//
//  Shaders.metal
//  iPadGame
//
//  Created by Andrew Clear on 5/24/16.
//  Copyright © 2016 Andrew Clear. All rights reserved.
//

#include <metal_stdlib>

using namespace metal;

struct Constants
{
    float4x4 mvp;
    float3x3 normalMatrix;
};

struct Vertex_PositionNormalColor_In
{
    float3  position [[attribute(0)]];
    float4  color [[attribute(1)]];
    float3  normal [[attribute(2)]];
};

struct Vertex_PositionNormalColor_Out
{
    float4 position [[position]];
    float4 color;
    float3 normal;
};

vertex Vertex_PositionNormalColor_Out passThroughVertex(Vertex_PositionNormalColor_In inVertex [[stage_in]], constant Constants &uniforms [[buffer(1)]])
{
    Vertex_PositionNormalColor_Out outVertex;
    //Vertex_PositionNormalColor_In inVertex = vertices[vertexID];
    
    outVertex.position = uniforms.mvp * float4(inVertex.position, 1);
    outVertex.normal = inVertex.normal;
    outVertex.color = inVertex.color;
    
    return outVertex;
};

fragment half4 passThroughFragment(Vertex_PositionNormalColor_Out inFrag [[stage_in]])
{
    return half4(inFrag.color);
};