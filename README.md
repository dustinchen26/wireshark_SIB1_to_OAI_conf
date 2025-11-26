# wireshark_SIB1_to_OAI_conf

online calculator: https://dustinchen26.github.io/wireshark_SIB1_to_OAI_conf

## Note 特別修改
```
(1) ssb_PositionsInBurst_Bitmap
webTcpdump.pcap SIB1顯示=> ssb-PositionsInBurst inOneGroup: 80 [bit length 8, 1000 0000 decimal value 128]
OAI conf 取後面 decimal value => ssb_PositionsInBurst_Bitmap = 128;#

(2) cedar webTcpdump.pcap 顯示的數值是DLearfcn，
真正的 PointA 要看 confdb_v2.xml
所以 647484 改成 644208，填入OAI conf

//●webTcpdump.pcap
nRFreqInfo
    nRARFCN: 647484●
    freqBandListNr: 1 item
        Item 0
            FreqBandNrItem
                freqBandIndicatorNr: 78
                supportedSULBandList: 0 items
frequencyAndTiming
    carrierFreq: 644736●
    ssbSubcarrierSpacing: kHz30 (1)
    ssb-MeasurementTimingConfiguration
        periodicityAndOffset: sf20 (2)
            sf20: 0
        duration: sf3 (2)

//●confdb_v2.xml
<NRARFCNDL>647484</NRARFCNDL>
<AbsoluteFrequencySSB>644736</AbsoluteFrequencySSB>
<AbsoluteFrequencyPointA>644208</AbsoluteFrequencyPointA>

(3) OAI的特殊限制，要改code才能讓prach_ConfigurationIndex = 147 和 198 可以 Run
////沒改OAI原始Code會crash
Assertion (prach_info.start_symbol + prach_info.N_t_slot * prach_info.N_dur < 14) failed!
In fix_scc() /home/dustin/openairinterface5g/openair2/GNB_APP/gnb_config.c:568
PRACH with configuration index 198 goes to the last symbol of the slot, for optimal performance pick another index. See Tables 6.3.3.2-2 to 6.3.3.2-4 in 38.211

////實際計算為何會有問題
//ETSI TS 138 211 Table 6.3.3.2-3: Random access configurations for FR1 and unpaired spectrum.  
=> 198  C2  2  1  2,3,4,7,8,9  2  1  2  6 
PRACH Configuration Index =198 #
Preamble format = C2 #
n_SFN mod x = y, (x,y)=(2,1)#
Subframe number =  2,3,4,7,8,9 #
Starting symbol = 2, #start_symbol 
Number of PRACH slots within a subframe = 1, #
N number of time-domain PRACH occasions within a PRACH slot = 2, #N_t_slot
N PRACH duration = 6 #N_dur

////計算
(prach_info.start_symbol + prach_info.N_t_slot * prach_info.N_dur < 14)
2 + 2 * 6 = 2 + 12 = 14，這等於14，而斷言要求小於14，所以失敗。
```
## 修改OAI code
```
1. 修改程式碼 
/home/dustin/openairinterface5g/openair2/GNB_APP/gnb_config.c

///////// 註解掉
/*  AssertFatal(prach_info.start_symbol + prach_info.N_t_slot * prach_info.N_dur < 14,
              "PRACH with configuration index %ld goes to the last symbol of the slot, for optimal performance pick another index. "
              "See Tables 6.3.3.2-2 to 6.3.3.2-4 in 38.211\n",
              config_index);
*/

///////// 改成顯示參數
{
// Dustin_fix prach index = 198
if (!(prach_info.start_symbol + prach_info.N_t_slot * prach_info.N_dur < 14)) {
LOG_W(GNB_APP,
      "PRACH start_symbol=%d, N_t_slot=%d, N_dur=%d, config_index=%d\n",
      prach_info.start_symbol,
      prach_info.N_t_slot,
      prach_info.N_dur,
      config_index);
}

2. 重新build
build_oai_simplified.sh
```

