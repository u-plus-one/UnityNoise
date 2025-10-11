# UnityNoise

[![Unity](https://img.shields.io/badge/Unity-2019.4+-blue.svg)](https://unity3d.com/get-unity/download)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE.md)

## Description

A Unity package that contains a collection of functions for generating various kinds of noise both on the CPU and GPU.

### Available Noise Functions
|Type           |1D                |2D                |3D                |4D                |
|---------------|------------------|------------------|------------------|------------------|
|Perlin         |:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:|
|Simplex        |:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:|
|Voronoi        |:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:|
|Cellular       |:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:|

All noise generators also include functions for generating a fractal version.

## Installation

### Option 1: Unity Package Manager

Open the Package Manager window, click on `Add Package from Git URL ...`, then enter the following:
```
https://github.com/u-plus-one/unitynoise.git
```

### Option 2: Manually Editing packages.json

Add the following line to your project's `Packages/manifest.json`:

```json
"com.github.u-plus-one.unitynoise": "https://github.com/u-plus-one/unitynoise.git"
```

### Option 3: Manual Installation (not recommended)

You can also download this repository and extract the ZIP file anywhere inside your project's Assets folder.

## Usage

### In Scripts

All noise generators are found inside the ```UnityNoise``` namespace.

Example:
```csharp
using UnityNoise;

-----

//Position to sample the noise at
Vector3 pos = new Vector3(0.5f, 1.0f, 2.0f);

//Simple 3D Perlin 
float noise = PerlinNoise.Instance.GetNoise3D(pos);

//Fractal 3D Perlin (parameters: octaves, lacunarity, persistence, scale)
FractalSettings fractal = new FractalSettings(4, 2f, 0.5f, 1);
float noise = PerlinNoise.Instance.GetNoise3D(pos, fractal);
```

### In Shaders

Add a reference to the include file(s) you want to use:
```hlsl
//Perlin Noise
#include "Packages/com.github.u-plus-one.unitynoise/Shaders/PerlinNoise.cginc"

//Simplex Noise
#include "Packages/com.github.u-plus-one.unitynoise/Shaders/SimplexNoise.cginc"

//Voronoi Noise
#include "Packages/com.github.u-plus-one.unitynoise/Shaders/VoronoiNoise.cginc"

//Simple Cellular Noise
#include "Packages/com.github.u-plus-one.unitynoise/Shaders/CellularNoise.cginc"
```

Example:
```hlsl
//Simple 3D Perlin
float noise = GetPerlinNoise3D(position.xyz);

//Fractal 3D Perlin
FractalSettings settings;
settings.octaves = 4;
settings.persistence = 0.5;
settings.lacunarity = 2.0;
float noise = ComputePerlinNoise3D(position.xyz, settings);
```

#### Using Half Precision

When targeting older GPUs or mobile devices, you may want to use half precision noise by defining `HALF_PRECISION` in your shader **before including the noise function files**:

```hlsl
//Make sure this comes BEFORE including the actual shader functions
#define HALF_PRECISION
//Include the noise functions, using half precision
#include "Packages/com.github.u-plus-one.unitynoise/Shaders/[...].cginc"
```

### Texture Assets

Noise Textures can be generated as procedural assets and can be used just like regular 2D textures.

To create a new noise texture, go to `Assets/Create/Texture/Noise Texture`

Noise Textures come with the following settings:

|Parameter      |Description|
|---------------|------------|
|Resolution     |Texture width / height.|
|Use 3D Noise   |Whether to sample from 3D noise to generate the 2D texture.|
|Scale          |Number of noise "cells" in both axes, higher numbers generate more noise.|
|Seed           |Random seed to use for noise generation.|
|Depth          |General contrast of the genreated noise.|
|Tiled          |Generates a texture that can repeat seamlessly.|
|**Fractal Settings**|Various settings releated to fractal noise generation.|
|**Mapping Settings**|Various settings related to remapping input values or mapping to a color gradient.|
|**Texture Settings**|Common Texture Importer settings|

A histogram view is also provided to see the distribution of noise values across the entire texture.

### Fractal Parameters Terminology
|Parameter      |Description|
|---------------|-----------|
|Octaves|The number of fractal noise layers added together. Higher values create more detailed noise. High octave counts can have a significant performance hit.|
|Lacunarity|The factor by which the frequency increases for each subsequent octave. Usually set to `2.0`, indicating that each octave doubles in frequency relative to the last.|
|Persistence|The factor by which the amplitude decreases per octave. Higher values generate rougher noise. Usually set to `0.5`.|

