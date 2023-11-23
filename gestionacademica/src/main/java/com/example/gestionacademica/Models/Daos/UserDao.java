package com.example.gestionacademica.Models.Daos;

import com.example.gestionacademica.Models.Beans.Usuario;
import com.example.gestionacademica.Models.SHA256;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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

        String sql = "SELECT * FROM jugadores where usuario = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, correo);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    usuario = new Usuario();
                    fetchJugadorData(usuario, rs);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return usuario;
    }

    private void fetchJugadorData(Usuario user, ResultSet rs) throws SQLException {
        user.setIdUsuario(rs.getInt(1));
        user.setNombre(rs.getString(2));
        user.setCorreo(rs.getString(3));
        user.setIdRol(rs.getInt(5));
        user.setUltimoIngreso(rs.getString(6));
        user.setCantIngresos(rs.getInt(7));
        user.setFechaRegistro(rs.getString(6));
        user.setFechaEdicion(rs.getString(8));
    }




}
