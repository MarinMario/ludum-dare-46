extends Area2D

export var lines: PoolStringArray
onready var dialog_box = global.DIALOG_BOX.instance()
onready var allow_spawn = true 

func _on_dialog_spawner_area_body_entered(body):
	if body.name == "player" and allow_spawn:
		dialog_box.lines = lines
		add_child(dialog_box)
		allow_spawn = false

