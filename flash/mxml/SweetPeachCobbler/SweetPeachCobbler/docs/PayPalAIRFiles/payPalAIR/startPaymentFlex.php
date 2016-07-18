<?php
require_once 'ppNVP/CallerService.php';
require_once 'ppNVP/constants.php';

session_start ();

$token = $_REQUEST ['token'];
$serverName = $_SERVER ['SERVER_NAME'];
$serverPort = $_SERVER ['SERVER_PORT'];
$url = dirname ( 'http://' . $serverName . ':' . $serverPort . $_SERVER ['REQUEST_URI'] );

function getMovieAmount($movieId) {
	//you can replace this function with a more sophisticated one
	return 1;
}

	
$paymentAmount = getMovieAmount($_GET['movieId']); //$_REQUEST ['paymentAmount'];
$currencyCodeType = 'USD'; //$_REQUEST ['currencyCodeType'];
$paymentType = 'Sale'; //$_REQUEST ['paymentType'];


/* The returnURL is the location where buyers return when a
		payment has been succesfully authorized.
		The cancelURL is the location buyers are sent to when they hit the
		cancel button during authorization of payment during the PayPal flow
		*/

$returnURL = urlencode ( $url . '/GetExpressCheckoutDetails.php?currencyCodeType=' . $currencyCodeType . '&paymentType=' . $paymentType . '&paymentAmount=' . $paymentAmount );
$cancelURL = urlencode ( "$url/cancel.php?paymentType=$paymentType" );

/* Construct the parameter string that describes the PayPal payment
		the varialbes were set in the web form, and the resulting string
		is stored in $nvpstr
		*/

$nvpstr = "&Amt=" . $paymentAmount . "&PAYMENTACTION=" . $paymentType . "&ReturnUrl=" . $returnURL . "&CANCELURL=" . $cancelURL . "&CURRENCYCODE=" . $currencyCodeType;

/* Make the call to PayPal to set the Express Checkout token
		If the API call succeded, then redirect the buyer to PayPal
		to begin to authorize payment.  If an error occured, show the
		resulting errors
		*/
$resArray = hash_call ( "SetExpressCheckout", $nvpstr );
$_SESSION ['reshash'] = $resArray;

$ack = strtoupper ( $resArray ["ACK"] );

if ($ack == "SUCCESS") {
	// Redirect to paypal.com here
	$token = urldecode ( $resArray ["TOKEN"] );
	$payPalURL = PAYPAL_URL . $token;
	header ( "Location: " . $payPalURL );
} else {
	//Redirecting to APIError.php to display errors. 
	$location = "APIError.php";
	header ( "Location: $location" );
}

?>