Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931063CB08B
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Jul 2021 03:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhGPBvT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Jul 2021 21:51:19 -0400
Received: from mail-eopbgr1310130.outbound.protection.outlook.com ([40.107.131.130]:8512
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230388AbhGPBvT (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 15 Jul 2021 21:51:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiSIRTWlDwazgTCqsLmRGG0qbn+URzsSKStHKA6hHktAT7/KfVYLrB4rvghdFaskUuUuXmyjdcKYc97UihTcNpihLmicWC7wJv6ZdTEGGAkgfWDZt9112yB55v1AWNsBGSgwiBg06Pn0gylvfgvGr8PS0UkXY1sWZktpElIKQ+ujoPZngKVVdzvWUuTRXeNGVBnebbOZyGAhCWdE3MBbnCwmrfk+EVeGWaLZEVyRwyzS/mxoBO5X3RnOa7W9XaTJDKthppNNcXIzFqR0+xEK7Z/lncLBoti2wlV0xTwV04TmRvtgdC8Z1ieH8LvVzDlZT4UNBcANk+mWtJ8ZY84PyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMHveLY0n3s1gMM9qI+SGFSo4PjJ8JdQX1aJoLdIB/g=;
 b=IiBaXoWaYlw25sDZkfWEY+59lR3JLVrrKfVFfYWvInVf5tM+utXpQqbnTsQNDPHSFs2w31teIi9ecdQhGet+0UeVohwFaXcv4Hjz38p/Jqx4Q7ZxmO4jBqMZeweh1h+bR4g6Hc9q8XhRjm4t5paiZSbppAT84/GYIj3t2hq4nsHBQia8oEbLfcfUwuG2WMMa9bJNfkRn3utPexQbU1z02KKSk35xxZzrwRtYjJRGuKHvjWYeF7nUScGn9t+V58XaVq7U1vThWd/QIireDehuOLXq6Y0UpTaevw8ODYsMTaHZVQyHX+2LIPzYdqlJiLbbB5kgvVrPjujcXLHE77EvVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMHveLY0n3s1gMM9qI+SGFSo4PjJ8JdQX1aJoLdIB/g=;
 b=iejFKJiqi6aZ9q/wWz8KlsJFAHeJtonLZ3pzvfcD9YJ95FJDQfK5bFN6gOFPrSmF0+et8B/TpQN8qiNjoeHqfrq3s1UAoiX+SNz+8GuTHr0W4FQMmVhSps52SB6CDHgOUAvYYLd5XF6uIBpMZcjcczxgdRJyQun7aLk+10TLPmGkEx7K/JKEStD05ZEUz6J3Lt/FKPXXv1InxjwORUybJFAHqSJU8pfnwzpbEi+vTAWmKWACLL+Ng+JOpwcjeDDUoipCMB6yK5j5W7TMXVihEwJhx4nCgmovW5H0R1qctqyStIU6kAWHLyboSAVt5PsOvPoF+XfYapKl1d2NrQAJdQ==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB3233.apcprd06.prod.outlook.com (2603:1096:203:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 01:48:21 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27%4]) with mapi id 15.20.4331.025; Fri, 16 Jul 2021
 01:48:21 +0000
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
Thread-Index: AQHXdI70LATZWzg1kUKYrs9wZPLHOKtELJmAgAE5s4A=
Date:   Fri, 16 Jul 2021 01:48:20 +0000
Message-ID: <BD5B012C-B377-45E2-B04E-61D12B086670@aspeedtech.com>
References: <20210709065217.6153-1-billy_tsai@aspeedtech.com>
 <20210709065217.6153-3-billy_tsai@aspeedtech.com>
 <20210715150533.vppkw5oiomkxmfrn@pengutronix.de>
In-Reply-To: <20210715150533.vppkw5oiomkxmfrn@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7a87955-e844-46c8-bf64-08d947fbcaa9
x-ms-traffictypediagnostic: HK0PR06MB3233:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB3233EEDBF2CEE37E34E24C338B119@HK0PR06MB3233.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fdrb/D0fxxxUJTm3UjDwdOGNitmBtL7/q1QLGaGaJ+OtHCmReYdGuMVXHeqELOaHViJW1L5zWv6/o9v1m9yXbNGpX6tQmuCtZ6dQaB0wmalFAQxXga1r8v9Dx8aVi0nLvVhlltHL/S1v3uqbG8cQTIDK2F2EfSxCaQ0L8qTecJX+8+bXgGhsd6X9AgPdD+lN010i0skAPmNP5PYrAbzE+ATWGA2s+7Furn+kdst7C8zTynYQAk7lo2wUgyy31ezVN5/ixI9YrQpeYxGKd5m/knWXS3g929mu/dm5YdEf6z9NX+Jas2rLiMRS6DqF9KqWAGzmJjMbYOAIbFsoEtnu+Pm4N6jh6C+f3UX2/U6NQF+nifDgrqtK+XcL2JZgcMxDC7K0qckWX+trJz5dch12h9WujfNGBUnq1MvSFLpmIp0F+ZLO8eAq15rHJ2nwhDo94vWxajYsxEGNQNEk4gRG98MIBSTK8WBAQ+qAzSo7IPsujvdfQyMDsYIfpR04OQylg7Nr67npY+8tU++bOkGt8gZZZdvUOS0wG+pyfUMML95PTdsiN6Y195Z255vX1cVKUJ5bQzO3cex1Iy5kothEFOEHHdDZ5VSuHGtYoPsq3z1kuU+bk2sQhICan7WDMUA3foBL3tVIYTH3Pyg9Wm7mSWPeLI/ZoK5TgrOZAf9DI9i6les0sD+forpBmGKtVcFC8Tw0L0rOshLBSKp3V8bqueaUQFPMFUNDs1zYU24+CXw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(396003)(39830400003)(376002)(6506007)(6916009)(53546011)(478600001)(8676002)(8936002)(86362001)(4326008)(71200400001)(5660300002)(316002)(36756003)(2616005)(38100700002)(122000001)(54906003)(7416002)(64756008)(55236004)(66446008)(66574015)(6512007)(66946007)(76116006)(66476007)(26005)(66556008)(186003)(6486002)(2906002)(33656002)(83380400001)(107886003)(38070700004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3hOWUxCZndJTzdWSGMwMit0ZXBqQVpxNmEzK0o2bzJuWDF3eWhkeFZtQW5C?=
 =?utf-8?B?NTc4bnA3cGM4RjRmSUk1anJsZHNsaWFzaDRNUjRmVzVGdXhOVFI3QzZhalRK?=
 =?utf-8?B?Y0EzeEFXRGxNUnFHTUlhenA5aG9BN2lFU3lhUnp6bDJXVjBqUTkxUnBuR0Vy?=
 =?utf-8?B?OEhuNDg0QTV5d2t1RGl6Q1hQRzBQT0o5Z2V1eWtrMS9kQXcxZG4xeFdvS2V3?=
 =?utf-8?B?WGNYeWZOWlV0MVh1VVZURkpGa0kxNURTSUo4cjMzMWF1Rnk1L1g3ckRGR2Vh?=
 =?utf-8?B?a2VVcHZwTXBrZFd3cXBFenpyS2pscmZRTjRVRFF6ZEpTWC85Q3pETi9oamla?=
 =?utf-8?B?UStzREs3MkUyc1V6bXJRYU5KL3ltTUdUalBtY3hkV0NSMzVWazkzTHp4TlNM?=
 =?utf-8?B?MmZzeWZndzRGSjJMbXpIMW9pZnZWemJndkJSS1Q5a294N3dMR0M5Nkx3Uzcr?=
 =?utf-8?B?Wkx1SkhQTnhTYkxvcXNzaEVxYzRjWUI4ZHNKQ29NTmFwT1VtR3FBY2crUXQ4?=
 =?utf-8?B?TDB0bC9BVHNhTTJKN0Y0ak9uWXE3N05OeTJZaEpteVQrNkxTOVNUbitWYVpR?=
 =?utf-8?B?U0xSWmlYN2lsQTNYRzZqWjZONklLd1hGUzZzTStHb1gxRFpuNkRPbmhiYlg4?=
 =?utf-8?B?L3EvMzgrQlZTT3hsWDBoaTVKa2lZNVNvb3drUXVINWNlUndiaERLZTd2NzNt?=
 =?utf-8?B?MVNDVzR3OVhxRXdKYWJYY0pxWTVkam5kczlhSjF6SXRmUUFSQTE4elF2OUFU?=
 =?utf-8?B?dUdYd1FIaEcveWJhREtqSDNEWkx5VWlxV3RiOGZiRHEram9GaU9ibXZuZHYy?=
 =?utf-8?B?clNONURiTXRCN1VsOTZIc0VIUUh4MG42SDZ4RTF6KzY2VUNjeHpnRDBDQm5x?=
 =?utf-8?B?NFFqNi9FOVo4ODcvL0xGYUFhaVVkNGpFeXhXaGRKcnh0VkZ2WXQrSUM4bUl2?=
 =?utf-8?B?UGQ2TWlDaCtDSldRdE5pa0tucmxRZW5PVTduWHNMNE5yeDYxbTNIem9PMHIv?=
 =?utf-8?B?T0VsU3FWcjIvNXpzN3A5MFl4MlprSXNJRlVYN3VmdWZjQ3ZwdWhSK0ZjSnNt?=
 =?utf-8?B?R0RpTTJYWnZBOThvWVNDSFdLOG5CR0JSZyszWVlWaHU5WkxMeE9tQVFkYVdS?=
 =?utf-8?B?SXBGRXFLSW9lUXRmUVdLM2txUGZvbjJKemx1L2JnTTFSdURyQnFKVGJDUDRW?=
 =?utf-8?B?Z2pxUktuVlhqdGlvN2k1ZWRMVDdvVWx0Q1EvMUFvOVFhK2xrVjJYd2pYQWZY?=
 =?utf-8?B?S01wQ3JZMnJGZExVRDNaVzhoS3FES3JsOUZkT051aDJieFVkREcwaldyc2pl?=
 =?utf-8?B?d2huTk1adXBuV0tLdzNMcEdQNklrenliSzRGNU5wWkVYb0NDSlc4RmVIYlM3?=
 =?utf-8?B?WFRUQmxPRVQ4ZTA3YjJWSXdKeXpHSW9KRldib2lBTHlhbHU2UmFDWFQ1czdt?=
 =?utf-8?B?UFprZXVZTW1sdTNLM1JydFFEOTVNZm1oaWpQa0dlSEt2Z05zQXNMalQ1N2tt?=
 =?utf-8?B?Y1YrSVhQN1U5elFMRnQwQmJRSm1ibDcrb2xUSFYwYVBmTnA4aXpvWDlYZVR5?=
 =?utf-8?B?TDdlR3J3NHVxVHlYM3ZoZHJkK3F1dUdFcCtxSk10OXZxZkI3dk9ia2FXTGUr?=
 =?utf-8?B?VDJrMEtLdVB3WS8vN1U1c09YNzQzREZXWkFQTWgzQktKWUVIRENLV0d0L25Z?=
 =?utf-8?B?WEZRUDZ3VzVxNnVFbFpTZGpDTExjLzlOVWhTRjlRVUZ6UEhTWTlXaUpIUlBO?=
 =?utf-8?Q?20hGrlmJXbW2RwGmRAUoUTSKe4IvMtv/5DRs4Sk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F748F69162666D49BEB3AD14AD93E465@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a87955-e844-46c8-bf64-08d947fbcaa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 01:48:21.1042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0bIsjqlsLELBwtJWbWqT7XQ5JXbfYOwuTccHsFn8OpWYoYYe5Elcx8ujmUN68EbZYkLgntFtnkhZyERr++M+DLHS1GgSnG3CzBuzFhqL4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3233
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGVsbG8gVXdlIEtsZWluZS1Lw7ZuaWcsIA0KDQpPbiAyMDIxLzcvMTUsIDExOjA2IFBNLCAiVXdl
IEtsZWluZS1Lw7ZuaWciIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+PiB3cm90ZToN
Cg0KICAgIE9uIEZyaSwgSnVsIDA5LCAyMDIxIGF0IDAyOjUyOjE3UE0gKzA4MDAsIEJpbGx5IFRz
YWkgd3JvdGU6DQogICAgPj4gVGhpcyBwYXRjaCBhZGQgdGhlIHN1cHBvcnQgb2YgUFdNIGNvbnRy
b2xsZXIgd2hpY2ggY2FuIGJlIGZvdW5kIGF0IGFzcGVlZA0KICAgID4+IGFzdDI2MDAgc29jLiBU
aGUgcHdtIHN1cG9vcnRzIHVwIHRvIDE2IGNoYW5uZWxzIGFuZCBpdCdzIHBhcnQgZnVuY3Rpb24N
CiAgICA+PiBvZiBtdWx0aS1mdW5jdGlvbiBkZXZpY2UgInB3bS10YWNoIGNvbnRyb2xsZXIiLg0K
ICAgID4+IA0KICAgID4+IFNpZ25lZC1vZmYtYnk6IEJpbGx5IFRzYWkgPGJpbGx5X3RzYWlAYXNw
ZWVkdGVjaC5jb20+DQogICAgPj4gLS0tDQogICAgPj4gIGRyaXZlcnMvcHdtL0tjb25maWcgICAg
ICAgICAgICAgIHwgICA5ICsNCiAgICA+PiAgZHJpdmVycy9wd20vTWFrZWZpbGUgICAgICAgICAg
ICAgfCAgIDEgKw0KICAgID4+ICBkcml2ZXJzL3B3bS9wd20tYXNwZWVkLWFzdDI2MDAuYyB8IDMx
NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogICAgPj4gIDMgZmlsZXMgY2hhbmdl
ZCwgMzI2IGluc2VydGlvbnMoKykNCiAgICA+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
cHdtL3B3bS1hc3BlZWQtYXN0MjYwMC5jDQogICAgPj4gDQogICAgPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcHdtL0tjb25maWcgYi9kcml2ZXJzL3B3bS9LY29uZmlnDQogICAgPj4gaW5kZXggNjNi
ZTUzNjJmZDNhLi5hNWFhYzNjYTRhYzcgMTAwNjQ0DQogICAgPj4gLS0tIGEvZHJpdmVycy9wd20v
S2NvbmZpZw0KICAgID4+ICsrKyBiL2RyaXZlcnMvcHdtL0tjb25maWcNCiAgICA+PiBAQCAtNTEs
NiArNTEsMTUgQEAgY29uZmlnIFBXTV9BQjg1MDANCiAgICA+PiAgCSAgVG8gY29tcGlsZSB0aGlz
IGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlIG1vZHVsZQ0KICAgID4+ICAJ
ICB3aWxsIGJlIGNhbGxlZCBwd20tYWI4NTAwLg0KICAgID4+ICANCiAgICA+PiArY29uZmlnIFBX
TV9BU1BFRURfQVNUMjYwMA0KICAgID4+ICsJdHJpc3RhdGUgIkFzcGVlZCBhc3QyNjAwIFBXTSBz
dXBwb3J0Ig0KICAgID4+ICsJZGVwZW5kcyBvbiBBUkNIX0FTUEVFRCB8fCBDT01QSUxFX1RFU1QN
Cg0KICAgID4gSSB0aGluayB5b3UgbmVlZA0KDQogICAgPglkZXBkZW5zIG9uIEhBVkVfQ0xLICYm
IEhBU19JT01FTQ0KDQogICAgPiBoZXJlLg0KDQpPaywgSSB3aWxsIGFkZCBpdCB0byBuZXh0IHZl
cnNpb24uDQoNCiAgICA+PiArCWhlbHANCiAgICA+PiArCSAgVGhpcyBkcml2ZXIgcHJvdmlkZXMg
c3VwcG9ydCBmb3IgQXNwZWVkIGFzdDI2MDAgUFdNIGNvbnRyb2xsZXJzLg0KICAgID4+ICsNCiAg
ICA+PiArCSAgVG8gY29tcGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVy
ZTogdGhlIG1vZHVsZQ0KICAgID4+ICsJICB3aWxsIGJlIGNhbGxlZCBwd20tYXNwZWVkLWFzdDI2
MDAuDQogICAgPj4gKw0KICAgID4+ICBjb25maWcgUFdNX0FUTUVMDQogICAgPj4gIAl0cmlzdGF0
ZSAiQXRtZWwgUFdNIHN1cHBvcnQiDQogICAgPj4gIAlkZXBlbmRzIG9uIE9GDQogICAgPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcHdtL01ha2VmaWxlIGIvZHJpdmVycy9wd20vTWFrZWZpbGUNCiAg
ICA+PiBpbmRleCBjYmRjZDU1ZDY5ZWUuLmFkYTQ1NGY5MTI5YSAxMDA2NDQNCiAgICA+PiAtLS0g
YS9kcml2ZXJzL3B3bS9NYWtlZmlsZQ0KICAgID4+ICsrKyBiL2RyaXZlcnMvcHdtL01ha2VmaWxl
DQogICAgPj4gQEAgLTIsNiArMiw3IEBADQogICAgPj4gIG9iai0kKENPTkZJR19QV00pCQkrPSBj
b3JlLm8NCiAgICA+PiAgb2JqLSQoQ09ORklHX1BXTV9TWVNGUykJCSs9IHN5c2ZzLm8NCiAgICA+
PiAgb2JqLSQoQ09ORklHX1BXTV9BQjg1MDApCSs9IHB3bS1hYjg1MDAubw0KICAgID4+ICtvYmot
JChDT05GSUdfUFdNX0FTUEVFRF9BU1QyNjAwKQkrPSBwd20tYXNwZWVkLWFzdDI2MDAubw0KICAg
ID4+ICBvYmotJChDT05GSUdfUFdNX0FUTUVMKQkJKz0gcHdtLWF0bWVsLm8NCiAgICA+PiAgb2Jq
LSQoQ09ORklHX1BXTV9BVE1FTF9ITENEQ19QV00pCSs9IHB3bS1hdG1lbC1obGNkYy5vDQogICAg
Pj4gIG9iai0kKENPTkZJR19QV01fQVRNRUxfVENCKQkrPSBwd20tYXRtZWwtdGNiLm8NCiAgICA+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLWFzcGVlZC1hc3QyNjAwLmMgYi9kcml2ZXJz
L3B3bS9wd20tYXNwZWVkLWFzdDI2MDAuYw0KICAgID4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQog
ICAgPj4gaW5kZXggMDAwMDAwMDAwMDAwLi42OGE0NWJhM2IzMmINCiAgICA+PiAtLS0gL2Rldi9u
dWxsDQogICAgPj4gKysrIGIvZHJpdmVycy9wd20vcHdtLWFzcGVlZC1hc3QyNjAwLmMNCiAgICA+
PiBAQCAtMCwwICsxLDMxNiBAQA0KICAgID4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vci1sYXRlcg0KICAgID4+ICsvKg0KICAgID4+ICsgKiBDb3B5cmlnaHQgKEMpIDIw
MjEgQXNwZWVkIFRlY2hub2xvZ3kgSW5jLg0KICAgID4+ICsgKg0KICAgID4+ICsgKiBQV00gY29u
dHJvbGxlciBkcml2ZXIgZm9yIEFzcGVlZCBhc3QyNjAwIFNvQ3MuDQogICAgPj4gKyAqIFRoaXMg
ZHJpdmVycyBkb2Vzbid0IHN1cHBvcnQgZWFybGllciB2ZXJzaW9uIG9mIHRoZSBJUC4NCiAgICA+
PiArICoNCiAgICA+PiArICogVGhlIGZvcm11bGEgb2YgcHdtIHBlcmlvZCBkdXJhdGlvbjoNCiAg
ICA+PiArICogcGVyaW9kIGR1cmF0aW9uID0gKChESVZfTCArIDEpICogKFBFUklPRCArIDEpIDw8
IERJVl9IKSAvIGlucHV0LWNsaw0KICAgID4+ICsgKg0KICAgID4+ICsgKiBUaGUgZm9ybXVsYSBv
ZiBwd20gZHV0eSBjeWNsZSBkdXJhdGlvbjoNCiAgICA+PiArICogZHV0eSBjeWNsZSBkdXJhdGlv
biA9IHBlcmlvZCBkdXJhdGlvbiAqIERVVFlfQ1lDTEVfRkFMTElOR19QT0lOVCAvIChQRVJJT0Qg
KyAxKQ0KICAgID4+ICsgKiA9ICgoRElWX0wgKyAxKSAqIERVVFlfQ1lDTEVfRkFMTElOR19QT0lO
VCA8PCBESVZfSCkgLyBpbnB1dC1jbGsNCiAgICA+PiArICoNCiAgICA+PiArICogVGhlIHNvZnR3
YXJlIGRyaXZlciBmaXhlcyB0aGUgcGVyaW9kIHRvIDI1NSwgd2hpY2ggY2F1c2VzIHRoZSBoaWdo
LWZyZXF1ZW5jeQ0KICAgID4+ICsgKiBwcmVjaXNpb24gb2YgdGhlIFBXTSB0byBiZSBjb2Fyc2Us
IGluIGV4Y2hhbmdlIGZvciB0aGUgZmluZW5lc3Mgb2YgdGhlIGR1dHkgY3ljbGUuDQogICAgPj4g
KyAqDQogICAgPj4gKyAqIFJlZ2lzdGVyIHVzYWdlOg0KICAgID4+ICsgKiBQSU5fRU5BQkxFOiBX
aGVuIGl0IGlzIHVuc2V0IHRoZSBwd20gY29udHJvbGxlciB3aWxsIGFsd2F5cyBvdXRwdXQgbG93
IHRvIHRoZSBleHRlcm4uDQogICAgPj4gKyAqIFVzZSB0byBkZXRlcm1pbmUgd2hldGhlciB0aGUg
UFdNIGNoYW5uZWwgaXMgZW5hYmxlZCBvciBkaXNhYmxlZA0KICAgID4+ICsgKiBDTEtfRU5BQkxF
OiBXaGVuIGl0IGlzIHVuc2V0IHRoZSBwd20gY29udHJvbGxlciB3aWxsIHJlc2V0IHRoZSBkdXR5
IGNvdW50ZXIgdG8gMCBhbmQNCiAgICA+PiArICogb3V0cHV0IGxvdyB0byB0aGUgUElOX0VOQUJM
RSBtdXggYWZ0ZXIgdGhhdCB0aGUgZHJpdmVyIGNhbiBzdGlsbCBjaGFuZ2UgdGhlIHB3bSBwZXJp
b2QNCiAgICA+PiArICogYW5kIGR1dHkgYW5kIHRoZSB2YWx1ZSB3aWxsIGFwcGx5IHdoZW4gQ0xL
X0VOQUJMRSBiZSBzZXQgYWdhaW4uDQogICAgPj4gKyAqIFVzZSB0byBkZXRlcm1pbmUgd2hldGhl
ciBkdXR5X2N5Y2xlIGJpZ2dlciB0aGFuIDAuDQogICAgPj4gKyAqIFBXTV9BU1BFRURfQ1RSTF9J
TlZFUlNFOiBXaGVuIGl0IGlzIHRvZ2dsZWQgdGhlIG91dHB1dCB2YWx1ZSB3aWxsIGludmVyc2Ug
aW1tZWRpYXRlbHkuDQogICAgPj4gKyAqIFBXTV9BU1BFRURfRFVUWV9DWUNMRV9GQUxMSU5HX1BP
SU5UL1BXTV9BU1BFRURfRFVUWV9DWUNMRV9SSVNJTkdfUE9JTlQ6IFdoZW4gdGhlc2UgdHdvDQog
ICAgPj4gKyAqIHZhbHVlcyBhcmUgZXF1YWwgaXQgbWVhbnMgdGhlIGR1dHkgY3ljbGUgPSAxMDAl
Lg0KICAgID4+ICsgKg0KICAgID4+ICsgKiBMaW1pdGF0aW9uczoNCiAgICA+PiArICogLSBXaGVu
IGNoYW5naW5nIGJvdGggZHV0eSBjeWNsZSBhbmQgcGVyaW9kLCB3ZSBjYW5ub3QgcHJldmVudCBp
bg0KICAgID4+ICsgKiAgIHNvZnR3YXJlIHRoYXQgdGhlIG91dHB1dCBtaWdodCBwcm9kdWNlIGEg
cGVyaW9kIHdpdGggbWl4ZWQNCiAgICA+PiArICogICBzZXR0aW5ncy4NCiAgICA+PiArICogLSBE
aXNhYmxpbmcgdGhlIFBXTSBkb2Vzbid0IGNvbXBsZXRlIHRoZSBjdXJyZW50IHBlcmlvZC4NCg0K
ICAgID4gQW5vdGhlciBpczogVGhlIFBXTSBkb2Vzbid0IHN1cHBvcnQgZHV0eV9jeWNsZSAwLCBv
biBzdWNoIGEgcmVxdWVzdCB0aGUNCiAgICA+IFBXTSBpcyBkaXNhYmxlZCB3aGljaCByZXN1bHRz
IGluIGEgY29uc3RhbnQgaW5hY3RpdmUgbGV2ZWwuDQoNCiAgICA+IChUaGlzIGlzIGNvcnJlY3Qs
IGlzIGl0PyBPciBkb2VzIGl0IHlpZWxkIGEgY29uc3RhbnQgMCBsZXZlbD8pDQoNCk91ciBwd20g
Y2FuIHN1cHBvcnQgZHV0eV9jeWNsZSAwIGJ5IHVuc2V0IENMS19FTkFCTEUuDQoNCk90aGVyIG5h
bWluZyBzdWdnZXN0aW9uIEkgd2lsbCBmaXggaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtz
DQoNCg==
