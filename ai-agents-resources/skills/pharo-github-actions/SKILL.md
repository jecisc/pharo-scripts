---
name: pharo-github-actions
description: Create or update GitHub Actions workflows for Pharo projects using smalltalkCI - the .pharo.ston file, test runs, a Pharo version matrix, saving image artefacts, continuous pre-releases on chosen branches, artefacts on GitHub releases and Coveralls coverage. Use when the user asks to set up, change or debug CI, GitHub Actions, workflows, .pharo.ston, smalltalkCI, artefacts, coverage or releases for a Pharo project.
---

# Pharo GitHub Actions

Pharo projects run their tests with smalltalkCI (`hpi-swa/setup-smalltalkCI`). The workflows live in `.github/workflows/`. Read the existing workflow files of the repository before editing them and keep their style.

## Options: all optional, the user chooses

Only the test run (sections 1 and 2) is the base. Ask the user which of the other options they want before writing anything, and do not add an option they did not choose:

- Matrix over Pharo versions (section 3)
- Image artefacts, saved on every run (section 4)
- Continuous pre-release on chosen branches (section 5)
- Artefacts on GitHub releases (section 6)
- Coveralls coverage (section 7)

Separate files instead of `if` conditions: the user may prefer one workflow file per purpose, for example `continuous.yml` for pushes to the chosen branches, `release.yml` for releases and `ci.yml` for tests and artefacts. Each file then has no `if` on the job, which is easier to read. Ask which layout the user wants. Both layouts are valid.

## 1. The `.pharo.ston` file

smalltalkCI reads a STON file, passed as the last argument of `smalltalkci`. The name `.pharo.ston` is the convention for new projects; smalltalkCI takes the path as an argument, so any name works if the workflow passes it. Keep the name the project already uses.

Minimal version: loads the baseline and runs the tests of the loaded packages. Nothing else is needed.

```
SmalltalkCISpec {
  #loading : [
    SCIMetacelloLoadSpec {
      #baseline : 'SpecToplo',
      #directory : 'src'
    }
  ]
}
```

- `#baseline` is the name without the `BaselineOf` prefix; `#directory` is where the baseline lives.
- `#platforms : [ #pharo ]` is not needed.
- Without a `#testing` section, smalltalkCI runs the tests of the loaded packages. Add `#testing` only when the tests of other packages must run, for example:

```
SmalltalkCISpec {
  #loading : [
    SCIMetacelloLoadSpec {
      #baseline : 'SpecToplo',
      #directory : 'src'
    }
  ],
  #testing : {
    #include : {
      #packages : [ 'Spec-Toplo-Extra.*' ]
    }
  }
}
```

- `#packages` is a regex list of the packages whose tests run.
- `#testing` is also where coverage is configured (section 7), so a project with coverage needs it.
- Several STON files are allowed when some tests must be excluded from a job (for example `.SpecBackendTests.ston` in the Spec-Toplo project, used by `full-tests.yml`). Give each file a clear name and say in a comment which tests it runs.

## 2. Run the tests (single job)

```yaml
name: CI
on: [ push, pull_request, workflow_dispatch ]
jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v7
      - name: Setup smalltalkCI
        uses: hpi-swa/setup-smalltalkCI@v1
        with:
          smalltalk-image: Pharo64-14
      - name: Load in New Image and Run Tests
        run: smalltalkci -s Pharo64-14 .pharo.ston
        shell: bash
        timeout-minutes: 15
```

`timeout-minutes: 15` is the value used in the Spec-Toplo project; the image download is the slow part. The FAST-Python project uses 30.

## 3. Matrix over Pharo versions (optional)

Use the image name in the matrix and reuse it in the steps. `fail-fast: false` keeps the other versions running when one fails.

```yaml
jobs:
  build:
    strategy:
      fail-fast: false
      matrix:
        smalltalk: [ Pharo64-14, Pharo64-15 ]
        os: [ macos-latest ]
    runs-on: ${{ matrix.os }}
    name: ${{ matrix.smalltalk }} on ${{ matrix.os }}
    steps:
      # same steps as above, with ${{ matrix.smalltalk }}
```

