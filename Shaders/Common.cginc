#ifndef UNITY_NOISE_COMMON_INCLUDED
#define UNITY_NOISE_COMMON_INCLUDED

#define FOR_FRACTAL for(int i = 0; i < min(settings.octaves, 8); i++)

#ifdef PRECISION_HALF
	#define vec1 half
	#define vec2 half2
	#define vec3 half3
	#define vec4 half4
#else
	#define vec1 float
	#define vec2 float2
	#define vec3 float3
	#define vec4 float4
#endif

struct FractalSettings
{
	int octaves;
	vec1 lacunarity;
	vec1 persistence;
	vec1 smoothing;
};

//TODO: find different magic numbers to avoid patterns
half hash(vec4 pos)
{
	return frac(sin(dot(pos, vec4(12.9898, 13.231, 45.164, 94.673))) * 43758.5453) * 2.0 - 1.0;
}
			
half hash(vec1 pos)
{
	return hash(vec4(pos, 0.0, 0.0, 0.0));
}

half hash(vec2 pos)
{
	return hash(vec4(pos, 0.0, 0.0));
}

half hash(vec3 pos)
{
	return hash(vec4(pos, 0.0));
}

uint mod(int x, uint m)
{
	int a = x % m;
	return a < 0 ? a + m : a;
}

#define SQRT_2 1.4142135623730951
#define A1 0.254829592
#define A2 -0.284496736
#define A3 1.421413741
#define A4 -1.453152027
#define A5 1.061405429
#define P 0.3275911

// Approximation of the error function (erf)
vec1 erfApprox(vec1 x)
{
	// Save the sign of x
	int sign = (x >= 0) ? 1 : -1;
	x = abs(x);

	// Apply the approximation formula
	vec1 t = 1.0 / (1.0 + P * x);
	vec1 y = 1.0 - (((((A5 * t + A4) * t) + A3) * t + A2) * t + A1) * t * exp(-x * x);

	return sign * y;
}

// CDF function for normal distribution using erfApprox
vec1 normalCDF(vec1 x, vec1 mean, vec1 stddev = 1.0)
{
	vec1 z = (x - mean) / stddev;
	return 0.5 * (1 + erfApprox(z / SQRT_2));
}

vec1 normalToUniform(vec1 x, vec1 stdDev)
{
	return normalCDF(x, 0.5, stdDev);
}

void addNoise(inout vec1 v, vec1 b, vec1 intensity)
{
	v = lerp(v, b, intensity);
}

void addNoise(inout vec2 v, vec2 b, vec1 intensity)
{
	v = lerp(v, b, intensity);
}

#endif