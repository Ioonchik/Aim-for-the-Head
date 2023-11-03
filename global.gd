extends Node

var dmg = 0

var player_pos_x = 0

var session_kills = 0
var wave_kills = 0

var max_bullets = 10
var bullets = 10

var souls = 0
func score_gain(type, amount):
	var score_tween = create_tween()
	score_tween.tween_method(set_score, souls, souls+amount, 0.7)

func set_score(amount):
	souls = amount

var bow_damage_level = 1
var bow_damage_price: int = 50
