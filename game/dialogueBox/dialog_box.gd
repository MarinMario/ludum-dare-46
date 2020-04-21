extends CanvasLayer

export var lines: PoolStringArray
var current_text := ""
var line_number := 0

func _ready():
	$anims.play("spawn")
	sounds.get_node("pop").play()
	

func _process(delta):
	if Input.is_action_just_pressed("action_key"):
		if line_number == lines.size() - 1:
			$anims.play("despawn")
			sounds.get_node("pop").play()
		else:
			line_number += 1
			$anims.play("pop")
			sounds.get_node("pop").play()
	
	if Input.is_action_just_pressed("escape") or Input.is_mouse_button_pressed(2):
		$anims.play("despawn")
		sounds.get_node("pop").play()
	
	current_text = lines[line_number]
	$container/Label.text = current_text

func _on_anims_animation_finished(anim_name):
	if anim_name == "despawn":
		if get_parent().is_in_group("dialogSpawner"):
			get_parent().queue_free()
		if get_parent().is_in_group("actionKeyArea"): 
			get_parent().linesRead = true
		self.queue_free()
