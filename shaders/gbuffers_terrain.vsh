#version 460

#include "/lib/light.glsl"
#include "/lib/fog.glsl"

in vec3 vaPosition;
in vec4 vaColor;
in vec2 vaUV0;
in ivec2 vaUV2;
in vec3 vaNormal;

uniform sampler2D lightmap;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform vec3 chunkOffset;
uniform int fogShape;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out vec4 normal;

void main() {
    vec3 pos = vaPosition + chunkOffset;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);

    vertexDistance = fog_distance(modelViewMatrix, pos, fogShape);
    vertexColor = vaColor * minecraft_sample_lightmap(lightmap, vaUV2);
    texCoord0 = vaUV0;
    normal = projectionMatrix * modelViewMatrix * vec4(vaNormal, 0.0);
}
