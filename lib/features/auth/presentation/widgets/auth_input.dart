import 'package:flutter/material.dart';
import 'package:synk/core/app_colors.dart';

class AuthInput extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final IconData? icon;
  final bool isPassword;

  const AuthInput({
    super.key,
    this.label,
    this.placeholder,
    this.icon,
    this.isPassword = false,
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
          obscureText: widget.isPassword ? _obscure : false,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            prefixIcon: widget.icon != null
                ? Icon(widget.icon, color: AppColors.textTertiary)
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
            hintStyle: TextStyle(color: AppColors.textTertiary),
          ),
        ),
      ],
    );
  }
}
