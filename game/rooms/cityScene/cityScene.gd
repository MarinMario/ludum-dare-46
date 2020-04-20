extends Node2D


func _ready():
	$taxi/taxi.play("move")
	$AnimationPlayer.play("taxi")

func _on_AnimationPlayer_animation_finished(anim_name):
	pass
