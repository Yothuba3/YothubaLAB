#ifndef YOTHUBALAB_RECEIVESHAODW_INCLUDED
#define YOTHUBALAB_RECEIVESHADOW_INCLUDED


#ifndef SHADERGRAPH_PREVIEW
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
#endif
#pragma multi_compile _ _MAIN_LIGHT_SHADOWS
#pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
#pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
#pragma multi_compile _ _SHADOWS_SOFT

void ReceiveShadow_float(float shadowAlpha,float3 worldPos, out half shadowAttenuation)
{
    #ifdef SHADERGRAPH_PREVIEW
    shadowAttenuation = 1.0;
    
    #else
    half4 shadowCoord = TransformWorldToShadowCoord(worldPos);
    Light mainLight = GetMainLight(shadowCoord);
    half shadow = mainLight.shadowAttenuation;
    int pixelLightCount = GetAdditionalLightsCount();
    for(int i = 0; i < pixelLightCount; i++)
    {
        Light AddLight0 = GetAdditionalLight(i, worldPos,1);
        half shadow0 = AddLight0.shadowAttenuation;
        shadow *= shadow0;
    }
    
    
    shadowAttenuation = shadow;
    #endif
   
}


#endif
