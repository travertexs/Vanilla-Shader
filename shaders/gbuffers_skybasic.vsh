#version 460

#include "/lib/fog.glsl"

in vec3 vaPosition;
in vec4 vaColor;

uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
uniform int fogShape;

out float vertexDistance;
out vec4 vertexColor;

void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition, 1.0);

    vertexDistance = fog_distance(modelViewMatrix, vaPosition, fogShape);
    vertexColor = vaColor;
}