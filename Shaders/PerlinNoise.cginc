#include "Common.cginc"

vec2 GetRandomDir(vec2 i)
{
	vec1 rand = hash(i) * 6.282;
	return vec2(sin(rand), cos(rand));
}

vec3 GetRandomDir(vec3 i)
{
	vec1 rand1 = hash(i) * 6.282;
	vec1 rand2 = hash(i + 1) * 6.282;
	return normalize(vec3(sin(rand1), cos(rand1), sin(rand2)));
}

vec4 GetRandomDir(vec4 i)
{
	vec1 rand1 = hash(i) * 6.282;
	vec1 rand2 = hash(i + 1) * 6.282;
	return normalize(vec4(sin(rand1), cos(rand1), sin(rand2), cos(rand2)));
}

vec1 DotGrid(vec2 pos, int2 c)
{
	vec2 dir = GetRandomDir(c);
	return dot(pos - c, dir);
}

vec1 DotGrid(vec3 pos, int3 c)
{
	vec3 dir = GetRandomDir(c);
	return dot(pos - c, dir);
}

vec1 DotGrid(vec4 pos, int4 c)
{
	vec4 dir = GetRandomDir(c);
	return dot(pos - c, dir);
}

vec1 PowLerp(vec1 a, vec1 b, vec1 t)
{
	return pow(t, 2.0) * (3.0 - 2.0 * t) * (b - a) + a;
}

vec1 GetPerlinNoise1D(vec1 x)
{
	int x1 = floor(x);
	int x2 = x1 + 1;
	vec1 wx = x - x1;
	vec1 g0 = DotGrid(vec2(x, x), x1);
	vec1 g1 = DotGrid(vec2(x, x), x2);
	vec1 n = PowLerp(g0, g1, wx) * 0.78 + 0.45;
	n = normalToUniform(n, 0.18);
	return n;
}

vec1 GetPerlinNoise2D(vec2 pos)
{
	int2 low = floor(pos);
	int2 high = low + 1;
	vec2 w = frac(pos);
	vec1 g00 = DotGrid(pos, int2(low.x, low.y));
	vec1 g10 = DotGrid(pos, int2(high.x, low.y));
	vec1 g01 = DotGrid(pos, int2(low.x, high.y));
	vec1 g11 = DotGrid(pos, int2(high.x, high.y));
	//Interpolate on x axis
	vec1 ix0 = PowLerp(g00, g10, w.x);
	vec1 ix1 = PowLerp(g01, g11, w.x);
	//Interpolate on y axis
	vec1 n = PowLerp(ix0, ix1, w.y) * 0.74 + 0.49;
	n = normalToUniform(n, 0.17);
	return n;
}

vec1 GetPerlinNoise3D(vec3 pos)
{
	int3 low = floor(pos);
	int3 high = low + 1;
	vec3 w = frac(pos);
	vec1 g000 = DotGrid(pos, int3(low.x, low.y, low.z));
	vec1 g100 = DotGrid(pos, int3(high.x, low.y, low.z));
	vec1 g010 = DotGrid(pos, int3(low.x, high.y, low.z));
	vec1 g110 = DotGrid(pos, int3(high.x, high.y, low.z));
	vec1 g001 = DotGrid(pos, int3(low.x, low.y, high.z));
	vec1 g101 = DotGrid(pos, int3(high.x, low.y, high.z));
	vec1 g011 = DotGrid(pos, int3(low.x, high.y, high.z));
	vec1 g111 = DotGrid(pos, int3(high.x, high.y, high.z));
	//Interpolate on x axis
	vec1 ix00 = PowLerp(g000, g100, w.x);
	vec1 ix10 = PowLerp(g010, g110, w.x);
	vec1 ix01 = PowLerp(g001, g101, w.x);
	vec1 ix11 = PowLerp(g011, g111, w.x);
	//Interpolate on y axis
	vec1 ixy0 = PowLerp(ix00, ix10, w.y);
	vec1 ixy1 = PowLerp(ix01, ix11, w.y);
	//Interpolate on z axis
	vec1 n = PowLerp(ixy0, ixy1, w.z) * 0.8 + 0.48;
	n = normalToUniform(n, 0.16);
	return n;
}

