import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_travel_app/features.trip/data/datasources/trip_local_datasource.dart';
import 'package:flutter_travel_app/features.trip/data/models/trip_model.dart';
import 'package:flutter_travel_app/features.trip/data/repositories/trip_repository_impl.dart';
import 'package:flutter_travel_app/features.trip/domain/entities/trip.dart';
import 'package:flutter_travel_app/features.trip/domain/usescases/delete_trip.dart';
import 'package:flutter_travel_app/features.trip/domain/usescases/get_trips.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/repositories/trip_repository.dart';
import '../../domain/usescases/add_trip.dart';

final tripLocalDataSourceProvider = Provider<TripLocalDataSource>((ref){
  final Box<TripModel> tripBox = Hive.box('trips');
  return TripLocalDataSource(tripBox);
});

final tripRepositoryProvider = Provider<TripRepository>((ref){
  final localDataSource = ref.read(tripLocalDataSourceProvider);
  return TripRepositoryImpl(localDataSource);
});

final addTripProvider = Provider<AddTrip>((ref){
  final repository = ref.read(tripRepositoryProvider);
  return AddTrip(repository);
});

final getTripsProvider = Provider<GetTrips>((ref){
  final repository = ref.read(tripRepositoryProvider);
  return GetTrips(repository);
});

final deleteTripsProvider = Provider<DeleteTrip>((ref){
  final repository = ref.read(tripRepositoryProvider);
  return DeleteTrip(repository);
});

final tripListNotifierprovider = StateNotifierProvider<TripListNotifier, List<Trip>>((ref) => {
  final getTrips = ref.read(getTripsProvider);
  final addTrip = ref.read(addTripProvider);
  final deleteTrip = ref.read(deleteTripProvider);

  return TripListNotifier(getTrips, addTrip, deleteTrip);
});

class tripListNotifier extends StateNotifier<List<Trip>> {
  final GetTrips _getTrips;
  final AddTrip _addTrip;
  final DeleteTrip _deleteTrip;

  tripListNotifier(this._getTrips, this._addTrip, this._deleteTrip) : super([]);

  Future <void> addNewTrip(Trip trip) async {
    await _addTrip.call(trip);
  }

  Future <void> removeTrip(int tripId) async {
    await _deleteTrip.call(tripId);
  }

  Future <void> loadTrips() async {
    await _getTrips();
  }
}