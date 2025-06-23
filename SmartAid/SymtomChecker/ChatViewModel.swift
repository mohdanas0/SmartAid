//
//  ChatViewModel.swift
//  SmartAid
//
//  Created by mohdanas on 17/06/25.
//

import Foundation

struct ChatMessage: Identifiable,Hashable {
    let id = UUID()
    let role: String // "user" or "bot"
    let content: String
}

class ChatViewModel: ObservableObject {
    @Published var userInput: String = ""
    @Published var messages: [ChatMessage] = []
    @Published var isLoading: Bool = false

    private let url = "https://router.huggingface.co/featherless-ai/v1/chat/completions"
    private let token = "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"

    func sendMessage() {
        let trimmed = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let userMessage = ChatMessage(role: "user", content: trimmed)
        messages.append(userMessage)
        userInput = ""
        isLoading = true

        // Build full chat history for API (role, content)
        let apiMessages = messages.map {
            ["role": $0.role == "user" ? "user" : "assistant", "content": $0.content]
        }

        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "mistralai/Magistral-Small-2506",
            "stream": false,
            "messages": apiMessages
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    self.messages.append(ChatMessage(role: "bot", content: "Error: \(error.localizedDescription)"))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.messages.append(ChatMessage(role: "bot", content: "No response data"))
                }
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    DispatchQueue.main.async {
                        self.messages.append(ChatMessage(role: "bot", content: content.trimmingCharacters(in: .whitespacesAndNewlines)))
                    }
                } else {
                    DispatchQueue.main.async {
                        self.messages.append(ChatMessage(role: "bot", content: "Unexpected response format"))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.messages.append(ChatMessage(role: "bot", content: "Failed to parse response"))
                }
            }
        }.resume()
    }
}

