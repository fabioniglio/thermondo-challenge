public with sharing class OrderNpsApiService {
    // Constants for authentication
    private static final String USERNAME = 'tmondo';
    private static final String PASSWORD = 'Noy84LRpYvMZuETB';
    private static final String API_URL = 'https://salesforce-coding-challenge.herokuapp.com/orders';

    public static HttpResponse sendOrder(Order order) {
        // Create the JSON payload
        Map<String, Object> payload = new Map<String, Object>();
        payload.put('sfId', order.Id);
        payload.put('orderNumber', order.OrderNumber);
        payload.put('customerEmail', order.ShipToContact.Email);
        
        // Convert payload to JSON and set up request
        HttpRequest httpRequest = setupRequest(JSON.serialize(payload));
        
        // Create an HTTP client and send the request
        Http http = new Http();
        try {
            return http.send(httpRequest);
        } catch (Exception e) {
            // You can choose to handle exceptions differently or just rethrow them
            throw e;
        }
    }

    private static HttpRequest setupRequest(String jsonPayload) {
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint(API_URL);
        httpRequest.setMethod('POST'); // Change as needed
        httpRequest.setHeader('Content-Type', 'application/json');
        httpRequest.setHeader('Accept', '*/*');
        Blob headerValue = Blob.valueOf(USERNAME + ':' + PASSWORD);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        httpRequest.setHeader('Authorization', authorizationHeader);
        httpRequest.setBody(jsonPayload);

        return httpRequest;
    }
}