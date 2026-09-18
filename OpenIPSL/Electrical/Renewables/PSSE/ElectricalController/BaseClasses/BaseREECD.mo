within OpenIPSL.Electrical.Renewables.PSSE.ElectricalController.BaseClasses;
partial model BaseREECD "Base renewable energy electrical controller model A"

  parameter Boolean pfflag=true "Constant output value" annotation (Dialog(tab="Control"));
  parameter Boolean vflag=true "Constant output value" annotation (Dialog(tab="Control"));
  parameter Boolean qflag=true "Constant output value" annotation (Dialog(tab="Control"));
  parameter Boolean pqflag=true "Constant output value" annotation (Dialog(tab="Control"));
  parameter Boolean pflag=false "Constant output value" annotation (Dialog(tab="Control"));
  parameter Boolean vcmpflag=false "Constant output value" annotation (Dialog(tab="Control"));

  Modelica.Blocks.Interfaces.RealInput Vt
    annotation (Placement(transformation(extent={{-480,278},{-440,318}}),
        iconTransformation(extent={{-480,284},{-440,324}})));
  Modelica.Blocks.Interfaces.RealInput Pe
    annotation (Placement(transformation(extent={{-480,122},{-440,162}}),
        iconTransformation(extent={{-480,122},{-440,162}})));
  Modelica.Blocks.Interfaces.RealInput Qext
    "Connector of second Real input signal"
    annotation (Placement(transformation(extent={{-480,-22},{-440,18}}),
        iconTransformation(extent={{-480,-42},{-440,-2}})));
  Modelica.Blocks.Interfaces.RealInput Qgen "Connector of Real input signal 2"
    annotation (Placement(transformation(extent={{-480,48},{-440,88}}),
        iconTransformation(extent={{-480,38},{-440,78}})));
  Modelica.Blocks.Interfaces.RealInput Pref annotation (Placement(
        transformation(extent={{-480,-98},{-440,-58}}),
        iconTransformation(extent={{-480,-120},{-440,-80}})));
  Modelica.Blocks.Interfaces.RealInput ip0 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={120,-320}),  iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={120,-320})));
  Modelica.Blocks.Interfaces.RealInput iq0 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={230,-320}),  iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={230,-320})));
  Modelica.Blocks.Interfaces.RealOutput Iqcmd
    annotation (Placement(transformation(extent={{300,140},{320,160}}),
        iconTransformation(extent={{300,140},{320,160}})));
  Modelica.Blocks.Interfaces.RealOutput Ipcmd
    annotation (Placement(transformation(extent={{300,-160},{320,-140}}),
        iconTransformation(extent={{300,-162},{320,-142}})));
  Modelica.Blocks.Interfaces.RealInput Wg annotation (Placement(
        transformation(extent={{-480,-176},{-440,-136}}), iconTransformation(
          extent={{-480,-196},{-440,-156}})));

  Modelica.Blocks.Interfaces.RealInput v0 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-320}),
                          iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-320})));
  Modelica.Blocks.Interfaces.RealInput p0 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-332,-320}),iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-230,-320})));
  Modelica.Blocks.Interfaces.RealInput q0 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-180,-320}),iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-120,-320})));
  Modelica.Blocks.Interfaces.RealInput It annotation (Placement(transformation(extent={{-480,198},{-440,238}}), iconTransformation(extent={{-480,206},{-440,246}})));
  Modelica.Blocks.Interfaces.RealInput Paux annotation (Placement(transformation(extent={{-480,-258},{-440,-218}}), iconTransformation(extent={{-480,-266},{-440,-226}})));

  Modelica.Blocks.Interfaces.RealInput i0 annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={42,-320}),iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-318})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-440,-300},{300,340}}),
                         graphics={Rectangle(extent={{-440,340},{300,-300}},
            lineColor={0,0,255}),
        Text(
          extent={{-422,322},{-362,282}},
          textColor={0,0,255},
          textString="VT"),
        Text(
          extent={{-424,158},{-312,118}},
          textColor={0,0,255},
          textString="PGEN"),
        Text(
          extent={{-426,76},{-314,36}},
          textColor={0,0,255},
          textString="QGEN"),
        Text(
          extent={{-430,-2},{-318,-42}},
          textColor={0,0,255},
          textString="QEXT"),
        Text(
          extent={{-428,-82},{-316,-122}},
          textColor={0,0,255},
          textString="PREF"),
        Text(
          extent={{-412,-154},{-352,-194}},
          textColor={0,0,255},
          textString="WG"),
        Text(
          extent={{-260,-254},{-200,-294}},
          textColor={0,0,255},
          textString="P0"),
        Text(
          extent={{-150,-254},{-90,-294}},
          textColor={0,0,255},
          textString="Q0"),
        Text(
          extent={{-30,-254},{30,-294}},
          textColor={0,0,255},
          textString="V0"),
        Text(
          extent={{90,-254},{150,-294}},
          textColor={0,0,255},
          textString="IP0"),
        Text(
          extent={{204,-254},{264,-294}},
          textColor={0,0,255},
          textString="IQ0"),
        Text(
          extent={{-262,112},{150,-84}},
          textColor={0,0,255},
          textString="REECDU1"),
        Text(
          extent={{178,168},{290,128}},
          textColor={0,0,255},
          textString="IQCMD"),
        Text(
          extent={{178,-132},{290,-172}},
          textColor={0,0,255},
          textString="IPCMD"),
        Text(
          extent={{-342,-268},{-422,-220}},
          textColor={0,0,255},
          textString="Paux"),
        Text(
          extent={{-422,242},{-362,202}},
          textColor={0,0,255},
          textString="IT"),
        Text(
          extent={{162,18},{274,-22}},
          textColor={0,0,255},
          textString="Pord"),
        Text(
          extent={{36,-252},{96,-292}},
          textColor={0,0,255},
          textString="I0")}),          Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-440,-300},{300,340}})));

end BaseREECD;
