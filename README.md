# Gastrovia – Mobil Restoran Sipariş Uygulaması

Bu proje, bir restoranın dijital sipariş yönetimini sağlamak amacıyla Flutter ile geliştirilmiş bir mobil uygulamadır. Uygulama, Firebase ile entegre çalışarak kullanıcı kimlik doğrulaması, menü yönetimi, sipariş takibi ve ödeme ekranı gibi işlevleri barındırır.

## Proje Geliştirme Süreci

### 1. Hafta – Firebase Kurulumu ve Kimlik Doğrulama
- Firebase projesi oluşturuldu.
- Uygulama Firebase’e bağlandı.
- Giriş ve kayıt ekranları oluşturuldu.
- Firebase Authentication kullanılarak kullanıcı yönetimi sağlandı.

### 2. Hafta – Menü Arayüzü ve Görseller
- Uygulama içi görsel yapılar (kategori kartları vs.) hazırlandı.
- Menü sayfası tasarlandı.
- Görseller assets klasörüne eklendi ve pubspec.yaml dosyasında tanımlandı.

### 3. Hafta – Firestore ile Menü Dinamik Yapısı
- Firestore veritabanına kategori ve ürün verileri eklendi.
- Menü ekranı Firestore'dan dinamik olarak yüklenecek şekilde geliştirildi.
- Kategori ve ürün listeleme mantığı tamamlandı.

### 4. Hafta – Sepet Sistemi
- Kullanıcıların ürünleri sepete eklemesi sağlandı.
- Sepet ekranında ürünler görüntülendi.
- Ürün silme ve toplam tutarı hesaplama işlemleri yapıldı.

### 5. Hafta – Sipariş Verme, Geçmiş ve Ödeme Simülasyonu
- Sipariş verme işlemi Firestore’a kayıt olarak eklendi.
- Kullanıcının geçmiş siparişleri listelendi.
- Temsili bir ödeme ekranı hazırlandı.

## Teknik Özellikler
- Flutter (Dart)
- Firebase Auth
- Cloud Firestore
- Provider (State Management)

## Notlar
GitHub'a yükleme sırasında bazı commit geçmişleri teknik sebeplerle yeniden yazıldı. Bu nedenle commit geçmişinde yalnızca son haftanın mesajı görünmekte ancak **projede 1. haftadan itibaren tüm özellikler eksiksiz olarak mevcuttur**. 
