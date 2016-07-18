<?php
require_once 'ppNVP/CallerService.php';
require_once 'ppNVP/constants.php';

session_start ();

$token = $_REQUEST ['token'];
if (! isset ( $token )) {
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

} else {
	/* At this point, the buyer has completed in authorizing payment
			at PayPal.  The script will now call PayPal with the details
			of the authorization, incuding any shipping information of the
			buyer.  Remember, the authorization is not a completed transaction
			at this state - the buyer still needs an additional step to finalize
			the transaction
			*/
	
	$token = urlencode ( $_REQUEST ['token'] );
	
	/* Build a second API request to PayPal, using the token as the
			ID to get the details on the payment authorization
			*/
	$nvpstr = "&TOKEN=" . $token;
	
	/* Make the API call and store the results in an array.  If the
			call was a success, show the authorization details, and provide
			an action to complete the payment.  If failed, show the error
			*/
	$resArray = hash_call ( "GetExpressCheckoutDetails", $nvpstr );
	$_SESSION ['reshash'] = $resArray;
	$ack = strtoupper ( $resArray ["ACK"] );
	
	if ($ack == "SUCCESS") {
		require_once "GetExpressCheckoutDetails.php";
	} else {
		//Redirecting to APIError.php to display errors. 
		$location = "APIError.php";
		header ( "Location: $location" );
	}
}

?>