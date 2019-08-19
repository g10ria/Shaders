#ifdef GL_ES
precision mediump float;
#endif

#define TWO_PI 6.2831853

vec3 hsv_rgb(in vec3 c) {
    // cool conversion
    vec3 rgb = clamp(abs(mod(c.x * 6.0 + vec3(0.0,4.0,2.0),6.0)-3.0)-1.0,0.0,1.0);
    return c.z * mix(vec3(1.0),rgb,c.y);
}

void main() {
    vec2 st = gl_FragCoord.xy / iResolution.xy;

    // important - sets the center to 0.5, 0.5
    vec2 rot = vec2(0.5)-st;

    // normalizing and shaping
    // float colDif = sin(iTime)+1.0;
    float colDif = mod(iTime, 1.0);
    float valDif = cos(iTime)/4.0 + 0.5;

    float len = length(rot) * 2.0;
    float nAngle = ((atan(rot.y,rot.x))/TWO_PI) + 0.5;

    vec3 color = hsv_rgb(vec3(nAngle, len, 1.0));
    gl_FragColor = vec4(hsv_rgb(vec3(nAngle+colDif,len, valDif)),1.0);
}