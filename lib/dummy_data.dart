import 'package:ecomm/features/shop/models/brand_category_model.dart';
import 'package:ecomm/features/shop/models/category_model.dart';
import 'package:ecomm/utils/constants/image_strings.dart';
import 'package:ecomm/utils/routes/routes.dart';
import 'package:flutter/material.dart';

import 'features/shop/models/banner_model.dart';
import 'features/shop/models/brand_model.dart';
import 'features/shop/models/product_attribute_model.dart';
import 'features/shop/models/product_category_model.dart';
import 'features/shop/models/product_model.dart';
import 'features/shop/models/product_variation_model.dart';

class DummyData {
  static final List<BrandModel> brands = [
    BrandModel(
        id: '1',
        image: TImages.nike,
        name: "Nike",
        isFeatured: true,
        productsCount: 50),
    BrandModel(
        id: '2',
        image: TImages.apple,
        name: "Apple",
        isFeatured: true,
        productsCount: 45),
    BrandModel(
        id: '3',
        image: TImages.samsung,
        name: "Samsung",
        isFeatured: true,
        productsCount: 65),
    BrandModel(
        id: '4',
        image: TImages.hm,
        name: "H&M",
        isFeatured: true,
        productsCount: 100),
    BrandModel(
        id: '5',
        image: TImages.marksAndSpencer,
        name: "Marks And Spencer",
        isFeatured: true,
        productsCount: 130),
    BrandModel(
        id: '6',
        image: TImages.jbl,
        name: "JBL",
        isFeatured: true,
        productsCount: 70),
    BrandModel(
        id: '7',
        image: TImages.titan,
        name: "Titan",
        isFeatured: true,
        productsCount: 30),
    BrandModel(
        id: '8',
        image: TImages.puma,
        name: "Puma",
        isFeatured: true,
        productsCount: 60),
  ];
  static final List<BannerModel> banners = [
    BannerModel(
        id: '1',
        imageUrl: TImages.phone_banner,
        targetScreen: TRoutes.allProducts,
        active: true,
        name: 'Mobiles banner'),
    BannerModel(
        id: '2',
        imageUrl: TImages.headphone_banner,
        targetScreen: TRoutes.allProducts,
        active: true,
        name: 'Headphones banner'),

    BannerModel(
        id: '3',
        imageUrl: TImages.shoes_banner,
        targetScreen: TRoutes.allProducts,
        active: false,
        name: 'Shoes banner'),
    BannerModel(
        id: '4',
        imageUrl: TImages.watch2_banner,
        targetScreen: TRoutes.allProducts,
        active: true,
        name: 'Watches banner'),
    BannerModel(
        id: '5',
        imageUrl: TImages.tshirt3_banner,
        targetScreen: TRoutes.allProducts,
        active: false,
        name: 'Cloths banner'),
    // BannerModel(
    //     id: '6',
    //     imageUrl: TImages.phone_banner,
    //     targetScreen: TRoutes.userAddress,
    //     active: false,
    //     name: 'Mobiles banner'),
    // BannerModel(
    //     id: '7',
    //     imageUrl: TImages.earbuds_banner,
    //     targetScreen: TRoutes.checkout,
    //     active: false,
    //     name: 'Headphones banner'),
  ];
  // List of all Categories
  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1', image: TImages.cloth, name: 'Cloths', isFeatured: true),
    CategoryModel(
        id: '2',
        image: TImages.headphone,
        name: 'Headphones',
        isFeatured: true),
    CategoryModel(
        id: '3', image: TImages.mobile, name: 'Mobiles', isFeatured: true),
    CategoryModel(
        id: '4', image: TImages.watch, name: 'Watches', isFeatured: true),
    CategoryModel(
        id: '5', image: TImages.shoe, name: 'Shoes', isFeatured: true),

    // Subcategories
    CategoryModel(
        id: '6',
        image: TImages.cloth,
        name: 'Jackets',
        parentId: '1',
        isFeatured: false),
    CategoryModel(
        id: '7',
        image: TImages.cloth,
        name: 'T-shirts',
        parentId: '1',
        isFeatured: false),

