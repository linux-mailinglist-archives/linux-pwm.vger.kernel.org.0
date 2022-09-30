Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0905F05F1
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Sep 2022 09:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiI3Hnm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Sep 2022 03:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiI3HnX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Sep 2022 03:43:23 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2097.outbound.protection.outlook.com [40.107.114.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A4E1F0181;
        Fri, 30 Sep 2022 00:43:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYdVeSidCVbDVZRSLcxrLQF+oRkmOwfB/2VxfMGL8GV5oZINZndMBRnzZc/nkakkkrenLGQ0UaBjDwTWf37oU62E0TAebhOtHAL8Xbv3QXCqPA2Vi9pk0DosGDslNmZCfFFx2SFgkei6aXvmo403QIKMq9aY79gHjzOT+g5qJ3t9v/sh8FkSlLXVyMJKjEAaTC3YJRY3kkLOhsHLyKEZ+b1KLAcpDE74heUdGH8bAu2Y0fK1cG7S0r3NJUMTzZzK8tbh6g8D7A3o8Dipa3pj2Qoj77PlhA5FDTNarUKj6c+v+z4FsjUxi+kB1pppm8P/MmZKVxKqdVCV2413VTceCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRa/AqICv4qEM9pOwOmSBMlaDhktTy2DJjQfSbqP6ss=;
 b=PUoJrw220mf3XP0+rCWP7jUImlBUlOgtvcfAM8oTBis/Y++6FYZYQwCe0kGijgZ98b2vQrJCdFD6s8ykXVNTqbp6cK2AkB4y88033XHtCpPrOkoAHf3BAixLxDQdN3OHmuyskk6ClAk6i+GYbDbHJhjF1SsAdcBS7U3b8R57C5B5gPz1q8SmsrKrGPGVY1LPRKExerUlCoKzjwo9HA6tFqjh4l0guaZcUHS19BbNlt7VqeXJtcLashytdicI1j30gcVWxU2vZVy/41NCNMCgCtIXzTK+dc2sHfxrXA6RB0fJhHkTwhnPsDftvmGpIpPYWyQEbYUubUjxUzgPpvgAyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRa/AqICv4qEM9pOwOmSBMlaDhktTy2DJjQfSbqP6ss=;
 b=Wc6WhGG5HdwNH7rqz5KBKiXP3FcxqBmgPD6YP647wWUJ9VEkFNQoq6bKNg5yRNC4lj+gQOsSsPoklwJDn084F0bRw4K74mzExUyBbWIZOQbippem/4EivLzzBV5j0MONXFQtZdJv94N2KeCWnP6/kZONO8KB7ytLywfdhChgDdw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYBPR01MB5374.jpnprd01.prod.outlook.com (2603:1096:404:802d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 07:43:19 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 07:43:19 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYzcqKYY4b2kXLe0WOhVN2yiYRM632twhggADaxYCAAAMdQIAABPOAgAAKedA=
Date:   Fri, 30 Sep 2022 07:43:19 +0000
Message-ID: <OS0PR01MB59226C4BAC20D5091205662D86569@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220921145741.901784-1-biju.das.jz@bp.renesas.com>
 <20220921145741.901784-3-biju.das.jz@bp.renesas.com>
 <OS0PR01MB59223AB5F30A55A0CD54B08886579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220930063429.xlcmimr6m3z3o5wh@pengutronix.de>
 <OS0PR01MB592278A1194D0E8B36123F0E86569@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220930070321.5a4tr7tuwc2hecbh@pengutronix.de>
In-Reply-To: <20220930070321.5a4tr7tuwc2hecbh@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYBPR01MB5374:EE_
x-ms-office365-filtering-correlation-id: 5e874356-a81d-4314-41f4-08daa2b77166
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Es4/6cg/nrAeT65VSqZ2mJ9CLXYgC8eAeaN0KI86kk6jLwF+4MUVoBsoKsJZCCrErMFz8pbdUbqetTx29dmFphbGMTGLi2OqSpPPxiGPndNaxGXW0zZ8R+RhMHOn1FewjEBsFKcZ7yamBlQsK4TOajOVxJgtJu/WMsHronTyJovwTJ4Ijk+yMs0DEaljhd2fDhL5xb24z4FdiJFjPPKx1iu4WBtXW2p/M+Dt4Gs+vNk2BJ9Qhsx1Mc07G247k6UFs8XKzfZFPybSqR6TENLtgAakwI4unGsmm5bpOF5ae0ajJmq4IuPs24f+TY9r0f1hY6etNfi/sfxS18KSGrHwg29RDDw1mgTkF1OfK+Lgd8RFP5vws60fPAsTp6BgG2wA2fP6DU1G+pd0aDZvd1ponrtutdCtfjAD1E8Dr9PBylRLRtkHiAUH8YxOemtq772et0WzxbFdlTqttpbcGkg2rLAdOBazFZaO9W/R53ThJXg1HOtjiIqr+421VkMdbd5EZzRIsIyXyJw2xXrAvGZCVEkCZXbvv8dobFkNmjgUrbeZac/sK2ro3Ps9l5CubYeoRzODkM/IbjEwUFhiDQ29/Emz2vvkWTOwE1x6CueJAsd9Qmm0cJBWiEyUL3t3ZF/tk4q+EIgXx3yuyKXcaM+j5CAmFx9zYSBIVEYucyQECYwBzr6xE0dDXmlnrtw8x+RX+cddJ2tC+iB8w71E/moYOdGiSOjt8dP1sIkRbbCdd2A83JQ1dc63QD9hLRozaVB93yI0xGhmWmETuOFB9F098A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199015)(122000001)(38100700002)(86362001)(5660300002)(26005)(55016003)(8936002)(7696005)(6506007)(66476007)(64756008)(9686003)(4326008)(8676002)(66556008)(66946007)(76116006)(66446008)(41300700001)(186003)(38070700005)(52536014)(33656002)(71200400001)(2906002)(316002)(6916009)(478600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm4rS0tRSFRXZndpSTV2M243VlY0N3c5c2NJbWZRejNuY2N1QlY2Q2cxZndU?=
 =?utf-8?B?RGhtbEFqR3hieURSUm9BQ3NGTFBVbUdPY1VPdmVzUGxva3c3ZytxbkptWC9G?=
 =?utf-8?B?clFvd1d4MGVFTEdDOGNscFdDWFpzZUFOajFQM01ITC9Nd1o0UWI1cURtSVZi?=
 =?utf-8?B?dUQvNU8vRjQrUEtobTBEbUZZS3Qwc1hLQjJJZ29oRkxCSE1JR1FTWUJVcGJR?=
 =?utf-8?B?d09mVldETmRHNDNiajZWa2RSR0huTEZ0RmhrNmk5eVQ1NVNMR2NZM0Z4UjlK?=
 =?utf-8?B?S3hpVlFuT2RjSkJqaTk3aHdybHNGNTY0Y1JHY1ZnQWJVbUFyNDkzUWg2emlM?=
 =?utf-8?B?YzRTNjRsNEUzTmx3RlJXS1VuSE5rYW1xcTYwRGpOTlBPSUdYQVlwY0tsNHF2?=
 =?utf-8?B?bW42YVoxZzhNUXNFK3Y5VU9QYnQ1V25pb3M5MXVmeGUwSFkvaW9pY2VDUXBC?=
 =?utf-8?B?NStXa21BTmhDYzMzL1FhajVyUFNlYWhtRHRiN3RVQ2F1WjJaOS8vT05KR0g3?=
 =?utf-8?B?VnJ0dmRUdkVjN280bC9DdlEvZXk0QVZ6Zkh5Q1ZvV1R2NlpjRnlodXoxNVRF?=
 =?utf-8?B?S2o0R281bXZlaUE2OWx1NjRXOHJxcUMxQm1DTU0xZWlFUy9nMlBQcVFvYStX?=
 =?utf-8?B?OVZ4RG1ZRWFHM2dxSE9ZUXFkbld2ckxyczViT0FqYzhCNlltSmRWRTZJMXow?=
 =?utf-8?B?NlZaQ3RPbGE2OWFxM1VaWDA5b01Lc0pzY2RKcFNGYW9laDFNRFZ0endFQWt6?=
 =?utf-8?B?d1VRVFhrdUt1UmN6TE5XYVJWMkhnd1U3NEtyaW0vWml5YjNMMUxPOUxlRWhQ?=
 =?utf-8?B?OFNudCtMY1d3bW53WXBzRkNQOFg5MHo4MUhyQWcxbWtWSW9ZcHN1bEU1Qk5D?=
 =?utf-8?B?czF6Zm0vOTBvSkNzOGNRY1lWNTl0YVdPcWRiVCtnYy9OODZhSjYzWmdCZ2w5?=
 =?utf-8?B?ZUt5cVB0d0kwL3Npd3RGSUpYWlVOWTIvOHFleWNGUHcrQzZBK0J6ZFZ5b0t1?=
 =?utf-8?B?OHlhR0VOQ2kwL2puTG1YY1d0VmZ2bTNvaXV4aTRQbzZxdkdCUDJBYmZ3OTRU?=
 =?utf-8?B?MUhCb0l5SFl3MThVWTNuWU9BUkw2TVN3SStGeElVekgwazY0MmFQY0c5Uk5w?=
 =?utf-8?B?TUJsVFVxRThhYklVTXF1TmtXMEZIOGxxUDRnUk5WZ2J4Z2RldFJlbnZvdzZx?=
 =?utf-8?B?cVJxdlVMbG5ETkMveXJHUkZ5VUtvYzk2OGp0ZEZpY2pkM0dmektjNlFVOE5q?=
 =?utf-8?B?NjR3UUE3QTdrbmZ6dGxFVnVsRUpqZEZXT3VvQS90V3RINkJVcFpZNXdpRWdK?=
 =?utf-8?B?bzBpVzVjU1MxSzdGS3VuVVZpRENmL1JjcTh4T05SOFJxaGxHOUkwZlJtcDlz?=
 =?utf-8?B?UVNhNS9kUTFYUUdxeUVVOFZGMUpjY1Avd0ZQd0sxVU0xSVk3bWt1ZDEydEgr?=
 =?utf-8?B?OWdtc3BGZVRWemV4bVN2OVFUYnNTeXF0cmtUMUFZcUo2a3RBYjFaQ25lNmFM?=
 =?utf-8?B?cXFiMXdTNWNUMW1BZnpwNjZaS2FxSHNSK0o2WmdqR1RRTnYwK1ZyWnc2LzZW?=
 =?utf-8?B?TmowZjgvVGRFcDBnZUh5aGUxeEF0U3RxTEJGMFJuMDkzUnN5SWl2d0xqc0ZY?=
 =?utf-8?B?S3M1dWQvTEprRURVMkxsMjN0YTF6MXFMN0ZrOUY3MjFZZ25qMUJYUEUxQjBj?=
 =?utf-8?B?Z3d6b1BBSFBVaVJCQkRQcWdUZ3VhejJMS0tmOGdIa1MvQURsdEg3NmpETElH?=
 =?utf-8?B?VnpoejNXaitnMkNTZk1wVGNjT1ZKYUpxbnUwQlY4TU9XWit0UUVzOGl2ZVNO?=
 =?utf-8?B?eDdDZ21CSExaUmRFdEI2Q1E0eTFlQTAwRUh1VTRnRzI4ZHU3Um5RVlEwV0RZ?=
 =?utf-8?B?cHZtZ1NVNVIvdWpKUCtKaHI3U1Nlc3VaM25CTWt3dnJBc3pFdndjaHhJdlRE?=
 =?utf-8?B?ZUpQYWdCY2oxZEhSWXVmQVJ1VG5GMkZMdFJlTWV5TzYwbEZiME85c1NKYWZ0?=
 =?utf-8?B?eVpoVXJjMVlXNUVFTlhoeDVoVjdHQUw2VktrMU1tV2dPWFVJV3pLdllKeVYw?=
 =?utf-8?B?SlNKUnROVjNVWm94dHFXZGpNVXBDKzBxbFM3Q0Z6cGJZZkxXS05pL21KVWY1?=
 =?utf-8?B?RUMydnhzTlBISEJwR3NBS0kxcmVwWGJWckFkdWl4Vng2REUyTHppR3E5MmFj?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e874356-a81d-4314-41f4-08daa2b77166
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 07:43:19.1432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iiA4ByoAAtcKZtg8HZyKUAC/tHm/wmpdMMsIX9kK9zKmtpUinms1+nZjRsJSk+LjlBJXQhD7nEjEljWDzZO8p8/DBx2QbSzKol8q0VXdQ7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5374
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgVXdlLA0KDQpKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+OyBQaGlsaXBwDQo+IFphYmVs
IDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDIvMl0g
cHdtOiBBZGQgc3VwcG9ydCBmb3IgUlovRzJMIEdQVA0KPiANCj4gT24gRnJpLCBTZXAgMzAsIDIw
MjIgYXQgMDY6NTE6MTJBTSArMDAwMCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkgVXdlLA0KPiA+
DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDIvMl0gcHdtOiBBZGQgc3VwcG9ydCBmb3Ig
UlovRzJMIEdQVA0KPiA+ID4NCj4gPiA+IEhlbGxvIEJpanUsDQo+ID4gPg0KPiA+ID4gT24gVGh1
LCBTZXAgMjksIDIwMjIgYXQgMDU6MzY6MzhQTSArMDAwMCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4g
PiA+ID4gK3N0YXRpYyB1OCByemcybF9jYWxjdWxhdGVfcHJlc2NhbGUoc3RydWN0IHJ6ZzJsX2dw
dF9jaGlwDQo+ID4gPiAqcnpnMmxfZ3B0LA0KPiA+ID4gPiA+ICsJCQkJICAgdTY0IHBlcmlvZF9j
eWNsZXMpDQo+ID4gPiA+ID4gK3sNCj4gPiA+ID4gPiArCXUzMiBwcmVzY2FsZWRfcGVyaW9kX2N5
Y2xlczsNCj4gPiA+ID4gPiArCXU4IHByZXNjYWxlOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiAr
CXByZXNjYWxlZF9wZXJpb2RfY3ljbGVzID0gcGVyaW9kX2N5Y2xlcyA+PiAzMjsNCj4gPiA+ID4g
PiArDQo+ID4gPiA+ID4gKwlpZiAocHJlc2NhbGVkX3BlcmlvZF9jeWNsZXMgPj0gMjU2KQ0KPiA+
ID4gPiA+ICsJCXByZXNjYWxlID0gNTsNCj4gPiA+ID4gPiArCWVsc2UNCj4gPiA+ID4gPiArCQlw
cmVzY2FsZSA9DQo+IChyb3VuZHVwX3Bvd19vZl90d28ocHJlc2NhbGVkX3BlcmlvZF9jeWNsZXMg
KyAxKQ0KPiA+ID4gPiA+ICsgMSkgLyAyOw0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlz
IGFsZ29yaXRobSB3b24ndCBnaXZlIGRlc2lyZWQgcmVzdWx0Lg0KPiA+ID4gPg0KPiA+ID4gPiBw
cmVzY2FsZWRfcGVyaW9kX2N5Y2xlcwkJRXhwZWN0ZWQgcmVzdWx0DQo+ID4gPiA+IDAJCQkJCS0+
MA0KPiA+ID4gPiAxLi4zCQkJCQktPjENCj4gPiA+ID4gNC4uMTUJCQkJCS0+Mg0KPiA+ID4gPiAx
Ni4uNjMJCQkJLT4zDQo+ID4gPiA+IDY0Li4yNTUJCQkJLT40DQo+ID4gPiA+IDI1NiA+CQkJCQkt
PjUNCj4gPiA+DQo+ID4gPiBPaCwgaW5kZWVkLCBpdCBmYWlscyBmb3IgcHJlc2NhbGVkX3Blcmlv
ZF9jeWNsZXMg4oiIIHsgMCwgMywgMTUsIDYzLA0KPiA+ID4gMjU1IH0uDQo+ID4gPg0KPiA+ID4g
VGhlIGNvcnJlY3QgZm9ybXVsYSBpczoNCj4gPiA+DQo+ID4gPiAJaWYgKHByZXNjYWxlZF9wZXJp
b2RfY3ljbGVzID49IDI1NikNCj4gPiA+IAkJcHJlc2NhbGUgPSA1Ow0KPiA+ID4gCWVsc2UNCj4g
PiA+IAkJcHJlc2NhbGUgPSAocm91bmR1cF9wb3dfb2ZfdHdvKHByZXNjYWxlZF9wZXJpb2RfY3lj
bGVzKSArDQo+ID4gPiAxKSAvIDI7DQo+ID4gPg0KPiA+DQo+ID4gUm91bmRfcG93X29mX3R3byhu
KSAtLT4gbj0wIGlzIG5vdCBhY2NlcHRhYmxlDQo+ID4NCj4gPiBSb3VuZF9wb3dfb2ZfdHdvKDU4
KS0tPiA2NCAgYXMgcGVyIHRoZSBhYm92ZSBmb3JtdWxhLCBpdCBiZWNvbWVzIDY0DQo+ICsNCj4g
PiAxIC8yID0gMzIgV2hpY2ggaXMgdmVyeSBoaWdoIHZhbHVlLg0KPiANCj4gT2gsIEkgdHJhbnNs
YXRlZCBteSAoUHl0aG9uKSBwcm90b3R5cGUgd3JvbmdseSB0byBLZXJuZWwtQywgcGxlYXNlDQo+
IG1ha2UNCj4gdGhpczoNCj4gDQo+ICAJaWYgKHByZXNjYWxlZF9wZXJpb2RfY3ljbGVzID49IDI1
NikNCj4gIAkJcHJlc2NhbGUgPSA1Ow0KPiAgCWVsc2UNCj4gIAkJcHJlc2NhbGUgPSAoZmxzKHBy
ZXNjYWxlZF9wZXJpb2RfY3ljbGVzKSArIDEpIC8gMjsNCj4gDQo+IFdpdGggZmxzKDU4KSA9IDYg
dGhlIHJlc3VsdCBpcyAzIGFzIGludGVuZGVkLg0KDQpUaGFua3MuDQoNClRlc3RlZCBvbiB0YXJn
ZXQgYW5kIHJlc3VsdHMgYXJlIG9rIG5vdy4NCg0KKyAgICAgICBmb3IgKGkgPTAgOyBpIDwgMjU2
OyBpKyspIHsNCisgICAgICAgICAgICAgICBwcl9pbmZvKCIjIyMjIyMjICVzICMjIyMldS8ldVxu
IixfX2Z1bmNfXyxpLChmbHMoaSkgKyAxKSAvIDIpOw0KKyAgICAgICB9DQoNClsgICAzNC43NDA5
MDJdICMjIyMjIyMgcnpnMmxfZ3B0X2NhbGN1bGF0ZV9wcmVzY2FsZSAjIyMjMC8wDQpbICAgMzQu
NzU5MTUxXSAjIyMjIyMjIHJ6ZzJsX2dwdF9jYWxjdWxhdGVfcHJlc2NhbGUgIyMjIzMvMQ0KWyAg
IDM0LjgyNTYxOV0gIyMjIyMjIyByemcybF9ncHRfY2FsY3VsYXRlX3ByZXNjYWxlICMjIyMxNS8y
DQpbICAgMzUuMDk0NjU1XSAjIyMjIyMjIHJ6ZzJsX2dwdF9jYWxjdWxhdGVfcHJlc2NhbGUgIyMj
IzYzLzMNClsgICAzNi4xODQxMjZdICMjIyMjIyMgcnpnMmxfZ3B0X2NhbGN1bGF0ZV9wcmVzY2Fs
ZSAjIyMjMjU1LzQNCg0KQ2hlZXJzLA0KQmlqdQ0KDQo=
