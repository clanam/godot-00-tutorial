# Godot Tutorial

Following along on the godot tutorial @
https://docs.godotengine.org/en/stable/getting_started/step_by_step/your_first_game.html

## Running Tests

Unit tests in [GUT](https://github.com/bitwes/Gut)

```
alias godot="/Applications/Godot.app/Contents/MacOS/Godot"
alias gut="godot -d -s --path $PWD addons/gut/gut_cmdln.gd"

# in project root
gut
```

 - `-d`:  run in debug mode
 - `-s`: run a script
 - `--path $PWD`: tells Godot to treat the current directory as project root

