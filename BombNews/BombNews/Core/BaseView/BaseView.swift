//
//  BaseView.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import SwiftUI

struct BaseView<Content: View, ViewState:ViewStateProtocol, VM: BaseViewModel<ViewState>>: View {
    
    @ObservedObject var baseViewModel: VM
    private let content: Content
    private var bgColor: Color = .white
    
    init(viewModel: VM, @ViewBuilder content: () -> Content) {
        _baseViewModel = ObservedObject(wrappedValue: viewModel)
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            bgColor.edgesIgnoringSafeArea(.all)
            content
        }
        .alert(isPresented: $baseViewModel.showAlert) {
            Alert(
                title: Text("Uyarı"),
                message: Text(baseViewModel.alertMessage),
                dismissButton: .default(Text("Tamam"))
            )
        }
    }
}

extension BaseView {
    func setBg(color: Color) -> Self {
        var view = self
        view.bgColor = color
        return view
    }
}
