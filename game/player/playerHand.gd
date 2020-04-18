extends Node2D

func _process(delta):
	$hand.look_at(get_global_mouse_position())

func _on_sword_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage()
