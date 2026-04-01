# Karate Framework - Visual Architecture Guide

## 🏗️ Project Architecture

```
┌─────────────────────────────────────────────────────────────┐
│           KARATE FRAMEWORK PROJECT STRUCTURE                │
└─────────────────────────────────────────────────────────────┘

karateframework/
│
├── 📄 pom.xml
│   └─ Maven configuration
│      • Karate 1.5.0
│      • JUnit 5.9.3
│      • Maven plugins (Surefire, Failsafe)
│
├── 📄 README.md ⭐ NEW
│   └─ Complete project documentation
│
├── 📄 UPDATES_SUMMARY.md ⭐ NEW
│   └─ Detailed change summary
│
├── 📄 QUICK_START.md ⭐ NEW
│   └─ Quick implementation guide
│
└── src/test/java/
    └── com/api/automation/
        │
        ├── 📄 karate-config.js ⭐ ENHANCED
        │   ├─ Dev environment: localhost:9897
        │   ├─ Stage environment: stage-server:9897
        │   └─ Prod environment: prod-server:9897
        │
        ├── 📄 logback-test.xml
        │   ├─ Console logging
        │   └─ File logging (target/karate.log)
        │
        ├── 📄 CommonCode.java ⭐ ENHANCED
        │   ├─ getRandomInt()
        │   ├─ generateUUID()
        │   ├─ generateRandomString()
        │   ├─ generateRandomEmail()
        │   └─ waitFor()
        │
        ├── 📄 TestRunner.java ⭐ NEW
        │   ├─ runAllTests() - Execute all feature files
        │   ├─ runGetTests() - Execute GET tests only
        │   ├─ runPostTests() - Execute POST tests only
        │   └─ runPutTests() - Execute PUT tests only
        │
        ├── 📄 JsonResponse.json
        ├── 📄 XMLResponse.xml
        │
        ├── 📁 getrequest/ ⭐ MODERNIZED
        │   ├── TestGetRunner.java (using @Karate.Test)
        │   ├── getRequest.feature
        │   ├── responseMatcher.feature
        │   ├── validateJSONArray.feature
        │   ├── validateXMLResponse.feature
        │   ├── validateJSONwithFuzzy.feature
        │   ├── validateXMLwithFuzzy.feature
        │   ├── validationUsingFile.feature
        │   └── Variable.feature
        │
        ├── 📁 postrequest/ ⭐ MODERNIZED
        │   ├── TestPostRunner.java (using @Karate.Test)
        │   ├── CreateJobEntry.feature
        │   ├── SchemaValidation.feature
        │   └── datapackage/
        │       └── JobEntry.json
        │
        └── 📁 putrequest/ ⭐ MODERNIZED
            ├── PutRunner.java (using @Karate.Test)
            └── jobupdate.feature
```

---

## 🔄 Test Execution Flow

```
┌────────────────────────────────────────┐
│         START: Run Tests               │
│   mvn test -Dkarate.env=<env>         │
└────────────────────────────────────────┘
                  ↓
┌────────────────────────────────────────┐
│  Load karate-config.js                 │
│  • Read environment property            │
│  • Set baseUrl based on environment     │
│  • Configure logging level              │
└────────────────────────────────────────┘
                  ↓
┌────────────────────────────────────────┐
│  Discover and Run Test Classes         │
│  • TestGetRunner                        │
│  • TestPostRunner                       │
│  • PutRunner                            │
│  • TestRunner (optional)                │
└────────────────────────────────────────┘
                  ↓
        ┌────────┴────────┐
        ↓                 ↓
   ┌─────────────┐  ┌─────────────┐
   │ GET Tests   │  │ POST Tests  │
   ├─────────────┤  ├─────────────┤
   │ 8 scenarios │  │ 3 scenarios │
   └─────────────┘  └─────────────┘
        ↓                 ↓
   ┌─────────────────────────────┐
   │  Execute Each Feature File  │
   │  • Load configuration        │
   │  • Execute scenarios         │
   │  • Validate responses        │
   │  • Collect results           │
   └─────────────────────────────┘
                  ↓
   ┌──────────────────────────────────┐
   │  Generate Reports & Logs         │
   │  • HTML reports (target/...)     │
   │  • Karate.log (target/...)       │
   │  • Console output                │
   └──────────────────────────────────┘
                  ↓
┌────────────────────────────────────────┐
│         TEST EXECUTION COMPLETE        │
│  Check results in target/ directory    │
└────────────────────────────────────────┘
```

