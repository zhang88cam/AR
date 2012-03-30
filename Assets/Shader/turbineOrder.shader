Shader "Custom/turbineOrder" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		//Tags { "RenderType"="Opaque" "Queue"="Geometry" }
		Tags {"RenderType"="Transparent" "IgnoreProjector"="True" "Queue"="Transparent+1" }
		//Lighting Off
		//Cull Off
		//ZTest Always
		//ZWrite Off
//		ZTest Always

		LOD 200
		Pass {
		
//			Material {
//				Diffuse (1, 1, 1, 1)
//			}
//					ZTest GEqual
//					setTexture[_MainTex] {combine texture * primary}

		
	}

//		
//		CGPROGRAM
//		#pragma surface surf Lambert
//
//		sampler2D _MainTex;
//
//		struct Input {
//			float2 uv_MainTex;
//		};
//
//		void surf (Input IN, inout SurfaceOutput o) {
//			half4 c = tex2D (_MainTex, IN.uv_MainTex);
//			o.Albedo = c.rgb;
//			o.Alpha = c.a;
//		}
//		ENDCG
	} 
//	FallBack "Diffuse"
}
