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
    <g:set var="entityName" value="${message(code: 'project.label', default: 'My Task')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
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
            <div class="row">
                <div class="col-md-12">
                    <h1><g:message code="default.list.label" args="[entityName]" /></h1>
                </div>
            </div>
        </div>
    </section>

    <div class="container">

        <div class="row  show-grid">
            <div class="col-md-12">
                <div id="list-project" class="content scaffold-list" role="main">

                    <table class="table table-striped mb-none  table-bordered">
                        <thead>
                        <tr>
                            <th>Original File</th>
                            <g:sortableColumn property="projectId" title="${message(code: 'project.projectId.label', default: 'Project Id')}" />

                  %{--          <th><g:message code="project.originalImage.label" default="Original Image" /></th>--}%
                            <th><g:message code="project.status.label" default="Status" /></th>
                            <th><g:message code="project.createdDate.label" default="Date Created" /></th>
                            <th><g:message code="project.lastUpdated.label" default="Last Updated" /></th>

                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${projectInstanceList}" status="i" var="projectInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
<td>
    %{--<div class="thumbnail">--}%
                    <img id="uploadedImage" class="img-rounded img-responsive" style="width: 40px;" src="${grailsApplication.config.retouch.imageServer}${projectInstance?.task?.originalImage?.getThumbnailImageName()}">
    %{--</div>--}%
</td>
                                <td><g:link action="show" id="${projectInstance.id}">${fieldValue(bean: projectInstance, field: "projectId")}</g:link></td>
                              %{--  <td>${fieldValue(bean: projectInstance, field: "originalImage")}</td>--}%
                                <td>${fieldValue(bean: projectInstance, field: "status")}</td>
                                <td>${fieldValue(bean: projectInstance, field: "createdDate")}</td>
                                <td>${fieldValue(bean: projectInstance, field: "lastUpdated")}</td>

  %{--                              <td>${fieldValue(bean: projectInstance, field: "finalImage")}</td>--}%

                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                    <ul class="pagination">
                        <retouch:paginate total="${projectInstanceCount ?: 0}" />
                    </ul>
                </div>
            </div>
        </div>
        <hr class="tall">
   </div>








</div>

</body>
</html>


