import 'package:bar_client/service/models/broadcast/broadcast_model_request.dart';
import 'package:bar_client/service/models/broadcast/broadcast_model_response.dart';
import 'package:bar_client/service/providers/broadcast_provider.dart';
import 'package:bar_client/service/safe_request/safe_request.dart';

class BroadcastService {
  final BroadcastProvider _broadcastProvider;

  BroadcastService({
    required BroadcastProvider broadcastProvider,
  }) : _broadcastProvider = broadcastProvider;

  Future<List<BroadcastModelResponse>> getBroadcasts() async {
    return safeRequest(_broadcastProvider.getBroadCasts);
  }

  Future<void> deleteBroadcast(int id) async {
    await safeRequest(() => _broadcastProvider.deleteBroadcast(id));
  }

  Future<void> createBroadcast({
    required BroadcastModelRequest broadcast,
  }) async {
    await safeRequest(() => _broadcastProvider.createBroadcast(broadcast));
  }

  Future<void> updateBroadcast({
    required BroadcastModelResponse broadcast,
  }) async {
    await safeRequest(
      () => _broadcastProvider.updateBroadcast(
        BroadcastModelRequest(
          name: broadcast.name,
          dateTime: broadcast.dateTime,
          description: broadcast.description,
        ),
        broadcast.id,
      ),
    );
  }
}