## 4. Save the image as an artefact, even when tests fail (optional)

Goal: the built image is downloadable from the run to debug locally. Rules learned on the Spec-Toplo project:

- Every packaging and upload step needs `if: always()`, otherwise a failing test step skips them. In a separate workflow file, where no test step is before them, the `if` is not needed.
- Use the paths smalltalkCI exports: `$SMALLTALK_CI_IMAGE`, `$SMALLTALK_CI_CHANGES`, `$SMALLTALK_CI_BUILD`, `$SMALLTALK_CI_CACHE`. Do not search with `find` for `*.image`: the first match can be a cached base Pharo image without the project.
- Compute the version from the matrix value: `Pharo64-14` gives `Spec-Toplo-Pharo14` (name) and `140` (content of `pharo.version`). Use the project's own name instead of `Spec-Toplo`.
- Upload the **directory**, not a zip. GitHub wraps every artefact in its own zip, so a zip inside a zip is hard to use.

```yaml
      - name: Compute the Pharo version
        id: version
        env:
          SMALLTALK_IMAGE: ${{ matrix.smalltalk }}
        run: |
          echo "pharo-version=Pharo${SMALLTALK_IMAGE##*-}" >> "$GITHUB_OUTPUT"
          echo "pharo-number=${SMALLTALK_IMAGE##*-}0" >> "$GITHUB_OUTPUT"
      - name: Package image, changes, sources and version
        if: always()
        env:
          PHARO_VERSION: ${{ steps.version.outputs.pharo-version }}
          PHARO_NUMBER: ${{ steps.version.outputs.pharo-number }}
        run: |
          set -euo pipefail
          package_directory="$RUNNER_TEMP/Spec-Toplo-$PHARO_VERSION"
          mkdir -p "$package_directory"
          cp "$SMALLTALK_CI_IMAGE" "$package_directory/Spec-Toplo-$PHARO_VERSION.image"
          cp "$SMALLTALK_CI_CHANGES" "$package_directory/Spec-Toplo-$PHARO_VERSION.changes"
          cp "$(find "$SMALLTALK_CI_BUILD" "$SMALLTALK_CI_CACHE" -name '*.sources' | head -n 1)" "$package_directory/"
          printf '%s' "$PHARO_NUMBER" > "$package_directory/pharo.version"
      - uses: actions/upload-artifact@v4
        if: always()
        with:
          name: Spec-Toplo-${{ steps.version.outputs.pharo-version }}
          path: ${{ runner.temp }}/Spec-Toplo-${{ steps.version.outputs.pharo-version }}
```

Caveat: the `.sources` file keeps Pharo's own name on purpose, because Pharo may look it up by that name. Not yet verified that a renamed image opens correctly; check on the first artefact.

## 5. Continuous pre-release on pushed branches (optional)

Publish a `continuous-<branch>` GitHub pre-release with the new build on each push. Never hardcode a branch name in the job logic: the branches are the user's choice, and each branch gets its own pre-release. Ask which branches before writing the trigger. Typical choice: `dev` only.

- The branches are set in the trigger. Omit the `branches` filter to build every branch, which creates one pre-release per branch, so warn the user about that.
- `needs: build` plus `if: ${{ !cancelled() && github.event_name == 'push' }}` so the release runs even when tests fail, but not when the run is cancelled. In a separate file, the `needs` and the `!cancelled()` part can be simplified.
- The tag and title use `$GITHUB_REF_NAME`, so each branch replaces only its own pre-release.
- The job needs `actions/checkout`. Without a git repository, `gh release delete --cleanup-tag` fails with "not a git repository", and the release is not replaced.
- Download the artefacts without `merge-multiple` (each version lands in its own folder), zip each folder, then publish.
- `concurrency` per branch with `cancel-in-progress`, so only one continuous release runs at a time for each branch.

```yaml
on:
  push:
    branches: [ dev ]   # the user's chosen branches; omit to build every branch
  pull_request:
  workflow_dispatch:

concurrency:
  group: ${{ github.event_name == 'push' && format('continuous-{0}', github.ref_name) || github.run_id }}
  cancel-in-progress: ${{ github.event_name == 'push' }}
```

