extends Node2D


var labelValue = {}
var labelValueKey
var goodOrBad = 0
var create : bool = true
var rightAnswers = 0
var total = 10
var lifes = 3
var in_game = false

func _ready():
	labelValue = {
	"int":[1,110,24,9], 
	"float":[4.5,11.55,100.4,66.425],
	"bool":[true,false,true,false],
	"string":["УТКИ","хорошо","КРОКОДИЛЫ","плохо"]
	}

		
func win_state():
	get_tree().change_scene("res://menu/Menu.tscn")
	in_game = false
	reset()
	
func lose_state():
	get_tree().change_scene("res://menu/Menu.tscn")
	in_game = false
	reset()

func reset():
	labelValue = {}
	goodOrBad = 0
	create = true
	rightAnswers = 0
	total = 10
	lifes = 3
	in_game = true
	labelValue = {
	"int":[1,110,24,9], 
	"float":[4.5,11.55,100.4,66.425],
	"bool":[true,false,true,false],
	"string":["УТКИ","хорошо","КРОКОДИЛЫ","плохо"]
	}
