Feature: To Validate AGET enpoint 
To validate the GET endpoint response

Background: Set up base URL
Given url 'http://localhost:9897'

Scenario: To get the data in JSON format and validate XML response contents
Given path 'normal/webapi/all'
And header Accept = 'application/xml'
When method get
Then status 200
And match response/List/item/jobId == '1'
And match response/List/item/experience/experience[1] == 'Google'
And match response/List/item/project/project/technology/technology[3] == 'Gradle'
#skip the response keyword
And match /List/item/experience/experience[2] == 'Apple'
#traverse the xml similar to json and validate the value and index starts from 0
And match response.List.item.experience.experience[1] == 'Apple'