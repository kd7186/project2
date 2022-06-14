package com.lcomputerstudy.example.config;

import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import com.lcomputerstudy.example.service.UserService;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {
   
   @Autowired
   private UserService userService;
   
   @Autowired
   private DataSource dataSource;
   
   @Bean
   public PasswordEncoder passwordEncoder() {
      return new BCryptPasswordEncoder();
   }
   
   
   @Override
   protected void configure(HttpSecurity http) throws Exception {


      http
      .authorizeRequests()
            .antMatchers("/user/**").authenticated()
            .antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')")
            .anyRequest().permitAll()
            .and()
      .formLogin()
            .loginPage("/login")
            .loginProcessingUrl("/loginPro")
            .defaultSuccessUrl("/1", true)
            .permitAll()
            .and()
      .logout()
         .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
         .logoutSuccessUrl("/1")
         .invalidateHttpSession(true)
         .deleteCookies("JSESSIONID", "remember-me")
         .and()
      .rememberMe()
         .key("myWeb")
         .rememberMeParameter("remember-me")
         .tokenValiditySeconds(86400)
         .and()
      .exceptionHandling()
         .accessDeniedPage("/denied")
         .and()
      .sessionManagement()
         .sessionCreationPolicy(SessionCreationPolicy.NEVER)   
         .invalidSessionUrl("/login")
         .and()   
      .csrf().disable();       
   }
   @Bean
   public PersistentTokenRepository persistentTokenRepository() {
      JdbcTokenRepositoryImpl db = new JdbcTokenRepositoryImpl();
      db.setDataSource(dataSource);
      return db;
   }

   @Override
   public void configure(AuthenticationManagerBuilder auth) throws Exception {
      auth.userDetailsService(userService).passwordEncoder(passwordEncoder());
   }
}