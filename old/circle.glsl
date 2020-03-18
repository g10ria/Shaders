#ifdef GL_ES
precision mediump float;
#endif

void drawCirc(vec2 st, vec2 center, float radius, inout vec3 color, vec3 paint) {    
    float dist = distance(st,center);
    float step = step(radius,dist);

    if (step==0.0)
        color = paint;
}

void drawCirclingCirc(vec2 st, vec2 center, float radius, inout vec3 color, vec3 paint) {
    st.x += sin(iTime)/2.0;
    st.y += cos(iTime)/2.0;
    
    drawCirc(st,center,radius,color,paint);
}

void drawOutlinedCirc(vec2 st, vec2 center, float radius, inout vec3 color, vec3 paint, float thickness) {
    float dist = distance(st,center);
    float outStep = step(radius,dist);
    float inStep = step(radius-thickness,dist);

    if (outStep==0.0  && inStep==1.0)
        color = paint;
}

void main() {
    vec2 st = gl_FragCoord.xy/iResolution.xy; 
    float dist = distance(st,vec2(0.5))  * 2.0;

    vec3 color = vec3(1.0);

    drawOutlinedCirc(st, vec2(0.5,0.5),0.5,color,vec3(0.0,1.0,0.0),0.01);
    drawCirc(st,vec2(0.6,0.7),0.1,color,vec3(0.0,0.3,0.3));
    drawCirclingCirc(st, vec2(0.5,0.5),0.3,color, vec3(1.0,0.0,0.0));
    
    
    
    gl_FragColor = vec4(color,1.0);
}