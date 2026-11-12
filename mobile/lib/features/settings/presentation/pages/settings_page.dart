import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_pocky/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:my_pocky/core/utils/validators.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _name = TextEditingController();
  final _business = TextEditingController();
  final _currency = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _wasUpdating = false;

  @override
  void initState() {
    super.initState();
    _syncFromState(context.read<AuthBloc>().state);
  }

  void _syncFromState(AuthState state) {
    if (state is AuthAuthenticated) {
      _name.text = state.user.name;
      _business.text = state.user.businessName ?? '';
      _currency.text = state.user.currency;
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _business.dispose();
    _currency.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is AuthAuthenticated) {
              if (_wasUpdating && !state.isUpdating) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile saved')),
                );
                _syncFromState(state);
              }
              _wasUpdating = state.isUpdating;
            }
          },
          builder: (context, state) {
            final isUpdating =
                state is AuthAuthenticated && state.isUpdating;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _name,
                      decoration:
                          const InputDecoration(labelText: 'Name'),
                      validator: Validators.required,
                      enabled: !isUpdating,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _business,
                      decoration: const InputDecoration(
                          labelText: 'Business Name'),
                      enabled: !isUpdating,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _currency,
                      decoration:
                          const InputDecoration(labelText: 'Currency'),
                      enabled: !isUpdating,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: isUpdating
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                _wasUpdating = true;
                                context.read<AuthBloc>().add(
                                      AuthProfileUpdateRequested({
                                        'name': _name.text.trim(),
                                        'businessName':
                                            _business.text.trim(),
                                        'currency':
                                            _currency.text.trim(),
                                      }),
                                    );
                              }
                            },
                      child: isUpdating
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Save'),
                    ),
                    const SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: isUpdating
                          ? null
                          : () async {
                              final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Log out'),
                                  content: const Text(
                                      'Are you sure you want to log out?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(false),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(true),
                                      child: const Text('Log out'),
                                    ),
                                  ],
                                ),
                              );
                              if (confirmed == true && context.mounted) {
                                context
                                    .read<AuthBloc>()
                                    .add(AuthLogoutRequested());
                                context.go('/login');
                              }
                            },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}