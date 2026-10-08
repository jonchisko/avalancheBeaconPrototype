shader_type canvas_item;

const float PI2 = 2.0 * PI;
const float HALF_PI = PI / 2.0;
const mat2 ROT_HALF_PI = mat2(
		vec2(cos(-HALF_PI), -sin(-HALF_PI)),
		vec2(sin(-HALF_PI), cos(-HALF_PI)));

// Uniform for the cooldown progress, ranges from 0.0 (full cooldown) to 1.0 (no cooldown)
uniform float cooldown_progress : hint_range(0.0, 1.0);

// Uniform to toggle between disappearing or transparent unseen area
uniform bool use_transparency;

// Uniform to control the alpha value of the transparent unseen area
uniform float transparency_alpha : hint_range(0.0, 1.0);

// Function to check if a point is inside the cooldown arc
bool in_cooldown(vec2 uv, float progress) {
    // Convert UV coordinates to centered coordinates (-0.5 to 0.5)
    vec2 centered_uv = uv - vec2(0.5);
	
	centered_uv *= ROT_HALF_PI;

    // Calculate the angle of the UV coordinate
    float angle = atan(centered_uv.y, centered_uv.x) / PI2 + 0.5;

    // Check if the point is within the cooldown arc
    return (angle <= progress);
}

void fragment() {
    // Sample the texture at the given UV coordinates
    vec4 tex_color = texture(TEXTURE, UV);

    // Check if the current fragment is within the cooldown arc
    if (in_cooldown(UV, cooldown_progress)) {
        // If within the cooldown, set the color to the texture color
        COLOR = tex_color;
    } else if (use_transparency) {
        // Set the color to the texture color with adjusted alpha
        COLOR = vec4(tex_color.rgb, transparency_alpha);
	} else {
        // Set the color to transparent
        COLOR = vec4(0.0, 0.0, 0.0, 0.0);
    }
}
