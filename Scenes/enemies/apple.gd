extends "res://Scenes/enemy.gd"

var jump = false
var stop = false


# Called when the node enters the scene tree for the first time.
func _ready():
	print(multiplier_to_damage)
	shadow(1.0, Vector2(0, 20))
	$HealthBar.max_value = health
	dying = false
	soul = 5
	multiplier_to_hit = 1
	speed = randi_range(400, 600)

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _physics_process(delta):
	position.x -= speed * delta


func _on_attack_area_area_entered(area):
	if(area and not dying):
		die()
