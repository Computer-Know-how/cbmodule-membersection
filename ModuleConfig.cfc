/**
* A Module that will help you generate forms for ContentBox, used in combination with the
* FormBuilder Widget it will allow you to create forms and display them on your ContentBox
* pages
*/
component {

	// Module Properties
	this.title 				= "Member Section";
	this.author 			= "Computer Know How, LLC";
	this.webURL 			= "http://www.compknowhow.com";
	this.description 		= "A cool member section for ContentBox";
	this.version			= "2.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "cbMemberSection";

	function configure(){

	}

	/**
	* Fired when the module is activated
	*/
	function onActivate(){
		var permissionService = controller.getWireBox().getInstance("PermissionService@cb");
		var roleService = controller.getWireBox().getInstance("RoleService@cb");
		var ruleService = controller.getWireBox().getInstance("securityRuleService@cb");
		var permissionExists = permissionService.findAllWhere({permission="MEMBER_ONLY"});
		if(!arrayLen(permissionExists)){
			var oPermission = permissionService.get(0);
			oPermission.setPermission("MEMBER_ONLY");
			oPermission.setDescription("Access to the member pages.");
			permissionService.save(oPermission);
			var oAdmin = roleService.findWhere({role="Administrator"});
			oAdmin.addPermission(oPermission);
			roleService.save(oAdmin);
		}
		var roleExists = roleService.findAllWhere({role="Member"});
		if(!arrayLen(roleExists)){
			var oRole = roleService.get(0);
			oRole.setRole("Member");
			oRole.setDescription("A site member");
			var permissions = permissionService.findAllWhere({permission="MEMBER_ONLY"});
			oRole.setPermissions(permissions);
			roleService.save(oRole);
		}
		var ruleData = {
			secureList = '^member',
			redirect = 'cbadmin/security/login',
			permissions = 'MEMBER_ONLY',
			order = 0,
			match = 'url',
			useSSL = false
		};
		var ruleExists = ruleService.findAllWhere({secureList="^member"});
		if(!arrayLen(ruleExists)){
			var oRule = ruleService.get(0);
			ruleService.populate(oRule,ruleData);
			ruleService.save(oRule);
		}
	}

}