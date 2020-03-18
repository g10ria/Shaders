#ifdef GL_ES
precision mediump float;
#endif


void main() {
    vec2 st = gl_FragCoord.xy/iResolution.xy;
    
    float mix1 = (st.x<0.25) ? st.x * 4.0 : (0.75-(st.x-0.25)) / 0.75;
    float mix2 = (st.x<0.5) ? st.x * 2.0 : (0.5-(st.x-0.5)) * 2.0;
    float mix3 = (st.x<0.75) ? st.x /0.75 : (0.25-(st.x-0.75)) * 4.0;
    vec3 pct = vec3(mix1,mix2,mix3);

    vec3 color = mix(vec3(1.0,1.0,1.0), vec3(0.0,0.0,0.0), pct);



    gl_FragColor = vec4(color, 1.0);
}