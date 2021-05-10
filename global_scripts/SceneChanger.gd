extends CanvasLayer

signal fade_finished

onready var animationplayer = $AnimationPlayer
onready var black = $Control/ColorRect

func change_scene(path):
	print("change scene")
	#yield(get_tree().create_timer(delay), "timeout")
	animationplayer.play("fade")
	yield(animationplayer, "animation_finished")
	get_tree().change_scene(path)
	animationplayer.play_backwards("fade")

func play_fade():
	animationplayer.play("fade")
	yield(animationplayer, "animation_finished")
	animationplayer.play_backwards("fade")
	emit_signal("fade_finished")
