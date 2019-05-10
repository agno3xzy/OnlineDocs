package ButtonSupport;
import com.opensymphony.xwork2.ActionSupport;

/*
此处为按钮控制类，所有
的跳转按钮逻辑都写于此
        */
public class ButtonAction extends ActionSupport {
    private boolean signin;
    private boolean signup;
    public void setSignin(boolean signin) {
        this.signin = signin;
    }
    public void setSignup(boolean signup) {
        this.signup = signup;
    }
    public String execute() throws Exception {
        if (signin) {
            signin();
            return "signinResult";
        }
        if (signup) {
            signup();
            return "signupResult";
        }
        return super.execute();
    }

    public String signin() throws Exception {
        // submit button logic here
        return SUCCESS;
    }

    public String signup() throws Exception {
        // clear button logic here
        return SUCCESS;
    }
}
