import 'package:flutter/material.dart';
import 'package:workout/components/heat_map.dart';
import 'package:workout/data/workout_data.dart';
import 'package:provider/provider.dart';
import 'package:workout/pages/WorkoutPage.dart';


class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {

  @override
  void initState() {
    super.initState();
    Provider.of<WorkoutData>(context,listen: false).initalizeWorkoutList();
  }
  final newWorkoutNameController = TextEditingController();

  void creatNewWorkout() {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("Creat new workout"),
              content: TextField(
                controller: newWorkoutNameController,
              ),
              actions: [
                MaterialButton(
                  onPressed: save,
                  child: Text("save"),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: Text("cancel"),
                ),
              ],
            ));
  }

  ///
  ///
  void goToWorkoutPage(String workoutName) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WorkoutPage(workoutName:workoutName)));
  }

  void save() {
    String newWorkoutName = newWorkoutNameController.text;
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
  }

  void clear() {
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
        builder: (context, value, child) =>
            Scaffold(
              backgroundColor: Colors.grey[500],
              appBar: AppBar(
                title: Text("Workout Tracker"),
              ),
              floatingActionButton: FloatingActionButton(
                  onPressed: creatNewWorkout, child: Icon(Icons.add)),
              body: ListView(
                children: [
                  MyHeatMap(datasets: value.heatMapDataset, startDataYYYMMDD: value.getStartDate()),
                  ListView.builder(
                    shrinkWrap: true,
                      itemCount: value
                          .getWorkoutList()
                          .length,
                      itemBuilder: (context, index) =>
                          ListTile(
                            title: Text(value.getWorkoutList()[index].name),
                            trailing:  IconButton(icon: Icon(Icons.arrow_forward),
                              onPressed: (){
                                goToWorkoutPage(value.getWorkoutList()[index].name);
                              },
                              //
                            ),
                          )),
                ],
              )
            ));
  }
}
