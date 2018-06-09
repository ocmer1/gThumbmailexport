# gThumbmailexport
A shell script to resize and export photos from gThumb by e-mail

## Requirements
* gThumb
* ImageMagick
* Thunderbird
Tested on Ubuntu 18.04 with gThumb 3.6.1

## Use
In gThumb, go to _tools_ and then _personalize_. Click _new_, give an appropriate name and add the following command:
`/path/to/sendbyemail.sh -yourflag %F`
Replace the path with the path where you've stored the script. You can replace _yourflag_ with one of the following:
* original: Does not resize
* small: Resizes the longest side of the picture to 800px
* medium: Resizes the longest side of the picture to 1200px
* large: Resizes the longest side of the picture to 1600px
* verylarge: Resizes the longest of the picture side to 2000px

Note that in the _personalize_ menu, you need to add an entry for each separate flag (so 5 in total, if you want to have all options mentioned above available). If you do not like the standard sizes, they can be easily replaced by other values in the script.


## Credits
Script is based on: http://nohup.run/gthumb-sending-resized-images-by-email/
