extends Node2D


func _on_Timer_timeout():
	GlobalVariables.lose_state()

func _process(delta):
	if (GlobalVariables.rightAnswers >= GlobalVariables.total and GlobalVariables.in_game):
		win_state()
	elif (GlobalVariables.lifes <= 0 and GlobalVariables.in_game):
		lose_state()

func win_state():
	$Timer.stop()
	$WinScreen.visible = true

func lose_state():
	$Timer.stop()
	$LoseScreen.visible = true

func _on_Button_pressed():
	$ColorRect.queue_free()
	$Timer.start()

func _on_RestartButton_pressed():
	GlobalVariables.reset()
	get_tree().reload_current_scene()


func _on_MenuButton_pressed():
	get_tree().change_scene("res://menu/Menu.tscn")
	GlobalVariables.in_game = false
	GlobalVariables.reset()
