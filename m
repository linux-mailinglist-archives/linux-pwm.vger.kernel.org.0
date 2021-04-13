Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B2635D525
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Apr 2021 04:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbhDMCL7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 22:11:59 -0400
Received: from mail-eopbgr1300139.outbound.protection.outlook.com ([40.107.130.139]:29568
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239254AbhDMCL5 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 12 Apr 2021 22:11:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtJ3ukqLuGSdXiZYRcAiUs0FF/uXiHrdqRbulrth59M9o5hBpRNP+v7hMEIMVYZHtGGUHliJREsVwVLcRIDdddOGj8OzwqiQBgaGUE84WntyGgZ+mVJXnbVjbk+56XBXMM6xDfU1vHZKuppTtl17lICgxYILNlBVfMl+rxOkByQEnuy7NTT5jnJZyRcLe84jQeBpgrrhe4l8KZGmSyvpxm+3nGaoqLGFqXp3M0IQh9yZT5cYN5y6VGugfuMmZAvFe7EeuARxp48/F2Fcu38y+GMfbrhWcG/6ERBt5h5FHS1xcWkv1gNboRoCDpjPRk8oQRSNI4If/bvX57byHq31qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtFkONwTsv4YY8agLXNOZThLsllqfV5U6g9hvd3Ksow=;
 b=bKG3MRkFj5u/g1mKn+dT00uODhoSs3ypM8ewqjIOpDGZbq5+D7ZctTInLB7dhN0FQV1RRst630Xfp1e8kjqgH1lGSIXVjbUnNCSuoBo/Qulic0G7PxozkEG3N1cjwatIiRnq3SnDxj2/8D/mZEoo3i4c9V6Wm6UaA1HV2rDv1sau3qCFlDyGTCRMtru/jgtw87TjaJ0YPWdRfUATnMha4hW/oQg5PlAmpJwJOqUhpCvTnTcx8gW9FGD0x/FcG7u1/D+kIUscMGyMfFmYq8EAWy88UfGUH4uj3qeWzqQUk2IOo/xCYPP8tJr8CTQxCg7miw8Q9sc52Wm854SRJyU+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK2PR06MB3537.apcprd06.prod.outlook.com (2603:1096:202:36::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 02:11:30 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::4d49:12fe:2d9a:b1bd]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::4d49:12fe:2d9a:b1bd%3]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 02:11:30 +0000
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
Subject: Re: [PATCH 4/4] pwm: Add support for aspeed pwm controller
Thread-Topic: [PATCH 4/4] pwm: Add support for aspeed pwm controller
Thread-Index: AQHXL4HkpEnvYhPT9U6/7p/B4+axNaqwutwAgAGA3YA=
Date:   Tue, 13 Apr 2021 02:11:30 +0000
Message-ID: <BAD0AD58-BE95-4EF2-BC3F-EFAA19A91965@aspeedtech.com>
References: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
 <20210412095457.15095-5-billy_tsai@aspeedtech.com>
 <20210412111400.w4yafy2r2lcy3qqv@pengutronix.de>
