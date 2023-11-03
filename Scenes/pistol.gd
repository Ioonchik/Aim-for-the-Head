extends CharacterBody2D

var SPEED = 50
var MAX_ROTATION = 30
var rotation_dir = 1
var current_rotation = 0

func _physics_process(delta):
	# Calculate the rotation based on the direction and speed
	current_rotation += rotation_dir * SPEED * delta
	if abs(current_rotation) >= MAX_ROTATION:
		# If the rotation reaches the maximum value, change direction
		rotation_dir *= -1
	# Set the rotation of the pistol
	rotation_degrees = current_rotation
