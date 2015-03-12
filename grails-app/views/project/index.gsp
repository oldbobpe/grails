

<%@ page import="com.retouch.Project" %>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'project.label', default: 'Project')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>

	<div role="main" class="main">

		<section class="page-top">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<ul class="breadcrumb">
							<li><a class="home" href="${createLink(uri: '/')}"><g:message
										code="default.home.label" /></a></li>
							<li><g:message code="default.list.label" args="[entityName]" /></li>
						</ul>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<h1>
							<g:message code="default.list.label" args="[entityName]" />
						</h1>
					</div>
				</div>
			</div>
		</section>

		<div class="container">
			<div class="alert alert-info">Change Text</div>

			<div class="panel-body">
				<div class="table-responsive">
					<g:if test="${flash.message}">
						<div class="message" role="status">${flash.message}</div>
					</g:if>
					<table
						class="table table-bordered table-striped table-condensed mb-none">
						<thead>
							<tr>

                                <g:sortableColumn property="projectId" title="${message(code: 'project.projectId.label', default: 'Project Id')}" />

					
						<g:sortableColumn property="note" title="${message(code: 'project.note.label', default: 'Note')}" />
					
						<th><g:message code="project.client.label" default="Client" /></th>

                                <th><g:message code="project.assignedTo.label" default="Assigned To" /></th>
					
						<g:sortableColumn property="createdDate" title="${message(code: 'project.createdDate.label', default: 'Created Date')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'project.lastUpdated.label', default: 'Last Updated')}" />
					
							</tr>
						</thead>
						<tbody>
							<g:each in="${projectInstanceList}" status="i"
								var="projectInstance">
								<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
									
									<td><g:link action="show" id="${projectInstance.id}">${fieldValue(bean: projectInstance, field: "projectId")}</g:link></td>
								
									<td>${fieldValue(bean: projectInstance, field: "note")}</td>
								
									<td>${fieldValue(bean: projectInstance, field: "client")}</td>
								
									<td>${fieldValue(bean: projectInstance, field: "assignedTo")}</td>
								
									<td><g:formatDate date="${projectInstance.createdDate}" /></td>
								
									<td><g:formatDate date="${projectInstance.lastUpdated}" /></td>
								

								</tr>
							</g:each>
						</tbody>
					</table>
					<ul class="pagination">
						<retouch:paginate total="${projectInstanceCount ?: 0}" />
					</ul>

				</div>
			</div>
			</section>
		</div>
	</div>
</body>
</html>
