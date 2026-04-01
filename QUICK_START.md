# Karate Framework - Implementation Quick Start Guide

## 🎯 What Was Updated

Your karateframework has been modernized according to real-time Karate framework best practices. Here's what changed and how to use it.

---

## 📦 Quick Summary

| Item | Change |
|------|--------|
| **Karate Version** | 1.4.1 → 1.5.0 |
| **JUnit Support** | Added JUnit 5.9.3 |
| **Test Annotations** | @Test → @Karate.Test |
| **Base URLs** | Hard-coded → Dynamic from config |
| **Test Organization** | 3 runners → 4 runners (added main) |
| **Documentation** | None → Complete |

---

## 🚀 Getting Started

### Step 1: Build the Project
```bash
cd C:\Users\nehah\eclipse-workspace\karateframework
mvn clean install
```

### Step 2: Run Tests
```bash
# All tests
mvn test

# GET tests only
mvn test -Dtest=TestGetRunner

# With specific environment
mvn test -Dkarate.env=stage
```

### Step 3: View Reports
- **HTML Reports**: `target/karate-reports/`
- **Logs**: `target/karate.log`
- **Console Output**: Maven console

---

## 📁 Project Structure Overview

```
karateframework/
├── pom.xml                    # Dependencies (UPDATED)
├── README.md                  # Full documentation (NEW)
├── UPDATES_SUMMARY.md        # This summary (NEW)
└── src/test/java/
    └── com/api/automation/
        ├── karate-config.js   # Configuration (ENHANCED)
        ├── logback-test.xml   # Logging config
        ├── CommonCode.java    # Utilities (ENHANCED)
        ├── TestRunner.java    # Main runner (NEW)
        ├── getrequest/        # GET tests (MODERNIZED)
        ├── postrequest/       # POST tests (MODERNIZED)
        └── putrequest/        # PUT tests (MODERNIZED)
```

---

## 🔑 Key Features

### 1. Configuration Management
Edit `karate-config.js` to change environment settings:

```javascript
// Dev environment (default)
config.baseUrl = 'http://localhost:9897'

// Stage environment
config.baseUrl = 'http://stage-server:9897'

// Prod environment
config.baseUrl = 'http://prod-server:9897'
```

**Switch at runtime**:
```bash
mvn test -Dkarate.env=stage
```

### 2. Test Runners

#### Main TestRunner.java (NEW)
```java
@Karate.Test
public Karate runAllTests() { ... }        // All tests

@Karate.Test
public Karate runGetTests() { ... }        // GET tests only

@Karate.Test
public Karate runPostTests() { ... }       // POST tests only

@Karate.Test
public Karate runPutTests() { ... }        // PUT tests only
```

#### Module-Specific Runners
- `TestGetRunner` → GET endpoint tests
- `TestPostRunner` → POST endpoint tests  
- `PutRunner` → PUT endpoint tests

### 3. Feature Files
All feature files now use dynamic configuration:

```gherkin
# Before (HARDCODED)
Given url 'http://localhost:9897'

# After (FROM CONFIG)
Given url baseUrl
Given url baseUrl + '/path'
```

### 4. Utility Methods (CommonCode.java)

```java
// Generate test data
int randomId = CommonCode.getRandomInt(1000);
int between = CommonCode.getRandomInt(10, 100);
String uuid = CommonCode.generateUUID();
String email = CommonCode.generateRandomEmail();
String randomStr = CommonCode.generateRandomString(10);

// Test control
CommonCode.waitFor(1000); // Wait 1 second
```

---

## 🧪 Writing Tests - Best Practices

### Feature File Template
```gherkin
Feature: Brief description of what is being tested
  Longer description of the feature

  Background: Setup common for all scenarios
    Given url baseUrl
    And headers { Content-Type: 'application/json' }

  Scenario: Describe what should happen
    Given path '/endpoint'
    When method post
    Then status 200
    And match response.field == expectedValue
```

### Using Variables
```gherkin
Scenario: Use variables for test data
  * def userId = 123
  * def randomId = CommonCode.getRandomInt(1000)
  * def userData = read('datapackage/user.json')
  
  Given path '/users/' + userId
  When method get
  Then status 200
```

### Validation Patterns
```gherkin
# Exact match
And match response.name == 'John'

# Type checking
And match response.age == '#number'
And match response.email == '#string'

# Arrays
And match response.items == '#[5]'
And match response.items[*] contains 'value'

# Complex validation
And match response.user == { name: '#string', age: '#number' }

# Fuzzy matching
And match response.score == '#number? _ > 100'
```

---

## 🔧 IDE Integration

### Eclipse
1. Right-click Test Runner → Run As → JUnit Test
2. Reports appear in Console and Results View

### IntelliJ
1. Right-click Test Runner → Run
2. View results in Run Console

### VS Code
Use Maven extension or terminal:
```bash
mvn test -Dtest=TestGetRunner
```

