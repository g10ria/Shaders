#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float plot(vec2 st,float pct, float stroke)
{
    // smoothstep interpolates between the first two given
    // parameters according to the value of the third
    // in this case, this sum returns a maximum value of 1
    // when y = pct (smoothstep1 = 1, smoothstep2 = 0)
    // if y is within the 0.2 tolerance, it interpolates to
    // 0, and outside of 0.2 it is 0 (see casework to prove)
    return smoothstep(pct-stroke,pct,st.y)-
    smoothstep(pct,pct+stroke,st.y);
}

void main(){
    vec2 st=gl_FragCoord.xy/u_resolution;
    
    // float y=st.x; // Linear
    // float y=pow(st.x,2.); // Square
    // float y=sqrt(st.x); // Square root
    // float y = 0.2 * exp(st.x); // Natural exponent
    float y = -log(st.x); // Natural log
    
    vec3 color=vec3(y);

    float stroke = 0.005;
    
    float pct=plot(st,y, stroke);

    // the larger pct is, the more green it is
    color=(1.-pct)*color+pct*vec3(0.,1.,0.);
    
    gl_FragColor=vec4(color,1.);
}
