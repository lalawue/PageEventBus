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
class SubmitPageModel: BlockPageModel<SubmitViewController, UIView, SubmitEvent, SubmitResult> {
    
    var phone: String = ""
    var email: String = ""
    
    var resultView: ResultView?
    
    override func agentName() -> String {
        return SubmitNames.SubmitAgent
    }
    
    override func updateData(data: Any?) {
        guard let cmd = data as? String, cmd == "viewDidLoad" else {
            return
        }
        
        createInfoView()
        createInputField()
        createSubmit()
        createTap()
    }
    
    // MARK: - UI Element
    
    private func createInputField() {
        // create child view controller
        if let vc = controller.phoneVC {
            vc.viewDidLoadCallback = { vc in
                vc.viewModel = InputPageModel(controller: vc, initBus: false)
                if let model = vc.viewModel as? InputPageModel {
                    model.data = "Phone"
                }
            }
            vc.viewWillLayoutCallback = { vc in
                guard  let model = vc.viewModel as? InputPageModel else {
                    return
                }
                model.layout()
            }
        }
        
        if let vc = controller.emailVC {
            vc.viewDidLoadCallback = { vc in
                vc.viewModel = InputPageModel(controller: vc, initBus: false)
                if let model = vc.viewModel as? InputPageModel {
                    model.data = "Email"
                }
            }
            vc.viewWillLayoutCallback = { vc in
                guard let model = vc.viewModel as? InputPageModel else {
                    return
                }
                model.layout()
            }
        }
        
        if let vc = controller.phoneVC {
            controller.addChild(vc)
            view.addSubview(vc.view)
            vc.didMove(toParent: controller)
        }
        
        if let vc = controller.emailVC {
            controller.addChild(vc)
            view.addSubview(vc.view)
            vc.didMove(toParent: controller)
        }
    }
    
    private func createInfoView() {
        if let v = controller.infoView {
            v.viewModel = InfoViewModel(view: v)
            if let model = v.viewModel as? InfoViewModel {
                model.data = "Please fill both below"
            }
            view.addSubview(v)
        }
    }
    
    private func createSubmit() {
        controller.confirmButton.isEnabled = false
        view.addSubview(controller.confirmButton)
        controller.confirmButton.addTarget(self, action: #selector(onSubmit(button:)), for: .touchUpInside)
    }
    
    private func createTap() {
        let gesture = UITapGestureRecognizer()
        view.addGestureRecognizer(gesture)
        gesture.addTarget(self, action: #selector(onTap(gesture:)))
    }
    
    // MARK: - Action
    
    @objc private func onTap(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
        if resultView != nil {
            resultView!.removeFromSuperview()
            resultView = nil
        }
    }
    
    @objc private func onSubmit(button: UIButton) {
        let size = view.frame.size
        resultView = ResultView(frame: CGRect(x: size.width/2-150, y: 0, width: 300, height: 100))
        if let v = resultView {
            v.viewModel = ResultViewModel(view: v)
            if let model = v.viewModel as? ResultViewModel {
                model.data = "Information"
            }
            v.center = CGPoint(x: size.width/2, y: size.height/2 - 30)
            view.addSubview(v)
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
