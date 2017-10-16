/**
* I handle the member member events
*/
component extends="base" {

	function index(event,rc,prc){
		//exit points
		prc.xehMemberRemove = "cbMemberSection.member.remove";
		//current members
		prc.members = memberService.list(sortOrder="lastName ASC",asQuery=false);
		//member member view
		event.setView(view="member/index",module="contentbox-membersection");
	}


	// slugify remotely
	// function slugify(event,rc,prc){
	// 	event.renderData(data=getInstance("HTMLHelper@coldbox").slugify( rc.slug ),type="plain");
	// }


	// member editor
	function editor(event,rc,prc){
		// exit handlers
		prc.xehMembersave 		= "cbMemberSection.member.save";
		//prc.xehSlugify	  		= "cbMemberSection.member.slugify";

		// get new or persisted member
		prc.member  = memberService.get( event.getValue("memberID",0) );

		//repopulate member form failed save
		memberService.populate(prc.member,rc);

		// viewlets
		// prc.fieldsViewlet = "";
		// if( prc.form.isLoaded() ){
		// 	var args = {memberID=rc.memberID};
		// 	prc.fieldsViewlet = runEvent(event="contentbox-membersection:form.fields",eventArguments=args);
		// }

		// Editor
		//prc.tabForms_editor = true;

		// view
		event.setView("member/editor");
	}


	// save form
	function save(event,rc,prc){

		// get it and populate it
		var oMember = populateModel( memberService.get(id=rc.memberID) );

		// validate it
		var errors = oMember.validate();
		if( !arrayLen(errors) ){
			// save content
			memberService.save( oMember );
			// Message
			getInstance("messageBox@cbMessageBox").info("Member saved! Now you are happy!");
			setNextEvent(event='cbMemberSection.member.index',queryString="memberID=#oMember.getMemberID()#");
		}
		else{
			flash.persistRC(exclude="event");
			getInstance("messageBox@cbMessageBox").warn(messageArray=errors);
			setNextEvent(event=prc.xehMemberEditor,queryString="memberID=#oMember.getMemberID()#");
		}

	}


	function remove(event,rc,prc){
		var oMember	= memberService.get( rc.memberID );

		if( isNull(oMember) ){
			getInstance("messageBox@cbMessageBox").setMessage("warning","Invalid Member detected!");
			setNextEvent( prc.xehMembers );
		}
		// remove
		memberService.delete( oMember );
		// message
		getInstance("messageBox@cbMessageBox").setMessage("info","Member Removed!");
		// redirect
		setNextEvent(prc.xehMembers);
	}



	/**
	* noDataSetup
	*/
	any function noDataSetup(event,rc,prc){

		event.setView("member/noDataSetup");
	}

}