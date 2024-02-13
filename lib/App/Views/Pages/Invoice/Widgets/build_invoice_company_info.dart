import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildInvoiceCompanyInfo extends StatelessWidget {
  final CrossAxisAlignment? crossAxisAlignment;
  final bool? inVerseColor;
  final String? companyName,
      ownerName,
      address,
      city,
      state,
      zip,
      country,
      phone,
      email;
  const BuildInvoiceCompanyInfo({
    super.key,
    this.crossAxisAlignment,
    this.companyName,
    this.ownerName,
    this.address,
    this.city,
    this.country,
    this.phone,
    this.email,
    this.state,
    this.zip,
    this.inVerseColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        if (companyName != null)
          Text(
            companyName!.toUpperCase(),
            style: TextStyle(
              fontSize: 6.sp,
              fontWeight: FontWeight.bold,
              color: inVerseColor == true ? Colors.white : Colors.black,
            ),
          ),
        if (ownerName != null)
          Text(
            ownerName!.capitalize!,
            style: TextStyle(
              fontSize: 5.sp,
              color: inVerseColor == true
                  ? Colors.white.withOpacity(0.7)
                  : Colors.black87,
            ),
          ),
        if (address != null)
          Text(
            address!.capitalize!,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 5.sp,
              color: inVerseColor == true
                  ? Colors.white.withOpacity(0.7)
                  : Colors.black87,
            ),
          ),
        if (city != null)
          Text(
            '${city!.capitalize!}, ${state?.capitalize ?? ''} ${zip ?? ''}',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 5.sp,
              color: inVerseColor == true
                  ? Colors.white.withOpacity(0.7)
                  : Colors.black87,
            ),
          ),
        if (country != null)
          Text(
            country!.capitalize!,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 5.sp,
              color: inVerseColor == true
                  ? Colors.white.withOpacity(0.7)
                  : Colors.black87,
            ),
          ),
        if (phone != null || email != null) SizedBox(height: 6.sp),
        if (phone != null)
          Text(
            phone!.toLowerCase(),
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 6.sp,
              color: inVerseColor == true
                  ? Colors.white.withOpacity(0.7)
                  : Colors.black87,
            ),
          ),
        if (email != null)
          Text(
            email!.toLowerCase(),
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 6.sp,
              color: inVerseColor == true
                  ? Colors.white.withOpacity(0.7)
                  : Colors.black87,
            ),
          ),
      ],
    );
  }
}
