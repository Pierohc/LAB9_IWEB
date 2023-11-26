package com.example.gestionacademica.Servlets;

import com.example.gestionacademica.Models.Beans.Curso;
import com.example.gestionacademica.Models.Beans.Usuario;
import com.example.gestionacademica.Models.Daos.CursoDao;
import com.example.gestionacademica.Models.Daos.FacultadHasDecanoDao;
import com.example.gestionacademica.Models.Daos.UserDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession httpSession = request.getSession();
        Usuario usuario = (Usuario) httpSession.getAttribute("userLog");

        if(usuario != null && usuario.getIdUsuario()>0){
            httpSession.invalidate();
            response.sendRedirect(request.getContextPath());
        }else{
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }



    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDao userDao = new UserDao();
        String action = request.getParameter("action") == null? "login": request.getParameter("action");

        switch (action){
            case "login":
                String correo = request.getParameter("correo");
                String password = request.getParameter("password");

                System.out.println("correo:" + correo);
                System.out.println("contra: "  + password);

                if(userDao.comprobarCorreoPassw(correo, password)){
                    System.out.println("credenciales validas");
                    Usuario usuario = userDao.obtenerUsuario(correo);

                    HttpSession httpSession = request.getSession();
                    httpSession.setAttribute("userLog", usuario);

                    if(usuario.getIdRol() == 3){
                        response.sendRedirect(request.getContextPath() +"/decano?action=home");

                    } else if(usuario.getIdRol() == 4){
                        response.sendRedirect(request.getContextPath() +"/docente?action=home");

                    }else{
                        response.sendRedirect(request.getContextPath());
                    }


                }else{
                    response.sendRedirect(request.getContextPath());
                }

                break;



        }



    }
}