In-Reply-To: <20210412111400.w4yafy2r2lcy3qqv@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acf280fe-c321-4469-d16d-08d8fe2173bd
x-ms-traffictypediagnostic: HK2PR06MB3537:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR06MB353703725F848F10BCD7A6C78B4F9@HK2PR06MB3537.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5u4ME1wft5yNZjvJ7oiG4xvQ51pt7QTK/NDFTiGO8/EHt/dOQh34cmvpevXpvlupY0KBXr0TScPEBraExoQYqdIczfkJWKtQJ3JCBxTk6xMmgpcIhJO35aJAX3X0JM37o2t0ke73KrC85JMXTinPko1Ri2J4ReS08vNC+w6gku/n+VfTeqUHHc3wRvyLAS8nuMOpAlVO5Y39Zom2Wr1Wf4mr/Q07VkPNjj5b/eGQgPJHopnLkCuJSwv377bSuuqeV7jM6zzOhjCAb8us1foDTRm5KrMPifGkOPWVBvtjGVs0VfpGffWwL1gf0rCroGDex5AXISZrS+600Rt7RRUQrcIQr33J1eaxvm8NrN9t2ysUSffJakQ2lAWSn0xM7EiyjLTdQUJ0G9c32yQKst026SjwGWQpjdpb+aBINJ8Hcgn2jMIzxShow9Jovbkl/sTyOTcOwPyYh5Pa2rFXGh+xMYBtlwSJBZ3cE4xh3Qq1SGMIA+43Qf1pFJX6Pxoch1Z5+VgFBU8gBvpnQ4kSB/q12DQ8WNbY1lC0dhkIomFDh6YUraYvKqDSmDXFDwiV0tP+QIfU/TC91GPEoHMjYy/yku51PMFVDK7kuLHCtaSIbgtfKLcGFm+deszX1dDOmKiFqmo9HazpEVyGeoQp2WYAAvay/hpdWeype5XW6sn44bMx0qlWPvZouGo7476fTPCERUn55BNBVAbEvcmXXnQxhPRoEQuSnQzWniEiqgK2VhQxdTqldB/MKXtO58p+uJub
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(346002)(39840400004)(71200400001)(38100700002)(76116006)(107886003)(66476007)(66946007)(33656002)(64756008)(66446008)(7416002)(66556008)(6506007)(54906003)(6512007)(8676002)(55236004)(5660300002)(2906002)(4326008)(6916009)(478600001)(26005)(86362001)(6486002)(36756003)(966005)(316002)(2616005)(66574015)(8936002)(186003)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: axW2e844Y3ISbp+wwEYlsqyunoTro8Ki6wOmysjGdl4DQcPd1+9GYqGjkWHEDMnr9flS3XHNxgsiHDTS3y3/O0zZRzluq5OULAt/GWgs1s2zzcS9yDH1/9IH83HE1Dn/HGBGB9nrQqf+hIRyibGBG5O++678URMOP70eedoUs8YS8v/jO+adohLWLnbcWnWyB2DaORd8nshesSyHn25A4jHaizZL0VQ5wH83HJv2YCHnSA/zQqfdnKl7HzsmzRNhtbErlx1RjnUjATHydF/0NQQJRIEUO5G2PZ+BiFPJ/hI/5F6xJ1Ju4yLDTGt0S/7AFLpHfbBHzLWrBRPcHjxidUilhgOOj769MJxQu0DOTv3FlSvHv9ymNztEVn3jOD4JJaTXdXbIi24C5cD3HyVUFMcRbPd8OJKQ7Yp73q34kX36HmVtfxmk0yMC3VKWLEldeqxK0vF8VQYDixsH9Jd8eAxbg8ZJi3DvNdnCv1v8UsWI7md5XjznYncbbElkGYbpGRZmpUV3acKF1Aq/Fjl5RCW5vIhNJ3n0sBvhJCgaVFHSDS1f0RCMvbI2v8YbiDv+f12etDI91flRWaza7qq+qQT+ocblmpDv+3By7KuN2Xldv1LtLgW65PopZtNGkWPkSTGrtsupijXIwDJeB3mF5XYqlaHhWRVU0K9AYXrh8DRVs8VOtV5DCc3seygH6w9hgqVVnRMQQFYWaE6fyW/Ss5umcoCDE1OyC/ISOgJENZwP+9CHpP9jn4q7ISawduIU
Content-Type: text/plain; charset="utf-8"
Content-ID: <95FB6D91137D5E42B958F38694EDCE15@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf280fe-c321-4469-d16d-08d8fe2173bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 02:11:30.1121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIEjRLeydxa5WGPTxvDKzKmG/PVN0e5yErJIvlNpzyeRjk0Smq9uqhgPOJVLKSGUFDjF4vn1wrIktW4JDP2kLAH2OzBQddk2SFr6xIZHYL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB3537
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHJldmlldw0KDQpCZXN0IFJlZ2FyZHMsDQpCaWxseSBUc2FpDQoNCk9u
IDIwMjEvNC8xMiwgNzoxNCBQTSxVd2UgS2xlaW5lLUvDtm5pZ3dyb3RlOg0KDQogICAgPkhlbGxv
LA0KDQogICAgPk9uIE1vbiwgQXByIDEyLCAyMDIxIGF0IDA1OjU0OjU3UE0gKzA4MDAsIEJpbGx5
IFRzYWkgd3JvdGU6DQogICAgPj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBwd20gY29udHJvbGxlciB3
aGljaCBjYW4gYmUgZm91bmQgYXQgYXNwZWVkIGFzdDI2MDANCiAgICA+PiBzb2MuIFRoaXMgZHJp
dmVyIGlzIHBhcnQgZnVuY3Rpb24gb2YgbXVsdGktZnVuY2l0b24gb2YgZGV2aWNlICJwd20tdGFj
aA0KICAgID4+IGNvbnRyb2xsZXIiLg0KDQogICAgPnBsZWFzZSBzcXVhc2ggdGhpcyBpbnRvIHBh
dGNoIDMuDQoNCk9LLCBJIHdpbGwgc3F1YXNoIGl0IHdoZW4gc2VuZGluZyB2Mi4NCg0KICAgID4+
IFNpZ25lZC1vZmYtYnk6IEJpbGx5IFRzYWkgPGJpbGx5X3RzYWlAYXNwZWVkdGVjaC5jb20+DQog
ICAgPj4gLS0tDQogICAgPj4gIGRyaXZlcnMvcHdtL0tjb25maWcgIHwgNiArKysrKysNCiAgICA+
PiAgZHJpdmVycy9wd20vTWFrZWZpbGUgfCAxICsNCiAgICA+PiAgMiBmaWxlcyBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKykNCiAgICA+PiANCiAgICA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20v
S2NvbmZpZyBiL2RyaXZlcnMvcHdtL0tjb25maWcNCiAgICA+PiBpbmRleCA2M2JlNTM2MmZkM2Eu
Ljk0N2VkNjQyZGViZSAxMDA2NDQNCiAgICA+PiAtLS0gYS9kcml2ZXJzL3B3bS9LY29uZmlnDQog
ICAgPj4gKysrIGIvZHJpdmVycy9wd20vS2NvbmZpZw0KICAgID4+IEBAIC00Miw2ICs0MiwxMiBA
QCBjb25maWcgUFdNX0RFQlVHDQogICAgPj4gIAkgIEl0IGlzIGV4cGVjdGVkIHRvIGludHJvZHVj
ZSBzb21lIHJ1bnRpbWUgb3ZlcmhlYWQgYW5kIGRpYWdub3N0aWMNCiAgICA+PiAgCSAgb3V0cHV0
IHRvIHRoZSBrZXJuZWwgbG9nLCBzbyBvbmx5IGVuYWJsZSB3aGlsZSB3b3JraW5nIG9uIGEgZHJp
dmVyLg0KICAgID4+ICANCiAgICA+PiArY29uZmlnIFBXTV9BU1BFRURfRzYNCiAgICA+PiArCXRy
aXN0YXRlICJBU1BFRURHNiBQV00gc3VwcG9ydCINCg0KICAgID5ObyBkZXBlbmRzPw0KDQpJIHdp
bGwgYWRkICJkZXBlbmRzIG9uIChBUkNIX0FTUEVFRCB8fCBDT01QSUxFX1RFU1QpIiBmb3IgdGhp
cyBjb25maWd1cmUuDQoNCiAgICA+QmVzdCByZWdhcmRzDQogICAgPlV3ZQ0KDQogICAgPi0tIA0K
ICAgID5QZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBVd2UgS2xl
aW5lLUvDtm5pZyAgICAgICAgICAgIHwNCiAgICA+SW5kdXN0cmlhbCBMaW51eCBTb2x1dGlvbnMg
ICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUvIHwNCg0K
