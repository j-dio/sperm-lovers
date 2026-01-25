extends Area3D

@export var speed: float = 30.0
@export var lifetime: float = 0.1
@export var damage: int = 2
@export var alert_radius: float = 12.0          # How far the "violence" sound travels to wake other enemies

var direction := Vector3.FORWARD

@onready var impact_sound: AudioStreamPlayer3D = $ImpactSound
@onready var death_sound: AudioStreamPlayer3D = $DeathSound

func _ready() -> void:
	get_tree().create_timer(lifetime).timeout.connect(queue_free)
	body_entered.connect(_on_body_entered)
	print("Bullet ready, monitoring: ", monitoring)


func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta


func _on_body_entered(body: Node3D) -> void:
	print("Bullet hit: ", body.name, " Groups: ", body.get_groups())
	var was_fatal := false
	
	# Handle enemy hit
	if body.is_in_group("enemies") and body.has_method("take_damage"):
		was_fatal = body.take_damage(damage)
		
		# Only alert nearby enemies if we actually damaged someone
		alert_nearby_enemies(body.global_position)
	
	# Handle impact / death sound and cleanup
	if body.is_in_group("enemies") or body.is_in_group("walls"):
		play_impact_and_free(was_fatal)


func alert_nearby_enemies(hit_position: Vector3) -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if not is_instance_valid(enemy): continue
		if not enemy.has_method("become_aggro"): continue
			
		var dist = enemy.global_position.distance_to(hit_position)
		
		if dist <= alert_radius: enemy.become_aggro()

func play_impact_and_free(was_fatal: bool = false) -> void:
	var sound_to_play: AudioStreamPlayer3D = null
	
	if was_fatal and death_sound and death_sound.stream:
		sound_to_play = death_sound
	elif impact_sound and impact_sound.stream:
		sound_to_play = impact_sound
	
	# Reparent so sound survives bullet deletion
	if sound_to_play:
		var sound_pos = sound_to_play.global_position
		sound_to_play.reparent(get_tree().root)
		sound_to_play.global_position = sound_pos
		sound_to_play.play()
		sound_to_play.finished.connect(sound_to_play.queue_free)
	
	queue_free()
