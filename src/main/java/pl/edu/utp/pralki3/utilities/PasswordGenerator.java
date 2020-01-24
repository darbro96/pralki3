package pl.edu.utp.pralki3.utilities;

import java.util.Random;

public class PasswordGenerator {
    private static final int PASSWORD_SIZE = 8;

    public static String generatePassword() {
        String password = "";
        String signs = "abcdefghijklmnopqrstuvwyzABCDEFGHIJKLMNOPQRSTUWYZ1234567890";
        Random random = new Random();
        for (int i = 0; i < PASSWORD_SIZE; i++) {
            int los = random.nextInt(signs.length());
            password += signs.substring(los, los + 1);
        }
        return password;
    }
}
