#version 460

in vec3 vaPosition;
in vec4 vaColor;
in vec2 vaUV0;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

out vec4 vertexColor;
out vec2 texCoord0;

void main()
{
    gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition, 1.0);

    vertexColor = vaColor;
    texCoord0 = vaUV0;
}
