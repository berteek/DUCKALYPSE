extends KinematicBody2D


var can_grab = false
var grabbed_offset = Vector2()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		can_grab = event.pressed
		grabbed_offset = position - get_global_mouse_position()

func _process(delta):
	if GlobalVariables.create == false:
		if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_grab:
			position = get_global_mouse_position() + grabbed_offset
	
func _on_Area2D_body_entered(body):
	_body_entered("int")

func _on_floatArea_body_entered(body):
	_body_entered("float")

func _on_boolArea_body_entered(body):
	_body_entered("bool")


func _on_stringArea_body_entered(body):
	_body_entered("string")


func _body_entered(value: String):
	print(GlobalVariables.labelValueKey)
	if(GlobalVariables.labelValueKey == value):
		GlobalVariables.goodOrBad = 1
		GlobalVariables.rightAnswers +=1
	else:
		GlobalVariables.goodOrBad = -1
		GlobalVariables.lifes -= 1
	self.get_child(0).get_child(0).visible = false
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	self.position.x = 640
	self.position.y = 72
	self.get_child(0).get_child(0).visible = true
	GlobalVariables.create = true
