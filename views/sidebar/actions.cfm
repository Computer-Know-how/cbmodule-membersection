<cfoutput>
	<div class="panel panel-primary">
		<!--- Info Box --->
		<div class="panel-heading">
			<h3 class="panel-title">
				<i class="fa fa-cogs"></i> Actions
			</h3>
		</div>
		<div class="panel-body">
			<!--- xehForms --->
			<button class="btn btn-danger" style="margin-right: 5px" onclick="return to('#event.buildLink(prc.xehMembers)#')">Members</button>
			<button class="btn" onclick="return to('#event.buildLink('cbadmin.module.cbMemberSection.settings.index')#')" title="Set global form settings">Settings</button>
		</div>
	</div>
</cfoutput>