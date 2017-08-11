<?php
// Convert $total_minutes to hours and minutes.

$total_minutes = 318;
$minutes = $total_minutes % 60;

$hours = floor( $total_minutes / 60 );

echo "Time taken was $hours hours $minutes minutes";
