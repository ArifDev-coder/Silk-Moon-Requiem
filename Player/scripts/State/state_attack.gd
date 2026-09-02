class_name State_Attack extends State

var attacking: bool = false

@export var attack_sound: AudioStream
@export_range(1, 20, 0.5) var decelerate_speed: float = 5.0

@onready var idle: State = $"../Idle"
@onready var walk: State = $"../Walk"
@onready var hurt_box: HurtBox = %AttackHurtBox

@onready var animation_player: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var animation_player_attack: AnimationPlayer = $"../../AnimatedSprite2D/AttackEffectSprite/AnimationPlayer"

@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"


# func _ready() -> void:
# 	animation_player.frame_changed.connect(on_frame_changed)


#? What happens when the player enters this State?
func Enter() -> void:
	player.UpdateAnimation("attack")
	
	animation_player_attack.play("attack_" + player.AnimDirection())

	animation_player.animation_finished.connect(EndAttack)

	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()

	attacking = true

	await get_tree().create_timer(0.075).timeout

	hurt_box.monitoring = true


#? What happens when the player exits this State?
func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)

	attacking = false

	hurt_box.monitoring = false


#? What happens during the _process update in this State?
func Process(_delta: float) -> State:
	if player.AnimDirection() == "side":
		player.velocity -= player.velocity * 20 * _delta
	else:
		player.velocity -= player.velocity * decelerate_speed * _delta

	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk

	return null


#? What happens during the _physics_process
func Physics(_delta: float) -> State:
	return null


#? What happens with input event in this State?
func HandleInput(_event: InputEvent) -> State:
	return null


func EndAttack() -> void:
	attacking = false

# func on_frame_changed() -> void:
# 	if animation_player.animation == "attack" and animation_player.frame == 3:
# 		hurt_box.monitoring = true
