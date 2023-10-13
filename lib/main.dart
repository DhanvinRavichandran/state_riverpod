import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:state_riverpod/settingspage.dart';
import 'theme_provider.dart';

void main() =>
  runApp(const ProviderScope(child:MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
final noteProvider = StateNotifierProvider<NotiferState,List<Notes>>((ref)=>NotiferState());

class Homepage extends ConsumerWidget{
  const Homepage({Key?key,}):super(key:key);

  @override
  Widget build(BuildContext context,WidgetRef ref){
    final notesList = ref.watch(noteProvider);
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("Important Notes"),),
      body: Column(children: [
        ElevatedButton(onPressed: (){
          showDialog(context: context, builder: (_){
            return AlertDialog(content:Column(children: [
              TextField(controller: titleController,decoration: InputDecoration(hintText: "title",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
              TextField(controller: contentController,decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),hintText: "Content"),),
            ],),
                actions: [
                  ElevatedButton(onPressed: (){
                    ref.read(noteProvider.notifier).addnotes(Notes(title: titleController.text, content: contentController.text));
                    Navigator.pop(context);
                  }, child: Text("Add Notes"))
                ],);
          });
        }, child: Text("Add Notes")),
        SizedBox(height: 20,),
        notesList.isEmpty?Text("Add Notes"):
            ListView.builder(itemCount:notesList.length,shrinkWrap: true,itemBuilder: (context,index){
             return ListTile(title: Text(notesList[index].title),
             subtitle:Text(notesList[index].content) ,
             trailing: IconButton(onPressed: (){
               ref.read(noteProvider.notifier).removenotes(notesList[index]);
             },icon: Icon(Icons.delete),),);

            })

      ],),
    );
  }
}



