extends Camera2D

var target = self.position
var dragging

var movement = 200.0

func _process(delta):
	if target.x < 0:
		target.x = 0
	if target.y < 0:
		target.y = 0
	
	translate(target - self.position)
		
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_D:
			target += Vector2(movement, 0)
		if event.pressed and event.scancode == KEY_A:
			target += Vector2(movement * -1, 0)
		if event.pressed and event.scancode == KEY_W:
			target += Vector2(0, movement * -1)
		if event.pressed and event.scancode == KEY_S:
			target += Vector2(0, movement)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT:
			dragging = event.pressed	
						
	if event is InputEventMouseMotion:
		if dragging:
			target -= event.relative
			
