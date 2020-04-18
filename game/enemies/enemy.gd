extends KinematicBody2D

onready var followPlayer = false
var target : Node2D
var targetPosition : Vector2
var direction := Vector2()
var velocity := Vector2()

export var health = 10
export var speed = 250
export var patrolSpeed = 50
onready var anim = "idle"

func _physics_process(delta):
	
	if shouldUpdateTargetPos:
		updateTargetPos(delta)
	else: followPlayer = false
	
	if followPlayer:
		direction = (targetPosition - self.position).normalized()
		if targetPosition.distance_squared_to(position) <= 2000:
			velocity = Vector2()
			attack()
		else: velocity = direction * speed
	else:
		generateRandomDirection(delta)
		velocity = randomDir * patrolSpeed
	
	move_and_slide(velocity)
	
	$body/AnimatedSprite.play(anim)
	if velocity != Vector2():
		anim = "move"
	else: anim = "idle"
	
	if velocity.x < 0:
		$body.scale.x = -1
	elif velocity.x > 0:
		$body.scale.x = 1
	
	if health <= 0: die()

func _on_detectArea_body_entered(body):
	if body.name == "player":
		target = body
		shouldUpdateTargetPos = true

func _on_detectArea_body_exited(body):
	if body.name == "player":
		shouldUpdateTargetPos = false

var shouldUpdateTargetPos = false
var updateTargetTimer = 0
func updateTargetPos(delta):
	updateTargetTimer += delta
	if updateTargetTimer >= 0.5:
		followPlayer = true
		targetPosition = target.position
		updateTargetTimer = 0

func takeDamage():
	randomize()
	health -= int(rand_range(0, 10))

var alreadyDead = false
func die():
	if not alreadyDead:
		alreadyDead = true
		$CollisionShape2D.disabled = true
		$detectArea/CollisionShape2D.disabled = true
		followPlayer = false
		shouldUpdateTargetPos = false
		patrolSpeed = 0

var randomDirectionTimer = 0
var randomDir = Vector2(0,0)
func generateRandomDirection(delta):
	randomize()
	var dir1 = round(rand_range(-1,1))
	var dir2 = round(rand_range(-1,1))
	var newRandomDir = Vector2(dir1, dir2)
	
	randomDirectionTimer += delta
	if randomDirectionTimer >= 3:
		randomDir = newRandomDir
		randomDirectionTimer = 0

func attack():
	$AnimationPlayer.play("attack")
