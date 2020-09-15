import java.security.SecureRandom;
//import com.google.common.io.BaseEncoding;

public class Dog {

    private int size;

    public int getSize() {
        return size;
    }

    public void setSize(int s) {
        size = s;
    }

    void bark() {
        if (size > 60) {
            System.out.println("Woof! Woof!");
        } else if (size < 60) {
            System.out.println("Ruff! Ruff!");
        } else {
            System.out.println("Yip! Yip!");
        }
    }

    private void createClusterBootstrapToken(String id) {


        // This is an embarassment....
        SecureRandom secureRandom = new SecureRandom();
        byte b [] = new byte[20];
        secureRandom.nextBytes(b);
//        String randomHex = BaseEncoding.base64().encode(b);

        secureRandom.nextBytes(b);
//        String randomHex2 = BaseEncoding.base64().encode(b);

//        String token = randomHex.substring(0,6)+"."+ randomHex2.substring(0,16);


    }
}
