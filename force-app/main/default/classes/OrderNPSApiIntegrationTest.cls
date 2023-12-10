@isTest
public with sharing class OrderNPSApiIntegrationTest {
    
    @isTest
    static void testSendOrderToApi() {


        // Create an Account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Create a Contact associated with the Account
        Contact testContact = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            Email = 'johndoe@example.com',
            AccountId = testAccount.Id
        );
        insert testContact;

        

        // Create a test Order
        Order testOrder = new Order(
            ShipToContactId = testContact.id,
            AccountId = testAccount.id,
            EffectiveDate = Date.today().addDays(1),
            Status= 'Draft'    

        );
        insert testOrder;

        // Create a mock HTTP callout
        Test.setMock(HttpCalloutMock.class, new MockOrderNPSApiCallout());

        // Create input variables for the Flow
        List<OrderNPSApiIntegration.InputVariables> inputParameters = new List<OrderNPSApiIntegration.InputVariables>();
        OrderNPSApiIntegration.InputVariables inputVariable = new OrderNPSApiIntegration.InputVariables();
        inputVariable.orderId = testOrder.Id;
        inputParameters.add(inputVariable);

        // Call the Flow's invocable method
        Test.startTest();
        List<OrderNPSApiIntegration.OutputVariables> results = OrderNPSApiIntegration.sendOrderToApi(inputParameters);
        Test.stopTest();

        // Assertions
        System.assertEquals(1, results.size());
        OrderNPSApiIntegration.OutputVariables result = results[0];
        System.assertEquals(null, result.errorMessage); // No error message indicates success

        // Query the updated Order to verify changes
        Order updatedOrder = [SELECT Id, NPS_API_SENT__c, NPS_API_Status_Code__c FROM Order WHERE Id = :testOrder.Id];
        System.assertEquals(true, updatedOrder.NPS_API_SENT__c);
        System.assertEquals('200', updatedOrder.NPS_API_Status_Code__c);
    }


}