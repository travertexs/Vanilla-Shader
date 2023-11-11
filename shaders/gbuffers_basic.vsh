#version 460

#include "/lib/fog.glsl"

in vec3 vaPosition;
in vec4 vaColor;
in ivec2 vaUV2;

uniform sampler2D lightmap;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrixInverse;
uniform int fogShape;

out float vertexDistance;
flat out vec4 vertexColor;

void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition, 1.0);

    vertexDistance = fog_distance(modelViewMatrix, (modelViewMatrixInverse * vec4(vaPosition, 0.0)).xyz, fogShape);
    vertexColor = vaColor * texelFetch(lightmap, vaUV2 / 16, 0);
}
