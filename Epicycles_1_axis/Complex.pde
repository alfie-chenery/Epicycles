class Complex{
  float Re;
  float Im;
  float amp;
  int freq;
  float phase;
 
  Complex(float a, float b){
    Re=a;
    Im=b;
    
    amp = 0;
    freq = 0;
    phase = 0;
  }
  
  void calculateCycle(int f){
    amp = sqrt(Re*Re+Im*Im);
    phase = atan2(Im,Re);
    freq = f;
  }
}



  Complex MULT(Complex a, Complex b){
    float Re = a.Re * b.Re - a.Im * b.Im;
    float Im = a.Re * b.Im + a.Im * b.Re;
    Complex c = new Complex(Re,Im);
    return c;
  }
  
  Complex ADD(Complex a, Complex b){
    float Re = a.Re + b.Re;
    float Im = a.Im + b.Im; 
    Complex c = new Complex(Re,Im);
    return c;
  }
  
  Complex DIV(Complex a, float b){
    float Re = a.Re/b;
    float Im = a.Im/b;
    Complex c = new Complex(Re,Im);
    return c;
  }
