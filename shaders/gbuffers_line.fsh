#version 460

#include "/lib/fog.glsl"

uniform float fogStart;
uniform float fogEnd;
uniform vec3 fogColor;

in float vertexDistance;
in vec4 vertexColor;

layout(location = 0) out vec4 outColor0;

void main() {
    vec4 color = vertexColor;
    outColor0 = linear_fog(color, vertexDistance, fogStart, fogEnd, vec4(fogColor, 1.0));
}

/* RENDERTARGETS: 0 */