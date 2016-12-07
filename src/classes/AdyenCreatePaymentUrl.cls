public with sharing class AdyenCreatePaymentUrl {
    private static final String sharedKey = '6CF175BBC8C912E376ED8B775018201BFBC59F7C4D9CA459CD011BA7EE10262E';
    public String hppUrl {get; set;}
    public String merchantReference {get; set;}
    public String paymentAmount {get; set;}
    public String currencyCode {get; set;}
    public String shipBeforeDate {get; set;}
    public String skinCode {get; set;}
    public String merchantAccount {get; set;}
    public String sessionValidity {get; set;}
    public String shopperLocale {get; set;}
    public String shopperEmail {get; set;}
    public String merchantReturnData {get; set;}
    public String merchantSig {get; set;}
    protected String test {get;set;}
    public AdyenCreatePaymentUrl() {

    }

    public PageReference setupPayment() {
        hppUrl = 'https://test.adyen.com/hpp/pay.shtml';
        Date currentDate = System.today(); // current date
        DateTime sessionDate = System.now().addDays(1); // current date + 1 day
        DateTime shippingDate = System.now().addDays(3); // current date + 3 days
        merchantReference = 'PAYMENT-00626000002Kk0pAAC-' + System.now().format('yyyy-MM-dd');
        paymentAmount = '123300';
        currencyCode = 'EUR';
        shipBeforeDate = '2015-10-18';
        skinCode = 'CsUnbw3A';
        merchantAccount = 'MovingaGmbHDE831';
        sessionValidity = '2015-10-16T17:28:25Z';//sessionDate.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
        shopperEmail = 'ionut@empaua.com';
        shopperLocale = 'en_GB';
        Map<String, String> params = new Map<String, String>{
            'currencyCode'=>currencyCode,
            'merchantAccount'=>merchantAccount,
            'merchantReference'=>merchantReference,
            'paymentAmount'=>paymentAmount,
            'sessionValidity'=>sessionValidity,
            'shipBeforeDate'=>shipBeforeDate,
            'shopperEmail'=>'ionut@empaua.com',
            //'shopperLocale'=>shopperLocale,
            'skinCode'=>skinCode
        };

        //199EUR2015-10-17TEST-PAYMENT-2015-10-14CsUnbw3AMovingaGmbHDE8312015-10-15T17:25:32Z00D24000000bdIP!AR8AQMLJAgrMaPylMjgPpHqiG87R7xWH05fuO6nh0w3Ltl.twbzw7DmXraHNtJNBRFLntzXv0z901CnVr2kL1.65iQVnVL2e
        /**
         * Signing the form
         * 
         * The merchant signature is used by Adyen to verify if the posted data is not altered by the shopper. The
         * signature must be encrypted according to the procedure below.
         * 
         * Please note: the signature does contain more variables, in this example they are NOT required since they are
         * empty. Please have a look at the advanced HPP example for a comprehensive overview on what should be part of
         * the signature.
         */
        //escape values
        params.put('merchantReference', escapeValue(params.get('merchantReference')));
        params.put('sessionValidity', escapeValue(params.get('sessionValidity')));
        //params.put('merchantReturnData', escapeValue(params.get('merchantReturnData')));
        List<String> sortedKeys = new List<String>();
        sortedKeys.addAll(params.keySet());
        system.debug(String.join(params.values(), ':'));
        system.debug(sortedKeys);
        String signingString = String.join(sortedKeys, ':') + ':' + String.join(params.values(), ':');

        try {
            merchantSig = calculateHMAC(signingString);
            System.debug(signingString);
            system.debug(merchantSig);
        } catch (Exception e) {
        }

        /**
         * Generating the payment URL
         * 
         * All variables are appended to the query string of the provided hppUrl. Please note that not all browsers are
         * capable of handling large URLs, and all parameters and their values should be URL-encoded using UTF-8
         * character encoding.
         */
        String paymentUrl = hppUrl
                + '?merchantReference=' + EncodingUtil.urlEncode(merchantReference, 'UTF-8')
                + '&paymentAmount=' + EncodingUtil.urlEncode(paymentAmount, 'UTF-8')
                + '&currencyCode=' + EncodingUtil.urlEncode(currencyCode, 'UTF-8')
                + '&shipBeforeDate=' + EncodingUtil.urlEncode(shipBeforeDate, 'UTF-8')
                + '&skinCode=' + EncodingUtil.urlEncode(skinCode, 'UTF-8')
                + '&merchantAccount=' + EncodingUtil.urlEncode(merchantAccount, 'UTF-8')
                + '&sessionValidity=' + EncodingUtil.urlEncode(sessionValidity, 'UTF-8')
                + '&shopperEmail=' + EncodingUtil.urlEncode(shopperEmail, 'UTF-8')
                //+ '&shopperLocale=' + EncodingUtil.urlEncode(shopperLocale, 'UTF-8')
                //+ '&merchantReturnData=' + EncodingUtil.urlEncode('merchantReturnData'), 'UTF-8')
                + '&merchantSig=' + EncodingUtil.urlEncode(merchantSig, 'UTF-8');
        PageReference paymentPage = new PageReference(paymentUrl);
        paymentPage.setRedirect(true);
        return paymentPage;
    }

    /**
     * Computes the Base64 encoded signature using the HMAC algorithm with the SHA-1 hashing function.
     */
    private String calculateHMAC(String stringToSign){
        Blob stringtoSignBlob = Blob.valueOf(stringToSign);
        Blob signatureBlob = Crypto.generateMac('hmacSHA256', stringtoSignBlob, EncodingUtil.convertFromHex(sharedKey));//sharedKeyBlob);
        System.debug(EncodingUtil.convertToHex(signatureBlob));
        System.debug(EncodingUtil.convertToHex(EncodingUtil.base64Decode(sharedKey)));
        return EncodingUtil.base64Encode(signatureBlob);
    }

    private String escapeValue(String value) {
        if(String.isBlank(value)) {
            return '';
        }
        return value.replace('\\','\\\\').replace(':','\\:');
    }
}