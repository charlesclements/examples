Read the following before using the files within this archive.

1. This archive contains files that belong to the Integrating PayPal Express Checkout with Flex and AIR source files posted on the Adobe Developer Center:
http://www.adobe.com/devnet/...


These files wil help you create a working demo on how to integrate the PayPal Express checkout with Flex running in AIR

2. Installing the sample files:

 * Unpack the archive and put the files in a temporary location (For example /tmp)
 * In Flash Builder click File->Import .. and choose Flash Builder Project
 * Choose payPalAIR.fxp
 * Copy payPalAIR folder into your Web Root folder (For example: /work/www).
 * Edit payPalAIR/ppNVP/constants.php and replace

define('API_USERNAME', 'sdk-three_api1.sdk.com');
define('API_PASSWORD', 'QFZCWN5HZM8VBG7Q');
define('API_SIGNATURE', 'A.d9eRKfd1yVkRrtmMfCFLTqa6M9AyodL0SJkhYztxUi8W9pCXF6.4NI');

with your ownPayPal API_USERNAME, API_PASSWORD and API_SIGNATURE

 * In Flash Builder click File->Import É and choose Flash Builder Project.
 * Choose payPalAIRReturn.fxp
 * Fill the Output Folder Location (this one should point to where you have copied payPalAIR folder in your web root), Web Root and Root URL with your values.