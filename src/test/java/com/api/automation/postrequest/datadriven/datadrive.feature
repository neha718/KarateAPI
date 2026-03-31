Feature: To create job description

Background: Read the data ferom csv file
* def data = read('jobdata.csv')

Scenario Outline: To create  job entry in json format with method <method>
Given print '<url>'
Then print '<path>'
When print '<method>'
And print '<status>'


Examples:
| url                     |  path                | method | status |
| http://localhost:9897   | /normal/webapi/add   | post   | 201    |
| http://localhost:9897   | /normal/webapi/all   | get    | 200    |


Scenario Outline: Data driven for job decsription creation - <jobId>
Given url 'http://localhost:9897'
And path '/normal/webapi/add'
And request {"jobId":'#(jobId)',"jobTitle":'#(jobTitle)',"jobDescription":'#(jobDescription)',"experience":["Google","Apple","Mobile Iron","PWC"],"project":[{"projectName":"Movie App","technology":["Kotlin","SQL Lite","Gradle"]}]}
And headers {Accept: 'application/json', Content-Type: 'application/json'}
When method post
Then status <status>

Examples:
|jobId|jobTitle | jobDescription|status|
|2    |Software Engg - 2|To develop andriod application|201|
|jobId|Software Engg - 3|To develop andriod application|400|


Scenario Outline: Data driven for job decsription creation using CSV file - <jobId>
Given url 'http://localhost:9897'
And path '/normal/webapi/add'
And request {"jobId":'#(jobId)',"jobTitle":'#(jobTitle)',"jobDescription":'#(jobDescription)',"experience":["Google","Apple","Mobile Iron","PWC"],"project":[{"projectName":"Movie App","technology":["Kotlin","SQL Lite","Gradle"]}]}
And headers {Accept: 'application/json', Content-Type: 'application/json'}
When method post
Then status <status>

Examples:
|read('jobdata.csv')|