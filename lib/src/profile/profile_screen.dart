import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  Widget _buildForm(GlobalKey<FormState> formKey) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nome do filho(a)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, preencha este campo';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Idade'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, preencha este campo';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // Process data
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text('Salvar', style: TextStyle(fontSize: 16),),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleProgressIndicator(
      {required int complete, required int all,}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: CircularProgressIndicator(
            value: complete/all,
            strokeWidth: 10,
            backgroundColor: Theme.of(context).primaryColorLight.withOpacity(0.5),
            valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor),
          ),
        ),
        Positioned(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 48,
                    color: Colors.black,
                  ),
              children: [
                TextSpan(text: '$complete'),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Text(
                      '/$all',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildForm(_formKey),
        Expanded(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'No dia'),
                    Tab(text: 'Na semana'),
                    Tab(text: 'No mês'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildCircleProgressIndicator(complete: 2, all: 3),
                      _buildCircleProgressIndicator(complete: 1, all: 2),
                      _buildCircleProgressIndicator(complete: 12, all: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
