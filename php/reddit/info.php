
<?php
$content = file_get_contents('http://www.google.com/'); 
if ($content !== false) {
   // do something with the content
    echo ( YES )
} else {
   // an error happened
    echo ( NO )
}
>