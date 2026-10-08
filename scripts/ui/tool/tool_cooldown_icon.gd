class_name ToolCooldownIcon extends TextureRect


signal tool_cooldown_end


var _running: bool = false
var _time: float = 0.0
var _max_time: float = 0.0


func _ready() -> void:
	self.material.set("shader_parameter/cooldown_progress", 1.0)


func _process(delta: float) -> void:
	if self._running:
		self._time += delta
		self._time = min(self._time, self._max_time)
		self.material.set("shader_parameter/cooldown_progress", self._time / self._max_time)

		if self._time >= self._max_time:
			self._running = false
			self.tool_cooldown_end.emit()


func start_cool_down(cool_down_time: float) -> void:
	self._time = 0.0
	self._max_time = cool_down_time
	self._running = true
