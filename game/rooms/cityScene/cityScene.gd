extends Node2D


func _ready():
	$taxi/taxi.play("move")
	$AnimationPlayer.play("taxi")
	sounds.get_node("car").play()

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://rooms/sernFront/sernFront.tscn")
