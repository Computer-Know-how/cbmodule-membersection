<cfoutput>
	#renderView( "viewlets/assets" )#
	<!--============================Main Column============================-->
	<div class="row">
		<div class="col-md-12">
			<h1 class="h1">
				<i class="fa fa-file-text-o"></i>
				<cfif prc.member.isLoaded()>Editing "#prc.member.getFirstName()# #prc.member.getLastName()#"<cfelse>Create Member</cfif>
			</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-md-9">
			<div class="panel panel-default">
				<div class="panel-body">
					#getInstance("MessageBox@cbmessagebox").renderit()#

					<div class="tabbable tabs-left">
						<ul class="nav nav-tabs">
							<li class="active"><a href="##memberDetails" data-toggle="tab"><i class="fa fa-list"></i> Member Details</a></li>
						</ul>

						<div class="tab-content">
							<div class="tab-pane active" id="memberDetails">
								<!--- Member Details --->
								#html.startForm(name="memberForm",action=prc.xehMembersave,novalidate="novalidate")#
									#html.startFieldset(legend="Member Details")#
										#html.hiddenField(name="memberID",bind=prc.member)#
										<!--- Fields --->
										<div class="form-group">
											#html.textField(name="firstName",bind=prc.member,label="*First Name:",required="required",class="form-control")#
										</div>

										<div class="form-group">
											#html.textField(name="lastName",bind=prc.member,label="*Last Name:",required="required",class="form-control")#
										</div>

										<div class="form-group">
											#html.textField(name="email",bind=prc.member,label="*Email Address:",required="required",class="form-control")#
										</div>
										<cfif !len(prc.member.getMemberID())>
											<div class="form-group">
												#html.textField(name="password",bind=prc.member,label="*Password:",required="required",class="form-control")#
											</div>
										</cfif>

										<div class="form-actions">
											<button class="btn" onclick="return to('#event.buildLink(prc.xehMembers)#')">Cancel</button>
											<input type="submit" value="Save" class="btn btn-danger">
										</div>
									#html.endFieldSet()#
								#html.endForm()#
							</div>
						</div>
					</div>
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