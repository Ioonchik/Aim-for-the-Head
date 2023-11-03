extends Node2D

func _ready():
	$Timer.wait_time = $Particle.lifetime
	$SubViewport/Label.text = str(global.dmg)


#func _on_timer_timeout():
#	queue_free()
