import 'package:mytasks/features/cart/domain/entity/cart_item_entity.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generateCartPdf(List<CartItemEntity>items) async{
  final pdf= pw.Document();
  pdf.addPage(
    pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text("Invoice - Cart Summary",
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.Divider(),
          pw.SizedBox(height: 20),
          pw.TableHelper.fromTextArray(
              headers: ['Products',"Price","Quantity","Total"],
          data: items.map((item) => [

          item.product.title,
          "${item.product.price}\$",
          item.quantity.toString(),
          "${(item.product.price * item.quantity).toStringAsFixed(2)}\$"
          ]).toList(),
          ),
          pw.SizedBox(height: 20),
          pw.Divider(),
          pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(

          "Total Amount: ${items.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity)).toStringAsFixed(2)}\$",

          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),)),
        ],
      );
    }

    )
  );
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format)async =>pdf.save(),
  );
}