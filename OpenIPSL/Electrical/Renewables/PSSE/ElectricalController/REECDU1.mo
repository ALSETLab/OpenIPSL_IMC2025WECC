within OpenIPSL.Electrical.Renewables.PSSE.ElectricalController;
model REECDU1 "Electrical control model for large scale wind (TEST)"
  extends
    OpenIPSL.Electrical.Renewables.PSSE.ElectricalController.BaseClasses.BaseREECD(
     Iqcmd(start=Iq0), Ipcmd(start=Ip0));

  parameter OpenIPSL.Types.PerUnit Vdip = -99 "Low voltage threshold to activate reactive current injection logic (0.85 – 0.9 pu)";
  parameter OpenIPSL.Types.PerUnit Vup = 99 "Voltage above which reactive current injection logic is activated (>1.1 pu)";
  parameter OpenIPSL.Types.Time Trv = 0.02 "Filter time constant for voltage measurement (0.02-0.05 s)";
  parameter OpenIPSL.Types.Time Tr1 = 0 "Filter time constant for voltage measurement (0s)";
  parameter OpenIPSL.Types.PerUnit dbd1 = -0.05 "Voltage error dead band lower threshold (-0.1 – 0 pu)";
  parameter OpenIPSL.Types.PerUnit dbd2 = 0.05 "Voltage error dead band upper threshold (0 – 0.1 pu)";
  parameter Real Kqv = 0 "Reactive current injection gain during over and undervoltage conditions (0 – 10)";
  parameter Real Kc = 0 "Reactive current compensation gain is zero";
  parameter OpenIPSL.Types.PerUnit Iqh1 = 1.05 "Upper limit on reactive current injection Iqinj (1 – 1.1 pu)";
  parameter OpenIPSL.Types.PerUnit Iql1 = -1.05 "Lower limit on reactive current injection Iqinj (-1.1 – 1 pu)";
  parameter OpenIPSL.Types.PerUnit vref0 = 0 "User defined voltage reference (0.95 – 1.05 pu)";
  parameter OpenIPSL.Types.PerUnit Iqfrz = 0.15 "Value at which Iqinj is held for Thld seconds following a voltage dip if Thld > 0";
  parameter OpenIPSL.Types.Time Thld = 0 "Time for which Iqinj is held at Iqfrz after voltage dip returns to zero";
  parameter OpenIPSL.Types.Time Tp = 0.05 "Filter time constant for electrical power (0.01 - 0.1 s)";
  parameter OpenIPSL.Types.PerUnit QVmax = 0.4 "Upper limits of the limit for the incoming Qext or Vext(pu)";
  parameter OpenIPSL.Types.PerUnit QVmin = -0.4 "Lower limits of the  limit for the incoming Qext or Vext(pu)";
  parameter OpenIPSL.Types.PerUnit Vmax = 1.1 "Maximum limit for voltage control (1.05 – 1.1 pu)";
  parameter OpenIPSL.Types.PerUnit Vmin = 0.9 "Lower limits of input signals (0.9 – 0.95 pu)";
  parameter Real Kqp = 0 "Reactive power regulator proportional gain (No predefined range)";
  parameter Real Kqi = 0.1 "Reactive power regulator integral gain (No predefined range)";
  parameter Real Kvp = 0 "Voltage regulator proportional gain (No predefined range)";
  parameter Real Kvi = 120 "Voltage regulator integral gain (No predefined range)";
  parameter OpenIPSL.Types.PerUnit Vbias = 0 "User-defined reference/bias on the inner-loop voltage control (No predefined range)";
  parameter OpenIPSL.Types.Time Tiq = 0.02 "Time constant on lag delay (0.01 - 0.02 s)";
  parameter Real dPmax = 99 "Power reference maximum ramp rate (No predefined range pu/s)";
  parameter Real dPmin = -99 "Lower limits of input signals (No predefined range pu/s)";
  parameter OpenIPSL.Types.PerUnit Pmax = 1 "Maximum power limit (1 pu)";
  parameter OpenIPSL.Types.PerUnit Pmin = 0 "Minimum power limit (0 pu)";
  parameter OpenIPSL.Types.PerUnit Imax = 1.7 "Maximum limit on total converter current (1.1 – 1.3 pu)";
  parameter OpenIPSL.Types.Time Tpord = 0.04 "Power filter time constant (0.01 - 0.02 s) ";
  parameter OpenIPSL.Types.PerUnit Vq1 = 0 "Reactive Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Iq1 = 1.2 "Reactive Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vq2 = 0.2 "Reactive Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Iq2 = 1.2    "Reactive Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vq3 = 0.72 "Reactive Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Iq3 = 1.2 "Reactive Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vq4 = 1.00 "Reactive Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Iq4 = 0.5 "Reactive Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vq5 = 1.20 "Reactive Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Iq5 = 0.5 "Reactive Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vq6 = 1.40 "Reactive Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Iq6 = 0.5    "Reactive Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vq7 = 1.60 "Reactive Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Iq7 = -1.2 "Reactive Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vq8 = 1.80 "Reactive Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Iq8 = -1.2 "Reactive Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vq9 = 2.0 "Reactive Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Iq9 = -1.2 "Reactive Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vq10 = 2.2 "Reactive Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Iq10 = -1.2 "Reactive Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vp1 = 0.00 "Real Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Ip1 = 0.00 "Real Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vp2 = 0.15 "Real Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Ip2 = 1.00 "Real Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vp3 = 0.46 "Real Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Ip3 = 1.00 "Real Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vp4 = 0.67 "Real Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Ip4 = 1.00 "Real Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vp5 = 1.21 "Real Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Ip5 = 1.15 "Real Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vp6 = 1.40 "Real Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Ip6 = 1.15 "Real Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vp7 = 1.62 "Real Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Ip7 = 1.30 "Real Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vp8 = 1.80 "Real Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Ip8 = 1.30 "Real Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vp9 = 2.0 "Real Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Ip9 = 1.30 "Real Power V-I pair, current (user defined)";
  parameter OpenIPSL.Types.PerUnit Vp10 = 2.2 "Real Power V-I pair, voltage (user defined)";
  parameter OpenIPSL.Types.PerUnit Ip10 = 0.00 "Real Power V-I pair, current (user defined)";
  parameter Real baseload = 0 "(Can be set to 0/1/2)";
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  import Modelica.ComplexMath.abs;

  parameter Types.PerUnit Rc=0 "Resistance";
  parameter Types.PerUnit Xc=0 "Reactance";
  import Modelica.ComplexMath.j;

  parameter Complex Z(re=Rc, im=Xc);

  Boolean Voltage_dip;

  Modelica.Blocks.Sources.BooleanConstant PfFlag_logic(k=pfflag)
    annotation (Placement(transformation(extent={{-364,66},{-344,86}})));
  Modelica.Blocks.Logical.Switch PfFlag
    "Constant Q (False) or PF (True) local control."
    annotation (Placement(transformation(extent={{-258,118},{-238,138}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=QVmax, uMin=QVmin)
    annotation (Placement(transformation(extent={{-194,118},{-174,138}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{-146,112},{-126,132}})));
  Modelica.Blocks.Sources.BooleanConstant Vflag_logic(k=vflag)
    annotation (Placement(transformation(extent={{-124,80},{-104,100}})));
  Modelica.Blocks.Logical.Switch VFlag
    "Constant Q (False) or PF (True) local control."
    annotation (Placement(transformation(extent={{-36,104},{-16,124}})));
  Modelica.Blocks.Nonlinear.Limiter limiter3(uMax=Vmax, uMin=Vmin)
    annotation (Placement(transformation(extent={{6,104},{26,124}})));
  Modelica.Blocks.Math.Add add4(k2=-1)
    annotation (Placement(transformation(extent={{56,104},{76,124}})));
  Modelica.Blocks.Sources.RealExpression IQMAX_(y=CLL_REECD.Iqmax)
                                                             annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={100,184})));
  Modelica.Blocks.Sources.RealExpression IQMIN_(y=CLL_REECD.Iqmin)
                                                             annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={92,76})));
  Modelica.Blocks.Logical.Switch QFlag
    annotation (Placement(transformation(extent={{164,52},{184,72}})));
  Modelica.Blocks.Sources.BooleanConstant QFLAG(k=qflag)
    annotation (Placement(transformation(extent={{40,42},{60,62}})));
  Modelica.Blocks.Math.Add add6(k2=+1)
    annotation (Placement(transformation(extent={{184,104},{204,124}})));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter
    annotation (Placement(transformation(extent={{234,76},{254,96}})));
  Modelica.Blocks.Sources.RealExpression IQMIN(y=CLL_REECD.Iqmin)
    annotation (Placement(transformation(extent={{248,42},{228,22}})));
  Modelica.Blocks.Sources.RealExpression IQMAX(y=CLL_REECD.Iqmax)
    annotation (Placement(transformation(extent={{246,136},{226,156}})));
  Modelica.Blocks.Math.Add add7(k2=-1)
    annotation (Placement(transformation(extent={{60,-26},{80,-6}})));
  Modelica.Blocks.Continuous.Integrator integrator2(k=1/Tiq,
    initType=Modelica.Blocks.Types.Init.InitialState,        y_start=-Iq0
         - (-V0 + Vref0)*Kqv)
    annotation (Placement(transformation(extent={{108,-26},{128,-6}})));
  Modelica.Blocks.Sources.RealExpression Vt_filt1(y=VFilter.y)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Nonlinear.Limiter limiter4(uMax=Modelica.Constants.inf, uMin=0.01)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Blocks.Tables.CombiTable1Ds VDLq(table=[(Vq1 + 2*Modelica.Constants.eps),Iq1; (Vq2 + 3*Modelica.Constants.eps),Iq2; (Vq3 + 4*Modelica.Constants.eps),Iq3; (Vq4 + 5*Modelica.Constants.eps),Iq4; (Vq5 + 6*Modelica.Constants.eps),Iq5; (Vq6 + 7*Modelica.Constants.eps),Iq6; (Vq7 + 8*Modelica.Constants.eps),Iq7; (Vq8 + 9*Modelica.Constants.eps),Iq8; (Vq9 + 10*Modelica.Constants.eps),Iq9; (Vq10 + 11*Modelica.Constants.eps),Iq10])
    annotation (Placement(transformation(extent={{64,-80},{84,-60}})));
  Modelica.Blocks.Tables.CombiTable1Ds VDLp(table=[(Vp1 + 2*Modelica.Constants.eps),Ip1; (Vp2 + 3*Modelica.Constants.eps),Ip2; (Vp3 + 4*Modelica.Constants.eps),Ip3; (Vp4 + 5*Modelica.Constants.eps),Ip4; (Vp5 + 6*Modelica.Constants.eps),Ip5; (Vp6 + 7*Modelica.Constants.eps),Ip6; (Vp7 + 8*Modelica.Constants.eps),Ip7; (Vp8 + 9*Modelica.Constants.eps),Ip8; (Vp9 + 10*Modelica.Constants.eps),Ip9; (Vp10 + 11*Modelica.Constants.eps),Ip10])
    annotation (Placement(transformation(extent={{64,-80},{84,-100}})));
  Modelica.Blocks.Continuous.Integrator integrator3(k=1/Tpord, y_start=Ip0*V0)
    annotation (Placement(transformation(extent={{-150,-160},{-130,-140}})));
  Modelica.Blocks.Math.Add add8(k2=-1)
    annotation (Placement(transformation(extent={{-264,-140},{-244,-160}})));
  Modelica.Blocks.Nonlinear.Limiter limiter5(uMax=dPmax, uMin=dPmin)
    annotation (Placement(transformation(extent={{-202,-160},{-182,-140}})));
  Modelica.Blocks.Nonlinear.Limiter limiter6(uMax=Pmax, uMin=Pmin)
    annotation (Placement(transformation(extent={{-102,-160},{-82,-140}})));
  Modelica.Blocks.Math.Product product5
    annotation (Placement(transformation(extent={{-328,-146},{-308,-166}})));
  Modelica.Blocks.Sources.RealExpression GeneratorSpeed(y=if pflag == true
         then Wg else 1)
    annotation (Placement(transformation(extent={{-396,-188},{-376,-208}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{-20,-182},{0,-162}})));
  Modelica.Blocks.Nonlinear.Limiter limiter7(uMax=Modelica.Constants.inf, uMin=0.01)
    annotation (Placement(transformation(extent={{-114,-242},{-94,-222}})));
  Modelica.Blocks.Sources.RealExpression Vt_filt3(y=VFilter.y)
    annotation (Placement(transformation(extent={{-180,-242},{-160,-222}})));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter1
    annotation (Placement(transformation(extent={{60,-182},{80,-162}})));
  Modelica.Blocks.Sources.RealExpression IPMAX(y=CLL_REECD.Ipmax)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={70,-142})));
  Modelica.Blocks.Sources.RealExpression IPMIN(y=CLL_REECD.Ipmin)
    annotation (Placement(transformation(extent={{78,-212},{58,-192}})));
  BaseClasses.CurrentLimitLogicREECD
    CLL_REECD(
    start_ii=Iq0,
    start_ir=Ip0,
    Imax=Imax)
    annotation (Placement(transformation(extent={{100,-96},{132,-64}})));
  Modelica.Blocks.Sources.RealExpression IQCMD(y=Iqcmd)
    annotation (Placement(transformation(extent={{176,-62},{156,-42}})));
  Modelica.Blocks.Sources.BooleanConstant PQFLAG(k=pqflag)
    annotation (Placement(transformation(extent={{176,-70},{156,-90}})));
  Modelica.Blocks.Sources.RealExpression IPCMD(y=Ipcmd)
    annotation (Placement(transformation(extent={{176,-102},{156,-122}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-190,280},{-170,300}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=Iqh1, uMin=Iql1)
    annotation (Placement(transformation(extent={{114,280},{134,300}})));
  Modelica.Blocks.Sources.RealExpression VREF0(y=Vref0)
    annotation (Placement(transformation(extent={{-232,258},{-212,278}})));
  Modelica.Blocks.Nonlinear.DeadZone dbd1_dbd2(uMax=dbd2, uMin=dbd1)
    annotation (Placement(transformation(extent={{-126,280},{-106,300}})));
  Modelica.Blocks.Math.Gain gain2(k=Kqv)
    annotation (Placement(transformation(extent={{-60,280},{-40,300}})));
  OpenIPSL.NonElectrical.Continuous.SimpleLag simpleLag1(
    K=1,
    T=Tp,
    y_start=p00)
    annotation (Placement(transformation(extent={{-362,132},{-342,152}})));
  Modelica.Blocks.Math.Tan tan1
    annotation (Placement(transformation(extent={{-364,126},{-344,106}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-310,126},{-290,146}})));
  Modelica.Blocks.Sources.RealExpression PFAREF(y=pfangle)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-400,116})));

  Modelica.Blocks.Math.Add add3
    annotation (Placement(transformation(extent={{-26,16},{-6,36}})));
  Modelica.Blocks.Sources.RealExpression VBIAS(y=Vmod)
    annotation (Placement(transformation(extent={{-60,22},{-40,42}})));
  BaseClasses.PIwithVariableLimiter pI_No_Windup(
    K_P=Kvp,
    K_I=Kvi,
    y_start=-Iq0 - (-V0 + Vref0)*Kqv)
    annotation (Placement(transformation(extent={{100,94},{140,134}})));
  BaseClasses.PIwithNoVariableLimiter pI_No_Windup_notVariable(
    K_P=Kqp,
    K_I=Kqi,
    V_RMAX=Vmax,
    V_RMIN=Vmin,
    y_start=V0)
    annotation (Placement(transformation(extent={{-102,112},{-82,132}})));
  Modelica.Blocks.Sources.BooleanExpression VLogic(y=Voltage_dip)
    annotation (Placement(transformation(extent={{64,142},{84,162}})));
  NonElectrical.Continuous.SimpleLag VFilter(
    K=1,
    T=Trv,
    y_start=V0)
    annotation (Placement(transformation(extent={{-280,286},{-260,306}})));
  Modelica.Blocks.Logical.Switch Vcmpflag annotation (Placement(transformation(extent={{-268,216},{-248,236}})));
  Modelica.Blocks.Sources.BooleanConstant Vcmpflag_logic(k=vcmpflag) annotation (Placement(transformation(extent={{-362,182},{-342,202}})));
  NonElectrical.Continuous.SimpleLag simpleLag(K=1, T=Tr1,
    y_start=if vcmpflag == true then abs(V0 - (Rc + j*Xc)*I0) else (V0 + (Kc*
        q00)))                                             annotation (Placement(transformation(extent={{-196,216},{-176,236}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Vt + (Kc*Qgen)) annotation (Placement(transformation(extent={{-306,168},{-286,188}})));
  Modelica.Blocks.Math.Add add2 annotation (Placement(transformation(extent={{-60,-166},{-40,-146}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=abs(Vt - (Rc + (j*Xc))
        *It))                                                             annotation (Placement(transformation(extent={{-396,
            248},{-350,274}})));
protected
  parameter Real pfaref=p00/sqrt(p00^2 +q00^2) "Power Factor of choice.";
  parameter OpenIPSL.Types.Angle pfangle = if q00 > 0 then acos(pfaref) else -acos(pfaref);
  parameter OpenIPSL.Types.PerUnit Ip0(fixed=false);
  parameter OpenIPSL.Types.PerUnit Iq0(fixed=false);
  parameter OpenIPSL.Types.PerUnit V0(fixed=false);
  parameter OpenIPSL.Types.PerUnit I0(fixed=false);
  parameter OpenIPSL.Types.PerUnit p00(fixed=false);
  parameter OpenIPSL.Types.PerUnit q00(fixed=false);
  parameter OpenIPSL.Types.PerUnit Vref0 = if vref0 == 0 then V0 else vref0;
  OpenIPSL.Types.PerUnit Vmod;
  //parameter OpenIPSL.Types.PerUnit Y0(fixed=false);
  //parameter OpenIPSL.Types.PerUnit M0(fixed=false);
initial equation

  Ip0 = ip0;
  Iq0 = iq0;
  V0 = v0;
  I0 = i0;
  p00 = p0;
  q00 = q0;
  //Y0 = V0 - (Z*I0);
  //Y0 = V0 - (Rc+j*Xc)* I0;
  //M0 = V0 + (Kc*q00);
equation

  Voltage_dip = if VFilter.y<Vdip or VFilter.y>Vup then true else false;
  Vmod = if pfflag == false and vflag == false and qflag == true then V0 - PfFlag.y else Vbias;

  if baseload == 1 then
  Pmax = p0;
  elseif baseload == 2 then
  Pmax = p0;
  Pmin = p0;
end if;


  connect(VREF0.y,add. u2) annotation (Line(points={{-211,268},{-204,268},{-204,284},{-192,284}},
                           color={0,0,127}));
  connect(dbd1_dbd2.y, gain2.u)
    annotation (Line(points={{-105,290},{-62,290}},  color={0,0,127}));
  connect(add.y, dbd1_dbd2.u)
    annotation (Line(points={{-169,290},{-128,290}}, color={0,0,127}));
  connect(gain2.y,limiter. u)
    annotation (Line(points={{-39,290},{112,290}},
                                                 color={0,0,127}));
  connect(simpleLag1.y, product1.u1)
    annotation (Line(points={{-341,142},{-312,142}}, color={0,0,127}));
  connect(tan1.y, product1.u2) annotation (Line(points={{-343,116},{-320,116},{-320,130},{-312,130}},
                            color={0,0,127}));
  connect(Pe, simpleLag1.u)
    annotation (Line(points={{-460,142},{-364,142}}, color={0,0,127}));
  connect(PFAREF.y, tan1.u)
    annotation (Line(points={{-389,116},{-366,116}},
                                                   color={0,0,127}));
  connect(product1.y, PfFlag.u1)
    annotation (Line(points={{-289,136},{-260,136}}, color={0,0,127}));
  connect(PfFlag_logic.y, PfFlag.u2) annotation (Line(points={{-343,76},{-280,76},{-280,128},{-260,128}},
                                  color={255,0,255}));
  connect(PfFlag.y, limiter1.u)
    annotation (Line(points={{-237,128},{-196,128}}, color={0,0,127}));
  connect(limiter1.y, add1.u1)
    annotation (Line(points={{-173,128},{-148,128}}, color={0,0,127}));
  connect(Vflag_logic.y, VFlag.u2) annotation (Line(points={{-103,90},{-48,90},{-48,114},{-38,114}},
                         color={255,0,255}));
  connect(limiter3.y,add4. u1) annotation (Line(points={{27,114},{27,120},{54,120}},
                     color={0,0,127}));
  connect(VFlag.y, limiter3.u)
    annotation (Line(points={{-15,114},{4,114}}, color={0,0,127}));
  connect(QFLAG.y, QFlag.u2) annotation (Line(points={{61,52},{152,52},{152,62},{162,62}},
                                       color={255,0,255}));
  connect(add6.y, variableLimiter.u)
    annotation (Line(points={{205,114},{220,114},{220,86},{232,86}},
                                                 color={0,0,127}));
  connect(IQMIN.y, variableLimiter.limit2) annotation (Line(points={{227,32},{220,32},{220,78},{232,78}},
                                  color={0,0,127}));
  connect(IQMAX.y, variableLimiter.limit1) annotation (Line(points={{225,146},{216,146},{216,120},{232,120},{232,94}},
                                   color={0,0,127}));
  connect(QFlag.y, add6.u2) annotation (Line(points={{185,62},{192,62},{192,96},{176,96},{176,108},{182,108}},
                     color={0,0,127}));
  connect(Vt_filt1.y, limiter4.u)
    annotation (Line(points={{-39,-30},{-22,-30}}, color={0,0,127}));
  connect(limiter4.y, division.u2) annotation (Line(points={{1,-30},{8,-30},{8,-16},
          {18,-16}}, color={0,0,127}));
  connect(division.y, add7.u1)
    annotation (Line(points={{41,-10},{58,-10}}, color={0,0,127}));
  connect(integrator2.y, QFlag.u3) annotation (Line(points={{129,-16},{162,-16},{162,54}},
                              color={0,0,127}));
  connect(add7.u2, QFlag.u3) annotation (Line(points={{58,-22},{52,-22},{52,-36},{162,-36},{162,54}},
                                        color={0,0,127}));
  connect(VDLp.u, limiter4.u) annotation (Line(points={{62,-90},{-28,-90},{-28,-30},
          {-22,-30}},                        color={0,0,127}));
  connect(VDLq.u, limiter4.u) annotation (Line(points={{62,-70},{-28,-70},{-28,-30},
          {-22,-30}},                   color={0,0,127}));
  connect(add8.y,limiter5. u)
    annotation (Line(points={{-243,-150},{-204,-150}},
                                                     color={0,0,127}));
  connect(integrator3.y,add8. u2) annotation (Line(points={{-129,-150},{-124,-150},{-124,-128},{-280,-128},{-280,-144},{-266,-144}},
                                                        color={0,0,127}));
  connect(integrator3.y,limiter6. u)
    annotation (Line(points={{-129,-150},{-104,-150}},
                                                   color={0,0,127}));
  connect(GeneratorSpeed.y, product5.u1) annotation (Line(points={{-375,-198},{-375,-200},{-344,-200},{-344,-162},{-330,-162}},
                                          color={0,0,127}));
  connect(limiter7.y, division1.u2) annotation (Line(points={{-93,-232},{-32,-232},{-32,-178},{-22,-178}},
                                  color={0,0,127}));
  connect(Vt_filt3.y, limiter7.u)
    annotation (Line(points={{-159,-232},{-116,-232}},
                                                     color={0,0,127}));
  connect(division1.y, variableLimiter1.u)
    annotation (Line(points={{1,-172},{58,-172}}, color={0,0,127}));
  connect(IPMIN.y, variableLimiter1.limit2) annotation (Line(points={{57,-202},{
          40,-202},{40,-180},{58,-180}}, color={0,0,127}));
  connect(IPMAX.y, variableLimiter1.limit1) annotation (Line(points={{59,-142},{
          40,-142},{40,-164},{58,-164}}, color={0,0,127}));
  connect(PQFLAG.y,CLL_REECD. pqflag)
    annotation (Line(points={{155,-80},{135.2,-80}}, color={255,0,255}));
  connect(IQCMD.y,CLL_REECD.Iqcmd)  annotation (Line(points={{155,-52},{140,-52},
          {140,-70.4},{135.2,-70.4}}, color={0,0,127}));
  connect(IPCMD.y,CLL_REECD.Ipcmd)  annotation (Line(points={{155,-112},{140,
          -112},{140,-89.6},{135.2,-89.6}},
                                      color={0,0,127}));
  connect(variableLimiter1.y, Ipcmd) annotation (Line(points={{81,-172},{260,-172},
          {260,-150},{310,-150}},
                                color={0,0,127}));
  connect(add3.y, VFlag.u3) annotation (Line(points={{-5,26},{0,26},{0,96},{-44,96},{-44,106},{-38,106}},
        color={0,0,127}));
  connect(VBIAS.y, add3.u1)
    annotation (Line(points={{-39,32},{-28,32}}, color={0,0,127}));
  connect(add7.y, integrator2.u) annotation (Line(points={{81,-16},{106,-16}},
                           color={0,0,127}));
  connect(limiter5.y, integrator3.u)
    annotation (Line(points={{-181,-150},{-152,-150}}, color={0,0,127}));
  connect(product5.y, add8.u1)
    annotation (Line(points={{-307,-156},{-266,-156}}, color={0,0,127}));
  connect(product5.u2, Pref) annotation (Line(points={{-330,-150},{-396,-150},{-396,-78},{-460,-78}},
                                    color={0,0,127}));
  connect(add4.y, pI_No_Windup.u)
    annotation (Line(points={{77,114},{92,114},{92,102},{96,102}},
                                                 color={0,0,127}));
  connect(IQMAX_.y, pI_No_Windup.limit1) annotation (Line(points={{89,184},{80,184},{80,204},{133.6,204},{133.6,138}},
                                                   color={0,0,127}));
  connect(IQMIN_.y, pI_No_Windup.limit2) annotation (Line(points={{81,76},{72,76},{72,60},{133.6,60},{133.6,90}},
                                               color={0,0,127}));
  connect(pI_No_Windup.y, QFlag.u1)
    annotation (Line(points={{142,114},{152,114},{152,70},{162,70}},
                                                            color={0,0,127}));
  connect(add1.y, pI_No_Windup_notVariable.u)
    annotation (Line(points={{-125,122},{-116,122},{-116,116},{-104,116}},
                                                    color={0,0,127}));
  connect(pI_No_Windup_notVariable.y, VFlag.u1) annotation (Line(points={{-81,122},{-38,122}},
                                      color={0,0,127}));
  connect(VLogic.y, pI_No_Windup.voltage_dip)
    annotation (Line(points={{85,152},{96,152},{96,126}}, color={255,0,255}));
  connect(pI_No_Windup_notVariable.voltage_dip, pI_No_Windup.voltage_dip)
    annotation (Line(points={{-104,128},{-112,128},{-112,172},{96,172},{96,126}},
        color={255,0,255}));
  connect(VFilter.y, add.u1)
    annotation (Line(points={{-259,296},{-192,296}}, color={0,0,127}));
  connect(VFilter.u, Vt) annotation (Line(points={{-282,296},{-428,296},{-428,298},{-460,298}},
                       color={0,0,127}));
  connect(Vcmpflag_logic.y, Vcmpflag.u2) annotation (Line(points={{-341,192},{-316,192},{-316,226},{-270,226}},
                                                                                          color={255,0,255}));
  connect(Vcmpflag.y, simpleLag.u) annotation (Line(points={{-247,226},{-198,226}}, color={0,0,127}));
  connect(realExpression.y, Vcmpflag.u3) annotation (Line(points={{-285,178},{-272,178},{-272,208},{-280,208},{-280,218},{-270,218}},
                                                                                                                color={0,0,127}));
  connect(simpleLag.y, add4.u2) annotation (Line(points={{-175,226},{48,226},{48,108},{54,108}},          color={0,0,127}));
  connect(limiter.y, add6.u1) annotation (Line(points={{135,290},{172,290},{172,120},{182,120}},
                                                                                               color={0,0,127}));
  connect(PfFlag.u3, Qext) annotation (Line(points={{-260,120},{-276,120},{-276,-2},{-460,-2}},   color={0,0,127}));
  connect(limiter6.y, add2.u1) annotation (Line(points={{-81,-150},{-62,-150}}, color={0,0,127}));
  connect(add2.y, division1.u1) annotation (Line(points={{-39,-156},{-32,-156},{-32,-166},{-22,-166}}, color={0,0,127}));
  connect(VDLq.y[1], CLL_REECD.VDLq_out) annotation (Line(points={{85,-70},{85,-70.4},{96.8,-70.4}}, color={0,0,127}));
  connect(VDLp.y[1], CLL_REECD.VDLp_out) annotation (Line(points={{85,-90},{90.9,-90},{90.9,-89.6},{96.8,-89.6}}, color={0,0,127}));
  connect(Paux, add2.u2) annotation (Line(points={{-460,-238},{-226,-238},{-226,-192},{-72,-192},{-72,-162},{-62,-162}}, color={0,0,127}));
  connect(variableLimiter.y, Iqcmd) annotation (Line(points={{255,86},{274,86},{274,150},{310,150}}, color={0,0,127}));
  connect(Qgen, add1.u2) annotation (Line(points={{-460,68},{-406,68},{-406,38},{-162,38},{-162,116},{-148,116}}, color={0,0,127}));
  connect(division.u1, add1.u1) annotation (Line(points={{18,-4},{-166,-4},{-166,128},{-148,128}}, color={0,0,127}));
  connect(add3.u2, add1.u1) annotation (Line(points={{-28,20},{-98,20},{-98,24},{-166,24},{-166,128},{-148,128}}, color={0,0,127}));
  connect(realExpression1.y, Vcmpflag.u1) annotation (Line(points={{-347.7,261},
          {-270,261},{-270,234}}, color={0,0,127}));
end REECDU1;
