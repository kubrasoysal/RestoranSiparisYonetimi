# Gastrovia – Mobil Restoran Sipariş Yönetimi

Bu proje, Flutter ve Firebase kullanılarak geliştirilmiş bir restoran sipariş yönetim sistemidir.  
Mobil kullanıcılar menüyü görüntüleyebilir, ürünleri sepete ekleyebilir, ödeme yapabilir ve sipariş durumlarını takip edebilir.  
Proje, 6 haftalık bir geliştirme süreciyle adım adım inşa edilmiştir.

---

##  Haftalık Geliştirme Süreci

###  1. Hafta – Firebase & Kimlik Doğrulama
- Firebase kurulumu tamamlandı  
- Firebase Authentication ile giriş & kayıt ekranları geliştirildi  
- AuthWrapper ile kullanıcı yönlendirme sistemi kuruldu

---

### 2. Hafta – Menü Arayüzü ve Görseller
- Menü sayfası oluşturuldu  
- Görseller assets klasörüne yerleştirildi  
- Kategorilere göre menü sistemi eklendi

---

###  3. Hafta – Firestore ile Dinamik Menü
- Menü ürünleri Firestore'a kaydedildi  
- Menü sayfası Firestore'dan gerçek zamanlı veri çekerek çalışır hale getirildi

---

###  4. Hafta – Sepet Sistemi ve Provider ile Durum Yönetimi
- Sepete ürün ekleme ve silme özellikleri geliştirildi  
- Provider kullanılarak uygulama genelinde sepet durumu yönetildi  
- Toplam tutar hesaplandı

---

###  5. Hafta – Ödeme Ekranı ve Sipariş Oluşturma
- Ödeme ekranı oluşturuldu (simülasyon amaçlı)  
- Sipariş verildiğinde Firestore'a ürün listesi, toplam tutar, kullanıcı bilgisi ve zaman damgası eklendi

---

###  6. Hafta – Gerçek Zamanlı Sipariş Takibi ve Admin Paneli
- Sipariş geçmişi ekranı oluşturuldu  
- Her siparişin durumu (`alındı`, `hazırlanıyor`, `yolda`, `teslim edildi`) anlık olarak takip edilebildi  
- Admin için sipariş yönetim ekranı geliştirildi  
- Kullanıcı arayüzü 3 sekmeli yapıya geçirildi (Menü, Sepet, Siparişlerim)

  
-----------------------------------------------------------------------------------------------

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
