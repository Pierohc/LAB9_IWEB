package com.example.gestionacademica.Models.Daos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public abstract class DaoBase {
    public Connection getConnection() throws SQLException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        String user = "root";
        String pass = "root";
        String url = "jdbc:mysql://35.239.118.88/lab_9";


        //return DriverManager.getConnection(url,user,pass);

        return DriverManager.getConnection("jdbc:mysql://35.239.118.88/lab_9","root", "\"uD}aN*,HG{F[OLb");
    }
}