```yaml
  continuous-release:
    needs: build
    if: ${{ !cancelled() && github.event_name == 'push' }}
    runs-on: ubuntu-latest
    permissions:
      contents: write
    env:
      GH_TOKEN: ${{ github.token }}
    steps:
      - uses: actions/checkout@v7
      - uses: actions/download-artifact@v4
        with:
          pattern: Spec-Toplo-Pharo*
          path: dist
      - name: Zip each Pharo version
        run: |
          for directory in dist/Spec-Toplo-Pharo*/; do
            name="$(basename "$directory")"
            (cd "$directory" && zip -r "../$name.zip" .)
          done
      - name: Replace the continuous pre-release
        run: |
          tag="continuous-$GITHUB_REF_NAME"
          gh release delete "$tag" --cleanup-tag --yes || true
          gh release create "$tag" dist/*.zip \
            --target "$GITHUB_SHA" \
            --prerelease \
            --title "Continuous build ($GITHUB_REF_NAME)" \
            --notes "Built from commit $GITHUB_SHA on $GITHUB_REF_NAME. Check the CI run for the test results."
```

Open point: `|| true` on the delete also hides real delete failures.

## 6. Artefacts on GitHub releases (optional)

Same download and zip steps as the continuous release, then upload to the release that triggered the run.

```yaml
  release:
    needs: build
    if: github.event_name == 'release'
    runs-on: ubuntu-latest
    permissions:
      contents: write
    env:
      GH_TOKEN: ${{ github.token }}
    steps:
      - uses: actions/checkout@v7
      - uses: actions/download-artifact@v4
        with:
          pattern: Spec-Toplo-Pharo*
          path: dist
      - name: Zip each Pharo version
        run: |
          for directory in dist/Spec-Toplo-Pharo*/; do
            name="$(basename "$directory")"
            (cd "$directory" && zip -r "../$name.zip" .)
          done
      - name: Upload the artifacts to the release
        run: gh release upload "${{ github.event.release.tag_name }}" dist/*.zip --clobber
```

The trigger is `release: types: [created, edited]`. The Spec-Toplo job needs a successful build, so failing builds are not attached to official releases. That is a choice; the user may prefer otherwise.

## 7. Coveralls (optional)

Pattern used by moosetechnology/FAST-Python (working on GitHub).

- Coverage is requested in the `.pharo.ston` file, inside `#testing`. `#format : #lcov` makes smalltalkCI write `coverage/lcov.info`:

```
  #testing : {
    #coverage : {
      #packages : [ 'FAST-Python-Model', 'FAST-Python-Model-Generator', 'FAST-Python-Tools' ],
      #format : #lcov
    }
  }
```

- Each matrix job runs smalltalkCI, then uploads its part with `parallel: true` and a flag per Pharo version. A separate `finish` job sends `parallel-finished: true` once all matrix jobs are done.
- No Coveralls token is needed: `secrets.GITHUB_TOKEN` is enough.

```yaml
  build:
    strategy:
      matrix:
        smalltalk: [ Pharo64-13, Pharo64-14 ]
    steps:
      # checkout, setup-smalltalkCI and smalltalkci as in section 2
      - name: Coveralls GitHub Action
        uses: coverallsapp/github-action@v2
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          flag-name: ${{ matrix.smalltalk }}
          parallel: true

  finish:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Coveralls Finished
        uses: coverallsapp/github-action@v2
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          parallel-finished: true
```

Notes:
- The FAST-Python matrix runs on `ubuntu-latest`. In its log, the Coveralls action picked the Unix reporter and uploaded successfully. Check the reporter steps before using it on another runner.
- `coveralls` expects the lcov file at `./coverage/lcov.info`, the default location of smalltalkCI. Keep that default unless there is a reason to change it.
- Keep coverage separate from the artefact job.

## Checks before finishing

- Ask the user which options of the list at the top they want, and write only those.
- Validate each YAML file (for example `ruby -ryaml -e 'YAML.load_file(ARGV[0])' file.yml`).
- Check that every packaging and upload step has `if: always()` when it must run after failing tests.
- Do not put tokens in the workflow; use `secrets.*` or `github.token`.