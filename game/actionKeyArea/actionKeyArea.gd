extends Area2D

export var lines: PoolStringArray
export var nextRoom := ""
onready var playerInside = false
onready var linesRead = false
var needsKey = false

func _ready():
	if lines.size() == 0:
		linesRead = true
	if get_parent().is_in_group("door"):
		needsKey = get_parent().needsKey
		print(needsKey)
	
func _process(delta):
	$AnimationPlayer.play("pop")
	
	var key = $CanvasLayer/key 
	key.visible = true if playerInside else false
	
	if Input.is_action_just_pressed("action_key") and playerInside:
		if needsKey:
			lines = ["I can't enter without the key"]
		if lines.size() > 0:
			spawnDialogBox()
		if nextRoom != "" and linesRead and !needsKey:
			global.lastRoom = nextRoom
			get_tree().change_scene(nextRoom)
			sounds.get_node("door").play()
		playerInside = false
	
	if lines.size()> 0 and linesRead:
		get_tree().change_scene(nextRoom)
		sounds.get_node("door").play()

func _on_actionKeyArea_body_entered(body):
	if body.name == "player":
		playerInside = true
		if body.hasKey:
			needsKey = false

func _on_actionKeyArea_body_exited(body):
	if body.name == "player":
		playerInside = false

func spawnDialogBox():
	var dialogBox = global.DIALOG_BOX.instance()
	dialogBox.lines = lines
	add_child(dialogBox)
