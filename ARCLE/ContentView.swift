import SwiftUI
import RealityKit
import ARKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black // Set background color to solid black
                
                VStack {
                    Text("ARCLE")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                    
                    Text("Welcome to our Augmented Reality Classroom Learning Experience")
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer() // Spacing between the paragraph and buttons
                    
                    Spacer() // Spacer between the buttons and the bottom edge
                }
                .padding(.top, 100) // Add padding to shift everything down
                
                VStack {
                    Spacer()
                    
                    NavigationLink(destination: FirstPage()) {
                        Text("Chemistry")
                            .foregroundColor(.white)
                            .frame(width: 300, height: 90) // Set fixed width and height
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    NavigationLink(destination: SecondPage()) {
                        Text("Astronomy")
                            .foregroundColor(.white)
                            .frame(width: 300, height: 90) // Set fixed width and height
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    NavigationLink(destination: ThirdPage()) {
                        Text("Biology")
                            .foregroundColor(.white)
                            .frame(width: 300, height: 90) // Set fixed width and height
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    NavigationLink(destination: FourthPage()) {
                        Text("Geosystems")
                            .foregroundColor(.white)
                            .frame(width: 300, height: 90) // Set fixed width and height
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Spacer()
                }
                .padding(.top, 190)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    class Coordinator: NSObject {
        var parent: ARViewContainer
        init(_ parent: ARViewContainer) {
            self.parent = parent
        }
        
        @objc func button1Tapped() {
            parent.addModel(name: "The_3D_Periodic_Table.usdz")
        }
        
        @objc func rotateButtonTapped() {
            parent.rotateModel()
        }
        @objc func sliderValueChanged(_ sender: UISlider) {
                    parent.zoomModel(scale: sender.value)
                }
    }
    
    func addModel(name: String) {
        do {
            // Load your 3D model
            let modelEntity = try ModelEntity.loadModel(named: name)

            // Create an anchor entity and add the model
            let anchorEntity = AnchorEntity(world: [0, 0, -1]) // Adjust the position as needed
            anchorEntity.addChild(modelEntity)

            // Add the anchor entity to the scene
            arView.scene.anchors.append(anchorEntity)
        } catch {
            print("Error loading model: \(error)")
        }
    }
    
    func rotateModel() {
        // Retrieve the model entity from the scene
        guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
            print("No model to rotate")
            return
        }
        
        // Rotate the model entity
        modelEntity.transform.rotation *= simd_quatf(angle: .pi / 2, axis: [0, 1, 0]) // Rotate by 90 degrees around the Y-axis
    }
    
    func zoomModel(scale: Float) {
            // Retrieve the model entity from the scene
            guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
                print("No model to zoom")
                return
            }
            
            // Scale the model entity
            modelEntity.scale = SIMD3<Float>(scale, scale, scale)
        }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    let arView = ARView(frame: .zero)
    
    func makeUIView(context: Context) -> ARView {
        // Create a bottom UI bar
        let uiBar = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width, height: 100))
        uiBar.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Set background color with alpha
        
        // Add buttons to the UI bar
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 20
        let buttonXPosition = (UIScreen.main.bounds.width - (buttonWidth * 3 + buttonSpacing * 2)) / 2
        
        let button1 = UIButton(type: .system)
        button1.setTitle("Periodic Table", for: .normal)
        button1.frame = CGRect(x: buttonXPosition, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        button1.addTarget(context.coordinator, action: #selector(Coordinator.button1Tapped), for: .touchUpInside)
        uiBar.addSubview(button1)
        
        let rotateButton = UIButton(type: .system)
                rotateButton.setTitle("Rotate", for: .normal)
                rotateButton.frame = CGRect(x: buttonXPosition + buttonSpacing + buttonWidth, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
                rotateButton.addTarget(context.coordinator, action: #selector(Coordinator.rotateButtonTapped), for: .touchUpInside)
                uiBar.addSubview(rotateButton)
        
        let slider = UISlider()
                slider.minimumValue = 0.001
                slider.maximumValue = 0.15
                slider.value = 1.0 // Initial zoom scale
                slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2)) // Rotate the slider vertically
                slider.frame = CGRect(x: 360, y: 450, width: 20, height: 200) // Adjust x, y, width, and height as needed
                slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged(_:)), for: .valueChanged)
                arView.addSubview(slider)
        
        arView.addSubview(uiBar)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}


struct ARViewContainer1: UIViewRepresentable {
    class Coordinator: NSObject {
        var parent: ARViewContainer1
        init(_ parent: ARViewContainer1) {
            self.parent = parent
        }
        @objc func button1Tapped() {
            parent.addModel(name: "NaCl.usdz")
        }
        @objc func rotateButtonTapped() {
                    parent.rotateModel()
                }
        @objc func sliderValueChanged(_ sender: UISlider) {
                    parent.zoomModel(scale: sender.value)
                }
    }
    func addModel(name: String) {
        do {
                // Load your 3D model
                let modelEntity = try ModelEntity.loadModel(named: name)

                // Create an anchor entity and add the model
                let anchorEntity = AnchorEntity(world: [0, 0, -1]) // Adjust the position as needed
                anchorEntity.addChild(modelEntity)

                // Add the anchor entity to the scene
                arView.scene.anchors.append(anchorEntity)
            } catch {
                print("Error loading model: \(error)")
            }
    }
    func rotateModel() {
        // Retrieve the model entity from the scene
        guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
            print("No model to rotate")
            return
        }
        
