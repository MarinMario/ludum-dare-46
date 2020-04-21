extends CanvasLayer

func _process(delta):
	var health = get_parent().health
	$healthBar/bar.value = health
	
	$timer.text = str(global.timer)
