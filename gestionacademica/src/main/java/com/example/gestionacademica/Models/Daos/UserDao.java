package com.example.gestionacademica.Models.Daos;

import com.example.gestionacademica.Models.Beans.Usuario;
import com.example.gestionacademica.Models.SHA256;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class UserDao extends DaoBase{

    public boolean comprobarCorreoPassw(String correo, String passwd){
        Boolean existeUsuario = false;

        passwd = SHA256.hashString(passwd);

        String sql ="select * from usuario where correo=? and password=?";

        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1, correo);
            pstmt.setString(2, passwd);

            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    existeUsuario  = true;
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return existeUsuario;
    }


    public Usuario obtenerUsuario(String correo){
        Usuario usuario = null;

        String sql = "SELECT * FROM usuario where correo = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, correo);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    usuario = new Usuario();
                    fetchUsuarioData(usuario, rs);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return usuario;
    }

    public ArrayList<Usuario> listarDocentesSinCursos(){
        ArrayList<Usuario> list = new ArrayList<>();

        String sql = "SELECT u.*\n" +
                "FROM usuario u\n" +
                "LEFT JOIN curso_has_docente ch ON u.idusuario = ch.iddocente\n" +
                "WHERE ch.idcurso IS NULL and idrol = 4";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()){
                Usuario usuario = new Usuario();
                fetchUsuarioData(usuario,rs );
                list.add(usuario);
            }


        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return list;
    }

    public ArrayList<Usuario> listarUsuarios(){
        ArrayList<Usuario> list = new ArrayList<>();

        String sql = "SELECT * from usuario";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()){
                Usuario usuario = new Usuario();
                fetchUsuarioData(usuario,rs );
                list.add(usuario);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return list;
    }


    public ArrayList<Usuario> listarDocentesConCursosPorFacultad(Integer idFacultad){
        ArrayList<Usuario> list = new ArrayList<>();

        String sql = "SELECT u.*\n" +
                "FROM curso_has_docente ch\n" +
                "left join curso c on c.idcurso = ch.idcurso\n" +
                "left join usuario u on ch.iddocente = u.idusuario\n" +
                "where c.idfacultad = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setInt(1, idFacultad);

             try(ResultSet rs = pstmt.executeQuery()){

                 while (rs.next()){
                     Usuario usuario = new Usuario();
                     fetchUsuarioData(usuario,rs );
                     list.add(usuario);
                 }

             }


        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return list;
    }


    public Usuario buscarUsuarioXid(Integer idUsuario){
        Usuario usuario = null;

        String sql = "SELECT * from usuario where idusuario = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setInt(1, idUsuario);

            try(ResultSet rs = pstmt.executeQuery()){

                if (rs.next()){
                    usuario = new Usuario();
                    fetchUsuarioData(usuario,rs );
                }

            }


        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return usuario;
    }


    public void crearDocente(Integer id, String nombre, String correo, String passwd){

        passwd = SHA256.hashString(passwd);

        LocalDateTime fechaHoraActual = LocalDateTime.now();
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String fechaHoraFormateada = fechaHoraActual.format(formato);
        System.out.println(passwd);
        System.out.println(fechaHoraFormateada);

        String sql = "INSERT INTO usuario (idusuario, nombre, correo, password, idrol, ultimo_ingreso, cantidad_ingresos, fecha_registro, fecha_edicion)\n" +
                "VALUES \n" +
                "    (?,?,?,?,4,NULL,0,?,?) ";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setInt(1, id);
            pstmt.setString(2, nombre);
            pstmt.setString(3, correo);
            pstmt.setString(4, passwd);
            pstmt.setString(5, fechaHoraFormateada);
            pstmt.setString(6, fechaHoraFormateada);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public void editDocente(String nombre, Integer idUsuario){

        LocalDateTime fechaHoraActual = LocalDateTime.now();
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String fechaHoraFormateada = fechaHoraActual.format(formato);


        String sql = "update usuario set nombre=?, fecha_edicion=? where idusuario=? ";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1, nombre);
            pstmt.setString(2, fechaHoraFormateada);
            pstmt.setInt(3, idUsuario);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void updateIngresos(Integer idUsuario, Integer cantidad){

        String sql = "update usuario set cantidad_ingresos=? where idusuario=? ";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setInt(1, cantidad);
            pstmt.setInt(2, idUsuario);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Integer ingresosXusuario(Integer idUsuario){
       Integer cant = null;

        String sql = "SELECT cantidad_ingresos from usuario where idusuario = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setInt(1, idUsuario);

            try(ResultSet rs = pstmt.executeQuery()){
                if (rs.next()){
                    cant = rs.getInt(1);
                }
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return cant;
    }




    public void eliminarDocente(Integer id){

        String sql = "DELETE from usuario where idusuario = ? ";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setInt(1, id);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }




    private void fetchUsuarioData(Usuario user, ResultSet rs) throws SQLException {
        user.setIdUsuario(rs.getInt(1));
        user.setNombre(rs.getString(2));
        user.setCorreo(rs.getString(3));
        user.setIdRol(rs.getInt(5));
        user.setUltimoIngreso(rs.getString(6));
        user.setCantIngresos(rs.getInt(7));
        user.setFechaRegistro(rs.getString(8));
        user.setFechaEdicion(rs.getString(9));
    }




}
