extends CanvasLayer

export var lines: PoolStringArray
var current_text := ""
var line_number := 0

func _ready():
	$anims.play("spawn")

func _process(delta):
	if Input.is_action_just_pressed("action_key"):
		if line_number == lines.size() - 1:
			$anims.play("despawn")
		else:
			line_number += 1
			$anims.play("pop")
	
	if Input.is_action_just_pressed("escape"):
		$anims.play("despawn")
	
	current_text = lines[line_number]
	$container/Label.text = current_text


func _on_anims_animation_finished(anim_name):
	if anim_name == "despawn":
		if get_parent().name == "dialog_spawner_area":
			get_parent().queue_free()
		else:
			get_parent().linesRead = true
		self.queue_free()
