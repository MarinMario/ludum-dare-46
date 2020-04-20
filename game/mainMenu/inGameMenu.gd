extends CanvasLayer

func _ready():
	$pauseMenu.visible = false

onready var paused = false
func _on_Pause_pressed():
	paused = not paused
	$pauseMenu.visible = paused
	get_tree().paused = paused
