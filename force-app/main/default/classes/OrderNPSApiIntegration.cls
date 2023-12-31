public with sharing class OrderNPSApiIntegration {
    
    public static final String USERNAME = 'tmondo';
    public static final String PASSWORD = 'Noy84LRpYvMZuETB';

    // Input parameter for the Order Id
    public class InputVariables {
        @InvocableVariable(label='Order Id' required=true)
        public String orderId;
    }

    // Define the output variables
    public class OutputVariables {   
        @InvocableVariable(label='Error Message')
        public String errorMessage;
    }

    @InvocableMethod(label='Send Order to API')
    public static List<OutputVariables> sendOrderToApi(List<InputVariables> inputParameters) {
        List<OutputVariables> results = new List<OutputVariables>();
        OutputVariables result = new OutputVariables();

        // Check if inputParameters is not empty and contains an Order Id
        if (inputParameters != null && inputParameters.size() > 0) {
            String orderId = inputParameters[0].orderId;
            
            // Query the Order to find the Order Number and any other required information
            Order order = [SELECT Id, OrderNumber, ShipToContact.Email, NPS_API_SENT__c, NPS_API_Status_Code__c FROM Order WHERE Id = :orderId LIMIT 1];
            
            if (order != null && !order.NPS_API_SENT__c) {
                
                
                try {
                    // Send the HTTP request and get the response
                    HttpResponse httpResponse = OrderNpsApiService.sendOrder(order);
                    
                    // Handle the API response as needed
                    if (httpResponse.getStatusCode() == 200) {
                        // Successful API call
                        System.debug('API Response: ' + httpResponse.getBody());
                        order.NPS_API_SENT__c = true;
                        order.NPS_API_Status_Code__c = String.valueOf(httpResponse.getStatusCode());

                        result.errorMessage = null;
                        results.add(result);    
                    } else {
                        // Handle API errors here
                        System.debug('API Request Failed with Status Code: ' + httpResponse.getStatusCode());
                        System.debug('API Response: ' + httpResponse.getBody());
                        order.NPS_API_Status_Code__c = String.valueOf(httpResponse.getStatusCode());

                        result.errorMessage = String.valueOf(httpResponse.getStatusCode());
                        results.add(result);
                    }

                    Database.update(order, true);
                    
                } catch (Exception e) {
                    // Handle any exceptions that occur during the request
                    System.debug('API Request Exception: ' + e.getMessage());
                    result.errorMessage = 'API Request Exception: ' + e.getMessage();
                    results.add(result);
                }
            } else {
                // Handle the case when the Order is not found
                System.debug('Order not found with Id: ' + orderId);
                result.errorMessage = 'Order not found with Id: ' + orderId;
                results.add(result);
            }
        } else {
            // Handle the case when inputParameters is empty
            System.debug('Order Id parameters not provided');
            result.errorMessage = 'Order Id parameters not provided';
            results.add(result);
        }

        return results;
    }
}