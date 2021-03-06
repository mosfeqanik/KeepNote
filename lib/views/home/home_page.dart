import 'package:flutter/material.dart';
import 'package:keepnote/models/NoteBook_Provider/Home_Page_Provider.dart';
import 'package:keepnote/models/user.dart';
import 'package:keepnote/views/constants/constants.dart';
import 'package:keepnote/database/database_helper.dart';
import 'package:keepnote/models/note.dart';
import 'package:keepnote/views/drawer/drawer_page.dart';
import 'package:keepnote/views/commons/widgets/app_bar_title_widget.dart';
import 'package:keepnote/views/login/login_screen.dart';
import 'package:keepnote/views/note/note_add_page.dart';
import 'package:keepnote/views/note/note_update_page.dart';
import 'package:keepnote/views/commons/utils/custom_toast.dart';
import 'package:keepnote/views/commons/utils/share_pref.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = 'Mosfeq Anik';
  String _greeting;
  DatabaseHelper _db;
  bool isLoading;
  List<NoteBook> noteList;
  List<NoteBook> storeNoteList;
  String noData;

  @override
  void initState() {
    super.initState();
    noData = "No note available, add new";
    noteList = [];
    storeNoteList = [];
    isLoading = true;
    _db = DatabaseHelper();
    greetings();
    fetchNoteList();
    setPref();
  }

  void setPref() async {
    await Prefs.loadPref();
  }

  void greetings() {
    var timeOfDay = DateTime
        .now()
        .hour;
    if (timeOfDay >= 0 && timeOfDay < 6) {
      _greeting = 'Good Night';
    } else if (timeOfDay >= 0 && timeOfDay < 12) {
      _greeting = 'Good Morning';
    } else if (timeOfDay >= 12 && timeOfDay < 16) {
      _greeting = 'Good Afternoon';
    } else if (timeOfDay >= 16 && timeOfDay < 21) {
      _greeting = 'Good Evening';
    } else if (timeOfDay >= 21 && timeOfDay < 24) {
      _greeting = 'Good Night';
    }
  }

  Future<void> fetchNoteList() async {
    var providerHomePage = Provider.of<HomePageProvider>(
        context, listen: false);
    try {
      var notes = await _db.fetchNoteList();
      if (notes.length > 0) {
        Provider
            .of<HomePageProvider>(context, listen: false)
            .notebooks = notes;
        // setState(() {
        //   noteList.addAll(notes);
        //   storeNoteList.addAll(notes);
        //   isLoading = false;
        // });
        providerHomePage.isLoading = false;
      }
    } catch (error) {
      providerHomePage.isLoading = false;
      // setState(() {
      //   noteList = [];
      //   isLoading = false;
      // });
    }
  }

  Future<void> showMenuSelection(String value, int id, NoteBook mbook) async {
    switch (value) {
      case 'Delete':
        setState(() {
          isLoading = true;
        });
        deleteConfirmationAlertBox(id);
        break;
      case 'Edit':
        bool isUpdated = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return NoteUpdatePage(
              notebook: mbook,
            );
          }),
        );
        if (isUpdated) {
          setState(() {
            isLoading = true;
          });
          noteList = [];
          fetchNoteList();
        }
        break;
    }
  }

  void filterSearchResult(String query) {
    noteList.clear();
    if (query.isNotEmpty) {
      List<NoteBook> newList = [];
      for (NoteBook noteBook in storeNoteList) {
        if (noteBook.title.toLowerCase().contains(query.toLowerCase()) ||
            noteBook.content.toLowerCase().contains(query.toLowerCase()) ||
            noteBook.date.toLowerCase().contains(query.toLowerCase())) {
          newList.add(noteBook);
        }
      }
      if (newList.length <= 0) {
        setState(() {
          noData = "No data found";
        });
      } else {
        setState(() {
          noteList.addAll(newList);
        });
      }
    } else {
      setState(() {
        noteList.addAll(storeNoteList);
      });
    }
  }

  void onDelete(int id) async {
    int isDeleted = await _db.deleteNote(id);
    if (isDeleted == 1) {
      CustomToast.toast('Note deleted');
      setState(() {
        isLoading = true;
      });
      showList();
    } else {
      CustomToast.toast('Note not deleted');
      setState(() {
        isLoading = false;
      });
    }
  }

  void showList() {
    noteList = [];
    fetchNoteList();
    Navigator.pop(context);
  }

  void deleteConfirmationAlertBox(int id) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Delete ALERT",
      desc: "Do You want to delete this Note?",
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => onDelete(id),
          color: Colors.teal,
        ),
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => showList(),
          color: Colors.red,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(right: 20, bottom: 20),
        child: FloatingActionButton(
            elevation: 0.0,
            child: Icon(Icons.add),
            backgroundColor: qColorPrimary,
            onPressed: () async {
              bool isAdded = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return NoteAddPage();
                }),
              );
              if (isAdded == true) {
                setState(() {
                  noteList = [];
                  isLoading = true;
                });
                fetchNoteList();
              }
            }),
      ),
      body: Scaffold(
          appBar: AppBar(
            title: AppBarTitleWidget(
              title: 'keep',
              subTitle: 'Note',
            ),
          ),
          drawer: Drawer(
            child: DrawerPage(),
          ),
          body: Consumer<HomePageProvider>(
            builder: (_, provider, ___) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Prefs.clearPref();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                        (route) => false);
                              },
                              child:Icon(
                                Icons.menu_book,
                                size: 40,
                              )
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Hello, ' +name,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            _greeting != null
                                ? Text(
                              _greeting,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontFamily: 'NunitoSans',
                                fontWeight: FontWeight.w400,
                              ),
                            )
                                : Container(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 0, bottom: 0, left: 15, right: 15),
                              height: 55,
                              child: TextField(
                                onChanged: (value) {
                                  filterSearchResult(value);
                                },
                                // controller: _editingController,
                                decoration: InputDecoration(
                                  labelText: 'search by title...',
                                  prefixIcon: Icon(Icons.search),
                                  fillColor: qColorLight,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                      borderSide: BorderSide(
                                          color: qColorPrimary)),
                                  filled: true,
                                  contentPadding: EdgeInsets.only(
                                      bottom: 10.0, left: 10.0, right: 10.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            !provider.isLoading
                                ? provider.notebooks.contains(null) ||
                                provider.notebooks.length <= 0
                                ? Container(
                                child: Center(
                                    child:
                                    Text("No note available, add new")))
                                : ListView.separated(
                              separatorBuilder: (context, index) =>
                                  SizedBox(
                                    height: 5,
                                  ),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: provider.notebooks.length,
                              itemBuilder: (context, index) {
                                return noteListItem(provider.notebooks[index]);
                              },
                            )
                                : Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    qColorPrimary),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
      ),
    );
  }

  Padding noteListItem(NoteBook noteBook) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: qColorLight,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      noteBook.title,
                      style: Theme
                          .of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      noteBook.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme
                          .of(context)
                          .textTheme
                          .subtitle2,
                    ),
                    Text(
                      noteBook.date,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText2,
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.more_vert),
                onSelected: (value) {
                  showMenuSelection(value, noteBook.id, noteBook);
                },
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                      value: 'Edit',
                      child: ListTile(
                          leading: Icon(Icons.edit), title: Text('Update'))),
                  const PopupMenuItem<String>(
                      value: 'Delete',
                      child: ListTile(
                          leading: Icon(Icons.delete), title: Text('Delete'))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
