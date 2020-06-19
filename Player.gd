extends Area2D


signal hit

export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
var target = Vector2() # Tapped/clicked position


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	# Move towards the target and stop when close.
	if position.distance_to(target) > 10:
		velocity = target - position
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		_set_animation_type(velocity)
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		target = event.position


func _on_Player_body_entered(body):
	hide()  # Player disappears after being hit.
	emit_signal("hit")

	# Disable the player's collision so we don't emit "hit" more than once.
	$CollisionShape2D.set_deferred("disabled", true)


func _set_animation_type(velocity):
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

func start(pos):
	position = pos
	target = pos
	show()
	$CollisionShape2D.disabled = false
