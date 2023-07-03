import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewModel()
    @State private var isLoading = false
    @State private var isTitleScrolledUp = false
    
    var body: some View {
        ZStack {
            VStack {
                selectionView
                ScrollView {
                    topViewStack
                    similarProductStack
                    ScrollView {
                        productStack
                    }
                }.onAppear() {
                    Task {
                        isLoading = true
                        try await homeViewModel.performProductRequest()
                        isLoading = false
                    }
                }
            }
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
                    .padding()
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(10)
            }
        }
    }
    var topViewStack: some View {
        VStack(alignment: .leading) {
            Text("\(homeViewModel.homeResponse?.name ?? "Title")")
                .font(Font.custom("Urbanist-ExtraBold",
                                  fixedSize: 20))
                .foregroundColor(.black)
                .padding(.leading)
            Text("\(homeViewModel.products.count) PRODUCTS")
                .font(Font.custom("Urbanist-Regular",
                                  fixedSize: 16))
                .foregroundColor(.gray)
                .padding(.leading)
        }.padding(.horizontal)
    }
    
    var selectionView: some View {
        HStack {
            if isTitleScrolledUp {
                Text("\(homeViewModel.homeResponse?.name ?? "Title")")
                    .font(Font.custom("Urbanist-ExtraBold",
                                      fixedSize: 20))
                    .foregroundColor(.black)
                    .padding(.leading)
                    .lineLimit(1)
            }
            Spacer()
            Button {
                //enable selection
            } label: {
                Text("Select")
                    .font(Font.custom("Urbanist-Regular",
                                      fixedSize: 18))
                    .foregroundColor(.black)
            }
            .padding(.trailing, 20)
        }.padding(.bottom)
    }
    
    var productStack: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(homeViewModel.catalogList) { product in
                    ProductCard(product: product)
                }
            }
            .padding()
        }
    }
    
    var similarProductStack: some View {
        VStack {
            HStack {
                Text("Some products you can add to store:")
                    .font(Font.custom("Urbanist-ExtraBold", fixedSize: 20))
                Spacer()
                Button {
                    // Collapse this view and add to list
                } label: {
                    Text("Add all")
                        .font(Font.custom("Urbanist-ExtraBold", fixedSize: 18))
                        .foregroundColor(.orange)
                }
                .padding(.trailing, 20)
            }
            .padding()
            
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack(spacing: 10) {
                    ForEach(homeViewModel.similarProductList, id: \.id) { product in
                        SimilarProductCard(product: product)
                            .environmentObject(homeViewModel)
                            .listStyle(.plain)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color.gray.opacity(0.1))
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
