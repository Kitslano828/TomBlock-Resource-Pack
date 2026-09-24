#version 330

#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:sample_lightmap.glsl>
#endif
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
in ivec2 UV2;
#endif
#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
uniform sampler2D Sampler2;
out float sphericalVertexDistance;
out float cylindricalVertexDistance;
#endif
out vec4 vertexColor;
out vec2 texCoord0;

void main() {
    vec3 hudPosition = Position;
    ivec3 marker = ivec3(round(Color.rgb * 255.0));
    bool tomblockHud = marker.r == 250 && marker.g >= 16 && marker.g <= 24;
    if (tomblockHud) {
        vec2 screen = vec2(2.0 / ProjMat[0][0], -2.0 / ProjMat[1][1]);
        int anchor = marker.g - 16;
        int horizontal = anchor % 3;
        int vertical = anchor / 3;
        if (horizontal == 0) hudPosition.x -= screen.x * 0.5;
        else if (horizontal == 2) hudPosition.x += screen.x * 0.5;
        float localY = Position.y - (screen.y - 59.0 - 7.0);
        float anchorY = vertical == 0 ? 0.0 : (vertical == 1 ? screen.y * 0.5 : screen.y);
        hudPosition.y = anchorY + float(marker.b - 128) + localY;
    }
    gl_Position = ProjMat * ModelViewMat * vec4(hudPosition, 1.0);
#if !defined(IS_GUI) && !defined(IS_SEE_THROUGH)
    sphericalVertexDistance = fog_spherical_distance(Position);
    cylindricalVertexDistance = fog_cylindrical_distance(Position);
    vertexColor = tomblockHud ? vec4(1.0) : Color * sample_lightmap(Sampler2, UV2);
#else
    vertexColor = tomblockHud ? vec4(1.0) : Color;
#endif
    texCoord0 = UV0;
}
