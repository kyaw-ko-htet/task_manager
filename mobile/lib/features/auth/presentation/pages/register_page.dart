import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile/core/utils/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  final _business = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _name, decoration: const InputDecoration(labelText: 'Name'), validator: Validators.required),
              const SizedBox(height: 12),
              TextFormField(controller: _email, decoration: const InputDecoration(labelText: 'Email'), validator: Validators.email),
              const SizedBox(height: 12),
              TextFormField(controller: _password, decoration: const InputDecoration(labelText: 'Password'), obscureText: true, validator: Validators.required),
              const SizedBox(height: 12),
              TextFormField(controller: _business, decoration: const InputDecoration(labelText: 'Business Name (optional)')),
              const SizedBox(height: 24),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) return const CircularProgressIndicator();
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthRegisterRequested(
                              email: _email.text.trim(),
                              password: _password.text,
                              name: _name.text.trim(),
                              businessName: _business.text.trim().isEmpty ? null : _business.text.trim(),
                            ));
                      }
                    },
                    child: const Text('Register'),
                  );
                },
              ),
              TextButton(onPressed: () { if (context.canPop()) { context.pop(); } else { context.go('/login'); } }, child: const Text('Back to login')),
            ],
          ),
        ),
      ),
    );
  }
}
