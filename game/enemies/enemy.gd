extends KinematicBody2D

onready var followPlayer = false
var target : Node2D
var targetPosition : Vector2
var direction := Vector2()
var velocity := Vector2()
export var maxTakenDamage := 20
export var state := "1"
export var hasKey = false

export var health = 50
export var speed = 250
export var patrolSpeed = 50
onready var anim = "idle1"

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
		if get_slide_count() > 0:
			randomDirectionTimer = 4
		velocity = randomDir * patrolSpeed
	
	move_and_slide(velocity)
	
	$body/AnimatedSprite.play(anim)
	if velocity != Vector2():
		anim = "move" + state
	else: anim = "idle" + state
	
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
	sounds.get_node("hit").play()
	health -= int(rand_range(1, maxTakenDamage))

onready var alreadyDead = false
func die():
	if not alreadyDead:
		alreadyDead = true
		$CollisionShape2D.disabled = true
		$detectArea/CollisionShape2D.disabled = true
		followPlayer = false
		shouldUpdateTargetPos = false
		patrolSpeed = 0
		$AnimationPlayer.play("die")
		self.z_index = 5
		if hasKey:
			spawnKey()

var randomDirectionTimer = 0
var randomDir = Vector2(0,0)
func generateRandomDirection(delta):
	randomize()
	var dir1 = round(rand_range(-1.4,1.4))
	var dir2 = round(rand_range(-1.4,1.4))
	var newRandomDir = Vector2(dir1, dir2)
	
	randomDirectionTimer += delta
	if randomDirectionTimer >= 3:
		randomDir = newRandomDir
		randomDirectionTimer = 0

func attack():
	$AnimationPlayer.play("attack")
	sounds.get_node("wosh").play()

func spawnKey():
	var key = global.KEY.instance()
	add_child(key)
