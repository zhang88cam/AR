Shader "Custom/cubeOrder" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		//Tags { "RenderType"="Opaque" "Queue" = "Geometry + 1" }
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		//Lighting Off
		//Cull Off
		//ZTest Always //{1}
		
//		Pass {
		
//			Material {
//				Diffuse (1, 1, 1, 1)
//			}
//			
//					ZWrite Off

		
//		}
		
		//LOD 200
		//ZTest Always //{1}
		
		//ZWrite Off

		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
