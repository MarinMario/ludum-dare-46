extends Node2D

func _process(delta):
	$bar.value = get_parent().health
	if get_parent().alreadyDead:
		self.visible = false
