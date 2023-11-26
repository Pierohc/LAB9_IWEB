<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.gestionacademica.Models.Beans.Curso" %>
<%@ page import="com.example.gestionacademica.Models.Beans.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean scope="session" id="userLog" type="com.example.gestionacademica.Models.Beans.Usuario"   class="com.example.gestionacademica.Models.Beans.Usuario"></jsp:useBean>
<% ArrayList<Usuario> listaDocentes = (ArrayList<Usuario>) request.getAttribute("listaDocentes"); %>

<% ArrayList<Usuario> conCurso = (ArrayList<Usuario>) request.getAttribute("listaConCurso"); %>
<% ArrayList<Usuario> sinCurso = (ArrayList<Usuario>) request.getAttribute("listaSinCurso"); %>


<html>
<head>

    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/slide-bar.css">
    <link rel="stylesheet" href="css/boostrap/bootstrap.css">


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
                <a href="<%=request.getContextPath()%>/decano?action=home" >Cursos</a>
            </li>
            <li>
                <a href="<%=request.getContextPath()%>/decano?action=docentes" class="active">Docentes</a>
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
            <h3 class="fw-bold text-white">Panel de Lista de Docentes</h3>
            <div style="margin-bottom: 20px"></div>
            <div class="justify-content-sm-center">
            </div>
        </div>
    </div>
</div>


<br>


<div class="container">


    <div>
        <a class="btn btn-primary" style="margin-left: 2px;" href="<%=request.getContextPath()%>/decano?action=newDocente">Registrar Docente</a>
    </div>

    <br>

    <table  class="table table-dark table-hover">

        <thead>

        <tr>
            <th scope="col">Nombre</th>
            <th scope="col">Codigo</th>
            <th scope="col">Fecha de Registro</th>
            <th scope="col">Fecha de Edición</th>
            <th scope="col">Editar</th>
            <th scope="col">Borrar</th>
        </tr>
        </thead>

        <tbody class="table-group-divider">

        <%for (Usuario docente : conCurso){ %>
        <tr>
            <td><%=docente.getNombre()%></td>
            <td><%=docente.getCorreo()%></td>
            <td><%=docente.getFechaRegistro()%></td>
            <td><%=docente.getFechaEdicion()%></td>
            <td class="cell c5" ><a href="<%=request.getContextPath() %>/decano?action=editDocente&idDocente=<%=docente.getIdUsuario()%>"><img width="24" height="24" src="https://img.icons8.com/pastel-glyph/64/FFFFFF/create-new--v2.png" alt="edit-row"/></a></td>
            <td class="cell c6 "></td>
        </tr>
        <%}%>

        <%for (Usuario docente : sinCurso){ %>
        <tr>
            <td><%=docente.getNombre()%></td>
            <td><%=docente.getCorreo()%></td>
            <td><%=docente.getFechaRegistro()%></td>
            <td><%=docente.getFechaEdicion()%></td>
            <td class="cell c5" ><a href="<%=request.getContextPath() %>/decano?action=editDocente&idDocente=<%=docente.getIdUsuario()%>"><img width="24" height="24" src="https://img.icons8.com/pastel-glyph/64/FFFFFF/create-new--v2.png" alt="edit-row"/></a></td>
            <td class="cell c6">
                <a onclick="confirmarBorrado(event)" href="<%=request.getContextPath() %>/decano?action=deleteDocente&idDocente=<%=docente.getIdUsuario()%>">
                    <img width="24" height="24" src="https://img.icons8.com/material-outlined/24/FFFFFF/filled-trash.png" alt="filled-trash"/>
                </a>
            </td>
        </tr>
        <%}%>




        </tbody>

    </table>


</div>

<br><br><br>

<script>
    function confirmarBorrado(event) {
        if (!confirm('¿Estás seguro de que deseas borrar este docente?')) {
            event.preventDefault();
        }
    }
</script>

<script src="js/bootstrap/bootstrap.js"></script>
<script src="../js/bootstrap/bootstrap.min.js"></script>
</body>
</html>
