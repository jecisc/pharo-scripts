initialization
copyClassShouldCopyComment
	"Because the community does not want it, but I want it. http://forum.world.st/Bad-copied-class-comment-td5106493.html"
	<script>
	(Class >> #duplicateClassWithNewName:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altDuplicateClassWithNewName:;
				arguments: #(#arguments);
				control: #instead)