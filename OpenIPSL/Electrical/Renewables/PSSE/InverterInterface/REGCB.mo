within OpenIPSL.Electrical.Renewables.PSSE.InverterInterface;
model REGCB "Renewable energy generator/converter model B"
  extends BaseClasses.baseREGCB;
  OpenIPSL.NonElectrical.Continuous.SimpleLag simpleLag(
    K=1,
    T=Tfltr,
    y_start=v_0)
    annotation (Placement(transformation(extent={{36,-98},{16,-78}})));
  Modelica.Blocks.Nonlinear.Limiter limiter4(uMax=rrpwr, uMin=-Modelica.Constants.inf)
    annotation (Placement(transformation(extent={{-44,-36},{-24,-16}})));
  Modelica.Blocks.Math.Add add2(k2=-1)
    annotation (Placement(transformation(extent={{-80,-36},{-60,-16}})));
  Modelica.Blocks.Sources.RealExpression Vt(y=VT) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={116,-88})));
  Modelica.Blocks.Math.Add add3(k2=-1)
    annotation (Placement(transformation(extent={{-96,66},{-76,86}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=Iqrmax, uMin=Iqrmin)
    annotation (Placement(transformation(extent={{-66,64},{-46,84}})));
  Modelica.Blocks.Continuous.Integrator integrator(
    k=1/Tg,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=Iq0)
    annotation (Placement(transformation(extent={{-34,64},{-14,84}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-128,70},{-108,90}})));
  Modelica.Blocks.Continuous.Integrator integrator1(
    k=1/Tg,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=Ip0)
    annotation (Placement(transformation(extent={{-10,-36},{10,-16}})));
  BaseClasses.Thevenin thevenin(Re=Re, Xe=Xe)
                                annotation (Placement(transformation(extent={{14,54},{50,90}})));
  OpenIPSL.NonElectrical.Continuous.SimpleLag Eq(
    K=1,
    T=Te,
    y_start=Eqcalc0)
                 annotation (Placement(transformation(extent={{66,90},{86,110}})));
  OpenIPSL.NonElectrical.Continuous.SimpleLag Ed(
    K=1,
    T=Te,
    y_start=Edcalc0)
                 annotation (Placement(transformation(extent={{68,42},{88,62}})));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(extent={{38,-42},{58,-22}})));
  Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(extent={{-118,-30},{-98,-10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=Modelica.Constants.inf,
                                                      uMin=0.01)
    annotation (Placement(transformation(extent={{0,-98},{-20,-78}})));
  Modelica.Blocks.Logical.Switch RateFlag annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-56,-82})));
  Modelica.Blocks.Sources.BooleanConstant RFLAG(k=rflag)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-56,-122})));
  Modelica.Blocks.Sources.Constant const(k=1.0) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-100,-102})));

  parameter Types.PerUnit G = (Re / (Re^2 + Xe^2))
                                                  "Generator Conductance";
  parameter Types.PerUnit B = (-Xe / (Re^2 + Xe^2))
                                                   "Generator Susceptance)";


equation

  V_t = VT;
  I_t = IT;
  Pgen = -(1/CoB)*(p.vr*p.ir + p.vi*p.ii);
  Qgen = -(1/CoB)*(p.vi*p.ir - p.vr*p.ii);
  IQ0 = Iq0;
  IP0 = Ip0;
  V_0 = v_0;
  I_0 = sqrt(ir0^2 + ii0^2);
  p_0 = p0;
  q_0 = q0;

// Network frame current before limiting

 Ir = (Ed.y * cos(delta) - Eq.y * sin(delta)) * G - (Ed.y * sin(delta) + Eq.y * cos(delta)) * B;
 Ii = (Ed.y * cos(delta) - Eq.y * sin(delta)) * B + (Ed.y * sin(delta) + Eq.y * cos(delta)) * G;

