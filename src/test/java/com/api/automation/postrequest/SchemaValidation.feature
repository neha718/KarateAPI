Feature: To validate JSON schema
  To validate the JSON schema of the response

  Background: Create and initialize the base URL
    Given url baseUrl

  Scenario: To create job entry in JSON format and validate schema
    Given path '/normal/webapi/add'
    * def body = read('datapackage/JobEntry.json')
    And request body
    And headers { Accept: 'application/json', Content-Type: 'application/json' }
    When method post
    Then status 201
    And match response ==
    """
    {
      "jobId": '#number',
      "jobTitle": '#string',
      "jobDescription": '#string',
      "experience": '#[] #string',
      "project": '#[] #object'
    }
    """

  Scenario: Complex schema validation for GET endpoint
    Given path 'normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    * def projectSchema = { "projectName": '#string', "technology": '#[] #string' }
    * def mainSchema = { "jobId": '#number', "jobTitle": '#string', "jobDescription": '#string', "experience": '#[] #string', "project": '#[] #(projectSchema)' }
    And match response == '#[] #(mainSchema)'

  Scenario: JSON path where value extracted using property
    Given path 'normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    * def jobTitle = karate.jsonPath(response, "$[?(@.jobId==1)].jobTitle")
    * def exp = karate.jsonPath(response, "$[?(@.jobId==1)].experience")
    And print "Job title is: ", jobTitle
    And print "Experience is: ", exp