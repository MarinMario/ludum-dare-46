extends Node2D

export var nextRoom = ""

func _ready():
	$actionKeyArea.nextRoom = nextRoom
