extends Sprite2D

var snap_point: Node2D
var snap_distance: float = 50
var dragging := false
var original_position: Vector2

func _ready():
	set_process(true)
	original_position = global_position
	z_index = 1
	snap_point = get_parent().get_node("SnapPoint_Pant")

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var mouse_pos = get_global_mouse_position()
			var hat_size = texture.get_size() * global_scale
			var hat_rect = Rect2(global_position - hat_size * 0.5, hat_size)
			if hat_rect.has_point(mouse_pos):
				dragging = true
		else:
			if dragging:
				dragging = false
				check_snap()

func check_snap():
	if global_position.distance_to(snap_point.global_position) < snap_distance:
		global_position = snap_point.global_position
	else:
		global_position = original_position
