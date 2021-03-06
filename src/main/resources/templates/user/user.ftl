<!DOCTYPE html>
<html lang="en">
	<head id="head">
		<title>Users</title>
		<#include "../stubs/header.ftl"/>
	</head>
	<body id="body">

		<#include "../stubs/default-navbar.ftl"/>

		<!-- content -->
		<div id="content" class="container">
			<!-- add/edit -->
			<div class="col-sm-4">
				<div class="panel panel-default">
					<div class="panel-heading">Add or Update User <span class="pull-right"><a href="/secure/user">Add New</a></span></div>
					<div class="panel-body">
						<form role="form" method="post" action="/secure/user">
							<div class="form-group row">
								<div class="col-xs-6">
									<input type="text" id="firstName" name="firstName" value="${(user.firstName)!}" class="form-control" placeholder="First" required="true" autofocus="true"/>
								</div>
								<div class="col-xs-6">
									<input type="text" id="lastName" name="lastName" value="${(user.lastName)!}" class="form-control" placeholder="First" required="true" autofocus="true"/>
								</div>
							</div>
							<div class="form-group">
								<input type="text" id="username" name="username" value="${(user.username)!}" class="form-control" placeholder="Username" required="true"/>
							</div>
							<div class="form-group">
								<input type="password" id="password" name="password" value="${(user.password)!}" class="form-control" placeholder="Password" required="true"/>
							</div>
							<input type="hidden" name="id" value="${(user.id)!}"/>
							<input type="hidden" name="creation" value="${(user.creation?c)!}"/>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<button class="btn btn-md btn-primary btn-block" type="submit">Save</button>
						</form>
					</div>
				</div>
			</div>
			<!-- add/edit -->
			<!-- view all -->
			<div class="col-sm-8">
				<div class="panel panel-default">
					<div class="panel-heading">Current Users</div>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>Name</th>
										<th>Username</th>
										<th>Role</th>
										<th>Enabled</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody>
									<#list users as user>
										<tr>
											<td>${(user.firstName)!} ${(user.lastName)!}</td>
											<td>${(user.username)!}</td>
											<td>${(user.role)?split('_')[1]?lower_case?cap_first!'N/A'}</td>
											<td>${(user.active == 1)?c}</td>
											<td>
												<a href="/secure/user/${(user.id)!}" class="btn btn-xs btn-primary">
													<i class="fa fa-pencil"></i>
												</a>
												<a href="#" class="btn btn-danger btn-xs" data-id="${(user.id)!}" data-toggle="modal" data-target="#deleteCheck">
													<i class="fa fa-trash-o"></i>
												</a>
											</td>
										</tr>
									</#list>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<!-- view all -->
		</div>

		<div class="modal fade" id="deleteCheck" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title">Are you sure?</h4>
					</div>
					<div class="modal-body">
						Permanently remove user? This action cannot be undone.
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-md pull-left" data-dismiss="modal">No, Cancel</button>
                        <span id="delete">
                            <form role="form" method="post" action="/secure/user/{id}">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<button type="submit" class="btn btn-primary btn-md">Yes, Remove User</button>
							</form>
                        </span>

					</div>
				</div>
			</div>
		</div>

		<!-- content -->

		<#include "../stubs/footer.ftl"/>

		<#include "../stubs/scripts.ftl"/>

		<script>
            $(document).ready(function() {

                // toggle safe delete modal popup
                $('a[data-toggle="modal"]').click(function(){
                    var id = $(this).data('id');
                    var form = $('.modal #delete');
                    form.html(form.html().replace('{id}',id));
                });
            });
        </script>

	</body>
</html>
