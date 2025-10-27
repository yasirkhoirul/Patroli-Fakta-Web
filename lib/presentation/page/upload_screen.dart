import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:patroli_fakta/presentation/provider/berita_list_notifier.dart';
import 'package:patroli_fakta/presentation/provider/berita_upload_notifier.dart';
import 'package:patroli_fakta/presentation/provider/status_provider.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  Future uploadtaps(String judul, String deskripsi) async {
    Logger().d("dikirim ke notifier $judul");
    await context.read<BeritaUploadNotifier>().uploadberita(judul, deskripsi);
  }

  final judul = TextEditingController();
  final deskripsi = TextEditingController();
  @override
  void dispose() {
    judul.dispose();
    deskripsi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<BeritaUploadNotifier>(
          builder: (context, value, child) {
            if (value.status is StatusIsloading) {
              return Center(child: CircularProgressIndicator());
            } else if (value.status is Isidle) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.biggest.height > 700) {
                    return SingleChildScrollView(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: IsiUpload(
                          judul: judul,
                          deskripsi: deskripsi,
                          uploadtap: () {
                            uploadtaps(judul.text, deskripsi.text);
                          },
                        ),
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: SizedBox(
                        height: 700,
                        width: MediaQuery.of(context).size.width,
                        child: IsiUpload(
                          judul: judul,
                          deskripsi: deskripsi,
                          uploadtap: () {
                            uploadtaps(judul.text, deskripsi.text);
                          },
                        ),
                      ),
                    );
                  }
                },
              );
            } else if (value.status is Iserror) {
              final messages = value.status as Iserror;
              return Center(
                child: AlertDialog(
                  title: const Text("error"),
                  content: Text(messages.message),
                  actions: [
                    TextButton(
                      onPressed: () {
                        value.setidle();
                      },
                      child: const Text("ok"),
                    ),
                  ],
                ),
              );
            } else if (value.status is Issuksesmessage) {
              return Center(
                child: AlertDialog(
                  title: const Text("Upload Berhasil"),
                  content: Text("Berhasil"),
                  actions: [
                    TextButton(
                      onPressed: () async{
                        await context.read<BeritaListNotifier>().fetchdatalistberita();
                        value.setidle();
                      },
                      child: const Text("ok"),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class IsiUpload extends StatelessWidget {
  final Function() uploadtap;
  final TextEditingController judul;
  final TextEditingController deskripsi;
  const IsiUpload({
    super.key,
    required this.judul,
    required this.deskripsi,
    required this.uploadtap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 10,
        children: [
          Text(
            "Upload Berita",
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          Expanded(
            flex: 2,
            child: TextField(
              controller: judul,
              minLines: null,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                label: const Text("Judul"),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: TextField(
              controller: deskripsi,
              minLines: null,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(
                label: const Text("Deskripsi"),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: OutlinedButton(
              onPressed: uploadtap,
              child: const Text("Upload"),
            ),
          ),
        ],
      ),
    );
  }
}
