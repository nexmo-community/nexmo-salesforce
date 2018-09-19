# Nexmo Helper Library for Salesforce


Installation
============

We've made it easy to get started. Just grab the code from GitHub and deploy it to your Salesforce org with the included Ant script.


If you have a previous version of Nexmo-Salesforce library installed, you will need to use Ant to install/update:


1. Checkout or download the [nexmo-salesforce](https://github.com/mhrycenk/nexmo-salesforce) library from GitHub.

    ```bash
    $ git clone git@github.com:mhrycenk/nexmo-salesforce.git
    ```

1. Install the [Force.com Migration Tool](http://www.salesforce.com/us/developer/docs/daas/Content/forcemigrationtool_install.htm) plugin for Ant, if you don't already have it.

1. Edit `install/build.properties` to insert your Salesforce username and password.  Since you will be using the API to access Salesforce, remember to [append your Security Token](http://www.salesforce.com/us/developer/docs/api/Content/sforce_api_concepts_security.htm#topic-title_login_token) to your password.

1. Open your command line to the `install` folder, then deploy using Ant:

    ```bash
    $ ant deployNexmo
    ```

Now all the library code is in your org and you're ready to start coding!



Quickstart
==========

Getting started with the Nexmo API couldn't be easier.

Connection configuration
-----------

1. Use or create Nexmo account. Your API key and secret can be found and updated under the "API settings" section on the [Settings](https://dashboard.nexmo.com/settings) page in the Nexmo Dashboard.
1. Go to Nexmo Configuration tab in Salesforce and validate your credentials.

![Nexmo Salesforce Conguration](https://raw.githubusercontent.com/mhrycenk/nexmo-salesforce/master/docs/nexmo_config.jpg)


Send an SMS message with the Messages API
-----------
Key | Description
------------ | -------------
**TO_NUMBER** | The phone number you are sending the message to.
**FROM_NUMBER** | The phone number you are sending the message from.


NOTE: Don't use a leading '+' or '00' when entering a phone number, start with the country code, for example 447700900000.


```javascript
String toNumber = 'XXXXXXXXXX';
String fromNumber = 'YYYYYYYYYY';
String text = 'Test message';
String channel = 'sms'

Nexmo.sendMessage(toNumber, fromNumber, text, channel);
```


Send a Facebook message with the Messages API
-----------
Key | Description
------------ | -------------
**RECIPIENT_ID** | The PSID of the user you want to reply to. The 'RECIPIENT_ID' is the PSID of the Facebook User you are messaging. This value is the 'from.id' value you received in the inbound messenger event on your Inbound Message Webhook URL.
**SENDER_ID** | Your Page ID. The 'SENDER_ID' is the same as the 'to.id' value you received in the inbound messenger event on your Inbound Message Webhook URL.


```javascript
String recipientId = 'XXXXXXXXXX';
String senderId = 'YYYYYYYYYY';
String text = 'Test message';
String channel = 'messenger'

Nexmo.sendMessage(recipientId, senderId, text, channel);
```

Send a Viber message with the Messages API
-----------
Key | Description
------------ | -------------
**TO_NUMBER** | The phone number you are sending the message to.
**VIBER_SERVICE_MESSAGE_ID** | Your Viber Service Message ID.


```javascript
String toNumber = 'XXXXXXXXXX';
String viberId = 'YYYYYYYYYY';
String text = 'Test message';
String channel = 'viber_service_msg'

Nexmo.sendMessage(toId, viberId, text, channel);
```

Send a WhatsApp message with the Messages API
-----------
Key | Description
------------ | -------------
**TO_NUMBER** | The phone number you are sending the message to.
**WHATSAPP_NUMBER** | Your WhatsApp number.


```javascript
String toNumber = 'XXXXXXXXXX';
String whatsAppNumber = 'YYYYYYYYYY';
String text = 'Test message';
String channel = 'whatsapp'

Nexmo.sendMessage(toId, whatsAppNumber, text, channel);
```

Next Steps
==========

The full power of the Nexmo API is at your fingertips. Visit the [full documentation](https://developer.nexmo.com/messages-and-workflows-apis/messages/overview) for advanced topics.
