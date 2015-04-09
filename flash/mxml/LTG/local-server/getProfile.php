<?php

	#$newID = "";
	function useID( $id )
	{

		#echo $id;
		$newID = $id;
		returnUserID( $id );

	}

	function returnUserID( $id )
	{
		#Call database here.

		$array = [
			#"id" => $id ,
		    "username" => "Charlie",
		    "id" => $id,
		    "active" => "true"
		];
		echo json_encode($array);

	}

?>