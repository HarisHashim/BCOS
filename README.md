BCOS
====

This project build a customize Ubuntu iso image.

Prerequisite
------------

Install Customizer by checking out the code from https://github.com/kamilion/customizer.

*IMPORTANT* follow this guide to install Customizer. The only way tat works! https://github.com/kamilion/customizer/wiki/First-guide

How to Build BCOS
------------------

Clone this repo and in BCOS directory
1. Use your favourite shell and change direcory to buildscripts. *IMPORTANT* wont work if the scripts is executed from elsewhere! 
2. Execute first time setting
   ```sudo setup-build-environment.sh```
3. Execute the build script 
   ```sudo mini-rebuild.sh```
4. An iso will be created in BCOS directory. Enjoy!

Note
----

Windows is not supported! Even then, this script is only tested in Ubuntu Bionic (18.04). So please take that as that!

Best run in an VM. Just in case it make your PC or notebook explode!

Drive safely and responsibly!