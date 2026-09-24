/* Screen-edge placement for TomBlock's tagged action-bar fonts. */
vec3 tomblock_hud_position(vec3 source, mat4 projection) {
    vec3 position = source;
    vec2 guiSize = ceil(2.0 / vec2(projection[0][0], -projection[1][1]));
    float id = trunc((position.y - 67.0) / 1000.0);
    if (id >= 201.0 && id <= 210.0) {
        float row = id - 201.0;
        position.y -= id * 1000.0 + 567.0;
        position.x -= guiSize.x * 0.5;
        position.y += guiSize.y;
        position.x += guiSize.x - 8.0;
        position.y -= guiSize.y - (12.0 + row * 10.0);
        position.z += 0.01;
    }
    return position;
}
