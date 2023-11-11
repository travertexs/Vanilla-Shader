#version 460

uniform sampler2D gtexture;

in vec4 vertexColor;
in vec2 texCoord0;

layout(location = 0) out vec4 outColor0;

void main()
{
    vec4 color = texture(gtexture, texCoord0);

    if (color.a == 0.0)
    {
        discard;
    }

    outColor0 = vertexColor;
}

/* RENDERTARGETS: 0 */