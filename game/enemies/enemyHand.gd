extends Node2D

onready var enemy = get_parent().get_parent()

func _process(delta):
	var state = "enemy" + get_parent().get_parent().state
	$hand.play(state)
	$hand/sword/sword.play(state)

func _on_sword_body_entered(body):
	if body.name == "player" and not enemy.alreadyDead:
		body.takeDamage()
		body.shouldCameraShake = true
