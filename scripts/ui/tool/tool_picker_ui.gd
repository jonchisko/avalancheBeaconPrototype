class_name ToolPickerUi extends Control


signal tool_picked(tool_type: GlobalEnums.ToolType)


@export var open_tool_picker_sfx: AudioStream
@export var close_tool_picker_sfx: AudioStream
@export var tool_select_sfx: AudioStream


@onready var _audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var _animation_player: AnimationPlayer = $AnimationPlayer

@onready var _icon_container: MarginContainer = $MarginContainer
@onready var _probe_icon: TextureRect = %ProbeIcon
@onready var _beacon_icon: TextureRect = %BeaconIcon
@onready var _shovel_icon: TextureRect = %ShovelIcon


var _enabled_input: bool = true


func _ready() -> void:
	self._icon_container.visible = false


func open_tool_picker() -> void:
	self._enabled_input = true
	if self._animation_player.is_playing():
		self._animation_player.stop()
	self._audio_stream_player.stream = self.open_tool_picker_sfx
	self._animation_player.play("make_visible")


func close_tool_picker() -> void:
	if self._animation_player.is_playing():
		self._animation_player.stop()
	self._audio_stream_player.stream = self.close_tool_picker_sfx
	self._animation_player.play("make_invisible")


func _on_shovel_icon_mouse_exited() -> void:
	if !self._enabled_input:
		return
	self._animate_hover_icon(self._shovel_icon, Vector2.ONE)


func _on_shovel_icon_mouse_entered() -> void:
	if !self._enabled_input:
		return
	self._animate_hover_icon(self._shovel_icon, Vector2.ONE * 1.2)


func _on_shovel_icon_gui_input(event: InputEvent) -> void:
	if self._enabled_input && event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			self._enabled_input = false
			self.tool_picked.emit(GlobalEnums.ToolType.SHOVEL)
			self._audio_stream_player.play()
			await self._animate_click_icon(self._shovel_icon)
			self._animation_player.play("make_invisible")


func _on_beacon_icon_mouse_exited() -> void:
	if !self._enabled_input:
		return
	self._animate_hover_icon(self._beacon_icon, Vector2.ONE)


func _on_beacon_icon_mouse_entered() -> void:
	if !self._enabled_input:
		return
	self._animate_hover_icon(self._beacon_icon, Vector2.ONE * 1.2)


func _on_beacon_icon_gui_input(event: InputEvent) -> void:
	if self._enabled_input && event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			self._enabled_input = false
			self.tool_picked.emit(GlobalEnums.ToolType.BEACON)
			self._audio_stream_player.play()
			await self._animate_click_icon(self._beacon_icon)
			self._animation_player.play("make_invisible")


func _on_probe_icon_mouse_exited() -> void:
	if !self._enabled_input:
		return
	self._animate_hover_icon(self._probe_icon, Vector2.ONE)


func _on_probe_icon_mouse_entered() -> void:
	if !self._enabled_input:
		return
	self._animate_hover_icon(self._probe_icon, Vector2.ONE * 1.2)


func _on_probe_icon_gui_input(event: InputEvent) -> void:
	if self._enabled_input && event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			self._enabled_input = false
			self.tool_picked.emit(GlobalEnums.ToolType.PROBE)
			self._audio_stream_player.play()
			await self._animate_click_icon(self._probe_icon)
			self._animation_player.play("make_invisible")


func _animate_hover_icon(icon: TextureRect, scaled: Vector2) -> void:
	icon.pivot_offset = icon.size / 2.0
	var tween = self.create_tween()
	tween.tween_property(icon, "scale", scaled, 0.22)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)


func _animate_click_icon(icon: TextureRect) -> void:
	icon.pivot_offset = icon.size / 2.0
	var tween = self.create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(
		icon,
		"rotation_degrees",
		10.0,
		0.05
	)

	tween.parallel().tween_property(
		icon,
		"scale",
		Vector2(1.25, 1.25),
		0.05
	)

	tween.tween_property(
		icon,
		"rotation_degrees",
		0.0,
		0.05
	)

	tween.parallel().tween_property(
		icon,
		"scale",
		Vector2(1.3, 1.3),
		0.05
	)

	tween.tween_property(
		icon,
		"rotation_degrees",
		-10.0,
		0.05
	)

	tween.parallel().tween_property(
		icon,
		"scale",
		Vector2(1.35, 1.35),
		0.05
	)

	tween.tween_property(
		icon,
		"rotation_degrees",
		0.0,
		0.05
	)

	await tween.finished
