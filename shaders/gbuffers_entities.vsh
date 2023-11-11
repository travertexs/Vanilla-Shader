#version 460

//#define IS_NEITHER

#include "/lib/light.glsl"
#include "/lib/fog.glsl"

in vec3 vaPosition;
in vec4 vaColor;
in vec2 vaUV0;
in ivec2 vaUV1;
in ivec2 vaUV2;
in vec3 vaNormal;

uniform sampler2D lightmap;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrixInverse;
uniform int fogShape;

out float vertexDistance;
out vec4 vertexColor;
out vec4 lightMapColor;
out vec2 texCoord0;
out vec4 normal;

void main()
{
    vec3 Light0_Direction = vec3( 0.2, 1.0, -0.7);
    vec3 Light1_Direction = vec3(-0.2, 1.0,  0.7);

#ifdef IS_NEITHER
    Light1_Direction = -Light0_Direction;
#endif

    gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition, 1.0);

    vertexDistance = fog_distance(modelViewMatrix, (modelViewMatrixInverse * vec4(vaPosition, 0.0)).xyz, fogShape);
    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, vaNormal, vaColor);
    lightMapColor = texelFetch(lightmap, vaUV2 / 16, 0);
    texCoord0 = vaUV0;
    normal = projectionMatrix * modelViewMatrix * vec4(vaNormal, 0.0);
}
