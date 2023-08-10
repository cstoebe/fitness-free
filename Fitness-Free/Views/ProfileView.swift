//
//  ProfileView.swift
//  Personal Fitness Free
//
//  Created by Conner Stoebe on 5/31/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        ScrollView {
            VStack {
                if let currentUser = userManager.currentUser,
                   let userImage = userManager.getProfilePicture(for: currentUser) {
                    Image(uiImage: userImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.top)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.top)
                }
                
                if let currentUser = userManager.currentUser {
                    Text(currentUser.name)
                        .font(.title)
                        .padding(.bottom)
                }
                
                // More here
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
