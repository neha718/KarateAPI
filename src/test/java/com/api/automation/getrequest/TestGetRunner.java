package com.api.automation.getrequest;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class TestGetRunner {
	@Test
	public Karate runTest()
	{
		return Karate.run("getRequest","responseMatcher","validateJSONArray","validateXMLResponse",
				"validateJSONwithFuzzy","validateXMLwithFuzzy").
				relativeTo(getClass());
	}
@Test
	public Karate  runTestUsingClassPath()
	{
	return Karate.run("getRequest").relativeTo(getClass());
		
	}
}

