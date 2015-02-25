<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="main" />
<title>Welcome to 1hRetouch !!!</title>
</head>
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
					<h1>Login</h1>
				</div>
			</div>
		</div>
	</section>

	<div class="container">

		<div class="row">
			<div class="col-md-12">

				<div class="row featured-boxes login">
					<div class="col-sm-6">

						<h2 class="more-spaced">Welcome Back</h2>

						<blockquote>
							We work with latest tools from tablets to the latest Imacs so we
							can work extremely efficient and our web-site is organized in the
							same way. This way retouchers are foucs on the image only and
							save time. For this reason we have kept the price as low as
							50cent per technique. The average technique will be about 3-5
							minutes work for a professional retoucher. <small>1hrtouch.com</small>
						</blockquote>
					</div>
					<div class="col-sm-6">
						<div
							class="featured-box featured-box-secundary default info-content">
							<div class="box-content">
								<h4>Sing In</h4>
								<form action="${postUrl}" id="loginForm" method="post"
									name="loginForm" autocomplete='off'>
									<div class="row">
										<div class="form-group">
											<div class="col-md-12">
												<label>Username or E-mail Address</label> <input
													name="j_username" id="username"
													class="form-control input-lg">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="form-group">
											<div class="col-md-12">
												<a class="pull-right" href="#">(Lost Password?)</a> <label>Password</label>
												<input type="password" name="j_password" id="password"
													class="form-control input-lg">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<span class="remember-box checkbox"> <label
												for="rememberme"> <input type="checkbox"
													name="${rememberMeParameter}" id="remember_me"
													name="rememberme">Remember Me
											</label>
											</span>
										</div>
										<div class="col-md-6">
											<input type="submit" value="Login"
												class="btn btn-primary pull-right push-bottom"
												data-loading-text="Loading...">
										</div>

									</div>

									<div class="row">
										<div class="form-group">
											<div class="col-md-12">
												<p class="sign-up-info">
													Don't have an account yet?
													<g:link controller="register">Sign
													Up</g:link>
												</p>
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>

				</div>

			</div>
		</div>
	</div>
</div>
</html>