package com.example.gestionacademica.Servlets;

import com.example.gestionacademica.Models.Beans.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "docente", value = "/docente")
public class DocenteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         HttpSession httpSession = request.getSession();
         Usuario usuario = (Usuario) httpSession.getAttribute("userLog");

         if(usuario != null && usuario.getIdUsuario() == 4){
            String action = request.getParameter("action") == null? "home" : request.getParameter("action");

            switch (action){

                case "home":



                    request.getRequestDispatcher("/docente/lista_evaluaciones.jsp").forward(request,response);
                    break;



            }
         }else{
             httpSession.invalidate();
             response.sendRedirect(request.getContextPath());
         }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
