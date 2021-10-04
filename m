Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDDF4204C9
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Oct 2021 03:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhJDBrz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 3 Oct 2021 21:47:55 -0400
Received: from mail-eopbgr1320133.outbound.protection.outlook.com ([40.107.132.133]:19968
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232053AbhJDBrx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 3 Oct 2021 21:47:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3h0VbPFdFJGkQCZ5/cntFLhBSu9+FxhOR2r6bCfHWZXU7oU7J1bvK0D4yvls1+kRiKVrOpS5gewFeJhKfFOxEIbgPYlWCNURJY9L7LGJU2jo4hBn/ijFV1P6s1QZsLbHmgMaK2tHfMKhUrgUogaegBxI4XA6EiaFCzauxwcxt7wcT2YznRE4nms+6jR7339dNqbxsLM7GnX9sp8VwZA096f7zq6w/d2LgNbn0lZViyXokH1GxB3HY1h+MrS61WB+2BeqHP+mFqRbS7ZSoSSJpfR/xHkgiZi2t449OsP/WOyWqDhvCyLuF0HOzpkK9Jk7FTJ+umQu3cGQVdTxNJBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ0Y1Yn0mN/afGSqEEKviuX6aXidvsbRL7XqzU9Xt3I=;
 b=ZmCPN6S1hyp2xdo7fZ56ZR7JeiWu04noUww822T24gyInyB1sJZxZr2I7QNMlCT2Jo0i9fXho6kd4ZfmssZZeyKk52T61sfclNqSGaW5WU3TRryfkXGXA0/vrz3izLViYXGXH5k0/vyTB0LXneOKgXG2TnHzMoLIcMwaA/fqNmrziTk2+wEgroye/m8hP+YVHJbtRSdu6rsUE++WY1B4UmsiH3jSUUFBGFdte9VuxeLRgLcM72C6UUMXwTPmbe2teZDsUsGT0zrKocz4ypSAEPhDeDBpkFwnJwzGn9EJ1+s/BPvn/zN7P7ghNm2JwgFQFocl4VpiQ80J+/n6KZI7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ0Y1Yn0mN/afGSqEEKviuX6aXidvsbRL7XqzU9Xt3I=;
 b=F9xrs2b3K2nThkG6nP3mwX2w/mA7N84k7pE9QDEkpCjC2Gy1GmfBkn9gXjdyWHiOvOcGKYU1y6VCHbQ2vSUuh4aMsMQGQOFr36KHhV2YYgRXEGhg28NU/PTumjuYOLwW6qXbdaOE+jgZJ3SGG0xb+kAakua+EP3tf32EYm7yEkxkEZL6cGAFedDuCWXA8j7igRd2ArYBahS6vdxLFtxtCphK+jBGnhZf4iJjZP9YYUGIFzp+gLAmAWXYrGn3Usky2mqN7lzNOQjLMVM6Dj+hsDEsZaBDvAN0tKSUhaYJzjNsXybjpAq1yircInmW6BgEwrR0uID+giDi4UPKYc6JiQ==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB2130.apcprd06.prod.outlook.com (2603:1096:203:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Mon, 4 Oct
 2021 01:46:01 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::190:5c40:6d3c:ca8a]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::190:5c40:6d3c:ca8a%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 01:46:01 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
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
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v9 1/2] dt-bindings: Add bindings for aspeed pwm-tach.
Thread-Topic: [v9 1/2] dt-bindings: Add bindings for aspeed pwm-tach.
Thread-Index: AQHXdI7yKsdmsqvIQUSavJJdmrvZGatBf8qAgADnWgCAgLj9AA==
Date:   Mon, 4 Oct 2021 01:46:01 +0000
Message-ID: <A7C9DA11-6880-46EC-BD71-2E1984EBA294@aspeedtech.com>
References: <20210709065217.6153-1-billy_tsai@aspeedtech.com>
 <20210709065217.6153-2-billy_tsai@aspeedtech.com>
 <20210713221431.GA936073@robh.at.kernel.org>
 <029CA29B-1488-4F73-A9E7-FB9BCD0B987F@aspeedtech.com>
