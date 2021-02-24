<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/styles.css">
    <link rel="icon" href="./img/icon.png">
    <title>MUSIFY - LOGIN</title>
</head>
    <body class="alert-dark bg">

        <section class="container-fluid text-center">
            <section class="row">
                <section class="col-12 ">
                    <img src="./img/logo.png" class="">
                </section>
                <section class="col-12 d-flex justify-content-center ">
                        <form class="form-container" action="${pageContext.request.contextPath}/Player" method="POST">
                            <div class="form-group">
                                <label for="email_input">Email</label>
                                <input type="text" class="form-control" name="email_input">
                            </div>
                            <div class="form-group">
                                <label for="password_input">Contraseña</label>
                                <input type="password" class="form-control" name="password_input">
                            </div>
                            <div class="form-group">
                                <input class="btn btn-outline-dark btn-block" type="submit" value="Entrar" name="login_button">
                                <a class="btn btn-outline-dark btn-block" href="./register.jsp" name="register_button">Registrarse</a>
                            </div>
                        </form>
                </section>  
            </section>
        </section>
        
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    </body>
</html>