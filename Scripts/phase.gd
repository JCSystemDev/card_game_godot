class_name Phase extends Node2D

enum phase {draw, pay, summon, attack, defense}
enum state {ingame, win, lose}
var phases: Array = ["DRAW PHASE", "PAY PHASE", "SUMMON PHASE", "ATTACK PHASE", "DEFENSE PHASE"]
var current_phase
var current_state

@onready var game_zone: GameZone = $".."
@onready var phase_label: Label = $"Phase Label"
@onready var phase_button: Button = $"Phase Button"

func _ready():
	phase_button.grab_focus()
	game_zone.deck._full_hand()
	phase_label.set_text(phases[0])
	current_phase = phase.pay
	_states(state.ingame)
	
	
func _process(_delta):
	pass


func _states(_state):
	match _state:
		state.ingame:
			AudioManager.play_music("Battle.mp3")
		state.win:
			game_zone.notifications.endgame_label.set_text("YOU WIN")
			game_zone.notifications.visible = true
			game_zone.enemy.visible = false
			phase_button.visible = false
			game_zone.deck.visible = false
			game_zone.discard_pile.visible = false
			game_zone.hand.visible = false
			phase_label.visible = false
			AudioManager.play_music("Victory Fanfare.mp3")
		state.lose:
			game_zone.notifications.endgame_label.set_text("YOU LOSE")
			game_zone.notifications.visible = true
			game_zone.enemy.visible = false
			phase_button.visible = false
			game_zone.deck.visible = false
			game_zone.discard_pile.visible = false
			game_zone.hand.visible = false
			phase_label.visible = false
			game_zone.player.player_anim.play("player_death")
			AudioManager.play_music("Game Over.mp3")
			

func _on_button_pressed():
	match current_phase:
		phase.draw:
			phase_label.set_text(phases[0])
			game_zone.deck._full_hand()
			current_phase = phase.pay
			AudioManager.play_sound("Draw Phase.wav")
		phase.pay:
			phase_label.set_text(phases[1])
			game_zone.player.current_gold += DataManager.player_stats[0]["player_gold"]
			current_phase = phase.summon
			AudioManager.play_sound("Magic.wav")
		phase.summon:
			phase_label.set_text(phases[2])
			current_phase = phase.attack
			AudioManager.play_sound("Summon.wav")
		phase.attack:
			var attack_damage: int = 0
			attack_damage = game_zone.player.current_attack - game_zone.enemy.current_defense
			if attack_damage < 0:
				attack_damage = 0
			game_zone.enemy.current_hp -= attack_damage
			phase_label.set_text(phases[3])
			current_phase = phase.defense
			AudioManager.play_sound("Attack Phase.wav")
			if game_zone.enemy.current_hp > 0:
				var shake = create_tween()
				game_zone.enemy.enemy_animation.play("damage_enemy")
				for times in 5:
					shake.tween_property(game_zone.enemy,"position", Vector2(game_zone.enemy.position.x + 5,game_zone.enemy.position.y),0.025)
					shake.tween_property(game_zone.enemy,"position", Vector2(game_zone.enemy.position.x - 5,game_zone.enemy.position.y),0.025)
				shake.tween_property(game_zone.enemy,"position", Vector2(game_zone.enemy.position.x,game_zone.enemy.position.y),0.025)
			else:
				game_zone.enemy.enemy_animation.play("death_enemy") 
				await game_zone.enemy.enemy_animation.animation_finished
				_states(state.win)
				
		phase.defense:
			phase_label.set_text(phases[4])
			current_phase = phase.draw
			var defense_damage: int = 0
			defense_damage = game_zone.enemy.current_attack - game_zone.player.current_defense
			if defense_damage < 0:
				defense_damage = 0
			var shake = create_tween()
			for times in 5:
				shake.tween_property(game_zone.player.stats_display, "position", Vector2(5, game_zone.player.stats_display.position.y), 0.025)
				shake.tween_property(game_zone.player.stats_display, "position", Vector2(-5, game_zone.player.stats_display.position.y), 0.025)
			shake.tween_property(game_zone.player.stats_display, "position", Vector2(game_zone.player.stats_display.position.x, game_zone.player.stats_display.position.y), 0.025)
			AudioManager.play_sound("Defense Phase.wav")
			game_zone.player.player_anim.play("player_damage")
			game_zone.player.current_hp -= defense_damage 
			if game_zone.player.current_hp <= 0:
				game_zone.player.current_hp = 0
				current_state = state.lose
				_states(current_state)
				
