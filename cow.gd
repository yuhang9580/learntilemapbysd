extends CharacterBody2D


@export var speed: int = 50;

var animatedSprite:AnimatedSprite2D;

var tileMap: TileMap;

var moveDir: Vector2;

var navigationAgent: NavigationAgent2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	tileMap = get_node("%WorldMap");
	animatedSprite = get_node("AnimatedSprite2D");
	
	navigationAgent = get_node("NavigationAgent2D");
	
	
	var layer = tileMap.get_navigation_map(0);
	navigationAgent.set_navigation_map(layer);
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var movePos = get_global_mouse_position();
		navigationAgent.target_position = movePos;


	var navigationStatus =  navigationAgent.is_navigation_finished();
	


	if !navigationStatus:

		var nextPos = navigationAgent.get_next_path_position()

		moveDir = position.direction_to(nextPos);

		velocity = moveDir.normalized() * speed;

		move_and_slide();
	else:

		velocity = Vector2.ZERO;
	
	
	if velocity.x >0:
		animatedSprite.play("walk_right");
	elif velocity.x < 0 :
		animatedSprite.play("walk_left");
	else:
		if moveDir.x >0:
			animatedSprite.play("idle_right");
		else:
			animatedSprite.play("idle_left");
