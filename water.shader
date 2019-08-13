Shader "Custom/Water"
{
  Properties {
    _Color ("Diffuse Material Color", Color) = (1,1,1,1)
    _Transparency ("Water Transparency", Float) = 0.3
    _WaveSpeed ("Wave Speed", Float) = 0.5
    _WaveAmp ("Wave Amplitude", Float) = 0.5
    _NoiseTex ("Noise Texture", 2D) = "" {}
  }
  SubShader
  {

    //   water shader written in shaderlab
    
    Pass
    {
      Tags {
        "Queue" = "Transparent"
        "LightMode" = "ForwardBase"
      }

      ZWrite Off
      Blend SrcAlpha OneMinusSrcAlpha

      CGPROGRAM
      #include "UnityCG.cginc"
      #pragma vertex vert
      #pragma fragment frag

      uniform float4 _LightColor0;
      uniform float4 _Color;
      // uniform float _Time;
      uniform float _Transparency;

      uniform float _WaveSpeed;
      uniform float _WaveAmp;
      uniform sampler2D _NoiseTex;

      struct vertexInput {
        float4 vertex : POSITION;
        float3 normal : NORMAL;
        fixed4 color : COLOR;
        float4 texcoord : TEXCOORD0;
      };

      struct vertexOutput {
        float4 pos : SV_POSITION;
        fixed4 col : COLOR;
      };

      vertexOutput vert(vertexInput input) {
        vertexOutput output;

        float4x4 modelMatrx = unity_ObjectToWorld;
        float4x4 modelMatrixInverse = unity_WorldToObject;
        float3 normalDirection = normalize(mul(float4(input.normal,0.0), modelMatrixInverse).xyz);
        float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
        float3 diffuseReflection = _LightColor0.rgb * _Color.rgb * max(0.0, dot(normalDirection,lightDirection));
        output.col = float4(diffuseReflection, _Transparency);

        output.pos = UnityObjectToClipPos(input.vertex);

        float noiseSample = tex2Dlod(_NoiseTex, float4(input.texcoord.xy, 0.0, 0.0));
        output.pos.y += sin(_Time[3]*_WaveSpeed * input.vertex.x)*_WaveAmp;
        
        return output;
      }

      float4 frag(vertexOutput input) : COLOR {
        return input.col;
      }

      ENDCG
    }

  }}
