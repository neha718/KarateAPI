Feature: To create entry in job application

 Scenario: To update job entry in JSON format
    Given url baseUrl
    And path '/normal/webapi/add'
    * def getRandomValue = function() { return Math.floor((100)*Math.random()); }
    * def jobId = getRandomValue()
    And request { jobId: '#(jobId)', jobTitle: 'Software Engg - 3', jobDescription: 'To develop android application', experience: ['Google', 'Apple', 'Mobile Iron', 'PWC'], project: [{ projectName: 'Movie App', technology: ['Kotlin', 'SQL Lite', 'Gradle'] }] }
    And headers { Accept: 'application/json', Content-Type: 'application/json' }
    When method post
    Then status 201
    * def responseJobId = response.jobId