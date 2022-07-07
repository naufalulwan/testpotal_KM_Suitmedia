import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/main_provider.dart';
import '../services/api_service.dart';
import 'second_screen.dart';

class ThirdScreen extends StatefulWidget {
  ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  ApiService service = ApiService();

  List<Data> listUser = [];

  int _page = 1;
  final int _limit = 6;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;

  late ScrollController _controller;

  getData() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    listUser = (await service.fetchDataUser(_page, _limit))!;
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  Future<void> _pullRefresh() async {
    listUser = (await service.fetchDataUser(_page = 1, _limit))!;
    setState(() {
      log(_page.toString());
      _hasNextPage = true;
    });
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 500) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      await Future.delayed(const Duration(seconds: 2));
      listUser.addAll((await service.fetchDataUser(_page += 1, _limit))!);

      setState(() {
        _isLoadMoreRunning = false;
        _hasNextPage = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MainProvider providerFunction = context.read<MainProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'Third Screen',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black45,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
            child: Stack(children: [
              ListView.builder(
                controller: _controller,
                itemCount: listUser.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      providerFunction.changeDataUser(
                          '${listUser[index].firstName!} ${listUser[index].lastName!}');
                      Navigator.of(context).pop();
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 31),
                      title: Text(
                        '${listUser[index].firstName!} ${listUser[index].lastName}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${listUser[index].email}'),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          '${listUser[index].avatar}',
                        ),
                        radius: 49,
                      ),
                    ),
                  );
                }),
              ),
              if (_isLoadMoreRunning == true)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ]),
          ),
        ),
      ),
    );
  }
}
