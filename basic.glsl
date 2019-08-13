#ifdef GL_ES
precision mediump float;
#endif

float plot(vec2 st,float pct){
    return smoothstep(pct-.01,pct,st.y)-smoothstep(pct,pct+0.01,st.y);
}

void main() {
	vec2 st = gl_FragCoord.xy/iResolution.xy;
    float y = pow(st.x,5.0);

    vec3 color = vec3(y);

    float pct = plot(st,y);
    color = (1.0-pct) * color + pct * vec3(1.0,0.0,0.0);

    gl_FragColor = vec4(color, 1.0);
	
}

