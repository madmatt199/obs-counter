+-------------------------------+
| OBS Counter v0.1 by GlazedHam |
+-------------------------------+

Tested against OBS Studio v21.1.0 64bit

----------------------
Setup Your Scene First
----------------------
1. Create in your Scene a custom Text (GDI+) source and give it a unique name

------------
Installation
------------
1. Unzip the script package in any location of your choosing
2. Then open OBS->Tools->Scripts and click on the Plus sign at the bottom
3. Navigate to wherever you put the script files and select obs-counter.lua
4. Click obs-counter.lua in the list
5. In the properties pane, open the drop down and sleect the text source you
   created earlier

-------------
Setup Hotkeys
-------------
1. Navigate to File->Settings->Hotkeys and look for Increment Counter and
   Decrement Counter in the global hotkeys
2. Set these to whatever you want and hit Apply
3. Now you should be able to increment and decrement your text source

!!!!!!
Quirks
!!!!!!
1. Due to the way OBS handles events if you have an item highlighted in your
   sources list the even won't fire. Try clicking outside OBS on your
   desktop and trying again.

----
Tips
----
You can make this look good by putting your text source right next to
an image, to give your counter meaning and context. Text can also be modified
to look good on any background with a small black border and bolder font.