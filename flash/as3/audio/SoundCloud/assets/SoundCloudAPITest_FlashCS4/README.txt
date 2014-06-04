
EXAMPLE FLASH APPLICATION FOR THE SOUNDCLOUD AS3 API

see http://github.com/dasflash/Soundcloud-AS3-API and http://dasflash.com for
more information on this project.

To compile and run SoundCloudAPITest_Fla.fla you need:

* Adobe Flash CS4 or newer (target FlashPlayer 10).

* A Consumer Key and Consumer Secret string for your application. Get it at
  http://soundcloud.com/settings/applications/new
  If you want to access the SoundCloud API sandbox too, you need a second key
  from http://sandbox-soundcloud.com/settings/applications/new


Known Issues:

* There seems to be a bug in FlashPlayer plugin for Mac OS X which throws an
  FileIOError #2038 after successful(!) file uploads. I'll try to fix this in a later
  version, but am not sure if this is possible at all. This bug does NOT occur
  on the Windows versions of FlashPlayer and the AIR runtime on both Mac and Windows.


Copyright 2010 (c) Dorian Roy - dasflash.com