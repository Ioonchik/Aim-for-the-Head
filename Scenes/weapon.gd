extends CharacterBody2D

signal cooldown_signal(a: bool)

var path_bullet = preload("res://Scenes/bullet.tscn")

var SPEED = 110
var MAX_ROTATION = 50
var rotation_dir = 1
var current_rotation = 0

var BULLET_SPEED = 1200

var cooldown = true
var can_shoot = true


func _ready():
	global.bullets = global.max_bullets

func _physics_process(delta):
	# Calculate the rotation based on the direction and speed
	current_rotation += rotation_dir * SPEED * delta
	if abs(current_rotation) >= MAX_ROTATION:
		# If the rotation reaches the maximum value, change direction
		rotation_dir *= -1
	# Set the rotation of the pistol
	rotation_degrees = current_rotation

func shoot():
	if(global.bullets > 0):
		var bullet = path_bullet.instantiate()
		# Set the position of the bullet
		bullet.position = position + Vector2(50 * abs(rotation_dir), 0).rotated(deg_to_rad(current_rotation))
		# Set the rotation of the bullet
		bullet.rotation_degrees = rotation_degrees
		# Add the bullet to the scene
		get_parent().add_child(bullet)
		bullet.apply_impulse(Vector2(BULLET_SPEED * abs(rotation_dir), 0).rotated(deg_to_rad(current_rotation)))
		
		global.bullets -= 1
		
		cooldown = false
		$Cooldown.start()
		emit_signal("cooldown_signal", true)

func _input(event):
	if event is InputEventScreenTouch and can_shoot:
		if event.pressed and cooldown:
			shoot()


func _on_cooldown_timeout():
	cooldown = true
	emit_signal("cooldown_signal", false)
