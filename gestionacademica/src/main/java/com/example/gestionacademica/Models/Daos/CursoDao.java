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


    public ArrayList<Curso> obtenerCursosConEvFacultad(Integer idFacultad){
        ArrayList<Curso> list = new ArrayList<>();

        String sql = "SELECT c.*\n" +
                "from evaluaciones e\n" +
                "left join curso c on e.idcurso = c.idcurso\n" +
                "where idfacultad = ?\n" +
                "group by idcurso";

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


    public ArrayList<Curso> obtenerCursosSinEvFacultad(Integer idFacultad){
        ArrayList<Curso> list = new ArrayList<>();

        String sql = "SELECT c.*\n" +
                "from curso c\n" +
                "left join evaluaciones e on c.idcurso = e.idcurso\n" +
                "where e.idevaluaciones is NULL and idfacultad = ?";

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

    public Curso obtenerCursoXid(Integer idCurso){
        Curso curso = null;

        String sql = "SELECT * FROM curso where idcurso = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idCurso);

            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    curso = new Curso();
                    fetchData(rs, curso);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return curso;
    }


    public void editCurso(String nombre, Integer idCurso){

        LocalDateTime fechaHoraActual = LocalDateTime.now();
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String fechaHoraFormateada = fechaHoraActual.format(formato);

        String sql = "update curso set nombre=?, fecha_edicion=? where idcurso=? ";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1, nombre);
            pstmt.setString(2, fechaHoraFormateada);
            pstmt.setInt(3, idCurso);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public void eliminarCurso(Integer idCurso){

        String sql = "delete from curso where idcurso = ? ";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setInt(1, idCurso);
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
