extends Node2D

func _process(delta):
	if $taxi/taxiArea.linesRead:
		get_tree().change_scene("res://rooms/cityScene/cityScene.tscn")
