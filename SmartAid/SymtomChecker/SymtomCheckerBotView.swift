//
//  SymtomCheckerBotView.swift
//  SmartAid
//
//  Created by mohdanas on 17/06/25.
//

import SwiftUI

struct SymtomCheckerBotView: View {
    @StateObject private var viewModel = ChatViewModel()
    var body: some View {
        VStack {
            if viewModel.messages.isEmpty {
                Spacer()
                Text("What's can i help you?")
                    .font(.headline)
                    
                Spacer()
            }else{
                ScrollView {
                    ForEach(viewModel.messages, id: \.self) { message in
                        Text("\(message.role == "user" ? "🧑‍💻" : "🤖") \(message.content)")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: message.role == "user" ? .trailing : .leading)
                            .background(message.role == "user" ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                }
            }
            
            HStack {
                TextField("Type something...", text: $viewModel.userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundStyle(Color.primary)
                    .disabled(viewModel.isLoading)
                Button(action: {
                    viewModel.sendMessage()
                }) {
                    Text(viewModel.isLoading ? "..." : "Send")
                        .padding(.horizontal)
                }
                .disabled(viewModel.userInput.trimmingCharacters(in: .whitespaces).isEmpty || viewModel.isLoading)
            }
            .padding()
        }
    }
}

#Preview {
    SymtomCheckerBotView()
}
