package com.example.gestionacademica.Models.Daos;

import com.example.gestionacademica.Models.Beans.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class FacultadHasDecanoDao extends DaoBase {


    public Integer obtenerIdFacultad(Integer idDecano) {
        Integer idFacultad = null;

        String sql = "SELECT * FROM facultad_has_decano where iddecano = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idDecano);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    idFacultad = rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return idFacultad;
    }


}
