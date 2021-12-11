extends Node2D

onready var entities = get_tree().get_nodes_in_group("Entities")
onready var crocodiles = get_tree().get_nodes_in_group("Crocodiles")
onready var ducks = get_tree().get_nodes_in_group("Ducks")


func _ready():
	$CrocodileDialog.visible = false

func _on_Button_pressed():
	var text = $ColorRect/TextEdit.text
	
	var available_commands = ["if", "iterate", "shoot", "is", "next"]
	var available_classes = ["Entity", "Duck", "Crocodile"]
	var available_collections = ["entities"]

	var collections = {
		"entities" : entities
	}
	var objects = {}
	var classes = {
		"Entity" : Entity,
		"Crocodile" : Crocodile,
		"Duck" : Duck
	}

	# split text
	var textArray = text.split("\n")
	var indices_to_remove = []
	for i in range(textArray.size()):
		if (textArray[i] == ""):
			indices_to_remove.append(i)
		textArray[i] = textArray[i].strip_edges()
		textArray[i] = textArray[i].strip_escapes()

	
	# clear text array of white spaces
	for index in indices_to_remove:
		textArray.remove(index)
		for i in range(indices_to_remove.size()):
			indices_to_remove[i] -= 1
	
	
	print(textArray)
	
	
	# output unidentified words
	#for word in textArray:
	#	if !available_commands.has(word) or !available_classes.has(word) or !available_objects.has(word):
	#		error(word)
	
	
	# run code
	var loop_times = null
	var loop_count = null
	var loop_start_line = null
	var it = null
	var it_collection = null
	var is_iterating = false
	var i = 0
	var error = false
	while i < textArray.size():
		var words = textArray[i].split(" ")
		if !available_commands.has(words[0]):
			error()
			i = textArray.size()
			error = true
			break
		match words[0]:
			"iterate":
				if available_collections.has(words[1]):
					it_collection = collections[words[1]]
					loop_times = it_collection.size()
					loop_count = 0
					loop_start_line = i + 1
					it = it_collection[loop_count]
					objects[words[2]] = it
					is_iterating = true
					
					i += 1
				else:
					error()
					i = textArray.size()
					error = true
					break
			"next":
				if is_iterating and loop_count < loop_times - 1:
					i = loop_start_line
					loop_count += 1
					it = it_collection[loop_count]
				else:
					i += 1
					is_iterating = false
				
			"if":
				var next_line = textArray[i + 1].split(" ")
				if (next_line[0] == "is" and objects.has(next_line[1])):
					match next_line[2]:
						"Entity":
							if (it.is_in_group("Entities")):
								i += 2
							else:
								i += 3
						"Crocodile":
							if (it.is_in_group("Crocodiles")):
								i += 2
							else:
								i += 3
						"Duck":
							if (it.is_in_group("Ducks")):
								i += 2
							else:
								i += 3
						_:
							error()
							i = textArray.size()
							error = true
							break
				else:
					error()
					i = textArray.size()
					error = true
					break
					
			"shoot":
				if (words.size() < 2):
					error()
					i = textArray.size()
					error = true
					break
				if (words[1] != "it"):
					error()
					i = textArray.size()
					error = true
					break
				$Turret.set_frame(1)
				var t = Timer.new()
				t.set_wait_time(0.5)
				t.set_one_shot(true)
				add_child(t)
				t.start()
				yield(t, "timeout")
				$Turret.set_frame(0)
				it.die()
				t = Timer.new()
				t.set_wait_time(0.5)
				t.set_one_shot(true)
				add_child(t)
				t.start()
				yield(t, "timeout")
				i += 1
	
	if (!error):
		
		var lost = false
		
		for duck in ducks:
			if duck.is_dead:
				lose_state()
				lost = true
				break
		
		if !lost:
			for crocodile in crocodiles:
				if !crocodile.is_dead:
					lose_state()
					lost = true
					break
		
		if !lost:
			win_state()

func lose_state():
	$LoseScreen.visible = true
	
func win_state():
	$WinScreen.visible = true

func error():
	$ErrorScreen.visible = true


func _on_MenuButton_pressed():
	get_tree().change_scene("res://menu/Menu.tscn")


func _on_StartButton_pressed():
	$Briefing.visible = false
	$CrocodileDialog.visible = true
	var t = Timer.new()
	t.set_wait_time(6)
	t.set_one_shot(true)
	add_child(t)
	t.start()
	yield(t, "timeout")
	$CrocodileDialog.visible = false


func _on_ErrorButton_pressed():
	$ErrorScreen.visible = false
