import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _amountOfGlassController = TextEditingController();
  List<WaterTrack> waterconsumelist = [];
  int totalamout= 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Water Consume Tracker',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.pinkAccent),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Total Water Consume',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '$totalamout',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               SizedBox(
                width: 50,
                child:TextField(
                  controller: _amountOfGlassController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    int amount = int.tryParse(_amountOfGlassController.text.trim()) ?? 1;
                    totalamout += amount;
                    WaterTrack waterTrack = WaterTrack(DateTime.now(),amount);
                    waterconsumelist.add(waterTrack);
                    setState(() {

                    });
                  },
                  child: const Text('Add')),
            ],
          ),
          Expanded(
              child:ListView.builder(
                itemCount: waterconsumelist.length,
                  itemBuilder: (context,index){
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      onLongPress: (){
                        showDialog(context: context, builder:(context)=>  SimpleDialog(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Do you want to delete'),
                                ElevatedButton(onPressed: (){
                                  setState(() {
                                    waterconsumelist.removeAt(index);
                                    int removeamount = waterconsumelist[index].noOfGlass;
                                    totalamout -= removeamount;
                                  });
                                  Navigator.pop(context);
                                  }, child:const Text('delete'))
                              ],
                            )
                          ],
                        ));
                      },
                      leading: CircleAvatar(
                        child: Text('${index+1}'),
                      ),
                      title: Text(DateFormat('HH:mm:ss  dd-MM-yyyy')
                          .format(waterconsumelist[index].time)),
                      trailing:  Text('${waterconsumelist[index].noOfGlass}'),
                    ),

                  );
              }
              )
          )
        ],
      ),
    );
  }
}
class WaterTrack{
  final DateTime time;
  final int noOfGlass;

  WaterTrack(this.time, this.noOfGlass);


}