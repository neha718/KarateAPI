package com.api.automation.postrequest;
import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

public class JavaScript {
	

		@Test
		public Karate runTest()
		{
			return Karate.run("JavaCriptExecutor").
					relativeTo(getClass());
		}

	}

