package com.web;

import com.model.Role;
import com.model.User;
import com.repository.RoleRepository;
import com.repository.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.HashSet;

@Component
public class DataSeeding implements ApplicationListener<ContextRefreshedEvent> {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent arg0) {
        // Roles
        if (roleRepository.findByName("ROLE_ADMIN") == null) {
            roleRepository.save(new Role("ROLE_ADMIN"));
        }

        if (roleRepository.findByName("ROLE_MEMBER") == null) {
            roleRepository.save(new Role("ROLE_MEMBER"));
        }

        // Admin account
        if (userRepository.findByUsername("admin") == null) {
            User admin = new User();
            admin.setUsername("admin");
            admin.setPassword(bCryptPasswordEncoder.encode("admin123"));
            HashSet<Role> roles = new HashSet<>();
            roles.add(roleRepository.findByName("ROLE_ADMIN"));
            admin.setRoles(roles);
            userRepository.save(admin);
        }

        // Patient account
        if (userRepository.findByUsername("patient") == null) {
            User patient = new User();
            patient.setUsername("patient");
            patient.setPassword(bCryptPasswordEncoder.encode("patient123"));
            HashSet<Role> roles = new HashSet<>();
            roles.add(roleRepository.findByName("ROLE_MEMBER"));
            patient.setRoles(roles);
            userRepository.save(patient);
        }

    }
}
