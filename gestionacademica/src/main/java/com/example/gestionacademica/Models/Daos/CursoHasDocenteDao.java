package com.example.gestionacademica.Models.Daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CursoHasDocenteDao extends DaoBase{

    public void crearCursoConDocente(Integer idCurso, Integer idDocente){

        String sql = "INSERT INTO curso_has_docente (idcurso, iddocente)\n" +
                "VALUES \n" +
                "    (?,?) ";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setInt(1, idCurso);
            pstmt.setInt(2, idDocente);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
