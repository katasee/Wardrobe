//
//  StreetView.swift
//  Wardrobe
//
//  Created by Anton on 27/06/2025.
//

import SwiftUI
import SwiftData

struct StreetView: View {

    @State private var viewModel: StreetViewModel
    @State private var selectionViewModel: OutfitSelectionViewModel?

    init(viewModel: StreetViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            header
            outfitsList
        }
        .padding(16)
        .background(Color.hex011B32.ignoresSafeArea())
        .fullScreenCover(item: $viewModel.state.selectedTimeOfDay) { timeOfDay in
            if let selectionViewModel {
                OutfitSelectionView(
                    viewModel: selectionViewModel,
                    onDismiss: {
                        viewModel.state.selectedTimeOfDay = nil
                        self.selectionViewModel = nil
                        viewModel.loadSelectedOutfits(for: timeOfDay)
                    }
                )
            }
        }
        .task {
            await viewModel.loadData()
        }
        .loader(viewModel.state.isLoading)
        .alert(item: $viewModel.state.error) { error in
            Alert(
                title: Text("Error"),
                message: Text(error.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    var header: some View {
        HStack(alignment: .top) {
            Text(Date.now.localizedDayMonthYear)
                .font(.montserrat(24, .semiBold))

            Spacer()

            VStack(alignment: .trailing, spacing: 12) {
                Text(viewModel.state.currentTemparature)
                    .font(.montserrat(19, .semiBold))

                Text(viewModel.state.currentLocation)
                    .font(.montserrat(16, .semiBold))
            }
        }
        .foregroundStyle(.white)
    }

    var outfitsList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 24) {
                ForEach(TimeOfDay.allCases, id: \.self) { timeOfDay in
                    outfitSection(for: timeOfDay)
                }
            }
            .padding(.vertical)
        }
    }

    func outfitSection(for timeOfDay: TimeOfDay) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(timeOfDay.rawValue.capitalized)
                .font(.montserrat(21, .medium))
                .foregroundStyle(.white)

            let items = viewModel.state.selectedItems[timeOfDay] ?? []

            Button {
                selectionViewModel = OutfitSelectionViewModel(
                    timeOfDay: timeOfDay,
                    repository: viewModel.wardrobeRepository
                )
                viewModel.state.selectedTimeOfDay = timeOfDay
            } label: {
                if items.isEmpty {
                    SectionPlaceholder()
                } else {
                    OutfitSelectionRow(items: items.mapToOutfitCategoryItems())
                }
            }
        }
    }
}
