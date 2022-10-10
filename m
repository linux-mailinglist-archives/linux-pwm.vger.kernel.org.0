Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1405FA0F7
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Oct 2022 17:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJJPNs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Oct 2022 11:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJJPNr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Oct 2022 11:13:47 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2098.outbound.protection.outlook.com [40.107.114.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58337356CB;
        Mon, 10 Oct 2022 08:13:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lt6xOdU+GxEtR4/W8wEE+3KzOSeslEobbdYfg3TSzNWKhNTufVR0NKJlG8dPcaAPPRqqN+LbqGQBMumUT6uOuAUxQkV+qYFSqbCKJJ9LfSEE1JbU0DVxHHajG06nJfkrVFUnQsluK51VTypapBVBI/JCs0ENdyICvB01MFuby3H5KE8QqpSzyCCB5VZVwonUGBxibrUgST2ACwUSk1O5ZSghBNgBEB2t8voj3AZouaQxnPa6AWL1+RkSp7rfz3VCfc1fbtkIby0kOC6PnuDdQdyJSEEvWorKZ8SWo0iay7QKAURRwXcFD4+X4NgyuIQe0PW50T5k7u9x55aPFDnPxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGBAHluOzxlYrbU1+BlIwp/P6rC5KBgs3imAfKo6IQQ=;
 b=IFM38mXTHCNrIR34NEZJW5RSLb4b52/PWESRViOnQH4s1G0XJbQG4WDt75XhUV6BwafhVmAv0F7CAyHA1AOch4CKLzb16BTpn7jn8igzrgZiy+KocxMyiHXlupVU6NnMZqixL/URPZu3TKMLxHBdoWxWP8InkhcG9TFRXEPwoYa61a/h+ZeS//BEUp0wzAUqG6eqk2YwpSq3sfgg6hVr2NGyXaNMzWF9iFmiAEYkcJw2jxodDA3ZHzSwHZrYbhYhYjRjpEIA2YxXdc2wbuISm6jEWRabaoPrBVVEKg5FQG7Ls87lSUh4VjVYh/FDuO1xj1WC2jcvNe1c945oofFw6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGBAHluOzxlYrbU1+BlIwp/P6rC5KBgs3imAfKo6IQQ=;
 b=a1DbbJTY1QKqtBGWT7pWrQkkh9+SG0wvHJRX+qVK7fGwnAvLywI8pBpXfxGuTlOwI8fL05T6bQomqZyIBPNAGfQ9DvkAQ59Libf+dDqZT6vGYdh752LXSa0o//dkI5BOy6VEKAHvQdneMoM7mQkkdCMhrzko7xCqIW0hBzRr9pk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 15:13:44 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%9]) with mapi id 15.20.5709.019; Mon, 10 Oct 2022
 15:13:42 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Topic: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Index: AQHY2YuXPmW6g+v5akyG0CoeRXz0kq4Bzk0AgAEPNNCAAT9J8IACFFSAgAGPMsA=
Date:   Mon, 10 Oct 2022 15:13:42 +0000
Message-ID: <OS0PR01MB592241145883E6862C3BF50286209@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
 <20221006135717.1748560-2-biju.das.jz@bp.renesas.com>
 <20221006201746.GA93297-robh@kernel.org>
 <OS0PR01MB5922F8058FC8FD1E35C17755865F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB59221BDEB7E6B39AEFD31C44865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <8b4a2bfd-ce7f-6bb9-4e50-ecd9bda881a2@linaro.org>
In-Reply-To: <8b4a2bfd-ce7f-6bb9-4e50-ecd9bda881a2@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9889:EE_
x-ms-office365-filtering-correlation-id: 13e38223-6e06-4c9d-a247-08daaad204ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P0m1zBxVkjf+NCITxz0CqJUPkVwmFj7WvYTrDsLPuNJi0illTCAGr8mvFuqpBy3RQcVfFbDfq2IOm+v3P70OTfKW3r2iI/CdiRmdP7P75porsaU9Oo++cOsZZ8JN0LaEenJF62JqPz1IDKeiHcH6LZEIyR/AiaZ1vg78YN0kkMUU3Unab8+Ad22CqGoSXWCbw8h3PVRVjj8DNE1FwzAaNrqzSyFqQWuJN0n7MVKl2n2xb+5Gmi7mR7QEwjMLU8YOO+RYA8b69K6vq3xGTuuyBN9i5wRGXCTs0C0ZbEzJjjTbmIRZH+wnRohCj9MPe65Yr9EWcJKEcVUQXUpHleiowF2IAbDF4y8fs/KbMWSt925cP55+A6UxjckBozyNM+D5zmqcVRm/F3GHQjnrg6xv74RnLJ+33EBhPe3mUo2fROQWA8i6F1KY8rxmG/WiTVx31ToGVFHBu+f8X/CrGtll19tI2pid1EflYwVEtDc5o9n3H+5VU83jU7bI6QxhtTbDEo9muJm2TUSoSwKmEf+4/FPCu6zKtJPRx7ItgoNJrrDrmuM/T6MAMvKmNiYiPmK+MyzkreO4X9OlLqbJn718XN395wpHnI2Bjur7S8ReoI18r2EVXTkE9EK6OvEo9DGKJNvez3xQBzwW1feIk0rNt/deF45ezdEkNIiTQE1BBobaQlJFFEX3mYQjHb+3eOzdE5nzS3H1xr/O1OJfgIqq7Zxvj/8jFlWVTS1pWkAGkGDvyTQDGx1ctAcLiwJdYAeZr+tgf5mq8sIK7ehtrTTZETpdVeLn4Yso2Mi+3YnBGrKJFMVt6meYpujtB1W0LBl1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199015)(6506007)(7696005)(53546011)(26005)(66556008)(38100700002)(55016003)(122000001)(316002)(86362001)(71200400001)(8676002)(66446008)(4326008)(64756008)(66946007)(76116006)(966005)(66476007)(38070700005)(33656002)(83380400001)(186003)(478600001)(2906002)(54906003)(5660300002)(52536014)(110136005)(8936002)(7416002)(9686003)(41300700001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RkFSWVJLVEpMRjlTeVBBY3VDcGFUSllDWEVWd2owTHk5TWlvNmk0bzYwOHBP?=
 =?utf-8?B?TW91QWYvYW9rb013Ykx4VkdXaHYreHAydVptQXJ0K3VOMHc0RStkTHFCL1k4?=
 =?utf-8?B?dGNHZFBwRkxXWkRkZnBiZjgzK3pRWVFnOXhRcU5LeWtGSVltemlIZ2JUV2Jq?=
 =?utf-8?B?V2NUUTNtbGg5RFczNG1ic294azNMK2hJRXh3bml6Z0RqZllPOGRBMDZON0tF?=
 =?utf-8?B?TEE1RVVsdEIyUkx3Y2htN3Q5aHMvbGJRaGlVdjd3SVVoUDJsWGF6YVI4dS9U?=
 =?utf-8?B?dHFFcDhRWDd6bFJHMHMvbmE1bzgwUlo5TEdWYW1EOVRuTTNrNytsZkZZOTJS?=
 =?utf-8?B?UUR4OU1rU3JjZUVTak41OGF1KzRsZFpBNWpUUGJ6U1Z2ZE5sRi9TRzNpSXlC?=
 =?utf-8?B?L3p0WlBoY2FUamVWTFpJVEtpVWtEbEp3Qkx6dWdzSTdMeGxzeVZsZEJyTDd4?=
 =?utf-8?B?UTZZYmQ1L2xnZG9iUkExajkzbFlubTQybUl4L3NlWWQvUXhBOWsrM285MExq?=
 =?utf-8?B?VU1kbVhRdzBKb3JwUXN3NzVjY21MemZlOFZPTWRDT2VRVE5vVUdDeVlnTEN2?=
 =?utf-8?B?WDB0akFtaThYbEJ3M0VQN3lBVXBlbVZHSVZtTzI2WW9ISUtZT0d0VWRBMllB?=
 =?utf-8?B?enJjTk5sakpSdVBJakRSbXFoU1o0UzhhaEFYSHhxT3FUblliYzltMDJVaXo2?=
 =?utf-8?B?QUJNZE9scWFkQ1lBRXBQL0N4RGNHOGhNdG1DZmNSU1V4NnV5RHh4dXRtYUZo?=
 =?utf-8?B?NkpFMGlXWDI0c01MTUt0RGx6NlR6N1l0c2VuazltM0d3VkhoSGVNeS9wMS9Z?=
 =?utf-8?B?NDBtYUs4UWhXSnVkN2cwWHIzbXRPRk5xdnBRbi8vNVhqM2d0SDNwY1kvSFBV?=
 =?utf-8?B?c2JyK3YxUy9sVFA5Q3JvTFFuUHF5SDhpanhLQ1E1T2p2YmNONmg2ajU3SmRr?=
 =?utf-8?B?QmlQdUVneDZzeUZYM2ZyWlJ6bHJxZysxalpqTFRUVC9UZjVNYjh4SERBVHRK?=
 =?utf-8?B?OXpieU9uQmtmNUsyLzhrUWorNFlmVFhxUEd6dUJhSjI1eGljY3Vsb0grcFIr?=
 =?utf-8?B?aWNacmw0aThZL1NBVUhMOUg4cGxGMnBPNWtjS1RtRHdLYXJscnY2NVc1QmRx?=
 =?utf-8?B?dXl3ZVBla21kS3k5OGQyeHNPQ2xGZGpPMG9IQVhQelU1Q2hwQ3k5ZmE1aGdm?=
 =?utf-8?B?RVZaYWpNTnZXUTV1WDhRYXdieHRTZFBVRDZpRkw3Zzc1cmdJNU9uais2RkFZ?=
 =?utf-8?B?d1ZoeHVNSHBac1dMV095akhTRGFDdGJDUkwzNTBjUGx4NjFrSVV5UmhRay9Y?=
 =?utf-8?B?VmtuM2hUNGwzY2pyZE1ERFpVUzhXWktrY3BiOVJCYWZOTGJzbklYZVE5TDY1?=
 =?utf-8?B?WHlUeFY0a2syMFJFb2t5R3lKcFZTR2Zhb2ZGeWFRc1hQNFlaYncrM3d6ZStG?=
 =?utf-8?B?VWRaRzB1cmNPbS9NUVlMYzlQRzFuR0FtVE80UXE4TXJuWXNNdU9qem9aMGdX?=
 =?utf-8?B?RXErZlg0WkQyY09tWXBVNE8vQzVtMkVRYWhzbU1HaHM2WGxWYUJWSGdnNkph?=
 =?utf-8?B?WERoQThwRjhCS0hyNk9zdCswTXVTQjgzUE1pNy9sVUVadUpNZVVtUXJsUGRn?=
 =?utf-8?B?dkM0dmEwcThxZzRZR0IvWTBnaFJKQU5FRWYycTZnQVB3VDlteU9vNE40TzNZ?=
 =?utf-8?B?ZTlBSzQ0dmxqQzUvRE0zb2liYWxaTnFaSmduZDRUZzF2bytaSWdNaExObWlS?=
 =?utf-8?B?QlhycXNLWWpvYlJHSktiVmZEc3hId2NOZzJYRFVKd3hxaElxWUJ4NWdGOE5E?=
 =?utf-8?B?R1V3VnkrR2h2WmF6MXJoZlh4Q3A3OFQ5T1BIcGprY1M0QkIybTBJQVRNTEtZ?=
 =?utf-8?B?MTM1OFpoMllINnVhZTcvVmRkbjdHSm9qRWZnTkxnT3dlOGx5ek5CeWUva2lq?=
 =?utf-8?B?N2ZJdmVYTFcyOUYyOEIzYXZTN3JpanFmeWNSN1FwYVVidHZRcEpyb2FQbGc4?=
 =?utf-8?B?akNicGZYcm5ScDBYM2lHd24rSVlRM1RXczQ2dmcyNHF2QWw3SEhlb2V2dE00?=
 =?utf-8?B?TThGUE5RQ3VncGJyemdUTE11OFAvUjVrWW85YTVnRHM1blptN012eWQyY0J5?=
 =?utf-8?B?WXcweTFVTVZpek90TTBBdFBWYnVWZGtadkgwSnNhVTZHdVZyVTBxUHBjcUtO?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e38223-6e06-4c9d-a247-08daaad204ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 15:13:42.4401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JYbF4beSc4jAHTmm1UEaUXHoZM9CRHhHTrLkRSFgkOGsPub6dfitdY8J+pWxAbj9j2wVcJgvScYahDolPom+ysrKlYc7YjT+8nrxrLzHdLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvNF0g
ZHQtYmluZGluZ3M6IG1mZDogRG9jdW1lbnQgUlovRzJMIE1UVTNhDQo+IGJpbmRpbmdzDQo+IA0K
PiBPbiAwOC8xMC8yMDIyIDA5OjQyLCBCaWp1IERhcyB3cm90ZToNCj4gDQo+ID4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICJ0Z2lhOCIsICJ0Z2liOCIsICJ0Z2ljOCIsICJ0Z2lkOCIsDQo+
ID4+PiAidGdpdjgiLCAidGdpdTgiOw0KPiA+Pj4+ICsgICAgICBjbG9ja3MgPSA8JmNwZyBDUEdf
TU9EIFI5QTA3RzA0NF9NVFVfWF9NQ0tfTVRVMz47DQo+ID4+Pj4gKyAgICAgIHBvd2VyLWRvbWFp
bnMgPSA8JmNwZz47DQo+ID4+Pj4gKyAgICAgIHJlc2V0cyA9IDwmY3BnIFI5QTA3RzA0NF9NVFVf
WF9QUkVTRVRfTVRVMz47DQo+ID4+Pj4gKw0KPiA+Pj4+ICsgICAgICBjb3VudGVyIHsNCj4gPj4+
PiArICAgICAgICBjb21wYXRpYmxlID0gInJlbmVzYXMscnotbXR1My1jb3VudGVyIjsNCj4gPj4+
DQo+ID4+PiBZb3UgZG9uJ3QgaGF2ZSBhbnkgcmVzb3VyY2VzIGZvciB0aGUgY291bnRlciBpbiBE
VCwgc28geW91IGRvbid0DQo+ID4+IGV2ZW4NCj4gPj4+IG5lZWQgYSBub2RlIGhlcmUuIEp1c3Qg
aGF2ZSB0aGUgcGFyZW50IGRyaXZlciBpbnN0YW5pYXRlIHRoZQ0KPiBjb3VudGVyDQo+ID4+PiBk
cml2ZXIuDQo+ID4+DQo+ID4NCj4gPiBJZiBJIHJlbW92ZSAicmVuZXNhcyxyei1tdHUzLWNvdW50
ZXIiIGFuZCAicmVuZXNhcyxyei1tdHUzLXB3bSIgdGhlbg0KPiA+IGluc3RhbnRpYXRpbmcgdGhl
IGNvdW50ZXIgYW5kIHB3bSBkcml2ZXIgZnJvbSBwYXJlbnQgZHJpdmVyIGJ5DQo+ID4gZGlyZWN0
bHkgY2FsbGluZyBwcm9iZSBmdW5jdGlvbiBpcyBnaXZpbmcgY3ljbGljIGRlcGVuZGVuY3kNCj4g
ZXJyb3JbMV0uDQo+IA0KPiBIb3cgaXMgdGhpcyByZWxhdGVkIHRvIERUPyBQdXJwb3NlIG9mIERU
IGlzIG5vdCB0byBzb2x2ZSB5b3VyIHByb2JlDQo+IHByb2JsZW1zLg0KDQpPSy4NCg0KPiANCj4g
Pg0KPiA+IFNvIGxvb2tzIGxpa2UgZWl0aGVyIHdlIG5lZWQgdG8gdXNlIGNvbXBhdGlibGUNCj4g
PiAicmVuZXNhcyxyei1tdHUzLWNvdW50ZXIiIGFuZCAicmVuZXNhcyxyei1tdHUzLXB3bSIgaWYg
dGhlc2UNCj4gPiBmdW5jdGlvbmFsaXRpZXMgdG8gYmUgaW4gcmVzcGVjdGl2ZSBzdWJzeXN0ZW0g
dHJlZQ0KPiA+DQo+IA0KPiBObywgeW91IGRvbid0IG5lZWQuIFlvdXIgZHJpdmVyIGltcGxlbWVu
dGF0aW9uIGlzIG5vdCByZWFsbHkgcmVsYXRlZA0KPiB0byB0aGUgYmluZGluZ3MuDQoNCk9LLiBQ
b3N0ZWQgWzFdIHdpdGggdGhlIHN1Z2dlc3RlZCBiaW5kaW5nIGNoYW5nZXMuDQoNClsxXSBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcmVuZXNhcy1zb2MvbGlzdC8/
c2VyaWVzPTY4NDIzMw0KDQpDaGVlcnMsDQpCaWp1DQo=
