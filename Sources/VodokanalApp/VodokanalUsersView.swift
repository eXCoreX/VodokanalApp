//
//  VodokanalUsersView.swift
//  
//
//  Created by Litvinov Rostyslav on 18.12.2022.
//

import TokamakDOM

struct VodokanalUsersView: View {
    let users: [VodokanalUser]

    var body: some View {
        VStack {
            LazyVGrid(columns: [
                .init(.fixed(200), alignment: .leading),
                .init(.fixed(300), alignment: .leading),
                .init(.fixed(200), alignment: .leading)
            ]) {
                Text("Номер рахунку")
                    .padding(.bottom)
                Text("ПІБ")
                    .padding(.bottom)
                Text("Останні показники")
                    .padding(.bottom)
                if users.isEmpty {
                    ProgressView()
                }
                ForEach(users) { user in
                    Text("\(user.accountNumber)")
                    Text("\(user.fullName)")
                    Text("\(user.lastReadings)")
                }
            }
        }
        .padding(24)
        .background(.background1)
        .cornerRadius(8)
    }
}
