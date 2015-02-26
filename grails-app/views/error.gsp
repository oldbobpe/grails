<!DOCTYPE html>
<html>
<head>
<title><g:if env="development">500 - Internal Server Error</g:if><g:else>Error</g:else></title>
<meta name="layout" content="main">
<g:if env="development">
	<asset:stylesheet src="errors.css" />
</g:if>
</head>
<body>
	<div role="main" class="main">

		<section class="page-top">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<ul class="breadcrumb">
							<li><a href="#">Home</a></li>
							<li class="active">Pages</li>
						</ul>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<h1>500 - Internal Server Error</h1>
					</div>
				</div>
			</div>
		</section>

		<div class="container">

			<section class="page-not-found">
				<div class="row">
					<div class="col-md-6 col-md-offset-1">
						<div class="page-not-found-main">
							<h2>
								500 <i class="fa fa-file"></i>
							</h2>
							<p>We're sorry, but something went wrong. Please try again!!!</p>
						</div>
					</div>
				</div>
			</section>

		</div>
	</div>
	<g:if env="development">
		<g:renderException exception="${exception}" />
	</g:if>
</body>
</html>
