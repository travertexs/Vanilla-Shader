#version 460

#include "/lib/fog.glsl"

in vec3 vaPosition;
in vec2 vaUV0;
in vec4 vaColor;
in ivec2 vaUV2;

uniform sampler2D lightmap;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform int fogShape;

out float vertexDistance;
out vec2 texCoord0;
out vec4 vertexColor;

void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition, 1.0);

    vertexDistance = fog_distance(modelViewMatrix, vaPosition, fogShape);
    texCoord0 = vaUV0;
    vertexColor = vaColor * texelFetch(lightmap, vaUV2 / 16, 0);
}