extends KinematicBody2D

export var health = 100

var velocity = Vector2()
export var speed = 300
export var maxTakenDamage = 20
onready var anim = "idle"
onready var hasKey = false

func _physics_process(delta):
	velocity = Vector2()
	if not alreadyDead: 
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
		if Input.is_action_just_pressed("attack"):
			$AnimationPlayer.play("attack")
			sounds.get_node("wosh").play()
	
	var motion = velocity.normalized() * speed
	move_and_slide(motion)
	
	$body/AnimatedSprite.play(anim)
	if not alreadyDead:
		if velocity != Vector2():
			anim = "move"
		else: anim = "idle"
	else: anim = "idle"
	
	if motion.x < 0:
		$body.scale.x = -1
	elif motion.x > 0:
		$body.scale.x = 1
	
	if health <= 0: die()
	
	if shouldCameraShake:
		cameraShakeTimer += delta
		if cameraShakeTimer >= 0.1:
			cameraShakeTimer = 0
			shouldCameraShake = false
			$Camera2D.offset = Vector2()
		else: cameraShake(10)


func takeDamage():
	randomize()
	health -= round(rand_range(1, maxTakenDamage))
	print(health)
	sounds.get_node("hit").play()


onready var alreadyDead = false
func die():
	if not alreadyDead:
		alreadyDead = true
		$CollisionShape2D.disabled = true
		$AnimationPlayer.play("die")
		speed = 0
		self.z_index = 5

onready var shouldCameraShake = false
onready var cameraShakeTimer = 0
func cameraShake(shakeAmount):
	$Camera2D.offset = Vector2(
		rand_range(-1.0, 1.0) * shakeAmount,
		rand_range(-1.0, 1.0) * shakeAmount
	)
