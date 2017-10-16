/**
* base handler for the member section
*/
component{

	// dependencies
	property name="memberService"					inject="entityService:Member";

	// pre handler
	function preHandler(event,action,eventArguments){
		var rc 	= event.getCollection();
		var prc = event.getCollection(private=true);

		// get module root
		prc.moduleRoot = event.getModuleRoot( "contentbox-membersection" );

		// if data isn't setup, redirect user
		// if( !FormSubmissionService.isDataSetup() && event.getCurrentEvent() NEQ "contentbox-membersection:form.noDataSetup") {
		// 	setNextEvent("cbMemberSection.form.noDataSetup");
		// }

		// exit points
		prc.xehMembers = "cbMemberSection.member.index";
		prc.xehMemberEditor = "cbMemberSection.member.editor";
		//prc.xehMemberSettings = "cbMemberSection.settings.index";

		//check login and redirect is needed.
		if(!prc.oCurrentAuthor.isLoaded()){
			getInstance("messageBox@cbMessageBox").setMessage("warning","Please login!");
			setNextEvent(prc.xehLogin);
		}

		// use the CB admin layout
		event.setLayout(name="admin",module="contentbox-admin");

		// tab control
		prc.tabModules = true;
		prc.tabModules_cbMemberSection = true;
	}

}