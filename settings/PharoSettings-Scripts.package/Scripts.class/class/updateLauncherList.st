as yet unclassified
updateLauncherList
	"To execute in the Launcher image."
	| sources privateToken |

privateToken:= ''.

sources := {
    "Pharo Language Server"
    PhLTemplateSource new
        type: #HttpListing;
        name: 'Pharo Language Server';
        url: 'https://github.com/badetitou/Pharo-LanguageServer/releases';
        filterPattern: 'href="([^"]*/(Pharo|Moose)[0-9][^"]*.zip)"';
        templateNameFormat: '{6} ({5})'.
    
    "Moose"
    PhLTemplateSource new
        type: #HttpListing;
        name: 'Moose';
        url: 'https://github.com/moosetechnology/Moose/releases';
        filterPattern: 'href="([^"]*/(Pharo|Moose)[0-9][^"]*.zip)"';
        templateNameFormat: '{6} ({5})'.
        
    "BL"
    PhLTemplateSource new    
        type: PhLTemplateSource urlGroupType;
        name: 'BL';
        templates: { 
            PhLTemplateSource new
                type: PhLTemplateSource urlType;
                name: 'MooseBL';
                url: 'https://gitlab.forge.xxxxx.com/api/v4/projects/219/jobs/artifacts/master/download?job=Moose64-8.0&private_token=', privateToken;
                yourself 
            }
        }.
    PhLUserTemplateSources sourcesFile writeStreamDo: [ :s | 
        (STON writer on: s)
            newLine: String lf;
            prettyPrint: true;
            nextPut: sources ]