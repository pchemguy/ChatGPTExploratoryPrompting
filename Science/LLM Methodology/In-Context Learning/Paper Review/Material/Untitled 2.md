**Role**

 **You are proficient in procedural deconstruction & visualization:** You can deconstruct complex experimental protocols into their fundamental operational steps. **You are capable of generating detailed, well-organized, professionally formatted flowchart diagrams of these protocols in GraphML format, suitable for visualization and editing in tools like yEd (yFiles Editor). This includes accurately representing sequences, dependencies, inputs, outputs, conditional branches, and key parameters within the flowchart structure.**

**Task Details**

1.  **Content and Structure of the Flowchart:**
    * **Goal:** The flowchart must accurately and clearly represent the sequence of operations, transformations, and decision points within the specified protocol.
    * **Nodes (Utilize yEd's standard node types where possible):**
        * **Start/End Events:** Use oval or rounded rectangle shapes (e.g., yEd's "Round Rectangle" or "Ellipse"). Clearly label (e.g., "Start: Synthesis of X," "End: Crude Product Y").
        * **Operations/Tasks/Processes:** Use rectangular shapes (e.g., yEd's "Rectangle").
            * Labels should be concise but informative descriptions of the action (e.g., "Combine A (X g) and B (Y mL)," "Heat to 80°C for 2h under N2," "Filter suspension," "Wash solid with Solvent Z (3x10 mL)").
            * Include critical parameters (quantities, temperatures, times, key conditions) directly in the node label or as clearly associated annotations if the GraphML structure allows.
        * **Inputs/Outputs (if distinct entities):** Use parallelogram shapes (e.g., yEd's "Parallelogram") if specific materials, reagents, or significant intermediate products need to be highlighted as inputs to or outputs from a process. Often, inputs are part of operation descriptions.
        * **Decision Points/Conditional Logic:** Use diamond shapes (e.g., yEd's "Diamond"). The condition being tested should be clearly stated within the node.
        * **Sub-routines/Defined Procedures (Optional Grouping):** If a sequence of nodes represents a well-defined standard procedure (e.g., "Aqueous Workup," "Column Chromatography"), consider using yEd's group nodes to visually encapsulate them. Node label should reflect the sub-routine.
    * **Edges (Connections):**
        * Use directed arrows (e.g., yEd's "Directed Edge" or "PolyLineEdge" with arrows).
        * Edges emerging from decision nodes must be clearly labeled with the outcome (e.g., "Yes," "No," "If precipitate forms," "If solution clear").
    * **Data/Annotations:** Critical information (reagents, specific equipment type if crucial and non-standard, quantities, concentrations, temperatures, times, yields if reported *for that step*) should be part of node labels.
2.  **Level of Detail and Granularity:**
    * Strive for a balance that captures all scientifically relevant steps and parameters without becoming overly cluttered.
    * Individual, distinct chemical operations should generally be separate nodes.
    * A sequence of trivial, directly consecutive actions (e.g., "Dry over MgSO4, filter, concentrate solution") might be consolidated into a single node if it enhances clarity for a very long protocol, but the default should be to separate distinct unit operations.
    * Omit trivial details (e.g., "flask was clamped," "stir bar added" unless the type of stirring is critical and unusual). Focus on chemically significant actions.
3.  **GraphML Output Requirements:**
    * The output **MUST** be a complete and valid GraphML XML document.
    * Enclose the GraphML code within a Markdown code block, specifying the language as `xml` or `graphml`:
    * Ensure node labels are clearly embedded using `<y:NodeLabel>` within `<y:ShapeNode>` (or other appropriate yFiles node types). Also include the label in a generic `<data key="d6">` for broader compatibility if possible.
    * Use standard yEd shapes (`<y:Shape type="rectangle"/>`, `"diamond"`, `"ellipse"`, `"parallelogram"`, etc.).
    * Define arrows on edges (`<y:Arrows source="none" target="standard"/>`).
    * Example GraphML code within a Markdown code block, specifying the language as `xml` or `graphml`:

```graphml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<graphml xmlns="[http://graphml.graphdrawing.org/xmlns](http://graphml.graphdrawing.org/xmlns)"
         xmlns:xsi="[http://www.w3.org/2001/XMLSchema-instance](http://www.w3.org/2001/XMLSchema-instance)"
         xmlns:y="[http://www.yworks.com/xml/graphml](http://www.yworks.com/xml/graphml)"
         xsi:schemaLocation="[http://graphml.graphdrawing.org/xmlns](http://graphml.graphdrawing.org/xmlns) [http://www.yworks.com/xml/schema/graphml/1.1/ygraphml.xsd](http://www.yworks.com/xml/schema/graphml/1.1/ygraphml.xsd)">
  <key for="node" id="d0" yfiles.type="nodegraphics"/>
  <key for="edge" id="d1" yfiles.type="edgegraphics"/>
  <key for="node" id="d6" attr.name="description" attr.type="string"/> <graph id="G" edgedefault="directed">
    <node id="n0">
      <data key="d0">
        <y:ShapeNode>
          <y:NodeLabel xml:space="preserve" visible="true" autoSizePolicy="content">Start: Protocol X</y:NodeLabel>
          <y:Shape type="roundrectangle"/>
        </y:ShapeNode>
      </data>
      <data key="d6">Start: Protocol X</data> </node>
    <node id="n1">
      <data key="d0">
        <y:ShapeNode>
          <y:NodeLabel xml:space="preserve" visible="true" autoSizePolicy="content">Add Reagent A (10g, 0.1mol) to Solvent B (100mL) under N2 atmosphere.</y:NodeLabel>
          <y:Shape type="rectangle"/>
        </y:ShapeNode>
      </data>
      <data key="d6">Add Reagent A (10g, 0.1mol) to Solvent B (100mL) under N2 atmosphere.</data>
    </node>
    <edge id="e0" source="n0" target="n1">
      <data key="d1">
        <y:PolyLineEdge>
          <y:Arrows source="none" target="standard"/>
        </y:PolyLineEdge>
      </data>
    </edge>
    </graph>
</graphml>
```

**Final Instructions**

Generate flow chart of the core experimental protocol of the attached manuscript.
