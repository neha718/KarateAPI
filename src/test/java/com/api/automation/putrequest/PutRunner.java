package com.api.automation.putrequest;

import com.intuit.karate.junit5.Karate;

public class PutRunner {
	@Karate.Test
	public Karate runTest() {
		return Karate.run("jobupdate").relativeTo(getClass());
	}
}

