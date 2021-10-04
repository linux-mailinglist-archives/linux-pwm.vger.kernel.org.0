Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528ED420500
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Oct 2021 04:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhJDCzz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 3 Oct 2021 22:55:55 -0400
Received: from mail-eopbgr1310121.outbound.protection.outlook.com ([40.107.131.121]:44838
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230513AbhJDCzy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 3 Oct 2021 22:55:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBgJ37Y/XDksB1HWEUIWN1yID4iJpFtq67Q2k30iEZrO9HeECZw8b+GtITCUnEJrAggKAAn+y6ngP4uEOdu3OX/aqTy4ok3epWIhR/Fh90ZeenBxqClSgcBImj+w0+hXMZx74n5G2CCPcAabvhOfQu0bb+AMrINfvU98jkeyrEV6wora00FjIyQQqcDH1xoDezeeE/eXMJ/1Wajhq3fo6XwuK51iqBrneT/og34KXMQpUYmWDseR5NOXsb6KdxSUOnDPYwwFCpQ+xUYH1foSrCsgbcwwiMLsoc8xrTNE2gV/mgMYj4fbb5xtAo9VZW+Sunj4VbvfhKLCNvzkTrLxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ros7tkUrVOYDPugPf2L4KwTV4jQE/bc8IkfVKBnogp4=;
 b=RZL1gYYPeXQ/hXGups+kU9MgDNHC+rWwywgq7R9bdljsbtuSYLy+zcOJ3zE0e3gplmpYDgL8HXZbPOWNzyUW/qnn07FJ1RGYYZr3CfCPxfBbAcqFahuCk4bmuBgf6Q8WAYgsqGI5uoBGpSOu7f3pmK8Rpl/x2wuZWlldzgB5Sy44QozjT2mu5eYT0Ouvq670aHrZ1P9IGF45PXzYylo4Sj7GuMT8xXsCA3IwmsQ5HFtdXEKmd4bgzWw8Y+FIqW7SCoveDZcLRiuLXigh7SPmtnKP2WefvzckRsvz/Mhs3ghsrvERopfvzjVcIP+TGiv2OhOdLF3AIrBzSlgt+GwJkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ros7tkUrVOYDPugPf2L4KwTV4jQE/bc8IkfVKBnogp4=;
 b=S96TUZV+dc5b6BBJ9YRvejcK93FyasOr7PhkOOMSL2b9ZeXmW2X/RGrXbow/suc8QnWlEPnam/qKOL2em2RFwfEcKhmUVEzaDqYv4j4xwzR8aM7pLJvLii6wWddONyQimQqdwLKIGYtmC1QtSKSpdRDUP9dtqLCAkkyTqnWEMVJ97SvvLCESxE+WzQz4Xip08hxVMh46ihW/lLMv1kwOsfh/ToA0fCfNSBH5uTq+F/8D+tLVE8I1zmXWjlMA3IYnv8d7sG8i55A67JujnBD9mYVCc8btZtWC07rrIvgCtjCOPEpPiJhNKK0nU1lPD3v+Y4pUDXKq7d9Kc73Wi6nI2w==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB2867.apcprd06.prod.outlook.com (2603:1096:203:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Mon, 4 Oct
 2021 02:54:00 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::190:5c40:6d3c:ca8a]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::190:5c40:6d3c:ca8a%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 02:54:00 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
CC:     BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v12 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v12 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHXosi+3/Cp8r5W9kOmoeBphO1kxKvC1rOA
Date:   Mon, 4 Oct 2021 02:54:00 +0000
Message-ID: <012AEBBE-9FFC-48B5-8794-00A577C3C87A@aspeedtech.com>
References: <20210906024339.21124-1-billy_tsai@aspeedtech.com>
 <20210906024339.21124-3-billy_tsai@aspeedtech.com>
In-Reply-To: <20210906024339.21124-3-billy_tsai@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cdcc414-1ace-43ab-e99c-08d986e237c3
x-ms-traffictypediagnostic: HK0PR06MB2867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB28671A59D566042DD11D3EF78BAE9@HK0PR06MB2867.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p5Uiz7bwc53SQSIql9OW7FBhmmTbkEOvKMO/gqmah+zh4a/9qVaHCfTxCEV+DWaut/VtXEYbLMRPfrSktpFkFK18khC69MCCDPCsSxForENFOLnqGjjQy/JtIO1gQ0sSUc4wZ8AfJPc8YAM0EEM3YXlO/JHsuIVjy2Zsk9cdqPKpyX8Lv9KgtQWkI2rPb2JlS9owWq+G4tjCDP1pS+AjQiENpLynTaOT8TjOFXpvfwQfRK2QdyKqfOrUmhkHnkqbnsxALQrktSiyGAsUfF6p2rFQ5lAzIl/+YaMctIEvs9Pitq1Q7w/CHK6kut8dqd0tRrvpxSA7c/ONXNNlQfOqpzL49p1q3LBPzk8znYvsTDvOskgdpTbK4aTu47kXyMx14l9zklPlAUrMdqU65HGukb0hiOQi1GUMJyKpVktpdab0pM02yAB5E3KAcQAsGd6/heicPFcb93O0LZ62pFcpMaKJdi0CE0OeDaNAYluFhx/8T5p0hTu6FxHrgcJ+/meivvYSfO78CLnT34cg0zb854mRLJSlfLO8SuLRz0JjGTI1yENazKIEL6IP6W6qU0RaIu5jEtz/IzPAhrUfvZaK0Yp71fpJPuThB0syStmyaSxKsuWHj8oOOCtXBifmCEmcD0ARpKWVmgtZXyouzJAHKokePmnunib4h1U3ayvyTRhpuMPL2WLmm5NswZF/0HLip4M2Qqseg+qLCVd6xujmZqX8/k2FfofWO2hf5UPZR6CrtlEJ6nRNVGrDrKpOvFaQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(36756003)(66946007)(76116006)(107886003)(2616005)(8676002)(4270600006)(6486002)(5660300002)(26005)(66476007)(66556008)(66446008)(6512007)(64756008)(558084003)(86362001)(38070700005)(186003)(7416002)(4326008)(33656002)(921005)(122000001)(8936002)(38100700002)(508600001)(2906002)(110136005)(71200400001)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGhEWkg4WlNiNzZCUWc0RFVzLzlsbXdNMWpWOHlzZ2ZtUFNrVWhPR3doOGJD?=
 =?utf-8?B?YmxaZFZaVHJJZUs4ZTZwZzYwWko4RVR0UjF6a2RKVjQ2OUtabmhuL1p3Vzgy?=
 =?utf-8?B?WlNGK0VlakdkcU8vbXhIamNkcDhjL2pRenBpOFlFZ0Rua3JPSlBlTXR6WVpi?=
 =?utf-8?B?WDRDODJENnZyUFJEQ255M2EyNVJKSWxzVmQ3cjVIK2tjSG1VZzQrNGFDOUxu?=
 =?utf-8?B?VjA5UXBuYzVNVUNydFVNZEROWnlsdTBMd2FvN1VaQ3k3REtIMVVHQTV4YkxF?=
 =?utf-8?B?aWRoTTlyM3RYUEdQYWJFVnUrRVo2azdqV0hURFd6VHNIZ3FOUHU4SjNIbWFO?=
 =?utf-8?B?aDNJMVBiYzBGMU5obEZmM0pEaitOOEVmdy93QjVWaEtoOVM5bVdkSnZhd3lH?=
 =?utf-8?B?RU1pQSs0M1JsczVGcG9uY3NyaFpHekVRUmd3QWo4SWRxbU14enVYeVViaXp4?=
 =?utf-8?B?OUhaNGplbVVNcm1hRFFiZE03VkFQaFR0LzcrTktRRm5mWE03RE94RitMdGdE?=
 =?utf-8?B?MjR5TW4rUUU1UTE5U0VOb2NjcXUxaEJ0MU9WbnVtZ2hvYVhyRUVoVjI1TkVZ?=
 =?utf-8?B?ZjBKais1OXNEY3ZIUnN2OE81NExFRGtUVEJpZ1IrZU41Yy9QSzFac2hhMlhZ?=
 =?utf-8?B?RXBFRGRrakRNVEdVZEFYY1ZrV3RyQUdUVFZtWHQvbVl3eUdVUW5oOFJmaFZy?=
 =?utf-8?B?ZWpWZjdNS3o1R1ZhY2xwaTNIaEtoRzc4bXRuT2RxYkZCRzlhems3MkJwRkJC?=
 =?utf-8?B?dEc1SUhsMm1QR1R1NjJGS3Q0TEJLRW1CUURaS2ljbE0yK2RQT1NubGJWVVI4?=
 =?utf-8?B?T3k2OXpsRC9VQW9DR0dSenY5ZFdVQUtDMkw2WjVnejdMbjMyZVJVUEtKOHR1?=
 =?utf-8?B?SGhXT09HaVJZbFYwOFg0U1V3bEFTRlBWOUM4Ukxwa2xRZnJGTW94RTVvTUZv?=
 =?utf-8?B?bUpxZ1VUUWxzZHNUZ2lyZTZ4emFYSmt1WHJmWS9CVDFNaTN1MXhCL093TGp6?=
 =?utf-8?B?MDc1alFjbTd2TUFUeDI5T05YdnQ3a0NtUFkyZk5yenZ5RnQwaWx4R0VudndL?=
 =?utf-8?B?TFhxUGU2U3ZraG13R2hZQnRGN1EwbHdsZStORVNSRlIvMDF6cW1RTi9OenVZ?=
 =?utf-8?B?WEhwZTM5TEZXNEJNVCtZS1ZQLzJySDNObDRBeWFDSC9GV1NKQXlQYkZaNm9m?=
 =?utf-8?B?cE9hQ1RjSkU5cDE5YnczaGpabnpsRnBSWU9KdlExb0NXcTcyR0tNdW5mY1dQ?=
 =?utf-8?B?TmFnclVkMVNWR1FFVldkTC9GV2JPOFhlcFl3Z0lyMFR5M3pSTm9FMm9WMm1N?=
 =?utf-8?B?dGcyMnBvVVl0ZlVDbFl5VmFITXI5amlXajNTWnFPZXlzS3d5aVBnQ2VnN29s?=
 =?utf-8?B?OWN1UVJYbzVRVTRjMVRpc2xXRjBKcVp3R3JqS3oxQzEwV2NxamhpdVZScXVB?=
 =?utf-8?B?QVRlSTVZZDB5bEdmVjV2dHZISXdyd01GbE50UVE4d1hpSWdaNkNyWXFlK3d6?=
 =?utf-8?B?WDBHa3g5cS85a2ZvSmZVSnF3dElQbTFMTXVRM2NuQi9lZVJvbzNmUUdIbHc4?=
 =?utf-8?B?bVJSTGNVZEtZdTk3aW0zQzNPWW1BWnZELzZ0Y0VjbGtKQ0NzckM4aVdrS2lq?=
 =?utf-8?B?d3BWOFlKa0FhUEdSbFo0dGlBTUFhRTc2OWlKU3owaHZuQWRoR3FEY2NVMzlJ?=
 =?utf-8?B?MVU0OERuVlNRUFo0ejRjeTNTNWtiRHQ4OGlRWWVQcW01SVQ2TDU3ZXM1YnB2?=
 =?utf-8?B?ejFmY0YxMnpnQjloeXRubTM1aVV0SmZYMFE5T3FBM3l6MmRTb0pTeTBUS0dT?=
 =?utf-8?B?VFBkWHFLR3NFYkJwdXMwdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9ECE030AFCD19E46A0313EECC38AD2C4@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdcc414-1ace-43ab-e99c-08d986e237c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 02:54:00.3974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mpR2VAk6h9p78KPr/BJ4yqkNTMwtYhOxeNuzTJmMzjKwwVZ7sA8puLN/Tt7+Pf0AcKAlssZhT0G9VwqvAjXbaQ1G7q4L4+6xKdR69NCfQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2867
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGksDQpEb2VzIGFueW9uZSBoYXZlIGFueSBjb21tZW50cyBhYm91dCB0aGlzIHBhdGNoPw0KDQpC
ZXN0IFJlZ2FyZHMsDQpCaWxseSBUc2FpDQoNCg0K
