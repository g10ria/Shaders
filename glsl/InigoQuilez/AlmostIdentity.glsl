#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

/**
Linear function for x>m
For x<=m, interpolates such that y=n at x=0; maintains
same slope at x=m and zero slope at x=0
*/
float almostIdentity(float x,float m,float n)
{
    if(x>m)return x;
    float a=2.*n-m;
    float b=2.*m-3.*n;
    float t=x/m;
    return(a*t+b)*t*t+n;
}

/**
Basically the same as above with m = 1 and n = 0
Useful because slope = 1 at x = 1 and slope = 0 at x = 0;
can be used for "speeding up".
*/
float almostUnitIdentity(float x)
{
    return almostIdentity(x,1.,0.);
}

/**
An almost-identity that can double as a smooth
absolute function (symmetric about y axis)
*/
float smoothAbsAlmostIdentity(float x, float n)
{
    return sqrt(x*x+n);
}

float plot(vec2 st, float pct, float stroke)
{
    return smoothstep(pct-stroke,pct,st.y)-
    smoothstep(pct,pct+stroke,st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;

    float stroke = 0.005;

    vec3 background = vec3(0.1,0.1,0.1);

    float pct1 = plot(st, almostIdentity(st.x,.2,.25), stroke);
    float pct2 = plot(st, almostUnitIdentity(st.x), stroke);
    float pct3 = plot(st, smoothAbsAlmostIdentity(st.x,0.02), stroke);

    vec3 color = (1.0-pct1) * (1.0-pct2) * background + 
    pct1 * vec3(0.,0.,1.) + 
    pct2 * vec3(0.,1.,0.) +
    pct3 * vec3(1.,0,0);

    gl_FragColor = vec4(color, 1.);
}