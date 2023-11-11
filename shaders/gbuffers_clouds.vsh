#version 460

#include "/lib/fog.glsl"

in vec3 vaPosition;
in vec2 vaUV0;
in vec4 vaColor;
in vec3 vaNormal;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform int fogShape;

out vec2 texCoord0;
out float vertexDistance;
out vec4 vertexColor;
out vec4 normal;

void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition, 1.0);

    texCoord0 = vaUV0;
    vertexDistance = fog_distance(modelViewMatrix, vaPosition, fogShape);
    vertexColor = vaColor;
    normal = projectionMatrix * modelViewMatrix * vec4(vaNormal, 0.0);
}
