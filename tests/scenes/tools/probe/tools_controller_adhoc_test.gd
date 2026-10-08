extends Node3D


@export var input_component: InputComponent
@export var tool_picker_ui: ToolPickerUi
@export var probe_tool: ProbeMain


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if self.input_component.is_alternative_use():
		self.probe_tool.visible = true
		self.probe_tool.show_probe()
		self.tool_picker_ui.open_tool_picker()
	#if self.tool_picker_ui.visible && self.input_component.is_alternative_use():
		#self.tool_picker_ui.close_tool_picker()
