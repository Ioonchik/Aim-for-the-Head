extends Node2D

signal wave_ended(wave)

var path_apple = preload("res://Scenes/enemies/apple.tscn")
var path_hornet = preload("res://Scenes/enemies/hornet.tscn")
var path_flower = preload("res://Scenes/enemies/flower.tscn")

var mobs = [path_apple, path_hornet]
var mob_variations = len(mobs)

var to_spawn = 3
var wave = 0
var wave_spawn = [3]

var merchant_wave = 1 #randi_range(2, 4)
var night_wave = 0#randi_range(3, 8)

func _ready():
	mobTimerStart()
#	get_parent().day_night()

func _process(delta):
	if(to_spawn <= 0 and $Mobs.get_child_count() == 0):
		wave_end()
	

func wave_end():
	wave += 1
	wave_spawn.append(wave_spawn[-1] * 1.2)
	to_spawn = round(wave_spawn[wave])
	merchant_wave -= 1
	night_wave -= 1
	
	if(merchant_wave == 0):
		emit_signal("wave_ended", "Merchant")
		return 0
	
	wave_start()

func wave_start():
	emit_signal("wave_ended", wave+1)
	await get_tree().create_timer(1).timeout
	$MobTimer.emit_signal("timeout")
	
	if(night_wave == 0):
		get_parent().day_night()
#	var timer = Timer.new()
#	timer.wait_time = 1
#	add_child(timer)
#	timer.start()
#	await timer.timeout
#
#	var mob = randi_range(0, mob_variations-1)
#	spawn(mobs[mob])

func spawn(path):
	var enemy = path.instantiate()
	enemy.position.x = get_viewport_rect().size.x + 200
	if(enemy.name == "Apple"):
		enemy.position.y = 500
	enemy.get_node("AnimationPlayer").play("idle")
	$Mobs.add_child(enemy)
	
	to_spawn -= 1
	
	if(to_spawn > 0):
		mobTimerStart() 

func mobTimerStart():
	$MobTimer.wait_time = randf_range(1, 4)
	$MobTimer.start()

func _on_mob_timer_timeout():
	var mob = randi_range(0, mob_variations-1)
	spawn(mobs[mob])
