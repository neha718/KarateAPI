Feature: To test the updation of job entry in test application
To test the updation of job entry in test application using put request

Background: Create and initialize the base URL
Given url 'http://localhost:9897'

Scenario: To update job entry in json format
Given path '/normal/webapi/add'
* def getRandomValue = function() {return Math.floor((100)*Math.random());}
* def jobId = getRandomValue()
And request {"jobId":'#(jobId)',"jobTitle":"Software Engg - 3","jobDescription":"To develop andriod application","experience":["Google","Apple","Mobile Iron","PWC"],"project":[{"projectName":"Movie App","technology":["Kotlin","SQL Lite","Gradle"]}]}
And headers {Accept: 'application/json', Content-Type: 'application/json'}
When method post
Then status 201
Given path '/normal/webapi/update'
And request 
"""
{
    "jobId": '#(jobId)',
    "jobTitle": "Software Engg - 6",
    "jobDescription": "To develop desktop application",
    "experience": [
        "Google",
        "Apple",
        "Mobile Iron",
        "BEML"
    ],
    "project": [
        {
            "projectName": "Movie App",
            "technology": [
                "Kotlin",
                "SQL Lite",
                "Gradle"
            ]
        },
        {
            "projectName": "Movie App",
            "technology": [
                "java",
                "SQL Lite",
                "Gradle"
            ]
        }
    ]
}
"""
And headers {Accept: 'application/json', Content-Type: 'application/json'}
When method put
Then status 200
* def projectarray = karate.jsonPath(response, "$[?(@.jobId==" + jobId +")].project")
And match projectarray[0] == '#[2]'



Scenario: 404 not found
Given path '/normal/webapi/add'
* def getRandomValue = function() {return Math.floor((100)*Math.random());}
* def jobId = getRandomValue()
And request {"jobId":'#(jobId)',"jobTitle":"Software Engg - 3","jobDescription":"To develop andriod application","experience":["Google","Apple","Mobile Iron","PWC"],"project":[{"projectName":"Movie App","technology":["Kotlin","SQL Lite","Gradle"]}]}
And headers {Accept: 'application/json', Content-Type: 'application/json'}
When method post
Then status 201
Given path '/normal/webapi/update'
And request 
"""
{
    "jobId": '#(getRandomValue())',
    "jobTitle": "Software Engg - 6",
    "jobDescription": "To develop desktop application",
    "experience": [
        "Google",
        "Apple",
        "Mobile Iron",
        "BEML"
    ],
    "project": [
        {
            "projectName": "Movie App",
            "technology": [
                "Kotlin",
                "SQL Lite",
                "Gradle"
            ]
        },
        {
            "projectName": "Movie App",
            "technology": [
                "java",
                "SQL Lite",
                "Gradle"
            ]
        }
    ]
}
"""
And headers {Accept: 'application/json', Content-Type: 'application/json'}
When method put
Then status 404
