Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8E33CB535
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Jul 2021 11:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhGPJZY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Jul 2021 05:25:24 -0400
Received: from mail-eopbgr1310130.outbound.protection.outlook.com ([40.107.131.130]:3582
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230168AbhGPJZY (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 16 Jul 2021 05:25:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqzGUsk/tFHlAU4QuG6uJNgq+1QPSzak+4AX2UG9VFX9YThYIWnBiQUq5PHJafeHJsCGYxoVKxFgvE23vTgknwSHxIlA1Cw2HdtoyqAs6qk1bImQci0BVvx1fcEYhv2fasD9BGaWOH7/7mDhRIOeGqx5pPpurFuJm1zHsyPBLLFvAaM5eymjINM01XDX2KQuz6yAcaV5jzmDAyXRMmql8r31cPjeSr1f1s/uI43Z4lajFWxIvBKR6zghp41YGs/rgLfeWq0MYQF8xgh6uGKTFHDS3dW1JUM1lQCxzkZCqmP2/Tjqz8s8s4/2KoCMH4HUXrpqghYcMQyO2IJ5mydtew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDrY1aXgKCGVjDpux6rMgUk6fXjnb/Tej6xw7N0cE6c=;
 b=Z6ZmpwvCFsTZDIzwrOek7oZGFNsgvdxFPHm+y+mqxTyyb+n/QEX7Hp3pt/w7W1B0HoLy861U9wO1GhFCjIEwaruHOkiak5NHnBFrqpnyK6+OXVWUBNXe4Ml1ISL9m54eHKxSrQ2wOVhcCrb5H3k16Q0h7KimIuDXoKuejUtTNifXLzsR8/lARDc0PNTEE7aINZX1Cj2pkbBgi/qceDIExC77v4jVse9rYP2UtruKVARG8Ngu7Q3XmhXlVKbcY025zIBgMVUAOVv9dNGGEBHf0v1vJ0ROZzCNgZQsQDkR2NoAW2wSz9KUuzzwQ4CIVvAG6+RP2zTfI31BlUrCGVg3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDrY1aXgKCGVjDpux6rMgUk6fXjnb/Tej6xw7N0cE6c=;
 b=WHDKiavtIpxVUDNHzeO6pJHIEHS5e6wQmQdpFoS1Gjq50FQMDamiwcUJn/6sqeuZXa0Z+KZo8CEgI9Iijk01YIE4pVuJ3CzVBFCCl/z4+Vdq0+vk/oalvBN4wCBmexd441u9SJJo6JiLespz9QiwxC3tOzD4TyxO08OPz54lqX851Lkv+g0Cp2kwBESzVwPpCwFEG8VhoeTDhwzDwwVLngLRuEykWU7ohKRB+dOqEmvazYecS3syRJUR4+vyWBm+me6Plj3kUaJQxvrQvrBf4OdX0NhhtvIjf6E7JPuOxf2hrFnQPxnk9v8MWGR3Y/hh1GfbOcZfQwhibtWL94WGFQ==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB3089.apcprd06.prod.outlook.com (2603:1096:203:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Fri, 16 Jul
 2021 09:22:22 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27%4]) with mapi id 15.20.4331.025; Fri, 16 Jul 2021
 09:22:23 +0000
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
Thread-Index: AQHXdI70LATZWzg1kUKYrs9wZPLHOKtELJmAgAE5s4D//9OwgIAAqykA
Date:   Fri, 16 Jul 2021 09:22:22 +0000
Message-ID: <DD5590B4-11BC-411B-95BF-03AC26C078E4@aspeedtech.com>
References: <20210709065217.6153-1-billy_tsai@aspeedtech.com>
 <20210709065217.6153-3-billy_tsai@aspeedtech.com>
 <20210715150533.vppkw5oiomkxmfrn@pengutronix.de>
 <BD5B012C-B377-45E2-B04E-61D12B086670@aspeedtech.com>
 <20210716070943.ayxkz2irkwhgincz@pengutronix.de>
In-Reply-To: <20210716070943.ayxkz2irkwhgincz@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddc9b86f-fd43-4854-8e65-08d9483b3810
x-ms-traffictypediagnostic: HK0PR06MB3089:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB30895ACB58773A90DBE57FB48B119@HK0PR06MB3089.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hqJicoy4wRoz0X17/SvKc7CLczadXvVeuJkIDracZmxhoojiX2jDRIk2hY+CRPLrwIWg5XQjtFuO8w+2fIsWYGQftGltNVsZ9uG/ocl5gF+15qh9PeBSGoi8oGdLZkKtHSZV1reC9TepsH6w51uK/vg0nEf7qn6Klr1mMctNdcsFmPSPiguXgKn+yJ9FgpG1fp8sKT/9veiW71gFhypPxpaFP9/dHPrb9RvqYzuGdAd1ZqHNnL5G9zPDnEp/ohwoJXBwJi28PJ43w4bThbPKq/DdEIPted7vy3OBiodnipltuvwcQG46pvovbC0HP3dqhf2toBOUPM4ByMnBIL28ByHMLKK2Brpi2DU0gGUBVUp3rlNfcLfkfLFODNdHvrifi0QsVN4qB4L4b6c2PwvvHWYGVf4f5EzAP9lUlu+IKy9KrctAB26JcwHFXBBBJGuzdTgW4yFLq99WUxEJkxoht8AptsUmAyce0AJd6Q0YQKHZ/OhwOFbLIxCq5TsAGIlBlCbcvBs+uUZq+TnIb2mw+39Ja1KNMMJnSE/ygKaT+FQKMmzjHP+yG+ttpNQuSI20+lHuHNpaX5scKIaTao7tVXUw8XeNoUsOhiOUkdZq378cqf9swiZz7OxdbT2rlnHVVsMNNYxyi19Drtw1PozczVNqgxT5J4gHiPqR+HAYtBDyLuAp9N75UYNrSzNt05WtgJ9K9I+SMPKCfr+BHiyTrQQ/Qj/gdMCvFY1EjjSSleI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(136003)(39850400004)(55236004)(6916009)(66446008)(64756008)(86362001)(26005)(53546011)(6506007)(83380400001)(66574015)(4326008)(66946007)(76116006)(186003)(71200400001)(33656002)(66476007)(66556008)(6512007)(107886003)(8676002)(6486002)(54906003)(478600001)(316002)(2616005)(36756003)(7416002)(122000001)(8936002)(2906002)(5660300002)(38100700002)(45980500001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVhvbHZqdXRmajhZS2JncC81WkRNU2wrOCtTNThWTjRyRE5nZ09IaTlyeWY4?=
 =?utf-8?B?bnpiYWsyUVdtVWNwM2p4R1hRbitQS29MKzV6OXhabUFEWFJFdStPRFhMOHVE?=
 =?utf-8?B?ZzlGcUt0RDhNNXByUFM0czc0SldsRnNjeDR2dXBuMEI2bThHKy9UM1BOOGZt?=
 =?utf-8?B?ZjAvL1Z3ZDhZWDNUeW1VSzdhb1VKbm9XRE1od3M0bk9ZSUJadUxHV0pyeC9Z?=
 =?utf-8?B?WklUVTIzVll6N0UwRUs0SGNpOHE4eUxtY2ErNVVvYUlMS2R5dHAwN0ZUdVFq?=
 =?utf-8?B?S0VETWxidDBpeGVSTFhCRGd4VjJxVkN0OWZ3MW5xQ3Y2V2xmYXBRSExZc2gx?=
 =?utf-8?B?dkZ0NTRqdCtvYkdhSUIzdjVabmNLZFM2M0VwSDlLeXVVd1RzMWFMK2U5T0V3?=
 =?utf-8?B?UndBZWtDZ0VhdkkzV2tVeW5DZ2RmUTNIU1ErTnFXYjFFSnFPRGxvOWdDRk51?=
 =?utf-8?B?MWhia2xYZXZlQmJNWDJZL3RBY1haekdDZlhXamJkNzdVMmx1TzVycnBXeUZY?=
 =?utf-8?B?My9CMmIxdkxlOEVZTmRHOTl5bVBqNEQ2NFZlK3ptZnBDMXd0RkcvWVFnWXdp?=
 =?utf-8?B?Z1VyQ3RZanRTYTZENVBYbzFkOGV3ME5YU1B6MUdrYmdwUG1JSFB5ODVZWUxu?=
 =?utf-8?B?ZTRSWlpuckdZOTlsV0UwY2dXT3poSzdicllZTjZRendWbnFTVWpLODFpWEdy?=
 =?utf-8?B?empqQzFmaDg2SFlza3JVMlVSMWhHbFJyczVDdTBad3pvb2RQQi9KUlBaQVdN?=
 =?utf-8?B?VXNMajBaVmZ1Mkp3MysvT0ZUSkpBeTdGZUlsdC94enFjd0RCRVpoUE41VWFW?=
 =?utf-8?B?VWlCSldFL1lOWFZlc1JZTlFISmQxeWJUTmJUMld6L1Q1VmJ0QzJSZ0Q1Qmlr?=
 =?utf-8?B?VCtFN0R5SFNRbzdFTmU5cGZrRkZoMEg1NDRLMHc2aDVMd2oxbCtML3Urdmhu?=
 =?utf-8?B?ZDcyM3ozNzhzTFVRcWdnbUxhbTkwMzdtbDl4UHROQjdtTTZVNzM3aFlIcXZL?=
 =?utf-8?B?YUdxVGhJM2JBaXBDaHBpa1pQamF6c21JQnM0TjhxWGJIVG1HSWJibTB4VjY4?=
 =?utf-8?B?Tko0L0RyZEtkaURXbXN3dkFzMGNja2RtV3Uwb0RWTlFNZTN1bGFoTW8xVi9l?=
 =?utf-8?B?YlM4Z1NCZ2NvYUM5QlBwUXNZckYzM1BlUGtGc3U5SkxxSHYycUduM2tCTHJ0?=
 =?utf-8?B?NHdHRkg4d2tVSENocEp2NmxOU2JZSG5Ib1JHaE5IczNEOVdjNjArY1FseDVl?=
 =?utf-8?B?R3FQanlITGp6Q2Y5N1hRakZCZ1FzQjRaZ0R3SjhjY0owSkpSS0NxTm1JSDgx?=
 =?utf-8?B?REN0d0pva29hNFRFS0ZqWEFOc0dQVFVjRXUwa3ZzakRBeVNGVUl2enJTNVJ2?=
 =?utf-8?B?bkl0cXRDSmZpQThibUF5TjBYanNLcjFVQnByaWhoOVZmZ0Y0dFhOQlpHcDZ5?=
 =?utf-8?B?YjdiMk5mTHAvOW4yWGw2c3ZUalBINFZPMzVSQ1AvVG9xb05pc1dwTjhWdEY3?=
 =?utf-8?B?dEtYT3JtTjVNUnZFREdLMVg3UnIveFdFeEJleXFrS21mZGdHbnJBVzRUdWpU?=
 =?utf-8?B?d0hWSmdNY21La2dFZThuZWNnYjZxZG1QZkJPSXhydU9XK2daTmJIb0xycFRv?=
 =?utf-8?B?cVk0MDNoTUV2ZThJbmJVdW9kYzBwaHhMR2hWNVNQR283YWZ6R1p5R0tsSHN0?=
 =?utf-8?B?cXlOWUlJWlIzS0ZacElIWjNWSFNySzI2aFNHQlowZkYxSWZBZ0FsZXc0djFZ?=
 =?utf-8?Q?/bvXh5C1rLT1gMHqm4vYw55nbKAqMDutaarRTvJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77E3E0C8EA6044459C73553865D85AEE@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc9b86f-fd43-4854-8e65-08d9483b3810
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 09:22:22.9106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: phM2r48H9Of8AZyIpiqGGvHtQSCsFJK6SXzipyiDTpPTS83eHsxVd0Vu2MT90gsuZMzpZgRJRD0BImKMq2JA6KwJap1awPRpA0tX9RuBJW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3089
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGVsbG8gVXdlLA0KDQpPbiAyMDIxLzcvMTYsIDM6MTAgUE0sICJVd2UgS2xlaW5lLUvDtm5pZyIg
PHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JvdGU6DQoNCiAgICBIZWxsbyBCaWxs
eSwNCg0KICAgIE9uIEZyaSwgSnVsIDE2LCAyMDIxIGF0IDAxOjQ4OjIwQU0gKzAwMDAsIEJpbGx5
IFRzYWkgd3JvdGU6DQogICAgPj4gT24gMjAyMS83LzE1LCAxMTowNiBQTSwgIlV3ZSBLbGVpbmUt
S8O2bmlnIiA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPj4gd3JvdGU6DQogICAgPj4g
ICAgID4gQW5vdGhlciBpczogVGhlIFBXTSBkb2Vzbid0IHN1cHBvcnQgZHV0eV9jeWNsZSAwLCBv
biBzdWNoIGEgcmVxdWVzdCB0aGUNCiAgICA+PiAgICAgPiBQV00gaXMgZGlzYWJsZWQgd2hpY2gg
cmVzdWx0cyBpbiBhIGNvbnN0YW50IGluYWN0aXZlIGxldmVsLg0KICAgID4+IA0KICAgID4+ICAg
ICA+IChUaGlzIGlzIGNvcnJlY3QsIGlzIGl0PyBPciBkb2VzIGl0IHlpZWxkIGEgY29uc3RhbnQg
MCBsZXZlbD8pDQogICAgPj4gDQogICAgPj4gT3VyIHB3bSBjYW4gc3VwcG9ydCBkdXR5X2N5Y2xl
IDAgYnkgdW5zZXQgQ0xLX0VOQUJMRS4NCg0KICAgID4gVGhpcyBoYXMgYSBzbGlnaHRseSBkaWZm
ZXJlbnQgc2VtYW50aWMgdGhvdWdoLiBTb21lIGNvbnN1bWVyIG1pZ2h0DQogICAgPiBleHBlY3Qg
dGhhdCB0aGUgZm9sbG93aW5nIHNlcXVlbmNlOg0KDQogICAgPglwd21fYXBwbHkobXlwd20sIHsg
LnBlcmlvZCA9IDEwMDAwLCAuZHV0eV9jeWNsZSA9IDEwMDAwLCAuZW5hYmxlZCA9IHRydWUgfSkN
CiAgICA+CXB3bV9hcHBseShteXB3bSwgeyAucGVyaW9kID0gMTAwMDAsIC5kdXR5X2N5Y2xlID0g
MCwgLmVuYWJsZWQgPSB0cnVlIH0pDQogICAgPglwd21fYXBwbHkobXlwd20sIHsgLnBlcmlvZCA9
IDEwMDAwLCAuZHV0eV9jeWNsZSA9IDEwMDAwLCAuZW5hYmxlZCA9IHRydWUgfSkNCg0KICAgID4g
cmVzdWx0cyBpbiB0aGUgb3V0cHV0IGJlaW5nIGxvdyBmb3IgYW4gaW50ZWdlciBtdWx0aXBsZSBv
ZiAxMCDCtXMuIFRoaXMNCiAgICA+IGlzbid0IGdpdmVuIHdpdGggc2V0dGluZyBDTEtfRU5BQkxF
IHRvIHplcm8sIGlzIGl0PyAoSSBkaWRuJ3QgcmVjaGVjaywNCiAgICA+IGlmIHRoZSBQV00gZG9l
c24ndCBjb21wbGV0ZSBwZXJpb2RzIG9uIHJlY29uZmlndXJhdGlvbiB0aGlzIGRvZXNuJ3QNCiAg
ICA+IG1hdHRlciBtdWNoIHRob3VnaC4pDQpUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbi4NCk91
ciBoYXJkd2FyZSBhY3R1YWxseSBjYW4gb25seSBzdXBwb3J0IGR1dHkgZnJvbSAxLzI1NiB0byAy
NTYvMjU2Lg0KRm9yIHRoaXMgc2l0dWF0aW9uIEkgY2FuIGRvIHBvc3NpYmxlIHNvbHV0aW9uOg0K
V2UgY2FuIHRob3VnaCBjaGFuZ2UgcG9sYXJpdHkgdG8gbWVldCB0aGlzIHJlcXVpcmVtZW50LiBJ
bnZlcnNlIHRoZSBwaW4gYW5kIHVzZQ0KZHV0eV9jeWNsZSAxMDAuIA0KQnV0IEkgdGhpbmsgdGhp
cyBpcyBub3QgYSBnb29kIHNvbHV0aW9uIGZvciB0aGlzIHByb2JsZW0gcmlnaHQ/DQoNCg==
