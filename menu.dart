import 'dart:collection';
import 'dart:io';

class MenuItem {
  String name;
  int price; //Harga dalam Rupiah

  MenuItem(this.name, this.price);

  @override
  String toString() {
    return '$name - Rp $price';
  }
}

class Menu {
  List<MenuItem> menuItems = []; //Akses cepat berdasarkan indeks

  void addItem(MenuItem item) {
    menuItems.add(item);
  }

  void displayMenu() {
    print('Menu Dapoer Vee:');
    for (var i = 0; i < menuItems.length; i++) {
      print('${i + 1}. ${menuItems[i]}');
    }
  }

  MenuItem? getItem(int index) {
    //Mengambil menu buat order
    if (index < 0 || index >= menuItems.length) {
      return null;
    }
    return menuItems[index];
  }
}

class Order {
  Queue<MenuItem> orders = Queue(); //Antrian pesanan

  void addOrder(MenuItem item) {
    orders.addLast(item);
    print('${item.name} telah ditambahkan ke pesanan Anda.');
  }

  void displayOrders() {
    if (orders.isEmpty) {
      print('Tidak ada pesanan.');
    } else {
      print('Pesanan Anda:');
      for (var item in orders) {
        print('- ${item.name} - Rp ${item.price}');
      }
    }
  }

  int getTotalPrice() {
    int total = 0;
    for (var item in orders) {
      total += item.price;
    }
    return total;
  }

  void confirmOrder() {
    if (orders.isEmpty) {
      print('Tidak ada pesanan yang perlu dikonfirmasi.');
      return;
    }

    print('Konfirmasi pesanan Anda (iya/tidak):');
    displayOrders();
    print('Total harga: Rp ${getTotalPrice()}');

    String? confirmation = stdin.readLineSync()?.toLowerCase();
    if (confirmation == 'iya') {
      print('Pesanan Anda telah dikonfirmasi. Terima kasih!');
      orders.clear();
    } else {
      print('Pesanan Anda tidak dikonfirmasi.');
    }
  }
}

void main() {
  Menu DapoerVeeMenu = Menu();
  DapoerVeeMenu.addItem(MenuItem('Brownies', 60000));
  DapoerVeeMenu.addItem(MenuItem('Bolu Cake', 30000));
  DapoerVeeMenu.addItem(MenuItem('Cake Tape', 30000));
  DapoerVeeMenu.addItem(MenuItem('Kue Bolen', 35000));
  DapoerVeeMenu.addItem(MenuItem('Roti Maryam Original', 25000));
  DapoerVeeMenu.addItem(MenuItem('Salad Buah', 15000));
  DapoerVeeMenu.addItem(MenuItem('Bomboloni', 15000));
  DapoerVeeMenu.addItem(MenuItem('Donat', 15000));

  Order order = Order();

  bool running = true; //Menjaga loop utama

  while (running) {
    print('Selamat datang di Dapoer Vee!');
    print('1. Lihat Menu');
    print('2. Tambah Pesanan');
    print('3. Lihat Pesanan');
    print('4. Total Harga');
    print('5. Konfirmasi Pesanan');
    print('6. Keluar');
    print('Pilih opsi: ');

    String? choice =
        stdin.readLineSync(); //Membaca input dari pengguna sebagai string.

    switch (choice) {
      case '1':
        DapoerVeeMenu.displayMenu();
        break;
      case '2':
        print('Masukkan nomor menu yang ingin dipesan: ');
        String? itemChoice = stdin.readLineSync();
        int? itemIndex = int.tryParse(itemChoice ?? '') ?? -1;
        MenuItem? item = DapoerVeeMenu.getItem(itemIndex - 1);
        if (item != null) {
          order.addOrder(item);
        } else {
          print('Menu tidak ditemukan.');
        }
        break;
      case '3':
        order.displayOrders();
        break;
      case '4':
        int totalPrice = order.getTotalPrice();
        print('Total harga pesanan Anda: Rp $totalPrice');
        break;
      case '5':
        order.confirmOrder();
        break;
      case '6':
        running = false;
        print('Terima kasih telah berkunjung!');
        break;
      default:
        print('Pilihan tidak valid.');
        break;
    }
  }
}
