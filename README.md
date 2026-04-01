# Karate Framework - API Automation Testing

This is a comprehensive Karate framework setup for API automation testing with best practices implemented.

## Project Overview

This project demonstrates a modern Karate framework implementation with:
- **JUnit 5** integration for test execution
- **Maven** build automation
- **Multiple test runners** for different API operations (GET, POST, PUT)
- **Environment-based configuration** management
- **Structured test organization** by API endpoints

## Directory Structure

```
karateframework/
├── pom.xml                          # Maven configuration
├── README.md                        # This file
└── src/test/java/
    └── com/api/automation/
        ├── karate-config.js         # Global Karate configuration
        ├── logback-test.xml         # Logging configuration
        ├── CommonCode.java          # Common utility methods
        ├── TestRunner.java          # Main test runner (runs all tests)
        ├── JsonResponse.json        # Test data file
        ├── XMLResponse.xml          # Test data file
        ├── getrequest/              # GET request tests
        │   ├── TestGetRunner.java
        │   ├── getRequest.feature
        │   ├── responseMatcher.feature
        │   ├── validateJSONArray.feature
        │   ├── validateXMLResponse.feature
        │   ├── validateJSONwithFuzzy.feature
        │   ├── validateXMLwithFuzzy.feature
        │   ├── validationUsingFile.feature
        │   └── Variable.feature
        ├── postrequest/             # POST request tests
        │   ├── TestPostRunner.java
        │   ├── CreateJobEntry.feature
        │   ├── SchemaValidation.feature
        │   └── datapackage/
        │       └── JobEntry.json
        └── putrequest/              # PUT request tests
            ├── PutRunner.java
            └── jobupdate.feature
```

## Key Features & Best Practices

### 1. **Modern Karate Version** (1.5.0)
- Latest features and bug fixes
- Better JUnit 5 integration
- Enhanced performance

### 2. **JUnit 5 Integration**
- Uses `@Karate.Test` annotation instead of deprecated `@Test`
- Compatible with modern IDEs and CI/CD pipelines
- Better test reports and failure analysis

### 3. **Configuration Management** (karate-config.js)
```javascript
- Environment-specific configurations (dev, stage, prod)
- Dynamic baseUrl management
- Logging level configuration
- Easy property overrides
```

### 4. **Test Organization**
- **TestRunner.java**: Master runner that executes all tests
- **TestGetRunner.java**: Executes all GET request tests
- **TestPostRunner.java**: Executes all POST request tests
- **PutRunner.java**: Executes all PUT request tests

### 5. **Logging Configuration**
- Configured via logback-test.xml
- Logs to both console and file (target/karate.log)
- DEBUG level for Karate framework
- INFO level for others

## Running Tests

### Run All Tests
```bash
mvn clean test
```

### Run Specific Test Runner
```bash
# Run GET tests only
mvn clean test -Dtest=TestGetRunner

# Run POST tests only
mvn clean test -Dtest=TestPostRunner

# Run PUT tests only
mvn clean test -Dtest=PutRunner

# Run all tests through main TestRunner
mvn clean test -Dtest=TestRunner
```

### Run with Specific Environment
```bash
mvn clean test -Dkarate.env=stage
mvn clean test -Dkarate.env=prod
```

### Run from IDE
1. Right-click on any Test Runner class
2. Select "Run As" > "JUnit Test"
3. Reports will be generated in `target/karate-reports/`

## Feature File Examples

### Basic GET Request
```gherkin
Feature: To test the GET endpoint
  Background:
    Given url baseUrl + '/normal/webapi/all'
  
  Scenario: To test the GET endpoint with JSON data
    When method get
    Then status 200
    And print response
```

### POST Request with JSON
```gherkin
Feature: To create job entry
  Background:
    Given url baseUrl

  Scenario: To create job entry in JSON format
    Given path '/normal/webapi/add'
    And request { jobId: 3, jobTitle: 'Software Engg', ... }
    And headers { Accept: 'application/json', Content-Type: 'application/json' }
    When method post
    Then status 201
    And match response.jobTitle == 'Software Engg'
```

### Response Validation with Matchers
```gherkin
# Exact match
And match response.jobId == 1

# Array validation
And match response[0].experience == '#[3]'

# Contains (order independent)
And match response[*].experience contains ['Google', 'Apple']

# Fuzzy matching
And match response.jobId == '#number'
And match response.jobTitle == '#string? _.length > 0'
```

### Using Variables
```gherkin
* def jobId = 100
* def randomId = function() { return Math.floor(Math.random() * 1000); }
* def jobData = read('datapackage/JobEntry.json')
```

## Configuration Details

### karate-config.js
- **baseUrl**: Dynamic base URL based on environment
- **env**: Current environment (dev, stage, prod)
- **logLevel**: Configurable logging level

### pom.xml
Key dependencies:
- `karate-junit5`: Main Karate framework
- `karate-core`: Core Karate functionality
- `junit-jupiter`: JUnit 5 for test execution
- `maven-surefire-plugin`: Test execution
- `maven-failsafe-plugin`: Integration test execution

## Best Practices Implemented

1. **DRY Principle**: Use of background scenarios and variables
2. **Parameterization**: Environment-based configuration
3. **Modular Tests**: Organized by API operation type
4. **Reusable Data**: External JSON/XML files for test data
5. **Clear Naming**: Descriptive scenario names
6. **Comments**: Well-documented feature files
7. **Schema Validation**: Fuzzy matchers for response validation
8. **Error Handling**: Scenario for error cases (e.g., 404)

## Test Reports

After running tests, reports are generated in:
- `target/karate-reports/` - HTML reports
- `target/test-classes/` - Test output

## Troubleshooting

### Tests not running
- Ensure Java 11+ is installed: `java -version`
- Verify Maven installation: `mvn -version`
- Check if localhost:9897 is running (if using local backend)

### Import errors in IDE
- Run Maven update: `mvn clean eclipse:eclipse` (for Eclipse)
- Rebuild project after dependency changes

### Port already in use
- Change port in karate-config.js or provide override: `-Dkarate.baseUrl=http://localhost:8080`

## Contributing

When adding new tests:
1. Create feature file in appropriate folder (getrequest, postrequest, putrequest)
2. Follow naming convention: `<action>.feature`
3. Use background scenarios for common setup
4. Add comments for complex logic
5. Update corresponding Runner class

## Resources

- **Karate Framework Documentation**: https://github.com/karatelabs/karate
- **Gherkin Syntax**: https://cucumber.io/docs/gherkin/
- **JUnit 5**: https://junit.org/junit5/
- **Maven Documentation**: https://maven.apache.org/

## Version History

- **v1.0.0** (Current): Updated to Karate 1.5.0, JUnit 5, modern best practices
- Previous versions used older Karate framework and deprecated annotations

---

**Last Updated**: April 2026  
**Framework Version**: Karate 1.5.0  
**Java Version**: 11+
