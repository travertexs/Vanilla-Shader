#version 460

#include "/lib/fog.glsl"

uniform float fogStart;
uniform float fogEnd;
uniform vec3 fogColor;

in float vertexDistance;
flat in vec4 vertexColor;

layout(location = 0) out vec4 outColor0;

void main()
{
    outColor0 = linear_fog(vertexColor, vertexDistance, fogStart, fogEnd, vec4(fogColor, 1.0));
}

/* RENDERTARGETS: 0 */