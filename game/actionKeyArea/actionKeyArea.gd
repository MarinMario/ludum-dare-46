extends Area2D

export var lines: PoolStringArray
export var nextRoom := ""
onready var playerInside = false
onready var linesRead = false

func _process(delta):
	$AnimationPlayer.play("pop")
	
	var key = $CanvasLayer/key 
	key.visible = true if playerInside else false
	
	if Input.is_action_just_pressed("action_key") and playerInside:
		if lines.size() > 0:
			spawnDialogBox()
		if nextRoom != "":
			global.lastRoom = nextRoom
			get_tree().change_scene(nextRoom)
		playerInside = false

func _on_actionKeyArea_body_entered(body):
	if body.name == "player":
		playerInside = true

func _on_actionKeyArea_body_exited(body):
	if body.name == "player":
		playerInside = false

func spawnDialogBox():
	var dialogBox = global.DIALOG_BOX.instance()
	dialogBox.lines = lines
	add_child(dialogBox)
