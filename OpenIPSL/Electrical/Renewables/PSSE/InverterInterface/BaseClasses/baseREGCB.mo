within OpenIPSL.Electrical.Renewables.PSSE.InverterInterface.BaseClasses;
partial model baseREGCB "Base renewable generator/converter B for PSSE models"
  import Complex;
  import Modelica.ComplexMath.j;
  import Modelica.ComplexMath.arg;
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  import Modelica.ComplexMath.conj;
  import Modelica.Blocks.Interfaces.*;
  parameter OpenIPSL.Types.ApparentPower M_b=SysData.S_b "Machine base power" annotation (Dialog(group="Power flow data"));
  extends OpenIPSL.Electrical.Essentials.pfComponent(
    final enabledisplayPF=false,
    final enablefn=false,
    final enableV_b=false,
    final enableangle_0=true,
    final enablev_0=true,
    final enableQ_0=true,
    final enableP_0=true,
    final enableS_b=true);

  // Set of Model Parameters
  parameter Modelica.Units.SI.Time Tg = 0.02 "Converter time constant (0.02-0.05s)" annotation (Dialog(group="Input Parameters"));
  parameter OpenIPSL.Types.PerUnit rrpwr = 10 "Low Voltage Power Logic (LVPL) ramp rate limit (1-20 pu/s)" annotation (Dialog(group="Input Parameters"));
  parameter Modelica.Units.SI.Time Tfltr = 0.02 "Voltage filter time constant for low voltage active current management (s)" annotation (Dialog(group="Input Parameters"));
  parameter Modelica.Units.SI.Time Te = 0 "Generator network impedance time constant(0-0.02s)" annotation (Dialog(group="Input Parameters"));
  parameter OpenIPSL.Types.PerUnit Iqrmax = 9999 "Upper limit on rate of change for reactive current (pu/s)" annotation (Dialog(group="Input Parameters"));
  parameter OpenIPSL.Types.PerUnit Iqrmin = -9999 "Lower limit on rate of change for reactive current (pu/s)" annotation (Dialog(group="Input Parameters"));
  parameter Boolean rflag=true "Constant output value" annotation (Dialog(tab="Control"));
  parameter Types.PerUnit Re=0.01 "Generator Effective Resistance(0-0.01 pu)";
  parameter Types.PerUnit Xe=0.5 "Generator Effective Reactance(0.05-0.2 pu)";
  parameter Boolean pqflag=true;

  OpenIPSL.Interfaces.PwPin p(
    vr(start=vr0),
    vi(start=vi0),
    ir(start=-ir0*CoB),
    ii(start=-ii0*CoB)) annotation (Placement(transformation(extent={{130,-10},{150,10}}),
                          iconTransformation(extent={{130,-10},{150,10}})));
  Modelica.Blocks.Interfaces.RealInput Iqcmd(start=-Iq0)
    annotation (Placement(transformation(extent={{-180,60},{-140,100}}),
        iconTransformation(extent={{-180,50},{-140,90}})));
  Modelica.Blocks.Interfaces.RealInput Ipcmd(start=Ip0)
    annotation (Placement(transformation(extent={{-180,-80},{-140,-40}}),
        iconTransformation(extent={{-180,-90},{-140,-50}})));
  Modelica.Blocks.Interfaces.RealOutput IQ0 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-120,-150}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-120,-150})));
  Modelica.Blocks.Interfaces.RealOutput IP0 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-150}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-150})));
  Modelica.Blocks.Interfaces.RealOutput V_0 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-150})));
  Modelica.Blocks.Interfaces.RealOutput q_0 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-150})));
  Modelica.Blocks.Interfaces.RealOutput p_0 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={120,-150})));
  Modelica.Blocks.Interfaces.RealOutput V_t annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-116,150}),iconTransformation(extent={{-10,-10},{10,10}},
          origin={-104,150},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput Pgen "Value of Real output"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,150}),  iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,150})));
  Modelica.Blocks.Interfaces.RealOutput Qgen "Value of Real output"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={102,150}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={110,150})));

  Modelica.Blocks.Interfaces.RealOutput I_t annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,150}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,150})));
  Modelica.Blocks.Interfaces.RealOutput Angle_t annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={6,150}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={6,150})));
  Modelica.Blocks.Interfaces.RealOutput I_0 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={34,-150}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={34,-150})));
