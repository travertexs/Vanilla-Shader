#version 460

#include "/lib/fog.glsl"

uniform sampler2D gtexture;

uniform float fogStart;
uniform float fogEnd;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;

layout(location = 0) out vec4 outColor0;

void main()
{
    vec4 color = texture(gtexture, texCoord0) * vertexColor;
    outColor0 = color * linear_fog_fade(vertexDistance, fogStart, fogEnd);
}

/* RENDERTARGETS: 0 */