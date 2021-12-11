extends Control


func _on_WarButton_pressed():
	get_tree().change_scene("res://tanks/World.tscn")


func _on_SortButton_pressed():
	get_tree().change_scene("res://Boxes/Scenes/MainScene.tscn")
	GlobalVariables.in_game = true
