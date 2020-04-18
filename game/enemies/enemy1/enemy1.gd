extends KinematicBody2D

onready var followPlayer = false
var target : Node2D
var targetPosition : Vector2
var direction := Vector2()
var velocity := Vector2()

var shouldUpdateTargetPos = false

export var speed = 250

onready var anim = "idle"

func _physics_process(delta):
	
	if shouldUpdateTargetPos:
		updateTargetPos(delta)
	else: followPlayer = false
	
	if followPlayer:
		direction = (targetPosition - self.position).normalized()
		velocity = direction * speed
		move_and_slide(velocity)
	
	$body/AnimatedSprite.play(anim)
	if velocity != Vector2():
		anim = "move"
	else: anim = "idle"
	
	if velocity.x < 0:
		$body.scale.x = -1
	elif velocity.x > 0:
		$body.scale.x = 1

func _on_detectArea_body_entered(body):
	if body.name == "player":
		target = body
		shouldUpdateTargetPos = true

func _on_detectArea_body_exited(body):
	if body.name == "player":
		shouldUpdateTargetPos = false

var updateTargetTimer = 0
func updateTargetPos(delta):
	updateTargetTimer += delta
	if updateTargetTimer >= 0.5:
		followPlayer = true
		targetPosition = target.position
		updateTargetTimer = 0
