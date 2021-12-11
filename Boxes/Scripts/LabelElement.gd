extends Label
#придумать как избегать показанные значения!!!!
var keys = ["int","float","bool","string"]
var rnd = RandomNumberGenerator.new()
var value
var hadSeenValue = {}
func create_value():
	GlobalVariables.create = false
	var flag = true
	var flag2 = true
	var key
	var value
	GlobalVariables.goodOrBad = 0
	rnd.randomize()
	key = rnd.randi_range(0,3)
	rnd.randomize()
	value = rnd.randi_range(0,3)
	if (GlobalVariables.in_game):
		self.text = String(GlobalVariables.labelValue[keys[key]][value])
	GlobalVariables.labelValueKey = keys[key]
func _process(delta):
	if GlobalVariables.create == true:
		create_value()
	
