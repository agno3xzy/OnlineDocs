package Registration;

import Controller.registcontroller;
import com.opensymphony.xwork2.ActionSupport;

import java.util.ArrayList;

public class SignupAction extends ActionSupport {
    String username;
    String password;
    @Override
    public String execute() throws Exception{
        ArrayList<String> userList = new ArrayList<String>();
        userList.add(username);
        userList.add(password);
        System.out.println(userList);
        registcontroller regist = new registcontroller();
        boolean mark = regist.regist(userList);
        if(mark){
            return SUCCESS;
        } else
        {
            return ERROR;
        }
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