---

## 📊 Understanding Test Execution

### Execution Flow
```
TestRunner.runAllTests()
    ├─→ Load karate-config.js
    ├─→ Set baseUrl based on environment
    ├─→ Execute all .feature files
    ├─→ Generate reports
    └─→ Output logs to target/karate.log
```

### Log Levels
```
DEBUG   : Detailed framework information (Dev)
INFO    : General information (Stage)
WARN    : Warnings only (Prod)
ERROR   : Errors only
```

---

## ⚙️ Configuration Options

### Via Command Line
```bash
# Environment
mvn test -Dkarate.env=stage

# Specific test
mvn test -Dtest=TestGetRunner

# Combined
mvn test -Dtest=TestPostRunner -Dkarate.env=prod

# Debug logging
mvn test -X
```

### Via karate-config.js
```javascript
var config = {
    env: 'dev',
    baseUrl: 'http://localhost:9897',
    logLevel: 'info',
    // Add custom properties
    apiTimeout: 5000,
    retryCount: 3
};
```

---

## 🐛 Troubleshooting

### Problem: Tests don't run
**Solution**:
```bash
mvn clean install
mvn test
```

### Problem: "Port already in use"
**Solution**: Change port in karate-config.js or use override:
```bash
mvn test -Dkarate.baseUrl=http://localhost:8080
```

### Problem: "Cannot find feature files"
**Solution**: Ensure files are in `src/test/java/` directory structure

### Problem: Test reports missing
**Solution**: Check `target/karate-reports/` after test run

---

## 📚 Feature Examples

### Example 1: GET Request
```gherkin
Feature: Fetch job listings

  Scenario: Get all jobs
    Given url baseUrl + '/normal/webapi/all'
    When method get
    Then status 200
    And match response[0].jobId == '#number'
    And print 'Retrieved ' + response.length + ' jobs'
```

### Example 2: POST Request with Validation
```gherkin
Feature: Create new job entry

  Scenario: Create job with JSON
    Given url baseUrl
    And path '/normal/webapi/add'
    And request { jobId: 1, jobTitle: 'Engineer' }
    And headers { Content-Type: 'application/json' }
    When method post
    Then status 201
    And match response.jobTitle == 'Engineer'
```

### Example 3: PUT Request
```gherkin
Feature: Update job entry

  Scenario: Update existing job
    Given url baseUrl
    And path '/normal/webapi/update'
    * def newData = { jobId: 1, jobTitle: 'Senior Engineer' }
    And request newData
    When method put
    Then status 200
    And match response.jobTitle == 'Senior Engineer'
```

---

## ✅ Verification Checklist

- [ ] Can run `mvn test` successfully
- [ ] Tests pass with dev environment
- [ ] Reports generated in target/karate-reports/
- [ ] Can switch environments with -Dkarate.env=stage
- [ ] Logs appear in target/karate.log
- [ ] IDE recognizes @Karate.Test annotations
- [ ] Can modify karate-config.js and see changes
- [ ] Feature files use baseUrl not hardcoded URLs

---

## 🆘 Need Help?

### Karate Framework Docs
- GitHub: https://github.com/karatelabs/karate
- Documentation: https://github.com/karatelabs/karate/wiki

### JUnit 5 Reference
- https://junit.org/junit5/docs/current/user-guide/

### Maven Guide
- https://maven.apache.org/guides/

---

## 📝 Next Steps

1. **Review** the updated files:
   - pom.xml (dependencies)
   - karate-config.js (configuration)
   - Feature files (test structure)

2. **Configure** for your environment:
   - Update baseUrl in karate-config.js
   - Add custom properties as needed

3. **Run** tests:
   - `mvn clean test` to verify setup
   - Check reports in target/karate-reports/

4. **Extend** with your tests:
   - Add feature files in appropriate directories
   - Use CommonCode utilities for data generation
   - Follow established patterns

5. **Integrate** with CI/CD:
   - Configure Jenkins/GitHub Actions/GitLab CI
   - Use Maven commands for automation

---

## 📋 File Checklist

### Updated Files ✅
- [x] pom.xml - Dependencies updated
- [x] karate-config.js - Enhanced configuration
- [x] TestGetRunner.java - Using @Karate.Test
- [x] TestPostRunner.java - Using @Karate.Test
- [x] PutRunner.java - Using @Karate.Test
- [x] CommonCode.java - Utility methods added
- [x] All 11 feature files - Modernized

### New Files ✅
- [x] TestRunner.java - Main test runner
- [x] README.md - Complete documentation
- [x] UPDATES_SUMMARY.md - Change summary
- [x] QUICK_START.md - This file

---

**Status**: ✅ FRAMEWORK FULLY UPDATED  
**Version**: Karate 1.5.0 + JUnit 5  
**Date**: April 1, 2026

---

*Happy Testing! 🧪*
