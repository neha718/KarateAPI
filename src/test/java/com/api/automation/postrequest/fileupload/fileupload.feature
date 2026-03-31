Feature: file upload  using karate framework

Background:Create and initialize the base URL
Given url 'http://localhost:9897'

Scenario: To upload file using multipart form data
Given path '/normal/webapi/upload'
And multipart file file = { read: 'fileupload.txt', filename: 'fileupload.txt', contentType: 'multipart/formdata' }
When method post
Then status 200
And print response

Scenario: To upload file using multipart form data
Given path '/normal/webapi/upload'
And def filelocation = '../datapackage/JobEntry.json'
And multipart file file = { read: '#(filelocation)', filename: 'JobEntry.json', contentType: 'multipart/formdata' }
When method post
Then status 200
And print response
And match response.message contains 'JobEntry.json'