# Godot Tutorial

Following along on the godot tutorial @
https://docs.godotengine.org/en/stable/getting_started/step_by_step/your_first_game.html

Other Links:

 - [file system](https://docs.godotengine.org/en/stable/getting_started/step_by_step/filesystem.html)
 - [game saves](https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html)

## Running the Game

The game can be run via the godot editor or command line:

```
alias godot="/Applications/Godot.app/Contents/MacOS/Godot"

# in project root
godot
```

## Running Tests

Unit tests in [GUT](https://github.com/bitwes/Gut)

 - [link](https://github.com/bitwes/Gut/wiki/Asserts-and-Methods) to asserts and methods page
 - [link](https://github.com/bitwes/Gut/wiki/Stubbing) to stubbing

```
alias godot="/Applications/Godot.app/Contents/MacOS/Godot"
alias gut="godot -d -s --path $PWD addons/gut/gut_cmdln.gd"

# in project root
gut

# run only one test
gut -gselect=test_hud.gd
```

 - `-d`: run in debug mode
 - `-s`: run a script
 - `--path $PWD`: tells Godot to treat the current directory as project root

