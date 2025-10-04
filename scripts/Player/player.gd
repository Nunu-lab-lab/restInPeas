extends CharacterBody2D


@export var walk_speed = 80.0
@export var run_speed = 140.0

@onready var anim = $AnimatedSprite2D





enum State {IDLE, RUN, WALK, DIG, WATER, FIGHT, FERTILISE, SEED}
var current_state = State.IDLE

func _ready():
	change_state(State.IDLE)

func change_state(new_state: State):
	current_state = new_state
	
	match current_state:
		State.IDLE:
			anim.play("idle")
		State.WALK:
			anim.play("walk")
		State.RUN:
			anim.play("run")
		State.DIG:
			anim.play("digging")
		State.FIGHT:
			anim.play("attack")
		State.WATER:
			anim.play("water")
		State.FERTILISE:
			anim.play("fertilise")
		State.SEED:
			anim.play("seeding")

func _physics_process(_delta: float) -> void:
	match current_state:
		State.IDLE:
			handle_input()
			if get_input_vector() != Vector2.ZERO:
				change_state(State.WALK)
		
		State.WALK:
			handle_input()
			var dir = get_input_vector()
			if dir == Vector2.ZERO:
				change_state(State.IDLE)
			elif Input.is_action_pressed("run"):
				change_state(State.RUN)
			else:
				velocity = dir * walk_speed
				flip()
				move_and_slide()
		
		State.RUN:
			var dir = get_input_vector()
			if dir == Vector2.ZERO:
				change_state(State.IDLE)
			else:
				velocity = dir * run_speed
				GameData.stamina = max(GameData.stamina - 5, 0)
				move_and_slide()
		
		State.DIG:
			velocity = Vector2.ZERO
			if not anim.is_playing():
				change_state(State.IDLE)
		
		State.WATER:
			velocity = Vector2.ZERO
			if not anim.is_playing():
				change_state(State.IDLE)
		
		State.FIGHT:
			velocity = Vector2.ZERO
			if not anim.is_playing():
				change_state(State.IDLE)
		
		State.SEED:
			velocity = Vector2.ZERO
			if not anim.is_playing():
				change_state(State.IDLE)
		
		State.FERTILISE:
			velocity = Vector2.ZERO
			if not anim.is_playing():
				change_state(State.IDLE)

func handle_input() -> void:
	if current_state == State.IDLE or current_state == State.WALK:
		if Input.is_action_just_pressed("dig"):
			change_state(State.DIG)
			#interact_with_soil("dig")
		elif Input.is_action_just_pressed("water"):
			change_state(State.WATER)
			#interact_with_soil("water")
		elif Input.is_action_just_pressed("attack"):
			change_state(State.FIGHT)
		elif Input.is_action_just_pressed("seed"):
			change_state(State.SEED)
			#interact_with_soil("seed")
		elif Input.is_action_just_pressed("fertilise"):
			change_state(State.FERTILISE)
			#interact_with_soil("fertilise")
		elif get_input_vector() != Vector2.ZERO:
			change_state(State.WALK)
		else:
			change_state(State.IDLE)

func get_input_vector() -> Vector2:
	var dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return dir.normalized()

func flip():
	if velocity.x < 0:
		anim.flip_h = true
	elif velocity.x > 0:
		anim.flip_h = false
