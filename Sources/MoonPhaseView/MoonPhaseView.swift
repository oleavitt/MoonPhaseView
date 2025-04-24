import SwiftUI
import SceneKit

@available(iOS 16, *)
public struct MoonPhaseView: View {
    @ObservedObject private var viewModel: MoonPhaseViewModel

    public init(viewModel: MoonPhaseViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        SceneView(scene: createScene())
    }

    private func createScene() -> SCNScene {
        print("createScene() called")
        let scene = SCNScene()
        scene.background.contents = UIColor.black

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        scene.rootNode.addChildNode(cameraNode)

        // TODO: Determine ecliptic rotation here
        //cameraNode.rotation = SCNVector4(0, 0, 1, percentVisibleToRadians(100 + 0))

        let ambientlightNode = SCNNode()
        ambientlightNode.light = SCNLight()
        ambientlightNode.light?.intensity = 30
        ambientlightNode.light!.type = .ambient
        scene.rootNode.addChildNode(ambientlightNode)

        let lightAtNode = SCNNode()
        let lightNode = SCNNode()
        let light = SCNLight()
        lightNode.light = SCNLight()
        light.intensity = 2000
        light.type = .omni
        lightNode.light = light
        lightNode.position = SCNVector3(x: 0, y: 0, z: 1000)
        lightAtNode.addChildNode(lightNode)
        scene.rootNode.addChildNode(lightAtNode)
        lightAtNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: percentVisibleToRadians(Float(viewModel.percentVisible)))

        let sphereNode = SCNNode(geometry: SCNSphere(radius: 4))
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "moon-map-hi", in: Bundle.module, compatibleWith: nil) ?? UIColor.white
        sphereNode.geometry?.firstMaterial = material
        scene.rootNode.addChildNode(sphereNode)

        return scene
    }

    private func percentVisibleToRadians(_ percent: Float) -> Float {
        Float(Float.pi - Float.pi * percent / 100)
    }
}

struct MoonPhaseView_Preview: PreviewProvider {
    static var previews: some View {
        @StateObject var moonViewModel = MoonPhaseViewModel()
        VStack {
            HStack {
                VStack {
                    Text("The Moon")
                        .font(.title)
                        .colorInvert()
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
                .padding(.vertical)
                MoonPhaseView(viewModel: moonViewModel)
                    .frame(width: 150)
            }
            .frame(height: 150)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular), style: .init())
            Slider(value: $moonViewModel.percentVisible, in: -100...100)
            Spacer()
        }
        .padding()
        MoonPhaseView(viewModel: moonViewModel)
    }
}
