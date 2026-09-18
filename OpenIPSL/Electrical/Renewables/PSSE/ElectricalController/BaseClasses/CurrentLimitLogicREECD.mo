within OpenIPSL.Electrical.Renewables.PSSE.ElectricalController.BaseClasses;
model CurrentLimitLogicREECD "Current limit logic for REECD"

  parameter OpenIPSL.Types.PerUnit start_ii;
  parameter OpenIPSL.Types.PerUnit start_ir;
  parameter Real Imax=1.0;
  parameter Real Ke=0;
 // parameter OpenIPSL.Types.PerUnit Vblkl "Voltage below which the converter is blocked";
 // parameter OpenIPSL.Types.PerUnit Vblkh "Voltage above which the converter is blocked";
 // parameter OpenIPSL.Types.Time Tblk_delay "Time delay after the blocking of the converter (0.04-0.1s)";
  //parameter Real Vt_filt1; // filtered terminal voltage

  //OpenIPSL.Types.PerUnit post_local_I;
  //OpenIPSL.Types.PerUnit local_I;

  Modelica.Blocks.Interfaces.RealInput VDLq_out annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,60}), iconTransformation(extent={{-140,80},{-100,40}})));
  Modelica.Blocks.Interfaces.BooleanInput pqflag annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,0}), iconTransformation(
        extent={{0,0},{40,40}},
        rotation=180,
        origin={140,20})));
  Modelica.Blocks.Interfaces.RealInput VDLp_out annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-60}), iconTransformation(extent={{-140,-40},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput Iqcmd annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,60}), iconTransformation(
        extent={{-13.3335,-13.3336},{26.6673,26.6664}},
        rotation=180,
        origin={126.667,66.6664})));
  Modelica.Blocks.Interfaces.RealInput Ipcmd annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-60}), iconTransformation(
        extent={{-3.63659,79.9998},{36.3659,39.9999}},
        rotation=180,
        origin={136.363,-0.0002})));
  Modelica.Blocks.Interfaces.RealOutput Iqmax annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,110})));
  Modelica.Blocks.Interfaces.RealOutput Iqmin annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,110})));
  Modelica.Blocks.Interfaces.RealOutput Ipmax annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-110})));
  Modelica.Blocks.Interfaces.RealOutput Ipmin annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-110})));

/*
  // Internal variables
  parameter Boolean inBlockingMode;
  parameter Boolean wasInBlockingMode;
  parameter Real timeEnteredBlockingMode;
  parameter Real timeExitedBlockingMode;

initial algorithm 
  inBlockingMode := false;
  wasInBlockingMode := false;
  timeEnteredBlockingMode := 0;
  timeExitedBlockingMode := 0;
  Iqmax := 0;
  Iqmin := 0;
  Ipmax := 0;
  Ipmin := 0;
  Ipcmd := 0;
  Iqcmd := 0;

equation 
  // Check for blocking condition
algorithm 
  if Vt_filt1 < Vblkl or Vt_filt1 > Vblkh then
    inBlockingMode := true;
    timeEnteredBlockingMode := time;
    Iqmax := 0;
    Iqmin := 0;
    Ipmax := 0;
    Ipmin := 0;
    Ipcmd := 0;
    Iqcmd := 0;
  elseif inBlockingMode and (Vblkl <= Vt_filt1 and Vt_filt1 <= Vblkh) then
    inBlockingMode := false;
    timeExitedBlockingMode := time;
  end if;

  // Delay logic after exiting blocking mode
  if wasInBlockingMode and (time - timeExitedBlockingMode > Tblk_delay) then
    Iqmax := 0; // Set to your system's specific current limit
    Iqmin := 0; // Set to your system's specific current limit
    Ipmax := 0; // Set to your system's specific current limit
    Ipmin := 0; // Set to your system's specific current limit
    wasInBlockingMode := false;
  elseif not inBlockingMode and not wasInBlockingMode then
    // Set the current limits to normal operational values
    Iqmax := 0; // Set to your system's specific current limit
    Iqmin := 0; // Set to your system's specific current limit
    Ipmax := 0; // Set to your system's specific current limit
    Ipmin := 0; // Set to your system's specific current limit
  end if;

  // Record that we were in blocking mode for logic processing
  if inBlockingMode then
    wasInBlockingMode := true;
  end if;
  */

equation

  //Iqmax = if vblkl<=VFilter

  Iqmax = if pqflag == false then min(VDLq_out, Imax) else min(VDLq_out, sqrt(Imax^2 - Ipcmd^2));
  Iqmin = if Iqmax < 0 then Iqmax else -Iqmax;
  Ipmax = if pqflag == false then min(VDLp_out, sqrt(Imax^2 - Iqcmd^2)) else min(VDLp_out, Imax);
  Ipmin = -Ke*Ipmax;

  annotation (Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.None),  Text(
          extent={{-60,40},{60,-40}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          textString="CLL REECA(C)"),     Text(
          extent={{52,80},{92,40}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          textString="IQCMD"),            Text(
          extent={{52,-40},{92,-80}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          textString="IPCMD"),            Text(
          extent={{-90,80},{-50,40}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          textString="VDL1"),             Text(
          extent={{-90,-40},{-50,-80}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          textString="VDL2"),             Text(
          extent={{-68,98},{-28,58}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          textString="IQMIN"),            Text(
          extent={{52,98},{92,58}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid,
          textString="IQMAX")}));
end CurrentLimitLogicREECD;
