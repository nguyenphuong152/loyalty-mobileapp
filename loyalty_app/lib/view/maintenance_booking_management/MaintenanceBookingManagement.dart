import 'package:flutter/material.dart';
import 'package:loyalty_app/view/maintenance_booking_management/components/body.dart';

class MaintenanceBookingManagementScreen extends StatefulWidget {
  @override
  _MaintenanceBookingManagementScreenState createState() =>
      _MaintenanceBookingManagementScreenState();
}

class _MaintenanceBookingManagementScreenState
    extends State<MaintenanceBookingManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
