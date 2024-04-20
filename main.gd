extends Node2D

var tileMap: TileMap;

var plants: Dictionary = {};

var timer: Timer;

# Called when the node enters the scene tree for the first time.
func _ready():
	tileMap = get_node("%WorldMap");
	timer = get_node("Timer");
	
	timer.set_wait_time(3.0);
	timer.start();

		
	
	pass # Replace with function body.

func timer_plant():
	if plants == null || plants.is_empty():
		return;
	for plantPos in plants:
		if plants[plantPos] < 4:
			plants[plantPos] = plants[plantPos] +1;
			var vec = Vector2i(plants[plantPos], 7);
			tileMap.set_cell(6,plantPos,0,vec);
		else: 
			continue;
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var mousePos = get_global_mouse_position();
		var plantPos = tileMap.local_to_map(mousePos);
		
		var tileData = tileMap.get_cell_tile_data(5,plantPos);
		
		if tileData ==null:
			return;
		
		var isLand = tileData.get_custom_data("island");
		
		if isLand != null || isLand  && !plants.has(plantPos):
			tileMap.set_cell(6,plantPos,0,Vector2i(0,7));
			plants[plantPos] = 0;
	pass


func _on_timer_timeout():
	timer_plant();
	pass # Replace with function body.
