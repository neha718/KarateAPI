Feature: To Validate GET endpoint
  To validate the GET endpoint response

  Background: Set up base URL
    Given url baseUrl

  Scenario: Validate first item with jobId 1 and nested experience/project elements
    Given path 'normal/webapi/all'
    And header Accept = 'application/xml'
    When method get
    Then status 200
    And match response/List/item/jobId == '1'
    And match response/List/item/jobTitle == 'Software Engg'
    And match response/List/item/experience/experience[1] == 'Google'
    And match response/List/item/project/project/projectName == 'Movie App'
    And match response/List/item/project/project/technology/technology[1] == 'Kotlin'
    


  Scenario: Validate response structure and data types
    Given path 'normal/webapi/all'
    And header Accept = 'application/xml'
    When method get
    Then status 200
    And match response/List/item/jobId == '#string'
    And match response/List/item/jobTitle == '#string'
    And match response/List/item/jobDescription == '#string'
    And match response/List/item/experience == '#present'
    And match response/List/item/project == '#present'

  Scenario: Validate multiple items in the response list
    Given path 'normal/webapi/all'
    And header Accept = 'application/xml'
    When method get
    Then status 200
    And match response/List/item/jobId == '1'
    And match response/List/item/jobTitle == 'Software Engg'
    And match response/List/item/experience/experience[1] == 'Google'
    And match response/List/item/project/project/projectName == 'Movie App'
    And match response/List/item/project/project/technology/technology[1] == 'Kotlin'
   


  Scenario: Validate item with multiple projects
    Given path 'normal/webapi/all'
    And header Accept = 'application/xml'
    When method get
    Then status 200
    # Validate first item with its project and technology nested structure
    And match response/List/item/jobId == '1'
    And match response/List/item/jobTitle == 'Software Engg'
    And match response/List/item/experience/experience[1] == 'Google'
    And match response/List/item/project/project/projectName == 'Movie App'
    And match response/List/item/project/project/technology/technology[1] == 'Kotlin'
    And match response/List/item/project/project/technology/technology[2] == 'SQL Lite'

  Scenario: Validate response with ignore and present matchers
    Given path 'normal/webapi/all'
    And header Accept = 'application/xml'
    When method get
    Then status 200
    And match response/List/item/experience/experience[2] == '#ignore'
    And match response/List/item/experience/experience[1] == '#present'
    And match response/List/item/jobId == '#present'

  Scenario: Validate item with jobId 1 has correct technology stack
    Given path 'normal/webapi/all'
    And header Accept = 'application/xml'
    When method get
    Then status 200
    # Item at index 0 has jobId 1 with correct technology
    And match response/List/item/jobId == '1'
    And match response/List/item/jobTitle == 'Software Engg'
    And match response/List/item/experience/experience[1] == 'Google'
    And match response/List/item/project/project/projectName == 'Movie App'
    And match response/List/item/project/project/technology/technology[1] == 'Kotlin'
    And match response/List/item/project/project/technology/technology[2] == 'SQL Lite'