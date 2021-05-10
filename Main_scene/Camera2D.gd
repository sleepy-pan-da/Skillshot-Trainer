extends Camera2D

onready var timer = $Screenshake_timer

export var amplitude := 6.0
export var duration := 0.8 setget set_duration
export(float, EASE) var DAMP_EASING := 1.0
export var shake : = false setget set_shake

#var enabled := false

func _ready():
	randomize()
	set_process(false)
	self.duration = duration
	#connect_to_shakers()
	
func _process(delta):
	var damping := ease(timer.time_left/ timer.wait_time, DAMP_EASING)
	offset = Vector2(
		rand_range(amplitude, -amplitude) * damping,
		rand_range(amplitude, -amplitude) * damping)
	print("i am shaking")
	
func _on_ShakeTimer_timeout():
	self.shake = false
	
func _on_camera_shake_requested():
#	if not enabled:
#		return
	self.shake = true
	
func set_duration(value: float):
	duration = value
	timer.wait_time = duration

func set_shake(value: bool):
	shake = value
	set_process(shake)
	offset = Vector2()
	if shake:
		timer.start()
		print("timer started")
		
#func connect_to_shakers():
#	for camera_shaker in get_tree().get_nodes_in_group("camera_shaker"):
#		camera_shaker.connect("camera_shake_requested", self, "_on_camera_shake_requested")
