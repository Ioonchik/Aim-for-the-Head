extends Node2D

var cloud_path = preload("res://Scenes/cloud.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer_start()

# Called every frame. 'delta' is the elapsed time since the previous frame.

func timer_start():
	$CloudTimer.wait_time = randi_range(5, 13)
	$CloudTimer.start()

func _on_cloud_timer_timeout():
	var cloud = cloud_path.instantiate()
	$Clouds.add_child(cloud)
	timer_start()
