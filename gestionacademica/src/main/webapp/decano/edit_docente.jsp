<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.gestionacademica.Models.Beans.Curso" %>
<%@ page import="com.example.gestionacademica.Models.Beans.Usuario" %>
<%@ page import="com.sun.jdi.ArrayReference" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean scope="session" id="userLog" type="com.example.gestionacademica.Models.Beans.Usuario"   class="com.example.gestionacademica.Models.Beans.Usuario"></jsp:useBean>
<%  Usuario usuario = (Usuario) request.getAttribute("usuario");
    ArrayList<Usuario> listaTotal = (ArrayList<Usuario>) request.getAttribute("listaTotal");
    ArrayList<String> nombresEnUso = new ArrayList<>();
    for(Usuario u : listaTotal){
        nombresEnUso.add(u.getNombre());
    }
%>


<script>
    var usedNames = [
        <% for (String nombre : nombresEnUso) { %>
        '<%= nombre %>',
        <% } %>
    ]
</script>


<html>
<head>

    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/slide-bar.css">
    <link rel="stylesheet" href="css/boostrap/bootstrap.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/showError.js"></script>

    <title>Title</title>
</head>
<body style="background: #1a1d20">

<header>
    <div class="logo"></div>

    <div class="bars">
        <div class="line"></div>
        <div class="line"></div>
        <div class="line"></div>
    </div>

    <nav class="nav-bar">
        <ul>
            <li>
                <a href="<%=request.getContextPath()%>/decano?action=home" class="active">Cursos</a>
            </li>
            <li>
                <a href="<%=request.getContextPath()%>/decano?action=docentes">Docentes</a>
            </li>
            <li>
                <a href="<%=request.getContextPath()%>/login"><i class="fa-solid fa-door-open nav-icon2"></i>Cerrar Sesión</a>
            </li>
        </ul>
    </nav>
</header>


<div class="container-fluid" style="padding-left:0 !important; padding-right: 0 !important; background: rgb(45,0,83) !important;
background: radial-gradient(circle, rgba(45,0,83,1) 0%, rgba(35,3,80,1) 59%, rgba(21,0,48,1) 100%) !important;">
    <div class="text-secondary px-4 py-5 text-center">
        <div class="py-5">
            <h1 class="display-5 fw-bold text-white">Bienvenido, decano: <%=userLog.getNombre()%></h1>
            <div style="margin-bottom: 20px"></div>
            <h3 class="fw-bold text-white">Panel de Registro de docente</h3>
            <div style="margin-bottom: 20px"></div>
            <div class="justify-content-sm-center">
            </div>
        </div>
    </div>
</div>

<div style="padding-top: 40px;"></div>
<br>


<div class="container">

    <div class="row">
        <div class="col-lg-6 col-md-12" style="text-align: left; padding-top: 1.5em">
            <form id="form" method="post" action="<%=request.getContextPath()%>/decano?action=editd">
                <div class="card">
                    <div class="card-body" style="padding-left: 35px">

                        <div style="padding-top: 1.5em;"></div>
                        <div class="form-group" style="padding-right: 1rem">
                            <label style="text-align: left;">
                                <strong>Nombre:</strong></label>
                            <input type="text" class="form-control" name="nombre" id="nombre" value="<%=usuario.getNombre()%>" required>
                            <input type="hidden" class="form-control" name="idDocente"  value="<%=usuario.getIdUsuario()%>" >
                        </div>





                        <div style="padding-top: 1.5em;"></div>
                    </div>
                </div>
                <br>
                <div class="uk-flex uk-flex-center uk-margin-top">
                    <div class="uk-flex uk-flex-center">
                        <a id="redirect-button" class="btn btn-secondary m-2" href="<%=request.getContextPath()%>/decano?action=docentes">Cancelar</a>
                        <button type="submit" class="btn btn-primary m-2">Guardar</button>
                    </div>
                </div>

            </form>
        </div>


    </div>
</div>









<br><br><br>

<script>
    const nombre = document.getElementById("nombre")
    const form = document.getElementById("form")
    const nombreActual = '<%=usuario.getNombre()%>'
    form.addEventListener("submit", e=>{

        if(usedNames.includes(nombre.value)){

            if(nombre.value!=nombreActual){
                showError('El nombre ingresado ya está en uso')
                e.preventDefault()
            }else{

            }
        }else{

        }
    })
</script>


<script src="js/bootstrap/bootstrap.js"></script>
<script src="/js/bootstrap/bootstrap.esm.js"></script>
<script src="/js/bootstrap/bootstrap.bundle.js"></script>

</body>
</html>
