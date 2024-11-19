import 'package:front_flutter_api_rest/src/services/api.dart';

class Providers {
  static Map<String, String> provider() {
    return {
      'categoriaListProvider': ConfigApi.buildUrl('/categoria'),
      'subCategoriaListProvider': ConfigApi.buildUrl('/subcategoria'),
      'productoListProvider': ConfigApi.buildUrl('/producto'),
      'loginProvider': ConfigApi.buildUrl('/auth/login'),
      'registerProvider': ConfigApi.buildUrl('/auth/create'),
      'userListProvider': ConfigApi.buildUrl('/auth/list'),
      'authUserListProvider': ConfigApi.buildUrl('/auth'),
      'imagenListProvider': ConfigApi.buildUrl('/imagen'),
      'clienteListProvider': ConfigApi.buildUrl('/cliente'),
      'voucherListProvider': ConfigApi.buildUrl('/voucher'),
      'voucherDetailListProvider': ConfigApi.buildUrl('/voucher_detalle'),
      'entregaListProvider': ConfigApi.buildUrl('/entrega'),
    };
  }
}
