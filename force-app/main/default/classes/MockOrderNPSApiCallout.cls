public with sharing class MockOrderNPSApiCallout implements HttpCalloutMock {

     // Implement the respond method to simulate the API response
     public HTTPResponse respond(HTTPRequest req) {
        // Create a new HTTP response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');

        // Simulate a successful API response with a status code of 200
        res.setStatusCode(200);
        res.setBody('{"status": "Success", "message": "API call successful"}');

        return res;
    }
    


}