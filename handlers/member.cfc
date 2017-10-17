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


	// member editor
	function editor(event,rc,prc){
		// exit handlers
		prc.xehMembersave 		= "cbMemberSection.member.save";

		// get new or persisted member
		prc.member  = memberService.get( event.getValue("memberID",0) );

		//repopulate member form failed save
		memberService.populate(prc.member,rc);

		// view
		event.setView("member/editor");
	}


	// save form
	function save(event,rc,prc){

		// get it and populate it
		var oMember = populateModel( memberService.get(id=rc.memberID) );
		if(!oMember.isLoaded()){
			oMember.updatePassword();
		}
		// validate it
		var errors = oMember.validate();
		// create criteria for uniqueness
		var c = memberService.newCriteria()
			.isEq( "email", rc.email );

		// Existing user, don't include it in the check
		if( oMember.isLoaded() ) {
			c.ne( "memberID", javacast("int",rc.memberID) );
		}
		if(c.count() GT 0){
			arrayAppend(errors,'Email must be unique.');
		}
		if( !arrayLen(errors) && c.count() EQ 0 ){
			// save content
			memberService.save(oMember);
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