Feature: To validate JSON schema
To validate the JSON schema of the response

Background: Create and initialize the base URL
Given url 'http://localhost:9897'

Scenario: To create  job entry in json format and validate schema
Given path '/normal/webapi/add'
* def body = read('datapackage/JobEntry.json')
And request body
And headers {Accept: 'application/json', Content-Type: 'application/json'}
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

Scenario: complex schema validation for get end point
Given path 'normal/webapi/all'
And header Accept = 'application/json'
When method get
Then status 200
* def projectSchema = { "projectName": '#string',"technology": '#[] #string' }
* def mainSchema = {"jobId": '#number' ,"jobTitle": '#string',"jobDescription": '#string',"experience": '#[] #string',"project": '#[] #(projectSchema)' }
And match response == '#[] #(mainSchema)'

Scenario: json path where value extracted usng property
Given path 'normal/webapi/all'
And header Accept = 'application/json'
When method get
Then status 200
* def jobtitle = karate.jsonPath(response, "$[?(@.jobId==1)].jobTitle")	
* def exp = karate.jsonPath(response,"$[?(@.jobId==1)].experience")
And print "job title is: ", jobtitle
And print "experience is: ", exp