//
//  SendMoneyView.swift
//  NTBank
//
//  Created by Javier Munoz on 8/3/21.
//

import SwiftUI

struct SendMoneyView: View {
    
    @State private var amount = ""
    @State private var selectedUser: User?
    @State private var isLoading = false
    @State private var users = [User]()
    @State private var currentUser: User?
    
    var onComplete: (() -> Void)
    
    var amountInt: Int { return Int(amount) ?? 0 }
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 2.5)
                .frame(width: 36, height: 5)
                .foregroundColor(.gray)
                .padding(.top)
            
            HStack {
                Text("Send Money").font(.title).bold()
                Spacer()
            }.padding()
            
            ZStack {
                List(users, id: \.self, selection: $selectedUser) { user in
                    UserCellView(isSelectedUser: user == selectedUser, userName: user.name, userColor: user.colorLiteral).onTapGesture { selectedUser = user }
                }
                
                if isLoading {
                    ProgressView().scaleEffect(2)
                }
            }
            
            Spacer()
            
            ZStack {
                EmptyView().frame(height: 105)
                    
                VStack {
                    Divider()
                    HStack {
                        Text("AMOUNT").font(.caption)
                        Spacer()
                    }
                    
                    TextField("$\(0)", text: $amount)
                        .keyboardType(.numberPad)
                        .font(.title)
                        .padding()
                }
            }.padding()
            
            Button(action: { sendMoney() }, label: {
                Text("Send \(amount == "" ? "" : "$\(amount) to") \(selectedUser?.name ?? "")")
                    .frame(width: 343, height: 50)
                    .background(Color.blue)
                    .accentColor(.white)
                    .cornerRadius(10)
            })
        }.onAppear {
            loadUser()
        }
    }
    
    private func loadUser() {
        isLoading = true
        GameService.shared.getAllPlayers { result in
            isLoading = false
            switch result {
            case .success(let users):
                guard let userID = GameService.shared.userID else { return }
                var temp = users
                for (index, user) in temp.enumerated() {
                    if user.userID == userID {
                        currentUser = user
                        temp.remove(at: index)
                    }
                }
                DispatchQueue.main.async {
                    self.users = temp
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func sendMoney() {
        isLoading = true
        GameService.shared.payPlayer(with: amountInt, from: currentUser!, to: selectedUser!) { result in
            isLoading = false
            switch result {
            case .success(_):
                onComplete()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct SendMoneyView_Previews: PreviewProvider {
    static var previews: some View {
        SendMoneyView(onComplete: {})
    }
}
