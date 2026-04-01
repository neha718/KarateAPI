package com.api.automation;

import java.util.Random;
import java.util.UUID;

/**
 * Common utility methods for API automation testing
 * Provides reusable functions for test data generation and manipulation
 */
public class CommonCode {
    
    private static final Random random = new Random();
    
    /**
     * Generates a random integer between 0 and max value
     * @param max the maximum value (exclusive)
     * @return random integer
     */
    public static int getRandomInt(int max) {
        return random.nextInt(max);
    }
    
    /**
     * Generates a random integer within a specified range
     * @param min the minimum value (inclusive)
     * @param max the maximum value (exclusive)
     * @return random integer between min and max
     */
    public static int getRandomInt(int min, int max) {
        return random.nextInt(max - min) + min;
    }
    
    /**
     * Generates a UUID string
     * @return unique identifier
     */
    public static String generateUUID() {
        return UUID.randomUUID().toString();
    }
    
    /**
     * Generates a random string of specified length
     * @param length the length of the string
     * @return random alphanumeric string
     */
    public static String generateRandomString(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < length; i++) {
            result.append(chars.charAt(random.nextInt(chars.length())));
        }
        return result.toString();
    }
    
    /**
     * Generates a random email address
     * @return random email
     */
    public static String generateRandomEmail() {
        return "test_" + generateRandomString(8) + "@example.com";
    }
    
    /**
     * Delays execution for specified milliseconds
     * @param milliseconds the delay duration
     */
    public static void waitFor(long milliseconds) {
        try {
            Thread.sleep(milliseconds);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}