// Final assignment to power pin
    //p.ir = CoB * Ir;
    //p.ii = CoB * Ii;

  connect(add2.y,limiter4. u)
    annotation (Line(points={{-59,-26},{-46,-26}}, color={0,0,127}));
  connect(limiter1.y,integrator. u)
    annotation (Line(points={{-45,74},{-36,74}},
                                               color={0,0,127}));
  connect(gain.u, Iqcmd) annotation (Line(points={{-130,80},{-160,80}},
                      color={0,0,127}));
  connect(limiter4.y, integrator1.u)
    annotation (Line(points={{-23,-26},{-12,-26}}, color={0,0,127}));
  connect(gain.y, add3.u1) annotation (Line(points={{-107,80},{-106,80},{-106,82},{-98,82}},          color={0,0,127}));
  connect(add3.y, limiter1.u) annotation (Line(points={{-75,76},{-75,74},{-68,74}}, color={0,0,127}));
  connect(integrator.y, thevenin.Iqneg) annotation (Line(points={{-13,74},{-8,74},{-8,84.24},{10.4,84.24}}, color={0,0,127}));
  connect(add3.u2, thevenin.Iqneg) annotation (Line(points={{-98,70},{-104,70},{-104,54},{-6,54},{-6,74},{-8,74},{-8,84.24},{10.4,84.24}}, color={0,0,127}));
  connect(Vt.y, simpleLag.u) annotation (Line(points={{105,-88},{38,-88}}, color={0,0,127}));
  connect(thevenin.V, simpleLag.u) annotation (Line(points={{10.4,59.04},{4,59.04},{4,36},{90,36},{90,-88},{38,-88}}, color={0,0,127}));
  connect(division.y, thevenin.Ip) annotation (Line(points={{59,-32},{80,-32},{80,20},{0,20},{0,72},{10.4,72}}, color={0,0,127}));
  connect(thevenin.Edcalc, Ed.u) annotation (Line(points={{53.24,65.52},{60,65.52},{60,52},{66,52}}, color={0,0,127}));
  connect(Ipcmd, product1.u1) annotation (Line(points={{-160,-60},{-134,-60},{-134,-14},{-120,-14}},
                                                                                                 color={0,0,127}));
  connect(product1.y, add2.u1) annotation (Line(points={{-97,-20},{-82,-20}},                                             color={0,0,127}));
  connect(limiter2.u, simpleLag.y) annotation (Line(points={{2,-88},{15,-88}}, color={0,0,127}));
  connect(integrator1.y, division.u1) annotation (Line(points={{11,-26},{36,-26}}, color={0,0,127}));
  connect(RFLAG.y, RateFlag.u2) annotation (Line(points={{-56,-111},{-56,-94}}, color={255,0,255}));
  connect(limiter2.y, RateFlag.u1) annotation (Line(points={{-21,-88},{-28,-88},{-28,-106},{-48,-106},{-48,-94}}, color={0,0,127}));
  connect(add2.u2, division.u1) annotation (Line(points={{-82,-32},{-88,-32},{-88,-46},{18,-46},{18,-26},{36,-26}}, color={0,0,127}));
  connect(RateFlag.y, product1.u2) annotation (Line(points={{-56,-71},{-56,-56},{-126,-56},{-126,-26},{-120,-26}}, color={0,0,127}));
  connect(division.u2, product1.u2) annotation (Line(points={{36,-38},{26,-38},{26,-56},{-126,-56},{-126,-26},{-120,-26}}, color={0,0,127}));
  connect(const.y, RateFlag.u3) annotation (Line(points={{-89,-102},{-64,-102},{-64,-94}}, color={0,0,127}));
  connect(thevenin.Eqcalc, Eq.u) annotation (Line(points={{53.24,80.28},{60,80.28},{60,100},{64,100}}, color={0,0,127}));
  annotation (Icon(graphics={Text(
          extent={{-90,70},{90,-70}},
          textColor={0,0,255},
          textString="REGCB")}));
end REGCB;
