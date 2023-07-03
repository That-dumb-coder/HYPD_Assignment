//
//  ProductCard.swift
//  HYPD
//
//  Created by Naman Sharma on 29/06/23.
//

import SwiftUI

struct ProductCard: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: product.featuredImage.src))
                .aspectRatio(contentMode: .fill)
                .frame(width: 164, height: 215)
                .cornerRadius(15)
                .padding(.horizontal)
            Text(product.brandInfo.name)
                .lineLimit(1)
                .multilineTextAlignment(.leading)
                .font(.subheadline)
                .bold()
                .frame(width: 180)
                .padding(5)
            Text(product.name)
                .lineLimit(2)
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
                .font(Font.custom("Urbanist-Regular",
                                  fixedSize: 12.0))
                .frame(width: 180)
                .padding(5)
            HStack(alignment: .center) {
                Text(String(format: "%.0f", product.retailPrice.value))
                    .font(.headline)
                    .bold()
                Spacer()
                Text(String(format: "%.0f", product.basePrice.value))
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .strikethrough()
                Spacer()
                Text(String(format: "%.2f", product.discountPercentage) + " % off")
                    .foregroundColor(Color.green)
                    .font(Font.custom("Urbanist-Bold",
                                      fixedSize: 12.0))
            }.padding(.horizontal, 10)
            HStack {
                Image("discount-shape")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .padding(5)
                    .bold()
                Text("Commission")
                    .font(Font.custom("Urbanist-Bold",
                                      fixedSize: 10.0))
                    .bold()
                Spacer()
                Text("12 %")
                    .font(Font.custom("Urbanist-Bold",
                                      fixedSize: 12.0))
                    .bold()
                    .padding(5)
            }.background {
                Color.gray.opacity(0.2)
                    .cornerRadius(5)
            }
        }
    }
}
