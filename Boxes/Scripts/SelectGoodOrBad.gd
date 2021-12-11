extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	pass
func _process(delta):
	match GlobalVariables.goodOrBad: 
		1:
			self.set_frame(1)
		-1:
			self.set_frame(2)
		0:
			self.set_frame(0)
