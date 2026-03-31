package com.api.automation.postrequest.datadriven;
import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class Scenarioutline {
	

		@Test
		public Karate runTest()
		{
			return Karate.run("datadrive").
					relativeTo(getClass());
		}

	}

