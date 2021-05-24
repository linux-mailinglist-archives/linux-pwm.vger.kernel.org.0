Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CD438DF01
	for <lists+linux-pwm@lfdr.de>; Mon, 24 May 2021 03:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhEXB5w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 23 May 2021 21:57:52 -0400
Received: from mail-eopbgr1320094.outbound.protection.outlook.com ([40.107.132.94]:33504
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231744AbhEXB5v (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 23 May 2021 21:57:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fveOkYLvGNmzw479pXxazb8ojpCQO545HLVAmJHRIM8H13uUF0t36i6QuexRo92DrVQvcTW/HODt+plqPMbv2CLPrGewBgeOLPst0puZrm/UqxdsvqONvHvI2MRvexpVA5LEH05104hWhvmFNewfg1STOgmtKL0yiUd2ohRebC+R1sC6eyvsaz9Y+U8byXJLBsfjB4OsE4VtOyxuSG+FLvXIHLnJE4TPK+iBx4s4eFUdH+KnqrxfPFxAG8YunsK+T3p5HvOYm4LvKrM1D/Y2f2hrxkHlIfKvAbZYkT3MaxfoFxYDQFcjAxo63fao1v/waIhxXL9y+oYFEOQetgBJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvYTMuDpxK6/2MiwN9gc2Nja4iJXE43LTSiWRpOI4/E=;
 b=Ed02hmGNQUjYr35zvk8wfIJOYw4FM+SHzpVOYwjG3s7K5MtitcuyZnVIya9xDBm2gBV4qF681zGpnT5Y0S6ixWVeGyD+5VGVOHNyHokSpK1SXJnf+XvM4eOXnga1pneKO62JFZ5PDGyOiBXhG7VO+pPBn4lFN/cBh8C5E7y96E0SrUlTss/BfAY7s/fc6J4L9OrcxoyzJHEyRBIONUeG0wVsBZ/7RPMvTSHjI7XZN9vEONyRUMNhQVrihg1Rb6TkqJY4c4yo/CzvUscJeCR37yyKyn88jyYIvbuDGGmv4tRvI7imStbUQWYPU4aNyuj07WdZw4ivjUtEHrX/kIFooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvYTMuDpxK6/2MiwN9gc2Nja4iJXE43LTSiWRpOI4/E=;
 b=FY/+pwtXR9i9OiQGbiIFh6gr2WzXWLJDZ3j/xiWUxJ3rzq+YAOchKvQZHYGQaTZN0NTL4qrUYYrzpuaacWHIdIm/Oqur2aT3Lw7zywOe/oBGZwABVBpQ8cRvTu+quk6KfwKrI/gYCx9zCuJabSnero7VVjF3HnsopXsOtLh8bze1r/HuRVZ1bi2m/Qq5J9u/gp46zOWG7njcdAo5Tmy2lZTCTiqxLpL/OZ9k9bRM+LbVcTChajoCZ4JzLPFfb7y6rXXJ7QFaUC9MUWyn+ef73krv2wUaXnSfRHYqCOy6MqqtcQepMWDWfRxS/I2kc0XwMo/lwFTQ+tcrO8uQmYiQ7A==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB2131.apcprd06.prod.outlook.com (2603:1096:203:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Mon, 24 May
 2021 01:56:19 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::9096:5259:90e5:42dc]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::9096:5259:90e5:42dc%2]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 01:56:19 +0000
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
Subject: Re: [v6 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v6 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHXS4BrVEeu+Idp8UuXdMC2i+TrmqrvsgYAgAK9CoA=
Date:   Mon, 24 May 2021 01:56:19 +0000
Message-ID: <9EA46360-8F43-4D1B-9004-3965A6182FA1@aspeedtech.com>
References: <20210518005517.9036-1-billy_tsai@aspeedtech.com>
 <20210518005517.9036-3-billy_tsai@aspeedtech.com>
 <20210522160708.ryr7n7klapszu2da@pengutronix.de>
In-Reply-To: <20210522160708.ryr7n7klapszu2da@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fa4694f-65ed-48d7-d56b-08d91e571ffa
x-ms-traffictypediagnostic: HK0PR06MB2131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB2131807FB435CDFA745CE7458B269@HK0PR06MB2131.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0dfBVTmYf990gxcD1c3uo1bo2V+IjCDZnxzTyPoSKWyefVSjLPZSMnIN2nZrhSAOdzlfvLpMdj73S/qcQeG8b2uSplhB35L2Cl5ium9rMPdII7EL+uuhT6MLnOeRJtasCkzXTJQBP5k5N09VHMUEvRgqPBYDGgYWdTsyT8BbdqTFtP6vTqQiMXEcOuLdptJ9qcXuV+mkFGOBUCz4ZlkQkB18mWyWzRc9QxB9PaMrjd0QndwS5sBWKrH2YhoYeNfKoD7Y+etqYKr3EsAGx1EwRtKNkRVHlCL14PQyn5bMMfpsUpd2i5nmzrN8Bd2yI0oaIoWOZ9wuFssrmJX+eb9zf9W5x5FCtMYhalCPgwJAC2GYBE9f3W7tjtL5xTn4FjW5j9WfPr5cOiciRdthBUkUl+uJA3K0vBnJiHAXfvTFrcPK2p8kX7V+PUTCNToNiZ7VhYVR7KsedMy9JkwZyLh4IMESSauoNmATPeZZnZ7Ukz0mNqz4LOwhWcikAxB194gVPnoEKWr7QBqQ0aweMkKVqbxbkuD2Ok0pOL7ix0vRzWQRPXm3Q9hKTueoIlG+SPQf2lHm1I9j7mpCuvPGLZcyjUA92KD7jriTBphgnq/wpKbkNcC/2RBhhF5F/CuVybqSpmOnZ8+6RK8a79vi5qTMN5WioWUrkYASx1OKbUyN0Ts=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39840400004)(346002)(376002)(136003)(366004)(26005)(6506007)(66946007)(33656002)(5660300002)(2906002)(66476007)(86362001)(66446008)(66556008)(186003)(64756008)(38100700002)(4326008)(8936002)(122000001)(2616005)(7416002)(478600001)(6512007)(54906003)(316002)(36756003)(83380400001)(6916009)(55236004)(71200400001)(8676002)(76116006)(107886003)(6486002)(66574015)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NVRLYlM3bHpkbXJpTGFURHYvQ2EyMGdZRWJGR29KTGdKWkluTE1YVHczL0do?=
 =?utf-8?B?Z0N1bStDeVN6RWYvbFVtbjBMVVNKWnowZjNHUU1TYnBVM0ZZVE5wN1BwWmx3?=
 =?utf-8?B?Z2xsbkJ0bDZKbVduMW5saFpRa21UUXFrOHVEQzQ3cmFDSFNZOFRNTXZiMmxJ?=
 =?utf-8?B?SHdGL3FZSWltVlE3elE4d0tiSHAzOGRtQjk4VzB0MC9ZdHI0Z1drSUpiK0ZZ?=
 =?utf-8?B?MVluM21XL2R3dnl0Q3RxTVRWUnFGYzRqNnF5SjVDWHRoWEtSbjllZEpsQmNC?=
 =?utf-8?B?bXZScjUwaW1Rb1k0STcralpncjBTdk5NMkFjVW9uK3FYMjV1Q1F0bmFoTnRH?=
 =?utf-8?B?a2l5dHY1Q3RWTG1tajdkSWdSYXB6aDY5NzRaa2ZSTlMyVnZFSFNsaEJVb2Vx?=
 =?utf-8?B?MXZicm5WaTdyeENxNXFUU2RNOVRqSVFxM0U5M2s5MG05TkVuSm1tM1A1SmIz?=
 =?utf-8?B?amZKS1hsdTFlMzdCcUwxWW1lTE04cGdwR3ZueXZZS1lVNUlyRjdNNkxucEJn?=
 =?utf-8?B?bzh2Qm9ERTRUL2JZb0pvNEtlU0xZNnJqbStLZjduQ01WZHhtcWl4YjdvcUNn?=
 =?utf-8?B?RTNZemVRMjRuRjFsYWNlWXF2M1IvRzZ5MXF6ZFFDcExZRHgwak1CYXBZUjdQ?=
 =?utf-8?B?R2FXQVRHTG9yQnYwNXZDb1NNOEpjTU9HMXpEUlR2MmhiWHVEMG1qSDlyajNz?=
 =?utf-8?B?SlF1TmhHT2E1TVhMTnl3TWhndnpnTlZlOTlFbHVjWm9lMG5wNTdLSDV4V3Nt?=
 =?utf-8?B?NVFsSkZ3QWJZTjVmUWJWUWZibkhuUk0wZy9za0tqMTZTRnhCb3VCRkNDUFBS?=
 =?utf-8?B?T21OL04wczVjRXVNR2krbWxMbktCNGdjSEVWcG4zZnJmTDZxTzVmSWh3TGQx?=
 =?utf-8?B?K0YyaSsza2RlS2N2V25sRUl1bDMzRGVTZ0NJazJaU1VZUUNvTjJSNUZEOWFh?=
 =?utf-8?B?YlhDSjU4M2UrQlVWcFZoWUowQ3VBYVZnODZ3clU3TW43cWtnU0RIUnhLMGRG?=
 =?utf-8?B?RjdxWkdvQi81WkxMUDRxaGdaWVI2WDlESmZOSUtHcU1pZVQwYTEzeU1JQ290?=
 =?utf-8?B?VUVvZHRaT2NyMWNValRsbUV6SllrL254V3hSdmtrRVNqRDRSS0JXUVFYaGRL?=
 =?utf-8?B?MjQxU0ZxTGdjL1d0YnhFVlEyLytkS3M5QmxiNVZwWUhPV2tZcFlFT3pKUnV5?=
 =?utf-8?B?TjNsMFlKQUt5YjdqOGRWUFk2MUhRR2FTeE96U1NGNVd3WCtjbTlRUXgrdVR3?=
 =?utf-8?B?SU81OU1BOFpibmJzbGwwZ1JyWUUvMlE0MlRJOTF4YVdGTjliZjBmMi9OSWlD?=
 =?utf-8?B?VWIwL2JyUmNBd2hseHQ4eWpxaVBiOTg5WnN6TjRwSUlTWko1WHU3WVIwLzBS?=
 =?utf-8?B?d1FrNmJoTzY5cktwMFpwUnpaQ1VIVU5lTGUyRVIzNFFuR0t4dHlNYjAvMVMx?=
 =?utf-8?B?c2xDZVh5bzFvUE9ES0VUZWpLSVRjTTZ3ZldCZVcrNXRrVHBVVUU0MXNFZVNv?=
 =?utf-8?B?UVVtN3M0aTkxUnlNR1lHNmUwSTNDT2F2d2h2UEw3ZmJBTkY0TVNFMTRXb1lj?=
 =?utf-8?B?ZCtqNkQ3Q2JkdVB4UktkUFMwdGFyOWNUL0lmMEo3SGlFUks0bkl6dm9WYTBT?=
 =?utf-8?B?NkRmdDQ3c1p0MzdWUUkzUHVjcnZ1QjIrdk1UUUZNS1N0VnJrSjNMQU40dzl3?=
 =?utf-8?B?MjJIRnovUTNyY29hLzA5SEF3T1lIbzFEanpjMWgzZWgzTm9Lb1RWQTRjSVM3?=
 =?utf-8?Q?cCfU8hL7tcgvvX0Ckv9f+X9D6NdcGYQp90b0pOH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60E32294AAA652489CE6283C0853324F@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa4694f-65ed-48d7-d56b-08d91e571ffa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 01:56:19.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AszpazOpWQuBkyJcZcNXr4JbyxzKFHKX3pCFINmtfq+lUvsAD5uJn0O6kn4Scv1D9NgImM/GzmMO0GMjFFAYWfXwHjQbUN/LpK6LgLwMqa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2131
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGksDQoNCk9uIDIwMjEvNS8yMywgMTI6MDcgQU0sVXdlIEtsZWluZS1Lw7ZuaWd3cm90ZToNCg0K
ICAgIEhlbGxvLA0KDQogICAgT24gVHVlLCBNYXkgMTgsIDIwMjEgYXQgMDg6NTU6MTdBTSArMDgw
MCwgQmlsbHkgVHNhaSB3cm90ZToNCiAgICA+ICAgPiArc3RhdGljIHU2NCBhc3BlZWRfcHdtX2dl
dF9wZXJpb2Qoc3RydWN0IHB3bV9jaGlwICpjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtKQ0K
ICAgID4gICA+ICt7DQogICAgPiAgID4gKwlzdHJ1Y3QgYXNwZWVkX3B3bV9kYXRhICpwcml2ID0g
YXNwZWVkX3B3bV9jaGlwX3RvX2RhdGEoY2hpcCk7DQogICAgPiAgID4gKwl1bnNpZ25lZCBsb25n
IHJhdGU7DQogICAgPiAgID4gKwl1MzIgaW5kZXggPSBwd20tPmh3cHdtOw0KICAgID4gICA+ICsJ
dTMyIHZhbDsNCiAgICA+ICAgPiArCXU2NCBwZXJpb2QsIGRpdl9oLCBkaXZfbCwgY2xrX3Blcmlv
ZDsNCiAgICA+ICAgPiArDQogICAgPiAgID4gKwlyYXRlID0gY2xrX2dldF9yYXRlKHByaXYtPmNs
ayk7DQogICAgPiAgID4gKwlyZWdtYXBfcmVhZChwcml2LT5yZWdtYXAsIFBXTV9BU1BFRURfQ1RS
TF9DSChpbmRleCksICZ2YWwpOw0KICAgID4gICA+ICsJZGl2X2ggPSBGSUVMRF9HRVQoUFdNX0FT
UEVFRF9DVFJMX0NMS19ESVZfSCwgdmFsKTsNCiAgICA+ICAgPiArCWRpdl9sID0gRklFTERfR0VU
KFBXTV9BU1BFRURfQ1RSTF9DTEtfRElWX0wsIHZhbCk7DQogICAgPiAgID4gKwlyZWdtYXBfcmVh
ZChwcml2LT5yZWdtYXAsIFBXTV9BU1BFRURfRFVUWV9DWUNMRV9DSChpbmRleCksICZ2YWwpOw0K
ICAgID4gICA+ICsJY2xrX3BlcmlvZCA9IEZJRUxEX0dFVChQV01fQVNQRUVEX0RVVFlfQ1lDTEVf
UEVSSU9ELCB2YWwpOw0KICAgID4gICA+ICsJcGVyaW9kID0gKE5TRUNfUEVSX1NFQyAqIEJJVChk
aXZfaCkgKiAoZGl2X2wgKyAxKSAqIChjbGtfcGVyaW9kICsgMSkpOw0KDQogICAgPiBUaGUgb3V0
ZXIgcGFpciBvZiBwYXJlbnRoZXNpcyBvbiB0aGUgUkhTIGlzbid0IG5lY2Vzc2FyeS4gVGhlIG1h
eGltYWwNCiAgICA+IHZhbHVlIHRoYXQgcGVyaW9kIGNhbiBoYXZlIGhlcmUgaXM6DQoNCiAgICA+
CTEwMDAwMDAwMDAgKiAyKioxNSAqIDI1NiAqIDI1Ng0KDQogICAgPiBUaGlzIGZpdHMgaW50byBh
biB1NjQsIGJ1dCBhcyBhbGwgYnV0IHRoZSBsYXN0IGZhY3RvciBhcmUgMzIgYml0IHZhbHVlcw0K
ICAgID4geW91IG1pZ2h0IGdldCBhbiBvdmVyZmxvdyBoZXJlLg0KDQpJIGRvbuKAmXQga25vdyBp
biB3aGljaCBjYXNlIHRoZSB2YWx1ZSB3aWxsIG92ZXJmbG93LCB3aGVuIG15IHBhcmFtZXRlciB0
eXBlcyBhcmUgYWxsIHU2NC4NCkNhbiB5b3UgdGVsbCBtZSB3aGF0IGlzICJ0aGUgbGFzdCBmYWN0
b3IiPw0KDQogICAgPiAgID4gK3N0YXRpYyBpbnQgYXNwZWVkX3B3bV9hcHBseShzdHJ1Y3QgcHdt
X2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20sDQogICAgPiAgID4gKwkJCSAgICBj
b25zdCBzdHJ1Y3QgcHdtX3N0YXRlICpzdGF0ZSkNCiAgICA+ICAgPiArew0KICAgID4gICA+ICsJ
c3RydWN0IGRldmljZSAqZGV2ID0gY2hpcC0+ZGV2Ow0KICAgID4gICA+ICsJc3RydWN0IGFzcGVl
ZF9wd21fZGF0YSAqcHJpdiA9IGFzcGVlZF9wd21fY2hpcF90b19kYXRhKGNoaXApOw0KICAgID4g
ICA+ICsJdTMyIGluZGV4ID0gcHdtLT5od3B3bTsNCiAgICA+ICAgPiArCWludCByZXQ7DQogICAg
PiAgID4gKw0KICAgID4gICA+ICsJZGV2X2RiZyhkZXYsICJhcHBseSBwZXJpb2Q6ICVsbGRucywg
ZHV0eV9jeWNsZTogJWxsZG5zIiwgc3RhdGUtPnBlcmlvZCwNCiAgICA+ICAgPiArCQlzdGF0ZS0+
ZHV0eV9jeWNsZSk7DQogICAgPiAgID4gKw0KICAgID4gICA+ICsJcmVnbWFwX3VwZGF0ZV9iaXRz
KHByaXYtPnJlZ21hcCwgUFdNX0FTUEVFRF9DVFJMX0NIKGluZGV4KSwNCiAgICA+ICAgPiArCQkJ
ICAgUFdNX0FTUEVFRF9DVFJMX1BJTl9FTkFCTEUsDQogICAgPiAgID4gKwkJCSAgIHN0YXRlLT5l
bmFibGVkID8gUFdNX0FTUEVFRF9DVFJMX1BJTl9FTkFCTEUgOiAwKTsNCiAgICA+ICAgPiArCS8q
DQogICAgPiAgID4gKwkgKiBGaXhlZCB0aGUgcGVyaW9kIHRvIHRoZSBtYXggdmFsdWUgYW5kIHJp
c2luZyBwb2ludCB0byAwDQogICAgPiAgID4gKwkgKiBmb3IgaGlnaCByZXNvbHV0aW9uIGFuZCBz
aW1wbGlmeSBmcmVxdWVuY3kgY2FsY3VsYXRpb24uDQogICAgPiAgID4gKwkgKi8NCiAgICA+ICAg
PiArCXJlZ21hcF91cGRhdGVfYml0cyhwcml2LT5yZWdtYXAsIFBXTV9BU1BFRURfRFVUWV9DWUNM
RV9DSChpbmRleCksDQogICAgPiAgID4gKwkJCSAgIChQV01fQVNQRUVEX0RVVFlfQ1lDTEVfUEVS
SU9EIHwNCiAgICA+ICAgPiArCQkJICAgIFBXTV9BU1BFRURfRFVUWV9DWUNMRV9SSVNJTkdfUE9J
TlQpLA0KICAgID4gICA+ICsJCQkgICBGSUVMRF9QUkVQKFBXTV9BU1BFRURfRFVUWV9DWUNMRV9Q
RVJJT0QsDQogICAgPiAgID4gKwkJCQkgICAgICBQV01fQVNQRUVEX0ZJWEVEX1BFUklPRCkpOw0K
ICAgID4gICA+ICsNCiAgICA+ICAgPiArCXJldCA9IGFzcGVlZF9wd21fc2V0X3BlcmlvZChjaGlw
LCBwd20sIHN0YXRlKTsNCiAgICA+ICAgPiArCWlmIChyZXQpDQogICAgPiAgID4gKwkJcmV0dXJu
IHJldDsNCiAgICA+ICAgPiArCWFzcGVlZF9wd21fc2V0X2R1dHkoY2hpcCwgcHdtLCBzdGF0ZSk7
DQoNCiAgICA+IGFzcGVlZF9wd21fc2V0X2R1dHkgY2FsbHMgYXNwZWVkX3B3bV9nZXRfcGVyaW9k
KCkgd2hpY2ggaXMgYSBiaXQNCiAgICA+IGluZWZmZWN0aXZlIGFmdGVyIGp1c3QgaGF2aW5nIHNl
dCB0aGUgcGVyaW9kLg0KDQpXaGVuIEkgY2FsbCBhc3BlZWRfcHdtX3NldF9wZXJpb2QgaXQgZG9l
c24ndCBtZWFuIHRoZSBwZXJpb2QgaXMgZXF1YWwgdG8gd2hhdCBJIHNldCAoSXQgbWF5DQpsb3Nl
IHNvbWUgcHJlY2lzaW9uIEV4OiBXaGVuIEkgc2V0IHRoZSBwZXJpb2QgNDAwMDBucywgdGhlIGFj
dHVhbCBwZXJpb2QgSSBzZXQgaXMgMzk2ODBucykgYW5kDQpJIGRpZG4ndCBnZXQgdGhpcyBpbmZv
cm1hdGlvbiB3aGVuIEkgY2FsbCBhc3BlZWRfcHdtX3NldF9wZXJpb2QuIFRodXMsIEkgbmVlZCB0
byBnZXQgdGhlIGFjdHVhbA0KcGVyaW9kIGZpcnN0IGJlZm9yZSBzZXQgZHV0eS4NCg0K
