extends Node2D


var instructionscene = "res://MainMenu/InstructionScreen.tscn"

func _on_Button_pressed():
	print("button pressed")
	SceneChanger.change_scene(instructionscene)
	#get_tree().change_scene_to(mainscene)
#	var Mainscene = mainscene.instance()
#	get_tree().set_current_scene(Mainscene)
	
