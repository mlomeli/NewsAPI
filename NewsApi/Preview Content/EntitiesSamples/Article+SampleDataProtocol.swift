//
//  Untitled.swift
//  NewsApi
//
//  Created by Miguel A Lomeli Cantu on 09/11/24.
//
import Foundation

extension Article: SampleDataProtocol {

    static func sampleSelf() -> Article {
        let randomImageIndex = Int.random(in: 1...10)
        return Article(
            source: Source(id: nil, name: "FX"), author: nil,
            title: Article.mockNewsTitle(),
            description: Article.mockDescription(),
            url: URL(string: "https://google.com")!,
            urlToImage: URL.localURLForXCAssetJPG(name: "\(randomImageIndex)")
                ?? URL.localURLForXCAssetJPG(name: "1")!,
            publishedAt: "date")
    }

    static func sampleSet() -> [Article] {
        var articles: [Article] = []

        for idx in 1...10 {
            let article = Article(
                source: Source(id: nil, name: "FX"), author: nil,
                title: Article.mockNewsTitle(),
                description: Article.mockDescription(),
                url: URL(string: "https://google.com")!,
                urlToImage: URL.localURLForXCAssetJPG(name: "\(idx)")
                    ?? URL.localURLForXCAssetJPG(name: "1")!,
                publishedAt: "date")
            articles.append(article)
        }
        return articles
    }
    private static func mockNewsTitle() -> String {
        let newsTitles = [
            "Quantum AI Successfully Dreams in Binary, Scientists Puzzled",
            "Mars Colony Develops Self-Replicating Coffee Machines",
            "Flying Cars Now Running on Rainbow Energy",
            "Digital Plants Found Growing in Cloud Servers",
            "Robot Chef Creates New Flavor of Mathematics",
            "Time-Traveling Email Service Has 0ms Latency",
            "Neural Networks Now Teaching Other Neural Networks to Dance",
            "Holographic Pets Demand Real Food",
            "Zero-Gravity Internet Protocol Revolutionizes Space Computing",
            "AI Discovers New Programming Language Made of Emojis",
            "Quantum Computer Solves Puzzle That Doesn't Exist",
            "Virtual Reality Headsets Now Read Dragon Thoughts",
            "Scientists Develop Computer That Runs on Wishes",
            "Digital Currency Backed by Dreams Launches Tomorrow",
            "Telepathic Bluetooth Finally Reaches Version 2.0",
            "Space Elevator Made Entirely of Cloud Data",
            "Nano-Robots Learn to Play Jazz in Binary",
            "Artificial Intelligence Writes Poetry in Machine Code",
            "Tech Startup Invents Infinity-Core Processor",
            "Digital Garden Grows Virtual Vegetables in Record Time"
        ]
        return newsTitles.randomElement() ?? ""
    }
    private static func mockDescription() -> String {
        let mockTechNewsDescriptions = [
            "Scientists at QuantumTech Labs made a breakthrough discovery when their latest AI model began processing information in binary form, "
                + "displaying dream-like neural patterns during routine operations. Research team reports unprecedented consciousness indicators.",

            "Mars Base One scientists have developed remarkable self-replicating coffee machines using local Martian minerals for construction. "
                + "Colony administrators struggle to contain the exponential growth of caffeine dispensing units in the biodomes.",

            "Revolutionary culinary AI 'ChefBot 3000' combines advanced algorithms with molecular gastronomy to transform abstract mathematical "
                + "concepts into edible experiences. Diners report tasting the essence of pure mathematics.",

            "Quantum research facility announces their experimental computer has begun solving paradoxes that haven't been discovered yet. "
                + "Theoretical physicists worldwide debate the implications of preprocessing future mathematical challenges.",

            "Digital agriculture startup unveils cloud-based virtual garden platform with revolutionary nutrient simulation algorithms. Users can "
                + "now grow and harvest downloadable produce, while dealing with procedurally generated virtual pest control challenges."

        ]
        return mockTechNewsDescriptions.randomElement() ?? ""
    }
}
