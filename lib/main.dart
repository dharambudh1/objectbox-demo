import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:objectbox_demo/model.dart';
import 'create.dart';
import 'object_box_helper.dart';
// created by `flutter pub run build_runner build`

class OB {
  static late ObjectBox objectBox;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OB.objectBox = await ObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ObjectBox Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Stream<List<Details>> streamDetails;

  @override
  void initState() {
    super.initState();
    streamDetails = OB.objectBox.getDetails();
  }

  @override
  void dispose() {
    OB.objectBox.store.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateEntry(
                  editMode: false,
                  streamDetails: streamDetails,
                  detailsValues: Details(
                    firstName: '',
                    lastName: '',
                    gender: '',
                    age: 0,
                  ),
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          child: StreamBuilder<List<Details>>(
            stream: streamDetails,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final detailsValues = snapshot.data!;
                return ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: detailsValues.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  commonRichTextWidget(
                                      label: 'ID number',
                                      value:
                                          detailsValues[index].id.toString()),
                                  commonRichTextWidget(
                                      label: 'First name',
                                      value: detailsValues[index].firstName),
                                  commonRichTextWidget(
                                      label: 'Last name',
                                      value: detailsValues[index].lastName),
                                  commonRichTextWidget(
                                      label: 'Age',
                                      value:
                                          detailsValues[index].age.toString()),
                                  commonRichTextWidget(
                                      label: 'Gender',
                                      value: detailsValues[index].gender),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateEntry(
                                      streamDetails: streamDetails,
                                      editMode: true,
                                      detailsValues: detailsValues[index],
                                    ),
                                  ),
                                ).whenComplete(() => setState((){}));
                              },
                              child: const Icon(Icons.edit),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                OB.objectBox.deleteDetail(detailsValues[index].id);
                              },
                              child: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget commonRichTextWidget({
    required String label,
    required String value,
  }) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      maxLines: 1,
      text: TextSpan(
        text: '$label: ',
        style: Theme.of(context).textTheme.bodyMedium,
        children: <TextSpan>[
          TextSpan(
            text: value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
