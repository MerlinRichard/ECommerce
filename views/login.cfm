<!DOCTYPE html>
<html class="h-100">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,height=device-height, initial-scale=1"/>
    <title>Login</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />
    <link href="../css/main.css" rel="stylesheet"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="../js/signup.js"></script>
  </head>
  <body class="h-100">
    <cfinclude template = "../common/header.cfm" />
    <div class="container-fluid h-100">
      <div class="d-flex justify-content-center align-items-center h-100">
        <form class="mt-10 w-25 bgForm" name="loginForm" id="loginFormId" method="post">
          <h3 class="text-center mb-4">Login</h3>
          <div class="mb-3">
            <span class="error" id="loginerror"></span>
          </div>
          <div class="mb-3">
            <label for="email" class="form-label">Email address</label>
            <input
              type="email"
              class="form-control"
              name="email"
              id="emailid"
              placeholder="email"
            />
            <span class="error" id="emailerror"></span>
          </div>
          <div class="mb-3">
            <label for="password"  class="form-label" >Password</label>
            <input
              type="password"
              class="form-control"
              name="password"
              id="passwordid"
              placeholder="password"
            />
          </div>
          <span class="error" id="pswderror"></span>
          <button type="submit" class="btn btn-primary w-100 mt-2" id="loginBtn">
            Login
          </button>
          <p class="mt-2">
            Don't have an account?
            <a href="signup.cfm">Create a account</a>
          </p>
        </form>
      </div>
    </div>
     <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>
  </body>
</html>
 