Feature: To Validate GET enpoint 
To validate the GET endpoint response

Background: Set up base URL
Given url 'http://localhost:9897'

Scenario: To get the data in JSON format and validate XML response contents
Given path 'normal/webapi/all'
And header Accept = 'application/xml'
When method get
Then status 200
And match response/List/item/jobId == '#notnull'
And match response/List/item/experience/experience[1] == '#notnull'
And match response/List/item/project/project/technology/technology[3] == '#string'
#skip the response keyword
And match /List/item/experience/experience[2] == '#ignore'
#traverse the xml similar to json and validate the value and index starts from 0
And match response.List.item.experience.experience[1] == '#present'
And match response/List/item/jobTitle == '#string? _.length == 13'