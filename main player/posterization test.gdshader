shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float SCREEN_WIDTH : hint_range(1, 1920) = 320;

uniform float RED_COMPONENT : hint_range(1, 256) = 8.0;
uniform float GREEN_COMPONENT : hint_range(1, 256) = 8.0;
uniform float BLUE_COMPONENT : hint_range(1, 256) = 8.0;

void fragment() {
    // Reduce pixels
    vec2 size = SCREEN_WIDTH * SCREEN_PIXEL_SIZE.xy / SCREEN_PIXEL_SIZE.x;
    vec2 coor = floor(UV * size);
    vec2 uv = FRAGCOORD.xy / (1.0 / SCREEN_PIXEL_SIZE).xy;

    // Get source color
    vec3 col = texture(SCREEN_TEXTURE, uv).xyz;

    // Reduce colors for each channel individually
    col.r = floor(col.r * RED_COMPONENT) / RED_COMPONENT;
    col.g = floor(col.g * GREEN_COMPONENT) / GREEN_COMPONENT;
    col.b = floor(col.b * BLUE_COMPONENT) / BLUE_COMPONENT;

    // Output to screen
    COLOR = vec4(col, 1.0);
}
