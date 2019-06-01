package Registration;

import Controller.logincontroller;
import com.opensymphony.xwork2.ActionSupport;
import dao.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
public class SigninAction extends ActionSupport{
    String username;
    String password;

    @Override
    public String execute() {
        return SUCCESS;
    }

    public String getUsername () {
        return username;
    }

    public void setUsername (String username){
        this.username = username;
    }

    public String getPassword () {
        return password;
    }

    public void setPassword (String password){
        this.password = password;
    }

}
