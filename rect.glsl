#ifdef GL_ES
precision mediump float;
#endif

void draw(vec2 st, vec2 center, float width, float height, inout vec3 color) {
    st.x -= center.x;
    st.y -= center.y;
    float xpos = step((1.0-width)/2.0,st.x);
    float xneg = step((1.0-width)/2.0,1.0-st.x);
    float ypos = step((1.0-height)/2.0,st.y);
    float yneg = step((1.0-height)/2.0,1.0-st.y);

    if (vec4(xpos,xneg,ypos,yneg)==vec4(1.0)) color *= 0.0;
}

void main() {
    vec2 st = gl_FragCoord.xy/iResolution.xy;
    vec3 color = vec3(1.0);

    draw(st,vec2(0.0,0.0),0.3,0.4,color);
    draw(st,vec2(0.2,0.2),0.3,0.4,color);

    gl_FragColor = vec4(color,1.0);
}

