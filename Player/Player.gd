extends KinematicBody2D

const SPEED = 200
const BULLET_SPEED = 400
#player
var target : Vector2
var direction : Vector2
var velocity : Vector2
#bullet
var bullet_target : Vector2
var bullet_direction : Vector2
var bullet_velocity : Vector2
var moving = false
var Bullet = preload("res://Player/Bullet.tscn")
var Muzzleflash = preload("res://Player/MuzzleFlash.tscn")
var Bloodeffect = preload("res://PlayerBloodeffect.tscn")
var Bulleteffect = preload("res://Bulleteffect.tscn")
onready var muzzle = $Muzzle
onready var gunsound = $Gun_sound
onready var animatedsprite = $AnimatedSprite

signal you_died
signal you_fired

func _physics_process(delta):
	if Input.is_action_just_pressed("right_click"):
		moving = true
		target = get_global_mouse_position()
		look_at(target)
	direction = global_position.direction_to(target)
	velocity = direction * SPEED
	
	if global_position.distance_to(target) > 10 and moving:
		velocity = move_and_slide(velocity)
		animatedsprite.play()
	else:
		animatedsprite.stop()
		animatedsprite.frame = 1
	
	if Input.is_action_just_pressed("q_key") and Playerposition.canshoot:
		gunsound.play()
		emit_signal("you_fired")
		Playerposition.canshoot = false
		moving = false
		#muzzleflash
		var flash = Muzzleflash.instance()
		get_tree().current_scene.add_child(flash)
		look_at(get_global_mouse_position())
		flash.global_position = muzzle.global_position
		flash.global_rotation = muzzle.global_rotation
		#bullet
		var bullet = Bullet.instance()
		get_tree().current_scene.add_child(bullet)
		bullet.start(muzzle.global_position, rotation)
		
	Playerposition.player_position = global_position #updating global script


func _on_Hurtbox_area_entered(area):
	print("you died")
	emit_signal("you_died")
	var bloodeffect = Bloodeffect.instance()
	get_parent().add_child(bloodeffect)
	bloodeffect.global_position = global_position
	queue_free()
