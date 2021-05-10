extends Node2D

var counter := 0
var wavecount := 0
var killcount := -1
#wave 7 starts to get hard
var Enemy = preload("res://Enemy/Enemy.tscn")
var Player = preload("res://Player/Player.tscn")
var Wood = preload("res://elo_tiers/Wood.tscn")
var Silver = preload("res://elo_tiers/Silver.tscn")
var Gold = preload("res://elo_tiers/Gold.tscn")
var Platinum = preload("res://elo_tiers/Platinum.tscn")
var Diamond = preload("res://elo_tiers/Diamond.tscn")

onready var Pathfollow2d = $Path2D/PathFollow2D
onready var timer = $Timer
onready var label_wavecount = $Node2D/ColorRect/Wavecount
onready var label_killcount = $Node2D/ColorRect/Killcount
onready var spawnpoint = $SpawnPoint
onready var player = $Player
onready var screenshake = $Camera2D/ScreenShake

func _ready():
	randomize()
	update_wavecount()
	update_killcount()
	player.connect("you_died", self, "_on_Player_you_died")
	player.connect("you_fired", screenshake, "start")
	

func _physics_process(delta):
	if Input.is_action_just_pressed("r_key") and !Playerposition.alive:
		restart()

func _on_Timer_timeout(): #spawns enemy
	var enemy = Enemy.instance()
	
	add_child(enemy)
	enemy.connect("enemykilled", self, "update_killcount")
	Pathfollow2d.unit_offset = randf()
	enemy.start(Pathfollow2d.global_position, Pathfollow2d.global_rotation + PI/2)
	counter += 1
	if counter == 10:
		if wavecount < 6:
			timer.wait_time -= 0.05
		else:
			timer.wait_time -= 0.01
		counter = 0
		wavecount += 1
		update_wavecount()

func update_wavecount():
	label_wavecount.text = "WAVECOUNT = " + str(wavecount)

func update_killcount():
	killcount += 1
	label_killcount.text = "KILLCOUNT = " + str(killcount)
	match killcount:
		10:
			var wood = Wood.instance()
			add_child(wood)
		30:
			var silver = Silver.instance()
			add_child(silver)
		50:
			var gold = Gold.instance()
			add_child(gold)
		70:
			var platinum = Platinum.instance()
			add_child(platinum)
		90:
			var diamond = Diamond.instance()
			add_child(diamond)

func update_gameover():
	label_wavecount.text = "GAMEOVER \n(R to restart)"

func _on_Player_you_died():
	update_gameover()
	timer.stop()
	Playerposition.alive = false
	print(Playerposition.alive)

func restart():
	randomize()
	SceneChanger.play_fade()
	yield(SceneChanger, "fade_finished")
	var player = Player.instance()
	get_tree().current_scene.add_child(player)
	player.connect("you_died", self, "_on_Player_you_died")
	player.connect("you_fired", screenshake, "start")
	player.global_position = spawnpoint.global_position
	Playerposition.alive = true
	counter = 0
	wavecount = 0
	killcount = -1
	timer.start(0.7)
	update_wavecount()
	update_killcount()
