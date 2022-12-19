//
//  AdminAuthenticationView.swift
//  
//
//  Created by Litvinov Rostyslav on 19.12.2022.
//

import TokamakDOM

struct AdminAutheticationView: View {
    @Binding var authorized: Bool
    var onClose: (Bool) -> Void

    @State private var password = ""
    @State private var message = ""

    var body: some View {
        VStack(alignment: .trailing, spacing: 16) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 32) {
                    Text("Вхід в адмін-панель")
                        .font(.title)

                    Button {
                        onClose(authorized)
                    } label: {
                        Text("X")
                            .bold()
                            .font(.title3)
                            .frame(width: 32, height: 32)
                            .background(Color.background0)
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }

                SecureField("Пароль", text: $password)
                    .border(.red, width: password.isEmpty ? 2 : 0)
                    .frame(height: 40)

                Button {
                    guard !password.isEmpty else {
                        message = "Пароль не може бути пустим."
                        return
                    }
                    message = ""
                    Task {
                        let result = await AuthenticationService.shared.authenticate(password: password)
                        if result {
                            message = "Успішний вхід."
                        } else {
                            message = "Помилка, не правильний пароль."
                            return
                        }
                        try? await Task.sleep(nanoseconds: 1_000_000_000)
                        authorized = true
                        onClose(true)
                    }
                } label: {
                    Text("Вхід")
                        .padding()
                        .background(
                            Color.color1
                        )
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
                .opacity(!password.isEmpty ? 1 : 0.5)

                if !message.isEmpty {
                    Text("\(message)")
                }
            }
        }
        .padding(32)
        .background(.background4)
        .cornerRadius(16)
    }
}
