extends Node2D

var mainscene = "res://Main_scene/Skillshot trainer.tscn"



func _on_Button_button_down():
	print("button pressed")
	SceneChanger.change_scene(mainscene)
