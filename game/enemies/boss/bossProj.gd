extends Area2D

var target = Vector2(100, 110)
var speed = 500
onready var direction = (target-position).normalized()

var despawnTimer = 0

func _ready():
	self.look_at(target)

func _physics_process(delta):
	self.position += direction * speed * delta
	despawnTimer += delta
	if despawnTimer > 10:
		self.queue_free()

func _on_bossProj_body_entered(body):
	if body.name == "player":
		body.takeDamage()