---

## 🎭 Test Organization

```
┌──────────────────────────────────────────────────────────┐
│            KARATE TEST HIERARCHY                         │
└──────────────────────────────────────────────────────────┘

TestRunner (Main Orchestrator)
├── runAllTests()
│   └─ Executes ALL feature files
│      ├─ getrequest/
│      ├─ postrequest/
│      └─ putrequest/
│
├── runGetTests()
│   └─ Executes ONLY getrequest/
│      ├─ getRequest.feature (scenarios)
│      ├─ responseMatcher.feature (scenarios)
│      ├─ validateJSONArray.feature (scenarios)
│      ├─ validateXMLResponse.feature (scenarios)
│      ├─ validateJSONwithFuzzy.feature (scenarios)
│      ├─ validateXMLwithFuzzy.feature (scenarios)
│      ├─ validationUsingFile.feature (scenarios)
│      └─ Variable.feature (scenarios)
│
├── runPostTests()
│   └─ Executes ONLY postrequest/
│      ├─ CreateJobEntry.feature (2 scenarios)
│      └─ SchemaValidation.feature (3 scenarios)
│
└── runPutTests()
    └─ Executes ONLY putrequest/
       └─ jobupdate.feature (2 scenarios)
```

---

## 📊 Configuration Hierarchy

```
┌─────────────────────────────────────────────────┐
│     CONFIGURATION PRIORITY & INHERITANCE        │
└─────────────────────────────────────────────────┘

PRIORITY ORDER (Highest to Lowest):
  1️⃣  Command Line Arguments
      mvn test -Dkarate.env=stage

  2️⃣  System Properties
      System.setProperty("karate.env", "prod")

  3️⃣  karate-config.js
      var config = {
        baseUrl: 'http://localhost:9897',
        ...
      }

  4️⃣  Default Values
      env = 'dev'
      logLevel = 'info'

┌─────────────────────────────────────────────────┐
│      AVAILABLE ENVIRONMENTS                     │
└─────────────────────────────────────────────────┘

dev      → http://localhost:9897      (Development)
stage    → http://stage-server:9897   (Staging)
prod     → http://prod-server:9897    (Production)

Usage: mvn test -Dkarate.env=stage
```

---

## 🧪 Feature File Structure

```
┌──────────────────────────────────────────────────────┐
│         TYPICAL FEATURE FILE LAYOUT                 │
└──────────────────────────────────────────────────────┘

Feature: Description of what is being tested
  Long description of the feature

  Background: Common setup for all scenarios
    Given url baseUrl
    And headers { Content-Type: 'application/json' }

  Scenario: First test scenario
    Given path '/endpoint'
    When method get
    Then status 200
    And match response.field == value
    
  Scenario: Second test scenario
    Given path '/another-endpoint'
    When method post
    Then status 201
    And print response

┌──────────────────────────────────────────────────────┐
│       KARATE KEYWORDS & THEIR MEANING               │
└──────────────────────────────────────────────────────┘

Given   → Setup/precondition (e.g., url, headers)
When    → Action/request (e.g., method get, post)
Then    → Assertion/validation (e.g., status, match)
And     → Additional step in same context
*       → JavaScript execution (e.g., * def var = value)
```

---

## 🚀 Running Tests - Command Cheat Sheet

```
┌────────────────────────────────────────────────────────┐
│         MAVEN COMMANDS FOR TEST EXECUTION              │
└────────────────────────────────────────────────────────┘

Build & Test All
  mvn clean test

Test Specific Runner
  mvn test -Dtest=TestGetRunner
  mvn test -Dtest=TestPostRunner
  mvn test -Dtest=PutRunner

Test with Environment
  mvn test -Dkarate.env=dev
  mvn test -Dkarate.env=stage
  mvn test -Dkarate.env=prod

Combined
  mvn test -Dtest=TestGetRunner -Dkarate.env=stage

Debug Mode
  mvn test -X

Skip Tests
  mvn clean package -DskipTests

View Help
  mvn --help

┌────────────────────────────────────────────────────────┐
│         WHERE TO FIND TEST OUTPUTS                    │
└────────────────────────────────────────────────────────┘

HTML Reports
  target/karate-reports/
  └─ index.html

Log Files
  target/karate.log

Test Output
  target/test-classes/

Maven Reports
  target/surefire-reports/
```

---

## 🎯 Utility Methods Quick Reference

