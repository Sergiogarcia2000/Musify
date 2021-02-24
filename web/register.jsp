<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/styles.css">
    <link rel="icon" href="./img/icon.png">
    <title>MUSIFY - REGISTER</title>
</head>
<body class="alert-dark bg">
    <section class="container-fluid bg">
        <section class="row justify-content-center">
            <section class="col-12 col-sm-6 col-md-3">
                <form class="form-container" action="${pageContext.request.contextPath}/Register" method="POST">
                    <div class="form-group">
                        <label for="email_input">Email</label>
                        <input type="email" class="form-control" name="email_input" required>
                    </div>
                    <div class="form-group">
                        <label for="username_input">Nombre de usuario</label>
                        <input type="text" class="form-control" name="username_input" required>
                    </div>
                    <div class="form-group">
                        <label for="password_input">Contraseña</label>
                        <input type="password" class="form-control" name="password_input" required>
                        
                    </div>
                    <div class="form-group">
                        <label for="confirm_password_input">Confirmar contraseña</label>
                        <input type="password" class="form-control" name="confirm_password_input" required>
                    </div>
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" name="remember_checkbox" required>
                        <label class="form-check-label" for="remember_checkbox">Acepto los <a href="./terms.html">términos y condicciones</a>.</label>
                    </div>
                    <input class="btn btn-outline-dark btn-block" type="submit" value="Registrarse" name="register_button">
                    <a class="btn btn-outline-dark btn-block" href="./index.jsp" name="go_back">Iniciar sesión</a>
                </form>
            </section>
        </section>
    </section>
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    
</body>
</html>