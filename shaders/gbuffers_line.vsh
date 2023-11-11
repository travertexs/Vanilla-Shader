#version 460

#include "/lib/fog.glsl"

in vec3 vaPosition;
in vec4 vaColor;
in vec3 vaNormal;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform float viewWidth;
uniform float viewHeight;
uniform int fogShape;

out float vertexDistance;
out vec4 vertexColor;

const float lineWidth = 2.5;
const float VIEW_SHRINK = 1.0 - (1.0 / 256.0);
const mat4 VIEW_SCALE = mat4(
    VIEW_SHRINK, 0.0        , 0.0        , 0.0,
    0.0        , VIEW_SHRINK, 0.0        , 0.0,
    0.0        , 0.0        , VIEW_SHRINK, 0.0,
    0.0        , 0.0        , 0.0        , 1.0
);

void main() {
    vec2 screenSize = vec2(viewWidth, viewHeight);

    vec4 linePosStart = projectionMatrix * VIEW_SCALE * modelViewMatrix * vec4(vaPosition, 1.0);
    vec4 linePosEnd = projectionMatrix * VIEW_SCALE * modelViewMatrix * vec4(vaPosition + vaNormal, 1.0);

    vec3 ndc1 = linePosStart.xyz / linePosStart.w;
    vec3 ndc2 = linePosEnd.xyz / linePosEnd.w;

    vec2 lineScreenDirection = normalize((ndc2.xy - ndc1.xy) * screenSize);
    vec2 lineOffset = vec2(-lineScreenDirection.y, lineScreenDirection.x) * lineWidth / screenSize;

    if (lineOffset.x < 0.0)
    {
        lineOffset *= -1.0;
    }

    if (gl_VertexID % 2 == 0)
    {
        gl_Position = vec4((ndc1 + vec3(lineOffset, 0.0)) * linePosStart.w, linePosStart.w);
    }
    else
    {
        gl_Position = vec4((ndc1 - vec3(lineOffset, 0.0)) * linePosStart.w, linePosStart.w);
    }

    vertexDistance = fog_distance(modelViewMatrix, vaPosition, fogShape);
    vertexColor = vaColor;
}
