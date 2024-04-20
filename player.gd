extends CharacterBody2D

@export var speed = 50;
var animatedSprite: AnimatedSprite2D;



# Called when the node enters the scene tree for the first time.
func _ready():
	
	animatedSprite = get_node("AnimatedSprite2D");
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	var moveDir = Input.get_vector("player_walk_left","player_walk_right","player_walk_up","player_walk_down");
	velocity = moveDir.normalized() * speed;
	move_and_collide(velocity * delta);
	
	
	if moveDir.y > 0:
		animatedSprite.play("walk_down");
	elif moveDir.y < 0:
		animatedSprite.play("walk_up");
	elif moveDir.x >0:
		animatedSprite.play("walk_right");
	elif moveDir.x <0:
		animatedSprite.play("walk_left");
	else:
		animatedSprite.stop();
