class_name ProbeMain extends Node3D


@export var tools_parent: Node3D
@export var player_hand: Node3D
@export var stamina_component: StaminaComponent
@export var input_component: InputComponent
@export var player_stats: PlayerStats


@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var _audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var _probe_controller: ProbeController = $ProbeController

#@onready var _hit_display_ui: Control = %HitDisplay
@onready var _label_ui: Label = %Label
@onready var _tool_cooldown_ui: ToolCooldownIcon = %ToolCooldownIcon
@onready var _hit_label_timer: Timer = %HitLabelTimer


func _ready() -> void:
	self._probe_controller.init_controler(self.stamina_component, self.player_stats)
	self._probe_controller.target_hit.connect(self._on_target_hit)
	self._probe_controller.probe_used.connect(self._on_probe_used)


func _process(_delta: float) -> void:
	if self.input_component.is_main_use():
		self._probe_controller.use_tool()


func show_probe() -> void:
	self.reparent(self.player_hand)
	self.global_position = self.player_hand.global_position
	if self._animation_player.is_playing():
		self._animation_player.stop()
	self._animation_player.play("probe_ready")

	self._tool_cooldown_ui.visible = true


func hide_probe() -> void:
	self.reparent(self.tools_parent, false)
	self._tool_cooldown_ui.visible = false


func _on_probe_used(cooldown: int) -> void:
	self._animation_player.play("probe_use")
	self._tool_cooldown_ui.start_cool_down(cooldown / 1000.0)


func _on_target_hit(depth: float) -> void:
	self._label_ui.text = "Target hit [depth: %.2f m]" % depth
	self._label_ui.visible = true
	self._hit_label_timer.start()


func _on_hit_label_timer_timeout() -> void:
	self._label_ui.visible = false
