Feature: To test the updation of job entry in test application
  To test the updation of job entry in test application using PUT request

  Background: Create and initialize the base URL
    Given url baseUrl

  Scenario: To update job entry in JSON format
    Given path '/normal/webapi/add'
    * def getRandomValue = function() { return Math.floor((100)*Math.random()); }
    * def jobId = getRandomValue()
    And request { jobId: '#(jobId)', jobTitle: 'Software Engg - 3', jobDescription: 'To develop android application', experience: ['Google', 'Apple', 'Mobile Iron', 'PWC'], project: [{ projectName: 'Movie App', technology: ['Kotlin', 'SQL Lite', 'Gradle'] }] }
    And headers { Accept: 'application/json', Content-Type: 'application/json' }
    When method post
    Then status 201
    
    Given path '/normal/webapi/update'
    * def updatePayload = { jobId: '#(jobId)', jobTitle: 'Software Engg - 6', jobDescription: 'To develop desktop application', experience: ['Google', 'Apple', 'Mobile Iron', 'BEML'], project: [{ projectName: 'Movie App', technology: ['Kotlin', 'SQL Lite', 'Gradle'] }, { projectName: 'Movie App', technology: ['java', 'SQL Lite', 'Gradle'] }] }
    And request updatePayload
    And headers { Accept: 'application/json', Content-Type: 'application/json' }
    When method put
    Then status 200
    * def projectarray = karate.jsonPath(response, "$[?(@.jobId==" + jobId +")].project")
    And match projectarray[0] == '#[2]'

  Scenario: 404 not found
    Given path '/normal/webapi/add'
    * def getRandomValue = function() { return Math.floor((100)*Math.random()); }
    * def jobId = getRandomValue()
    And request { jobId: '#(jobId)', jobTitle: 'Software Engg - 3', jobDescription: 'To develop android application', experience: ['Google', 'Apple', 'Mobile Iron', 'PWC'], project: [{ projectName: 'Movie App', technology: ['Kotlin', 'SQL Lite', 'Gradle'] }] }
    And headers { Accept: 'application/json', Content-Type: 'application/json' }
    When method post
    Then status 201
    
    Given path '/normal/webapi/update'
    * def invalidJobId = -(Math.floor((1000)*Math.random()) + 1000)
    And request { jobId: '#(invalidJobId)', jobTitle: 'Software Engg - 6', jobDescription: 'To develop desktop application', experience: ['Google', 'Apple', 'Mobile Iron', 'BEML'], project: [{ projectName: 'Movie App', technology: ['Kotlin', 'SQL Lite', 'Gradle'] }, { projectName: 'Movie App', technology: ['java', 'SQL Lite', 'Gradle'] }] }
    And headers { Accept: 'application/json', Content-Type: 'application/json' }
    When method put
    Then status 404
    
     Scenario: To update job entry in JSON format
    #<Gherkin keyword> <call> <read(<file path>)>
    Given call read("../createJobentry.feature") 
    Given path '/normal/webapi/update'
    * def updatePayload = { jobId: '#(jobId)', jobTitle: 'Software Engg - 6', jobDescription: 'To develop desktop application', experience: ['Google', 'Apple', 'Mobile Iron', 'BEML'], project: [{ projectName: 'Movie App', technology: ['Kotlin', 'SQL Lite', 'Gradle'] }, { projectName: 'Movie App', technology: ['java', 'SQL Lite', 'Gradle'] }] }
    And request updatePayload
    And headers { Accept: 'application/json', Content-Type: 'application/json' }
    When method put
    Then status 200
    * def projectarray = karate.jsonPath(response, "$[?(@.jobId==" + jobId +")].project")
    And match projectarray[0] == '#[2]'
    
    
    
      Scenario: To update job entry in JSON format by calling another feature file
    #<Gherkin keyword> <call> <read(<file path>)>
    #Given call read("../createJobentry.feature") 
    * def createJobEntry = call read("../createJobentry.feature")
    And print "Created Job ID: " + createJobEntry.jobId
    And print "JS function result: " + createJobEntry.getRandomValue()
    Given path '/normal/webapi/update'
    * def updatePayload = { jobId: '#(createJobEntry.jobId)', jobTitle: 'Software Engg - 6', jobDescription: 'To develop desktop application', experience: ['Google', 'Apple', 'Mobile Iron', 'BEML'], project: [{ projectName: 'Movie App', technology: ['Kotlin', 'SQL Lite', 'Gradle'] }, { projectName: 'Movie App', technology: ['java', 'SQL Lite', 'Gradle'] }] }
    And request updatePayload
    And headers { Accept: 'application/json', Content-Type: 'application/json' }
    When method put
    Then status 200
    * def projectarray = karate.jsonPath(response, "$[?(@.jobId==" + createJobEntry.jobId +")].project")
    And match projectarray[0] == '#[2]'
    
    
    Scenario: To update job entry in JSON format by calling another feature file
    #<Gherkin keyword> <call> <read(<file path>)>
    #Given call read("../createJobentry.feature") {var1:value , var: value}
    * def getRandomValue = function() { return Math.floor((100)*Math.random()); }
    * def jobId = getRandomValue()
    * def createJobEntry = call read("../createJobentrywithvariables.feature") {_baseUrl: 'http://localhost:9897', _path: '/normal/webapi/add', _jobId: '#(jobId)'}
    
   