extends KinematicBody2D

var speed = 450
var velocity = Vector2()

onready var timer = $Timer

func start(pos, dir):
	rotation = dir
	global_position = pos
	velocity = Vector2(speed, 0).rotated(rotation)
	
func _physics_process(delta):
	move_and_collide(velocity * delta)






func _on_VisibilityNotifier2D_screen_exited():
	Playerposition.canshoot = true
	queue_free()
	


func _on_Hitbox_area_entered(area):
	queue_free()


func _on_Timer_timeout():
	Playerposition.canshoot = true
	queue_free()
