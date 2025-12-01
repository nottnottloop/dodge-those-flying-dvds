extends CharacterBody2D

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	
	move_and_collide(velocity * delta)
