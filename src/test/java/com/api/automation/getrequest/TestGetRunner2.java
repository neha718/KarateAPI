package com.api.automation.getrequest;

import com.intuit.karate.junit5.Karate;

public class TestGetRunner2 {

    @Karate.Test
    public Karate runTest() {
        // Make sure the feature file name matches exactly
        return Karate.run("variable")
                     .relativeTo(getClass());
    }
}