        // Rotate the model entity
        modelEntity.transform.rotation *= simd_quatf(angle: .pi / 2, axis: [0, 1, 0]) // Rotate by 90 degrees around the Y-axis
    }
    func zoomModel(scale: Float) {
            // Retrieve the model entity from the scene
            guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
                print("No model to zoom")
                return
            }
            
            // Scale the model entity
            modelEntity.scale = SIMD3<Float>(scale, scale, scale)
        }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    let arView = ARView(frame: .zero)
    func makeUIView(context: Context) -> ARView {
        // Create a bottom UI bar
        let uiBar = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width, height: 100))
        uiBar.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Set background color with alpha
        
        // Add buttons to the UI bar
        let buttonWidth: CGFloat = 170
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 22
        let buttonXPosition = (UIScreen.main.bounds.width - (buttonWidth * 3 + buttonSpacing * 2)) / 2
        
        let button1 = UIButton(type: .system)
        button1.setTitle("Sodium Chloride", for: .normal)
        button1.frame = CGRect(x: buttonXPosition+70, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        button1.addTarget(context.coordinator, action: #selector(Coordinator.button1Tapped), for: .touchUpInside)
        uiBar.addSubview(button1)
        
        let rotateButton = UIButton(type: .system)
                rotateButton.setTitle("Rotate", for: .normal)
                rotateButton.frame = CGRect(x: buttonXPosition + buttonSpacing + buttonWidth, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
                rotateButton.addTarget(context.coordinator, action: #selector(Coordinator.rotateButtonTapped), for: .touchUpInside)
                uiBar.addSubview(rotateButton)
        
        let slider = UISlider()
        slider.minimumValue = 0.001
        slider.maximumValue = 0.15
                slider.value = 1.0 // Initial zoom scale
                slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2)) // Rotate the slider vertically
                slider.frame = CGRect(x: 360, y: 450, width: 20, height: 200) // Adjust x, y, width, and height as needed
                slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged(_:)), for: .valueChanged)
                arView.addSubview(slider)
        
        arView.addSubview(uiBar)
        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct ARViewContainer2: UIViewRepresentable {
    class Coordinator: NSObject {
        var parent: ARViewContainer2
        init(_ parent: ARViewContainer2) {
            self.parent = parent
        }
        @objc func button1Tapped() {
            parent.addModel(name: "But-2-ene.usdz")
        }
        @objc func button2Tapped() {
            parent.addModel(name: "CH4.usdz")
        }
        @objc func rotateButtonTapped() {
                    parent.rotateModel()
                }
        @objc func sliderValueChanged(_ sender: UISlider) {
                    parent.zoomModel(scale: sender.value)
                }
    }
    func addModel(name: String) {
        do {
                // Load your 3D model
                let modelEntity = try ModelEntity.loadModel(named: name)

                // Create an anchor entity and add the model
                let anchorEntity = AnchorEntity(world: [0, 0, -1]) // Adjust the position as needed
                anchorEntity.addChild(modelEntity)

                // Add the anchor entity to the scene
                arView.scene.anchors.append(anchorEntity)
            } catch {
                print("Error loading model: \(error)")
            }
    }
    func rotateModel() {
        // Retrieve the model entity from the scene
        guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
            print("No model to rotate")
            return
        }
        
        // Rotate the model entity
        modelEntity.transform.rotation *= simd_quatf(angle: .pi / 2, axis: [0, 1, 0]) // Rotate by 90 degrees around the Y-axis
    }
    func zoomModel(scale: Float) {
            // Retrieve the model entity from the scene
            guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
                print("No model to zoom")
                return
            }
            
            // Scale the model entity
            modelEntity.scale = SIMD3<Float>(scale, scale, scale)
        }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    let arView = ARView(frame: .zero)
    func makeUIView(context: Context) -> ARView {
        // Create a bottom UI bar
        let uiBar = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width, height: 100))
        uiBar.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Set background color with alpha
        
        // Add buttons to the UI bar
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 20
        let buttonXPosition = (UIScreen.main.bounds.width - (buttonWidth * 3 + buttonSpacing * 2)) / 2
        
        let button1 = UIButton(type: .system)
        button1.setTitle("But-2-ene", for: .normal)
        button1.frame = CGRect(x: buttonXPosition, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        button1.addTarget(context.coordinator, action: #selector(Coordinator.button1Tapped), for: .touchUpInside)
        
        let button2 = UIButton(type: .system)
        button2.setTitle("Methane", for: .normal)
        button2.frame = CGRect(x: buttonXPosition + buttonWidth + buttonSpacing, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        button2.addTarget(context.coordinator, action: #selector(Coordinator.button2Tapped), for: .touchUpInside)
        
        let rotateButton = UIButton(type: .system)
                rotateButton.setTitle("Rotate", for: .normal)
                rotateButton.frame = CGRect(x: buttonXPosition + buttonSpacing + buttonWidth + buttonWidth, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
                rotateButton.addTarget(context.coordinator, action: #selector(Coordinator.rotateButtonTapped), for: .touchUpInside)
        
        uiBar.addSubview(button1)
        uiBar.addSubview(button2)
        uiBar.addSubview(rotateButton)
        let slider = UISlider()
        slider.minimumValue = 0.001
        slider.maximumValue = 0.15
                slider.value = 1.0 // Initial zoom scale
                slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2)) // Rotate the slider vertically
                slider.frame = CGRect(x: 360, y: 450, width: 20, height: 200) // Adjust x, y, width, and height as needed
                slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged(_:)), for: .valueChanged)
                arView.addSubview(slider)
        
        arView.addSubview(uiBar)
        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct ARViewContainer3: UIViewRepresentable {
    class Coordinator: NSObject {
        var parent: ARViewContainer3
        init(_ parent: ARViewContainer3) {
            self.parent = parent
        }
        @objc func button1Tapped() {
            parent.addModel(name: "DNA_RNA.usdz")
        }
        @objc func rotateButtonTapped() {
                    parent.rotateModel()
                }
        @objc func sliderValueChanged(_ sender: UISlider) {
                    parent.zoomModel(scale: sender.value)
                }
    }
    func addModel(name: String) {
        do {
                // Load your 3D model
                let modelEntity = try ModelEntity.loadModel(named: name)

                // Create an anchor entity and add the model
                let anchorEntity = AnchorEntity(world: [0, 0, -1]) // Adjust the position as needed
                anchorEntity.addChild(modelEntity)

                // Add the anchor entity to the scene
                arView.scene.anchors.append(anchorEntity)
            } catch {
                print("Error loading model: \(error)")
            }
    }
    func rotateModel() {
        // Retrieve the model entity from the scene
        guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
            print("No model to rotate")
            return
        }
        
        // Rotate the model entity
        modelEntity.transform.rotation *= simd_quatf(angle: .pi / 2, axis: [0, 1, 0]) // Rotate by 90 degrees around the Y-axis
    }
    func zoomModel(scale: Float) {
            // Retrieve the model entity from the scene
            guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
                print("No model to zoom")
                return
            }
            
            // Scale the model entity
            modelEntity.scale = SIMD3<Float>(scale, scale, scale)
        }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    let arView = ARView(frame: .zero)
    func makeUIView(context: Context) -> ARView {
        // Create a bottom UI bar
        let uiBar = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width, height: 100))
        uiBar.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Set background color with alpha
        
        // Add buttons to the UI bar
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 20
        let buttonXPosition = (UIScreen.main.bounds.width - (buttonWidth * 3 + buttonSpacing * 2)) / 2
        
        let button1 = UIButton(type: .system)
        button1.setTitle("DNA RNA", for: .normal)
        button1.frame = CGRect(x: buttonXPosition, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        button1.addTarget(context.coordinator, action: #selector(Coordinator.button1Tapped), for: .touchUpInside)
        uiBar.addSubview(button1)
        
        let rotateButton = UIButton(type: .system)
                rotateButton.setTitle("Rotate", for: .normal)
                rotateButton.frame = CGRect(x: buttonXPosition + buttonSpacing + buttonWidth, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
                rotateButton.addTarget(context.coordinator, action: #selector(Coordinator.rotateButtonTapped), for: .touchUpInside)
                uiBar.addSubview(rotateButton)
        
        let slider = UISlider()
        slider.minimumValue = 0.001
        slider.maximumValue = 0.15
                slider.value = 1.0 // Initial zoom scale
                slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2)) // Rotate the slider vertically
                slider.frame = CGRect(x: 360, y: 450, width: 20, height: 200) // Adjust x, y, width, and height as needed
                slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged(_:)), for: .valueChanged)
                arView.addSubview(slider)
        arView.addSubview(uiBar)
        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct ARViewContainer4: UIViewRepresentable {
    class Coordinator: NSObject {
        var parent: ARViewContainer4
        init(_ parent: ARViewContainer4){
            self.parent = parent
        }
        @objc func button1Tapped() {
            parent.addModel(name: "AnimalCell.usdz")
        }
        @objc func rotateButtonTapped() {
                    parent.rotateModel()
                }
        @objc func sliderValueChanged(_ sender: UISlider) {
                    parent.zoomModel(scale: sender.value)
                }
    }
    func addModel(name: String) {
        do {
                // Load your 3D model
                let modelEntity = try ModelEntity.loadModel(named: name)

                // Create an anchor entity and add the model
                let anchorEntity = AnchorEntity(world: [0, 0, -1]) // Adjust the position as needed
                anchorEntity.addChild(modelEntity)

                // Add the anchor entity to the scene
                arView.scene.anchors.append(anchorEntity)
            } catch {
                print("Error loading model: \(error)")
            }
    }
    func rotateModel() {
        // Retrieve the model entity from the scene
        guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
            print("No model to rotate")
            return
        }
        
        // Rotate the model entity
        modelEntity.transform.rotation *= simd_quatf(angle: .pi / 2, axis: [0, 1, 0]) // Rotate by 90 degrees around the Y-axis
    }
    func zoomModel(scale: Float) {
            // Retrieve the model entity from the scene
            guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
                print("No model to zoom")
                return
            }
            
            // Scale the model entity
            modelEntity.scale = SIMD3<Float>(scale, scale, scale)
        }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    let arView = ARView(frame: .zero)
    func makeUIView(context: Context) -> ARView {
        // Create a bottom UI bar
        let uiBar = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width, height: 100))
        uiBar.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Set background color with alpha
        
        // Add buttons to the UI bar
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 20
        let buttonXPosition = (UIScreen.main.bounds.width - (buttonWidth * 3 + buttonSpacing * 2)) / 2
        
        let button1 = UIButton(type: .system)
        button1.setTitle("Animal Cell", for: .normal)
        button1.frame = CGRect(x: buttonXPosition, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        button1.addTarget(context.coordinator, action: #selector(Coordinator.button1Tapped), for: .touchUpInside)
        uiBar.addSubview(button1)
        
        let rotateButton = UIButton(type: .system)
                rotateButton.setTitle("Rotate", for: .normal)
                rotateButton.frame = CGRect(x: buttonXPosition + buttonSpacing + buttonWidth, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
                rotateButton.addTarget(context.coordinator, action: #selector(Coordinator.rotateButtonTapped), for: .touchUpInside)
                uiBar.addSubview(rotateButton)
        let slider = UISlider()
        slider.minimumValue = 0.001
        slider.maximumValue = 0.15
                slider.value = 1.0 // Initial zoom scale
                slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2)) // Rotate the slider vertically
                slider.frame = CGRect(x: 360, y: 450, width: 20, height: 200) // Adjust x, y, width, and height as needed
                slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged(_:)), for: .valueChanged)
                arView.addSubview(slider)
        arView.addSubview(uiBar)
        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct ARViewContainer5: UIViewRepresentable {
    class Coordinator: NSObject {
        var parent: ARViewContainer5
        init(_ parent: ARViewContainer5){
            self.parent = parent
        }
        @objc func button1Tapped() {
            parent.addModel(name: "Lab_Glassware.usdz")
        }
        @objc func rotateButtonTapped() {
                    parent.rotateModel()
                }
        @objc func sliderValueChanged(_ sender: UISlider) {
                    parent.zoomModel(scale: sender.value)
                }
    }
    func addModel(name: String) {
        do {
                // Load your 3D model
                let modelEntity = try ModelEntity.loadModel(named: name)

                // Create an anchor entity and add the model
                let anchorEntity = AnchorEntity(world: [0, 0, -1]) // Adjust the position as needed
                anchorEntity.addChild(modelEntity)

                // Add the anchor entity to the scene
                arView.scene.anchors.append(anchorEntity)
            } catch {
                print("Error loading model: \(error)")
            }
    }
    func rotateModel() {
        // Retrieve the model entity from the scene
        guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
            print("No model to rotate")
            return
        }
        
        // Rotate the model entity
        modelEntity.transform.rotation *= simd_quatf(angle: .pi / 2, axis: [0, 1, 0]) // Rotate by 90 degrees around the Y-axis
    }
    func zoomModel(scale: Float) {
            // Retrieve the model entity from the scene
            guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
                print("No model to zoom")
                return
            }
            
            // Scale the model entity
            modelEntity.scale = SIMD3<Float>(scale, scale, scale)
        }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    let arView = ARView(frame: .zero)
    func makeUIView(context: Context) -> ARView {
        // Create a bottom UI bar
        let uiBar = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width, height: 100))
        uiBar.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Set background color with alpha
        
        // Add buttons to the UI bar
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 20
        let buttonXPosition = (UIScreen.main.bounds.width - (buttonWidth * 3 + buttonSpacing * 2)) / 2
        
        let button1 = UIButton(type: .system)
        button1.setTitle("Lab Materials", for: .normal)
        button1.frame = CGRect(x: buttonXPosition, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        button1.addTarget(context.coordinator, action: #selector(Coordinator.button1Tapped), for: .touchUpInside)
        uiBar.addSubview(button1)
        
        let rotateButton = UIButton(type: .system)
                rotateButton.setTitle("Rotate", for: .normal)
                rotateButton.frame = CGRect(x: buttonXPosition + buttonSpacing + buttonWidth, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
                rotateButton.addTarget(context.coordinator, action: #selector(Coordinator.rotateButtonTapped), for: .touchUpInside)
                uiBar.addSubview(rotateButton)
        let slider = UISlider()
        slider.minimumValue = 0.001
        slider.maximumValue = 0.15
                slider.value = 1.0 // Initial zoom scale
                slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2)) // Rotate the slider vertically
                slider.frame = CGRect(x: 360, y: 450, width: 20, height: 200) // Adjust x, y, width, and height as needed
                slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged(_:)), for: .valueChanged)
                arView.addSubview(slider)
        arView.addSubview(uiBar)
        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct ARViewContainer6: UIViewRepresentable {
    class Coordinator: NSObject {
        var parent: ARViewContainer6
        init(_ parent: ARViewContainer6) {
            self.parent = parent
        }
        @objc func button1Tapped() {
            parent.addModel(name: "Solar_System_Custom.usdz")
        }
        @objc func rotateButtonTapped() {
                    parent.rotateModel()
                }
        @objc func sliderValueChanged(_ sender: UISlider) {
                    parent.zoomModel(scale: sender.value)
                }
    }
    func addModel(name: String) {
        do {
                // Load your 3D model
                let modelEntity = try ModelEntity.loadModel(named: name)

                // Create an anchor entity and add the model
                let anchorEntity = AnchorEntity(world: [0, 0, -1]) // Adjust the position as needed
                anchorEntity.addChild(modelEntity)

                // Add the anchor entity to the scene
                arView.scene.anchors.append(anchorEntity)
            } catch {
                print("Error loading model: \(error)")
            }
    }
    func rotateModel() {
        // Retrieve the model entity from the scene
        guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
            print("No model to rotate")
            return
        }
        
        // Rotate the model entity
        modelEntity.transform.rotation *= simd_quatf(angle: .pi / 2, axis: [0, 1, 0]) // Rotate by 90 degrees around the Y-axis
    }
    func zoomModel(scale: Float) {
            // Retrieve the model entity from the scene
            guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
                print("No model to zoom")
                return
            }
            
            // Scale the model entity
            modelEntity.scale = SIMD3<Float>(scale, scale, scale)
        }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    let arView = ARView(frame: .zero)
    func makeUIView(context: Context) -> ARView {
        // Create a bottom UI bar
        let uiBar = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width, height: 100))
        uiBar.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Set background color with alpha
        
        // Add buttons to the UI bar
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 20
        let buttonXPosition = (UIScreen.main.bounds.width - (buttonWidth * 3 + buttonSpacing * 2)) / 2
        
        let button1 = UIButton(type: .system)
        button1.setTitle("Solar System", for: .normal)
        button1.frame = CGRect(x: buttonXPosition, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        button1.addTarget(context.coordinator, action: #selector(Coordinator.button1Tapped), for: .touchUpInside)
        uiBar.addSubview(button1)
        
        let rotateButton = UIButton(type: .system)
                rotateButton.setTitle("Rotate", for: .normal)
                rotateButton.frame = CGRect(x: buttonXPosition + buttonSpacing + buttonWidth, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
                rotateButton.addTarget(context.coordinator, action: #selector(Coordinator.rotateButtonTapped), for: .touchUpInside)
                uiBar.addSubview(rotateButton)
        let slider = UISlider()
        slider.minimumValue = 0.001
        slider.maximumValue = 0.15
                slider.value = 1.0 // Initial zoom scale
                slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2)) // Rotate the slider vertically
                slider.frame = CGRect(x: 360, y: 450, width: 20, height: 200) // Adjust x, y, width, and height as needed
                slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged(_:)), for: .valueChanged)
                arView.addSubview(slider)
        arView.addSubview(uiBar)
        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct ARViewContainer7: UIViewRepresentable {
    class Coordinator: NSObject {
        var parent: ARViewContainer7
        init(_ parent: ARViewContainer7) {
            self.parent = parent
        }
        @objc func button1Tapped() {
            parent.addModel(name: "Solar_System_Linear.usdz")
        }
        @objc func rotateButtonTapped() {
                    parent.rotateModel()
                }
        @objc func sliderValueChanged(_ sender: UISlider) {
                    parent.zoomModel(scale: sender.value)
                }
    }
    func addModel(name: String) {
        do {
                // Load your 3D model
                let modelEntity = try ModelEntity.loadModel(named: name)

                // Create an anchor entity and add the model
                let anchorEntity = AnchorEntity(world: [0, 0, -1]) // Adjust the position as needed
                anchorEntity.addChild(modelEntity)

                // Add the anchor entity to the scene
                arView.scene.anchors.append(anchorEntity)
            } catch {
                print("Error loading model: \(error)")
            }
    }
    func rotateModel() {
        // Retrieve the model entity from the scene
        guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
            print("No model to rotate")
            return
        }
        
        // Rotate the model entity
        modelEntity.transform.rotation *= simd_quatf(angle: .pi / 2, axis: [0, 1, 0]) // Rotate by 90 degrees around the Y-axis
    }
    func zoomModel(scale: Float) {
            // Retrieve the model entity from the scene
            guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
                print("No model to zoom")
                return
            }
            
            // Scale the model entity
            modelEntity.scale = SIMD3<Float>(scale, scale, scale)
        }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    let arView = ARView(frame: .zero)
    func makeUIView(context: Context) -> ARView {
        // Create a bottom UI bar
        let uiBar = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width, height: 100))
        uiBar.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Set background color with alpha
        
        // Add buttons to the UI bar
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 20
        let buttonXPosition = (UIScreen.main.bounds.width - (buttonWidth * 3 + buttonSpacing * 2)) / 2
        
        let button1 = UIButton(type: .system)
        button1.setTitle("Solar System", for: .normal)
        button1.frame = CGRect(x: buttonXPosition, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        button1.addTarget(context.coordinator, action: #selector(Coordinator.button1Tapped), for: .touchUpInside)
        uiBar.addSubview(button1)
        
        let rotateButton = UIButton(type: .system)
                rotateButton.setTitle("Rotate", for: .normal)
                rotateButton.frame = CGRect(x: buttonXPosition + buttonSpacing + buttonWidth, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
                rotateButton.addTarget(context.coordinator, action: #selector(Coordinator.rotateButtonTapped), for: .touchUpInside)
                uiBar.addSubview(rotateButton)
        let slider = UISlider()
        slider.minimumValue = 0.001
        slider.maximumValue = 0.15
                slider.value = 1.0 // Initial zoom scale
                slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2)) // Rotate the slider vertically
                slider.frame = CGRect(x: 360, y: 450, width: 20, height: 200) // Adjust x, y, width, and height as needed
                slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged(_:)), for: .valueChanged)
                arView.addSubview(slider)
        arView.addSubview(uiBar)
        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct ARViewContainer8: UIViewRepresentable {
    class Coordinator: NSObject {
        var parent: ARViewContainer8
        init(_ parent: ARViewContainer8) {
            self.parent = parent
        }
        @objc func button1Tapped() {
            parent.addModel(name: "ISS.usdz")
        }
        @objc func rotateButtonTapped() {
                    parent.rotateModel()
                }
        @objc func sliderValueChanged(_ sender: UISlider) {
                    parent.zoomModel(scale: sender.value)
                }
    }
    func addModel(name: String) {
        do {
                // Load your 3D model
                let modelEntity = try ModelEntity.loadModel(named: name)

                // Create an anchor entity and add the model
                let anchorEntity = AnchorEntity(world: [0, 0, -1]) // Adjust the position as needed
                anchorEntity.addChild(modelEntity)

                // Add the anchor entity to the scene
                arView.scene.anchors.append(anchorEntity)
            } catch {
                print("Error loading model: \(error)")
            }
    }
    func rotateModel() {
        // Retrieve the model entity from the scene
        guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
            print("No model to rotate")
            return
        }
        
        // Rotate the model entity
        modelEntity.transform.rotation *= simd_quatf(angle: .pi / 2, axis: [0, 1, 0]) // Rotate by 90 degrees around the Y-axis
    }
    func zoomModel(scale: Float) {
            // Retrieve the model entity from the scene
            guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
                print("No model to zoom")
                return
            }
            
            // Scale the model entity
            modelEntity.scale = SIMD3<Float>(scale, scale, scale)
        }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    let arView = ARView(frame: .zero)
    func makeUIView(context: Context) -> ARView {
        // Create a bottom UI bar
        let uiBar = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width, height: 100))
        uiBar.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Set background color with alpha
        
        // Add buttons to the UI bar
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 20
        let buttonXPosition = (UIScreen.main.bounds.width - (buttonWidth * 3 + buttonSpacing * 2)) / 2
        
        let button1 = UIButton(type: .system)
        button1.setTitle("ISS", for: .normal)
        button1.frame = CGRect(x: buttonXPosition, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        button1.addTarget(context.coordinator, action: #selector(Coordinator.button1Tapped), for: .touchUpInside)
        uiBar.addSubview(button1)
        let rotateButton = UIButton(type: .system)
                rotateButton.setTitle("Rotate", for: .normal)
                rotateButton.frame = CGRect(x: buttonXPosition + buttonSpacing + buttonWidth, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
                rotateButton.addTarget(context.coordinator, action: #selector(Coordinator.rotateButtonTapped), for: .touchUpInside)
                uiBar.addSubview(rotateButton)
        let slider = UISlider()
        slider.minimumValue = 0.001
        slider.maximumValue = 0.15
                slider.value = 1.0 // Initial zoom scale
                slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2)) // Rotate the slider vertically
                slider.frame = CGRect(x: 360, y: 450, width: 20, height: 200) // Adjust x, y, width, and height as needed
                slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged(_:)), for: .valueChanged)
                arView.addSubview(slider)
        arView.addSubview(uiBar)
        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct ARViewContainer9: UIViewRepresentable {
    class Coordinator: NSObject {
        var parent: ARViewContainer9
        init(_ parent: ARViewContainer9) {
            self.parent = parent
        }
        @objc func button1Tapped() {
            parent.addModel(name: "Japan_Earthquake.usdz")
        }
        @objc func rotateButtonTapped() {
                    parent.rotateModel()
                }
        @objc func sliderValueChanged(_ sender: UISlider) {
                    parent.zoomModel(scale: sender.value)
                }
    }
    func addModel(name: String) {
        do {
                // Load your 3D model
                let modelEntity = try ModelEntity.loadModel(named: name)

                // Create an anchor entity and add the model
            let anchorEntity = AnchorEntity(world: [0, -1, -1]) // Adjust the position as needed
                anchorEntity.addChild(modelEntity)

                // Add the anchor entity to the scene
                arView.scene.anchors.append(anchorEntity)
            } catch {
                print("Error loading model: \(error)")
            }
    }
    func rotateModel() {
        // Retrieve the model entity from the scene
        guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
            print("No model to rotate")
            return
        }
        
        // Rotate the model entity
        modelEntity.transform.rotation *= simd_quatf(angle: .pi / 2, axis: [0, 1, 0]) // Rotate by 90 degrees around the Y-axis
    }
    func zoomModel(scale: Float) {
            // Retrieve the model entity from the scene
            guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
                print("No model to zoom")
                return
            }
            
            // Scale the model entity
            modelEntity.scale = SIMD3<Float>(scale, scale, scale)
        }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    let arView = ARView(frame: .zero)
    func makeUIView(context: Context) -> ARView {
        // Create a bottom UI bar
        let uiBar = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width, height: 100))
        uiBar.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Set background color with alpha
        
        // Add buttons to the UI bar
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 20
        let buttonXPosition = (UIScreen.main.bounds.width - (buttonWidth * 3 + buttonSpacing * 2)) / 2
        
        let button1 = UIButton(type: .system)
        button1.setTitle("Terrain Map", for: .normal)
        button1.frame = CGRect(x: buttonXPosition, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        button1.addTarget(context.coordinator, action: #selector(Coordinator.button1Tapped), for: .touchUpInside)
        uiBar.addSubview(button1)
        let rotateButton = UIButton(type: .system)
                rotateButton.setTitle("Rotate", for: .normal)
                rotateButton.frame = CGRect(x: buttonXPosition + buttonSpacing + buttonWidth, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
                rotateButton.addTarget(context.coordinator, action: #selector(Coordinator.rotateButtonTapped), for: .touchUpInside)
                uiBar.addSubview(rotateButton)
        let slider = UISlider()
        slider.minimumValue = 0.001
        slider.maximumValue = 0.15
                slider.value = 1.0 // Initial zoom scale
                slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2)) // Rotate the slider vertically
                slider.frame = CGRect(x: 360, y: 450, width: 20, height: 200) // Adjust x, y, width, and height as needed
                slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged(_:)), for: .valueChanged)
                arView.addSubview(slider)
        arView.addSubview(uiBar)
        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct ARViewContainer10: UIViewRepresentable {
    class Coordinator: NSObject {
        var parent: ARViewContainer10
        init(_ parent: ARViewContainer10) {
            self.parent = parent
        }
        @objc func button1Tapped() {
            parent.addModel(name: "Tectonic_Plates.usdz")
        }
        @objc func rotateButtonTapped() {
                    parent.rotateModel()
                }
        @objc func sliderValueChanged(_ sender: UISlider) {
                    parent.zoomModel(scale: sender.value)
                }
    }
    func addModel(name: String) {
        do {
                // Load your 3D model
                let modelEntity = try ModelEntity.loadModel(named: name)

                // Create an anchor entity and add the model
            let anchorEntity = AnchorEntity(world: [0, -2, -1]) // Adjust the position as needed
                anchorEntity.addChild(modelEntity)

                // Add the anchor entity to the scene
                arView.scene.anchors.append(anchorEntity)
            } catch {
                print("Error loading model: \(error)")
            }
    }
    func rotateModel() {
        // Retrieve the model entity from the scene
        guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
            print("No model to rotate")
            return
        }
        
        // Rotate the model entity
        modelEntity.transform.rotation *= simd_quatf(angle: .pi / 2, axis: [0, 1, 0]) // Rotate by 90 degrees around the Y-axis
    }
    func zoomModel(scale: Float) {
            // Retrieve the model entity from the scene
            guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
                print("No model to zoom")
                return
            }
            
            // Scale the model entity
            modelEntity.scale = SIMD3<Float>(scale, scale, scale)
        }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    let arView = ARView(frame: .zero)
    func makeUIView(context: Context) -> ARView {
        // Create a bottom UI bar
        let uiBar = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width, height: 100))
        uiBar.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Set background color with alpha
        
        // Add buttons to the UI bar
        let buttonWidth: CGFloat = 120
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 20
        let buttonXPosition = (UIScreen.main.bounds.width - (buttonWidth * 3 + buttonSpacing * 2)) / 2
        
        let button1 = UIButton(type: .system)
        button1.setTitle("Convergent Plains", for: .normal)
        button1.frame = CGRect(x: buttonXPosition, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        button1.addTarget(context.coordinator, action: #selector(Coordinator.button1Tapped), for: .touchUpInside)
        uiBar.addSubview(button1)
        let rotateButton = UIButton(type: .system)
                rotateButton.setTitle("Rotate", for: .normal)
                rotateButton.frame = CGRect(x: buttonXPosition + buttonSpacing + buttonWidth, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
                rotateButton.addTarget(context.coordinator, action: #selector(Coordinator.rotateButtonTapped), for: .touchUpInside)
                uiBar.addSubview(rotateButton)
        let slider = UISlider()
        slider.minimumValue = 0.001
        slider.maximumValue = 0.15
                slider.value = 1.0 // Initial zoom scale
                slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2)) // Rotate the slider vertically
                slider.frame = CGRect(x: 360, y: 450, width: 20, height: 200) // Adjust x, y, width, and height as needed
                slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged(_:)), for: .valueChanged)
                arView.addSubview(slider)
        arView.addSubview(uiBar)
        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct ARViewContainer11: UIViewRepresentable {
    class Coordinator: NSObject {
        var parent: ARViewContainer11
        init(_ parent: ARViewContainer11) {
            self.parent = parent
        }
        @objc func button1Tapped() {
            parent.addModel(name: "Earth_Core_V2.usdz")
        }
        @objc func rotateButtonTapped() {
                    parent.rotateModel()
                }
        @objc func sliderValueChanged(_ sender: UISlider) {
                    parent.zoomModel(scale: sender.value)
                }
    }
    func addModel(name: String) {
        do {
                // Load your 3D model
                let modelEntity = try ModelEntity.loadModel(named: name)

                // Create an anchor entity and add the model
            let anchorEntity = AnchorEntity(world: [0, 0, -1]) // Adjust the position as needed
                anchorEntity.addChild(modelEntity)

                // Add the anchor entity to the scene
                arView.scene.anchors.append(anchorEntity)
            } catch {
                print("Error loading model: \(error)")
            }
    }
    func rotateModel() {
        // Retrieve the model entity from the scene
        guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
            print("No model to rotate")
            return
        }
        
        // Rotate the model entity
        modelEntity.transform.rotation *= simd_quatf(angle: .pi / 2, axis: [0, 1, 0]) // Rotate by 90 degrees around the Y-axis
    }
    func zoomModel(scale: Float) {
            // Retrieve the model entity from the scene
            guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
                print("No model to zoom")
                return
            }
            
            // Scale the model entity
            modelEntity.scale = SIMD3<Float>(scale, scale, scale)
        }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    let arView = ARView(frame: .zero)
    func makeUIView(context: Context) -> ARView {
        // Create a bottom UI bar
        let uiBar = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width, height: 100))
        uiBar.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Set background color with alpha
        
        // Add buttons to the UI bar
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 20
        let buttonXPosition = (UIScreen.main.bounds.width - (buttonWidth * 3 + buttonSpacing * 2)) / 2
        
        let button1 = UIButton(type: .system)
        button1.setTitle("Earth's Layer", for: .normal)
        button1.frame = CGRect(x: buttonXPosition, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        button1.addTarget(context.coordinator, action: #selector(Coordinator.button1Tapped), for: .touchUpInside)
        uiBar.addSubview(button1)
        let rotateButton = UIButton(type: .system)
                rotateButton.setTitle("Rotate", for: .normal)
                rotateButton.frame = CGRect(x: buttonXPosition + buttonSpacing + buttonWidth, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
                rotateButton.addTarget(context.coordinator, action: #selector(Coordinator.rotateButtonTapped), for: .touchUpInside)
                uiBar.addSubview(rotateButton)
        let slider = UISlider()
        slider.minimumValue = 0.001
        slider.maximumValue = 0.15
                slider.value = 1.0 // Initial zoom scale
                slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2)) // Rotate the slider vertically
                slider.frame = CGRect(x: 360, y: 450, width: 20, height: 200) // Adjust x, y, width, and height as needed
                slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged(_:)), for: .valueChanged)
                arView.addSubview(slider)
        arView.addSubview(uiBar)
        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct ARViewContainer12: UIViewRepresentable {
    class Coordinator: NSObject {
        var parent: ARViewContainer12
        init(_ parent: ARViewContainer12) {
            self.parent = parent
        }
        @objc func button1Tapped() {
            parent.addModel(name: "Plant_Cell.usdz")
        }
        @objc func rotateButtonTapped() {
                    parent.rotateModel()
                }
        @objc func sliderValueChanged(_ sender: UISlider) {
                    parent.zoomModel(scale: sender.value)
                }
    }
    func addModel(name: String) {
        do {
                // Load your 3D model
                let modelEntity = try ModelEntity.loadModel(named: name)

                // Create an anchor entity and add the model
            let anchorEntity = AnchorEntity(world: [0, 0, -1]) // Adjust the position as needed
                anchorEntity.addChild(modelEntity)

                // Add the anchor entity to the scene
                arView.scene.anchors.append(anchorEntity)
            } catch {
                print("Error loading model: \(error)")
            }
    }
    func rotateModel() {
        // Retrieve the model entity from the scene
        guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
            print("No model to rotate")
            return
        }
        
        // Rotate the model entity
        modelEntity.transform.rotation *= simd_quatf(angle: .pi / 2, axis: [0, 1, 0]) // Rotate by 90 degrees around the Y-axis
    }
    func zoomModel(scale: Float) {
            // Retrieve the model entity from the scene
            guard let modelEntity = arView.scene.anchors.first?.children.first as? ModelEntity else {
                print("No model to zoom")
                return
            }
            
            // Scale the model entity
            modelEntity.scale = SIMD3<Float>(scale, scale, scale)
        }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    let arView = ARView(frame: .zero)
    func makeUIView(context: Context) -> ARView {
        // Create a bottom UI bar
        let uiBar = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width, height: 100))
        uiBar.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Set background color with alpha
        
        // Add buttons to the UI bar
        let buttonWidth: CGFloat = 100
        let buttonHeight: CGFloat = 50
        let buttonSpacing: CGFloat = 20
        let buttonXPosition = (UIScreen.main.bounds.width - (buttonWidth * 3 + buttonSpacing * 2)) / 2
        
        let button1 = UIButton(type: .system)
        button1.setTitle("Plant Cell", for: .normal)
        button1.frame = CGRect(x: buttonXPosition, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        button1.addTarget(context.coordinator, action: #selector(Coordinator.button1Tapped), for: .touchUpInside)
        uiBar.addSubview(button1)
        let rotateButton = UIButton(type: .system)
                rotateButton.setTitle("Rotate", for: .normal)
                rotateButton.frame = CGRect(x: buttonXPosition + buttonSpacing + buttonWidth, y: (100 - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
                rotateButton.addTarget(context.coordinator, action: #selector(Coordinator.rotateButtonTapped), for: .touchUpInside)
                uiBar.addSubview(rotateButton)
        let slider = UISlider()
        slider.minimumValue = 0.001
        slider.maximumValue = 0.15
                slider.value = 1.0 // Initial zoom scale
                slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2)) // Rotate the slider vertically
                slider.frame = CGRect(x: 360, y: 450, width: 20, height: 200) // Adjust x, y, width, and height as needed
                slider.addTarget(context.coordinator, action: #selector(Coordinator.sliderValueChanged(_:)), for: .valueChanged)
                arView.addSubview(slider)
        arView.addSubview(uiBar)
        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct FirstPage: View {
    var body: some View {
        VStack {
            Spacer()
            
            NavigationLink(destination: PeriodicTable()) {
                Text("Periodic Table Kit")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 60) // Set fixed width and height
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            NavigationLink(destination: NaClBonding()) {
                Text("Ionic Bonding Kit")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 60) // Set fixed width and height
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            NavigationLink(destination: OrgoMolecules()) {
                Text("Organic Molecules Kit")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 60) // Set fixed width and height
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            NavigationLink(destination: LabGlassware()) {
                Text("Lab Glassware Kit")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 60) // Set fixed width and height
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Chemistry")
    }
}


struct SecondPage: View {
    var body: some View {
        VStack {
            Spacer()
            
            NavigationLink(destination: SolarDetailed()) {
                Text("Solar Orbits Kit")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 60) // Set fixed width and height
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            NavigationLink(destination: LinearSystem()) {
                Text("Linear Solar System")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 60) // Set fixed width and height
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            NavigationLink(destination: ISS()) {
                Text("International Space Station")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 60) // Set fixed width and height
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Astronomy")
    }
}

struct ThirdPage: View {
    var body: some View {
        VStack {
            Spacer()
            
            NavigationLink(destination: DnaRna()) {
                Text("DNA RNA Kit")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 60) // Set fixed width and height
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            NavigationLink(destination: AnimalCell()) {
                Text("Animal Cell Kit")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 60) // Set fixed width and height
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            NavigationLink(destination: PlantCell()) {
                Text("Plant Cell Kit")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 60) // Set fixed width and height
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Biology")
    }
}

struct FourthPage: View {
    var body: some View {
        VStack {
            Spacer()
            
            NavigationLink(destination: JapanQuake()) {
                Text("Model Earthquake Kit")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 60) // Set fixed width and height
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            NavigationLink(destination: Plates()) {
                Text("Tectonic Plates Kit")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 60) // Set fixed width and height
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            NavigationLink(destination: EarthsLayer()) {
                Text("Earth's Layer Kit")
                    .foregroundColor(.white)
                    .frame(width: 300, height: 60) // Set fixed width and height
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Geosystems")
    }
}

struct PeriodicTable: View {
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}

struct NaClBonding: View {
    var body: some View {
        ARViewContainer1()
            .edgesIgnoringSafeArea(.all)
    }
}

struct OrgoMolecules: View {
    var body: some View {
        ARViewContainer2()
            .edgesIgnoringSafeArea(.all)
    }
}

struct DnaRna: View {
    var body: some View {
        ARViewContainer3()
            .edgesIgnoringSafeArea(.all)
    }
}

struct AnimalCell: View {
    var body: some View {
        ARViewContainer4()
            .edgesIgnoringSafeArea(.all)
    }
}

struct LabGlassware: View {
    var body: some View {
        ARViewContainer5()
            .edgesIgnoringSafeArea(.all)
    }
}

struct SolarDetailed: View {
    var body: some View {
        ARViewContainer6()
            .edgesIgnoringSafeArea(.all)
    }
}

struct LinearSystem: View {
    var body: some View {
        ARViewContainer7()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ISS: View {
    var body: some View {
        ARViewContainer8()
            .edgesIgnoringSafeArea(.all)
    }
}

struct JapanQuake: View {
    var body: some View {
        ARViewContainer9()
            .edgesIgnoringSafeArea(.all)
    }
}

struct Plates: View {
    var body: some View {
        ARViewContainer10()
            .edgesIgnoringSafeArea(.all)
    }
}

struct EarthsLayer: View {
    var body: some View {
        ARViewContainer11()
            .edgesIgnoringSafeArea(.all)
    }
}

struct PlantCell: View {
    var body: some View {
        ARViewContainer12()
            .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
