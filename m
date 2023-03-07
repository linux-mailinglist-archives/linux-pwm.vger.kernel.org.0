Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9113E6ADB76
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Mar 2023 11:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCGKKa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Mar 2023 05:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCGKK1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Mar 2023 05:10:27 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2113.outbound.protection.outlook.com [40.107.113.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DCF5504F;
        Tue,  7 Mar 2023 02:10:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGBo8GLyOW2GB2JtbHEfsT6CmhUS3TgEbz61ZmZt/nJ2oa1CcIIgcESSWLbMHEvsV8IUKEzLwrVs/qSzksx8g2hIKlkRDenWYhgyyqLVH+WAfGZBoicAwlwrZNz6yCDZmeqo6NyyEhlRtkIILDHWaNpJhZDBhWaQgsw4a7ETwYT3rn2KnbgrVFBTqTYkgysJlkHt7tDMCZy4USkeyvA+gsVL2TQnhwjXJ63skM6WzxFtirdHmJplJ8F64uQpl3U/2/yUuB/YMp0SF9NoKiYOGuQyyzT6kSIRahZ8oMZNsfaTl3M5pg6HUdJ8pmUVILBO9Jio/aE5O30FfnCKElswQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLq/1LMSLxfAUdbcZShmSTvgTZTgdA50xnWlAdI8ExE=;
 b=jssq4AUB0E8IHi2vatR0R1j0RBIJGSk9xSF/yTf+awNMay2RvbrbBHtdaeH2GSjgDKpolzHtvOvM01y12cCy+6i2VzLpRh5TrQH40edIEddmaqYvlgt65k19Gs7+dLN7v5rOL0wE2F0WDvenVLHGf24OTRmna8WhgFO/Pnxgh5Xw36gLlu6mbCz+iy0/ZH2mnbdR7ZztygqjYGBx1Up0bIruOCBS2mIbZWdkWq5ph+y3ddGdxK7Vk5Se99I/QNWLa8cmlfKTJLObEgjoXCR8E29MhmjI3PWoaMepRUPxm79oB94o8Y+X+AJiJvd5y/MNYIHUNyFzlb+rACBJwThBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLq/1LMSLxfAUdbcZShmSTvgTZTgdA50xnWlAdI8ExE=;
 b=HJjxcNwJEFjlE6GO8YWBQvnxLQW1zbVIS18fNzw64iQ5z1+dXvK+UxDa7//Sj6begahL7IQGNUQnkmoXDNN/1fUk7Qq+K+/NG06nNfC9GqPChjgwu3AY+jzIiNctMYLnYStB9cSxeyP7KfogfkqFln6K6rBpJ6vMe8zQa8xczxA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8326.jpnprd01.prod.outlook.com (2603:1096:400:15b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 10:10:22 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::f54c:4b2:9c7d:f207%7]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 10:10:22 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v6 06/13] drivers: pinctrl: renesas: Add RZ/G2L POEG
 driver support
Thread-Topic: [PATCH v6 06/13] drivers: pinctrl: renesas: Add RZ/G2L POEG
 driver support
Thread-Index: AQHZUAojNP3mD44BfE2nuzra+Sv8J67uaLkAgACVQcCAABiwgIAAAqWg
Date:   Tue, 7 Mar 2023 10:10:22 +0000
Message-ID: <OS0PR01MB59229CD801939459BB2F8E8686B79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230306090014.128732-1-biju.das.jz@bp.renesas.com>
 <20230306090014.128732-7-biju.das.jz@bp.renesas.com>
 <ZAZ43tylTNxPIun8@surfacebook>
 <OS0PR01MB59223AF6B7850592F34CABF086B79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAHp75Vcdyq-XKRFKzEjHFQ_0Qv61HkMEVu0Dg-ffsnVc9R3-ww@mail.gmail.com>
In-Reply-To: <CAHp75Vcdyq-XKRFKzEjHFQ_0Qv61HkMEVu0Dg-ffsnVc9R3-ww@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8326:EE_
x-ms-office365-filtering-correlation-id: fb8991d4-1c40-477d-7802-08db1ef429c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CtKWPmfUOXbq2ol8YVaZbApp8MriIfyaB7V9BJnG/Q74x0eeLw7Y834wpMqCxrLvzTGMTU12/ktVjlGp9mJbX5uS2NwChu/aTmX0ro1ho8GJtMqhd6XFi2DmoSCsihclmasXogb0WmvK7CRMYzTtRWaQLtcOiFpRdiGzjaMlHa00+L4a0cvqrv6k88HbvePAKNHzsuNWBA15jWgUUHqcaVvMNtcvxAhiYJwH5tR+G5H3ePJ1fR+Jvf++5k30sBHT05QKuay34d54RHkdaJSB3PopaAfoqYKpsgUihcYlzP4hyLGBM7XF7XgxwaFM+dFIZJ1e7POfwa/3o8vx2Gn3a0nO37DSoM7S5kYLoZP6Hopi31ceTywe9dkkntzcj+JLNwl9bcLD/yv87665Z/tqMYjPoahHZE2ZhUfWX72xxQmjx8MVyQu93SyZqvjmTIWY2hRl5lfJ0tL2vnSTEIdtWw7Z3NYe4QUgZABfVFVKIQHrzZie2XMs5kdNhObuvwJL94evrSO/jDGZsFbjD/YCQf+NjjWOxy+b9OkZaaf32NunOp2vwusja6tnN74GrJY9feHi5XrZKf+k9P5XFv/DYx1yt2q2QzjhBTDfgw0pB/4wvRnaEtv99GLXsB6hAhdgB96XmqsYEBC42SKwXZoQYjJSuFWKC2/4Wom03lCLJ/EYVGkQFIKvBODzkeRr6Qy+5P7PnuHCgQzs089eIqmpCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199018)(8936002)(5660300002)(2906002)(52536014)(41300700001)(76116006)(4326008)(64756008)(66446008)(66946007)(6916009)(66556008)(83380400001)(66476007)(8676002)(316002)(54906003)(107886003)(478600001)(53546011)(71200400001)(7696005)(33656002)(6506007)(55016003)(9686003)(186003)(86362001)(38100700002)(26005)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3lCRVhuWjdXOFJNRjBHMm02bThsSDZrUDVJSWVjbmpzMU9BNnhrcy9RaS8x?=
 =?utf-8?B?cjhEeU12QkFQdkc5ckVLRFNoTE0yek5JSWJ0ZWY1SVNzdENQQ2MxT2ZsdUdB?=
 =?utf-8?B?WE5paGFqUGNvRGNUMXFBWVNxUGlJeGhNRERxMk5ucGlOU3F3ZzFsMjBrdklV?=
 =?utf-8?B?eldrNXVHZHRmbGhFYVhQWXJUOXE3YWlmTFkrQ3pGeGc3R3hUci9vQmN3MDcy?=
 =?utf-8?B?SktEYTBDNTRwOEpEakF0dXRjZ21Hc0QrMFp6MG1WSEpqSjErL2RZbmgyZktN?=
 =?utf-8?B?NHM2akU4Z1BGUTNCRTJjUzhSV0NCVy9DMlZoNkNYb0hVN0dsRW95M3lxMCs2?=
 =?utf-8?B?U1JoM1FwcGFEWEtudkpzbUhlQ1pGVE9RVmJuaEhQbmZkaUxqMTRUZlBSRVpj?=
 =?utf-8?B?TlFubzQ5a1I4QzhpZ0tkQ3FsRDhFK3BKclhDQWFaRHZTdllpN21mcmhFT2FE?=
 =?utf-8?B?VmU5bUpORXVQTnJ3dkh6OFBuMXJuczhnejIvMVo4eG9wcGplUXBENXlJZ3ds?=
 =?utf-8?B?c1hiMm1mV2IweUVMa1BQUlY3THlRK2NwUU80YnRkNDlwMnlyUnpMdDhZL2ZC?=
 =?utf-8?B?amo3YStLZ0hza3FhYzd5NkhTZlV2czJ2SGVMc2R1VVhIcVJpRGdXbEpwd1B1?=
 =?utf-8?B?d0NQNHlDQXhhMlErS1lic3V2MW5MZldOZW0rdWV0OFhxQTVRQ1lqWGYwdFhV?=
 =?utf-8?B?VGhmWnFaWUhpUHJVMTEvSTh1eDJFS25wb2FyQzRMdjU2TThjK0duMFZjaEtI?=
 =?utf-8?B?MXN6UWRaVWRVekJVZVdYNXVkMmNIWnRQUkpwTzhiM0NrSDFrSzNzalZhbEtM?=
 =?utf-8?B?M2pNNDhYajR6NVZ4czFKcUdwSTN3NDVqa3pPbVR0d0lkS2FKQVkrdm5sZWJk?=
 =?utf-8?B?bWdBOGkwbHJmczlvTmdmUXl1Q1VmOWREM09SSStEbkRYOHUxNFpiRW91K2kv?=
 =?utf-8?B?L0JYT2FRbTV3cmkwUDdWdCtGRUMvYm05TFR2N3JoV211TkZ4RkNWVXFTSy84?=
 =?utf-8?B?TXc5WGFlMEJrU1ZLYUlsbm1PTFZUUUxXQ21lNU9kRVhrR0dZUE5ka2hOaXJk?=
 =?utf-8?B?Q01yVDZGYmVoaUJKQ255bHZadUhBUHc3Q3Z1OUwvb1BIbEFWa0ZMRE13dGoz?=
 =?utf-8?B?VDNOWTJTRU5IOGQybk1lamdlNnpub1R5OFNwZndkeTN3S2dzb3VMd1oxNkxm?=
 =?utf-8?B?WTd5OHk3UmlJcFhDRUh1UXJSTjJvaUVMYWJnbmVTRGVsSnRZaGhtdlFJMXFE?=
 =?utf-8?B?TE5WNDVZVTZpZWdYYnRMSHVGek1xRXRpVkJTUms0VW82MjZ6Rk5nTjNybjV1?=
 =?utf-8?B?OWRUUEZyZ0xaV3ZtNm02RlRDNWxHamdmYnZwVlE3NGxTTmt5Z0JkQWV4TXFu?=
 =?utf-8?B?cXRCTytJN0VZMHF5ek4vSnR1ZUhKbTRxL3dPUStJK2k4MHJUY2xjZVIwNDYx?=
 =?utf-8?B?RkE0TjZRZFJ4MUtFOGdrMytnc1djekM0R24wNW8zQTMwVXcyc3l4U2dCZEZ1?=
 =?utf-8?B?S2tyNVVMTGt1bFRmQkdYZmtnK3lGSmp5d0lXcDd4U1h2QTUwbDROMFkyeGVT?=
 =?utf-8?B?N3VaUlJ3RlE1V0U1TkxtNEY1YStiSHlkTldiNWx0MzVSY3c1N2l5ZThWaEtv?=
 =?utf-8?B?MFJkdEMrRk1UeTlIdVhLTnptMmJUaGpXbkgvazNVaUdSZHZNUmxhUk5UTDNR?=
 =?utf-8?B?bS9IWjQ5aGxIMTNuK1BaS0tnbk5wWmJMM0x6emN4aUN5c2tWMlJKVTFMaUZl?=
 =?utf-8?B?ZHdINjdUNnFjOUlQWG5jcW1yMVVPNHRtNHRkZURjZGxRQkUwMDlmaDFFVjVz?=
 =?utf-8?B?RnJvZi92bGFmb1VFTHEvWXJNMjdHV1ovUStPRlJzdVE5MS9jUWtYU1lMekNt?=
 =?utf-8?B?eVBwdXQyZlJZTFAyeHBuaUx0MVRqQ0JjcTNydmtKWXhneGVTVk05R2htVHpE?=
 =?utf-8?B?MWUySUlyWmNlcVVzbS81MGltRkZGRTNqNHlFdDlUTUthQUlrOGRENWFJeXZY?=
 =?utf-8?B?dWZhMXZOWDFYVVBmQXBJaVUySUgyb0FYVG1neHV6NmtPWnJsMnViUmJKK3Z3?=
 =?utf-8?B?bldSOTlsYVh4N1BkOUdxc3V5YUxZT0dwSTJBRW1CcERBRzkrcC9aYTMvMmM5?=
 =?utf-8?Q?r8gZrglBzedHcML7uFmM7qAai?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8991d4-1c40-477d-7802-08db1ef429c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 10:10:22.4365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GaZ/Ltrs1bz36H+/MfwQLvFAef8PaJr0xIlmLJWlpNBBCBPjCJjoKwSP20yoNnugQLq/xc4bvYh3aVBtUg3uBdBRat2/N9ulJJglUkG3Pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8326
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgQW5keSBTaGV2Y2hlbmtvLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY2IDA2LzEzXSBkcml2ZXJzOiBwaW5jdHJsOiByZW5lc2FzOiBBZGQg
UlovRzJMIFBPRUcNCj4gZHJpdmVyIHN1cHBvcnQNCj4gDQo+IE9uIFR1ZSwgTWFyIDcsIDIwMjMg
YXQgMTA6NTPigK9BTSBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3Rl
Og0KPiA+ID4gRnJvbTogYW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbSA8YW5keS5zaGV2Y2hlbmtv
QGdtYWlsLmNvbT4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgTWFyY2ggNiwgMjAyMyAxMTozNiBQTSBN
b24sIE1hciAwNiwgMjAyMyBhdCAwOTowMDowN0FNDQo+ID4gPiArMDAwMCwgQmlqdSBEYXMga2ly
am9pdHRpOg0KPiANCj4gLi4uDQo+IA0KPiA+ID4gPiArc3RhdGljIHZvaWQgcnpnMmxfcG9lZ193
cml0ZShzdHJ1Y3QgcnpnMmxfcG9lZ19jaGlwICpjaGlwLCB1MzINCj4gPiA+ID4gK2RhdGEpIHsN
Cj4gPiA+ID4gKyAgIGlvd3JpdGUzMihkYXRhLCBjaGlwLT5tbWlvKTsNCj4gPiA+ID4gK30NCj4g
PiA+ID4gKw0KPiA+ID4gPiArc3RhdGljIHUzMiByemcybF9wb2VnX3JlYWQoc3RydWN0IHJ6ZzJs
X3BvZWdfY2hpcCAqY2hpcCkgew0KPiA+ID4gPiArICAgcmV0dXJuIGlvcmVhZDMyKGNoaXAtPm1t
aW8pOw0KPiA+ID4gPiArfQ0KPiA+ID4NCj4gPiA+IFdoeSBub3QgcmVnbWFwIE1NSU8/DQo+ID4N
Cj4gPiBTb21lIGRyaXZlcnMgdXNlZCBpb3dyaXRlMzIsIHNvbWUgdXNlcyB3cml0ZWwsIHNvbWUg
dXNlcyByZWdtYXAuDQo+ID4NCj4gPiB3aWxsIHVzZSByZWdtYXAgZm9yIHJlYWQvd3JpdGUsSWYg
dGhlIHByZWZlcmVuY2UgaXMgcmVnbWFwIE1NSU8gYXMgaXQNCj4gPiBjb21lcyB3aXRoIHNwaW5s
b2NrIGZvciBNTUlPIGFjY2Vzcy4NCj4gDQo+IExvY2sgY2FuIGJlIGRpc2FibGVkLiBJdCdzIHVw
IHRvIHRoZSB1c2VyIG9mIHJlZ21hcC4NCg0KT2ssIEp1c3Qgd2FudCB0byBkb3VibGUgY2hlY2ss
DQpQT0VHIGhhcyBhIHNpbmdsZSAzMiBiaXQgcmVnaXN0ZXIuIFNvIGl0IHdvcnRoIHRvIHVzZSBy
ZWdtYXA/DQpBIHNpbXBsZSByZWFkbC93cml0ZSBpcyBzdWZmaWNpZW50IG5vPz8NCg0KQ2hlZXJz
LA0KQmlqdQ0K
