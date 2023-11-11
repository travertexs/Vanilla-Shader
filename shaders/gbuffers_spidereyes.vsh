#version 460

#include "/lib/fog.glsl"

in vec3 vaPosition;
in vec4 vaColor;
in vec2 vaUV0;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrixInverse;
uniform int fogShape;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

void main()
{
    gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition, 1.0);

    vertexDistance = fog_distance(modelViewMatrix, (modelViewMatrixInverse * vec4(vaPosition, 0.0)).xyz, fogShape);
    vertexColor = vaColor;
    texCoord0 = vaUV0;
}
