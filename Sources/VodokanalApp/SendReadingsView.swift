//
//  SendReadingsView.swift
//  
//
//  Created by Litvinov Rostyslav on 14.12.2022.
//

import TokamakDOM

struct SendReadingsView: View {
    var onClose: () -> Void
    @State private var accountNumber: String = ""
    @State private var readings: String = ""

    @State private var message: String = ""

    private var accountNumberInt: Int? {
        Int(accountNumber)
    }

    private var readingsInt: Int? {
        Int(readings)
    }

    private var allDataIsValid: Bool {
        accountNumberInt != nil && readingsInt != nil
    }

    var body: some View {
        VStack(alignment: .trailing, spacing: 16) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 32) {
                    Text("Показання лічильника")
                        .font(.title)
                    
                    Button {
                        onClose()
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

                TextField("Номер рахунку", text: $accountNumber)
                    .border(.red, width: accountNumberInt == nil ? 2 : 0)
                    .frame(height: 40)

                TextField("Показання (м³)", text: $readings)
                    .border(.red, width: readingsInt == nil ? 2 : 0)
                    .frame(height: 40)

                Button {
                    Task {
                        guard let accountNumberInt = accountNumberInt,
                              let readingsInt = readingsInt else {
                            return
                        }

                        let userToUpdate = VodokanalUser(accountNumber: accountNumberInt, lastReadings: readingsInt, fullName: "")

                        do {
                            _ = try await VodokanalUsersRepository.shared.updateUser(userToUpdate)
                            message = "Успішно відправлено!"
                        } catch {
                            message = "Помилка."
                        }
                    }
                } label: {
                    Text("Відправити")
                        .padding()
                        .background(
                            Color.color1
                        )
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
                .opacity(allDataIsValid ? 1 : 0.5)

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
