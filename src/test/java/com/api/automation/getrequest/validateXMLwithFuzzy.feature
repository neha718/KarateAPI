Feature: To Validate GET endpoint
  To validate the GET endpoint response

  Background: Set up base URL
    Given url baseUrl

  Scenario: To get the data in JSON format and validate XML response contents
    Given path 'normal/webapi/all'
    And header Accept = 'application/xml'
    When method get
    Then status 200
    And match response/List/item/jobId == '1'
    And match response/List/item/experience/experience[1] == 'Google'
    And match response/List/item/project/project/technology/technology[2] == 'SQL Lite'
    
    # Skip the response keyword
    And match /List/item/experience/experience[2] == '#ignore'
    
    # Traverse the XML similar to JSON and validate the value (index starts from 0)
    And match response/List/item/experience/experience[1] == '#present'
    And match response/List/item/jobTitle == 'Software Engg'