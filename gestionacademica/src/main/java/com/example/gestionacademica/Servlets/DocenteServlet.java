package com.example.gestionacademica.Servlets;

import com.example.gestionacademica.Models.Beans.Evaluaciones;
import com.example.gestionacademica.Models.Beans.Semestre;
import com.example.gestionacademica.Models.Beans.Usuario;
import com.example.gestionacademica.Models.Daos.CursoHasDocenteDao;
import com.example.gestionacademica.Models.Daos.EvaluacionesDao;
import com.example.gestionacademica.Models.Daos.SemestreDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "docente", value = "/docente")
public class DocenteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         HttpSession httpSession = request.getSession();
         Usuario usuario = (Usuario) httpSession.getAttribute("userLog");

        CursoHasDocenteDao chd = new CursoHasDocenteDao();
        EvaluacionesDao evDao = new EvaluacionesDao();
        SemestreDao semestreDao = new SemestreDao();

         if(usuario != null && usuario.getIdRol() == 4){
            String action = request.getParameter("action") == null? "home" : request.getParameter("action");

            switch (action){

                case "home":

                    Integer idCurso = chd.obtenerIdCursoXidDocente(usuario.getIdUsuario());
                    ArrayList<Evaluaciones> listaCursosPorDocente = evDao.listarEvaluacionesDeDocente(idCurso);
                    Semestre semestreHabilitado = semestreDao.semestreHabilitado();

                    request.setAttribute("semestreHabilitado", semestreHabilitado);
                    request.setAttribute("listaEvaluaciones", listaCursosPorDocente);
                    request.getRequestDispatcher("/docente/lista_evaluaciones.jsp").forward(request,response);
                    break;

                case "newEv":
                    request.getRequestDispatcher("/docente/new_ev.jsp").forward(request, response);
                    break;

                case "editEv":
                    String idEv = request.getParameter("id");
                    Evaluaciones editEv = evDao.buscarEvxId(Integer.parseInt(idEv));
                    request.setAttribute("evaluacion", editEv);
                    request.getRequestDispatcher("/docente/edit_ev.jsp").forward(request,response);
                    break;

                case "deleteEv":
                    String idEvDelete = request.getParameter("id");
                    evDao.deleteEvaluacion(Integer.parseInt(idEvDelete));
                    response.sendRedirect(request.getContextPath() + "/docente?action=home");
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

        SemestreDao semestreDao = new SemestreDao();
        CursoHasDocenteDao chd = new CursoHasDocenteDao();
        EvaluacionesDao evDao = new EvaluacionesDao();

        String action = request.getParameter("action") == null? "newEv" : request.getParameter("action");

        switch (action){
            case "newEv":
                String nombre = request.getParameter("nombre");
                String codigo = request.getParameter("codigo");
                String correo = request.getParameter("correo");
                String nota = request.getParameter("nota");
                Semestre semestreHabilitado = semestreDao.semestreHabilitado();
                Integer idSemestre = semestreHabilitado.getIdSemestre();
                Integer idCurso = chd.obtenerIdCursoXidDocente(usuario.getIdUsuario());

                System.out.println(nombre);
                System.out.println(codigo);
                System.out.println(correo);
                System.out.println(nota);
                System.out.println(idSemestre);
                System.out.println(idCurso);

                evDao.crearEvaluacion(nombre,codigo,correo,Integer.parseInt(nota),idCurso,idSemestre);
                response.sendRedirect(request.getContextPath() + "/docente?action=home");
                break;


            case "editEv":
                String idEv = request.getParameter("idEv");
                String nombre2 = request.getParameter("nombre");
                String codigo2 = request.getParameter("codigo");
                String correo2 = request.getParameter("correo");
                String nota2 = request.getParameter("nota");

                System.out.println(nombre2);
                System.out.println(codigo2);
                System.out.println(correo2);
                System.out.println(nota2);
                System.out.println(idEv);

                evDao.editarEvaluacion(Integer.parseInt(idEv), nombre2, codigo2, correo2, Integer.parseInt(nota2));
                response.sendRedirect(request.getContextPath() + "/docente?action=home");

                break;

            case "filtro":
                String filtro = request.getParameter("filter");


                if(filtro.equals("current")){
                    Semestre semestreHabilitado2 = semestreDao.semestreHabilitado();
                    Integer idCurso2 = chd.obtenerIdCursoXidDocente(usuario.getIdUsuario());
                    ArrayList<Evaluaciones> listaEvCurrent = evDao.listarEvaluacionesSemestreActual(idCurso2, semestreHabilitado2.getIdSemestre());


                    request.setAttribute("semestreHabilitado", semestreHabilitado2);
                    request.setAttribute("listaEvaluaciones", listaEvCurrent);
                    request.getRequestDispatcher("/docente/lista_evaluaciones.jsp").forward(request,response);

                }else{
                    Semestre semestreHabilitado3 = semestreDao.semestreHabilitado();
                    Integer idCurso3 = chd.obtenerIdCursoXidDocente(usuario.getIdUsuario());
                    ArrayList<Evaluaciones> listaEvPast = evDao.listarEvaluacionesSemestrePasado(idCurso3, semestreHabilitado3.getIdSemestre());

                    request.setAttribute("semestreHabilitado", semestreHabilitado3);
                    request.setAttribute("listaEvaluaciones", listaEvPast);
                    request.getRequestDispatcher("/docente/lista_evaluaciones.jsp").forward(request,response);

                }







        }




    }
}
