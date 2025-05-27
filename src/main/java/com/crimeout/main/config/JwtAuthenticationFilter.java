package com.crimeout.main.config;

import java.io.IOException;
import com.crimeout.main.service.JwtService;
import jakarta.servlet.http.Cookie;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {
    private final JwtService jwtService;
    private final UserDetailsService userDetailsService;
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        try {
            String requestPath = request.getRequestURI();

            // Excluir rutas públicas de la autenticación
            if (requestPath.equals("/")
                    || requestPath.startsWith("/api/v1/crimeout/auth/")) {
                filterChain.doFilter(request, response);
                return;
            }

            final String token = getTokenFromRequest(request);
            final String username; //username es rut

            if (token==null)
            {
                filterChain.doFilter(request, response);
                return;
            }

            username=jwtService.getUsernameFromToken(token);

            //  Verifica si el token es válido
            if (username!=null && SecurityContextHolder.getContext().getAuthentication()==null) {
                UserDetails userDetails=userDetailsService.loadUserByUsername(username);
                if (jwtService.isTokenValid(token, userDetails)) {
                    UsernamePasswordAuthenticationToken authToken= new UsernamePasswordAuthenticationToken(
                            userDetails,
                            null,
                            userDetails.getAuthorities());

                    authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

                    SecurityContextHolder.getContext().setAuthentication(authToken);
                    System.out.println("Autenticación configurada para el usuario: " + username);
                }
            }
            filterChain.doFilter(request, response);
        } catch (AuthenticationException e) {
            response.sendRedirect("/");
        }
    }
    private String getTokenFromRequest(HttpServletRequest request) {
        String authHeader = request.getHeader("Authorization");
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            return authHeader.substring(7);
        }
        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if (cookie.getName().equals("jwt")) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

}