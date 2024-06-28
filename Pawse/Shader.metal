//
//  Shader.metal
//  Pawse
//
//  Created by hendra on 25/06/24.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 recolor(float2 position, half4 color, half4 replacement) {
    return replacement * color.a;
}