vec1 GetPerlinNoise4D(vec4 pos)
{
	int4 low = floor(pos);
	int4 high = low + 1;
	vec4 w = frac(pos);
	vec1 g0000 = DotGrid(pos, int4(low.x, low.y, low.z, low.w));
	vec1 g1000 = DotGrid(pos, int4(high.x, low.y, low.z, low.w));
	vec1 g0100 = DotGrid(pos, int4(low.x, high.y, low.z, low.w));
	vec1 g1100 = DotGrid(pos, int4(high.x, high.y, low.z, low.w));
	vec1 g0010 = DotGrid(pos, int4(low.x, low.y, high.z, low.w));
	vec1 g1010 = DotGrid(pos, int4(high.x, low.y, high.z, low.w));
	vec1 g0110 = DotGrid(pos, int4(low.x, high.y, high.z, low.w));
	vec1 g1110 = DotGrid(pos, int4(high.x, high.y, high.z, low.w));
	vec1 g0001 = DotGrid(pos, int4(low.x, low.y, low.z, high.w));
	vec1 g1001 = DotGrid(pos, int4(high.x, low.y, low.z, high.w));
	vec1 g0101 = DotGrid(pos, int4(low.x, high.y, low.z, high.w));
	vec1 g1101 = DotGrid(pos, int4(high.x, high.y, low.z, high.w));
	vec1 g0011 = DotGrid(pos, int4(low.x, low.y, high.z, high.w));
	vec1 g1011 = DotGrid(pos, int4(high.x, low.y, high.z, high.w));
	vec1 g0111 = DotGrid(pos, int4(low.x, high.y, high.z, high.w));
	vec1 g1111 = DotGrid(pos, int4(high.x, high.y, high.z, high.w));
	//Interpolate on x axis
	vec1 ix000 = PowLerp(g0000, g1000, w.x);
	vec1 ix100 = PowLerp(g0100, g1100, w.x);
	vec1 ix010 = PowLerp(g0010, g1010, w.x);
	vec1 ix110 = PowLerp(g0110, g1110, w.x);
	vec1 ix001 = PowLerp(g0001, g1001, w.x);
	vec1 ix101 = PowLerp(g0101, g1101, w.x);
	vec1 ix011 = PowLerp(g0011, g1011, w.x);
	vec1 ix111 = PowLerp(g0111, g1111, w.x);
	//Interpolate on y axis
	vec1 iy00 = PowLerp(ix000, ix100, w.y);
	vec1 iy10 = PowLerp(ix010, ix110, w.y);
	vec1 iy01 = PowLerp(ix001, ix101, w.y);
	vec1 iy11 = PowLerp(ix011, ix111, w.y);
	//Interpolate on z axis
	vec1 iz0 = PowLerp(iy00, iy10, w.z);
	vec1 iz1 = PowLerp(iy01, iy11, w.z);
	//Interpolate on w axis
	vec1 n = PowLerp(iz0, iz1, w.w) * 0.9 + 0.5;
	n = normalToUniform(n, 0.15);
	return n;
}

vec1 ComputePerlinNoise1D(vec1 pos, FractalSettings settings)
{
	vec1 v = 0.0;
	vec1 intensity = 1.0;
	FOR_FRACTAL
	{
		addNoise(v, GetPerlinNoise1D(pos), intensity);
		pos *= settings.lacunarity;
		intensity *= settings.persistence;
	}
	return v;
}

vec1 ComputePerlinNoise2D(vec2 pos, FractalSettings settings)
{
	vec1 v = 0.0;
	vec1 intensity = 1.0;
	FOR_FRACTAL
	{
		addNoise(v, GetPerlinNoise2D(pos), intensity);
		pos *= settings.lacunarity;
		intensity *= settings.persistence;
	}
	return v;
}

vec1 ComputePerlinNoise3D(vec3 pos, FractalSettings settings)
{
	vec1 v = 0.0;
	vec1 intensity = 1.0;
	FOR_FRACTAL
	{
		addNoise(v, GetPerlinNoise3D(pos), intensity);
		pos *= settings.lacunarity;
		intensity *= settings.persistence;
	}
	return v;
}

vec1 ComputePerlinNoise4D(vec4 pos, FractalSettings settings)
{
	vec1 v = 0.0;
	vec1 intensity = 1.0;
	FOR_FRACTAL
	{
		addNoise(v, GetPerlinNoise4D(pos), intensity);
		pos *= settings.lacunarity;
		intensity *= settings.persistence;
	}
	return v;
}