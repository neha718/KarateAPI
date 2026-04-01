package com.api.automation;

import org.junit.jupiter.api.Test;

import com.intuit.karate.junit5.Karate;

/**
 * Main test runner class to execute all Karate tests
 * This class runs all feature files from different modules: GET, POST, PUT requests
 */
public class TestRunner {
	
	@Karate.Test
	public Karate runAllTests() {
		return Karate.run().relativeTo(getClass());
	}
	
	@Karate.Test
	public Karate runGetTests() {
		return Karate.run().path("getrequest").relativeTo(getClass());
	}
	
	@Karate.Test
	public Karate runPostTests() {
		return Karate.run().path("postrequest").relativeTo(getClass());
	}
	
	@Test
	public Karate runPutTests() {
		return Karate.run().path("putrequest").relativeTo(getClass());
	}
}
