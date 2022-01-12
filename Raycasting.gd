extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cell_size = Vector2(16, 16)
var map_size = Vector2(int(426 / cell_size.x) + 1, int(240 / cell_size.y) + 1)
var vec_map = []
var player = Vector2(0, 0)
var show_grid = false

# Called when the node enters the scene tree for the first time.
func _ready():
	vec_map.resize(map_size.x * map_size.y)
	vec_map[map_size.y * 2 + 20] = 1

func _index_to_xy(i):
	var x = i % int(map_size.x)
	var y = int(i / map_size.x)
	return Vector2(x, y)

func _xy_to_index(xy):
	return xy.y * map_size.x + xy.x

func _process(delta):
	update()

func _draw_grid():
	for y in range(map_size.y):
		var a = Vector2(0, y * cell_size.y)
		var b = Vector2(map_size.x * cell_size.x, y * cell_size.y) 
		draw_line(a, b, Color(255, 255, 255), 2)
		for x in range(map_size.x):
			var a1 = Vector2(cell_size.x * x, 0)
			var b1 = Vector2(cell_size.x * x, map_size.y * y) 
			draw_line(a1, b1, Color(255, 255, 255), 2)

func _draw():
	if show_grid:
		_draw_grid()
	for i in range(len(vec_map)):
		if vec_map[i] == 1:
			var xy = _index_to_xy(i)
			draw_rect(Rect2(xy.x * cell_size.x, xy.y * cell_size.y, cell_size.x, cell_size.y), Color.green)
	draw_circle(player, cell_size.x / 2 - 1, Color.red)

func _mouse_to_vec(mouse):
	return Vector2(int(mouse.x / cell_size.x), int(mouse.y / cell_size.y))

func _input(ev):
	if ev.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if ev is InputEventMouseMotion:
		print(ev.is_pressed())
	if ev is InputEventMouseButton:
		if ev.button_index == 1 and ev.pressed:
			vec_map[_xy_to_index(_mouse_to_vec(ev.position))] = 1
		if ev.button_index == 2 and ev.pressed:
			print("RMB")
	if ev is InputEventKey and ev.scancode == KEY_Q and ev.pressed and not ev.echo:
		show_grid = !show_grid
		# if (GetKey(olc::Key::W).bHeld) vPlayer.y -= 25.0f * fElapsedTime;
		# if (GetKey(olc::Key::S).bHeld) vPlayer.y += 25.0f * fElapsedTime;
		# if (GetKey(olc::Key::A).bHeld) vPlayer.x -= 25.0f * fElapsedTime;
		# if (GetKey(olc::Key::D).bHeld) vPlayer.x += 25.0f * fElapsedTime;
