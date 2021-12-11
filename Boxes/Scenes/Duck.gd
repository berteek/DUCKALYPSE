extends AnimatedSprite


func _process(delta):
	match GlobalVariables.goodOrBad: 
		1:
			self.set_frame(2)
		-1:
			self.set_frame(1)
		0:
			self.set_frame(0)
