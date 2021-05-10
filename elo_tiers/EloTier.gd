extends Node2D

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_OUT

onready var tween = $Tween
onready var timer = $timer
onready var animationplayer = $AnimationPlayer

var startpt = Playerposition.player_position
var endpt = startpt + Vector2(0, -40)

func _ready():
	tween.interpolate_property($Sprite, "position", Playerposition.player_position, endpt, timer.wait_time, TRANS, EASE)
	tween.start()
	animationplayer.play("fadeout")
	
func delete():
	queue_free()


