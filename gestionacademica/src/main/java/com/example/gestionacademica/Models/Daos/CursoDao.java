package com.example.gestionacademica.Models.Daos;

import com.example.gestionacademica.Models.Beans.Curso;
import com.example.gestionacademica.Models.SHA256;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class CursoDao extends DaoBase{

    public ArrayList<Curso> obtenerCursosFacultad(Integer idFacultad){
        ArrayList<Curso> list = new ArrayList<>();

        String sql = "SELECT * FROM curso where idfacultad = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idFacultad);

            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    Curso curso = new Curso();
                    fetchData(rs, curso);
                    list.add(curso);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public ArrayList<Curso> listarTodosCursos(){
        ArrayList<Curso> list = new ArrayList<>();

        String sql = "SELECT * FROM curso ";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

                while (rs.next()) {
                    Curso curso = new Curso();
                    fetchData(rs, curso);
                    list.add(curso);
                }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public void crearCurso(Integer id, String codigo, String nombre, Integer idFacultad){

        LocalDateTime fechaHoraActual = LocalDateTime.now();
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String fechaHoraFormateada = fechaHoraActual.format(formato);


        String sql = "INSERT INTO curso (idcurso, codigo, nombre, idfacultad, fecha_registro, fecha_edicion)\n" +
                "VALUES \n" +
                "    (?,?,?,?,?,?) ";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setInt(1, id);
            pstmt.setString(2, codigo);
            pstmt.setString(3, nombre);
            pstmt.setInt(4, idFacultad);
            pstmt.setString(5, fechaHoraFormateada);
            pstmt.setString(6, fechaHoraFormateada);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }








    public void fetchData(ResultSet rs, Curso curso) throws SQLException {

        curso.setIdCurso(rs.getInt(1));
        curso.setCodigo(rs.getString(2));
        curso.setNombre(rs.getString(3));
        curso.setIdFacultad(rs.getInt(4));
        curso.setFechaRegistro(rs.getString(5));
        curso.setFechaEdicion(rs.getString(6));
    }



}
