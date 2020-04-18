extends KinematicBody2D

var velocity = Vector2()
var speed = 300
var anim = ""

func _physics_process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	var motion = velocity.normalized() * speed
	move_and_slide(motion)
	
	$AnimatedSprite.play(anim)
	if velocity != Vector2():
		anim = "move"
	else: anim = "idle"
	
	if motion.x < 0:
		$AnimatedSprite.scale.x = -2
	elif motion.x > 0:
		$AnimatedSprite.scale.x = 2
