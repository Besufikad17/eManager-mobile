import 'package:cleanarchdemo/domain/models/employee.dart';
import 'package:cleanarchdemo/presentation/components/card.dart';
import 'package:flutter/material.dart';

class EmployeeList extends StatelessWidget {
  const EmployeeList({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void _buildError(BuildContext context) {
    
  }

  Widget _buildLoaded(BuildContext context, List<Employee> employees) {
    return ListView.builder(
      itemCount: employees.length,
      itemBuilder: (BuildContext context, index) {
        return MyCard(image: employees[index].profilePictureUrl!, fullName: employees[index].toString());
      }
    );
  }
}