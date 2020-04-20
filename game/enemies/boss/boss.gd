extends KinematicBody2D

export var speed = 150
export var health = 100
export var maxTakenDamage = 10
onready var shootPlayer = false
var target: Node2D
var velocity = Vector2()
onready var anim = "idle"

var spawnProjTimer = 0
func _process(delta):
	if shootPlayer:
		spawnProjTimer += delta
		if spawnProjTimer >= 2:
			spawnProj()
			spawnProjTimer = 0
		randomDirectionTimer += delta
		if randomDirectionTimer >= 1:
			randomDirectionTimer = 0
			randomDir = generateRandomDirection(delta)
			if get_slide_count() > 0:
				randomDirectionTimer = 4
		velocity = randomDir * speed
		move_and_slide(velocity)
	
	$body/Sprite.play(anim)
	if not alreadyDead:
		if velocity != Vector2():
			anim = "move"
		else: anim = "idle"
	else: anim = "idle"
	
	if velocity.x < 0:
		$body.scale.x = -1
	elif velocity.x > 0:
		$body.scale.x = 1
	
	if health <= 0: die()
		

func takeDamage():
	randomize()
	sounds.get_node("hit").play()
	health -= int(rand_range(1, maxTakenDamage))

func spawnProj():
	var proj = global.KNIFE.instance()
	proj.position = self.global_position
	proj.target = target.global_position
	get_parent().add_child(proj)

var randomDirectionTimer = 0
var randomDir = Vector2(0,0)
func generateRandomDirection(delta):
	randomize()
	var dir1 = round(rand_range(-1.4,1.4))
	var dir2 = round(rand_range(-1.4,1.4))
	return Vector2(dir1, dir2)

onready var alreadyDead = false
func die():
	if not alreadyDead:
		$CollisionShape2D.disabled = true
		$AnimationPlayer.play("die")
		alreadyDead = true
		shootPlayer = false
		spawnKey()

func _on_Area2D_body_entered(body):
	if body.name == "player":
		target = body
		shootPlayer = true
		sounds.get_node("gos").stop()
		sounds.get_node("op").play()
		$Area2D.queue_free()

func spawnKey():
	var key = global.KEY.instance()
	add_child(key)
	sounds.get_node("wosh").play()
