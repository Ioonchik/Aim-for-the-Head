extends Node2D

var night = false

var player_max_health = 0

func _ready():
	randomize()
	var visible_rect = get_viewport().get_visible_rect()
	
	$Player.position.x = visible_rect.size.x/1280*360
	$Weapon.position.x = $Player.position.x + 60
	$Spawner.position.x = visible_rect.size.x/1280
	$DarkRect.size = get_viewport().size
	$DarkRect.position = visible_rect.position-Vector2(100, 100)
	
	
	$HUD/Stats/AmmoBar/BulletCountBar.max_value = global.max_bullets
	player_max_health = $Player.health
	$HUD/Stats/HealthBar/HealthCountBar.max_value = player_max_health
	global.player_pos_x = $Player.position.x
	$HUD/Cooldown.hide()
	global.session_kills = 0
	global.wave_kills = 0
	
	$HUD.message("Wave: 1", "Wave")


func _process(delta):
	$HUD/Stats/AmmoBar/BulletCountBar.value = global.bullets
	$HUD/Stats/HealthBar/HealthCountBar.value = $Player.health
	$HUD/Stats/AmmoBar/BulletCount.text = "Ammo: " + str(global.bullets) + ' / ' + str(global.max_bullets)
	$HUD/Stats/HealthBar/HealthCount.text = "Health: " + str($Player.health) + ' / ' + str(player_max_health)
	$HUD/Kills/Label.text = ": " + str(global.session_kills)
	$HUD/Cooldown.text = str($Weapon/Cooldown.time_left).substr(0, 3) + "s"
	$HUD/Stats/Soul/SoulCount.text = ": " + str(global.souls)
	
	$HUD/WaveProgress.value = global.wave_kills
	
#	$Label.text = str(get_viewport().size) + "   " + str(get_viewport().position)
#	$Label2.text = str(get_viewport().get_visible_rect().size)  + "   " + str(get_viewport().get_visible_rect().position)
#	$Label3.text = str($DarkRect.size) + "   " + str($DarkRect.position)


func _on_weapon_cooldown_signal(a: bool):
	if(a):
		$HUD/Cooldown.show()
	else:
		$HUD/Cooldown.hide()


func _on_spawner_wave_ended(wave):
	wave = str(wave)
	
	if(wave == "Merchant"):
		$HUD.message("Merchant", "Merchant")
		$Weapon.can_shoot = false
	else:
		$HUD.message("Wave: " + wave, "Wave")
		
		$BG.next_wave()
		var bg_tween = get_tree().create_tween().set_parallel()
		bg_tween.tween_property($BG, "position", Vector2($BG.position.x - 1280, 0), 1.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
		
		global.wave_kills = 0
		$HUD/WaveProgress.max_value = round($Spawner.wave_spawn[-1])

func _on_player_died():
	$HUD.message("You Died", "Die")


#func day_night():
#	await get_tree().create_timer(2).timeout
#	$BG.day_night()
#	var dark_tween = create_tween().set_parallel()
#	dark_tween.tween_property($DarkRect, "color", Color(0, 0, 0, 1), 2).set_trans(Tween.TRANS_SINE)
#	dark_tween.tween_property(self, "modulate", Color(0.4, 0.4, 0.4, 1), 2).set_trans(Tween.TRANS_SINE)
#	var dark_items = [$Player, $Spawner, $Weapon]
#	for i in dark_items:
#		dark_tween.tween_property(i, "modulate", Color(0.2, 0.2, 0.2, 1), 2).set_trans(Tween.TRANS_SINE)


#func _input(event):
#	if event is InputEventMouseButton:
##		for i in get_children():
##			if(i.name != "HUD" and i.name != "BGAnim"):
##				var dark_tween = create_tween()
##				dark_tween.tween_property(i, "modulate", Color(0.2, 0.2, 0.2, 1), 2).set_trans(Tween.TRANS_SINE)
##				$Moon/TextureRect/PointLight2D.enabled = true
##				dark_tween.tween_property($Moon, "position:y", get_viewport().get_visible_rect().position.y+30, 2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
##				await dark_tween.finished
##				night = true
