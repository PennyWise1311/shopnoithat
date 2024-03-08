import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  List<Product> listProduct = [];
  List<ProductItem> listProductItem = [];
  List<Review> listReviewItem = [];
  List<Product> listNewArchiveProduct = [];
  List<Product> listTopSeller = [];
  List<Product> listReview = [];
  List<Product> listDiscount = [];
  List<Product> listProductByName = [];
  Product productCurrent = Product(name: '', img: '', id: '', description: '', rootPrice: 0, currentPrice: 0, categoryItemId: '', status: '', material: const {}, size: const {}, review: 0, sellest: 0, title: '', productItemList: const [], reviewList: const [], timestamp: DateTime.now());
  String id ='';

  // Get All Product
  Future<void> getProduct() async {
    List<Product> newList = [];
    List<Product> listDis = [];

    QuerySnapshot productSnapshot =
    await FirebaseFirestore.instance.collection("product").get();

    for (var doc in productSnapshot.docs) {

      List<ProductItem> proItemList = [];
      List<Review> reList = [];

      QuerySnapshot productItemSnapshot = await FirebaseFirestore.instance.collection('product').doc(doc.reference.id).collection('product-item').get();
      for(var pro in productItemSnapshot.docs) {
        var proItem = ProductItem(
          id: pro.reference.id,
          color: Map.from(pro['color']),
          img: List.from(pro["img"]),
        );

        proItemList.add(proItem);
      }
      listProductItem = proItemList;

      QuerySnapshot reviewItemSnapshot = await FirebaseFirestore.instance.collection('product').doc(doc.reference.id).collection('review').get();

      for(var re in reviewItemSnapshot.docs) {
        DateTime dt = (re['timestamp'] as Timestamp).toDate();
        var review = Review(
          id: re.reference.id,
          idOrder: re['idOrder'],
          idUser: re['idUser'],
          message: re['message'],
          img: List.from(re['img']),
          date: dt,
          service: Map.from(re['service']),
          star: double.parse(re['star'].toString()),
        );
        reList.add(review);
      }

      listReviewItem = reList;

      DateTime dtPro = (doc['timestamp'] as Timestamp).toDate();
      var product = Product(
        img: doc["img"],
        name: doc["name"],
        id: doc.reference.id,
        size: Map.from(doc["size"]),
        rootPrice: double.parse(doc["rootPrice"].toString()),
        currentPrice: double.parse(doc["currentPrice"].toString()),
        categoryItemId: doc["categoryItemId"].toString(),
        description: doc["description"].toString(),
        status: doc["status"].toString(),
        material: Map.from(doc["material"]),
        review: double.parse(doc["review"].toString()),
        sellest: double.parse(doc["sellest"].toString()),
        title: doc['title'],
        productItemList: proItemList,
        reviewList: reList,
        timestamp: dtPro,
      );
      newList.add(product);

      if(product.currentPrice != product.rootPrice) {
        listDis.add(product);
      }
    }

    listDiscount = listDis;
    listProduct = newList;
    notifyListeners();
  }

  // Get Product New Archive
  Future<void> getNewArchiveProduct() async {

    List<Product> newList = [];

    QuerySnapshot productSnapshot =
    await FirebaseFirestore.instance.collection('product').orderBy("timestamp", descending: true).limit(8).get();

    for (var doc in productSnapshot.docs) {

      List<ProductItem> proItemList = [];
      List<Review> reList = [];

      QuerySnapshot productItemSnapshot = await FirebaseFirestore.instance.collection('product').doc(doc.reference.id).collection('product-item').get();
      for(var pro in productItemSnapshot.docs) {
        var proItem = ProductItem(
          id: pro.reference.id,
          color: Map.from(pro['color']),
          img: List.from(pro["img"]),
        );

        proItemList.add(proItem);
      }
      listProductItem = proItemList;

      QuerySnapshot reviewItemSnapshot = await FirebaseFirestore.instance.collection('product').doc(doc.reference.id).collection('review').get();

      for(var re in reviewItemSnapshot.docs) {
        DateTime dt = (re['timestamp'] as Timestamp).toDate();
        var review = Review(
          id: re.reference.id,
          idOrder: re['idOrder'],
          idUser: re['idUser'],
          message: re['message'],
          img: List.from(re['img']),
          date: dt,
          service: Map.from(re['service']),
          star: double.parse(re['star'].toString()),
        );
        reList.add(review);
      }

      listReviewItem = reList;

      DateTime dtPro = (doc['timestamp'] as Timestamp).toDate();
      var product = Product(
        img: doc["img"],
        name: doc["name"],
        id: doc.reference.id,
        size: Map.from(doc["size"]),
        rootPrice: double.parse(doc["rootPrice"].toString()),
        currentPrice: double.parse(doc["currentPrice"].toString()),
        categoryItemId: doc["categoryItemId"].toString(),
        description: doc["description"].toString(),
        status: doc["status"].toString(),
        material: Map.from(doc["material"]),
        review: double.parse(doc["review"].toString()),
        sellest: double.parse(doc["sellest"].toString()),
        title: doc['title'],
        productItemList: proItemList,
        reviewList: reList,
        timestamp: dtPro,
      );
      newList.add(product);
    }

    listNewArchiveProduct = newList;
    notifyListeners();
  }

  // Get Product Top Seller
  Future<void> getTopSeller() async {
    List<Product> newList = [];

    QuerySnapshot productSnapshot =
    await FirebaseFirestore.instance.collection('product').orderBy("sellest", descending: true).limit(8).get();

    for (var doc in productSnapshot.docs) {

      List<ProductItem> proItemList = [];
      List<Review> reList = [];

      QuerySnapshot productItemSnapshot = await FirebaseFirestore.instance.collection('product').doc(doc.reference.id).collection('product-item').get();
      for(var pro in productItemSnapshot.docs) {
        var proItem = ProductItem(
          id: pro.reference.id,
          color: Map.from(pro['color']),
          img: List.from(pro["img"]),
        );

        proItemList.add(proItem);
      }
      listProductItem = proItemList;

      QuerySnapshot reviewItemSnapshot = await FirebaseFirestore.instance.collection('product').doc(doc.reference.id).collection('review').get();

      for(var re in reviewItemSnapshot.docs) {
        DateTime dt = (re['timestamp'] as Timestamp).toDate();
        var review = Review(
          id: re.reference.id,
          idOrder: re['idOrder'],
          idUser: re['idUser'],
          message: re['message'],
          img: List.from(re['img']),
          date: dt,
          service: Map.from(re['service']),
          star: double.parse(re['star'].toString()),
        );
        reList.add(review);
      }

      listReviewItem = reList;

      DateTime dtPro = (doc['timestamp'] as Timestamp).toDate();
      var product = Product(
        img: doc["img"],
        name: doc["name"],
        id: doc.reference.id,
        size: Map.from(doc["size"]),
        rootPrice: double.parse(doc["rootPrice"].toString()),
        currentPrice: double.parse(doc["currentPrice"].toString()),
        categoryItemId: doc["categoryItemId"].toString(),
        description: doc["description"].toString(),
        status: doc["status"].toString(),
        material: Map.from(doc["material"]),
        review: double.parse(doc["review"].toString()),
        sellest: double.parse(doc["sellest"].toString()),
        title: doc['title'],
        productItemList: proItemList,
        reviewList: reList,
        timestamp: dtPro,
      );
      newList.add(product);
    }

    listTopSeller = newList;
    notifyListeners();
  }

  // Get Product Top Seller
  Future<void> getReview() async {
    List<Product> newList = [];

    QuerySnapshot productSnapshot =
    await FirebaseFirestore.instance.collection('product').orderBy("review", descending: true).limit(8).get();

    for (var doc in productSnapshot.docs) {

      List<ProductItem> proItemList = [];
      List<Review> reList = [];

      QuerySnapshot productItemSnapshot = await FirebaseFirestore.instance.collection('product').doc(doc.reference.id).collection('product-item').get();
      for(var pro in productItemSnapshot.docs) {
        var proItem = ProductItem(
          id: pro.reference.id,
          color: Map.from(pro['color']),
          img: List.from(pro["img"]),
        );

        proItemList.add(proItem);
      }
      listProductItem = proItemList;

      QuerySnapshot reviewItemSnapshot = await FirebaseFirestore.instance.collection('product').doc(doc.reference.id).collection('review').get();

      for(var re in reviewItemSnapshot.docs) {
        DateTime dt = (re['timestamp'] as Timestamp).toDate();
        var review = Review(
          id: re.reference.id,
          idOrder: re['idOrder'],
          idUser: re['idUser'],
          message: re['message'],
          img: List.from(re['img']),
          date: dt,
          service: Map.from(re['service']),
          star: double.parse(re['star'].toString()),
        );
        reList.add(review);
      }

      listReviewItem = reList;

      DateTime dtPro = (doc['timestamp'] as Timestamp).toDate();
      var product = Product(
        img: doc["img"],
        name: doc["name"],
        id: doc.reference.id,
        size: Map.from(doc["size"]),
        rootPrice: double.parse(doc["rootPrice"].toString()),
        currentPrice: double.parse(doc["currentPrice"].toString()),
        categoryItemId: doc["categoryItemId"].toString(),
        description: doc["description"].toString(),
        status: doc["status"].toString(),
        material: Map.from(doc["material"]),
        review: double.parse(doc["review"].toString()),
        sellest: double.parse(doc["sellest"].toString()),
        title: doc['title'],
        productItemList: proItemList,
        reviewList: reList,
        timestamp: dtPro,
      );
      newList.add(product);
    }

    listReview = newList;
    notifyListeners();
  }

  Future<void> getProductItem(String id) async {

    List<ProductItem> newListItem = [];

    CollectionReference product = FirebaseFirestore.instance.collection("product");

    QuerySnapshot productSnapshotItem = await product.doc(id).collection('product-item').get();

    for (var doc in productSnapshotItem.docs) {
      var proItem = ProductItem(
        id: doc.reference.id,
        color: Map.from(doc['color']),
        img: List.from(doc["img"]),
      );

      newListItem.add(proItem);
    }

    listProductItem = newListItem;
    notifyListeners();
  }

  Future<void> getProductReview(String id) async {

    List<Review> newListItem = [];

    CollectionReference product = FirebaseFirestore.instance.collection("product");

    QuerySnapshot productSnapshotItem = await product.doc(id).collection('review').get();

    for (var doc in productSnapshotItem.docs) {
      DateTime dt = (doc['timestamp'] as Timestamp).toDate();
      var review = Review(
        id: doc.reference.id,
        idOrder: doc['idOrder'],
        idUser: doc['idUser'],
        message: doc['message'],
        img: List.from(doc['img']),
        date: dt,
        service: Map.from(doc['service']),
        star: double.parse(doc['star'].toString()),
      );

      newListItem.add(review);
    }
    listReviewItem = newListItem;
    notifyListeners();
  }

  Future<void> getProductByID(String id) async {

    DocumentSnapshot productSnapshot =
    await FirebaseFirestore.instance.collection("product").doc(id).get();

    getProductItem(productSnapshot.reference.id);
    getProductItem(productSnapshot.reference.id);

    DateTime dtPro = (productSnapshot['timestamp'] as Timestamp).toDate();
    var product = Product(
      img: productSnapshot["img"],
      name: productSnapshot["name"],
      id: productSnapshot.reference.id,
      size: Map.from(productSnapshot["size"]),
      rootPrice: double.parse(productSnapshot["rootPrice"].toString()),
      currentPrice: double.parse(productSnapshot["currentPrice"].toString()),
      categoryItemId: productSnapshot["categoryItemId"].toString(),
      description: productSnapshot["description"].toString(),
      status: productSnapshot["status"].toString(),
      material: Map.from(productSnapshot["material"]),
      review: double.parse(productSnapshot["review"].toString()),
      sellest: double.parse(productSnapshot["sellest"].toString()),
      title: productSnapshot['title'],
      productItemList: getListProductItem,
      reviewList: getListReviewProductItem,
      timestamp: dtPro,
    );
    productCurrent = product;
    notifyListeners();
  }

  Future<void> getProductByName(String query) async {
    List<Product> newList = [];

    QuerySnapshot productSnapshot =
    await FirebaseFirestore.instance.collection("product").where('name',isEqualTo:query).get();

    for (var doc in productSnapshot.docs) {

      List<ProductItem> proItemList = [];
      List<Review> reList = [];

      QuerySnapshot productItemSnapshot = await FirebaseFirestore.instance.collection('product').doc(doc.reference.id).collection('product-item').get();
      for(var pro in productItemSnapshot.docs) {
        var proItem = ProductItem(
          id: pro.reference.id,
          color: Map.from(pro['color']),
          img: List.from(pro["img"]),
        );

        proItemList.add(proItem);
      }
      listProductItem = proItemList;

      QuerySnapshot reviewItemSnapshot = await FirebaseFirestore.instance.collection('product').doc(doc.reference.id).collection('review').get();

      for(var re in reviewItemSnapshot.docs) {
        DateTime dt = (re['timestamp'] as Timestamp).toDate();
        var review = Review(
          id: re.reference.id,
          idOrder: re['idOrder'],
          idUser: re['idUser'],
          message: re['message'],
          img: List.from(re['img']),
          date: dt,
          service: Map.from(re['service']),
          star: double.parse(re['star'].toString()),
        );
        reList.add(review);
      }

      listReviewItem = reList;

      DateTime dtPro = (doc['timestamp'] as Timestamp).toDate();
      var product = Product(
        img: doc["img"],
        name: doc["name"],
        id: doc.reference.id,
        size: Map.from(doc["size"]),
        rootPrice: double.parse(doc["rootPrice"].toString()),
        currentPrice: double.parse(doc["currentPrice"].toString()),
        categoryItemId: doc["categoryItemId"].toString(),
        description: doc["description"].toString(),
        status: doc["status"].toString(),
        material: Map.from(doc["material"]),
        review: double.parse(doc["review"].toString()),
        sellest: double.parse(doc["sellest"].toString()),
        title: doc['title'],
        productItemList: proItemList,
        reviewList: reList,
        timestamp: dtPro,
      );
      newList.add(product);
    }

    listProductByName = newList;
    notifyListeners();
  }


  Future<void> addReview(Review review , String idProduct) async {
    await FirebaseFirestore.instance.collection('product').doc(idProduct).collection('review').doc(review.id).set(review.toMap());
  }

  List<Product> get getListProduct {
    //getProduct();
    return listProduct;
  }

  List<Product> get getListNewArchiveProduct {
    return listNewArchiveProduct;
  }

  List<Product> get getListTopSeller {
    return listTopSeller;
  }

  List<Product> get getListReview {
    return listReview;
  }

  List<Product> get getListDiscount {
    return listDiscount;
  }

  Product get getProductCurrent {
    return productCurrent;
  }

  List<ProductItem> get getListProductItem {
    //getProductItem(id);
    return listProductItem;
  }

  List<Review> get getListReviewProductItem {
    return listReviewItem;
  }

  List<Product> get getListProductByName {
    return listProductByName;
  }

}
