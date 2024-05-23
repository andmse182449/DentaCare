/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package account;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Arrays;
import java.util.Base64;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

/**
 *
 * @author Admin
 */
public class StringEncoder {
    private static final String ALGORITHM = "AES/CBC/PKCS5Padding";
    private static final String SECRET_KEY = "your-secret-key"; // Replace with your own secret key
    private static final byte[] SALT = new byte[16]; // 16-byte salt

    static {
     
        SecureRandom random = new SecureRandom();
        random.nextBytes(SALT);
    }

    public  String encode(String input) throws Exception {
        byte[] key = hashSecret(SECRET_KEY, SALT);
        SecretKeySpec secretKey = new SecretKeySpec(key, "AES");
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, secretKey, new IvParameterSpec(SALT));
        byte[] encrypted = cipher.doFinal(input.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(encrypted);
    }

    public String decode(String input) throws Exception {
        byte[] key = hashSecret(SECRET_KEY, SALT);
        SecretKeySpec secretKey = new SecretKeySpec(key, "AES");
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, secretKey, new IvParameterSpec(SALT));
        byte[] decoded = cipher.doFinal(Base64.getDecoder().decode(input));
        return new String(decoded, StandardCharsets.UTF_8);
    }

    private byte[] hashSecret(String secret, byte[] salt) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        digest.update(salt);
        byte[] hash = digest.digest(secret.getBytes(StandardCharsets.UTF_8));
        return Arrays.copyOf(hash, 16); // Use only the first 128 bits
    }
}
