package com.model;

import com.model.User;
import org.junit.Test;
import static org.junit.Assert.*;



public class UserTest {
    private User user = new User("nguy2616", "redrose12", "redrose12");

    public UserTest() {
    }

    @Test
    public void testGetUsername() {
        System.out.println("Get Username");
        String expect = "nguy2616";
        String actual = user.getUsername();
        assertEquals(expect, actual);
    }

    @Test
    public void testSetUserName() {
        System.out.println("Set UserName");
        String newName = "new nguy2616";
        user.setUsername(newName);
        System.out.println(user);
    }

    @Test
    public void testGetPassword() {
        System.out.println("Get Password");
        String expect = "redrose12";
        String actual = user.getPassword();
        assertEquals(expect, actual);
    }

    @Test
    public void testSetPassword() {
        System.out.println("Set Password");
        String pass = "new redrose12";
        user.setPassword(pass);
        System.out.println(user);
    }

    @Test
    public void testGetConfirmPassword() {
        System.out.println("Get Confirm Password");
        String expect = "redrose12";
        String actual = user.getPasswordConfirm();
        assertEquals(expect, actual);
    }

    @Test
    public void testSetConfirmPassword() {
        System.out.println("Set Confirm Password");
        String pass = "new redrose12";
        user.setPassword(pass);
        System.out.println(user);
    }
}
