package com.example.gestionacademica.Models.Daos;

import com.example.gestionacademica.Models.Beans.Evaluaciones;
import com.example.gestionacademica.Models.Beans.Semestre;

import java.sql.*;
import java.util.ArrayList;

public class SemestreDao extends DaoBase{

    public Semestre semestreHabilitado(){
        Semestre semestre = null;

        String sql = "SELECT * FROM lab_9.semestre where habilitado = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ){

            pstmt.setInt(1, 1);

            try(ResultSet rs = pstmt.executeQuery()){

                if (rs.next()){
                    semestre = new Semestre();
                    fetchSemestreData(rs, semestre);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return semestre;
    }

    public Semestre semestreXid(Integer idSemestre){
        Semestre semestre = null;

        String sql = "SELECT * FROM lab_9.semestre where idsemestre = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);){

            pstmt.setInt(1, idSemestre);

            try(ResultSet rs = pstmt.executeQuery()){

                if (rs.next()){
                    semestre = new Semestre();
                    fetchSemestreData(rs, semestre);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return semestre;
    }

    public ArrayList<Semestre> listaSemestres(){
        ArrayList<Semestre> list = new ArrayList<>();

        String sql = "SELECT * FROM lab_9.semestre";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql) ){

                while (rs.next()){
                    Semestre semestre = new Semestre();
                    fetchSemestreData(rs, semestre);
                    list.add(semestre);
                }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }



    public void fetchSemestreData(ResultSet rs, Semestre semestre) throws SQLException {
        semestre.setIdSemestre(rs.getInt(1));
        semestre.setNombre(rs.getString(2));
        semestre.setIdAdministrador(rs.getInt(3));
        semestre.setHabilitado(rs.getInt(4));
        semestre.setFechaRegistro(rs.getString(5));
        semestre.setFechaEdicion(rs.getString(6));
    }




}
