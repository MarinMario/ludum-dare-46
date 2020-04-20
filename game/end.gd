extends Node2D


func _ready():
	sounds.get_node("op").stop()
	sounds.get_node("gos").play()
