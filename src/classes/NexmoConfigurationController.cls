public with sharing class NexmoConfigurationController {

    public String apiKey { get; set; }
    public String apiSecret { get; set; }
    public String virtualPhoneNumber { get; set; }

    public NexmoConfigurationController() {
        for(NexmoConfig__c conf : [SELECT API_Key__c, API_Secret__c, Virtual_Phone_Number__c FROM NexmoConfig__c LIMIT 1]) {
            apiKey = conf.API_Key__c;
            apiSecret = conf.API_Secret__c;
            virtualPhoneNumber = conf.Virtual_Phone_Number__c;
        }
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
            for(NexmoConfig__c c : [SELECT Id, Name, API_Key__c, API_Secret__c, Virtual_Phone_Number__c FROM NexmoConfig__c LIMIT 1]) {
                conf = c;
            }
            conf.Name = 'Nexmo';
            conf.API_Key__c = apiKey;
            conf.API_Secret__c = apiSecret;
            conf.Virtual_Phone_Number__c = virtualNumber;
            upsert conf;

            return true;
        }
    }
}