protected
  OpenIPSL.Types.Angle delta(start=angle_0);
  OpenIPSL.Types.PerUnit VT(start=v0) "Bus voltage magnitude";
  OpenIPSL.Types.PerUnit IT(start=sqrt(ir0^2 + ii0^2)) "Terminal current magnitude";
  OpenIPSL.Types.Angle anglev(start=angle_0) "Bus voltage angle";
  parameter OpenIPSL.Types.PerUnit p0=P_0/M_b "Initial active power (machine base)";
  parameter OpenIPSL.Types.PerUnit q0=Q_0/M_b "Initial reactive power (machine base)";
  parameter OpenIPSL.Types.PerUnit vr0 = Re * ir0 - Xe * ii0;
  parameter OpenIPSL.Types.PerUnit vi0 = Re * ii0 + Xe * ir0;
  parameter OpenIPSL.Types.PerUnit v0 = sqrt(vr0^2 + vi0^2);
  parameter OpenIPSL.Types.PerUnit ir0=(p0*vr0 + q0*vi0)/(vr0^2 + vi0^2);
  parameter OpenIPSL.Types.PerUnit ii0=(p0*vi0 - q0*vr0)/(vr0^2 + vi0^2);
  //parameter OpenIPSL.Types.PerUnit Isr0=ir0 "Source current re M_b";
  //parameter OpenIPSL.Types.PerUnit Isi0=ii0 "Source current im M_b";
  //parameter OpenIPSL.Types.PerUnit Ip0=Isr0*cos(-angle_0) - Isi0*sin(-angle_0);
  //parameter OpenIPSL.Types.PerUnit Iq0=(Isr0*sin(-angle_0) + cos(-angle_0)*Isi0);
  parameter Real CoB=M_b/S_b "Change of base";

  //parameter OpenIPSL.Types.PerUnit Itermr(start=ir0);
  //parameter OpenIPSL.Types.PerUnit Itermq(start=ii0);
  ///parameter OpenIPSL.Types.PerUnit Imaxd( start=0);
  //parameter OpenIPSL.Types.PerUnit Imaxq( start=0);
  //parameter OpenIPSL.Types.PerUnit Ireal(start=0);
  //parameter OpenIPSL.Types.PerUnit Iimag(start=0);
  parameter OpenIPSL.Types.PerUnit Ir(start=ir0);
  parameter OpenIPSL.Types.PerUnit Ii(start=ii0);
  parameter Real Imax=1.4;

  parameter OpenIPSL.Types.PerUnit Ed0 = Edcalc0;
  parameter OpenIPSL.Types.PerUnit Eq0 = Eqcalc0;
  parameter OpenIPSL.Types.PerUnit Eqcalc0 = vi0;
  parameter OpenIPSL.Types.PerUnit Edcalc0 = vr0;
  parameter OpenIPSL.Types.PerUnit Iqneg0 = (Eqcalc0 - Ip0*Xe)/Re;
  parameter OpenIPSL.Types.PerUnit Ip0 = (Edcalc0- v0 + Iqneg0*Xe)/Re;
  parameter OpenIPSL.Types.PerUnit Iq0 = Iqneg0;

equation
  anglev = atan2(p.vi, p.vr);
  VT = sqrt(p.vr*p.vr + p.vi*p.vi);
  IT = sqrt(p.ii^2 + p.ir^2);
  delta = anglev;
  Angle_t = delta;

 annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},
            {140,140}}), graphics={
        Rectangle(extent={{-140,140},{140,-140}}, lineColor={28,108,200}),
        Text(
          extent={{-126,90},{-66,50}},
          textColor={0,0,255},
          textString="IQCMD"),
        Text(
          extent={{-126,-50},{-66,-90}},
          textColor={0,0,255},
          textString="IPCMD"),
        Text(
          extent={{-136,-100},{-104,-140}},
          textColor={0,0,255},
          textString="IQ0"),
        Text(
          extent={{-76,-100},{-44,-140}},
          textColor={0,0,255},
          textString="IP0"),
        Text(
          extent={{-24,-106},{4,-138}},
          textColor={0,0,255},
          textString="V0"),
        Text(
          extent={{46,-104},{74,-136}},
          textColor={0,0,255},
          textString="Q0"),
        Text(
          extent={{106,-104},{134,-136}},
          textColor={0,0,255},
          textString="P0"),
        Text(
          extent={{-124,134},{-84,104}},
          textColor={0,0,255},
          textString="VT"),
        Text(
          extent={{44,132},{84,110}},
          textColor={0,0,255},
          textString="PGEN"),
        Text(
          extent={{96,128},{136,102}},
          textColor={0,0,255},
          textString="QGEN"),
        Text(
          extent={{-72,134},{-32,104}},
          textColor={0,0,255},
          textString="IT"),
        Text(
          extent={{-12,136},{28,106}},
          textColor={0,0,255},
          textString="Angle"),
        Text(
          extent={{18,-110},{38,-138}},
          textColor={0,0,255},
          textString="I0")}),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,140}})));
end baseREGCB;