## Example
```
【範例】底下，
1. wireshark開啟 ●webTcpdump.pcap
2. 搜尋 F1AP	F1SetupRequest, MIB, SIB1
3. 對著 F1 Application Protocol (F1SetupRequest) 按右鍵 Expand Subtree
4. 對著 F1 Application Protocol (F1SetupRequest) 按右鍵 Copy->All Visible Selected Tree Items
5. 貼到輸入框
6. 按下"轉換"得到oai CONF

【Input Wireshark SIB1 packet】
F1 Application Protocol (GNBDUConfigurationUpdate)
    F1AP-PDU: initiatingMessage (0)
        initiatingMessage
            procedureCode: id-gNBDUConfigurationUpdate (3)
            criticality: reject (0)
            value
                GNBDUConfigurationUpdate
                    protocolIEs: 2 items
                        Item 0: id-TransactionID
                            ProtocolIE-Field
                                id: id-TransactionID (78)
                                criticality: reject (0)
                                value
                                    TransactionID: 0
                        Item 1: id-Served-Cells-To-Modify-List
                            ProtocolIE-Field
                                id: id-Served-Cells-To-Modify-List (62)
                                criticality: reject (0)
                                value
                                    Served-Cells-To-Modify-List: 1 item
                                        Item 0: id-Served-Cells-To-Modify-Item
                                            ProtocolIE-SingleContainer
                                                id: id-Served-Cells-To-Modify-Item (61)
                                                criticality: reject (0)
                                                value
                                                    Served-Cells-To-Modify-Item
                                                        oldNRCGI
                                                            pLMN-Identity: 00f110
                                                                Mobile Country Code (MCC): Unknown (001)
                                                                Mobile Network Code (MNC): Unknown (01)
                                                            nRCellIdentity: 00009e0010 [bit length 36, 4 LSB pad bits, 0000 0000  0000 0000  1001 1110  0000 0000  0001 .... decimal value 647169]
                                                        served-Cell-Information
                                                            nRCGI
                                                                pLMN-Identity: 00f110
                                                                    Mobile Country Code (MCC): Unknown (001)
                                                                    Mobile Network Code (MNC): Unknown (01)
                                                                nRCellIdentity: 00009e0010 [bit length 36, 4 LSB pad bits, 0000 0000  0000 0000  1001 1110  0000 0000  0001 .... decimal value 647169]
                                                            nRPCI: 186
                                                            servedPLMNs: 1 item
                                                                Item 0
                                                                    ServedPLMNs-Item
                                                                        pLMN-Identity: 00f110
                                                                            Mobile Country Code (MCC): Unknown (001)
                                                                            Mobile Network Code (MNC): Unknown (01)
                                                            nR-Mode-Info: tDD (1)
                                                                tDD
                                                                    nRFreqInfo
                                                                        nRARFCN: 647484
                                                                        freqBandListNr: 1 item
                                                                            Item 0
                                                                                FreqBandNrItem
                                                                                    freqBandIndicatorNr: 78
                                                                                    supportedSULBandList: 0 items
                                                                    transmission-Bandwidth
                                                                        nRSCS: scs30 (1)
                                                                        nRNRB: nrb273 (28)
                                                            measurementTimingConfiguration: 10313ad005010081ec017400
                                                                MeasurementTimingConfiguration
                                                                    criticalExtensions: c1 (0)
                                                                        c1: measTimingConf (0)
                                                                            measTimingConf
                                                                                measTiming: 1 item
                                                                                    Item 0
                                                                                        MeasTiming
                                                                                            frequencyAndTiming
                                                                                                carrierFreq: 644736
                                                                                                ssbSubcarrierSpacing: kHz30 (1)
                                                                                                ssb-MeasurementTimingConfiguration
                                                                                                    periodicityAndOffset: sf20 (2)
                                                                                                        sf20: 0
                                                                                                    duration: sf3 (2)
                                                                                            ssb-ToMeasure: mediumBitmap (1)
                                                                                                mediumBitmap: 80 [bit length 8, 1000 0000 decimal value 128]
                                                                                            physCellId: 186
                                                            iE-Extensions: 1 item
                                                                Item 0
                                                                    ProtocolExtensionField
                                                                        id: 223
                                                                        criticality: ignore (1)
                                                                        extensionValue
                                                                            BPLMN-ID-Info-List: 1 item
                                                                                Item 0
                                                                                    BPLMN-ID-Info-Item
                                                                                        pLMN-Identity-List: 1 item
                                                                                            Item 0
                                                                                                AvailablePLMNList-Item
                                                                                                    pLMNIdentity: 00f110
                                                                                                        Mobile Country Code (MCC): Unknown (001)
                                                                                                        Mobile Network Code (MNC): Unknown (01)
                                                                                        fiveGS-TAC: 1 (0x000001)
                                                                                        nr-cell-ID: 00009e0010 [bit length 36, 4 LSB pad bits, 0000 0000  0000 0000  1001 1110  0000 0000  0001 .... decimal value 647169]
                                                        gNB-DU-System-Information
                                                            mIB-message: 270504
                                                                MIB
                                                                    systemFrameNumber: 24 [bit length 6, 2 LSB pad bits, 0010 01.. decimal value 9]
                                                                    subCarrierSpacingCommon: scs30or120 (1)
                                                                    ssb-SubcarrierOffset: 8
                                                                    dmrs-TypeA-Position: pos2 (0)
                                                                    pdcch-ConfigSIB1
                                                                        controlResourceSetZero: 5
                                                                        searchSpaceZero: 0
                                                                    cellBarred: barred (0)
                                                                    intraFreqReselection: notAllowed (1)
                                                                    spare: 00 [bit length 1, 7 LSB pad bits, 0... .... decimal value 0]
                                                            sIB1-message: ba040480410010080000080004f000c004280084086004842680c0000188302259afe80dc1008000088a0001041a42830110243a8002100001886ae044b33a49802a703ab7121f010424e9046e10dc31b8837146cb55706ae8049501d0049405402262a6e628
                                                                SIB1
                                                                    cellSelectionInfo
                                                                        q-RxLevMin: -140dBm (-70)
                                                                        q-QualMin: -25 dB
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
                                                                                    cellIdentity: 00009e0010 [bit length 36, 4 LSB pad bits, 0000 0000  0000 0000  1001 1110  0000 0000  0001 .... decimal value 647169]
                                                                                    cellReservedForOperatorUse: notReserved (1)
                                                                    si-SchedulingInfo
                                                                        schedulingInfoList: 1 item
                                                                            Item 0
                                                                                SchedulingInfo
                                                                                    si-BroadcastStatus: broadcasting (0)
                                                                                    si-Periodicity: rf32 (2)
                                                                                    sib-MappingInfo: 3 items
                                                                                        Item 0
                                                                                            SIB-TypeInfo
                                                                                                type: sibType2 (0)
                                                                                                valueTag: 0
                                                                                        Item 1
                                                                                            SIB-TypeInfo
                                                                                                type: sibType4 (2)
                                                                                                valueTag: 0
                                                                                        Item 2
                                                                                            SIB-TypeInfo
                                                                                                type: sibType5 (3)
                                                                                                valueTag: 0
                                                                        si-WindowLength: s5 (0)
                                                                    servingCellConfigCommon
                                                                        downlinkConfigCommon
                                                                            frequencyInfoDL
                                                                                frequencyBandList: 1 item
                                                                                    Item 0
                                                                                        NR-MultiBandInfo
                                                                                            freqBandIndicatorNR: 78
                                                                                offsetToPointA: 24 PRBs
                                                                                scs-SpecificCarrierList: 1 item
                                                                                    Item 0
                                                                                        SCS-SpecificCarrier
                                                                                            offsetToCarrier: 0
                                                                                            subcarrierSpacing: kHz30 (1)
                                                                                            carrierBandwidth: 273
                                                                            initialDownlinkBWP
                                                                                genericParameters
                                                                                    locationAndBandwidth: 1099
                                                                                    subcarrierSpacing: kHz30 (1)
                                                                                pdcch-ConfigCommon: setup (1)
                                                                                    setup
                                                                                        controlResourceSetZero: 10
                                                                                        searchSpaceZero: 0
                                                                                        commonSearchSpaceList: 1 item
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
                                                                                                        aggregationLevel4: n4 (4)
                                                                                                        aggregationLevel8: n2 (2)
                                                                                                        aggregationLevel16: n1 (1)
                                                                                                    searchSpaceType: common (0)
                                                                                                        common
                                                                                                            dci-Format0-0-AndFormat1-0
                                                                                        searchSpaceSIB1: 0
                                                                                        searchSpaceOtherSystemInformation: 1
                                                                                        pagingSearchSpace: 1
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
                                                                                                    startSymbolAndLength: 96
                                                                                            Item 2
                                                                                                PDSCH-TimeDomainResourceAllocation
                                                                                                    mappingType: typeA (0)
                                                                                                    startSymbolAndLength: 68
                                                                            bcch-Config
                                                                                modificationPeriodCoeff: n2 (0)
                                                                            pcch-Config
                                                                                defaultPagingCycle: rf32 (0)
                                                                                nAndPagingFrameOffset: oneSixteenthT (4)
                                                                                    oneSixteenthT: 3
                                                                                ns: one (2)
                                                                                firstPDCCH-MonitoringOccasionOfPO: sCS480KHZoneT-SCS120KHZquarterT-SCS60KHZoneEighthT-SCS30KHZoneSixteenthT (5)
                                                                                    sCS480KHZoneT-SCS120KHZquarterT-SCS60KHZoneEighthT-SCS30KHZoneSixteenthT: 1 item
                                                                                        Item 0
                                                                                            sCS480KHZoneT-SCS120KHZquarterT-SCS60KHZoneEighthT-SCS30KHZoneSixteenthT item: 2
                                                                        uplinkConfigCommon
                                                                            frequencyInfoUL
                                                                                scs-SpecificCarrierList: 1 item
                                                                                    Item 0
                                                                                        SCS-SpecificCarrier
                                                                                            offsetToCarrier: 0
                                                                                            subcarrierSpacing: kHz30 (1)
                                                                                            carrierBandwidth: 273
                                                                                p-Max: 23 dBm
                                                                            initialUplinkBWP
                                                                                genericParameters
                                                                                    locationAndBandwidth: 1099
                                                                                    subcarrierSpacing: kHz30 (1)
                                                                                rach-ConfigCommon: setup (1)
                                                                                    setup
                                                                                        rach-ConfigGeneric
                                                                                            prach-ConfigurationIndex: 147
                                                                                            msg1-FDM: one (0)
                                                                                            msg1-FrequencyStart: 2
                                                                                            zeroCorrelationZoneConfig: 10
                                                                                            preambleReceivedTargetPower: -90 dBm
                                                                                            preambleTransMax: n6 (3)
                                                                                            powerRampingStep: dB4 (2)
                                                                                            ra-ResponseWindow: sl20 (5)
                                                                                        ssb-perRACH-OccasionAndCB-PreamblesPerSSB: one (3)
                                                                                            one: n32 (7)
                                                                                        groupBconfigured
                                                                                            ra-Msg3SizeGroupA: b144 (1)
                                                                                            messagePowerOffsetGroupB: dB0 (1)
                                                                                            numberOfRA-PreamblesGroupA: 4
                                                                                        ra-ContentionResolutionTimer: sf64 (7)
                                                                                        rsrp-ThresholdSSB: SS-RSRP < -156dBm (0)
                                                                                        prach-RootSequenceIndex: l139 (1)
                                                                                            l139: 4
                                                                                        msg1-SubcarrierSpacing: kHz30 (1)
                                                                                        restrictedSetConfig: unrestrictedSet (0)
                                                                                pusch-ConfigCommon: setup (1)
                                                                                    setup
                                                                                        pusch-TimeDomainAllocationList: 5 items
                                                                                            Item 0
                                                                                                PUSCH-TimeDomainResourceAllocation
                                                                                                    k2: 1
                                                                                                    mappingType: typeA (0)
                                                                                                    startSymbolAndLength: 27
                                                                                            Item 1
                                                                                                PUSCH-TimeDomainResourceAllocation
                                                                                                    k2: 2
                                                                                                    mappingType: typeA (0)
                                                                                                    startSymbolAndLength: 27
                                                                                            Item 2
                                                                                                PUSCH-TimeDomainResourceAllocation
                                                                                                    k2: 3
                                                                                                    mappingType: typeA (0)
                                                                                                    startSymbolAndLength: 27
                                                                                            Item 3
                                                                                                PUSCH-TimeDomainResourceAllocation
                                                                                                    k2: 4
                                                                                                    mappingType: typeA (0)
                                                                                                    startSymbolAndLength: 27
                                                                                            Item 4
                                                                                                PUSCH-TimeDomainResourceAllocation
                                                                                                    k2: 5
                                                                                                    mappingType: typeA (0)
                                                                                                    startSymbolAndLength: 27
                                                                                        msg3-DeltaPreamble: 0dB (0)
                                                                                        p0-NominalWithGrant: -96 dBm
                                                                                pucch-ConfigCommon: setup (1)
                                                                                    setup
                                                                                        pucch-ResourceCommon: 12
                                                                                        pucch-GroupHopping: neither (0)
                                                                                        p0-nominal: -96 dBm
                                                                            timeAlignmentTimerCommon: infinity (7)
                                                                        ssb-PositionsInBurst
                                                                            inOneGroup: 80 [bit length 8, 1000 0000 decimal value 128]
                                                                        ssb-PeriodicityServingCell: ms20 (2)
                                                                        tdd-UL-DL-ConfigurationCommon
                                                                            referenceSubcarrierSpacing: kHz30 (1)
                                                                            pattern1
                                                                                dl-UL-TransmissionPeriodicity: ms2p5 (5)
                                                                                nrofDownlinkSlots: 3
                                                                                nrofDownlinkSymbols: 10
                                                                                nrofUplinkSlots: 1
                                                                                nrofUplinkSymbols: 2
                                                                            pattern2
                                                                                dl-UL-TransmissionPeriodicity: ms2p5 (5)
                                                                                nrofDownlinkSlots: 2
                                                                                nrofDownlinkSymbols: 10
                                                                                nrofUplinkSlots: 2
                                                                                nrofUplinkSymbols: 2
                                                                        ss-PBCH-BlockPower: -11 dBm
                                                                    ims-EmergencySupport: true (0)
                                                                    ue-TimersAndConstants
                                                                        t300: ms1000 (5)
                                                                        t301: ms200 (1)
                                                                        t310: ms1000 (5)
                                                                        n310: n10 (6)
                                                                        t311: ms10000 (3)
                                                                        n311: n1 (0)
                                                                        t319: ms1000 (5)

【Output OAI conf】
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

    nr_cellid = 647169L;

    ////////// Physical parameters:

    min_rxtxtime = 6;

    servingCellConfigCommon = (
    {
 #spCellConfigCommon

      physCellId                                               = 186;

#  downlinkConfigCommon
    #frequencyInfoDL
      # this is 3600 MHz + 43 PRBs@30kHz SCS (same as initial BWP)
      absoluteFrequencySSB                                      = 644736;
      dl_frequencyBand                                          = 78;
      # this is 3600 MHz
      dl_absoluteFrequencyPointA                                = 647484;
      #scs-SpecificCarrierList
        dl_offstToCarrier                                       = 0;
# subcarrierSpacing
# 0=kHz15, 1=kHz30, 2=kHz60, 3=kHz120
        dl_subcarrierSpacing                                    = 1;
        dl_carrierBandwidth                                     = 273;
     #initialDownlinkBWP
      #genericParameters
        # this is RBstart=27,L=48 (275*(L-1))+RBstart
        initialDLBWPlocationAndBandwidth                         = 1099; # 6366 12925 12956 28875 12952
# subcarrierSpacing
# 0=kHz15, 1=kHz30, 2=kHz60, 3=kHz120
        initialDLBWPsubcarrierSpacing                             = 1;
      #pdcch-ConfigCommon
        initialDLBWPcontrolResourceSetZero                        = 10;
        initialDLBWPsearchSpaceZero                               = 0;

  #uplinkConfigCommon
     #frequencyInfoUL
      ul_frequencyBand                                             = 78;
      #scs-SpecificCarrierList
      ul_offstToCarrier                                            = 0;
# subcarrierSpacing
# 0=kHz15, 1=kHz30, 2=kHz60, 3=kHz120
      ul_subcarrierSpacing                                         = 1;
      ul_carrierBandwidth                                          = 273;
      pMax                                                         = 23;
     #initialUplinkBWP
      #genericParameters
        initialULBWPlocationAndBandwidth                           = 1099;
# subcarrierSpacing
# 0=kHz15, 1=kHz30, 2=kHz60, 3=kHz120
        initialULBWPsubcarrierSpacing                              = 1;
      #rach-ConfigCommon
        #rach-ConfigGeneric
          prach_ConfigurationIndex                                 = 147;
#prach_msg1_FDM
#0 = one, 1=two, 2=four, 3=eight
          prach_msg1_FDM                                           = 0;
          prach_msg1_FrequencyStart                                = 2;
          zeroCorrelationZoneConfig                                = 10;
          preambleReceivedTargetPower                              = -90;
#preamblTransMax (0...10) = (3,4,5,6,7,8,10,20,50,100,200)
          preambleTransMax                                         = 6;
#powerRampingStep
# 0=dB0,1=dB2,2=dB4,3=dB6
        powerRampingStep                                           = 2;
#ssb_perRACH_OccasionAndCB_PreamblesPerSSB_PR
#1=oneeighth,2=onefourth,3=half,4=one,5=two,6=four,7=eight,8=sixteen
        ssb_perRACH_OccasionAndCB_PreamblesPerSSB_PR               = 4;
#one (0..15) 4,8,12,16,...60,64
        ssb_perRACH_OccasionAndCB_PreamblesPerSSB                  = 7;
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
        p0_NominalWithGrant                                        =-96;

# pucch-ConfigCommon setup :
# pucchGroupHopping
# 0 = neither, 1= group hopping, 2=sequence hopping
        pucchGroupHopping                                          = 0;
        hoppingId                                                  = 40;
        p0_nominal                                                 = -96;

      ssb_PositionsInBurst_Bitmap                                  = 128;

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
      # ext: 8=ms3, 9=ms4
      dl_UL_TransmissionPeriodicity                                = 5;
      nrofDownlinkSlots                                            = 3;
      nrofDownlinkSymbols                                          = 10;
      nrofUplinkSlots                                              = 1;
      nrofUplinkSymbols                                            = 2;

      # pattern2
      pattern2: {
        dl_UL_TransmissionPeriodicity2                             = 5;
        nrofDownlinkSlots2                                         = 2;
        nrofDownlinkSymbols2                                       = 10;
        nrofUplinkSlots2                                           = 2;
        nrofUplinkSymbols2                                         = 2;
      };

      ssPBCH_BlockPower                                            = -11;
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

要修改
prach_ConfigurationIndex = 147; 改成 75
dl_absoluteFrequencyPointA = 647484; 改成 644208
```