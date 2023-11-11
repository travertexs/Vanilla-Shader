#version 460

#include "/lib/fog.glsl"

uniform sampler2D gtexture;

uniform float fogStart;
uniform float fogEnd;
uniform vec3 fogColor;

uniform vec4 entityColor;

in float vertexDistance;
in vec4 vertexColor;
in vec4 lightMapColor;
in vec2 texCoord0;
in vec4 normal;

layout(location = 0) out vec4 outColor0;

void main() {
    vec4 color = texture(gtexture, texCoord0);

    if (color.a < 0.1)
    {
        discard;
    }

    color *= vertexColor;

    color.rgb = mix(color.rgb, entityColor.rgb, entityColor.a);
    color *= lightMapColor;
    outColor0 = linear_fog(color, vertexDistance, fogStart, fogEnd, vec4(fogColor, 1.0));
}

/* RENDERTARGETS: 0 */