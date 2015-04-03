<?php
    $regUser = "tom";
    $regPass = "pass";
    if( $_POST['user'] == $regUser && $_POST['password'] == $regPass )
    {

    	$id = "201504011912";

    	include 'getProfile.php';
    	useID( $id );
	#echo "201504011912";


    } 
    else echo "null";
?>