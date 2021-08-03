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
                Text("Send Money")
                    .font(.title)
                    .bold()
                Spacer()
            }.padding()
            
            ZStack {
                List(users, id: \.self, selection: $selectedUser) { user in
                    UserCell(isSelectedUser: user == selectedUser, userName: user.name, userColor: user.colorLiteral)
                        .onTapGesture { selectedUser = user }
                }
                
                if isLoading {
                    ProgressView()
                        .scaleEffect(2)
                }
            }
            
            Spacer()
            
            ZStack {
                EmptyView()
                    .frame(height: 105)
                    
                VStack {
                    Divider()
                    HStack {
                        Text("AMOUNT")
                            .font(.caption)
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
        NetworkManager.shared.getAllPlayers { users in
            isLoading = false
            guard let userID = NetworkManager.shared.userID else { return }
            guard let users = users else { return }
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
        }
    }
    
    private func sendMoney() {
        NetworkManager.shared.payPlayer(with: amountInt, from: currentUser!, to: selectedUser!) { bool in
            if bool {
                onComplete()
            } else {
                print("FAILED")
            }
        }
    }
}

struct UserCell: View {
    
    var isSelectedUser: Bool
    var userName: String
    var userColor: UIColor
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 40, height: 40)
                .foregroundColor(Color.init(userColor))
            
            Text(userName).font(.title2)
            
            Spacer()
            
            if isSelectedUser { Image(systemName: "checkmark.circle") }
        }
        .frame(height: 50)
    }
}

struct SendMoneyView_Previews: PreviewProvider {
    static var previews: some View {
        //SendMoneyView()
        UserCell(isSelectedUser: true, userName: "TEST", userColor: UIColor.blue)
    }
}
