class_name ObjectShaker extends Node
@export var obj : Node3D
@export var delay : float
@export var offset_1 : float
@export var offset_2 : float
var originalPos : Vector3
var shaking = false

func StartShaking():
	if not is_inside_tree():
		push_warning("ObjectShaker: Cannot start shaking - node not in scene tree")
		return
		
	originalPos = obj.transform.origin
	shaking = true
	# Use call_deferred to ensure we're properly in the tree
	call_deferred("ShakeRoutine")

func StopShaking():
	shaking = false
	if obj:
		obj.transform.origin = originalPos

func ShakeRoutine():
	# Safety check to ensure we're in the tree
	if not is_inside_tree():
		shaking = false
		return
		
	while shaking:
		var val = randf_range(offset_1, offset_2)
		var pos = Vector3(obj.transform.origin.x + val, obj.transform.origin.y + val, obj.transform.origin.z + val)
		obj.transform.origin = pos
		
		await get_tree().create_timer(delay, false).timeout
		
		# Check if still in tree and still shaking after await
		if not is_inside_tree() or not shaking:
			break
			
		obj.transform.origin = originalPos
		
		await get_tree().create_timer(delay, false).timeout
		
		# Check again after second await
		if not is_inside_tree() or not shaking:
			break
