package com.api.automation.getrequest;

import com.intuit.karate.junit5.Karate;

public class TestGetRunner {
	@Karate.Test
	public Karate runTest() {
		return Karate.run("getRequest", "responseMatcher", "validateJSONArray", 
				"validateXMLResponse", "validateJSONwithFuzzy", "validateXMLwithFuzzy")
				.relativeTo(getClass());
	}

	@Karate.Test
	public Karate runTestUsingClassPath() {
		return Karate.run("getRequest").relativeTo(getClass());
	}
}

