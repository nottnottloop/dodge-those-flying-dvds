extends CharacterBody2D
signal hit

@onready var control = %Control

@export var speed = 400

var screen_size
var is_dead := false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_dead == false:
		var velocity = Vector2.ZERO # The player's movement vector.
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1

		#$AnimatedSprite2D.animation = "Neutral"
		if velocity.x > 0:
			if velocity.y < 0:
				$AnimatedSprite2D.animation = "UpRight"
			elif velocity.y > 0:
				$AnimatedSprite2D.animation = "DownRight"
			else:
				$AnimatedSprite2D.animation = "Right"
		elif velocity.x < 0:
			if velocity.y < 0:
				$AnimatedSprite2D.animation = "UpLeft"
			elif velocity.y > 0:
				$AnimatedSprite2D.animation = "DownLeft"
			else:
				$AnimatedSprite2D.animation = "Left"
		elif velocity.y < 0:
			$AnimatedSprite2D.animation = "Up"
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "Down"


		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()

	#position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	
		move_and_collide(velocity * delta)



func _on_collide(body):
	is_dead = true
	$AnimatedSprite2D.play("Dead")
	control.visible = true
