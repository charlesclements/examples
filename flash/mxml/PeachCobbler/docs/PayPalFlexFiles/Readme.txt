Read the following before using the files within this archive.

1. This archive contains files that belong to the Integrating PayPal Express Checkout with Flex and AIR source files posted on the Adobe Developer Center:
http://www.adobe.com/devnet/...


These files wil help you create a working demo on how to integrate the PayPal Express checkout with Flex running in Flash Player

2. Installing the sample files:

 * Unpack the archive and put the files in a temporary location (For example /tmp)
 * Copy payPalFlex folder into your Web Root folder (For example: /work/www).
 * Edit payPalFlex/ppNVP/constants.php and replace

define('API_USERNAME', 'sdk-three_api1.sdk.com');
define('API_PASSWORD', 'QFZCWN5HZM8VBG7Q');
define('API_SIGNATURE', 'A.d9eRKfd1yVkRrtmMfCFLTqa6M9AyodL0SJkhYztxUi8W9pCXF6.4NI');

with your ownPayPal API_USERNAME, API_PASSWORD and API_SIGNATURE

 * In Flash Builder click File->Import É and choose Flash Builder Project.
 * Choose payPalFlex.fxp
 * Fill the the Output Folder Location, Web Root and Root URL with your values.