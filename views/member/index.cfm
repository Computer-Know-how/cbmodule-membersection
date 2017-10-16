<cfoutput>
	#renderView( "viewlets/assets" )#
	<!--============================Main Column============================-->
	<div class="row">
		<div class="col-md-12">
			<h1 class="h1">
				<i class="fa fa-list"></i> Members
			</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-md-9">
			<div class="panel panel-default">
				<div class="panel-body">
					#getInstance("MessageBox@cbmessagebox").renderit()#

					#html.startForm(name="membersForm",action=prc.xehMemberRemove)#
					#html.hiddenField(name="memberID",value="")#

					<!--- Filter Bar --->
					<div class="well well-sm">
						<div class="btn-group btn-sm pull-right">
							<button class="btn btn-sm btn-primary" onclick="return to('#event.buildLink(prc.xehMemberEditor)#')" title="Create new form">Add Member</button>
						</div>

						<div class="form-group form-inline no-margin">
							<input type="text" name="membersFilter" size="30" class="form-control" placeholder="Quick Filter" id="membersFilter">
						</div>
					</div>

					<!--- members --->
					<table name="members" id="members" class="tablesorter table table-striped" width="98%">
						<thead>
							<tr>
								<th>Name</th>
								<th>Username</th>
								<th>Email</th>
								<th>Created Date</th>
								<th width="90" class="center {sorter:false}">Actions</th>
							</tr>
						</thead>
						<tbody>
							<!--- Loop over members --->
							<cfloop array="#prc.members#" index="member">
								<tr>
									<td>
										<a href="#event.buildLink(prc.xehMemberEditor)#/memberID/#member.getMemberID()#"
										title="Edit #member.getFirstName()# #member.getLastName()#">#member.getFirstName()# #member.getLastName()#</a>
									</td>
									<td>#member.getUsername()#</td>
									<td>#member.getEmail()#</td>
									<td>#dateFormat(member.getCreatedDate(),"short")# #timeFormat(member.getCreatedDate(),"short")#</td>
									<td class="center">
										<!--- Edit Command --->
										<a class="btn btn-info btn-sm" href="#event.buildLink(prc.xehMemberEditor)#/memberID/#member.getMemberID()#"
										title="Edit #member.getFirstName()# #member.getLastName()#"><i class="fa fa-pencil"></i></a>
										<!--- Delete Command --->
										<!--- removeForm --->
										<a class="btn btn-danger btn-sm confirmIt" title="Delete Member" href="javascript:removeMember('#member.getMemberID()#')" data-title="Delete Member?"><i id="delete_#member.getMemberID()#" class="fa fa-trash"></i></a>
									</td>
								</tr>
							</cfloop>
						</tbody>
					</table>
					#html.endForm()#

				</div>
			</div>
		</div>

		<!--============================ Sidebar ============================-->
		<div class="col-md-3">
			<cfinclude template="../sidebar/actions.cfm" >
			<cfinclude template="../sidebar/help.cfm" >
			<cfinclude template="../sidebar/about.cfm" >
		</div>
	</div>
</cfoutput>