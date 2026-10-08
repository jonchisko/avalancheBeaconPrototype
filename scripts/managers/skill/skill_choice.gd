class_name SkillChoice extends RefCounted


var number_of_skills: int
var skills: Array[Skill]


func _init(possible_skills: Array[Skill], number_of_possible_skills: int) -> void:
	self.number_of_skills = number_of_possible_skills
	self.skills = possible_skills


func has_max_upgraded_skill() -> bool:
	return self.skills.any(func(skill): return skill.is_maxed_out())
