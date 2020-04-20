extends Node2D

export var personState = ""
var personPos = Vector2(200, 100)
var tilesetColor = "oof"

func _ready():
	$stranger.play(personState)
	if personState == "male1":
		personPos = Vector2(150, 150)
		$stranger.scale = Vector2(2.3, 2.3)
		tilesetColor = "#fff44f"
	elif personState == "female1":
		personPos = Vector2(300, 200)
		tilesetColor = "#414a4c"
	elif personState == "male2":
		$stranger.scale = Vector2(2.4, 2.4)
		personPos = Vector2(200, 200)
		tilesetColor = "#b33745"
	else:
		tilesetColor = "#d89123"
	
	$colorTileset.modulate = tilesetColor
	$stranger.global_position = personPos
	
