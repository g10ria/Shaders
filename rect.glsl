#ifdef GL_ES
precision mediump float;
#endif

void draw(vec2 st, vec2 center, float width, float height, inout vec3 color, vec3 paint) {
    st.x -= center.x;
    st.y -= center.y;
    float xpos = step((1.0-width)/2.0,st.x);
    float xneg = step((1.0-width)/2.0,1.0-st.x);
    float ypos = step((1.0-height)/2.0,st.y);
    float yneg = step((1.0-height)/2.0,1.0-st.y);

    if (vec4(xpos,xneg,ypos,yneg)==vec4(1.0)) color = paint;
}

void drawOutline(vec2 st, vec2 center, float width, float height, inout vec3 color, vec3 paint, float thickness) {
    vec2 leftCenter = vec2(center.x-width/2.0+thickness/2.0, center.y);
    vec2 rightCenter = vec2(center.x+width/2.0-thickness/2.0, center.y);
    vec2 topCenter = vec2(center.y, center.y+height/2.0-thickness/2.0);
    vec2 botCenter = vec2(center.y, center.y-height/2.0+thickness/2.0);

    draw(st,leftCenter, thickness, height, color, paint);
    draw(st,rightCenter, thickness, height, color, paint);
    draw(st,topCenter, width, thickness, color, paint);
    draw(st,botCenter, width, thickness, color, paint);
}

void main() {
    vec2 st = gl_FragCoord.xy/iResolution.xy;
    vec3 color = vec3(1.0);

    drawOutline(st,vec2(0.0,0.0),0.3,0.4,color, vec3(1.0,0.0,0.0),0.01);
    draw(st,vec2(0.2,0.2),0.3,0.4,color, vec3(0.0,1.0,0.0));

    gl_FragColor = vec4(color,1.0);
}