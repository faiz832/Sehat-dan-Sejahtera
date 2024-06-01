import 'package:flutter/material.dart';
import 'routes.dart';
import 'detail_article_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToDetail(String title, String imagePath, String content) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailArticlePage(
          title: title,
          imagePath: imagePath,
          content: content,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/profile.png'),
                        radius: 30,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello Aprillia!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Monday, 06:30 WIB',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.notifications),
                        onPressed: () {
                          // Handle notifications
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Check Up',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCheckUpCard('Check Diabetes', 'images/diabetes.png'),
                      _buildCheckUpCard('Check HIV Aids', 'images/hiv.png'),
                      _buildCheckUpCard('Check Malaria', 'images/malaria.png'),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Populer Artikel',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildArticleCard(
                    'Apa Itu Kanker',
                    'This article will look at this subject, providing a brief overview of this subject.',
                    'images/hepatitis.png',
                    'Waspada! Inilah Beberapa Gejala Diabetes Yang Perlu Kamu Tau!\n\n'
                        'Apa Itu Diabetes?\n\n'
                        'Diabetes adalah penyakit kronis yang ditandai dengan tingginya kadar gula darah. '
                        'Glukosa merupakan sumber energi utama bagi sel tubuh manusia. Akan tetapi, pada penderita diabetes, '
                        'glukosa tersebut tidak dapat digunakan oleh tubuh.\n\n'
                        'Gejala Diabetes\n\n'
                        'Diabetes tipe 1 dapat berkembang dengan cepat dalam beberapa minggu atau bahkan beberapa hari saja. '
                        'Sedangkan pada diabetes tipe 2, banyak penderitanya yang tidak menyadari bahwa mereka telah menderita diabetes selama bertahun-tahun, '
                        'karena gejalanya cenderung tidak spesifik. Beberapa ciri-ciri penyakit gula atau diabetes tipe 1 dan tipe 2 meliputi:\n'
                        '- Sering merasa haus atau sangat lapar\n'
                        '- Sering buang air kecil, terutama pada malam hari\n'
                        '- Penurunan berat badan tanpa sebab yang jelas\n'
                        '- Kelelahan\n'
                        '- Penglihatan kabur\n'
                        '- Luka yang lama sembuh\n'
                        '- Sering mengalami infeksi, seperti infeksi kulit, gusi, atau saluran kemih.',
                  ),
                  _buildArticleCard(
                    'Tanda-Tanda Jantung Bocor',
                    'This article will look at this subject, providing a brief overview of this subject.',
                    'images/tbc.png',
                    'Tanda-tanda jantung bocor bisa beragam, termasuk nyeri dada, kelelahan, dan lainnya...\n\n'
                        'Apa Itu Jantung Bocor?\n\n'
                        'Jantung bocor adalah kondisi di mana ada kebocoran pada katup jantung. '
                        'Kondisi ini dapat menyebabkan darah mengalir kembali ke jantung, '
                        'mengurangi efisiensi jantung dalam memompa darah ke seluruh tubuh.\n\n'
                        'Gejala Jantung Bocor\n\n'
                        'Gejala jantung bocor dapat bervariasi tergantung pada tingkat keparahan kondisi. '
                        'Beberapa gejala umum meliputi:\n'
                        '- Nyeri dada\n'
                        '- Kelelahan\n'
                        '- Sesak napas\n'
                        '- Detak jantung tidak teratur\n'
                        '- Pembengkakan pada kaki atau pergelangan kaki\n'
                        '- Pusing atau pingsan.',
                  ),
                  _buildArticleCard(
                    'Cegah Diabetes Dengan Ini',
                    'This article will look at this subject, providing a brief overview of this subject.',
                    'images/diabetes.png',
                    'Cara mencegah diabetes termasuk menjaga pola makan dan rutin berolahraga...\n\n'
                        'Tips Mencegah Diabetes\n\n'
                        '1. Jaga Berat Badan Ideal\n'
                        'Menjaga berat badan ideal sangat penting untuk mencegah diabetes. Kelebihan berat badan dapat meningkatkan risiko terkena diabetes tipe 2.\n\n'
                        '2. Konsumsi Makanan Sehat\n'
                        'Pilih makanan yang kaya serat, seperti buah, sayuran, dan biji-bijian utuh. Kurangi konsumsi gula dan lemak jenuh.\n\n'
                        '3. Rutin Berolahraga\n'
                        'Lakukan aktivitas fisik secara rutin, seperti berjalan kaki, berlari, atau berenang. Olahraga membantu meningkatkan sensitivitas insulin.\n\n'
                        '4. Hindari Rokok\n'
                        'Merokok dapat meningkatkan risiko diabetes dan komplikasi yang berhubungan dengan diabetes.\n\n'
                        '5. Rutin Periksa Kesehatan\n'
                        'Lakukan pemeriksaan kesehatan secara rutin untuk memantau kadar gula darah dan mengidentifikasi dini tanda-tanda diabetes.',
                  ),
                  _buildArticleCard(
                    'Cegah Malaria Dengan Ini',
                    'This article will look at this subject, providing a brief overview of this subject.',
                    'images/malaria.png',
                    'Malaria adalah penyakit yang bisa dicegah dengan cara-cara tertentu, termasuk menggunakan kelambu...\n\n'
                        'Tips Mencegah Malaria\n\n'
                        '1. Gunakan Kelambu\n'
                        'Tidur menggunakan kelambu yang telah diolesi insektisida dapat melindungi dari gigitan nyamuk penyebab malaria.\n\n'
                        '2. Semprot Ruangan dengan Insektisida\n'
                        'Semprot ruangan dengan insektisida untuk membunuh nyamuk yang masuk ke dalam rumah.\n\n'
                        '3. Hindari Aktivitas di Luar Rumah pada Malam Hari\n'
                        'Nyamuk Anopheles yang menyebarkan malaria biasanya aktif pada malam hari. Hindari aktivitas di luar rumah pada malam hari atau gunakan pakaian panjang dan lotion anti nyamuk.\n\n'
                        '4. Minum Obat Antimalaria\n'
                        'Bagi yang tinggal atau akan bepergian ke daerah endemik malaria, minum obat antimalaria sesuai anjuran dokter dapat membantu mencegah infeksi.',
                  ),
                ],
              ),
            ),
          ),
          ...Routes.widgetOptions.sublist(1),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sick),
            label: 'Check',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        backgroundColor: Colors.lightBlue,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildCheckUpCard(String title, String assetPath) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            assetPath,
            height: 50,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(String title, String description, String assetPath, String content) {
    return GestureDetector(
      onTap: () => _navigateToDetail(title, assetPath, content),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  assetPath,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