```
CommonCode Utility Methods:

┌─────────────────────────────────────────┐
│    Data Generation Methods              │
└─────────────────────────────────────────┘

getRandomInt(int max)
  → Returns random number 0 to max-1
  Example: CommonCode.getRandomInt(100)

getRandomInt(int min, int max)
  → Returns random number min to max-1
  Example: CommonCode.getRandomInt(10, 100)

generateUUID()
  → Returns unique identifier
  Example: CommonCode.generateUUID()
           Result: "550e8400-e29b-41d4-a716-446655440000"

generateRandomString(int length)
  → Returns random alphanumeric string
  Example: CommonCode.generateRandomString(10)
           Result: "aBcDeF1234"

generateRandomEmail()
  → Returns random email address
  Example: CommonCode.generateRandomEmail()
           Result: "test_xyz123@example.com"

┌─────────────────────────────────────────┐
│    Control Flow Methods                 │
└─────────────────────────────────────────┘

waitFor(long milliseconds)
  → Pause test execution
  Example: CommonCode.waitFor(1000) // 1 second

┌─────────────────────────────────────────┐
│    Usage in Feature Files               │
└─────────────────────────────────────────┘

* def randomId = CommonCode.getRandomInt(1000)
* def email = CommonCode.generateRandomEmail()
* def testId = CommonCode.generateUUID()

Given request { id: '#(randomId)', email: '#(email)' }
```

---

## 📈 Test Reporting

```
┌────────────────────────────────────────────────────┐
│       TEST REPORT GENERATION & LOCATION            │
└────────────────────────────────────────────────────┘

After running: mvn test

Reports Generated:
├── HTML Report
│   └─ target/karate-reports/index.html
│      • Overall statistics
│      • Scenario results
│      • Request/Response details
│      • Failure analysis
│
├── Log File
│   └─ target/karate.log
│      • DEBUG information
│      • Request/Response bodies
│      • Assertions
│      • Timing information
│
└── Maven Report
    └─ target/surefire-reports/
       • JUnit XML format
       • Summary statistics

┌────────────────────────────────────────────────────┐
│       WHAT EACH REPORT SHOWS                       │
└────────────────────────────────────────────────────┘

HTML Report (index.html)
  ✓ Summary statistics
  ✓ Feature file results
  ✓ Scenario details
  ✓ Request/Response body
  ✓ Timing metrics
  ✓ Error messages

Karate.log
  ✓ Complete execution trace
  ✓ Variable values
  ✓ Request details
  ✓ Response details
  ✓ Timing data

Maven Report
  ✓ Test count
  ✓ Success rate
  ✓ Failure details
  ✓ CI/CD integration
```

---

## 🔍 Dependency Versions

```
┌─────────────────────────────────────────┐
│       PROJECT DEPENDENCIES              │
└─────────────────────────────────────────┘

Core Framework:
  • Karate: 1.5.0 ✅ UPDATED
  • Karate Core: 1.5.0
  • Karate JUnit5: 1.5.0

Testing Framework:
  • JUnit Jupiter: 5.9.3 ✅ NEW
  • JUnit API: 5.9.3 ✅ NEW
  • JUnit Engine: 5.9.3 ✅ NEW

Build Tools:
  • Maven Compiler: 3.11.0
  • Maven Surefire: 3.0.0
  • Maven Failsafe: 3.0.0 ✅ NEW

Java Version: 11+ (Required)

Encoding: UTF-8
```

---

## ✨ Key Improvements Visualized

```
┌──────────────────────────────────────────────────────────┐
│          BEFORE vs AFTER COMPARISON                      │
└──────────────────────────────────────────────────────────┘

DEPENDENCIES:
  Before: Karate 1.4.1, No JUnit 5
  After:  Karate 1.5.0, JUnit 5.9.3 ✅

TEST ANNOTATIONS:
  Before: @Test (deprecated)
  After:  @Karate.Test ✅

CONFIGURATION:
  Before: Hard-coded URLs in features
  After:  Dynamic baseUrl from config ✅

TEST RUNNERS:
  Before: 3 separate runners
  After:  4 runners with main orchestrator ✅

UTILITIES:
  Before: Empty CommonCode.java
  After:  6 utility methods ✅

DOCUMENTATION:
  Before: None
  After:  3 comprehensive guides ✅

FEATURE FILES:
  Before: Inconsistent formatting
  After:  Modernized & standardized ✅
```

---

**Visual Guide Complete** ✅

*Use this guide to understand the architecture and organization of your Karate framework.*
