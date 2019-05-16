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
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        ArrayList<String> userList = new ArrayList<String>();
        userList.add(username);
        userList.add(password);
        System.out.println(userList);
        logincontroller login = new logincontroller();
        boolean mark = login.checkLogin(userList);
        if (mark) return SUCCESS;
        else return ERROR;
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
