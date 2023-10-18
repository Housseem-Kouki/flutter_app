import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:url_launcher/url_launcher.dart';

class Statistique extends StatefulWidget {
  const Statistique({Key? key}) : super(key: key);

  @override
  _Statistique createState() => _Statistique();
}

class ChartDataPoint {
  final String month;
  final int value;

  ChartDataPoint(this.month, this.value);
}

class _Statistique extends State<Statistique> {
  final GlobalKey _chartKey = GlobalKey();

  List<ChartDataPoint> _createChartData() {
    final data = [
      ChartDataPoint('Jan', 5),
      ChartDataPoint('Feb', 25),
      ChartDataPoint('Mar', 100),
      // Ajoutez les données supplémentaires ici
    ];

    return data;
  }

  Future<void> exportChartToPDF() async {
    final RenderRepaintBoundary boundary =
    _chartKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final Uint8List bytes = byteData!.buffer.asUint8List();

    final pdf = pw.Document();
    final pdfImage = pw.Image(pw.MemoryImage(bytes));
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(child: pdfImage);
    }));

    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/chart.pdf';
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    await openFile(file);
  }

  Future<void> openFile(File file) async {
    if (await file.exists()) {
      final filePath = file.path;
      if (Platform.isIOS) {
        await launch('file://$filePath', forceSafariVC: false);
      } else {
        await launch(filePath);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistique 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: _chartKey,
              child: Container(
                width: 400,
                height: 300,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries>[
                    ColumnSeries<ChartDataPoint, String>(
                      dataSource: _createChartData(),
                      xValueMapper: (ChartDataPoint data, _) => data.month,
                      yValueMapper: (ChartDataPoint data, _) => data.value,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: exportChartToPDF,
              child: Text('Export PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
