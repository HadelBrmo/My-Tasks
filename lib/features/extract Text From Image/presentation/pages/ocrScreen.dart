import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytasks/features/extract%20Text%20From%20Image/presentation/bloc/ocrBloc.dart';
import 'package:mytasks/features/extract%20Text%20From%20Image/presentation/bloc/ocrEvent.dart';
import 'package:mytasks/features/extract%20Text%20From%20Image/presentation/bloc/ocrState.dart';

class OcrScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text( " استخراج النص من الصورة")),
      body: BlocConsumer<OcrBloc, OcrState>(
        listener: (context, state) {
          if (state is OcrFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          if (state is OcrLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is OcrSuccess) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: SelectableText(state.extractedText), 
            );
          }
          return Center(child: Text("قم باختيار صورة للبدء"));
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "camera",
            onPressed: () => context.read<OcrBloc>().add(PickImageAndExtractText(fromCamera: true)),
            child: Icon(Icons.camera_alt),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "gallery",
            onPressed: () => context.read<OcrBloc>().add(PickImageAndExtractText(fromCamera: false)),
            child: Icon(Icons.photo_library),
          ),
        ],
      ),
    );
  }
}