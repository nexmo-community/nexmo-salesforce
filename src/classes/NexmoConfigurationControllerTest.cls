@isTest
public with sharing class NexmoConfigurationControllerTest {

    public static testMethod void testController(){
        NexmoConfig__c conf = new NexmoConfig__c();
        conf.Name = 'Nexmo';
        conf.API_Key__c = '123456789';
        conf.API_Secret__c = '123456789qawsedrf123456789';
        insert conf;

        NexmoConfigurationController nexmoConfCtrl = new NexmoConfigurationController();
        System.assertEquals('123456789', nexmoConfCtrl.apiKey);
        System.assertEquals('123456789qawsedrf123456789', nexmoConfCtrl.apiSecret);
        System.assertEquals(null, nexmoConfCtrl.virtualPhoneNumber);
    }
}