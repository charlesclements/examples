<?php
$string_reddit = file_get_contents("http://www.reddit.com/reddits.json?limit=10");

$json = json_decode($string_reddit, true);  

$children = $json['data']['children'];

//echo $children;

print_r $children;
foreach ($children as $child){
    /*
    $title = $child['data']['title'];
    $url = $child['data']['url'];
    echo $title . "<br>";
    echo $url . "<br><br>";
    
    print_r $children;
    */
}

?>