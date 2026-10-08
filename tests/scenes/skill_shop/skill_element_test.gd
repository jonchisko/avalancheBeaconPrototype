class_name SkillElementTest extends HBoxContainer


@onready var _skill_name: Label = $Label
@onready var _skill_value: Label = $Label2


func init_data(skill_name: String, value: int) -> void:
	self._skill_name.text = skill_name
	self._skill_value.text = str(value)
