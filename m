Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265503D0DD7
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jul 2021 13:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbhGUKxi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Jul 2021 06:53:38 -0400
Received: from mail-eopbgr1300094.outbound.protection.outlook.com ([40.107.130.94]:29240
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239068AbhGUKMR (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 21 Jul 2021 06:12:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMc7vLTym9dE6lkJCnn4cqWfyFFio6WauvDS3Ozh5H5ecGbjb2eeOo9HJU+xR+cTH/IGwM8t0ftcx81H2gsncz8jJlfXmzItE3TsokQBgp3PzSuSgxPoYluMxRCucGDCwaRcCFGPa0cKBCLNB7N8qSiuIUiTZ6ay/F+UfZjYziEqb45i59eXlso+Xeg5gnXAi54+hqdNAON8J4+1B8ZfJi6p/6UbG8GKczQLvbaW6qaNhIRq+rKJX6GaZ+rerc5o71tsgM5DZaNDXh+6inrfVmrd75Hm3BYJyg94tu50DC7X3/GJa9iFJdDLQKRqRPDCpEvs/bTV+p6Tb6GLTT96uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ro5x/27OT4s/Nq3BVJPvJkPbRO1KXele+MB/6eiG0nM=;
 b=ZZ689c5n+ZP4mb2djaWLh+s/L141K5P5UfI0tPL3Nb1LZu5Qi5W9b9oQETOfLf9FYrwcbAQSKyXKkCReIdn7YLgN3/M8U7jcwaHwKVnCVYqtRQiY2w1K9z/ISMgFlGVYzLUme1Bp18Klzf32m9weT93Ej0mH3HAk+kDF1BX2Xclko+wupApPH6mSwhF4RBN23p12CugwSzbPa0d37rNkAsjtPRYbJU6kjXPTZIYbkd1df9gAS5VNOWHYdgcBuUuwVQ2Ee+BoVSC0wsqdB1O+lTVFqEEdGWw4259e8PkYcP/wZWRi5S2Kq7RenHm7zKVrZCXrGRi24ucFF6blPyYWaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ro5x/27OT4s/Nq3BVJPvJkPbRO1KXele+MB/6eiG0nM=;
 b=cxarQjFABEgb2aeQF8CFnQN+JmcP9LiHvEB9dPFV8wPlPZ8Pe9N5qj3drRxcPRgWdOZgx/xv+Kn18j8F13A6h6SOWDGA1cpmWY/zr7AEbPtPKGRe6UK1WB7zo8XEMY/CX719D6SBKsRqnj+L2HS8i9Xs2lOhxiKswFUg0zKBikj3YxpfjSvKH6+VzSj4pOPRLaVwTcd229MnAexfYJWjphTRh1949nA39wAiDVUJSGhNtlaRj7u2j3ANNVAq3l+7zrM1NHbMW10y+BgltrIKXMRulC/dKzg6Nl0Mw4rXInspBvB2KtAiHOaEzYU7eicMQ6VtHs94dE1vPB2VlR3HXQ==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB3041.apcprd06.prod.outlook.com (2603:1096:203:84::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Wed, 21 Jul
 2021 10:52:22 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27%4]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 10:52:22 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v9 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v9 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHXdI70LATZWzg1kUKYrs9wZPLHOKtELJmAgAE5s4D//9OwgIAAqykA//+IDYCAAJI6gIAH2oiA
Date:   Wed, 21 Jul 2021 10:52:21 +0000
Message-ID: <4BC9AEF6-31EA-4EDA-BCB2-7E4D44B6D5D2@aspeedtech.com>
References: <20210709065217.6153-1-billy_tsai@aspeedtech.com>
 <20210709065217.6153-3-billy_tsai@aspeedtech.com>
 <20210715150533.vppkw5oiomkxmfrn@pengutronix.de>
 <BD5B012C-B377-45E2-B04E-61D12B086670@aspeedtech.com>
 <20210716070943.ayxkz2irkwhgincz@pengutronix.de>
 <DD5590B4-11BC-411B-95BF-03AC26C078E4@aspeedtech.com>
 <20210716101301.l563tdwt5xuq5iq6@pengutronix.de>
 <3F12A498-DF5C-4954-8BCE-8C0C66BC9734@aspeedtech.com>
In-Reply-To: <3F12A498-DF5C-4954-8BCE-8C0C66BC9734@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fca384e-c9e4-41e2-f982-08d94c359e27
x-ms-traffictypediagnostic: HK0PR06MB3041:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB304161E6167E2E44AB6E47E08BE39@HK0PR06MB3041.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 877+vTwwUFOSt85O/gTphZ4ZrURJSNkrtVtDoCijeo06JTlFT7L+WCv+UeIlE6Pp1mYLYfpC0Dgl0AMXBZP4tjQPKhl7CzipBgTu4z07Qum6riVD7UacfS3iMpLpU5nP8XLa4zYKdvRJK0QMvDZRopAeonSqhr7lSbpY2B5sLWdBItMSLQhYEsH+/0/9tlUPJWq0jVJtJDWf5OhzrKrl82WkXpkx30ehicwrficwkpvszkIB3N2Em1r26ScyGLcGdOqcgWfd9tW5WsS7Pjmum9or0Xx/NEHoWGZq+XAFu5LFeXXmQeFBNmLbpItlMLn0II72lY3wmuyUtRXLoC8b8xIbCpDzi5d56Xl7MN2p/QO1MA8qMwZAd061dhJAeHh5RhKC08ZvKI6pZUcQQKcncdbZtwv7DQ5a9tvZfSBqZui3IzisfyitXOjAjM3f4py7lHnkYs6AvRJ5b1BUw1j9y7B2H5dayaOKVVNnl9Ctegb4uB3JKRhychLNPhkvVF2Yx6syaO6hbL1LmR/DH3OhD86dKAfgSv+du3b9V8dxbKhlwp4laueTwUKetXRaiw9/yELXIv/VeW/JNnyqUrYk8fRlGOxzVPI5xVuXe0fCL1QWy2FuQmkLe2dyzLKvCZ+hBhEkeybKy1NrIxdrwflmnlnsZOZ02rX70BGA+DbRqzGxK+sBVN6mSzNNBX3AJ5W5uI4uc8Wdyl/1XrgB6fAOyyDsfZhvDDhJO4jpkVxyi+o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39840400004)(366004)(376002)(396003)(36756003)(55236004)(66574015)(33656002)(478600001)(6506007)(53546011)(107886003)(6512007)(76116006)(122000001)(83380400001)(6916009)(8676002)(66946007)(38100700002)(54906003)(7416002)(66476007)(66556008)(2906002)(8936002)(66446008)(2616005)(4326008)(186003)(5660300002)(71200400001)(316002)(64756008)(6486002)(26005)(86362001)(45980500001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWJFMDAwUUZkZzRKWDQ4SnVPOFg0aXFlOGJDWUlBYVhjdkZVZjJBeXBsdURX?=
 =?utf-8?B?K1lHbWtubkNmUFJPR0RGd25mYlY4OGM5QnNDZ0h4RVFIbjczTW1kWnRUWWZz?=
 =?utf-8?B?NWpaVTZ5c0V0SnVBYWVjblZwR3FKTFU2UmR0SiswamxoMjVaZzViSjZmL3Bx?=
 =?utf-8?B?am01SFF3OHVRVDdmK3FsbzZDTGtPQUoybUREd1V0YWVUNWJHVHpJVTJDazNh?=
 =?utf-8?B?dGVHT2luOXhNeG4ycVR3b0pMT3NLalhpOEtqYlpHSkgwMUExdVBiUUV2RFlV?=
 =?utf-8?B?UG1qcFNRTnNGU0hRdnFSZVNjQVQ4aXNuZ1RQOHgvS2dZdFRXOUlraEZWVytQ?=
 =?utf-8?B?Vi9CT2U0WXJRbStPZTBHeHFEeFFhMGg3VkhaN1RBVkF6YmM5dVFINXh4SUNW?=
 =?utf-8?B?VGFBTThLWTBzeHFWenBEeHdKdkV2a0RtblZDODRZSElSYm5xQXdBMkQwdWdh?=
 =?utf-8?B?MDIyWjFuWWcvZVI3ckVtdDVBeStXVnVpQ3htM1c5WG9tOGRXeHl0V20vcG14?=
 =?utf-8?B?VG44dXkxZHNLczNQMCtWdmZ4TmZva1lVdEFxejE5NVY1MnJNVXdNeXR0VTlo?=
 =?utf-8?B?RnA2SGg1aS9hVkFhSk9scngzOExtUmVlOVhvMCtiaEtodGtNRnM2WHcxUC91?=
 =?utf-8?B?ZDZ6SU5DYUIvNE1XY0FBMUFqOUwzQ25XeDh3eDlWYjFtR2F4eWpZdFBIbkk0?=
 =?utf-8?B?NmdqMFIyQ2owV1Z2RFR3U1QyNFZBZDJBaFFtdzFIRlowbHJMTDhTTlA2WWlh?=
 =?utf-8?B?UzBlc1V5OFRlZ3lOWHBhTWd4WFNqdzNPMXhuMDZuSUQwZm5nTjR4WGFVNHhP?=
 =?utf-8?B?eXY3anhEbnU0TXhxdXFLUmpFcDNCZ21CaTIwSVZTODh5OHhVdVJkSUlNdWpw?=
 =?utf-8?B?bnZIQktTN0RWNHJ6YksyL28reEFWN0ZqYzY5Y1pwaXhPRE5DK0FVS3ZpTFNN?=
 =?utf-8?B?UjAzdmg4UENVNHdzMlppSXJDUHE2bVVCY25NSFVJbTV4UDJkQnZEYXpTeFFp?=
 =?utf-8?B?Wk9WVnoydUVZUmpRQUFmVVI2M05EcFRmYlN4WUlPTzdmMWx3ZEZHaGR2bEo2?=
 =?utf-8?B?TXBBK3VzcEVYcWNTZExKZW50WWNaRW81dFEyakswdmFsMU1TeDl1OTBwVjNy?=
 =?utf-8?B?Mm5kbGJndnZjRlplT2oycnRqZHZBbWJMOXdaQ243Y3dKOWs2ZllSSjVROElS?=
 =?utf-8?B?QW5ORWw2YVFCaU40Q29vY2FLTGNCRVJPYlR2S1ZlVjA2cWc0Qmg4bGlra3hv?=
 =?utf-8?B?a05wNVJQUDZmejdPYXo1cHdSNmFjRlVFU1NZRTJ3ZFE4cUVNbm1NRHlnQ0Zn?=
 =?utf-8?B?M2pnSEFkKzR3T1N4enEyRFUrQUxycWtId1FQMm4zdXhDRWI5RWtZK3Zwbmp5?=
 =?utf-8?B?TmpkUE9GNjcrTXNSRGYxWXV2WTNrcWRqcy8wUnAxUWRFV2xzT21ON2YwSDkv?=
 =?utf-8?B?NytaMmV4b0FuUDYrMlgzYktTcCtNS2NWSDlNdlVMeEtLWmVqNkdVL1JJTmFZ?=
 =?utf-8?B?VjJ4bFJCRkRldGgrSmVSMzJHeGxyWVUzTGJUcUtmSG4zc0UxOWFxZFhDd2pZ?=
 =?utf-8?B?RGJsOExOL1pLSkxOeUtuek1tdlhEOHE4bmtWOXdTZi9EYXdPQWltUklFaG4y?=
 =?utf-8?B?dHRWWWlZNjZZTjhPc0hoMjNDSExmN21qQm91cFJvZ3Q3cm15dWdNVTkrQjJa?=
 =?utf-8?B?cmoyc0JkVHR4Ty9tc2xrd3Naclc3K1IwdUxIWjRySTVBS1VZZkhNVDBGY200?=
 =?utf-8?Q?L+waYmYygBSQRo2mqI0vz0fiKe/vKuBBIq/UXz6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9757A94FBDB6DB4DAF36560C915FD5BC@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fca384e-c9e4-41e2-f982-08d94c359e27
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 10:52:21.9333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhGQPEdLkNiTabefRXKJnUjKRVw+GliDqvu28wc3llbSuv3OtLFAPvNq81LIQ/2iAHnzgCZnFbhxXX67RsfrdacOD0796sct/Zjfnd41M+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3041
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgVXdlLA0KDQogICAgT24gMjAyMS83LzE2LCA2OjEzIFBNLCAiVXdlIEtsZWluZS1Lw7ZuaWci
IDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOg0KDQogICAgICAgIE9uIEZy
aSwgSnVsIDE2LCAyMDIxIGF0IDA5OjIyOjIyQU0gKzAwMDAsIEJpbGx5IFRzYWkgd3JvdGU6DQog
ICAgICAgID4+IE9uIDIwMjEvNy8xNiwgMzoxMCBQTSwgIlV3ZSBLbGVpbmUtS8O2bmlnIiA8dS5r
bGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToNCiAgICAgICAgPj4gDQogICAgICAg
ID4+ICAgICBPbiBGcmksIEp1bCAxNiwgMjAyMSBhdCAwMTo0ODoyMEFNICswMDAwLCBCaWxseSBU
c2FpIHdyb3RlOg0KICAgICAgICA+PiAgICAgPj4gT24gMjAyMS83LzE1LCAxMTowNiBQTSwgIlV3
ZSBLbGVpbmUtS8O2bmlnIiA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPj4gd3JvdGU6
DQogICAgICAgID4+ICAgICA+PiAgICAgPiBBbm90aGVyIGlzOiBUaGUgUFdNIGRvZXNuJ3Qgc3Vw
cG9ydCBkdXR5X2N5Y2xlIDAsIG9uIHN1Y2ggYSByZXF1ZXN0IHRoZQ0KICAgICAgICA+PiAgICAg
Pj4gICAgID4gUFdNIGlzIGRpc2FibGVkIHdoaWNoIHJlc3VsdHMgaW4gYSBjb25zdGFudCBpbmFj
dGl2ZSBsZXZlbC4NCiAgICAgICAgPj4gICAgID4+IA0KICAgICAgICA+PiAgICAgPj4gICAgID4g
KFRoaXMgaXMgY29ycmVjdCwgaXMgaXQ/IE9yIGRvZXMgaXQgeWllbGQgYSBjb25zdGFudCAwIGxl
dmVsPykNCiAgICAgICAgPj4gICAgID4+IA0KICAgICAgICA+PiAgICAgPj4gT3VyIHB3bSBjYW4g
c3VwcG9ydCBkdXR5X2N5Y2xlIDAgYnkgdW5zZXQgQ0xLX0VOQUJMRS4NCiAgICAgICAgPj4gDQog
ICAgICAgID4+ICAgICA+IFRoaXMgaGFzIGEgc2xpZ2h0bHkgZGlmZmVyZW50IHNlbWFudGljIHRo
b3VnaC4gU29tZSBjb25zdW1lciBtaWdodA0KICAgICAgICA+PiAgICAgPiBleHBlY3QgdGhhdCB0
aGUgZm9sbG93aW5nIHNlcXVlbmNlOg0KICAgICAgICA+PiANCiAgICAgICAgPj4gICAgID4JcHdt
X2FwcGx5KG15cHdtLCB7IC5wZXJpb2QgPSAxMDAwMCwgLmR1dHlfY3ljbGUgPSAxMDAwMCwgLmVu
YWJsZWQgPSB0cnVlIH0pDQogICAgICAgID4+ICAgICA+CXB3bV9hcHBseShteXB3bSwgeyAucGVy
aW9kID0gMTAwMDAsIC5kdXR5X2N5Y2xlID0gMCwgLmVuYWJsZWQgPSB0cnVlIH0pDQogICAgICAg
ID4+ICAgICA+CXB3bV9hcHBseShteXB3bSwgeyAucGVyaW9kID0gMTAwMDAsIC5kdXR5X2N5Y2xl
ID0gMTAwMDAsIC5lbmFibGVkID0gdHJ1ZSB9KQ0KICAgICAgICA+PiANCiAgICAgICAgPj4gICAg
ID4gcmVzdWx0cyBpbiB0aGUgb3V0cHV0IGJlaW5nIGxvdyBmb3IgYW4gaW50ZWdlciBtdWx0aXBs
ZSBvZiAxMCDCtXMuIFRoaXMNCiAgICAgICAgPj4gICAgID4gaXNuJ3QgZ2l2ZW4gd2l0aCBzZXR0
aW5nIENMS19FTkFCTEUgdG8gemVybywgaXMgaXQ/IChJIGRpZG4ndCByZWNoZWNrLA0KICAgICAg
ICA+PiAgICAgPiBpZiB0aGUgUFdNIGRvZXNuJ3QgY29tcGxldGUgcGVyaW9kcyBvbiByZWNvbmZp
Z3VyYXRpb24gdGhpcyBkb2Vzbid0DQogICAgICAgID4+ICAgICA+IG1hdHRlciBtdWNoIHRob3Vn
aC4pDQogICAgICAgID4+IFRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9uLg0KICAgICAgICA+PiBP
dXIgaGFyZHdhcmUgYWN0dWFsbHkgY2FuIG9ubHkgc3VwcG9ydCBkdXR5IGZyb20gMS8yNTYgdG8g
MjU2LzI1Ni4NCiAgICAgICAgPj4gRm9yIHRoaXMgc2l0dWF0aW9uIEkgY2FuIGRvIHBvc3NpYmxl
IHNvbHV0aW9uOg0KICAgICAgICA+PiBXZSBjYW4gdGhvdWdoIGNoYW5nZSBwb2xhcml0eSB0byBt
ZWV0IHRoaXMgcmVxdWlyZW1lbnQuIEludmVyc2UgdGhlIHBpbiBhbmQgdXNlDQogICAgICAgID4+
IGR1dHlfY3ljbGUgMTAwLiANCiAgICAgICAgPj4gQnV0IEkgdGhpbmsgdGhpcyBpcyBub3QgYSBn
b29kIHNvbHV0aW9uIGZvciB0aGlzIHByb2JsZW0gcmlnaHQ/DQoNCiAgICAgICAgPiBJZiB0aGlz
IGRvZXNuJ3QgcmVzdWx0IGluIG1vcmUgZ2xpdGNoZXMgdGhhdCB3b3VsZCBiZSBmaW5lIGZvciBt
ZS4NCiAgICAgICAgPiAoQXNzdW1pbmcgaXQgaXMgZG9jdW1lbnRlZCBnb29kIGVub3VnaCBpbiB0
aGUgY29kZSB0byBiZQ0KICAgICAgICA+IHVuZGVyc3RhbmRhYmxlLikNCg0KICAgID4gVGhlIHBv
bGFyaXR5IG9mIG91ciBwd20gY29udHJvbGxlciB3aWxsIGFmZmVjdCB0aGUgZHV0eSBjeWNsZSBy
YW5nZToNCiAgICA+IFBXTV9QT0xBUklUWV9JTlZFUlNFRCA6IFN1cHBvcnQgZHV0eV9jeWNsZSBm
cm9tIDAlIHRvIDk5JQ0KICAgID4gUFdNX1BPTEFSSVRZX05PUk1BTDogU3VwcG9ydCBkdXR5X2N5
Y2xlIGZyb20gMSUgdG8gMTAwJQ0KICAgID4gRHluYW1pYyBjaGFuZ2UgcG9sYXJpdHkgd2lsbCBy
ZXN1bHQgaW4gbW9yZSBnbGl0Y2hlcy4gVGh1cywgdGhpcyB3aWxsIGJlY29tZQ0KICAgID4gYSB0
cmFkZS1vZmYgYmV0d2VlbiAxMDAlIGFuZCAwJSBkdXR5X2N5Y2xlIHN1cHBvcnQgZm9yIHVzZXIg
dG8gdXNlIG91ciBwd20gZGV2aWNlLg0KICAgID4gSSB3aWxsIGRvY3VtZW50IGl0IGFuZCBzZW5k
IG5leHQgcGF0Y2guDQoNCkZvciBoYW5kbGluZyB0aGUgc2l0dWF0aW9uIHRoYXQgdGhlIHVzZXIg
d2FudCB0byBzZXQgdGhlIGR1dHkgY3ljbGUgdG8gMCUsIHRoZSBkcml2ZXIgY2FuOg0KMS4gSnVz
dCByZXR1cm4gdGhlIGVycm9yLg0KMi4gVXNlIHRoZSBtaW5pbXVtIGR1dHkgY3ljbGUgdmFsdWUu
DQpJIGRvbid0IGtub3cgd2hpY2ggc29sdXRpb24gd2lsbCBiZSB0aGUgYmV0dGVyIHdheSBvciBv
dGhlcnMuDQpJIHdvdWxkIGJlIGdyYXRlZnVsIGlmIHlvdSBjYW4gZ2l2ZSBtZSBzb21lIHN1Z2dl
c3Rpb24gYWJvdXQgdGhpcyBwcm9ibGVtLg0KDQpUaGFua3MNCg0KQmVzdCBSZWdhcmRzLA0KQmls
bHkgVHNhaQ0KDQoNCg==
