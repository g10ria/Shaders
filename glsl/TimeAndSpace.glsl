#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main(){
    vec2 st= gl_FragCoord.xy/u_resolution;
    float mouseX = u_mouse.x/u_resolution.x;
    float mouseY = u_mouse.y/u_resolution.y;
    gl_FragColor=vec4(mouseX, mouseY, sin(u_time), 1.);
}