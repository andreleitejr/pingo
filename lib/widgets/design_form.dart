import 'package:flutter/material.dart';

class DesignForm extends StatefulWidget {
  const DesignForm({super.key, required this.inputs});

  final List<Widget> inputs;

  @override
  DesignFormState createState() {
    return DesignFormState();
  }
}

class DesignFormState extends State<DesignForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: widget.inputs,
      ),
    );
  }
}
