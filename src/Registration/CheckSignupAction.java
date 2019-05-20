package Registration;

import Controller.registcontroller;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class CheckSignupAction extends ActionSupport {
    private String username;
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    @Override
    public String execute() {
        boolean data = false;
        System.out.println(data);
        try {
            registcontroller regist = new registcontroller();
            data = regist.checkRegist(username);
            //取得response 实例
            ServletResponse response = ServletActionContext.getResponse();
            PrintWriter writer = response.getWriter();
            //可以注册
            if(data==true){
                //response.getWriter()得到PrintWriter实例，write 输出
                writer.write("0");
                System.out.println("you can regist");
            }else {//不能注册
                writer.write("1");
                System.out.println("the username already existed");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
