import 'package:flutter/material.dart';
import '../viewmodel/access.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AccessViewModel viewModel = AccessViewModel();
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
    viewModel.loadEmployees().then((_) {
      setState(() {
        dataLoaded = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (dataLoaded)
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.employees.length,
                  itemBuilder: (context, index) {
                    final emp = viewModel.employees[index];
                    return ListTile(
                      title: Text("${emp.id} - ${emp.room}"),
                      subtitle: Text(
                        "Access: ${emp.accessLevel}, Time: "
                        "${emp.requestTime.hour}:${emp.requestTime.minute.toString().padLeft(2, '0')}",
                      ),
                    );
                  },
                ),
              )
            else
              const SizedBox(height: 0),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      dataLoaded = !dataLoaded;
                    });
                  },
                  child: Text(
                    dataLoaded ? "Hide Employee Data" : "Show Employee Data",
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      viewModel.simulateAccess();
                    });
                  },
                  child: const Text("Simulate Access"),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Flexible(
              fit: FlexFit.loose,
              child: viewModel.results.isNotEmpty
                  ? ListView.builder(
                      itemCount: viewModel.results.length,
                      itemBuilder: (context, index) {
                        final result = viewModel.results[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              "${result.employee.id} → ${result.granted ? "Granted" : "Denied"}",
                              style: TextStyle(
                                color: result.granted
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            subtitle: Text(
                              result.reason,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        "No results yet",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
