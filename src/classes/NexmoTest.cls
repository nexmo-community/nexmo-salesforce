@isTest
public with sharing class NexmoTest {

    public static testMethod void testSendMessage(){
        String smsChannel = 'sms';
        String messengerChannel = 'messenger';
        String viberChannel = 'viber_service_msg';
        String whatsappChannel = 'whatsapp';

        System.assertEquals(smsChannel, Nexmo.SMS_CHANNEL);
        System.assertEquals(messengerChannel, Nexmo.MESSENGER_CHANNEL);
        System.assertEquals(viberChannel, Nexmo.VIBER_CHANNEL);
        System.assertEquals(whatsappChannel, Nexmo.WHATSAPP_CHANNEL);

        NexmoConfig__c conf = new NexmoConfig__c();
        conf.Name = 'Nexmo';
        conf.API_Key__c = '123456789';
        conf.API_Secret__c = '123456789qawsedrf123456789';
        insert conf;

        String toId = '0123456789';
        String fromId = 'Nexmo Account';
        String text = 'Test Message';

        System.assertNotEquals(null, Nexmo.buildRequestBody(toId, fromId, text, smsChannel));
        System.assertNotEquals(null, Nexmo.buildRequestBody(toId, fromId, text, messengerChannel));
        System.assertNotEquals(null, Nexmo.buildRequestBody(toId, fromId, text, viberChannel));
        System.assertNotEquals(null, Nexmo.buildRequestBody(toId, fromId, text, whatsappChannel));

        System.assertNotEquals(null, Nexmo.getAuthorizationHeader());

        String apiKey = '';
        String apiSecret = '';
        for(NexmoConfig__c c : [SELECT API_Key__c, API_Secret__c FROM NexmoConfig__c LIMIT 1]) {
            apiKey = c.API_Key__c;
            apiSecret = c.API_Secret__c;
        }

        Blob headerValue = Blob.valueOf(apiKey + ':' + apiSecret);
        String authorizationheader =  'BASIC ' + EncodingUtil.base64Encode(headerValue);

        System.assertEquals(authorizationheader, Nexmo.getAuthorizationHeader());
        System.assertNotEquals(null, Nexmo.buildRequest('Test Body'));
    }
}