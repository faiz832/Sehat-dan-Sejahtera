import 'package:flutter/material.dart';

class DetailArticlePage extends StatelessWidget {
  final String title;
  final String imagePath;
  final String content;

  DetailArticlePage({
    required this.title,
    required this.imagePath,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Detail Artikel',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 20,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
              SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Apa Itu Diabetes?\n\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                      'Diabetes adalah penyakit kronis yang ditandai dengan tingginya kadar gula darah. Glukosa merupakan sumber energi utama bagi sel tubuh manusia. '
                          'Akan tetapi, pada penderita diabetes, glukosa tersebut tidak dapat digunakan oleh tubuh.\n\n',
                    ),
                    TextSpan(
                      text: 'Gejala Diabetes\n\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                      'Diabetes tipe 1 dapat berkembang dengan cepat dalam beberapa minggu atau bahkan beberapa hari saja. '
                          'Sedangkan pada diabetes tipe 2, banyak penderitanya yang tidak menyadari bahwa mereka telah menderita diabetes selama bertahun-tahun, '
                          'karena gejalanya cenderung tidak spesifik. Beberapa ciri-ciri penyakit gula atau diabetes tipe 1 dan tipe 2 meliputi:\n'
                          '- Sering merasa haus atau sangat lapar\n'
                          '- Sering buang air kecil, terutama pada malam hari\n'
                          '- Penurunan berat badan tanpa sebab yang jelas\n'
                          '- Kelelahan\n'
                          '- Penglihatan kabur\n'
                          '- Luka yang lama sembuh\n'
                          '- Sering mengalami infeksi, seperti infeksi kulit, gusi, atau saluran kemih.\n\n',
                    ),
                    TextSpan(
                      text: 'Beberapa ciri-ciri penyakit gula atau diabetes tipe 1 dan tipe 2 meliputi:\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                      '1. Sering merasa haus atau sangat lapar\n'
                          '2. Sering buang air kecil, terutama pada malam hari\n'
                          '3. Penurunan berat badan tanpa sebab yang jelas\n'
                          '4. Kelelahan\n'
                          '5. Penglihatan kabur\n'
                          '6. Luka yang lama sembuh\n'
                          '7. Sering mengalami infeksi, seperti infeksi kulit, gusi, atau saluran kemih.\n\n',
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
