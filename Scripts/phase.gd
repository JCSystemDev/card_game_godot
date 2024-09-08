class_name Phase extends Node2D

enum phase {draw, summon, battle}
enum state {ingame, win, lose}
var phases: Array = ["DRAW PHASE", "PAY PHASE", "SUMMON PHASE", "ATTACK PHASE", "DEFENSE PHASE"]
var current_phase
var current_state
@onready var game_zone: GameZone = $".."
@onready var phase_label: Label = $"Label/Phase Label"
@onready var phase_button: Button = $"Button/Phase Button"
@onready var button_node: Node2D = $Button
@onready var label_node: Node2D = $Label

func _ready():
	AudioManager.play_music("Battle.mp3")
	current_state = state.ingame
	phase_label.set_text("START PHASE")
	TweenManager._appear_tween(label_node)
	phase_button.hide()
	await get_tree().create_timer(1).timeout
	_states(state.ingame)
	_draw_phase()

func _states(_state):
	match _state:
		state.ingame:
			pass
		state.win:
			AudioManager.play_music("Victory Fanfare.mp3")
			DataManager.player_stats[0]["player_exp"] += game_zone.enemy.exp_points
			game_zone.notifications.exp_label.set_text(str("YOU GOT ",game_zone.enemy.exp_points," EXP POINTS"))
			game_zone.notifications.animation_player.play("show")
			game_zone.notifications.endgame_label.set_text("YOU WIN")
			game_zone.notifications.show()
			game_zone.notifications.win_buttons.show()
			game_zone.enemy.hide()
			phase_button.hide()
			game_zone.deck.hide()
			game_zone.discard_pile.hide()
			game_zone.hand.hide()
			phase_label.hide()
		state.lose:
			game_zone.notifications.endgame_label.set_text("YOU LOSE")
			game_zone.notifications.animation_player.play("show")
			game_zone.notifications.show()
			game_zone.notifications.lose_buttons.show()
			game_zone.enemy.hide()
			phase_button.hide()
			game_zone.deck.hide()
			game_zone.discard_pile.hide()
			game_zone.hand.hide()
			phase_label.hide()
			game_zone.player.player_anim.play("player_death")
			AudioManager.play_music("Game Over.mp3")

func _draw_phase():
	phase_button.hide()
	current_phase = phase.draw
	_draw_cards()
	await get_tree().create_timer(1.5).timeout
	_get_gold()
	await get_tree().create_timer(1).timeout
	AudioManager.play_sound("Summon.wav")
	current_phase = phase.summon
	phase_label.set_text(phases[2])
	TweenManager._appear_tween(label_node)
	phase_button.show()
	TweenManager._appear_tween(button_node)
	
func _draw_cards():
	phase_label.set_text(phases[0])
	TweenManager._appear_tween(label_node)
	game_zone.deck._full_hand()

func _get_gold():
	phase_label.set_text(phases[1])
	TweenManager._appear_tween(label_node)
	game_zone.player.current_gold += DataManager.player_stats[0]["player_gold"]
	AudioManager.play_sound("Magic.wav")
	game_zone.player.player_anim.play("player_gold")
	await game_zone.player.player_anim.animation_finished
	
func _on_button_pressed():
	match current_phase:
		phase.summon:
			_battle_phase()
			
func _attack():
	phase_label.set_text(phases[3])
	TweenManager._appear_tween(label_node)
	var attack_damage: int = 0
	attack_damage = game_zone.player.current_attack - game_zone.enemy.current_defense
	if attack_damage < 0:
		attack_damage = 0
	game_zone.enemy.current_hp -= attack_damage
	AudioManager.play_sound("Attack Phase.wav")
	if game_zone.enemy.current_hp > 0:
		TweenManager._shake_tween(game_zone.enemy)
		game_zone.enemy.enemy_animation.play("damage_enemy")
		await game_zone.enemy.enemy_animation.animation_finished
	else:
		game_zone.enemy.enemy_animation.play("death_enemy") 
		await game_zone.enemy.enemy_animation.animation_finished
		current_state = state.win
		_states(state.win)

func _defense():
	phase_label.set_text(phases[4])
	TweenManager._appear_tween(label_node)
	var defense_damage: int = 0
	defense_damage = game_zone.enemy.current_attack - game_zone.player.current_defense
	if defense_damage < 0:
		defense_damage = 0
	game_zone.player.current_hp -= defense_damage 
	AudioManager.play_sound("Defense Phase.wav")
	if game_zone.player.current_hp > 0:
		TweenManager._shake_tween(game_zone.player)
		game_zone.player.player_anim.play("player_damage")
		await game_zone.player.player_anim.animation_finished
		_draw_phase()
	else:
		game_zone.player.current_hp = 0
		game_zone.player.player_anim.play("player_death")
		await game_zone.player.player_anim.animation_finished
		current_state = state.lose
		_states(current_state) 
		
func _battle_phase():
	current_phase = phase.battle
	_attack()
	await get_tree().create_timer(1).timeout
	if current_state == state.ingame:
		_defense()
		await get_tree().create_timer(1.5).timeout
