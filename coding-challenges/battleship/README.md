# Battleship Game

Welcome to my Battleship Game implementation for the [Launch School](www.launschool.com) course. Game instructions are displayed when run. You will notice that I added an option to choose a battlefield. The battlefield dictates the size of the board and the number of ships.

When selecting the battlefield, a configuration file is loaded. I've added already a number of default ones.

* Skirmish (battleship_config.yml)
* Battlezone (battlezone_config.yml)
* Warzone (warzone_config.yml)


You'll also notice that there is an option for a *custom* battlefield. For this one you will need to `copy and paste` any of the existing configuration files into a file that is named as **custom_config.yml**. I have't fully tested this one yet, but you should be able to do the following:

* Add your own ships
* Set the number of ships in the game
* Set the ship composition


Bugs? Contact me through <vpaoloreyes@gmail.com>

##### For the TA's and other intereseted testers
I've added a *test configuration file* [ts_battlehsip_config.yml]. This is the configuration file that I used to run the test suite that I made. Please **NOTE** that in order for the ALL the tests to pass the `battleship.rb` file has to be modified a bit. I've added some `colorize` effect to the displays during the game play and this does not work yet with the current test suite that I made. So if you want to try out the test suite please remove all the `colorize` that is present in my code (sorry for this hassle).
