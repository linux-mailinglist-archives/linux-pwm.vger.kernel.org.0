Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD79135D806
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Apr 2021 08:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhDMG2U (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Apr 2021 02:28:20 -0400
Received: from mail-eopbgr1310119.outbound.protection.outlook.com ([40.107.131.119]:28594
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230350AbhDMG2U (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 13 Apr 2021 02:28:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9ZJmj05BgkjadmlHXSwFfD+9upM1NFj5V+IbCu5LghY929N4fgrW6NcgKmhFUGlYUVw6qyMIxCbP2D4tABScqkwejh/oC8PrqLfFSZ1JJZdlSs6dPAnh9JMDPXrKjp2PuMQ6O93a/CSk9af0RavKribCW5g/AQcSwrZzRlfLE9BDMdRZreyrnYegzGQiv7hG4hx3ZvRTNR7Vo8AbYkF3QTlBHJ5ybJGBfBq9E5+tLtMRDQq/pLFt9U+XUbDKaYTB0zk/KT5St7j6G7qC3zXeK9Snyz//6FO0+7bVNDR8Zbu7MmaELbNQ3oqSfAzsTv9qA1Ro6+7RFzvwENC9tiNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfrMYixqUVa3q54bdtJ7BKkhqOgg4z8CBYqbzG9CuIk=;
 b=F55C2eqGKBRxp5Z3jLaI0XUUU21fr44EQ5xs7NGfqGYHvoAlJh6MRmnE75ABNIhdjFDjkNH5556Gf5UyjVRdZMCy/9dGH2TB7uMykdgFeQGJcsGu7jWjF73cI/JHC3c2IM2ry5ArINJeZH3bQNmlnmUkL2inn4+qZceDmaaNmvPPsrx4eAA4zPaje2Dx2/15ZXm/Hv+1dvTweixY1UxYfrXCS5xKcpvDlCORh/CZXSW+67x1t8PqOrgjV7lB7anj9MTzzD3VSOZlCIksDI1mUOml4QaVcjUY8q4LI1n8UCLo/U/DQpk2bu3mkyIaGXEMB2HhsVnr2S0EIOg6KtFswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK2PR0601MB1986.apcprd06.prod.outlook.com (2603:1096:202:8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 06:27:55 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::4d49:12fe:2d9a:b1bd]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::4d49:12fe:2d9a:b1bd%3]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 06:27:55 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "billy_tasi@aspeedtech.com" <billy_tasi@aspeedtech.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH 1/4] dt-bindings: Add bindings for aspeed pwm-tach.
Thread-Topic: [PATCH 1/4] dt-bindings: Add bindings for aspeed pwm-tach.
Thread-Index: AQHXL4HhmdofrFYwSUC9I4u4h0WvIaqw10eAgAGsGIA=
Date:   Tue, 13 Apr 2021 06:27:55 +0000
Message-ID: <676ABCCC-C2E8-4AC3-8A3E-F4F5084B6211@aspeedtech.com>
References: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
 <20210412095457.15095-2-billy_tsai@aspeedtech.com>
 <20210412125543.xhnitijeumddqdmn@pengutronix.de>
In-Reply-To: <20210412125543.xhnitijeumddqdmn@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6302a156-554d-4715-f907-08d8fe45464b
x-ms-traffictypediagnostic: HK2PR0601MB1986:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR0601MB1986990A0C36DC4C95E925118B4F9@HK2PR0601MB1986.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XUDTi+K0hdYGjZ6L7e6LAiOI8W5NAPMgLsp+OtnqBD9XQVLU6UgmsUFZHvV7pLm5bEF0mygxJf5wOZYEq5Ii1tj1/SvuiIfV/GhwtLtHb9xI0/mn7ZG0QCteOoYnFh9DDtr+mHIqnDhZlAU/A/y6fOHTDd5Nl7P+L/PtV+sANpGPamjUMphe9sI7cWuTQEagnTuACESWsUH1Cz5rrqAyq/CV5jk62IROwfH4zGnMyaRr4/K00sGh5JMxbfyxl9aafmbap04PonPl638Vjo1g+DiQhG//MiybESAIPsGGoVti9GBupH5jAnHdW7UZ2IWDPkCOrWHtRlQMh32B0krtYEtF/21R/dw3GpxKIHhxf0OpnNADJZjRGYCGTbi8jB9FYONESNoQBCw+/+fNTaL9uA+/31U4PmKesur9ROg9731Gyic1cBQ2BE22Y9DegREnVwo09pDCdQmXPtZlHKPIgnxjh9crhRrczDxL7uDP+YTHSYejcJ2l7pkqvXmKY8SXegxU5nMA4g4qfcrLGffYCCMH6XZLPex+PYQluahlQO6NWqtNzmktrJbdSCgCfqUrSWOH74jBR99irzVxeEUd1ehRdmi8i42h+SQHGTLj35jaQSAwt1mWgYvevAHhWtEV02bgoXafXvlRiko8YeQOtC59Pi8jaEm56OmroA7K1MlpEO07om3hoWuk91kSb4g1kPQR426YYu5recPp8z4/4k75Hl77wCBGwLM9FZTwNXPxGlDdHx27qiDWZHgCSSWB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(39850400004)(376002)(346002)(66556008)(8676002)(26005)(66446008)(66946007)(66476007)(6512007)(7416002)(122000001)(64756008)(6506007)(186003)(54906003)(6916009)(86362001)(55236004)(107886003)(2906002)(2616005)(4744005)(8936002)(36756003)(5660300002)(33656002)(316002)(71200400001)(38100700002)(66574015)(76116006)(6486002)(478600001)(4326008)(966005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cnA1SlI0dlBjbVVMckRxSnBvOEZabEpyM2RaUUVPYnJKTmtuWnl6VFZoMUph?=
 =?utf-8?B?MmJSTjFPVUw1alNRZHB2RVgyWDZTS2ZVY21GNEZleE4xVFhxK3ZaQTNvdWVT?=
 =?utf-8?B?SVVMcFRpWFZUUDltMFNOZXhNYi8vTm5mYWt6eXZYMEVjeVVoYXFvczgwRHRp?=
 =?utf-8?B?OE5JWDhOV0lBRzlBeVBEbHFubi95UXdRZmtlL0NKVU5IUU9qMVlHV0JETm52?=
 =?utf-8?B?S2R1K1ZxTUREN0pTZHl1bytza2xLTjRFVWNpOXpPeis3Rk93L1NpVEdnM2tP?=
 =?utf-8?B?OVJEWHRCRlovL1ZZR0U0T2ZaZmFpbWN3b0V0NzJtdzBvbWhuVUpGZGtlT09W?=
 =?utf-8?B?ZEZwUmZzdWw5SzY1Q1dDcWhJSW92aU9KRlBPQ2s4WWZjNzJlVzRQV3FncXlS?=
 =?utf-8?B?VmlMaWNsZjZTWWQxZHY0cmZ2V2ttd2NFZXVkUktCYjhvQ2VEUStHb3hxMVRi?=
 =?utf-8?B?endZVEQ5R1RtRW5yTUZGQ1REWVlZTVcvdDJBdTlEQXZOTkdYNTdnUVB0emha?=
 =?utf-8?B?YnhWVDJGbVh6cGVUYXI0ZitEbnVSUkt3bE5UdDhvblB5ZkxsQUtENkdxTkVh?=
 =?utf-8?B?aVpTMjlrWDVOcjZ2ck9nWFNoaGZ5THllMDF0WFl1ZXpJK2xTbmNuTGZMZ0Vw?=
 =?utf-8?B?RldCOVdhZ05kSFFuUnlsVmRTM3VsL1RmS0QxaDhlQXBKeHk2Z0ViQjRDRWpn?=
 =?utf-8?B?QzBiZW5PNmUvWGY4VEVROWVuNERySjhnVzFSQVFBYjRrcDFYZ3RkbVJLQlNa?=
 =?utf-8?B?SEpCVVNCSVQzWFhHRzFYWG15SmE4SzhoR2doRzg5NGtwMTQ0dmVOVWo3Z1dx?=
 =?utf-8?B?TVhmaldYdHFIdVlYaUd1YXFZSGpueVhzUng1eFJJTzJrRXRoeHRvajNzd1hp?=
 =?utf-8?B?SEdpSzRmRkhyaUwvdDZQV1dxOWRXc3lUeUlyQU1FUEdRcWVkWXNrQlpRRWlS?=
 =?utf-8?B?Z3gzMldUSE1KRFpDTkE5d1h0ZnRRZStQUDVzWUx2bFludHNhV1owUzcrRzhM?=
 =?utf-8?B?aEE2K04yVEY5VUkwai9hdVVleUpTUFp3aEV2VVBoQmIrOU11NlRScXBBNUht?=
 =?utf-8?B?YlpWM1JyTmhZQWh1anFEYUN1RG8wRmpneG45RXZoS0FteTI5S0llUm9mVVdP?=
 =?utf-8?B?RHVqb3pjcGk3ZDgxQVdJdTRqbmNjOW1IUitOMFdkUUFMOWdPQnNnb3k2cnkr?=
 =?utf-8?B?aHUvaEhodGY4NFBQdDNNMHBxVlpJMlpDYkxaQXZvWFdBdXAyWmdOZXNwZndO?=
 =?utf-8?B?Q3AwZmV3Y1FWblJYNUQ3MjByL1RYeDhDdzRxN0ppUS9ieDVjMXd5a1ZBUGMx?=
 =?utf-8?B?MktUZkc0M0oraVA4aUtUYWhmS3hGN2R2YUFFaU4xWThrQkgrS1RBUTE2NFVU?=
 =?utf-8?B?NnVsYVhEZG94ajM4Rm81b1hqOTVrdXJKMDQrcVErYk5HRHBmcnlmeVE1MHBw?=
 =?utf-8?B?SThvaENOZW9MNGxpWXdVbU1mcE1Nb2YxbUNZd3lnZm00UW4vUC9mbEV2Sklm?=
 =?utf-8?B?elYyWXNMTUNUVlVBUGthVzBSeWNRd05mV1B2eHRDaUpkdTRlTlJyQU9VMHkv?=
 =?utf-8?B?VHg2dnBnSHFqSU1sZjl6VEx1UlZBOGErN3MxNWNTMmZ2Y3h6SzhzZ2gvQ2VK?=
 =?utf-8?B?dDMvNkNPaDRCZUgzOGhLS0JqL1o1Q1MwOTFaQ0hMNnJiQWNLQWRhbEUvSkZS?=
 =?utf-8?B?MnV5UjY2NG5lMlBJN2NsVkhlK3A1SnkvTG9PWm9zeW44YmpQbXVQSk1BY1NC?=
 =?utf-8?Q?y+u+JnVwn8/7lsOBWafd9B6TbAiOZ4uYzVQ6Sge?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69706314763FF2438B5BC8A2C58FD8D0@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6302a156-554d-4715-f907-08d8fe45464b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 06:27:55.7798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qa7r/jfdHFj5E+4klnOyVBkfLbvxJCSQA5JOnztiMT5KOqhtvadWGeOO/xDNEtRY68Vjw6XHGl0wzMU84YOuoUeai2atc5FmA7AzATnsYxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB1986
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGksDQoNCkJlc3QgUmVnYXJkcywNCkJpbGx5IFRzYWkNCg0KT24gMjAyMS80LzEyLCA4OjU1IFBN
LFV3ZSBLbGVpbmUtS8O2bmlnd3JvdGU6DQoNCiAgICA+IEhlbGxvLA0KDQogICAgT24gTW9uLCBB
cHIgMTIsIDIwMjEgYXQgMDU6NTQ6NTRQTSArMDgwMCwgQmlsbHkgVHNhaSB3cm90ZToNCiAgICA+
ICsgIC0gQmlsbHkgVHNhaSA8YmlsbHlfdGFzaUBhc3BlZWR0ZWNoLmNvbT4NCg0KICAgID4gSSBv
YmplY3QgYmVjYXVzZSB0aGUgTVRBIGF0IGFzcGVlZHRlY2guY29tIGRvZXNuJ3Qga25vdyB0aGlz
IGVtYWlsDQogICAgPiBhZGRyZXNzLg0KDQpUaGlzIGlzIHR5cG8gZXJyb3IsIG15IGVtYWlsIGFk
ZHJlc3MgaXMgYmlsbHlfdHNhaUBhc3BlZWR0ZWNoLmNvbQ0KSSB3aWxsIGZpeCBpdCBhdCB2Mi4N
Cg0KICAgID4gQmVzdCByZWdhcmRzDQogICAgPiBVd2UNCg0KICAgID4gLS0gDQogICAgPiBQZW5n
dXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBVd2UgS2xlaW5lLUvDtm5p
ZyAgICAgICAgICAgIHwNCiAgICA+IEluZHVzdHJpYWwgTGludXggU29sdXRpb25zICAgICAgICAg
ICAgICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlLyB8DQoNCg==
