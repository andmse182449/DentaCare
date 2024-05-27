package Token;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.SignatureException;

import java.util.Date;

public class TokenGenerator {

    private static final String SECRET_KEY = "Xr4ilPBav/8PSU30icGIiAkoo4nXnLdg2dUZlECA44L37Pq9szYh8pECIAqImBn+OuJbnxxsfs0HHU87rGuAuw==";

    public static String generateToken(long expirationTimeInMillis) {
        long nowMillis = System.currentTimeMillis();
        Date now = new Date(nowMillis);
        Date exp = new Date(nowMillis + expirationTimeInMillis);

        return Jwts.builder()
                .setIssuedAt(now)
                .setExpiration(exp)
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
                .compact();
    }

    public static boolean validateToken(String token) {
        try {
            Jws<Claims> claims = Jwts.parser()
                    .setSigningKey(SECRET_KEY)
                    .parseClaimsJws(token);
            System.out.println("Token is valid. Claims: " + claims.getBody());
            return true;
        } catch (ExpiredJwtException e) {
            System.out.println("Token has expired.");
        } catch (SignatureException e) {
            System.out.println("Token signature is invalid.");
        } catch (Exception e) {
            System.out.println("Token is invalid.");
        }
        return false;
    }
}
