extends TileMapLayer

const DRY_TILE = Vector2i(0, 0)
const DUG_TILE = Vector2i(0, 0)
const WATERED_TILE = Vector2i(2, 0)
const OVERWATERED_TILE = Vector2i(4, 0)
const FERTILISED_TILE = Vector2i(6, 0)
const SEEDED_TILE = Vector2i(0, 0)
@onready var message_label = $"../message_label"
@onready var player = get_tree().get_first_node_in_group("player")

func _process(_delta):
	if not player:
		return

	var player_pos = player.global_position
	var tile_pos = local_to_map(player_pos)


	var tile_data = get_cell_tile_data(tile_pos)
	var current_tile = get_cell_atlas_coords(tile_pos)

	# DIG
	if Input.is_action_just_pressed("dig"):
		if current_tile == DRY_TILE:
			set_cell(tile_pos, 0, DUG_TILE)
	
	# WATER
	elif Input.is_action_just_pressed("water"):
		if current_tile == SEEDED_TILE:
			set_cell(tile_pos, 1, WATERED_TILE)
		elif current_tile == WATERED_TILE:
			set_cell(tile_pos, 1, OVERWATERED_TILE)
	
	# FERTILISE
	elif Input.is_action_just_pressed("fertilise"):
		if current_tile == WATERED_TILE:
			set_cell(tile_pos, 1, FERTILISED_TILE)
	
	# SEED
	elif Input.is_action_just_pressed("seed"):
		if current_tile == DUG_TILE:
			set_cell(tile_pos, 4, SEEDED_TILE)
			#start_growth_timer(tile_pos)
