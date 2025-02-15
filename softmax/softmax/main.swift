//
//  main.swift
//  softmax
//
//  Created by Ayça Eren on 14.02.2025.
//

import Foundation

// Mahalle veri yapısı
struct Mahalle {
    let isim: String
    let nufusYogunlugu: Double
    let ulasimAltyapisi: Double
    let maliyet: Double
    let cevreselEtki: Double
    let sosyalFayda: Double
}

// Softmax fonksiyonu
func softmax(skorlar: [Double]) -> [Double] {
    let üstelSkorlar = skorlar.map { exp($0) }
    let toplam = üstelSkorlar.reduce(0, +)
    return üstelSkorlar.map { $0 / toplam }
}

// Mahallelerin skorlarını hesapla
func skorHesapla(mahalle: Mahalle) -> Double {
    let agirliklar = [0.30, 0.20, 0.15, 0.20, 0.15] // Kriter ağırlıkları
    let skorlar = [
        mahalle.nufusYogunlugu,
        mahalle.ulasimAltyapisi,
        mahalle.maliyet,
        mahalle.cevreselEtki,
        mahalle.sosyalFayda
    ]
    return zip(agirliklar, skorlar).map { $0 * $1 }.reduce(0, +)
}

// Mahalle verileri
let mahalleler = [
    Mahalle(isim: "Mahalle Karakaş", nufusYogunlugu: 8, ulasimAltyapisi: 6, maliyet: 5, cevreselEtki: 7, sosyalFayda: 9),
    Mahalle(isim: "Mahalle Cumhuriyet", nufusYogunlugu: 7, ulasimAltyapisi: 5, maliyet: 4, cevreselEtki: 8, sosyalFayda: 8),
    Mahalle(isim: "Mahalle İstasyon", nufusYogunlugu: 9, ulasimAltyapisi: 7, maliyet: 6, cevreselEtki: 6, sosyalFayda: 7)
]

// Mahalle skorlarını hesapla
let skorlar = mahalleler.map { skorHesapla(mahalle: $0) }

// Softmax olasılıklarını hesapla
let softmaxOlasiliklar = softmax(skorlar: skorlar)

// Sonuçları yazdır
for (index, mahalle) in mahalleler.enumerated() {
    print("\(mahalle.isim): %\(String(format: "%.1f", softmaxOlasiliklar[index] * 100))")
}

// En uygun güzergahı bul
let enUygunIndex = softmaxOlasiliklar.firstIndex(of: softmaxOlasiliklar.max()!)!
print("\nEn uygun güzergah: \(mahalleler[enUygunIndex].isim)")

// Maliyet-fayda analizi
print("\nMaliyet-Fayda Analizi:")
print("Maliyet: \(mahalleler[enUygunIndex].maliyet)/10")
print("Fayda: Nüfus Yoğunluğu (\(mahalleler[enUygunIndex].nufusYogunlugu)/10), Sosyal Fayda (\(mahalleler[enUygunIndex].sosyalFayda)/10), Çevresel Etki (\(mahalleler[enUygunIndex].cevreselEtki)/10)")