    CategoryModel(
        id: '8',
        image: TImages.headphone,
        name: 'Over-ear',
        parentId: '2',
        isFeatured: false),
    CategoryModel(
        id: '9',
        image: TImages.headphone,
        name: 'In-ear',
        parentId: '2',
        isFeatured: false),

    CategoryModel(
        id: '10',
        image: TImages.mobile,
        name: 'Android',
        parentId: '3',
        isFeatured: false),
    CategoryModel(
        id: '11',
        image: TImages.mobile,
        name: 'Iphones',
        parentId: '3',
        isFeatured: false),

    // Electronics
    CategoryModel(
        id: '12',
        image: TImages.watch,
        name: 'Analog',
        parentId: '4',
        isFeatured: false),
    CategoryModel(
        id: '13',
        image: TImages.watch,
        name: 'Digital',
        parentId: '4',
        isFeatured: false),

    // Clothes
    CategoryModel(
        id: '14',
        image: TImages.shoe,
        name: 'Jordans',
        parentId: '5',
        isFeatured: false),
    CategoryModel(
        id: '15',
        image: TImages.shoe,
        name: 'Puma',
        parentId: '5',
        isFeatured: false),
  ];
  // -- List of all Products
  static final List<ProductModel> products = [
    ProductModel(
      id: '001',
      title: 'Stylish Leather Jackets',
      stock: 15,
      price: 270.0,
      isFeatured: true,
      thumbnail: TImages.blackJacket,
      description:
          'A stylish leather jacket available in various colors and sizes, perfect for any occasion.',
      brand: BrandModel(
          id: '5',
          image: TImages.marksAndSpencer,
          name: "Marks And Spencer",
          isFeatured: true,
          productsCount: 130),
      images: [
        TImages.greyJacket,
        TImages.blackJacket,
        TImages.darkgreyJacket,
      ],
      salePrice: 240.0,
      sku: 'SLJ2024',
      categoryId: '1',
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Grey', 'Black', 'Dark Grey']),
        ProductAttributeModel(
            name: 'Size', values: ['Small', 'Medium', 'Large']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          image: TImages.greyJacket,
          stock: 12,
          price: 270.0,
          salePrice: 240.0,
          description:
              'Grey Leather Jacket in Small size, ideal for a sleek and modern look.',
          attributeValues: {'Color': 'Grey', 'Size': 'Small'},
        ),
        ProductVariationModel(
          id: '2',
          image: TImages.greyJacket,
          stock: 8,
          price: 265.0,
          salePrice: 230.0,
          description:
              'Grey Leather Jacket in Medium size, perfect for a classic appearance.',
          attributeValues: {'Color': 'Grey', 'Size': 'Medium'},
        ),
        ProductVariationModel(
          id: '3',
          image: TImages.greyJacket,
          stock: 5,
          price: 260.0,
          salePrice: 220.0,
          description:
              'Grey Leather Jacket in Large size, combines style with comfort.',
          attributeValues: {'Color': 'Grey', 'Size': 'Large'},
        ),
        ProductVariationModel(
          id: '4',
          image: TImages.blackJacket,
          stock: 10,
          price: 275.0,
          salePrice: 245.0,
          description:
              'Black Leather Jacket in Small size, featuring a sleek and elegant design.',
          attributeValues: {'Color': 'Black', 'Size': 'Small'},
        ),
        ProductVariationModel(
          id: '5',
          image: TImages.blackJacket,
          stock: 7,
          price: 280.0,
          salePrice: 250.0,
          description:
              'Black Leather Jacket in Medium size, a timeless classic with a modern touch.',
          attributeValues: {'Color': 'Black', 'Size': 'Medium'},
        ),
        ProductVariationModel(
          id: '6',
          image: TImages.blackJacket,
          stock: 6,
          price: 290.0,
          salePrice: 255.0,
          description:
              'Black Leather Jacket in Large size, for those who prefer a bold style.',
          attributeValues: {'Color': 'Black', 'Size': 'Large'},
        ),
        ProductVariationModel(
          id: '7',
          image: TImages.darkgreyJacket,
          stock: 4,
          price: 300.0,
          salePrice: 270.0,
          description:
              'Dark Grey Leather Jacket in Small size, offering a distinguished look.',
          attributeValues: {'Color': 'Dark Grey', 'Size': 'Small'},
        ),
        ProductVariationModel(
          id: '8',
          image: TImages.darkgreyJacket,
          stock: 3,
          price: 310.0,
          salePrice: 280.0,
          description:
              'Dark Grey Leather Jacket in Medium size, ideal for versatile wear.',
          attributeValues: {'Color': 'Dark Grey', 'Size': 'Medium'},
        ),
        ProductVariationModel(
          id: '9',
          image: TImages.darkgreyJacket,
          stock: 2,
          price: 320.0,
          salePrice: 290.0,
          description:
              'Dark Grey Leather Jacket in Large size, combining style and functionality.',
          attributeValues: {'Color': 'Dark Grey', 'Size': 'Large'},
        ),
      ],
      productType: 'ProductType.variable',
    ),
    ProductModel(
      id: '002',
      title: 'Stylish T-shirts',
      stock: 25,
      price: 180.0,
      isFeatured: true,
      thumbnail: TImages.blackTshirt,
      description:
          'A stylish T-shirt available in Grey, Black, and Light Pink, perfect for casual and comfortable wear.',
      brand: BrandModel(
          id: '4',
          image: TImages.hm,
          name: "H&M",
          isFeatured: true,
          productsCount: 100),
      images: [
        TImages.greyTshirt,
        TImages.blackTshirt,
        TImages.lightPinkTshirt,
      ],
      salePrice: 150.0,
      sku: 'STJ2024',
      categoryId: '1',
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Grey', 'Black', 'Light Pink']),
        ProductAttributeModel(
            name: 'Size', values: ['Small', 'Medium', 'Large']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          image: TImages.greyTshirt,
          stock: 20,
          price: 180.0,
          salePrice: 150.0,
          description: 'Grey T-shirt in Small size, perfect for casual wear.',
          attributeValues: {'Color': 'Grey', 'Size': 'Small'},
        ),
        ProductVariationModel(
          id: '2',
          image: TImages.greyTshirt,
          stock: 18,
          price: 175.0,
          salePrice: 145.0,
          description:
              'Grey T-shirt in Medium size, ideal for a comfortable fit.',
          attributeValues: {'Color': 'Grey', 'Size': 'Medium'},
        ),
        ProductVariationModel(
          id: '3',
          image: TImages.greyTshirt,
          stock: 10,
          price: 170.0,
          salePrice: 140.0,
          description:
              'Grey T-shirt in Large size, combines style and comfort.',
          attributeValues: {'Color': 'Grey', 'Size': 'Large'},
        ),
        ProductVariationModel(
          id: '4',
          image: TImages.blackTshirt,
          stock: 15,
          price: 185.0,
          salePrice: 155.0,
          description: 'Black T-shirt in Small size, stylish and sleek.',
          attributeValues: {'Color': 'Black', 'Size': 'Small'},
        ),
        ProductVariationModel(
          id: '5',
          image: TImages.blackTshirt,
          stock: 12,
          price: 190.0,
          salePrice: 160.0,
          description:
              'Black T-shirt in Medium size, a versatile wardrobe staple.',
          attributeValues: {'Color': 'Black', 'Size': 'Medium'},
        ),
        ProductVariationModel(
          id: '6',
          image: TImages.blackTshirt,
          stock: 8,
          price: 195.0,
          salePrice: 165.0,
          description: 'Black T-shirt in Large size, great for a bold look.',
          attributeValues: {'Color': 'Black', 'Size': 'Large'},
        ),
        ProductVariationModel(
          id: '7',
          image: TImages.lightPinkTshirt,
          stock: 10,
          price: 200.0,
          salePrice: 170.0,
          description: 'Light Pink T-shirt in Small size, adds a pop of color.',
          attributeValues: {'Color': 'Light Pink', 'Size': 'Small'},
        ),
        ProductVariationModel(
          id: '8',
          image: TImages.lightPinkTshirt,
          stock: 6,
          price: 205.0,
          salePrice: 175.0,
          description:
              'Light Pink T-shirt in Medium size, perfect for a fresh look.',
          attributeValues: {'Color': 'Light Pink', 'Size': 'Medium'},
        ),
        ProductVariationModel(
          id: '9',
          image: TImages.lightPinkTshirt,
          stock: 5,
          price: 210.0,
          salePrice: 180.0,
          description:
              'Light Pink T-shirt in Large size, combines comfort and style.',
          attributeValues: {'Color': 'Light Pink', 'Size': 'Large'},
        ),
      ],
      productType: 'ProductType.variable',
    ),
    ProductModel(
      id: '003',
      title: 'Apple Airpods Over-ear',
      stock: 18,
      price: 270.0,
      isFeatured: true,
      thumbnail: TImages.whiteAirpodsMax,
      description:
          'Apple Airpods with superior sound quality, available in Black, Green, and White, designed for in-ear comfort.',
      brand: BrandModel(
          id: '2',
          image: TImages.apple,
          name: "Apple",
          isFeatured: true,
          productsCount: 45),
      images: [
        TImages.blackAirpodsMax,
        TImages.greenAirpodsMax,
        TImages.whiteAirpodsMax,
      ],
      salePrice: 240.0,
      sku: 'AAPL2024',
      categoryId: '2',
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Black', 'Green', 'White']),
        ProductAttributeModel(name: 'Size', values: ['Over-ear']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          image: TImages.blackAirpodsMax,
          stock: 8,
          price: 280.0,
          salePrice: 250.0,
          description: 'Apple Airpods with black stylished color and comfort',
          attributeValues: {'Color': 'Black', 'Size': 'Over-ear'},
        ),
        ProductVariationModel(
          id: '2',
          image: TImages.whiteAirpodsMax,
          stock: 6,
          price: 280.0,
          salePrice: 250.0,
          description: 'Apple Airpods with White stylished color and comfort',
          attributeValues: {'Color': 'White', 'Size': 'Over-ear'},
        ),
        ProductVariationModel(
          id: '3',
          image: TImages.greenAirpodsMax,
          stock: 4,
          price: 285.0,
          salePrice: 260.0,
          description: 'Apple Airpods with Green stylished color and comfort',
          attributeValues: {'Color': 'Green', 'Size': 'Over-ear'},
        ),
      ],
      productType: 'ProductType.variable',
    ),
    ProductModel(
      id: '004',
      title: 'JBL Over-ear Headphones',
      stock: 25,
      price: 260.0,
      isFeatured: true,
      thumbnail: TImages.whiteJBL,
      description:
          'JBL over-ear headphones, offering rich sound and comfort, available in Red, Black, and White colors.',
      brand: BrandModel(
          id: '6',
          image: TImages.jbl,
          name: "JBL",
          isFeatured: true,
          productsCount: 70),
      images: [
        TImages.redJBL,
        TImages.blackJBL,
        TImages.whiteJBL,
      ],
      salePrice: 230.0,
      sku: 'JBL2024',
      categoryId: '2',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Red', 'Black', 'White']),
        ProductAttributeModel(name: 'Size', values: ['Over-ear']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          image: TImages.redJBL,
          stock: 10,
          price: 280.0,
          salePrice: 250.0,
          description: 'Red JBL with high quality sound and bass',
          attributeValues: {'Color': 'Red', 'Size': 'Over-ear'},
        ),
        ProductVariationModel(
          id: '2',
          image: TImages.blackJBL,
          stock: 12,
          price: 280.0,
          salePrice: 250.0,
          description: 'Black JBL with high quality sound and bass',
          attributeValues: {'Color': 'Black', 'Size': 'Over-ear'},
        ),
        ProductVariationModel(
          id: '3',
          image: TImages.whiteJBL,
          stock: 8,
          price: 285.0,
          salePrice: 260.0,
          description: 'White JBL with high quality sound and bass',
          attributeValues: {'Color': 'White', 'Size': 'Over-ear'},
        ),
      ],
      productType: 'ProductType.variable',
    ),
    ProductModel(
      id: '005',
      title: 'Android Samsung Galaxy S23 Ultra ',
      stock: 15,
      price: 1200.0,
      isFeatured: true,
      thumbnail: TImages.cremeSamsungS23,
      description:
          'Samsung Galaxy S23 Ultra, a high-performance Android smartphone available in Blue, Black, and Creme.',
      brand: BrandModel(
          id: '3',
          image: TImages.samsung,
          name: "Samsung",
          isFeatured: true,
          productsCount: 65),
      images: [
        TImages.blueSamsungS23,
        TImages.blackSamsungS23,
        TImages.cremeSamsungS23,
      ],
      salePrice: 1150.0,
      sku: 'SAMS2024',
      categoryId: '3',
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Blue', 'Black', 'Creme']),
        ProductAttributeModel(name: 'Size', values: ['Android']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '006',
      title: 'Iphones iPhone 14',
      stock: 12,
      price: 1100.0,
      isFeatured: true,
      thumbnail: TImages.purpleIphone14,
      description:
          'iPhone 14, the latest Apple smartphone available in Black, White, and Purple, featuring iOS for an exceptional user experience.',
      brand: BrandModel(
          id: '2',
          image: TImages.apple,
          name: "Apple",
          isFeatured: true,
          productsCount: 45),
      images: [
        TImages.blackIphone14,
        TImages.whiteIphone14,
        TImages.purpleIphone14,
      ],
      salePrice: 1050.0,
      sku: 'IPH2024',
      categoryId: '3',
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Black', 'White', 'Purple']),
        ProductAttributeModel(name: 'Size', values: ['IOS']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '007',
      title: 'Nike Air Jordans',
      stock: 30,
      price: 300.0,
      isFeatured: true,
      thumbnail: TImages.nikeAirJordansBlueBlack,
      description:
          'Nike Air Jordans available in Blue-Black, Blue-White, and Red-Black, known for their style and performance.',
      brand: BrandModel(
          id: '1',
          image: TImages.nike,
          name: "Nike",
          isFeatured: true,
          productsCount: 50),
      images: [
        TImages.nikeAirJordansBlueBlack,
        TImages.nikeAirJordansBlueWhite,
        TImages.nikeAirJordansRedBlack,
      ],
      salePrice: 280.0,
      sku: 'JORD2024',
      categoryId: '5',
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Blue-Black', 'Blue-White', 'Red-Black']),
        ProductAttributeModel(name: 'Size', values: ['EU32', 'EU34']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          image: TImages.nikeAirJordansBlueBlack,
          stock: 20,
          price: 320.0,
          salePrice: 290.0,
          description: 'Nike Air Jordans in Blue-Black, size EU32.',
          attributeValues: {'Color': 'Blue-Black', 'Size': 'EU32'},
        ),
        ProductVariationModel(
          id: '2',
          image: TImages.nikeAirJordansBlueBlack,
          stock: 18,
          price: 340.0,
          salePrice: 290.0,
          description: 'Nike Air Jordans in Blue-Black, size EU34.',
          attributeValues: {'Color': 'Blue-Black', 'Size': 'EU34'},
        ),
        ProductVariationModel(
          id: '3',
          image: TImages.nikeAirJordansBlueWhite,
          stock: 16,
          price: 310.0,
          salePrice: 300.0,
          description: 'Nike Air Jordans in Blue-White, size EU32.',
          attributeValues: {'Color': 'Blue-White', 'Size': 'EU32'},
        ),
        ProductVariationModel(
          id: '4',
          image: TImages.nikeAirJordansBlueWhite,
          stock: 12,
          price: 330.0,
          salePrice: 300.0,
          description: 'Nike Air Jordans in Blue-White, size EU34.',
          attributeValues: {'Color': 'Blue-White', 'Size': 'EU34'},
        ),
        ProductVariationModel(
          id: '5',
          image: TImages.nikeAirJordansRedBlack,
          stock: 20,
          price: 315.0,
          salePrice: 295.0,
          description: 'Nike Air Jordans in Red-Black, size EU32.',
          attributeValues: {'Color': 'Red-Black', 'Size': 'EU32'},
        ),
        ProductVariationModel(
          id: '6',
          image: TImages.nikeAirJordansRedBlack,
          stock: 18,
          price: 345.0,
          salePrice: 295.0,
          description: 'Nike Air Jordans in Red-Black, size EU34.',
          attributeValues: {'Color': 'Red-Black', 'Size': 'EU34'},
        ),
      ],
      productType: 'ProductType.variable',
    ),
    ProductModel(
      id: '008',
      title: 'Puma Sneakers',
      stock: 50,
      price: 240.0,
      isFeatured: true,
      thumbnail: TImages.darkBluePumaSneakers,
      description:
          'Puma Sneakers available in Black, Green, and Dark-Blue, offering style and comfort for everyday wear.',
      brand: BrandModel(
          id: '8',
          image: TImages.puma,
          name: "Puma",
          isFeatured: true,
          productsCount: 60),
      images: [
        TImages.blackPumaSneakers,
        TImages.greenPumaSneakers,
        TImages.darkBluePumaSneakers,
      ],
      salePrice: 220.0,
      sku: 'PUMA2024',
      categoryId: '5',
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Black', 'Green', 'Dark-Blue']),
        ProductAttributeModel(name: 'Size', values: ['EU32', 'EU34']),
      ],
      productVariations: [
        ProductVariationModel(
          id: '1',
          image: TImages.blackPumaSneakers,
          stock: 35,
          price: 240.0,
          salePrice: 210.0,
          description: 'Puma Sneakers in Black, size EU32.',
          attributeValues: {'Color': 'Black', 'Size': 'EU32'},
        ),
        ProductVariationModel(
          id: '2',
          image: TImages.blackPumaSneakers,
          stock: 25,
          price: 240.0,
          salePrice: 215.0,
          description: 'Puma Sneakers in Black, size EU34.',
          attributeValues: {'Color': 'Black', 'Size': 'EU34'},
        ),
        ProductVariationModel(
          id: '3',
          image: TImages.greenPumaSneakers,
          stock: 20,
          price: 245.0,
          salePrice: 220.0,
          description: 'Puma Sneakers in Green, size EU32.',
          attributeValues: {'Color': 'Green', 'Size': 'EU32'},
        ),
        ProductVariationModel(
          id: '4',
          image: TImages.greenPumaSneakers,
          stock: 22,
          price: 250.0,
          salePrice: 225.0,
          description: 'Puma Sneakers in Green, size EU34.',
          attributeValues: {'Color': 'Green', 'Size': 'EU34'},
        ),
        ProductVariationModel(
          id: '5',
          image: TImages.darkBluePumaSneakers,
          stock: 18,
          price: 255.0,
          salePrice: 230.0,
          description: 'Puma Sneakers in Dark-Blue, size EU32.',
          attributeValues: {'Color': 'Dark-Blue', 'Size': 'EU32'},
        ),
        ProductVariationModel(
          id: '6',
          image: TImages.darkBluePumaSneakers,
          stock: 12,
          price: 260.0,
          salePrice: 235.0,
          description: 'Puma Sneakers in Dark-Blue, size EU34.',
          attributeValues: {'Color': 'Dark-Blue', 'Size': 'EU34'},
        ),
      ],
      productType: 'ProductType.variable',
    ),
    ProductModel(
      id: '009',
      title: 'Samsung Digital Galaxy Watch 6',
      stock: 30,
      price: 270.0,
      isFeatured: true,
      thumbnail: TImages.blackSamsungWatch6,
      description:
          'Samsung Galaxy Watch 6 available in Black, Creme, and Light Grey, featuring advanced health tracking.',
      brand: BrandModel(
          id: '3',
          image: TImages.samsung,
          name: "Samsung",
          isFeatured: true,
          productsCount: 65),
      images: [
        TImages.blackSamsungWatch6,
        TImages.cremeSamsungWatch6,
        TImages.lightGreySamsungWatch6,
      ],
      salePrice: 245.0,
      sku: 'SGW2024',
      categoryId: '4',
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Black', 'Creme', 'Light Grey']),
        ProductAttributeModel(name: 'Size', values: ['Digital']),
      ],
      productType: 'ProductType.single',
    ),
    ProductModel(
      id: '010',
      title: 'Titan Analog Watch',
      stock: 40,
      price: 200.0,
      isFeatured: true,
      thumbnail: TImages.blackTitanRound,
      description:
          'Titan Analog Watch, available in Black, Light Brown, and Brown, offering a sleek and timeless design.',
      brand: BrandModel(
          id: '7',
          image: TImages.titan,
          name: "Titan",
          isFeatured: true,
          productsCount: 30),
      images: [
        TImages.blackTitanRound,
        TImages.brownTitanRound,
        TImages.brownSquareTitan,
      ],
      salePrice: 180.0,
      sku: 'TITAN2024',
      categoryId: '4',
      productAttributes: [
        ProductAttributeModel(
            name: 'Color', values: ['Black', 'Light Brown', 'Brown']),
        ProductAttributeModel(name: 'Size', values: ['Analog']),
      ],
      productType: 'ProductType.single',
    ),
  ];

  static final List<BrandCategoryModel> brandCategories = [
    BrandCategoryModel(brandId: '1', categoryId: '5'), // Nike - Shoes
    BrandCategoryModel(brandId: '2', categoryId: '3'), // Apple - Mobiles

    BrandCategoryModel(brandId: '3', categoryId: '3'), // Samsung - Mobiles
    BrandCategoryModel(brandId: '3', categoryId: '4'), // Samsung - Watches
    BrandCategoryModel(brandId: '4', categoryId: '1'), // H&M - Cloths
    BrandCategoryModel(
        brandId: '5', categoryId: '1'), // Marks And Spencer - Cloths

    BrandCategoryModel(brandId: '6', categoryId: '2'), // JBL - Headphones
    BrandCategoryModel(brandId: '2', categoryId: '2'), // JBL - Headphones
    BrandCategoryModel(brandId: '7', categoryId: '4'), // Titan - Watches
    BrandCategoryModel(brandId: '8', categoryId: '5'), // Puma - Shoes
  ];
  static final List<ProductCategoryModel> productCategories = [
    ProductCategoryModel(
        productId: '001', categoryId: '1'), // Stylish Leather Jacket - Cloths
    ProductCategoryModel(
        productId: '002', categoryId: '1'), // Stylish T-Shirt - Cloths
    ProductCategoryModel(
        productId: '003', categoryId: '2'), // Apple Airpods - Headphones
    ProductCategoryModel(
        productId: '004',
        categoryId: '2'), // JBL Over-Ear Headphones - Headphones
    ProductCategoryModel(
        productId: '005',
        categoryId: '3'), // Samsung Galaxy S23 Ultra - Mobiles
    ProductCategoryModel(
        productId: '006', categoryId: '3'), // iPhone 14 - Mobiles
    ProductCategoryModel(
        productId: '007', categoryId: '5'), // Nike Air Jordans - Shoes
    ProductCategoryModel(
        productId: '008', categoryId: '5'), // Puma Sneakers - Shoes
    ProductCategoryModel(
        productId: '009', categoryId: '4'), // Samsung Galaxy Watch 6 - Watches
    ProductCategoryModel(
        productId: '010', categoryId: '4'), // Titan Analog Watch - Watches
  ];
}
