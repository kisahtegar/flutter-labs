import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;
  Barcode? barcode;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrViewController!.pauseCamera();
    }
    qrViewController!.resumeCamera();
  }

  QRView buildQrView() => QRView(
    key: qrKey,
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderColor: Theme.of(context).primaryColor,
      borderRadius: 10,
      borderLength: 20,
      borderWidth: 10,
      cutOutSize: MediaQuery.of(context).size.width * 0.8,
    ),
  );

  void onQRViewCreated(QRViewController controller) {
    setState(() => qrViewController = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() => barcode = scanData);
    });
  }

  Container buildResult() => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white24,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text(
      barcode != null ? 'Result: ${barcode!.code}' : 'Scan a QR code',
      maxLines: 3,
    ),
  );

  Container buildControlButtons() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white24,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: FutureBuilder<bool?>(
            future: qrViewController?.getFlashStatus(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return Icon(
                  snapshot.data! ? Icons.flash_on : Icons.flash_off,
                  color: Colors.white,
                );
              } else {
                return Container();
              }
            },
          ),
          onPressed: () async {
            await qrViewController?.toggleFlash();
            setState(() {});
          },
        ),
        IconButton(
          icon: FutureBuilder(
            future: qrViewController?.getCameraInfo(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return Icon(Icons.flip_camera_ios, color: Colors.white);
              } else {
                return Container();
              }
            },
          ),
          onPressed: () async {
            await qrViewController?.flipCamera();
            setState(() {});
          },
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQrView(),
            Positioned(bottom: 10, child: buildResult()),
            Positioned(top: 10, child: buildControlButtons()),
          ],
        ),
      ),
    );
  }
}
