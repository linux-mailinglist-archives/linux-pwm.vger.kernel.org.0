Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517065FBC2F
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Oct 2022 22:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJKUgI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Oct 2022 16:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJKUfq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Oct 2022 16:35:46 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2138.outbound.protection.outlook.com [40.107.114.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744D032A9F;
        Tue, 11 Oct 2022 13:35:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kazkr3uzCFLAmh34B5FxCZxp8FQVdfl32R1Bf4tvKEUaEZ9X30qlV9J3kc44tBrm1q5hKHAailzaa8LxBjFHbkt0n9uB6Er9GMIs7w2eISt/v7tLv5wILZ4KsjljCX29Fcc4OiobCf0AgdzVA98zA5qd/fxkHKCZ/jiFq+vLRXD2PmFPWBh0tMZLG2RC8CaE/tB2EAVceoxwMWIVtV4RmXcqqru5+UuuFR01DG1Bb/t+OMsovWjpr566ykQCj4KyuNnakS6HT2cUHqo4j+G4i77+6Q3fkIkSwb4J35VFxNkz6Jk4rmzYRNv9mxFNQq4kVTKspovTmuRxAVuo5B9J2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxGduLj17EufLm+UqjWKovBk/Xg4NDOQPOseWpsDafI=;
 b=IZvb7xfnR0G0msTW6lKRb1ZU5jYCq7BSMVETlRZZO14rRqCjtyx9LbIYHe25IB0vvnWvYZD2+XjkZkzyqvSgbK4HKjUQ2OJXxHTrJTJRFY8+rDuNKotFC4/lqjnX95afNf1yL15Q0PuzV/GYOuZ6CiB/C6yD6lC8eJW2bzFeSQL1ZdgibUb78BVo72suRb/WzAMA6XqkD09sMEUuMD5QaZaf5wFj7JNLNjYoSBHkj7PgXjY8feld88HYx/iiVp0bcsK3ZKYymXZC6sL3koU+pnCoGc49qsgUdF2lwxP3+tFm7q9toqvmLM2c/yyLW+W24kUvWHYGzoxhnfUbjCrOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxGduLj17EufLm+UqjWKovBk/Xg4NDOQPOseWpsDafI=;
 b=LCadYsMi/IKcY9CnfZJN0cpsHJod8cSG5HrJSM4rGAdt1zaqmRNaqMt3Xa38cdUds+uq02RhbXysMn7VGjWkDTceN2NElNXqJchbE7FNoMw47Dx41SJZ0ROB05H/cDtjkUlJZus4x1f28swrpB7yBE0KlV0tKDii2NEikWKevEg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9664.jpnprd01.prod.outlook.com (2603:1096:400:22b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 20:35:37 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%8]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 20:35:36 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Lee Jones <lee@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
Thread-Topic: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
Thread-Index: AQHY3Lf1ZjO75wmqM0qPUfqcMk9xD64JjDKAgAACnKCAABKoAIAAATcwgAADlICAAAF6AA==
Date:   Tue, 11 Oct 2022 20:35:36 +0000
Message-ID: <OS0PR01MB5922E406D2711AA6B8CD632C86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-5-biju.das.jz@bp.renesas.com>
 <b701187b-d2aa-eecc-0052-d611d1f45807@linaro.org>
 <OS0PR01MB59227CF4B0D4CA846E24298C86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <219922df-5bba-e6ae-fa89-60a9b319424b@linaro.org>
 <OS0PR01MB592269EB3BAE686A2F74B48286239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <f12dfcd3-ef5c-b422-c00c-35cef082a3ff@linaro.org>
In-Reply-To: <f12dfcd3-ef5c-b422-c00c-35cef082a3ff@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9664:EE_
x-ms-office365-filtering-correlation-id: 4d02d1e6-b95b-4c5e-fe31-08daabc82756
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QFVvAT2UmuWfaeB7P/Ke7OSxiCO+kAey7JDyrI1sqmrcClpxKwSTtfLKDAFceI7dy6zQWP1r4Rye5rALLAql35XijRjGcXT0KxSMAhb340YuOn15tNnXaNpMsjIDY+tKsq3ag2nDVewlcFgOhdmNmMUqb9tqe78lhTsAALhvrnssG3V1kvkVm2u/Agdtkhc0pbh3p+gDYLK1Tqe4V6LZ0FKxrbxsD4w2IypjgvY3wXRrQrAgFaq/hrzYsghDA3bzJhiRGFFbXKeuRXDojhqfjyr3hqWMbN0TissPBYTi9F3/fnp4nre8mSz+HYCp/UEqLKyp68UInELHVmCiJB2dJIi7vRYlFnO+/2IbVAqnWokF3E6zidyTAqqP2GOyhwxvulVd9Uz1OXyxLMbOyLIo+UpC7tEplo+iGZAQqWREUodPQ0nvvd/ziZ0EdkMX+yj690DXMp4JvV0wBPuut0xrlDXtiOjh0PbVlGjaekgOj1/Bruv3CbIuzYIXo3azC3Ud+oVhDIlAegoXdhDYxSBUlgaSjCP3jYSCV9bf+nv6Ds9MHbAplRoSvFI/rNscyP16rtMoq4YhpQ8o/XkMYMdfLYG3bjHeNkx0FKPdlFbeyz9t9aBDVHN7GpC195it3J5P5fVnop99/Il41nbiIEy/jBwDz8XuxBdYQzWpv0GughDPNqB+QjbxPrg9brmG5bRD+MbaiQMoz/ExXbPt4Mn6/Y9pbnM8U/X81blDaMjGuvsWnGKQLluTXY32vzTeVtyQkJbniO8ALZi/QMzk0WKweg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199015)(9686003)(2906002)(52536014)(8936002)(26005)(76116006)(5660300002)(4326008)(66946007)(8676002)(53546011)(66446008)(7696005)(6506007)(64756008)(66556008)(41300700001)(66476007)(122000001)(86362001)(38100700002)(38070700005)(186003)(83380400001)(55016003)(33656002)(478600001)(71200400001)(316002)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEVOd2ZZd3kzSytMZkhUbVRrSHVKN1BIVGdrTVAzL1FwcXJzZW9kR2lxWFBx?=
 =?utf-8?B?d2hsWHpWY05YSXZBQmdMS2lWS3lQRWxGMTkxd2swN2pmcEQ4TWs5a0NpeVYw?=
 =?utf-8?B?cFY2Qk9WZnBsWnhvVTkvdHowZ0trc1RNSXBxK1NjQUJpOFQ0ZDU2bTdjSWpM?=
 =?utf-8?B?NWk4cDlXTXIvSTl2eXFMN3NoUkRlRzN4Yys5SHB1OG1LUkM2NkI0REZWS052?=
 =?utf-8?B?YlBUV0ZaV2xFTXNnendJMmJEc0VkZkJlVzBacG53Q3E5TkZTK0p6Z0gzZjZu?=
 =?utf-8?B?ck1NaWpWS2FPdnlCTjlRUUV2UEkxQ2FTRnNtZkdEaXBoQmtmTEJZYlZESTRx?=
 =?utf-8?B?QmZ2TjFiL1J5RUZMK29BODZPOVAySERvaE1NVVJZMk9NQVhXWnM4Qmp5TDhl?=
 =?utf-8?B?Mm4ya3V2VktGVDd2WmxCQ3QxUE9TREd4dFRTWk9hQ0pHUkt1RGh0ajYzZXJ5?=
 =?utf-8?B?K1ZJQ2FxcHAwU3FPT2NlazlYQktWWnIzaG9CTmtIWVNiM0trM3dNb3Y4dHVX?=
 =?utf-8?B?K2UrNFhuVDEzVGk2NEdGMUtscmhkMTJHdFhadnVnNEROZENSVkVFaWF4V3Y2?=
 =?utf-8?B?SHp1QW5ZZ0lDbm85VWJLQloySHRmVVVSS2g3Tnh0Y1lFTkxwMnBnQnM1WjNi?=
 =?utf-8?B?QjhTT04zTzErdEhPamszY0FnL2hINWp6THdLWDF2aGIwdURWN0ZYdkhUdHMx?=
 =?utf-8?B?YzNIV1pBdTZ0QnUwVFlRZlhBWTJtQ29VTk5xYlJ2WWN4UVBBVGNxMkNxYVRC?=
 =?utf-8?B?STdmTVVNanY3SzBaMFBkNng3bzkzVVUzMXJxWVRpTjRnaUhSUSs5M1VBL0cz?=
 =?utf-8?B?UWlNQkw0cy8vRkpRMnE0c0UwSkc2V2lRWHFyU2ZKN1VoRFNidjNaa3d3T3hv?=
 =?utf-8?B?N1E3WEo3eVBwczJRS3p4akgzT0R2RzB1RUs3djVyUWcyN2VlVkkwQm5aWVFm?=
 =?utf-8?B?SDBjV0JaZ3dsNHhIT0NxcHZBdytFYnI2eVV3NHFEY1REdHMvTTIxZVppU2d5?=
 =?utf-8?B?cUI4S1I4dVJHbHNMY05Nc1l0RXJ2QkhDNlhMTTR0VFNBRmR0Rnk2VG45SDVP?=
 =?utf-8?B?SFU5QldlSXpOOFdHcjBGeHMzT21iNW9iZGpRbFVlSHZUNTZTeUJqZFZqWVhU?=
 =?utf-8?B?TDFxU091aURmUkZZQkJNV0ZvcHJZek9GNEJvN1dibXR6dllMMEFnbU95YSsr?=
 =?utf-8?B?UndTbDdtaXEvM1FvellWcFNQaUZud09ueTlPVWRzelRsN2wrM0tkeUR4d09E?=
 =?utf-8?B?RVhkWWJCN3lUNmI1Zmx0NXE5bGZHUmhoc2NhSlovNG5HZEc3K29sZ2VSUkpY?=
 =?utf-8?B?UldZdUxocDcyanpGWXJ6OUNWUS9kMmhMcTFNSzBPMVZaakRQTG9QRGU1N0pq?=
 =?utf-8?B?ZDVUR0dDUExZQk1UTlRDWUtHWHNOTEF0d3dmY2NvMGFMbk5KSERmanJXakxt?=
 =?utf-8?B?K3B6d0dkcXNaUUJ3TDdRbHJITUF4cGh3Z1NtTHY5WGxlWUNybGtmVWlKR2hq?=
 =?utf-8?B?N3c2eVhKS3lQVzJQaGFuSHpNRjRzV1F0Q2dHSmJwT1RYZG1CZXBpUDVxWkZv?=
 =?utf-8?B?bCtVOUpvVGxOOENiaG9lT2VhUFpIa3dDUkN5Vkw0QmdJQ3RHZE43MTBwNXJC?=
 =?utf-8?B?SWx4dTl0T09ieTNMZHMwZXdraWplZnVySW5JSS91UWRrTmdkM2RVU0x0V3lI?=
 =?utf-8?B?S1N0TWJYcWpYRUpvcy9BR0t5d0pBYlpuK2RubHpVb1hYdFUyMXhIZWhMK0JI?=
 =?utf-8?B?ZGNFNmo4VGJSMUdTMjEvbHJ2WDJrSExyWW9KYXM5dVloam1mUHoxUWphTnNE?=
 =?utf-8?B?SUJ6YTNTZ1crWUI2TWxlNmdkUy8xMkRMRWpSaUNiN0E0T0xiRERCUXdiQ2dh?=
 =?utf-8?B?Q2ZHUXR4aEE4SDgyTjlPY0VUQ2IzTWpOS21rNUprSTN0YitYNjRNQlQyak5F?=
 =?utf-8?B?eXB3Z1BzRnFzZk9WMG5jL1RiOUZRY3JldTRHNllneEtLaEh0cGpIS2V6eENq?=
 =?utf-8?B?V0ExMkg3eERSeEJwL1djMWt3Vmp3Ym5pVmVESEpSeEhDL3FNa2RkM0d5TUxF?=
 =?utf-8?B?MXRrSHF1RDZ5eVJNR2xYbWRZMDZ3K09RNW44V2k3Z0dob1M2TG5YNThQSlhR?=
 =?utf-8?B?ZTZTWXkyUzdNQjBZdlB2dDFRYXIyUDJndkZPUytUeDcvaU15Ymxwc05uLy9G?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d02d1e6-b95b-4c5e-fe31-08daabc82756
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 20:35:36.8011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYVKXzqX07/jXYI1/biGZA8l02E5NBOhnBSNE+yzBgEVRSGT06XMzRucAHYzUJhLpCK9X8P15+NZFRaPNLNFI1t6H48z4p4duiccrC9Eq7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9664
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDQvNF0gbWZkOiBBZGQgUlovRzJMIE1UVTMgUFdNIGRy
aXZlcg0KPiANCj4gT24gMTEvMTAvMjAyMiAxNjoxOCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNC80XSBtZmQ6IEFkZCBSWi9HMkwgTVRVMyBQV00gZHJpdmVy
DQo+ID4+DQo+ID4+IE9uIDExLzEwLzIwMjIgMTU6MTMsIEJpanUgRGFzIHdyb3RlOg0KPiA+Pj4+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNC80XSBtZmQ6IEFkZCBSWi9HMkwgTVRVMyBQV00gZHJp
dmVyDQo+ID4+Pj4NCj4gPj4+PiBPbiAxMC8xMC8yMDIyIDEwOjUyLCBCaWp1IERhcyB3cm90ZToN
Cj4gPj4+Pj4gQWRkIHN1cHBvcnQgZm9yIFJaL0cyTCBNVFUzIFBXTSBkcml2ZXIuIFRoZSBJUCBz
dXBwb3J0cw0KPiBmb2xsb3dpbmcNCj4gPj4+PiBQV00NCj4gPj4+Pj4gbW9kZXMNCj4gPj4+Pj4N
Cj4gPj4+Pj4gMSkgUFdNIG1vZGV7MSwyfQ0KPiA+Pj4+PiAyKSBSZXNldC1zeW5jaHJvbml6ZWQg
UFdNIG1vZGUNCj4gPj4+Pj4gMykgQ29tcGxlbWVudGFyeSBQV00gbW9kZXsxLDIsM30NCj4gPj4+
Pj4NCj4gPj4+Pj4gVGhpcyBwYXRjaCBhZGRzIGJhc2ljIHB3bSBtb2RlIDEgc3VwcG9ydCBmb3Ig
UlovRzJMIE1UVTMgZHJpdmVyDQo+IGJ5DQo+ID4+Pj4+IGNyZWF0aW5nIHNlcGFyYXRlIGxvZ2lj
YWwgY2hhbm5lbHMgZm9yIGVhY2ggSU9zLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5
OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4+Pj4+IC0tLQ0KPiA+
Pj4+PiB2My0+djQ6DQo+ID4+Pj4+ICAqIFRoZXJlIGlzIG5vIHJlc291cmNlIGFzc29jaWF0ZWQg
d2l0aCAicnotbXR1My1wd20iIGNvbXBhdGlibGUNCj4gPj4+Pj4gICAgYW5kIG1vdmVkIHRoZSBj
b2RlIHRvIG1mZCBzdWJzeXN0ZW0gYXMgaXQgYmluZHMgYWdhaW5zdCAicnotDQo+ID4+IG10dSIu
DQo+ID4+Pj4+ICAqIFJlbW92ZWQgc3RydWN0IHBsYXRmb3JtX2RyaXZlciByel9tdHUzX3B3bV9k
cml2ZXIuDQo+ID4+Pj4+IHYyLT52MzoNCj4gPj4+Pj4gICogTm8gY2hhbmdlLg0KPiA+Pj4+PiB2
MS0+djI6DQo+ID4+Pj4+ICAqIE1vZGVsbGVkIGFzIGEgc2luZ2xlIFBXTSBkZXZpY2UgaGFuZGxp
bmcgbXVsdGlwbGUgY2hhbm5sZXMuDQo+ID4+Pj4+ICAqIFVzZWQgUE0gZnJhbWV3b3JrIHRvIG1h
bmFnZSB0aGUgY2xvY2tzLg0KPiA+Pj4+PiAtLS0NCj4gPj4+Pj4gIGRyaXZlcnMvbWZkL0tjb25m
aWcgICAgICAgfCAgIDYgKw0KPiA+Pj4+PiAgZHJpdmVycy9tZmQvTWFrZWZpbGUgICAgICB8ICAg
MiArDQo+ID4+Pj4+ICBkcml2ZXJzL21mZC9yei1tdHUzLXB3bS5jIHwgNDA1DQo+ID4+Pj4+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+Pj4NCj4gPj4+PiBUaGF0
J3Mgbm90IGEgTUZEIGRyaXZlci4gVGhhdCdzIGEgUFdNLiBVc2UgcHJvcGVyIHN1YnN5c3RlbSBh
bmQNCj4gPj4gZW1haWwNCj4gPj4+PiBwcmVmaXguDQo+ID4+Pg0KPiA+Pj4gU2VlIFsxXQ0KPiA+
Pj4gWzFdDQo+ID4gPTAzcVNxYXg1dHI1dEF1REhCeXRuN3hIJTJCUzZvVTJ4Z3V1aTltcnNoSQ0K
PiA+Pj4gdENJJTNEJmFtcDtyZXNlcnZlZD0wDQo+ID4+Pg0KPiA+Pj4gSXQgaXMgYSBzaW5nbGUg
ZHJpdmVyIHRoYXQgYmluZHMgYWdhaW5zdCAicmVuZXNhcyxyei1tdHUzIiwgYW5kDQo+ID4+PiBy
ZWdpc3RlcnMgYm90aCB0aGUgY291bnRlciBhbmQgdGhlIHB3bSBmdW5jdGlvbmFsaXRpZXMuIEp1
c3QgbGlrZQ0KPiA+PiB0aGUgY2xvY2sgZHJpdmVyLCB3aGljaCByZWdpc3RlcnMgY2xvY2ssIHJl
c2V0LCBhbmQgUE0gRG9tYWluDQo+ID4+IGZ1bmN0aW9uYWxpdGllcy4NCj4gPj4NCj4gPj4gTm8s
IGl0IGlzIG5vdCBhIHNpbmdsZSBkcml2ZXIuIFlvdSBqdXN0IGFkZGVkIGEgbmV3IGZpbGUgLSBQ
V00uDQo+ID4NCj4gPiBJdCBpcyBhIHNpbmdsZSBkcml2ZXIgcnotbXR1LmtvIGJpbmRzIHdpdGgg
InJlbmVzYXMscnotbXR1MyINCj4gDQo+IEJpbmRpbmcgdG8gY29tcGF0aWJsZSBpcyBub3QgcmVh
bGx5IHJlbGF0ZWQuDQo+IA0KPiA+DQo+ID4+DQo+ID4+Pg0KPiA+Pj4gSXQgaXMgc2FtZSBoZXJl
LCBhIHNpbmdsZSBNRkQgZHJpdmVyIHdoaWNoIGJpbmRzIGFnYWluc3QNCj4gPj4+ICIicmVuZXNh
cyxyei1tdHUzIiBhbmQgcmVnaXN0ZXJzIGNvdW50ZXIgQW5kIHB3bSBmdW5jdGlvbmFsaXRpZXMu
DQo+ID4+Pg0KPiA+Pj4gcnotbXR1LWNvcmUgaXMgY29yZSBkcml2ZXIgd2hpY2ggcHJvdmlkZXMg
cmVzb3VyY2VzIHRvIGNoaWxkDQo+IGRldmljZXMNCj4gPj4gbGlrZSBjb3VudGVyIGFuZCBwd20u
DQo+ID4+Pg0KPiA+Pj4gSSBhbHJlYWR5IGNvcGllZCBQV00gc3Vic3lzdGVtIGluIHRoZSBsb29w
LiBBbSBJIG1pc3NpbmcgYW55dGhpbmcNCj4gPj4+IHJlbGF0ZWQgdG8gWzFdDQo+ID4+DQo+ID4+
IE1GRCBzdWJzeXN0ZW0gaXMgb25seSBhIHdyYXBwZXIvcGFyZW50IG92ZXIgYWN0dWFsIGRyaXZl
cnMuIEl0J3MNCj4gbm90DQo+ID4+IG1lYW50IHRvIGhvbGQgdGhlIHN1YnN5c3RlbS1zcGVjaWZp
YyBjb2RlLCBiZWNhdXNlIHJlbGV2YW50DQo+ID4+IG1haW50YWluZXJzIHdpbGwgbm90IGxvb2sg
aGVyZS4NCj4gPj4NCj4gPj4gU28gbm8sIGhlcmUgYW5kIGluIG90aGVyIGZpbGVzIC0gZG9uJ3Qg
cHV0IHN1YnN5c3RlbSBzcGVjaWZpYyBjb2RlDQo+ID4+IGxpa2UgUFdNIG9yIHRpbWVyIGludG8g
TUZELg0KPiA+DQo+ID4gV2hlcmUgc2hvdWxkIGRvIHdlIHB1dCwgaWYgdGhlcmUgaXMgc2luZ2xl
IGRyaXZlciB0byBiZSBiaW5kIGFnYWluc3QNCj4gPiAicmVuZXNhcyxyei1tdHUzIiBhbmQgcmVn
aXN0ZXIgZnVuY3Rpb25hbGl0aWVzIGZvciBwd20gYW5kIGNvdW50ZXI/Pw0KPiANCj4gQWdhaW4g
LSBob3cgYmluZGluZyBpcyByZWxhdGVkIHRvIHRoaXMgcHJvYmxlbT8gSWYgeW91IGhhdmUgc2Vw
YXJhdGUNCj4gZHJpdmVycywgZS5nLiBjb3VudGVyLCB0aW1lciBhbmQgUFdNLCBhbGwgZ28gdG8g
dGhlaXIgcmVzcGVjdGl2ZQ0KPiBzdWJzeXN0ZW1zLiBDb3VudGVyIGdvZXMgdG8gY291bnRlciwg
dGltZXIgdG8gdGltZXIsIFBXTSB0byBwd20uDQoNCkhvdyBkbyB5b3UgaW5zdGFudGlhdGUgdGhl
c2UgZHJpdmVycyB3aXRoIGEgc2luZ2xlIGNvbXBhdGlibGUgInJlbmVzYXMscnotbXR1MyI/DQpJ
ZiBpdCBpcyBzZXBhcmF0ZSBkcml2ZXJzLg0KDQpQbGVhc2UgbGV0IG1lIGtub3cuDQoNCkNoZWVy
cywNCkJpanUNCg0K
