package Registration;

import Controller.logincontroller;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.ServletResponse;
import java.io.PrintWriter;
import java.util.ArrayList;

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
