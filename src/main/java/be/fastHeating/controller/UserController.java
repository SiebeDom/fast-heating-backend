package be.fastHeating.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

@RestController
public class UserController {
    @GetMapping("/users/login")
    @ResponseBody
    public Principal user(Principal user) {
        return user;
    }
}
