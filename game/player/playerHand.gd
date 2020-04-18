extends Node2D

onready var player = get_parent().get_parent()

func _process(delta):
	if not player.alreadyDead:
		$hand.look_at(get_global_mouse_position())

func _on_sword_body_entered(body):
	if body.is_in_group("enemy"):
		body.takeDamage()
		player.shouldCameraShake = true
