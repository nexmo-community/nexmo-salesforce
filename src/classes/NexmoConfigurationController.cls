public with sharing class NexmoConfigurationController {

    public String apiKey { get; set; }
    public String apiSecret { get; set; }
    public String virtualPhoneNumber { get; set; }

    public NexmoConfigurationController() {
        NexmoConfig__c conf = NexmoConfig__c.getAll().values()[0]; 
            apiKey = conf.API_Key__c;
            apiSecret = conf.API_Secret__c;
            virtualPhoneNumber = conf.Virtual_Phone_Number__c;
    }

    @RemoteAction
    public static Boolean validateCredentials(String apiKey, String apiSecret, String virtualNumber) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(Nexmo.API_ENDPOINT + Nexmo.MESSAGES_API);
        req.setMethod('POST');
        Blob authorization = Blob.valueOf(apiKey + ':' + apiSecret);
        req.setHeader('Authorization', 'BASIC ' + EncodingUtil.base64Encode(authorization));
        req.setHeader('Content-Type', 'application/json');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        if (res.getStatus() == 'Unauthorized') {
            return false;
        } else {
            NexmoConfig__c conf = new NexmoConfig__c();
            conf = NexmoConfig__c.getAll().values()[0]; 
            conf.Name = 'Nexmo';
            conf.API_Key__c = apiKey;
            conf.API_Secret__c = apiSecret;
            conf.Virtual_Phone_Number__c = virtualNumber;
            upsert conf;

            return true;
        }
    }
}