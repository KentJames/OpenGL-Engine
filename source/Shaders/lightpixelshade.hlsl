////////////////////////////////////////////////////////////////////////////////
// Filename: light.ps
////////////////////////////////////////////////////////////////////////////////
#version 400


/////////////////////
// INPUT VARIABLES //
/////////////////////
in vec2 texCoord;
in vec3 normal;


//////////////////////
// OUTPUT VARIABLES //
//////////////////////
out vec4 outputColor;


///////////////////////
// UNIFORM VARIABLES //
///////////////////////
uniform sampler2D shaderTexture;
uniform vec3 lightDirection;
uniform vec4 diffuseLightColor;


////////////////////////////////////////////////////////////////////////////////
// Pixel Shader
////////////////////////////////////////////////////////////////////////////////
void main(void)
{
	vec4 textureColor;
	vec3 lightDir;
	float lightIntensity;


	// Sample the pixel color from the texture using the sampler at this texture coordinate location.
	textureColor = texture(shaderTexture, texCoord);

	// Invert the light direction for calculations.
	lightDir = -lightDirection;

	// Calculate the amount of light on this pixel.
	lightIntensity = clamp(dot(normal, lightDir), 0.0f, 1.0f);

	// Determine the final amount of diffuse color based on the diffuse color combined with the light intensity.
	outputColor =  clamp((diffuseLightColor * lightIntensity), 0.0f, 1.0f);

	// Multiply the texture pixel and the final diffuse color to get the final pixel color result.
	outputColor = outputColor * textureColor;
}