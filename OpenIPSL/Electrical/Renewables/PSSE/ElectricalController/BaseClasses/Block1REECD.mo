within OpenIPSL.Electrical.Renewables.PSSE.ElectricalController.BaseClasses;
model Block1REECD

  Modelica.Blocks.Interfaces.RealInput Vt annotation (Placement(transformation(extent={{-140,46},{-100,86}}), iconTransformation(extent={{-140,50},{-100,90}})));
  Modelica.Blocks.Interfaces.RealInput It annotation (Placement(transformation(extent={{-140,-70},{-100,-30}}), iconTransformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,10}})));

  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  import Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.j;

  parameter Types.PerUnit Rc=0 "Resistance";
  parameter Types.PerUnit Xc=0 "Reactance";
  parameter Complex Z(re=Rc, im=Xc);
  Complex Vterm;
  Complex Iterm;
  Complex C;
  OpenIPSL.Types.Angle angle;
  OpenIPSL.Types.PerUnit Vmag "Bus voltage magnitude";
  OpenIPSL.Types.PerUnit Imag "Terminal current magnitude";
  OpenIPSL.Types.PerUnit V_re;
  OpenIPSL.Types.PerUnit V_im;
  OpenIPSL.Types.PerUnit I_re;
  OpenIPSL.Types.PerUnit I_im;

  Modelica.Blocks.Interfaces.RealInput Angle_in annotation (Placement(transformation(extent={{-140,-18},{-100,22}}), iconTransformation(extent={{-140,-12},{-100,28}})));

equation
 Vmag = Vt;
 Imag = It;
 angle = Angle_in;

 // Calculate the real and imaginary parts
 V_re = Vmag * cos(angle); // Real part of the voltage
 V_im = Vmag * sin(angle); // Imaginary part of the voltage
 I_re = Imag * cos(angle); // Real part of the current
 I_im = Imag * sin(angle); // Imaginary part of the current
 Vterm = V_re + j*V_im;
 Iterm = I_re + j*I_im;
 C = Vterm - (Z*Iterm);
 y = abs(C);

  annotation (Icon(graphics={Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255}), Text(
          extent={{-84,-44},{88,48}},
          textColor={28,108,200},
          textStyle={TextStyle.Bold},
          textString="Block1")}));
end Block1REECD;
