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
    * Enclose the GraphML code within a Markdown code block, specifying the language as `xml`.
    * Ensure node labels are clearly embedded using `<y:NodeLabel>` within `<y:ShapeNode>` (or other appropriate yFiles node types). Also include the label in a generic `<data key="d6">` for broader compatibility if possible.
    * Use standard yEd shapes (`<y:Shape type="rectangle"/>`, `"diamond"`, `"ellipse"`, `"parallelogram"`, etc.).
    * Define arrows on edges (`<y:Arrows source="none" target="standard"/>`).

**Final Instructions**

Generate flow chart of the core experimental protocol of the attached manuscript.

