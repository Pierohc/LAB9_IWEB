package com.example.gestionacademica.Servlets;

import com.example.gestionacademica.Models.Beans.Curso;
import com.example.gestionacademica.Models.Beans.Usuario;
import com.example.gestionacademica.Models.Daos.CursoDao;
import com.example.gestionacademica.Models.Daos.CursoHasDocenteDao;
import com.example.gestionacademica.Models.Daos.FacultadHasDecanoDao;
import com.example.gestionacademica.Models.Daos.UserDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

@WebServlet(name = "decano", value = "/decano")
public class DecanoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession httpSession = request.getSession();
        Usuario usuario = (Usuario) httpSession.getAttribute("userLog");


        FacultadHasDecanoDao fhd = new FacultadHasDecanoDao();
        CursoDao cursoDao = new CursoDao();
        UserDao userDao = new UserDao();

        if(usuario != null && usuario.getIdRol() == 3){

            String action = request.getParameter("action") == null? "home" : request.getParameter("action");

            switch (action){
                case "home":
                    Integer idFacultad = fhd.obtenerIdFacultad(usuario.getIdUsuario());
                    System.out.println("el id de la facultad: " + idFacultad);
                    ArrayList<Curso> listaCursos = cursoDao.obtenerCursosFacultad(idFacultad);
                    System.out.println("tamaño de la lista de cursos: " + listaCursos.size());

                    request.setAttribute("listaCursos", listaCursos);
                    request.getRequestDispatcher("/decano/cursos.jsp").forward(request,response);
                    break;

                case "docentes":
                    ArrayList<Usuario> docentesSinCurso = userDao.listarDocentesSinCursos();
                    ArrayList<Usuario> docentesConCurso = userDao.listarDocentesConCursosPorFacultad(fhd.obtenerIdFacultad(usuario.getIdUsuario()));
                    ArrayList<Usuario> listaDocentes = new ArrayList<>();
                    listaDocentes.addAll(docentesSinCurso);
                    listaDocentes.addAll(docentesConCurso);

                    request.setAttribute("listaSinCurso", docentesSinCurso);
                    request.setAttribute("listaConCurso", docentesConCurso);
                    request.setAttribute("listaDocentes", listaDocentes);
                    request.getRequestDispatcher("/decano/lista_docentes.jsp").forward(request, response);
                    break;

                case "newDocente":

                    ArrayList<Usuario> listaTotalUsers = userDao.listarUsuarios();
                    request.setAttribute("listaTotal", listaTotalUsers);
                    request.getRequestDispatcher("/decano/new_docente.jsp").forward(request, response);
                    break;

                case "deleteDocente":
                    String id = request.getParameter("idDocente");
                    userDao.eliminarDocente(Integer.parseInt(id));
                    response.sendRedirect(request.getContextPath()+"/decano?action=docentes");
                    break;

                case "editDocente":
                    ArrayList<Usuario> listaTotalUsers2 = userDao.listarUsuarios();
                    String id2 = request.getParameter("idDocente");
                    Usuario userSearched = userDao.buscarUsuarioXid(Integer.parseInt(id2));

                    request.setAttribute("listaTotal", listaTotalUsers2);
                    request.setAttribute("usuario", userSearched);
                    request.getRequestDispatcher("/decano/edit_docente.jsp").forward(request, response);
                    break;

                case "newCurso":
                    ArrayList<Curso> cursos = cursoDao.listarTodosCursos();
                    ArrayList<Usuario> docentesSinCurso2 = userDao.listarDocentesSinCursos();

                    request.setAttribute("listaCursos", cursos);
                    request.setAttribute("docentesSinCurso", docentesSinCurso2);
                    request.getRequestDispatcher("/decano/new_curso.jsp").forward(request,response);
                    break;





            }


        }else{
            httpSession.invalidate();
            response.sendRedirect(request.getContextPath());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession httpSession = request.getSession();
        Usuario usuario = (Usuario) httpSession.getAttribute("userLog");

        FacultadHasDecanoDao fhd = new FacultadHasDecanoDao();
        CursoHasDocenteDao chd = new CursoHasDocenteDao();
        UserDao userDao = new UserDao();
        CursoDao cursoDao = new CursoDao();
        String action = request.getParameter("action") == null? "newd" : request.getParameter("action");

        switch (action){
            case "newd":
                String nombre = request.getParameter("nombre");
                String correo = request.getParameter("correo");
                String passwd = request.getParameter("passwd");
                ArrayList<Usuario> lista = userDao.listarUsuarios();
                Usuario lastUser = lista.get(lista.size() - 1);
                Integer id = lastUser.getIdUsuario() + 1;

                userDao.crearDocente(id, nombre, correo, passwd);
                response.sendRedirect(request.getContextPath()+"/decano?action=docentes");

                break;

            case "editd":
                String nombre2 = request.getParameter("nombre");
                String id2str = request.getParameter("idDocente");

                userDao.editDocente(nombre2, Integer.parseInt(id2str));
                response.sendRedirect(request.getContextPath()+"/decano?action=docentes");

                break;

            case "newCurso":
                String nombreCurso = request.getParameter("nombre");
                String codigo = request.getParameter("codigo");
                String docenteId = request.getParameter("idDocente");
                Integer idFacultad = fhd.obtenerIdFacultad(usuario.getIdUsuario());

                ArrayList<Curso> cursos = cursoDao.listarTodosCursos();
                Curso lastCurso = cursos.get(cursos.size() - 1);
                Integer idCurso = lastCurso.getIdCurso() + 1;


                System.out.println(nombreCurso);
                System.out.println(codigo);
                System.out.println(docenteId);
                System.out.println(idFacultad);
                System.out.println(idCurso);

                cursoDao.crearCurso(idCurso, codigo, nombreCurso, idFacultad);
                chd.crearCursoConDocente(idCurso, Integer.parseInt(docenteId));
                response.sendRedirect(request.getContextPath()+"/decano?action=home");

                break;




        }





    }
}
