#version 460

#include "/lib/fog.glsl"

uniform sampler2D gtexture;

uniform mat4 projectionMatrix;

uniform float fogStart;
uniform float fogEnd;
uniform vec3 fogColor;

in vec4 vertexColor;
in vec2 texCoord0;

layout(location = 0) out vec4 outColor0;

void main()
{
    vec4 color = texture(gtexture, texCoord0) * vertexColor;

    float fragmentDistance = -projectionMatrix[3].z / ((gl_FragCoord.z) * -2.0 + 1.0 - projectionMatrix[2].z);
    outColor0 = linear_fog(color, fragmentDistance, fogStart, fogEnd, vec4(fogColor, 1.0));
}

/* RENDERTARGETS: 0 */