import 'package:flutter/material.dart';
import 'package:synk/core/app_colors.dart';

class AuthInput extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final IconData? icon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const AuthInput({
    super.key,
    this.label,
    this.placeholder,
    this.icon,
    this.isPassword = false,
    this.controller,
    this.errorText,
    this.onChanged,
  });

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: TextStyle(color: AppColors.borderSubtle, fontSize: 14),
          ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          obscureText: widget.isPassword ? _obscure : false,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            errorText: widget.errorText,
            prefixIcon: widget.icon != null
                ? Icon(
                    widget.icon,
                    color: widget.errorText != null
                        ? Colors.red.shade400
                        : AppColors.textTertiary,
                  )
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textTertiary,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.borderSubtle),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.borderSubtle),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.navyMid),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade400),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade600, width: 1.5),
            ),
            hintStyle: TextStyle(color: AppColors.textTertiary),
          ),
        ),
      ],
    );
  }
}
