extends Area2D

onready var playerInside = false
var player

func _process(delta):
	if Input.is_action_just_pressed("action_key"):
		if playerInside:
			player.hasKey = true
			sounds.get_node("pop").play()
			self.queue_free()

func _on_key_body_entered(body):
	if body.name == "player":
		playerInside = true
		player = body

func _on_key_body_exited(body):
	if body.name == "player":
		playerInside = false
