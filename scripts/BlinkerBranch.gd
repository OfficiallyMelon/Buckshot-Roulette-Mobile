class_name BlinkerBranch extends Node
@export var mat_1 : StandardMaterial3D
@export var mat_2 : StandardMaterial3D
@export var delay_range1 : float
@export var delay_range2 : float
var parent : MeshInstance3D
var looping = false

func _ready():
	parent = get_parent()
	looping = true
	# Use call_deferred to ensure the node is fully in the tree
	call_deferred("Loop")

func Loop():
	# Additional safety check
	if not is_inside_tree():
		return
		
	while looping:
		var delay = randf_range(delay_range1, delay_range2)
		parent.set_surface_override_material(0, mat_1)
		await get_tree().create_timer(delay, false).timeout
		
		# Check if still in tree after await (in case node was freed/removed)
		if not is_inside_tree() or not looping:
			break
			
		parent.set_surface_override_material(0, mat_2)
		await get_tree().create_timer(delay, false).timeout
		
		# Check again after second await
		if not is_inside_tree() or not looping:
			break

func stop_blinking():
	looping = false
