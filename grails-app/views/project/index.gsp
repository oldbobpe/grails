<%--
  Created by IntelliJ IDEA.
  User: Aasiz
  Date: 2/26/2015
  Time: 2:06 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div role="main" class="main">

    <section class="page-top">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <ul class="breadcrumb">
                        <li><a href="#">Home</a></li>
                        <li class="active">Projects</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <div class="container">

        <div class="row  show-grid">
            <div class="col-md-12">
                <div id="list-project" class="content scaffold-list" role="main">
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>

                    <table class="table table-striped mb-none  table-bordered">
                        <thead>
                        <tr>
                            <g:sortableColumn property="projectId"
                                              title="${message(code: 'project.projectId.label', default: 'Project Id')}"/>
                            <th><g:message code="project.status.label" default="Status"/></th>
                            <th><g:message code="project.createdDate.label" default="Date Created"/></th>

                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${projectInstanceList}" status="i" var="projectInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>
                                    <a href="${createLink(uri: '/project/show')}/${projectInstance.id}"> ${fieldValue(bean: projectInstance, field: "projectId")}</a>
                                </td>
                                <td>${fieldValue(bean: projectInstance, field: "status")}</td>
                                <td>${fieldValue(bean: projectInstance, field: "createdDate")}</td>

                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                    <ul class="pagination">
                        <retouch:paginate total="${projectInstanceCount ?: 0}"/>
                    </ul>
                </div>
            </div>
        </div>
        <hr class="tall">
    </div>
</div>

</body>
</html>


