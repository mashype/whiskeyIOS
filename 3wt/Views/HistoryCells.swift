//
//  HistoryCells.swift
//  3wt
//
//  Created by Seth Merritt on 9/1/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents


class RequestHistoryHeader: DatasourceCell {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "YOUR COPILOT REQUESTS"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        backgroundColor = wtBlue
        
        addSubview(headerLabel)
        
        headerLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

class RequestHistoryFooter: DatasourceCell {
    
    let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "SECTION FOOTER"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = wtGreen
        
        addSubview(footerLabel)
        
        footerLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 00)
        
    }
}


class RequestHistoryCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            //if there is a profile existing
            guard let request = datasourceItem as? Request else { return }
            departureCityLabel.text = request.location
            flightTypeLabel.text = request.flightType
            requestID = request.requestID!
        }
    }
    
    //MARK:- Label constants
    
    var requestID = String()
    

    
    let departureCityTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.text = "Departing:"
        return label
    }()
    
    let departureCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let flightTypeTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.text = "Type:"
        return label
    }()
    
    let flightTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let planeTypeTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.text = "Plane Type:"
        return label
    }()
    
    let planeTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    

    
    override func setupViews() {
        
        super.setupViews()
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        backgroundColor = .white
        
        addSubview(departureCityTitle)
        addSubview(departureCityLabel)
        addSubview(flightTypeTitle)
        addSubview(flightTypeLabel)
        addSubview(planeTypeTitle)
        addSubview(planeTypeLabel)

        
        departureCityTitle.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 0)
        
        departureCityLabel.anchor(departureCityTitle.topAnchor, left: departureCityTitle.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 00, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        flightTypeTitle.anchor(departureCityTitle.bottomAnchor, left: departureCityTitle.leftAnchor, bottom: nil, right: departureCityTitle.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        flightTypeLabel.anchor(flightTypeTitle.topAnchor, left: departureCityLabel.leftAnchor, bottom: nil, right: departureCityLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        planeTypeTitle.anchor(flightTypeTitle.bottomAnchor, left: departureCityTitle.leftAnchor, bottom: nil, right: departureCityTitle.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        planeTypeLabel.anchor(planeTypeTitle.topAnchor, left: departureCityLabel.leftAnchor, bottom: nil, right: departureCityLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
}


class BookingHistoryHeader: DatasourceCell {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "YOUR BOOKINGS"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        backgroundColor = wtBlue
        
        addSubview(headerLabel)
        
        headerLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

class BookingHistoryFooter: DatasourceCell {
    
    let footerLabel: UILabel = {
        let label = UILabel()
        label.text = "BOOKING FOOTER"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = wtGreen
        
        addSubview(footerLabel)
        
        footerLabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 00)
        
    }
}


class BookingHistoryCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            //if there is a profile existing
            guard let booking = datasourceItem as? Booking else { return }
            departureCityLabel.text = booking.departure
            destinationCityLabel.text = booking.destination
            dateLabel.text = booking.departure

        }
    }
    
    
    let departureCityTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.text = "Departing:"
        return label
    }()
    
    let departureCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let destinationCityTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.text = "Type:"
        return label
    }()
    
    let destinationCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let dateTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.text = "Type:"
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    override func setupViews() {
        
        super.setupViews()
        
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        backgroundColor = .white
        
        addSubview(departureCityTitle)
        addSubview(departureCityLabel)
        addSubview(destinationCityTitle)
        addSubview(destinationCityLabel)
        addSubview(dateTitle)
        addSubview(dateLabel)


        departureCityTitle.anchor(topAnchor, left: leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 0)
        
        departureCityLabel.anchor(departureCityTitle.topAnchor, left: departureCityTitle.rightAnchor, bottom: nil, right: rightAnchor, topConstant: 00, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        destinationCityTitle.anchor(departureCityTitle.bottomAnchor, left: departureCityTitle.leftAnchor, bottom: nil, right: departureCityTitle.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        destinationCityLabel.anchor(destinationCityTitle.topAnchor, left: departureCityLabel.leftAnchor, bottom: nil, right: departureCityLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        dateTitle.anchor(destinationCityTitle.bottomAnchor, left: departureCityTitle.leftAnchor, bottom: nil, right: departureCityTitle.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        dateLabel.anchor(dateTitle.topAnchor, left: departureCityLabel.leftAnchor, bottom: nil, right: departureCityLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }

    
}


