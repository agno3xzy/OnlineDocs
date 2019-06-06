package Registration;

import Controller.logincontroller;
import com.opensymphony.xwork2.ActionSupport;
import dao.Dao;
import org.apache.struts2.ServletActionContext;

import javax.servlet.ServletResponse;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CheckSigninAction extends ActionSupport {
    private String username;
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    @Override
    public String execute() {
        String password = "";
        try {
            logincontroller login = new logincontroller();
            password = login.checkLogin(username);
            System.out.println(password);

            //取得response 实例
            ServletResponse response = ServletActionContext.getResponse();
            PrintWriter writer = response.getWriter();
            writer.write(password);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
