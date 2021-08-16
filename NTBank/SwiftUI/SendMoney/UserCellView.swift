//
//  UserCellView.swift
//  NTBank
//
//  Created by Javier Munoz on 8/16/21.
//

import SwiftUI

struct UserCellView: View {
    
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

struct UserCellView_Previews: PreviewProvider {
    static var previews: some View {
        UserCellView(isSelectedUser: true, userName: "Javier", userColor: .blue)
    }
}
