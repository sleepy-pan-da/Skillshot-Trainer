extends KinematicBody2D

var delay_mseconds := 70
var speed = 150
var velocity = Vector2()
var direction : Vector2

var Bloodeffect = preload("res://Bloodeffect.tscn")

onready var animatedsprite = $AnimatedSprite

signal enemykilled

func _ready():
	animatedsprite.play()

func start(pos, dir):
	rotation = dir
	#look_at(lookat_player())
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	look_at(Playerposition.player_position)
	direction = lookat_player()
	velocity = speed * direction
	move_and_collide(velocity * delta)
	if !Playerposition.alive:
		queue_free()

func lookat_player():
	return global_position.direction_to(Playerposition.player_position)


func _on_Hurtbox_area_entered(area):
	emit_signal("enemykilled")
	#OS.delay_msec(delay_mseconds)
	var bloodeffect = Bloodeffect.instance()
	get_parent().add_child(bloodeffect)
	bloodeffect.global_position = global_position
	queue_free()
