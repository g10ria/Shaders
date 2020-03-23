#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_time;

float plot(vec2 st, float y, float stroke)
{
    return smoothstep(y-stroke, y, st.y) - 
            smoothstep(y, y+stroke, st.y);
}

float expImpulse(float x, float k)
{
    float h=k*x;
    return h*exp(1.-h);
}

float almostIdentity(float x,float m,float n)
{
    if(x>m)return x;
    float a=2.*n-m;
    float b=2.*m-3.*n;
    float t=x/m;
    return(a*t+b)*t*t+n;
}

float plotVec(vec2 st,float y,float stroke, float k)
{
    // basically,the width is the same function shown 
    // to the right except it's offset  by 1/k
    // (the critical point is at 1/k)
    float exp = expImpulse(st.x+1./k, k);
    
    // almost identity prevents the width from going to
    // 0 at x = 1
    float width=almostIdentity(exp, 0.1, 0.1)*stroke;
    
    return plot(st,y,width);
}

void main()
{
    vec2 st = gl_FragCoord.xy/u_resolution;

    float stroke = 0.01;

    vec3 background = vec3(.1,.1,.1);
    
    float pct1 = plotVec(st, expImpulse(st.x, 1.), stroke, 1.);
    float pct2 = plotVec(st, expImpulse(st.x,4.), stroke, 4.);
    float pct3 = plotVec(st, expImpulse(st.x,10.), 3. * stroke, 10.);

    vec3 color = (1.0-pct1) * (1.0-pct2) * (1.0-pct3) * background + 
    pct1 * vec3(0,0,1.) + 
    pct2 * vec3(0, 1., 0) +
    pct3 * vec3(1.,0,0);

    gl_FragColor = vec4(color, 1.0);
}