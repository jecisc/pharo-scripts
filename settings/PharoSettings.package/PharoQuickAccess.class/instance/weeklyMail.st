synectique
weeklyMail
	<name: #'Weekly mail'>
	| files mailMessage from to creds file text |
	from := 'cyril.ferlicot@synectique.eu'.
	to := 'team@synectique.eu'.
	(file := StartupPreferencesLoader preferencesGeneralFolder / 'SettingRessources' / 'CredsAmen') exists
		ifFalse: [ | cred |
			cred := Dictionary new.
			cred at: #amenPassword put: (UIManager default textEntry: 'Amen Password').
			file writeStreamDo: [ :s | s nextPutAll: (STON toStringPretty: cred) ] ].
	creds := STON fromString: file contents.

	files := ('/Users/cyril/Google Drive/Synectique/Rapports' asFileReference allFiles select: [ :f | f basename first isDigit ])
		sort: [ :a :b | a basenameWithoutExtension asDate > b basenameWithoutExtension asDate ].

	text := String
		streamContents: [ :stream | 
			stream
				<< 'Bonjour,';
				lf;
				lf;
				<< 'Voici mon rapport de la semaine : ';
				lf;
				lf;
				<< files first contents;
				lf;
				lf;
				<<
					'--
Cyril Ferlicot
https://ferlicot.fr

http://www.synectique.eu
2 rue Jacques Prévert 01,
59650 Villeneuve d''ascq France
' ].

	(UIManager default confirm: text label: 'Envoyer ?')
		ifTrue: [ mailMessage := MailMessage empty
				setField: 'subject' toString: (Date today printFormat: #(1 2 3 $- 1 1));
				body: (MIMEDocument contentType: 'text/plain' content: text);
				setField: 'from' toString: from;
				setField: 'to' toString: to;
				setField: 'bcc' toString: from;
				yourself.

			ZdcSecureSMTPClient new
				user: from;
				password: (creds at: #amenPassword);
				openOnHost: (NetNameResolver addressForName: 'smtp.synectique.eu') port: 465;
				mailFrom: from to: {to} text: mailMessage text;
				quit;
				close ]