extends "res://Scenes/enemy.gd"

var flight_height = 250
var attack_speed = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = randi_range(80, 120)
	health = 3
	multiplier_to_hit = 0.5
	multiplier_to_damage = 1.5
	soul = 7
	position.y = flight_height
	$AnimationPlayer.speed_scale = randf_range(0.5, 1.5)
	$AnimationPlayer.play("idle")
	$HealthBar.max_value = health


func _physics_process(delta):
	var player_pos = get_parent().get_parent().get_parent().get_node("Player").position
	position.x -= speed * delta
	if(position.x <= player_pos.x+100):
		var direction = (player_pos - global_position).normalized()
		move_and_collide(direction * attack_speed * delta)


func _on_attack_area_area_entered(area):
	if(area and not dying):
		$AnimationPlayer.speed_scale = 1
		speed = 0
		attack_speed = 0
		die()