In-Reply-To: <029CA29B-1488-4F73-A9E7-FB9BCD0B987F@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1de52e1d-1b85-4c29-b4af-08d986d8b88b
x-ms-traffictypediagnostic: HK0PR06MB2130:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB21309D81F10043BE094E2F428BAE9@HK0PR06MB2130.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7QS/+GbjIW4rSAiHWn0FHS2RMSdonwgbbyCfoYDKzGj2OK7MNjYFsfKhwkcWwrsE9hdKXiKNx+bbGbNjbeXeWLMzV3ZMVPurFjnccludRE78ImCt4agwQIvM5hZ3WpMjVmZFJ4Eu83XkA4+jZ9JcxcRkAubq77zHpTaEF8ITZEIsjmwYYK02K1DlXPrxJLDk5shA57uAefpYs8W4FGKi8dkrO57bnkfF6FFRNk5ho0apoKY3KT6M1mJRZZkE3zlila2IRa+G1LuZSmvKYJ5Uis9zoj1zDfltAdshgOOuu7ABQcRR/8xIXCTSr9T5cQpKzV07jkgkrGvAfCPIV64TdWDdDXslPDQUzcjJDrm3OWSy+fJTWcKo5lWPMVwZR6hUmgp/1JQPqPViQ478FEkPnluRTCMOJJ1ii1cQoOTUCXp0X+wm+xHRlUaNKdLRAlBgv5pAELLmO1YKeZSjDFYMRvBHNTw+gKP1Uoprs1AGYxEVkR8ynKd2uajJB/NiQru23hLvRDMxalUFME5NEjuqZIEaBw8YGtTa29TJnc0TMjtZdqHVXjr4Q5ffFniVZ/yFRED4BoyHYq1qNPzqqW6V6kkX65KlIY3rtAlqrOFW3mekNmjfHOsvDHDIk9JKC6ehEr4wjuDWBy1UlL1Z2kweOY+DeqviqFMZqcvSTIY+qb22kGk3JYqMCDpQ1o2G3DFI7F8iaOvaq7ml3E5s3QRNMKtALpGciI4fI5eBAjF0KYvGm39lNClOvpcjOzbczz7k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(6512007)(71200400001)(5660300002)(316002)(2616005)(83380400001)(4326008)(33656002)(6506007)(6486002)(107886003)(508600001)(2906002)(122000001)(66946007)(38070700005)(36756003)(76116006)(8676002)(186003)(66556008)(86362001)(66446008)(64756008)(7416002)(54906003)(8936002)(6916009)(38100700002)(66476007)(26005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVd5MlpBaFRDQnk0eFdtdjJGK2tEeDNhZ1hCL3BTUWZ4UFBWOFgyN0RyUUxp?=
 =?utf-8?B?RFJXajBnQ3pHSlJHVVNCRHFaR2FTUlFjQVQwL1NyQjdEd0hteHRVeDdiTERJ?=
 =?utf-8?B?UWhwdGYzVXZDd1dVTHUwaEFwdWZMNkdtYWcxc0FOeko3bm41SDdHNFFHWGNq?=
 =?utf-8?B?UHU4c2Z6cW95R3BRQ3puWnJEMEFkSmwwZzVkSjF6eXFzb1g4UmlRdFFIdS9G?=
 =?utf-8?B?eDZ5am5xbURzbjlOdkVGVUdDajFkbEFXd25NV1k4Q2FSOE9TODlTeEUrU0JX?=
 =?utf-8?B?L0UzR1E1VkY3YllacmVmTy9pODlRR1k0VHFjempXZzYwUUhOMEpwYlZqVzFW?=
 =?utf-8?B?dVozcC95RTgvSjgyeDJBQkNjMzhvY0QwVXFNNUJFRGpjRWxLdUNzUXhpekhO?=
 =?utf-8?B?MUNTa1pSVkFzbnFNa01RZ1lqcDlIbHZjVzZET2FiekkyOEQwbFp2OFNuQXAw?=
 =?utf-8?B?ck9nSS9WNlV4ZEcxUHpabGpOKzRWWUUxUlFIR0NTbHIwMG9WSmZNclpVK3E2?=
 =?utf-8?B?dnRkVnRscFRrWXQvczYzQW1UTUkrYjFHaWcyWkR1Nkh2emx0cEx2VnQ1NFBC?=
 =?utf-8?B?NkI2dk9Da0ZJbWFQZDJkdGRYMVlMa0ZXWTR1RGJkOUlRUXp0NWJ3VS92cDRP?=
 =?utf-8?B?azdMc2R0M2padHR1ZURJMkJRUENaeHpsNFpqVWVFcUFIMnBJeCs4VHMvSDJE?=
 =?utf-8?B?SkswcHEweW5CR3FSdkFaQVF4R210di9QMlJjbFp3TkFnZWR6bDJ3U2JodHM1?=
 =?utf-8?B?c1BEVXlUVTJKUjUrTmdpYytXdzd3aWpRall5Qi9PWmtsRGp2QXluWWRzcDhY?=
 =?utf-8?B?Y1QvNE01YjBReEE3Q0VYR1oxRUZWZmtkaEh0dloyTzlqdmVIQWtFSWVYYUJq?=
 =?utf-8?B?ZkZxSEdabEN2d3hQeG0vZU44K1ZoL0lENW5JSVRyMk9VTXh4bGtnb2NDYm4y?=
 =?utf-8?B?UGoxbElzbEprUHJaVnFja2F5c2x3RWRKRW96S0tFZjYrQlhoUnB4Z2Y4ZnFi?=
 =?utf-8?B?ZU5yQWQ4aXZ5ZGlBdFltcDFmS1dwcVBkNTE3enN4bHNpc0p5aEVWc3U4QVRR?=
 =?utf-8?B?SSt2cWNQWk1CdGhhVDJKUjJucVlwa0pMZGl5dFBpbzljSWlCTjlLZFlwb2g4?=
 =?utf-8?B?eXFTOWN4cnpScXJqSFdIdXJjTmxwaHNOQ21zNlFlM2FJeitZL1NDMUlOZ0Qy?=
 =?utf-8?B?Y2ozU1JKR1BZcTkyK2x1RXJhaktKQkdnZDJsMlgrK2hURURUKytIU1RtWGdQ?=
 =?utf-8?B?bzFBM3M5QkdNWDk0S0N3MzlZcVo4Tzk2VStLOGFnN2hMYVBYRk45M0tZd3BN?=
 =?utf-8?B?NDJYaFV3MEFGV1VBZC9VRWoyY2FlZ0hjTkw5SGFYRUI1RW9adWx2UHc2MVRP?=
 =?utf-8?B?MVU2S0J2NGpnS0lZalk5N2dMQzE1NXRTZ1B3S3hhUkFEeFpUc29YMUVKOGkz?=
 =?utf-8?B?dFdlODVvalpOZ0d6YzBGdmJweTM1RVE3Zzc3MEhPcUQwTFc4U2p2NERKOEsx?=
 =?utf-8?B?N2pMMXZwaVN5dGFKMytqTHpnLzBkR012THNDVXdoN1I0bWJpbzBtZ0czczN2?=
 =?utf-8?B?RUJOS2JXRFNNdU4yay91OG1MUEtSYVdvWW9vMW1LS2h6NVg2Q3FmVmpEaWI0?=
 =?utf-8?B?a2pNbUFMU3d0anN3d3BwRU54Sy9MZFdpeTBxMXB0Tis4TFVaR211MkFodUVs?=
 =?utf-8?B?ZkZKbEhRVk9rSzk2VWtmN20rTlY1TkIzWE16OXZ3clkzamJmdkRic3crTGhl?=
 =?utf-8?B?Ym9uREgrd3JVSzdLZmtIYkFPakZpRW5aa3ZMeWx6a3JvTWFZc09Qei9xVVNx?=
 =?utf-8?B?VEx0T2R3V3FaUWZ3eHh3QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <584BF32B0E45C64D8F02990057956594@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de52e1d-1b85-4c29-b4af-08d986d8b88b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 01:46:01.5787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gU3lDq2JZ2paWztCit2O8qxD88PxEsTgkpSQ93p48vLsMWQU6k0JZt39ESlLP/yPbOOhe9eO0F+VPPnxUskn+UBlYqdHi4cKL1Wo7Y4cQsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2130
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgUm9iLA0KDQpPbiAyMDIxLzcvMTQsIDEyOjAyIFBNLCAiQmlsbHkgVHNhaSIgPGJpbGx5X3Rz
YWlAYXNwZWVkdGVjaC5jb20+IHdyb3RlOg0KDQogICAgT24gMjAyMS83LzE0LCA2OjE0IEFNLCAi
Um9iIEhlcnJpbmciIDxyb2JoQGtlcm5lbC5vcmc+IHdyb3RlOg0KDQogICAgICAgIE9uIEZyaSwg
SnVsIDA5LCAyMDIxIGF0IDAyOjUyOjE2UE0gKzA4MDAsIEJpbGx5IFRzYWkgd3JvdGU6DQogICAg
ICAgID4+PiBUaGlzIHBhdGNoIGFkZHMgZGV2aWNlIGJpbmRpbmcgZm9yIGFzcGVlZCBwd20tdGFj
aCBkZXZpY2Ugd2hpY2ggaXMgYQ0KICAgICAgICA+Pj4gbXVsdGktZnVuY3Rpb24gZGV2aWNlIGlu
Y2x1ZGUgcHdtIGFuZCB0YWNoIGZ1bmN0aW9uIGFuZCBwd20vdGFjaCBkZXZpY2UNCiAgICAgICAg
Pj4+IGJpbmRpbmdzIHdoaWNoIHNob3VsZCBiZSB0aGUgY2hpbGQtbm9kZSBvZiBwd20tdGFjaCBk
ZXZpY2UuDQoNCiAgICAgICAgPj5JJ2xsIHNheSBpdCBhZ2FpbiwgdGhlIGZhbiBjb250cm9sIGgv
dyBuZWVkcyBzb21lIGNvbW1vbiBiaW5kaW5ncyBmb3IgDQogICAgICAgID4+ZGVzY3JpYmluZyBm
YW5zIGFuZCBmYW4gY29ubmVjdGlvbnMgdG8gcHdtIGFuZCB0YWNoLiBJJ20gbm90IGdvaW5nIHRv
IA0KICAgICAgICA+PnNpZ24gb2ZmIG9uIG1vcmUgZmFuIGJpbmRpbmdzIGp1c3QgZG9pbmcgdGhl
aXIgb3duIHRoaW5nLg0KDQogICAgPiBUaGlzIHBhdGNoIGRvZXNuJ3QgdXNlIHRvIGJpbmRpbmcg
dGhlIGZhbiBjb250cm9sIGgvdy4gSXQgaXMgdXNlZCB0byBiaW5kaW5nIHRoZSB0d28gaW5kZXBl
bmRlbnQgaC93IGJsb2Nrcy4NCiAgICA+IE9uZSBpcyB1c2VkIHRvIHByb3ZpZGUgcHdtIG91dHB1
dCBhbmQgYW5vdGhlciBpcyB1c2VkIHRvIG1vbml0b3IgdGhlIHNwZWVkIG9mIHRoZSBpbnB1dC4N
CiAgICA+IEl0IGlzIGRpZmZlcmVudCBmcm9tICJhc3BlZWQtcHdtLXRhY2hvLnR4dCIgYW5kICJu
cGNtNzUwLXB3bS1mYW4udHh0IiB3aGljaCBvbmx5IGZvY3VzIG9uIGZhbiB1c2FnZS4NCiAgICA+
IEl0IGlzIG1vcmUgbGlrZSB0aGUgImtvbnRyb24sc2wyOGNwbGQueWFtbCIgdGhlIGRldmljZSBp
bmNsdWRlcyBhIGZhbiBtb25pdG9yIGFuZCBQV00gb3V0cHV0IGRldmljZXMuDQoNCkNhbiB5b3Ug
Z2l2ZSBtZSBtb3JlIHN1Z2dlc3Rpb25zIGFib3V0IHRoaXMgcGF0Y2g/DQoNClRoYW5rcw0KDQoN
Cg==
