extends KinematicBody2D

var health = 100

var velocity = Vector2()
var speed = 300
onready var anim = "idle"

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
	
	$body/AnimatedSprite.play(anim)
	if velocity != Vector2():
		anim = "move"
	else: anim = "idle"
	
	if motion.x < 0:
		$body.scale.x = -1
	elif motion.x > 0:
		$body.scale.x = 1

func take_damage():
	randomize()
	health -= rand_range(0, 10)
