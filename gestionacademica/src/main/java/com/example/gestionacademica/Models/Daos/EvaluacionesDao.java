package com.example.gestionacademica.Models.Daos;

import com.example.gestionacademica.Models.Beans.Curso;
import com.example.gestionacademica.Models.Beans.Evaluaciones;
import com.example.gestionacademica.Models.Beans.Usuario;
import com.example.gestionacademica.Models.SHA256;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class EvaluacionesDao extends DaoBase{

    public ArrayList<Evaluaciones> listarEvaluacionesDeDocente(Integer idCurso){
        ArrayList<Evaluaciones> list = new ArrayList<>();

        String sql = "SELECT * FROM lab_9.evaluaciones where idcurso = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setInt(1, idCurso);

            try(ResultSet rs = pstmt.executeQuery()){

                while (rs.next()){
                    Evaluaciones ev = new Evaluaciones();
                    fetchEvalucionData(rs, ev);
                    list.add(ev);
                }

            }


        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return list;
    }

    public ArrayList<Evaluaciones> listarEvaluacionesXsemestre(Integer idCurso, Integer idSemestre){
        ArrayList<Evaluaciones> list = new ArrayList<>();

        String sql = "SELECT * FROM lab_9.evaluaciones where idcurso = ? and idsemestre=?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setInt(1, idCurso);
            pstmt.setInt(2, idSemestre);

            try(ResultSet rs = pstmt.executeQuery()){

                while (rs.next()){
                    Evaluaciones ev = new Evaluaciones();
                    fetchEvalucionData(rs, ev);
                    list.add(ev);
                }

            }


        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return list;
    }

    public ArrayList<Evaluaciones> listarEvaluacionesSemestrePasado (Integer idCurso, Integer idSemestre){
        ArrayList<Evaluaciones> list = new ArrayList<>();

        String sql = "SELECT * FROM lab_9.evaluaciones where idcurso = ? and idsemestre != ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setInt(1, idCurso);
            pstmt.setInt(2, idSemestre);

            try(ResultSet rs = pstmt.executeQuery()){

                while (rs.next()){
                    Evaluaciones ev = new Evaluaciones();
                    fetchEvalucionData(rs, ev);
                    list.add(ev);
                }

            }


        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return list;
    }


    public Evaluaciones buscarEvxId(Integer idEv){
        Evaluaciones evaluacion = null;

        String sql = "SELECT * from evaluaciones where idevaluaciones = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setInt(1, idEv);

            try(ResultSet rs = pstmt.executeQuery()){

                if (rs.next()){
                    evaluacion = new Evaluaciones();
                    fetchEvalucionData(rs,evaluacion);
                }

            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return evaluacion;
    }


    public void crearEvaluacion(String nombreEstudiante, String codigoEstudiante,String correo,Integer nota, Integer idCurso, Integer idSemestre){

        LocalDateTime fechaHoraActual = LocalDateTime.now();
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String fechaHoraFormateada = fechaHoraActual.format(formato);

        String sql = "INSERT INTO evaluaciones (nombre_estudiantes, codigo_estudiantes, correo_estudiantes, nota, idcurso, idsemestre, fecha_registro, fecha_edicion)\n" +
                "VALUES \n" +
                "    (?,?,?,?,?,?,?,?) ";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1, nombreEstudiante);
            pstmt.setString(2, codigoEstudiante);
            pstmt.setString(3, correo);
            pstmt.setInt(4, nota);
            pstmt.setInt(5, idCurso);
            pstmt.setInt(6, idSemestre);
            pstmt.setString(7, fechaHoraFormateada);
            pstmt.setString(8,fechaHoraFormateada);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void editarEvaluacion(Integer idEv, String nombreEstudiante, String codigoEstudiante,String correo,Integer nota){

        LocalDateTime fechaHoraActual = LocalDateTime.now();
        DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String fechaHoraFormateada = fechaHoraActual.format(formato);

        String sql = "update evaluaciones set nombre_estudiantes = ?, codigo_estudiantes = ?, correo_estudiantes = ?, nota = ?, fecha_edicion = ? where idevaluaciones=?";


        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1, nombreEstudiante);
            pstmt.setString(2, codigoEstudiante);
            pstmt.setString(3, correo);
            pstmt.setInt(4, nota);
            pstmt.setString(5, fechaHoraFormateada);
            pstmt.setInt(6, idEv);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public void deleteEvaluacion(Integer idEv){

        String sql = "Delete from evaluaciones where idevaluaciones = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setInt(1, idEv);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public void fetchEvalucionData(ResultSet rs, Evaluaciones ev) throws SQLException {
        ev.setIdevaluacion(rs.getInt(1));
        ev.setNombreEstudiante(rs.getString(2));
        ev.setCodigoEstudiante(rs.getString(3));
        ev.setCorreoEstudiante(rs.getString(4));
        ev.setNota(rs.getInt(5));
        ev.setIdCurso(rs.getInt(6));
        ev.setIdSemestre(rs.getInt(7));
        ev.setFechaRegistro(rs.getString(8));
        ev.setFechaEdicion(rs.getString(9));
    }


}
