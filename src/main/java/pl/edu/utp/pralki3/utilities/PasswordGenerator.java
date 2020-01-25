package pl.edu.utp.pralki3.utilities;

import java.util.Random;

public class PasswordGenerator {
    private static final int PASSWORD_SIZE = 8;

    public static String generatePassword() {
        String password = null;
        String signs = "abcdefghijklmnopqrstuvwyzABCDEFGHIJKLMNOPQRSTUWYZ1234567890";
        Random random = new Random();
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < PASSWORD_SIZE; i++) {
            int los = random.nextInt(signs.length());
            builder.append(signs, los, los + 1);
        }
        password = builder.toString();
        return password;
    }
}
