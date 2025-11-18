# wireshark_SIB1_to_OAI_conf
online calculator: https://dustinchen26.github.io/wireshark_SIB1_to_OAI_conf

## Example
```
【Input Wireshark SIB1】
F1 Application Protocol (F1SetupRequest)
    F1AP-PDU: initiatingMessage (0)
        initiatingMessage
            procedureCode: id-F1Setup (1)
            criticality: reject (0)
            value
                F1SetupRequest
                    protocolIEs: 5 items
                        Item 0: id-TransactionID
                            ProtocolIE-Field
                                id: id-TransactionID (78)
                                criticality: reject (0)
                                value
                                    TransactionID: 1
                        Item 1: id-gNB-DU-ID
                            ProtocolIE-Field
                                id: id-gNB-DU-ID (42)
                                criticality: reject (0)
                                value
                                    GNB-DU-ID: 3584
                        Item 2: id-gNB-DU-Name
                            ProtocolIE-Field
                                id: id-gNB-DU-Name (45)
                                criticality: ignore (1)
                                value
                                    GNB-DU-Name: du-rfsim
                        Item 3: id-gNB-DU-Served-Cells-List
                            ProtocolIE-Field
                                id: id-gNB-DU-Served-Cells-List (44)
                                criticality: reject (0)
                                value
                                    GNB-DU-Served-Cells-List: 1 item
                                        Item 0: id-GNB-DU-Served-Cells-Item
                                            ProtocolIE-SingleContainer
                                                id: id-GNB-DU-Served-Cells-Item (43)
                                                criticality: reject (0)
                                                value
                                                    GNB-DU-Served-Cells-Item
                                                        served-Cell-Information
                                                            nRCGI
                                                                pLMN-Identity: 00f110
                                                                    Mobile Country Code (MCC): Unknown (001)
                                                                    Mobile Network Code (MNC): Unknown (01)
                                                                nRCellIdentity: 000bc614e0 [bit length 36, 4 LSB pad bits, 0000 0000  0000 1011  1100 0110  0001 0100  1110 .... decimal value 12345678]
                                                            nRPCI: 0
                                                            fiveGS-TAC: 1 (0x000001)
                                                            servedPLMNs: 1 item
                                                                Item 0
                                                                    ServedPLMNs-Item
                                                                        pLMN-Identity: 00f110
                                                                            Mobile Country Code (MCC): Unknown (001)
                                                                            Mobile Network Code (MNC): Unknown (01)
                                                                        iE-Extensions: 1 item
                                                                            Item 0
                                                                                ProtocolExtensionField
                                                                                    id: 131
                                                                                    criticality: ignore (1)
                                                                                    extensionValue
                                                                                        SliceSupportList: 1 item
                                                                                            Item 0
                                                                                                SliceSupportItem
                                                                                                    sNSSAI
                                                                                                        sST: 01
                                                            nR-Mode-Info: tDD (1)
                                                                tDD
                                                                    nRFreqInfo
                                                                        nRARFCN: 628776
                                                                        freqBandListNr: 1 item
                                                                            Item 0
                                                                                FreqBandNrItem
                                                                                    freqBandIndicatorNr: 78
                                                                                    supportedSULBandList: 0 items
                                                                    transmission-Bandwidth
                                                                        nRSCS: scs30 (1)
                                                                        nRNRB: nrb106 (14)
                                                            measurementTimingConfiguration: 101133a4050000
                                                                MeasurementTimingConfiguration
                                                                    criticalExtensions: c1 (0)
                                                                        c1: measTimingConf (0)
                                                                            measTimingConf
                                                                                measTiming: 1 item
                                                                                    Item 0
                                                                                        MeasTiming
                                                                                            frequencyAndTiming
                                                                                                carrierFreq: 630048
                                                                                                ssbSubcarrierSpacing: kHz30 (1)
                                                                                                ssb-MeasurementTimingConfiguration
                                                                                                    periodicityAndOffset: sf20 (2)
                                                                                                        sf20: 0
                                                                                                    duration: sf1 (0)
                                                        gNB-DU-System-Information
                                                            mIB-message: 010606
                                                                MIB
                                                                    systemFrameNumber: 00 [bit length 6, 2 LSB pad bits, 0000 00.. decimal value 0]
                                                                    subCarrierSpacingCommon: scs15or60 (0)
                                                                    ssb-SubcarrierOffset: 8
                                                                    dmrs-TypeA-Position: pos2 (0)
                                                                    pdcch-ConfigSIB1
                                                                        controlResourceSetZero: 6
                                                                        searchSpaceZero: 0
                                                                    cellBarred: barred (0)
                                                                    intraFreqReselection: notAllowed (1)
                                                                    spare: 80 [bit length 1, 7 LSB pad bits, 1... .... decimal value 1]
                                                            sIB1-message: 92002808200201000001000bc614ea4213415800009a59c32cd7f816e0804000020106e1004000020106e180400002010001840d2140d8721d330000800009a7273865995188006b5335f7270124e31aa6353270b80143874020b01d80488cdec430
                                                                SIB1
                                                                    cellSelectionInfo
                                                                        q-RxLevMin: -130dBm (-65)
                                                                    cellAccessRelatedInfo
                                                                        plmn-IdentityInfoList: 1 item
                                                                            Item 0
                                                                                PLMN-IdentityInfo
                                                                                    plmn-IdentityList: 1 item
                                                                                        Item 0
                                                                                            PLMN-Identity
                                                                                                mcc: 3 items
                                                                                                    Item 0
                                                                                                        MCC-MNC-Digit: 0
                                                                                                    Item 1
                                                                                                        MCC-MNC-Digit: 0
                                                                                                    Item 2
                                                                                                        MCC-MNC-Digit: 1
                                                                                                mnc: 2 items
                                                                                                    Item 0
                                                                                                        MCC-MNC-Digit: 0
                                                                                                    Item 1
                                                                                                        MCC-MNC-Digit: 1
                                                                                    trackingAreaCode: 000001 [bit length 24, 0000 0000  0000 0000  0000 0001 decimal value 1]
                                                                                    cellIdentity: 000bc614e0 [bit length 36, 4 LSB pad bits, 0000 0000  0000 1011  1100 0110  0001 0100  1110 .... decimal value 12345678]
                                                                                    cellReservedForOperatorUse: notReserved (1)
                                                                    servingCellConfigCommon
                                                                        downlinkConfigCommon
                                                                            frequencyInfoDL
                                                                                frequencyBandList: 1 item
                                                                                    Item 0
                                                                                        NR-MultiBandInfo
                                                                                            freqBandIndicatorNR: 78
                                                                                offsetToPointA: 86 PRBs
                                                                                scs-SpecificCarrierList: 1 item
                                                                                    Item 0
                                                                                        SCS-SpecificCarrier
                                                                                            offsetToCarrier: 0
                                                                                            subcarrierSpacing: kHz30 (1)
                                                                                            carrierBandwidth: 106
                                                                            initialDownlinkBWP
                                                                                genericParameters
                                                                                    locationAndBandwidth: 28875
                                                                                    subcarrierSpacing: kHz30 (1)
                                                                                pdcch-ConfigCommon: setup (1)
                                                                                    setup
                                                                                        controlResourceSetZero: 12
                                                                                        searchSpaceZero: 0
                                                                                        commonSearchSpaceList: 3 items
                                                                                            Item 0
                                                                                                SearchSpace
                                                                                                    searchSpaceId: 1
                                                                                                    controlResourceSetId: 0
                                                                                                    monitoringSlotPeriodicityAndOffset: sl1 (0)
                                                                                                        sl1: NULL
                                                                                                    monitoringSymbolsWithinSlot: 8000 [bit length 14, 2 LSB pad bits, 1000 0000  0000 00.. decimal value 8192]
                                                                                                    nrofCandidates
                                                                                                        aggregationLevel1: n0 (0)
                                                                                                        aggregationLevel2: n0 (0)
                                                                                                        aggregationLevel4: n2 (2)
                                                                                                        aggregationLevel8: n0 (0)
                                                                                                        aggregationLevel16: n0 (0)
                                                                                                    searchSpaceType: common (0)
                                                                                                        common
                                                                                                            dci-Format0-0-AndFormat1-0
                                                                                            Item 1
                                                                                                SearchSpace
                                                                                                    searchSpaceId: 2
                                                                                                    controlResourceSetId: 0
                                                                                                    monitoringSlotPeriodicityAndOffset: sl1 (0)
                                                                                                        sl1: NULL
                                                                                                    monitoringSymbolsWithinSlot: 8000 [bit length 14, 2 LSB pad bits, 1000 0000  0000 00.. decimal value 8192]
                                                                                                    nrofCandidates
                                                                                                        aggregationLevel1: n0 (0)
                                                                                                        aggregationLevel2: n0 (0)
                                                                                                        aggregationLevel4: n2 (2)
                                                                                                        aggregationLevel8: n0 (0)
                                                                                                        aggregationLevel16: n0 (0)
                                                                                                    searchSpaceType: common (0)
                                                                                                        common
                                                                                                            dci-Format0-0-AndFormat1-0
                                                                                            Item 2
                                                                                                SearchSpace
                                                                                                    searchSpaceId: 3
                                                                                                    controlResourceSetId: 0
                                                                                                    monitoringSlotPeriodicityAndOffset: sl1 (0)
                                                                                                        sl1: NULL
                                                                                                    monitoringSymbolsWithinSlot: 8000 [bit length 14, 2 LSB pad bits, 1000 0000  0000 00.. decimal value 8192]
                                                                                                    nrofCandidates
                                                                                                        aggregationLevel1: n0 (0)
                                                                                                        aggregationLevel2: n0 (0)
                                                                                                        aggregationLevel4: n2 (2)
                                                                                                        aggregationLevel8: n0 (0)
                                                                                                        aggregationLevel16: n0 (0)
                                                                                                    searchSpaceType: common (0)
                                                                                                        common
                                                                                                            dci-Format0-0-AndFormat1-0
                                                                                        searchSpaceSIB1: 0
                                                                                        searchSpaceOtherSystemInformation: 3
                                                                                        pagingSearchSpace: 2
                                                                                        ra-SearchSpace: 1
                                                                                pdsch-ConfigCommon: setup (1)
                                                                                    setup
                                                                                        pdsch-TimeDomainAllocationList: 3 items
                                                                                            Item 0
                                                                                                PDSCH-TimeDomainResourceAllocation
                                                                                                    mappingType: typeA (0)
                                                                                                    startSymbolAndLength: 40
                                                                                            Item 1
                                                                                                PDSCH-TimeDomainResourceAllocation
                                                                                                    mappingType: typeA (0)
                                                                                                    startSymbolAndLength: 54
                                                                                            Item 2
                                                                                                PDSCH-TimeDomainResourceAllocation
                                                                                                    mappingType: typeA (0)
                                                                                                    startSymbolAndLength: 57
                                                                            bcch-Config
                                                                                modificationPeriodCoeff: n2 (0)
                                                                            pcch-Config
                                                                                defaultPagingCycle: rf256 (3)
                                                                                nAndPagingFrameOffset: quarterT (2)
                                                                                    quarterT: 1
                                                                                ns: one (2)
                                                                                firstPDCCH-MonitoringOccasionOfPO: sCS120KHZoneT-SCS60KHZhalfT-SCS30KHZquarterT-SCS15KHZoneEighthT (3)
                                                                                    sCS120KHZoneT-SCS60KHZhalfT-SCS30KHZquarterT-SCS15KHZoneEighthT: 1 item
                                                                                        Item 0
                                                                                            sCS120KHZoneT-SCS60KHZhalfT-SCS30KHZquarterT-SCS15KHZoneEighthT item: 0
                                                                        uplinkConfigCommon
                                                                            frequencyInfoUL
                                                                                scs-SpecificCarrierList: 1 item
                                                                                    Item 0
                                                                                        SCS-SpecificCarrier
                                                                                            offsetToCarrier: 0
                                                                                            subcarrierSpacing: kHz30 (1)
                                                                                            carrierBandwidth: 106
                                                                                p-Max: 20 dBm
                                                                            initialUplinkBWP
                                                                                genericParameters
                                                                                    locationAndBandwidth: 28875
                                                                                    subcarrierSpacing: kHz30 (1)
                                                                                rach-ConfigCommon: setup (1)
                                                                                    setup
                                                                                        rach-ConfigGeneric
                                                                                            prach-ConfigurationIndex: 98
                                                                                            msg1-FDM: one (0)
                                                                                            msg1-FrequencyStart: 0
                                                                                            zeroCorrelationZoneConfig: 13
                                                                                            preambleReceivedTargetPower: -96 dBm
                                                                                            preambleTransMax: n10 (6)
                                                                                            powerRampingStep: dB2 (1)
                                                                                            ra-ResponseWindow: sl20 (5)
                                                                                        ssb-perRACH-OccasionAndCB-PreamblesPerSSB: one (3)
                                                                                            one: n60 (14)
                                                                                        ra-ContentionResolutionTimer: sf64 (7)
                                                                                        rsrp-ThresholdSSB: -138dBm <= SS-RSRP < -137dBm (19)
                                                                                        prach-RootSequenceIndex: l139 (1)
                                                                                            l139: 1
                                                                                        msg1-SubcarrierSpacing: kHz30 (1)
                                                                                        restrictedSetConfig: unrestrictedSet (0)
                                                                                pusch-ConfigCommon: setup (1)
                                                                                    setup
                                                                                        pusch-TimeDomainAllocationList: 2 items
                                                                                            Item 0
                                                                                                PUSCH-TimeDomainResourceAllocation
                                                                                                    k2: 6
                                                                                                    mappingType: typeB (1)
                                                                                                    startSymbolAndLength: 41
                                                                                            Item 1
                                                                                                PUSCH-TimeDomainResourceAllocation
                                                                                                    k2: 6
                                                                                                    mappingType: typeB (1)
                                                                                                    startSymbolAndLength: 38
                                                                                        msg3-DeltaPreamble: 2dB (1)
                                                                                        p0-NominalWithGrant: -90 dBm
                                                                                pucch-ConfigCommon: setup (1)
                                                                                    setup
                                                                                        pucch-ResourceCommon: 0
                                                                                        pucch-GroupHopping: neither (0)
                                                                                        hoppingId: 40
                                                                                        p0-nominal: -90 dBm
                                                                            timeAlignmentTimerCommon: infinity (7)
                                                                        ssb-PositionsInBurst
                                                                            inOneGroup: 80 [bit length 8, 1000 0000 decimal value 128]
                                                                        ssb-PeriodicityServingCell: ms20 (2)
                                                                        tdd-UL-DL-ConfigurationCommon
                                                                            referenceSubcarrierSpacing: kHz30 (1)
                                                                            pattern1
                                                                                dl-UL-TransmissionPeriodicity: ms5 (6)
                                                                                nrofDownlinkSlots: 7
                                                                                nrofDownlinkSymbols: 6
                                                                                nrofUplinkSlots: 2
                                                                                nrofUplinkSymbols: 4
                                                                        ss-PBCH-BlockPower: -25 dBm
                                                                    ue-TimersAndConstants
                                                                        t300: ms400 (3)
                                                                        t301: ms400 (3)
                                                                        t310: ms2000 (6)
                                                                        n310: n10 (6)
                                                                        t311: ms3000 (1)
                                                                        n311: n1 (0)
                                                                        t319: ms400 (3)
                        Item 4: id-GNB-DU-RRC-Version
                            ProtocolIE-Field
                                id: id-GNB-DU-RRC-Version (171)
                                criticality: reject (0)
                                value
                                    RRC-Version
                                        latest-RRC-Version: 00 [bit length 3, 5 LSB pad bits, 000. .... decimal value 0]
                                        iE-Extensions: 1 item
                                            Item 0
                                                ProtocolExtensionField
                                                    id: 199
                                                    criticality: ignore (1)
                                                    extensionValue
                                                        17.3.0

【Output OAI_conf】
Active_gNBs = ( "du-rfsim");
# Asn1_verbosity, choice in: none, info, annoying
Asn1_verbosity = "none";

gNBs =
(
 {
    ////////// Identification parameters:
    gNB_ID = 0xe00;
    gNB_DU_ID = 0xe00;
    gNB_name  =  "du-rfsim";

    // Tracking area code, 0x0000 and 0xfffe are reserved values
    tracking_area_code  =  1;
    plmn_list = ({ mcc = 001; mnc = 01; mnc_length = 2; snssaiList = ({ sst = 1; }) });

    nr_cellid = 12345678L;

    ////////// Physical parameters:

    min_rxtxtime = 4;

    servingCellConfigCommon = (
    {
 #spCellConfigCommon

      physCellId                                               = 0;

#  downlinkConfigCommon
    #frequencyInfoDL
      # this is 3600 MHz + 43 PRBs@30kHz SCS (same as initial BWP)
      absoluteFrequencySSB                                      = 630048;
      dl_frequencyBand                                          = 78;
      # this is 3600 MHz
      dl_absoluteFrequencyPointA                                = 628776;
      #scs-SpecificCarrierList
        dl_offstToCarrier                                       = 0;
# subcarrierSpacing
# 0=kHz15, 1=kHz30, 2=kHz60, 3=kHz120
        dl_subcarrierSpacing                                    = 1;
        dl_carrierBandwidth                                     = 106;
     #initialDownlinkBWP
      #genericParameters
        # this is RBstart=27,L=48 (275*(L-1))+RBstart
        initialDLBWPlocationAndBandwidth                         = 28875; # 6366 12925 12956 28875 12952
# subcarrierSpacing
# 0=kHz15, 1=kHz30, 2=kHz60, 3=kHz120
        initialDLBWPsubcarrierSpacing                             = 1;
      #pdcch-ConfigCommon
        initialDLBWPcontrolResourceSetZero                        = 12;
        initialDLBWPsearchSpaceZero                               = 0;

  #uplinkConfigCommon
     #frequencyInfoUL
      ul_frequencyBand                                             = 78;
      #scs-SpecificCarrierList
      ul_offstToCarrier                                            = 0;
# subcarrierSpacing
# 0=kHz15, 1=kHz30, 2=kHz60, 3=kHz120
      ul_subcarrierSpacing                                         = 1;
      ul_carrierBandwidth                                          = 106;
      pMax                                                         = 20;
     #initialUplinkBWP
      #genericParameters
        initialULBWPlocationAndBandwidth                           = 28875;
# subcarrierSpacing
# 0=kHz15, 1=kHz30, 2=kHz60, 3=kHz120
        initialULBWPsubcarrierSpacing                              = 1;
      #rach-ConfigCommon
        #rach-ConfigGeneric
          prach_ConfigurationIndex                                 = 98;
#prach_msg1_FDM
#0 = one, 1=two, 2=four, 3=eight
          prach_msg1_FDM                                           = 0;
          prach_msg1_FrequencyStart                                = 0;
          zeroCorrelationZoneConfig                                = 13;
          preambleReceivedTargetPower                              = -96;
#preamblTransMax (0...10) = (3,4,5,6,7,8,10,20,50,100,200)
          preambleTransMax                                         = 6;
#powerRampingStep
# 0=dB0,1=dB2,2=dB4,3=dB6
        powerRampingStep                                           = 1;
#ssb_perRACH_OccasionAndCB_PreamblesPerSSB_PR
#1=oneeighth,2=onefourth,3=half,4=one,5=two,6=four,7=eight,8=sixteen
        ssb_perRACH_OccasionAndCB_PreamblesPerSSB_PR               = 4;
#one (0..15) 4,8,12,16,...60,64
        ssb_perRACH_OccasionAndCB_PreamblesPerSSB                  = 14;
#ra_ContentionResolutionTimer
#(0..7) 8,16,24,32,40,48,56,64
        ra_ContentionResolutionTimer                               = 7;
        rsrp_ThresholdSSB                                          = 19;
#prach-RootSequenceIndex_PR
#1 = 839, 2 = 139
        prach_RootSequenceIndex_PR                                 = 2;
        prach_RootSequenceIndex                                    = 1;
        # SCS for msg1, can only be 15 for 30 kHz < 6 GHz, takes precendence over the one derived from prach-ConfigIndex
        #
        msg1_SubcarrierSpacing                                     = 1,
# restrictedSetConfig
# 0=unrestricted, 1=restricted type A, 2=restricted type B
        restrictedSetConfig                                        = 0,

        msg3_DeltaPreamble                                         = 1;
        p0_NominalWithGrant                                        =-90;

# pucch-ConfigCommon setup :
# pucchGroupHopping
# 0 = neither, 1= group hopping, 2=sequence hopping
        pucchGroupHopping                                          = 0;
        hoppingId                                                  = 40;
        p0_nominal                                                 = -90;

      ssb_PositionsInBurst_Bitmap                                  = 1;

# ssb_periodicityServingCell
# 0 = ms5, 1=ms10, 2=ms20, 3=ms40, 4=ms80, 5=ms160, 6=spare2, 7=spare1
      ssb_periodicityServingCell                                   = 2;

# dmrs_TypeA_position
# 0 = pos2, 1 = pos3
      dmrs_TypeA_Position                                           = 0;

# subcarrierSpacing
# 0=kHz15, 1=kHz30, 2=kHz60, 3=kHz120
      subcarrierSpacing                                            = 1;


  #tdd-UL-DL-ConfigurationCommon
# subcarrierSpacing
# 0=kHz15, 1=kHz30, 2=kHz60, 3=kHz120
      referenceSubcarrierSpacing                                   = 1;
      # pattern1
      # dl_UL_TransmissionPeriodicity
      # 0=ms0p5, 1=ms0p625, 2=ms1, 3=ms1p25, 4=ms2, 5=ms2p5, 6=ms5, 7=ms10
      dl_UL_TransmissionPeriodicity                                = 6;
      nrofDownlinkSlots                                            = 7;
      nrofDownlinkSymbols                                          = 6;
      nrofUplinkSlots                                              = 2;
      nrofUplinkSymbols                                            = 4;

      ssPBCH_BlockPower                                            = -25;
     }

  );

    # ------- SCTP definitions
    SCTP :
    {
        # Number of streams to use in input/output
        SCTP_INSTREAMS  = 2;
        SCTP_OUTSTREAMS = 2;
    };
  }
);

MACRLCs = ({
    num_cc              = 1;
    tr_s_preference     = "local_L1";
    tr_n_preference     = "f1";
    local_n_address     = "127.0.0.4";
    remote_n_address    = "127.0.0.3";
    local_n_portd       = 2152;
    remote_n_portd      = 2152;
    pusch_FailureThres  = 1000;
});

L1s = ({
    num_cc = 1;
    tr_n_preference = "local_mac";
    prach_dtx_threshold = 200;
    pucch0_dtx_threshold = 150;
    ofdm_offset_divisor = 8; #set this to UINT_MAX for offset 0
});

RUs = ({
    local_rf       = "yes"
    nb_tx          = 1
    nb_rx          = 1
    att_tx         = 0
    att_rx         = 0;
    bands          = [78];
    max_pdschReferenceSignalPower = -27;
    max_rxgain                    = 114;
    eNB_instances  = [0];
    clock_src = "internal";
});

rfsimulator: {
  serveraddr = "server";
  serverport = 4043;
  options = (); #("saviq"); or/and "chanmod"
  modelname = "AWGN";
  IQfile = "/tmp/rfsimulator.iqs"
}

log_config: {
  global_log_level = "info";
  hw_log_level     = "info";
  nr_phy_log_level = "info";
  nr_mac_log_level = "info";
  rlc_log_level    = "info";
  pdcp_log_level   = "info";
  rrc_log_level    = "info";
  f1ap_log_level   = "info";
  ngap_log_level   = "debug";
};

e2_agent = {
  near_ric_ip_addr = "127.0.0.1";
  sm_dir = "/usr/local/lib/flexric/"
};

```