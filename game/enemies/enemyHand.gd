extends Node2D

func _process(delta):
	var state = get_parent().get_parent().name
	$hand.play(state)
	$hand/sword/sword.play(state)

func _on_sword_body_entered(body):
	if body.name == "player":
		body.takeDamage()
