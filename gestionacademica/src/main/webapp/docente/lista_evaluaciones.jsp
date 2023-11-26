<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.gestionacademica.Models.Beans.Curso" %>
<%@ page import="com.example.gestionacademica.Models.Beans.Evaluaciones" %>
<%@ page import="com.example.gestionacademica.Models.Beans.Semestre" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean scope="session" id="userLog" type="com.example.gestionacademica.Models.Beans.Usuario"   class="com.example.gestionacademica.Models.Beans.Usuario"></jsp:useBean>
<%  ArrayList<Evaluaciones> listaEvaluaciones = (ArrayList<Evaluaciones>) request.getAttribute("listaEvaluaciones");
    Semestre semestreHabilitado = (Semestre) request.getAttribute("semestreHabilitado");
    ArrayList<Semestre> listaSemestres = (ArrayList<Semestre>) request.getAttribute("listaSemestres");
    Semestre semestreSeleccionado = (Semestre) request.getAttribute("semestreSeleccionado");

%>


<html>
<head>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/slide-bar.css">
    <link rel="stylesheet" href="css/boostrap/bootstrap.css">

   <title>Lista de Evaluaciones</title>
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
                <a href="<%=request.getContextPath()%>/docente?action=home" class="active">Evaluaciones</a>
            </li>

            <li>
                <a href="<%=request.getContextPath()%>/login"><i class="fa-solid fa-door-open nav-icon2"></i>Cerrar Sesión</a>
            </li>
        </ul>
    </nav>
</header>


<div class="container-fluid" style="padding-left:0 !important; padding-right: 0 !important; background: rgb(45,0,83) !important;
background: radial-gradient(circle, rgba(45,0,83,1) 0%, rgba(35,3,80,1) 59%, rgba(21,0,48,1) 100%) !important;">
    <div class="text-secondary px-4 py-8 text-center">
        <div class="py-5">
            <h1 class="display-5 fw-bold text-white">Bienvenido, Docente: <%=userLog.getNombre()%></h1>
            <div style="margin-bottom: 20px"></div>


            <%   if (semestreSeleccionado == null){%>
            <h3 class="fw-bold text-white">Panel de Lista de Evaluaciones de Todos los Semestres</h3>
            <%}else{%>
            <h3 class="fw-bold text-white">Panel de Lista de Evaluaciones del Semestre: </h3>
            <br>
            <h3 class="fw-bold text-white"><%=semestreSeleccionado.getNombre()%></h3>
            <% }%>

            <div class="justify-content-sm-center">
            </div>
        </div>
    </div>
</div>


<br>
<div class="container">


    <div class="row">


        <div class="col-md-8">
            <div>
                <a class="btn btn-primary" style="margin-left: 2px;" href="<%=request.getContextPath()%>/docente?action=newEv">Registrar Evaluación</a>
            </div>
        </div>


        <div class="col-md-4">
            <div class="btn-group" style="margin-left:80px">
                <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">Filtrar por Semestre</button>

                <ul class="dropdown-menu dropdown-menu-dark">


                    <% for(Semestre semestre : listaSemestres){ %>
                    <li>
                        <a class="dropdown-item" href="<%=request.getContextPath()%>/docente?action=home&id=<%=semestre.getIdSemestre()%>">
                            <%=semestre.getNombre()%>
                        </a>
                    </li>
                    <% } %>
                    <li>
                        <a class="dropdown-item" href="<%=request.getContextPath()%>/docente?action=home">
                            Todos
                        </a>
                    </li>




                </ul>
            </div>






        <a class="btn btn-primary" href="<%=request.getContextPath()%>/docente?action=home" role="button">Borrar filtros</a>

        </div>



    </div>

    <br>

    <table  class="table table-dark table-hover">

        <thead>

        <tr>
            <th scope="col">Estudiante</th>
            <th scope="col">Codigo Estudiante</th>
            <th scope="col">Correo Estudiante</th>
            <th scope="col">Nota</th>
            <th scope="col">Fecha Registro</th>
            <th scope="col">Fecha Edición</th>
            <th scope="col">Editar</th>
            <th scope="col">Borrar</th>
        </tr>
        </thead>

        <tbody class="table-group-divider">

        <%if (listaEvaluaciones.size() != 0){ %>

            <%for (Evaluaciones evaluacion : listaEvaluaciones){ %>
            <tr>
                <td><%=evaluacion.getNombreEstudiante()%></td>
                <td><%=evaluacion.getCodigoEstudiante()%></td>
                <td><%=evaluacion.getCorreoEstudiante()%></td>
                <td><%=evaluacion.getNota()%></td>
                <td><%=evaluacion.getFechaRegistro()%></td>
                <td><%=evaluacion.getFechaEdicion()%></td>
                <td class="cell c5" ><a href="<%=request.getContextPath()%>/docente?action=editEv&id=<%=evaluacion.getIdevaluacion()%>"><img width="24" height="24" src="https://img.icons8.com/pastel-glyph/64/FFFFFF/create-new--v2.png" alt="edit-row"/></a></td>

                <% if (evaluacion.getIdSemestre() == semestreHabilitado.getIdSemestre()){ %>
                <td class="cell c6 "><a onclick="confirmarBorrado(event)" href="<%=request.getContextPath()%>/docente?action=deleteEv&id=<%=evaluacion.getIdevaluacion()%>"><img width="24" height="24" src="https://img.icons8.com/material-outlined/24/FFFFFF/filled-trash.png" alt="filled-trash"/></a></td>
                <% }else{ %>
                <td class="cell c6 "></td>
                <%}%>

            </tr>
            <%}%>

        <%}%>

        </tbody>

    </table>

    <br>
</div>



<%if (listaEvaluaciones.size() == 0){ %>

    <br>
    <h1 style="font-size: 30px; color:white; text-align: center">Usted no tiene evaluaciones registradas en este semestre</h1>
    <br>
    <br>

<%}%>


<br><br><br>




<script>
    function confirmarBorrado(event) {
        if (!confirm('¿Estás seguro de que deseas borrar esta evaluación?')) {
            event.preventDefault();
        }
    }
</script>

<script src="js/bootstrap/bootstrap.js"></script>
<script src="/js/bootstrap/bootstrap.esm.js"></script>
<script src="/js/bootstrap/bootstrap.bundle.js"></script>



</body>
</html>
