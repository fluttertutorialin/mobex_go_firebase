import 'package:mobex_go/model/multiple_upload.dart';
import 'package:bloc/bloc.dart';
import 'multiple_upload_event.dart';
import 'multiple_upload_state.dart';

class MultipleUploadBloc
    extends Bloc<MultipleUploadEvent, MultipleUploadState> {
  void multipleUploadParam(multipleUploadParam) {
    dispatch(MultipleUploadParam(multipleUploadParam: multipleUploadParam));
  }

  void multipleUploadRemove(uId) {
    dispatch(RemoveId(uId: uId));
    dispatch(MultipleUploadRemove());
  }

  void multipleUploadClear() {
    dispatch(MultipleUploadClear());
  }

  void ascImageUpload(callback) {
    dispatch(ASCImageUpload(callback: callback));
  }

  @override
  MultipleUploadState get initialState => MultipleUploadState.initial();

  @override
  Stream<MultipleUploadState> mapEventToState(
      MultipleUploadEvent event) async* {
    if (event is MultipleUploadParam) {
      currentState.multipleUploadList.add(event.multipleUploadParam);
      if( currentState.multipleUploadList.length != 1)
        {
          List<MultipleUpload> removeAfterList = currentState.multipleUploadList;
          removeAfterList.removeWhere((item) => item.uId == '0');

          currentState.multipleUploadList.add(MultipleUpload(file: null, uId: '0'));
        }
      yield currentState.copyWith(multipleUploadList: currentState.multipleUploadList);
    }

    if (event is RemoveId) {
      yield currentState.copyWith(removeId: event.uId);
    }

    if (event is MultipleUploadRemove) {
      List<MultipleUpload> removeAfterList = currentState.multipleUploadList;
      removeAfterList.removeWhere((item) => item.uId == currentState.removeId);
      yield currentState.copyWith(removeId: null, multipleUploadList: removeAfterList);
    }

    if (event is MultipleUploadClear) {
      List<MultipleUpload> removeAfterList = new List();
      yield currentState.copyWith(removeId: null, multipleUploadList: removeAfterList);
    }

    if (event is ASCImageUpload) {
      List<MultipleUpload> selectImageList = currentState.multipleUploadList;
      selectImageList.length == 1
          ? event.callback(null)
          : event.callback(selectImageList);
    }
  }
}
