import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foody/widgets/navigator_widget.dart';
import 'package:foody/widgets/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class CheckOut extends StatefulWidget {
  final List e;
  final int sum;
  final int quantity;

  const CheckOut(
      {Key? key, required this.e, required this.sum, required this.quantity})
      : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  int? sum;
  int? quan;
  List? list;

  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference = firebaseDatabase.ref('users');

  final Completer<GoogleMapController> _googleMapController = Completer();
  late GoogleMapController _newGoogleMapController;
  late Position _currentPosition;

  String address = "";
  String userName = "";

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.762622, 106.660172),
    zoom: 14,
  );

  Set<Marker> _markers = {};

  @override
  void initState() {
    // TODO: implement initState
    sum = widget.sum;
    quan = widget.quantity;
    list = widget.e;
    getName();
    super.initState();
  }

  Future<void> getName() async {
    databaseReference.child(uid).get().then((v) {
      userName = v.child("name").value.toString();
    });
  }

  Future<void> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();
    LatLng latLng = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLng, zoom: 14);
    _newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    _markers.add(Marker(markerId: MarkerId('My location'), position: latLng));

    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placeMark = placeMarks[0];
    address = "${placeMark.street}, ${placeMark.subAdministrativeArea}";

    setState(() {});
  }

  Future<void> order() async {
    var tempDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    var tempID = generateRandomString();
    firebaseDatabase.ref('orders').child(uid).child(tempID).set({
      'orderID': tempID,
      'orderDate': tempDate,
      'orderSum': sum,
      'orderQuantity': quan,
      'userName': userName,
      'address': address.toString(),
      'orderFood': list,
    });
    await databaseReference.child(uid).child('cart').remove();
    int counter = 2;
    Navigator.of(context).popUntil((route) => counter-- <= 0);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Check out"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _googleMap(size),
                _info(size),
                _cart(),
              ],
            ),
          ),
          _total(),
        ],
      ),
    );
  }

  _googleMap(Size size) {
    return Container(
      width: size.width,
      height: 300,
      child: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: _markers,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _googleMapController.complete(controller);
          _newGoogleMapController = controller;
          getCurrentPosition();
        },
      ),
    );
  }

  _info(Size size) {
    return Container(
      width: size.width,
      height: 100,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Name: $userName",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Address: $address",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  _total() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
              child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white, border: Border.all(color: Colors.green)),
            height: 48,
            child: Text("Total: $sum",
                style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0)),
          )),
          Expanded(
              child: Container(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                order();
              },
              child: Text('Order'),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      //borderRadius: BorderRadius.circular(16),
                      ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  _cart() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: widget.e.length,
        itemBuilder: (context, index) {
          return SizedBox(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(widget.e
                          .elementAt(index)["food"]["image"]
                          .toString()),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              widget.e
                                  .elementAt(index)["food"]["name"]
                                  .toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                overflow: TextStyle().overflow,
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          TextWidget().default_price(
                              text: widget.e
                                  .elementAt(index)["food"]["price"]
                                  .toString(),
                              fontSize: 16),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16.0),
                      child: Row(
                        children: [
                          Text("Số lượng:"),
                          Container(
                            width: 30,
                            child: Center(
                              child: Text(
                                "${widget.e.elementAt(index)["quantity"]}",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
