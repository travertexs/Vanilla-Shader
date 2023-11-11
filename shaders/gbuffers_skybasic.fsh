#version 460

#include "/lib/fog.glsl"

uniform int isEyeInWater;

uniform float fogStart;
uniform float fogEnd;
uniform vec3 fogColor;
uniform vec3 skyColor;

in float vertexDistance;
in vec4 vertexColor;

layout(location = 0) out vec4 outColor0;

void main()
{
    vec4 skyColorEye = vec4((isEyeInWater < 0.5) ? skyColor : vec3(0.0), 1.0);

    outColor0 = linear_fog_sky(
        skyColorEye,
        vertexColor,
        vertexDistance,
        fogStart,
        fogEnd,
        vec4(fogColor, 1.0)
    );
}

/* RENDERTARGETS: 0 */