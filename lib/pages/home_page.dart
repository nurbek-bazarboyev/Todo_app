import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:module8/services/auth/auth_service.dart';
import 'package:flutter/cupertino.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  void signOut(){
    AuthService().signOut();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(child: Text("To Do",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 28),)),
        actions: [
          IconButton(onPressed: signOut, icon: Icon(Icons.logout,color: Colors.white,size: 35,))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tasks').orderBy('task_deadline').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
                itemCount: docs.length ?? 0,
                itemBuilder: (context, index) {
                  final doc = docs[index].data();
                  Timestamp data = doc['task_deadline'];
                  return ListTile(
                    leading: Text(
                      "${index + 1}.", style: TextStyle(fontSize: 16),),
                    title: Text(doc['task_name']),
                    subtitle: Text("${data.toDate().day}.${data.toDate().month}.${data.toDate().year}"),
                    trailing: IconButton(onPressed: () {
                      FirebaseFirestore.instance.collection("tasks").doc(docs[index].id).delete();
                    },
                        icon: Icon(Icons.delete, color: Colors.red,)),
                  );
                });
          }
          return Center(child: Text("No data"),);
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, builder: (context){
            return CreateTodoList();
          });
        },
        child: Icon(CupertinoIcons.plus),
      ),
    );
  }
 
}


class CreateTodoList extends StatefulWidget {
  const CreateTodoList({super.key,});

  @override
  State<CreateTodoList> createState() => _CreateTodoListState();
}

class _CreateTodoListState extends State<CreateTodoList> {
  late final TextEditingController controller;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  DateTime? selectedTime;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Task"),
      contentPadding: EdgeInsets.all(15),
      actions:isLoading ?
      [
        Center(child:CircularProgressIndicator.adaptive(),)
      ] :
      [
        TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Cancel",style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.w600),)),
        TextButton(onPressed: ()async{

          if(controller.text.isEmpty || selectedTime == null){
            return;
          }
          setState(() {
            isLoading = true;
          });
          Map<String,dynamic> data = {
            'task_name':controller.text,
            'task_deadline':selectedTime
          };
          await FirebaseFirestore.instance.collection('tasks').add(data);
          setState(() {
            isLoading = false;
          });
          Navigator.pop(context);
        }, child: Text("Create",style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.w600),))
      ],
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
                label: Text("Enter Task"),
                border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 15,),
          selectedTime != null ? Text("${selectedTime!.day}.${selectedTime!.month}.${selectedTime!.year}") : ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      )
                  )),
              onPressed: ()async{
                selectedTime = await showDatePicker(context: context,initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2025));
                setState(() {

                });
              },
              child: Text("Choose date",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),))

        ],
      ),
    );
  }
}
