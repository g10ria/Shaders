#ifdef GL_ES
precision mediump float;
#endif

vec3 color1 = vec3(0.8, 0.1, 1.0);
vec3 color2 = vec3(0.9, .6, 0.0);

void main() {
    vec2 st = gl_FragCoord.xy/iResolution.xy;
    
    float mixAmount = st.x;
    float mixY = (st.y<0.4 && st.y>0.2 && st.x>0.5) ? 0.4-st.y : 
    (st.y<0.4 && st.y>0.2 && st.x<0.5 && st.x>0.2) ? ((st.x-0.2)/0.3) * (0.4-st.y) : 0.0;

    vec3 color = mix(color1, color2, mixAmount);
    color = mix(color, vec3(1.0,0.0,0.0), mixY);

    gl_FragColor = vec4(color, 1.0);
}