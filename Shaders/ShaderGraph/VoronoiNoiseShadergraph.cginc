#include "../VoronoiNoise.cginc"

#define SETUP_SETTINGS				\
FractalSettings settings;			\
settings.octaves = floor(octaves);	\
settings.lacunarity = lacunarity;	\
settings.persistence = persistence;



void ComputeVoronoiNoise1D_float(float pos, float scale, float octaves, float lacunarity, float persistence, out float distance, out float cell, out float cellPos)
{
	SETUP_SETTINGS
	VoronoiResult1D result = ComputeVoronoiNoise1D(pos, scale, settings);
	distance = result.distance;
	cell = result.cell;
	cellPos = result.cellPos;
}

void ComputeVoronoiNoise1D_half(half pos, half scale, half octaves, half lacunarity, half persistence, out half distance, out half cell, out half cellPos)
{
	SETUP_SETTINGS
	VoronoiResult1D result = ComputeVoronoiNoise1D(pos, scale, settings);
	distance = result.distance;
	cell = result.cell;
	cellPos = result.cellPos;
}

void ComputeVoronoiNoise2D_float(float2 pos, float2 scale, float octaves, float lacunarity, float persistence, out float distance, out float cell, out float2 cellPos)
{
	SETUP_SETTINGS
	VoronoiResult2D result = ComputeVoronoiNoise2D(pos, scale, settings);
	distance = result.distance;
	cell = result.cell;
	cellPos = result.cellPos;
}

void ComputeVoronoiNoise2D_half(half2 pos, half2 scale, half octaves, half lacunarity, half persistence, out half distance, out half cell, out half2 cellPos)
{
	SETUP_SETTINGS
	VoronoiResult2D result = ComputeVoronoiNoise2D(pos, scale, settings);
	distance = result.distance;
	cell = result.cell;
	cellPos = result.cellPos;
}

void ComputeVoronoiNoise3D_float(float3 pos, float3 scale, float octaves, float lacunarity, float persistence, out float distance, out float cell, out float3 cellPos)
{
	SETUP_SETTINGS
	VoronoiResult3D result = ComputeVoronoiNoise3D(pos, scale, settings);
	distance = result.distance;
	cell = result.cell;
	cellPos = result.cellPos;
}

void ComputeVoronoiNoise3D_half(half3 pos, half3 scale, half octaves, half lacunarity, half persistence, out half distance, out half cell, out half3 cellPos)
{
	SETUP_SETTINGS
	VoronoiResult3D result = ComputeVoronoiNoise3D(pos, scale, settings);
	distance = result.distance;
	cell = result.cell;
	cellPos = result.cellPos;
}

void ComputeVoronoiNoise4D_float(float4 pos, float4 scale, float octaves, float lacunarity, float persistence, out float distance, out float cell, out float4 cellPos)
{
	SETUP_SETTINGS
	VoronoiResult4D result = ComputeVoronoiNoise4D(pos, scale, settings);
	distance = result.distance;
	cell = result.cell;
	cellPos = result.cellPos;
}

void ComputeVoronoiNoise4D_half(half4 pos, half4 scale, half octaves, half lacunarity, half persistence, out half distance, out half cell, out half4 cellPos)
{
	SETUP_SETTINGS
	VoronoiResult4D result = ComputeVoronoiNoise4D(pos, scale, settings);
	distance = result.distance;
	cell = result.cell;
	cellPos = result.cellPos;
}