global class Nexmo {

    global static final String SMS_CHANNEL = 'sms';
    global static final String MESSENGER_CHANNEL = 'messenger';
    global static final String VIBER_CHANNEL = 'viber_service_msg';
    global static final String WHATSAPP_CHANNEL = 'whatsapp';

    global static final String API_ENDPOINT = 'https://api.nexmo.com';
    global static final String MESSAGES_API = '/v0.1/messages';

    global static void sendMessage(String toId, String fromId, String text, String channel) {
        String body = buildRequestBody(toId, fromId, text, channel);
        HttpRequest request = buildRequest(body);
        Http http = new Http();
        HTTPResponse res = http.send(request);
        System.debug(res.getBody());
    }

    public static String buildRequestBody(String toId, String fromId, String text, String channel) {
        String result = '';
        result += '{';

        if (channel == SMS_CHANNEL) {
            result += '"from": { "type": "sms", "number": "' + fromId + '" },';
            result += '"to": { "type": "sms", "number": "' + toId + '" },';
        }

        if (channel == MESSENGER_CHANNEL) {
            result += '"from": { "type": "messenger", "id": "' + fromId + '" },';
            result += '"to": { "type": "messenger", "id": "' + toId + '" },';
        }

        if (channel == VIBER_CHANNEL) {
            result += '"from": { "type": "viber_service_msg", "id": "' + fromId + '" },';
            result += '"to": { "type": "viber_service_msg", "number": "' + toId + '" },';
        }

        if (channel == WHATSAPP_CHANNEL) {
            result += '"from": { "type": "whatsapp", "number": "' + fromId + '" },';
            result += '"to": { "type": "whatsapp", "number": "' + toId + '" },';
        }

        result += '"message": {';
        result += '"content": {"type": "text", "text": "' + text + '"';
        result += '}';
        result += '}';
        result += '}';
        return result;
    }

    public static HttpRequest buildRequest(String body) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(API_ENDPOINT + MESSAGES_API);
        req.setMethod('POST');
        req.setHeader('Authorization', getAuthorizationHeader());
        req.setHeader('Content-Type', 'application/json');
        req.setBody(body);

        return req;
    }

    public static String getAuthorizationHeader() {
        String apiKey = '';
        String apiSecret = '';
        for(NexmoConfig__c conf : [SELECT API_Key__c, API_Secret__c FROM NexmoConfig__c LIMIT 1]) {
            apiKey = conf.API_Key__c;
            apiSecret = conf.API_Secret__c;
        }

        Blob headerValue = Blob.valueOf(apiKey + ':' + apiSecret);
        return 'BASIC ' + EncodingUtil.base64Encode(headerValue);
    }
}
