extends Node2D

class_name Square

var rect
var color
var filled

func _draw():
	draw_rect(rect, color, filled)

func _init(_rect, _color, _filled):
	rect = _rect
	filled = _filled
	color = _color
	

