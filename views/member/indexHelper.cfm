<cfoutput>
	<script type="text/javascript">
		$(document).ready(function() {
			// quick filter
			$("##formsFilter").keyup(function(){
				$.uiTableFilter( $("##forms"), this.value );
			});

			$("##forms").dataTable({
				"paging": false,
				"info": false,
				"searching": false,
				"columnDefs": [
				{
					"orderable": false,
					"targets": '{sorter:false}'
				}
				],
				"order": []
			});

		});

		function removeMember(memberID){
			$("##memberID").val( memberID );
			$("##membersForm").submit();
		}
	</script>
</cfoutput>