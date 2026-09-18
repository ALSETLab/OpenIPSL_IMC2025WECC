within OpenIPSL.Electrical.Renewables.PSSE.InverterInterface.BaseClasses;
model Thevenin

  Modelica.Blocks.Interfaces.RealInput Iqneg
  annotation (Placement(transformation(extent={{-140,42},{-100,82}}), iconTransformation(extent={{-140,48},{-100,88}})));
  Modelica.Blocks.Interfaces.RealInput Ip
  annotation (Placement(transformation(extent={{-140,-20},{-100,20}}), iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput V
  annotation (Placement(transformation(extent={{-140,-86},{-100,-46}}), iconTransformation(extent={{-140,-92},{-100,-52}})));
  Modelica.Blocks.Interfaces.RealOutput Eqcalc
   annotation (Placement(transformation(extent={{100,26},{136,62}}), iconTransformation(extent={{100,28},{136,64}})));
  Modelica.Blocks.Interfaces.RealOutput Edcalc
   annotation (Placement(transformation(extent={{100,-50},{136,-14}}), iconTransformation(extent={{100,-54},{136,-18}})));

  parameter Types.PerUnit Re=0 "Generator Effective Resistance(0-0.01 pu)";
  parameter Types.PerUnit Xe=0.5 "Generator Effective Reactance(0.05-0.2 pu)";
equation
 Eqcalc = 0 + (Iqneg*Re) + (Ip*Xe);
 Edcalc = V + (Ip*Re) - (Iqneg*Xe);
  annotation (Icon(graphics={Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}), Text(
          extent={{-68,38},{66,-30}},
          textColor={28,108,200},
          textString="%name",
          textStyle={TextStyle.Bold})}));
end Thevenin;
