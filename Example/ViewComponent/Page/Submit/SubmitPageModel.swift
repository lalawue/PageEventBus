//
//  SubmitPageModel.swift
//  ViewComponent
//
//  Created by lalawue on 2021/2/14.
//

import UIKit
import PageEventBus

/** model for submit page
 */
class SubmitPageModel: BlockPageModel<SubmitViewController, SubmitEvent, SubmitResult> {
    
    var phone: String = ""
    var email: String = ""
    
    var resultView: ResultView?
    
    override func agentName() -> String {
        return SubmitNames.SubmitAgent
    }

    override func viewDidLoad() {
        createInfoView()
        createInputField()
        createSubmit()
        createTap()
    }
    
    // MARK: - UI Element
    
    private func createInputField() {
        // create child view controller
        if let vc = controller.phoneVC {
            let model = InputPageModel(controller: vc)
            vc.viewModel = model
            model.connectBus()
            model.data = "Phone"
        }
        
        if let vc = controller.emailVC {
            let model = InputPageModel(controller: vc)
            vc.viewModel = model
            model.connectBus()
            model.data = "Email"
        }
        
        if let vc = controller.phoneVC {
            controller.addChild(vc)
            controller.view.addSubview(vc.view)
            vc.didMove(toParent: controller)
        }
        
        if let vc = controller.emailVC {
            controller.addChild(vc)
            controller.view.addSubview(vc.view)
            vc.didMove(toParent: controller)
        }
    }
    
    private func createInfoView() {
        if let v = controller.infoView {
            v.viewModel = InfoViewModel(view: v)
            if let model = v.viewModel as? InfoViewModel {
                model.data = "Please fill both below"
            }
            controller.view.addSubview(v)
        }
    }
    
    private func createSubmit() {
        controller.confirmButton.isEnabled = false
        controller.view.addSubview(controller.confirmButton)
        controller.confirmButton.addTarget(self, action: #selector(onSubmit(button:)), for: .touchUpInside)
    }
    
    private func createTap() {
        let gesture = UITapGestureRecognizer()
        controller.view.addGestureRecognizer(gesture)
        gesture.addTarget(self, action: #selector(onTap(gesture:)))
    }
    
    // MARK: - Action
    
    @objc private func onTap(gesture: UITapGestureRecognizer) {
        controller.view.endEditing(true)
        if resultView != nil {
            resultView!.removeFromSuperview()
            resultView = nil
        }
    }
    
    @objc private func onSubmit(button: UIButton) {
        let size = controller.view.frame.size
        resultView = ResultView(frame: CGRect(x: size.width/2-150, y: 0, width: 300, height: 100))
        if let v = resultView {
            v.viewModel = ResultViewModel(view: v)
            if let model = v.viewModel as? ResultViewModel {
                model.data = "Information"
            }
            v.center = CGPoint(x: size.width/2, y: size.height/2 - 30)
            controller.view.addSubview(v)
        }
    }
    
    // MARK: - Event
    
    override func didReceiveEvent(event: SubmitEvent) -> SubmitResult? {
        switch event {
        case .DataInput(let flag, let data):
            if flag == "Phone" {
                self.phone = data
            } else {
                self.email = data
            }
            updatePageState()
        default:
            break
        }
        return nil
    }
    
    private func updatePageState() {
        if phone.count > 0 && email.count > 0 {
            controller.confirmButton.isEnabled = true
        } else {
            controller.confirmButton.isEnabled = false
        }
    }
}
