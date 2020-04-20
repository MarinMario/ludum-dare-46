extends Node2D

export var nextRoom = ""
export var needsKey = false

func _ready():
	$actionKeyArea.nextRoom = nextRoom
