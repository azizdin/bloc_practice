//imports
//lists of employees
//stream controller
//stream sink getter
//constructor - add data; listen to changes
// core functions
//dispose
//import

import 'dart:async';
import 'Employee.dart';


class EmployeeBloc{

  //sink to add into pipe
  //stream to get data from pipe
  //pipe = data stream/flow

  //list of employee
  List<Employee> _employeeList = [
    Employee(1, "Employee one", 1000.0),
    Employee(2, "Employee two", 2000.0),
    Employee(3, "Employee three", 3000.0),
    Employee(4, "Employee four", 4000.0),
    Employee(5, "Employee five", 5000.0)
  ];

  //stream controller
  final _employeeListStreamController = StreamController<List<Employee>>();

  //increment and decrement controller
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  //stream & sink getter
  //stream
  Stream<List<Employee>> get employeeListStream => _employeeListStreamController.stream;
  //sink
  StreamSink<List<Employee>> get employeeListSink => _employeeListStreamController.sink;
  StreamSink<Employee> get employeeSalaryIncrement => _employeeSalaryIncrementStreamController.sink;
  StreamSink<Employee> get employeeSalaryDecrement => _employeeSalaryDecrementStreamController.sink;

  //constructor - add data; listen to changes
  EmployeeBloc(){
    _employeeListStreamController.add(_employeeList);

    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  //core functions
  _incrementSalary(Employee employee){
    double salary = employee.salary;
    double incrementedSalary = salary * 20/100;
    _employeeList[employee.id -1].salary = salary + incrementedSalary;

    employeeListSink.add(_employeeList);
  }
  _decrementSalary(Employee employee){
    double salary = employee.salary;
    double decrementedSalary = salary * 20/100;
    _employeeList[employee.id -1].salary = salary - decrementedSalary;

    employeeListSink.add(_employeeList);
  }

  //dispose
  void dispose(){
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeListStreamController.close();
  }
}

