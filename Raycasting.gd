extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cell_size = Vector2(16, 16)
var map_size = Vector2(int(426 / cell_size.x) + 1, int(240 / cell_size.y) + 1)
var vec_map = []

# Called when the node enters the scene tree for the first time.
func _ready():
	vec_map.resize(map_size.x * map_size.y)
	vec_map[map_size.y * 2 + 20] = 1

func _index_to_xy(i):
	var x = i % int(map_size.x)
	var y = int(i / map_size.x)
	return [x, y]

func _xy_to_index(xy):
	return xy.y * map_size.x + xy.x

func _process(delta):
	update()

func _draw():
	for y in range(map_size.y):
		var a = Vector2(0, y * cell_size.y)
		var b = Vector2(map_size.x * cell_size.x, y * cell_size.y) 
		draw_line(a, b, Color(255, 255, 255), 2)
		for x in range(map_size.x):
			var a1 = Vector2(cell_size.x * x, 0)
			var b1 = Vector2(cell_size.x * x, map_size.y * y) 
			draw_line(a1, b1, Color(255, 255, 255), 2)
	#############################################################################	
	# for i in range(vec_map):
	# 	var x = y % i
	# 	var y = int(i / map_size.y)
	# 	print([x, y])	
	# 	draw_rect(Rect2(w * int, HEIGHT - height, w, height), Color.white)
	# 		draw_line(Vector2(0,0), Vector2(50, 50), Color(255, 0, 0), 1)
	# for (int y = 0; y < vMapSize.y; y++)
	# 	{
	# 		for (int x = 0; x < vMapSize.x; x++)
	# 		{
	# 			int cell = vecMap[y * vMapSize.x + x];
	# 			if (cell == 1)
	# 				FillRect(olc::vi2d(x, y) * vCellSize, vCellSize, olc::BLUE);

	# 			// Draw Cell border
	# 			DrawRect(olc::vi2d(x, y) * vCellSize, vCellSize, olc::DARK_GREY);
	# 		}
	# 	}

func _mouse_to_vec(mouse):
	return Vector2(int(mouse.x / cell_size.x), int(mouse.y / cell_size.y))

func _input(ev):
	if ev.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if ev is InputEventMouseButton:
		if ev.button_index == 1 and ev.pressed:
			vec_map[_xy_to_index(_mouse_to_vec(ev.position))] = 1
		if ev.button_index == 2 and ev.pressed:
			print("RMB")

