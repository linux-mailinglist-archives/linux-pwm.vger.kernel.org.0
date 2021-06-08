Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A2339EDA9
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jun 2021 06:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhFHE2W (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Jun 2021 00:28:22 -0400
Received: from mail-eopbgr1310099.outbound.protection.outlook.com ([40.107.131.99]:39382
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229526AbhFHE2W (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 8 Jun 2021 00:28:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWb+n3GNsKiAtFPDS622jXFeg5uWBRmfDG3vwJgu45PGkfx8WTVMfO7RmfVENbpFZA9LvXhF+ALqNzjj9Ty25/cTbQPAJCM1Ho445QIlMFeuVRN8D7qwvKlyWl4e+UaGxPV2cz1S5YMORfKC6j5LwT8YrHHtSD+s0y/upF9vUpIihWzUVQAV9RZUxKcR3/tFI57DF9djw16sLJas8xrxuyGU3E8I6tUGpCURNhqreHQypCojmIACip3mP++2p8MVlyvvGJpQ4JNPXWD/YrAxcCUJE/RBjxAemi8BD4i1wXIZrgQz5BJxBg3vye2uvJiPmyZc94drwgX8SvKpGjmG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3+rwhYvlwrnxcbRES4VKqgW8vG0X0tZwpbphAStXqc=;
 b=CiMvCjoLvg/bzgPNTPCNglf6FDFZH1ntDP4nMQCEwTi6U8a82ClmSUPGybflQuGWgqgM7QXXB81ibA3ffEbxDg26vFj6qcfojGk+Bv8vinu54RZxb2Mq4l+kvJvjMvk0znQ637qS9SO18En0joPWdlNonkTg5sJyv/CYgP/VdZI4nsz6cictFZnEx3eCppaRwpYtPjED/9fTKW++WyP8VIJHyLSYEYw8SAZgs4tdK0ENxGrG9cqhIrQaD9sEBH2pdmedwBqLn6TJ/bOcnhSiJ05ytCP4TTRyVMYldoHrVOgbXVGBPFUIkGLLoFUhR7OJ/tnLZjbQnZiB3rVerekbaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3+rwhYvlwrnxcbRES4VKqgW8vG0X0tZwpbphAStXqc=;
 b=h1p1hfYXHwi1hyw3v8LO8+waW3DVXJ3uEppSbuP8b58YIDIQMFi4fyk0KsmmMG0LQxxPm3AMVLOeXD0r5sXUZl/d3Yid6z/yA2TYyACOTRI0VNa1vPGh2JPQEDtnKIi1gVdmK5g6suL5ERDaKBsQRh8QIvUOE1FHwbM0NXYVoII/75xn77nXuEwgkJIoSntfSakbhc9yuElgSPoCk0DC/DvwJgT4PyCPHTt2jYOq8aIUoBf4LYx/8frJlywG4H62e9GsLStjJXnRmLcBgyFVK3yw4drBog0/ArpyE0mePogC1yGAxo0U4Pmi3aVxqK0hXTX5C80z/3totefxr5rwIg==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK2PR0601MB1985.apcprd06.prod.outlook.com (2603:1096:202:c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Tue, 8 Jun
 2021 04:26:24 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::9096:5259:90e5:42dc]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::9096:5259:90e5:42dc%2]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 04:26:24 +0000
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
Subject: Re: [v7 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v7 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHXUR7UIO+L+RtNj0Czmzu9LSkOd6sIOjSAgAHmiQA=
Date:   Tue, 8 Jun 2021 04:26:24 +0000
Message-ID: <A85AB108-192E-47BB-A6CA-C2013C605466@aspeedtech.com>
References: <20210525043224.27998-1-billy_tsai@aspeedtech.com>
 <20210525043224.27998-3-billy_tsai@aspeedtech.com>
 <20210607072459.mzanptd6mwvalh3n@pengutronix.de>
In-Reply-To: <20210607072459.mzanptd6mwvalh3n@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c327cea-9237-41c2-f0d4-08d92a359359
x-ms-traffictypediagnostic: HK2PR0601MB1985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR0601MB1985DC980ECF6016721F535D8B379@HK2PR0601MB1985.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dcRSHK3nW+nxaMmIHUVCIHLL18I7m6xwl/unRdDoKTzERDgMRuocWBNLm1nB24dbRkkjON0e2mQ1/HX2R3PwzPB6n3v/2oP0TBC7dZOCvMGL4CbV0nQWiL2S+YQ5Hrr32HzQRug3o7vDk+If76QorrXMRTmHGlHTD8hwlyVm7//paceAXDveKrY0/y/zSLCGWsdP/6HmqA+b36WaGB4RCy9yON4+YnkvFZ+6bvMBbhwGJdcTiMxxct0KjSCga7WPZSLTGyGYdz/8dLorj0C/F1rtBkGTjrvPbpTGvse8v6LxHDxhwgcmJg+KGRM0YE2DIR+HKv4k5Pj3rC5ETbTBAEzd2eykOCbPwnHWRsUxq6wJwH3VQUUsLhpZwMgeH222xY0erfAxUGe6JzmwEcZwFGNuj0CkTb5lxyqtJ2SwhtyescmqANyqwmyQRnFZsRwVXa6qBp0EFvM0njhqLZZR8FJhmEfWhK/TQMu0MeNupHVv22+iLxQvWNVa/ulIPOp/fTXGVgBJPfVZQKtFZIXhLwogdI5NAoUodtcpXpCrR+Klv7QkkW2EFKcoz/sj3vwP7uZ4b3KOqY1hHTno+er55vIBHWoY+nIPdZ7btYa0yz0NBsgy2xm/FxWWhWKQpxcCOJwCSf6jRYF4AkpGq5zZmbeZPSP7i2qiyNbLGjzuo1M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(376002)(39840400004)(8676002)(54906003)(26005)(316002)(6916009)(8936002)(36756003)(186003)(71200400001)(4326008)(122000001)(7416002)(6486002)(86362001)(38100700002)(66446008)(478600001)(33656002)(55236004)(6506007)(6512007)(76116006)(5660300002)(66556008)(66574015)(66476007)(64756008)(66946007)(107886003)(2616005)(83380400001)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cWl1ZVF5akNuSklVT0g5UWJ1MmptZG9CZjJFSWZEdHlidWNaMElGam9LYWYy?=
 =?utf-8?B?eUNBQlFQcU1xL2wxZkhQaFNDVi94QzJDTVp0RERrMnRrWVRjL21vaVllVmJS?=
 =?utf-8?B?TjVFZ3hET0JPK3NacFIzTDNOUjFKR05HeWZkamhHZ01uMXFaalR2QkN4b25Y?=
 =?utf-8?B?STQvSGJBRFRxd3pNYXFzR2N4VVl3YzI2VU1jZzROdHBKVnlCYkVRdEZyY1I0?=
 =?utf-8?B?MjAzZlQ2RElvWFVSOEJGNUVhL011dVVtcDBmRnlNYVozMHNIT01oL1Z2WDlo?=
 =?utf-8?B?eTYyazlKNnlHWTR3elhONFRZYUNWeXF6aiswNVZ0cG9NaFRGajJaazcvQ0N0?=
 =?utf-8?B?RzRNWFhhWFNjeW5PUktHUC9hTisrbHRBOFBwWFpEekphUXVnZUtGRDZZbW9S?=
 =?utf-8?B?Y2VhMko3bEVFYXhxTTJ3WnMyb3Z0Z2RsbnVrTS9xOCtMT0dyTFBnaFQxTnhN?=
 =?utf-8?B?Y1Q3azRDWFN4ZHFVSy95MlZEWGY0dld5MTg4TDN3Tk1aMkVYQ0tGRWdaOUdC?=
 =?utf-8?B?ZGpxV1RCV2cwUlFnY2NRcURNTDdBMFR0czJ0WDJCK3I0ZGtKakdaWldBTENV?=
 =?utf-8?B?WE5FaTRGY0I3UFNhSUxXaVpGRlA5QXcvaXBEdUx6WElJRHhhcTFieFREdGVs?=
 =?utf-8?B?VGxocWhLUjk5Z0p3N2dLYndtQTV0ekJDMTluam1QRTBDdXEyTEY5cVl6aDY4?=
 =?utf-8?B?bWhSYmZIakNaSjZ1amUra0pKRjJzaHhUNGdBMmJLRzRtODFGeU1NNjExSnh0?=
 =?utf-8?B?dlREeWtjQXVjQW1WZ29LamozQTQ5ejlUS2JyYW9RTk43a0pGK2ZxR1JFNHdm?=
 =?utf-8?B?M2lYVm9OSzNrZjlKWWRad2xIcm1tb1pZOXJ3cXQ1MGxyaGx3aks1VkNNOW5E?=
 =?utf-8?B?Z0lUeGYvRXcxekhteEtTaG11dXMrYXgyaFNyNjRyMVo4TjRXdlF3eFpYZ1k4?=
 =?utf-8?B?cEU0a1FPU2lYNlFFL21tZzFHWXRqeURnN2lFQ1VLWlVCSG1hZUdYRTIyQlIw?=
 =?utf-8?B?Z3JMd2JaRVlwMUh0K0RoNlhQOU9NVVY5QWtFaktMQXBZcnJaTk1ZMFU0QlNO?=
 =?utf-8?B?MmY4KzRxeElXNkJCb2JQQ081K2FlSkNGTXoyUXZZek1VRXlWa055ZU9zNGsr?=
 =?utf-8?B?U0ZSNjV6RHBQZmt1MkdVaU8rNUJDNzN5WkVQclFsVGI3WTFJRndzaHVHajNv?=
 =?utf-8?B?UTMwUDNMVUJ3c0UxV2U3VGxlSjB2YkxqbTFDdzNvZzBsUUtnRUpSdHVHcVlE?=
 =?utf-8?B?cUNaSXVxNTBSSDd3TVBYSUY2ZHhabFpyOFVEMFRLVGtMUWRYL01LWEpzOFky?=
 =?utf-8?B?Rm1qTW9zUlIwYUpVMEd6NGRZLzlFNG5xQ2hZQkNMY3A4STZCU2t6KzlJakV5?=
 =?utf-8?B?YW5malkxQkFVVmN6UmI3NS9NdG5jdVdETWtHTTVueEF0V1cwNkNBZ1ZpQzhj?=
 =?utf-8?B?eWY5SW41L29pZ1FQTDVKT3NTZlNwTVBkUk9ta3QyZSt4Z2Z3RFc0V3JPbmkx?=
 =?utf-8?B?VmlPNFAzR0RxU2ltMDRpaDA5NzF6N25hQzArQUttd2J1R2N1MEhKOVhLdHBy?=
 =?utf-8?B?VWFCM3NDeU52eENDMFBFT1hWWlJnb01NRkljd1JZenRhZFh2UHZEUDJWbHo1?=
 =?utf-8?B?Wk5yOW9lQVNPTUNXOEx3V0xKTnZuVkZaYjNxMUlwMHJYK2ZZaE1aaG56RTZM?=
 =?utf-8?B?M05Gd0JDbUlnS2djamw1MU5uOTc3b3hBcXovRzBpOVZkSWl6dWNNd0FaOEVL?=
 =?utf-8?Q?DH4p4g+cmQyGMP9V+MS7UsTR0O4XAxQXF4g3aJM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D540CA5D74FFC243A9CBB58F64964122@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c327cea-9237-41c2-f0d4-08d92a359359
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 04:26:24.2384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tm7DM+O4xInoQo3i/oze8Yv1yH1fB/FzwnVBU601KhdAqTYV555w+/bUu0VPVpX1PafRcwTzheCC/f+6V1/RQHLEgTngzD4bP/ZAMyphQbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB1985
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGVsbG8sDQoNCk9uIDIwMjEvNi83LCAzOjI1IFBNLFV3ZSBLbGVpbmUtS8O2bmlnd3JvdGU6DQoN
CiAgICBIZWxsbywNCg0KICAgIE9uIFR1ZSwgTWF5IDI1LCAyMDIxIGF0IDEyOjMyOjI0UE0gKzA4
MDAsIEJpbGx5IFRzYWkgd3JvdGU6DQogICAgPj4gVGhpcyBwYXRjaCBhZGQgdGhlIHN1cHBvcnQg
b2YgUFdNIGNvbnRyb2xsZXIgd2hpY2ggY2FuIGJlIGZvdW5kIGF0IGFzcGVlZA0KICAgID4+IGFz
dDI2MDAgc29jLiBUaGUgcHdtIHN1cG9vcnRzIHVwIHRvIDE2IGNoYW5uZWxzIGFuZCBpdCdzIHBh
cnQgZnVuY3Rpb24NCiAgICA+PiBvZiBtdWx0aS1mdW5jdGlvbiBkZXZpY2UgInB3bS10YWNoIGNv
bnRyb2xsZXIiLg0KICAgID4+IA0KICAgID4+IFNpZ25lZC1vZmYtYnk6IEJpbGx5IFRzYWkgPGJp
bGx5X3RzYWlAYXNwZWVkdGVjaC5jb20+DQogICAgPj4gLS0tDQogICAgPj4gIGRyaXZlcnMvcHdt
L0tjb25maWcgICAgICAgICB8ICAgOSArDQogICAgPj4gIGRyaXZlcnMvcHdtL01ha2VmaWxlICAg
ICAgICB8ICAgMSArDQogICAgPj4gIGRyaXZlcnMvcHdtL3B3bS1hc3BlZWQtZzYuYyB8IDMzNCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCg0KICAgID4gVGhpcyBkb2Vzbid0
IG1hdGNoIHRoZSBkcml2ZXIgbmFtZSB3aGljaCBpcyBvbmx5ICJhc3BlZWRfcHdtIi4gQ2FuIHlv
dQ0KICAgID4gcGxlYXNlIHVzZSBtYXRjaGluZyBuYW1lcyBhbmQgcGljayB0aGUgZnVuY3Rpb24g
cHJlZml4IGFjY29yZGluZ2x5PyBXaGF0DQogICAgPiBpcyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVu
IGc2IGFuZCBhc3QyNjAwPw0KDQpUaGV5IGFyZSB0aGUgc2FtZS4gSSB3aWxsIHVzZSBhc3QyNjAw
IHRvIHJlcGxhY2UgZzYuDQoNCiAgICA+PiArICogVGhlIHNvZnR3YXJlIGRyaXZlciBmaXhlcyB0
aGUgcGVyaW9kIHRvIDI1NSwgd2hpY2ggY2F1c2VzIHRoZSBoaWdoLWZyZXF1ZW5jeQ0KICAgID4+
ICsgKiBwcmVjaXNpb24gb2YgdGhlIFBXTSB0byBiZSBjb2Fyc2UsIGluIGV4Y2hhbmdlIGZvciB0
aGUgZmluZW5lc3Mgb2YgdGhlIGR1dHkgY3ljbGUuDQogICAgPj4gKyAqDQogICAgPj4gKyAqIFJl
Z2lzdGVyIHVzYWdlOg0KICAgID4+ICsgKiBQSU5fRU5BQkxFOiBXaGVuIGl0IGlzIHVuc2V0IHRo
ZSBwd20gY29udHJvbGxlciB3aWxsIGFsd2F5cyBvdXRwdXQgbG93IHRvIHRoZSBleHRlcm4uDQog
ICAgPj4gKyAqIFVzZSB0byBkZXRlcm1pbmUgd2hldGhlciB0aGUgUFdNIGNoYW5uZWwgaXMgZW5h
YmxlZCBvciBkaXNhYmxlZA0KICAgID4+ICsgKiBDTEtfRU5BQkxFOiBXaGVuIGl0IGlzIHVuc2V0
IHRoZSBwd20gY29udHJvbGxlciB3aWxsIHJlc2V0IHRoZSBkdXR5IGNvdW50ZXIgdG8gMCBhbmQN
CiAgICA+PiArICogb3V0cHV0IGxvdyB0byB0aGUgUElOX0VOQUJMRSBtdXggYWZ0ZXIgdGhhdCB0
aGUgZHJpdmVyIGNhbiBzdGlsbCBjaGFuZ2UgdGhlIHB3bSBwZXJpb2QNCiAgICA+PiArICogYW5k
IGR1dHkgYW5kIHRoZSB2YWx1ZSB3aWxsIGFwcGx5IHdoZW4gQ0xLX0VOQUJMRSBiZSBzZXQgYWdh
aW4uDQogICAgPj4gKyAqIFVzZSB0byBkZXRlcm1pbiB3aGV0aGVyIGR1dHlfY3ljbGUgYmlnZ2Vy
IHRoYW4gMC4NCg0KICAgID4gcy9kZXRlcm1pbi9kZXRlcm1pbmUvDQoNCiAgICA+IFVuc2V0dGlu
ZyBDTEtfRU5BQkxFIGhhcyBhbiBpbW1lZGlhdGUgZWZmZWN0LCByaWdodD8gDQoNClllcy4NCg0K
ICAgID4+ICsgKiBQV01fQVNQRUVEX0NUUkxfSU5WRVJTRTogV2hlbiBpdCBpcyB0b2dnbGVkIHRo
ZSBvdXRwdXQgdmFsdWUgd2lsbCBpbnZlcnNlIGltbWVkaWF0ZWx5Lg0KICAgID4+ICsgKiBQV01f
QVNQRUVEX0RVVFlfQ1lDTEVfRkFMTElOR19QT0lOVC9QV01fQVNQRUVEX0RVVFlfQ1lDTEVfUklT
SU5HX1BPSU5UOiBXaGVuIHRoZXNlIHR3bw0KICAgID4+ICsgKiB2YWx1ZXMgYXJlIGVxdWFsIGl0
IG1lYW5zIHRoZSBkdXR5IGN5Y2xlID0gMTAwJS4NCg0KICAgID4gSnVzdCBmb3IgbXkgdW5kZXJz
dGFuZGluZzogVGhlc2UgYWxsb3cgdG8gaW1wbGVtZW50IGEgcGhhc2Ugb2Zmc2V0IGFuZA0KICAg
ID4gc28gdG8gaW1wbGVtZW50IGludmVyc2UgcG9sYXJpdHkgeW91IGNhbiBlaXRoZXIgdXNlDQog
ICAgPiBQV01fQVNQRUVEX0NUUkxfSU5WRVJTRSBvciBzZXQgdGhlc2UgdmFsdWVzIGFjY29yZGlu
Z2x5LCByaWdodD8NCg0KWWVzLg0KDQogICAgPj4gKyNpbmNsdWRlIDxsaW51eC9pby5oPg0KICAg
ID4+ICsjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQogICAgPj4gKyNpbmNsdWRlIDxsaW51eC9t
ZmQvc3lzY29uLmg+DQogICAgPj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiAgICA+PiAr
I2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+DQogICAgPj4gKyNpbmNsdWRlIDxsaW51eC9v
Zl9kZXZpY2UuaD4NCiAgICA+PiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0K
ICAgID4+ICsjaW5jbHVkZSA8bGludXgvc3lzZnMuaD4NCiAgICA+PiArI2luY2x1ZGUgPGxpbnV4
L3Jlc2V0Lmg+DQogICAgPj4gKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCiAgICA+PiArI2lu
Y2x1ZGUgPGxpbnV4L2JpdGZpZWxkLmg+DQogICAgPj4gKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+
DQogICAgPj4gKyNpbmNsdWRlIDxsaW51eC9wd20uaD4NCiAgICA+PiArI2luY2x1ZGUgPGxpbnV4
L21hdGg2NC5oPg0KICAgID4+ICsNCiAgICA+PiArLyogVGhlIGNoYW5uZWwgbnVtYmVyIG9mIEFz
cGVlZCBwd20gY29udHJvbGxlciAqLw0KDQogICAgPiBJcyB0aGVyZSBhbiBvZmZpY2lhbGx5IGNv
cnJlY3Qgc3BlbGxpbmcgb2YgIkFzcGVlZCIgdGhhdCB5b3VyIG1hcmtldGluZw0KICAgID4gc2Vj
dGlvbiB3b3VsZCBiZSBoYXBweSBpZiBpdCB3ZXJlIHRvIGJlIHVzZWQgY29uc2lzdGVudGx5PyBX
ZSBoYXZlDQogICAgPiAiQXNwZWVkIiBhbmQgIkFTUEVFRCIgaW4gdGhpcyBwYXRjaCBzZXQuDQoN
Ckkgd2lsbCB1c2UgIkFzcGVlZCIuDQoNCiAgICA+PiArc3RhdGljIGludCBhc3BlZWRfcHdtX2Fw
cGx5KHN0cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwNCiAgICA+
PiArCQkJICAgIGNvbnN0IHN0cnVjdCBwd21fc3RhdGUgKnN0YXRlKQ0KICAgID4+ICt7DQogICAg
Pj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBjaGlwLT5kZXY7DQogICAgPj4gKwlzdHJ1Y3QgYXNw
ZWVkX3B3bV9kYXRhICpwcml2ID0gYXNwZWVkX3B3bV9jaGlwX3RvX2RhdGEoY2hpcCk7DQogICAg
Pj4gKwl1MzIgaW5kZXggPSBwd20tPmh3cHdtLCBkdXR5X3B0Ow0KICAgID4+ICsJdW5zaWduZWQg
bG9uZyByYXRlOw0KICAgID4+ICsJdTY0IGFwcGx5X3BlcmlvZCwgZGl2X2gsIGRpdl9sLCBkaXZp
c29yOw0KICAgID4+ICsNCiAgICA+PiArCWRldl9kYmcoZGV2LCAiZXhwZWN0IHBlcmlvZDogJWxs
ZG5zLCBkdXR5X2N5Y2xlOiAlbGxkbnMiLCBzdGF0ZS0+cGVyaW9kLA0KICAgID4+ICsJCXN0YXRl
LT5kdXR5X2N5Y2xlKTsNCiAgICA+PiArDQogICAgPj4gKwlyYXRlID0gY2xrX2dldF9yYXRlKHBy
aXYtPmNsayk7DQogICAgPj4gKwkvKg0KICAgID4+ICsJICogUGljayB0aGUgc21hbGxlc3QgdmFs
dWUgZm9yIGRpdl9oIHNvIHRoYXQgZGl2X2wgY2FuIGJlIHRoZSBiaWdnZXN0DQogICAgPj4gKwkg
KiB3aGljaCByZXN1bHRzIGluIGEgZmluZXIgcmVzb2x1dGlvbiBuZWFyIHRoZSB0YXJnZXQgcGVy
aW9kIHZhbHVlLg0KICAgID4+ICsJICovDQogICAgPj4gKwlkaXZpc29yID0gKHU2NClOU0VDX1BF
Ul9TRUMgKiAoUFdNX0FTUEVFRF9GSVhFRF9QRVJJT0QgKyAxKSAqDQogICAgPj4gKwkJICAoRklF
TERfTUFYKFBXTV9BU1BFRURfQ1RSTF9DTEtfRElWX0wpICsgMSk7DQogICAgPj4gKwlkaXZfaCA9
IG9yZGVyX2Jhc2VfMihESVY2NF9VNjRfUk9VTkRfVVAocmF0ZSAqIHN0YXRlLT5wZXJpb2QsIGRp
dmlzb3IpKTsNCiAgICA+PiArCWlmIChkaXZfaCA+IDB4ZikNCiAgICA+PiArCQlkaXZfaCA9IDB4
ZjsNCiAgICA+PiArDQogICAgPj4gKwlkaXZpc29yID0gKCh1NjQpTlNFQ19QRVJfU0VDICogKFBX
TV9BU1BFRURfRklYRURfUEVSSU9EICsgMSkpIDw8IGRpdl9oOw0KICAgID4+ICsJZGl2X2wgPSBk
aXY2NF91NjQocmF0ZSAqIHN0YXRlLT5wZXJpb2QsIGRpdmlzb3IpOw0KICAgID4+ICsNCiAgICA+
PiArCWlmIChkaXZfbCA9PSAwKQ0KICAgID4+ICsJCXJldHVybiAtRVJBTkdFOw0KICAgID4+ICsN
CiAgICA+PiArCWRpdl9sIC09IDE7DQogICAgPj4gKw0KICAgID4+ICsJaWYgKGRpdl9sID4gMjU1
KQ0KICAgID4+ICsJCWRpdl9sID0gMjU1Ow0KICAgID4+ICsNCiAgICA+PiArCWRldl9kYmcoZGV2
LCAiY2xrIHNvdXJjZTogJWxkIGRpdl9oICVsbGQsIGRpdl9sIDogJWxsZFxuIiwgcmF0ZSwgZGl2
X2gsDQogICAgPj4gKwkJZGl2X2wpOw0KICAgID4+ICsNCiAgICA+PiArCWFwcGx5X3BlcmlvZCA9
IERJVl9ST1VORF9VUF9VTEwoKHU2NClOU0VDX1BFUl9TRUMgKiBfQklUVUxMKGRpdl9oKSAqDQog
ICAgPj4gKwkJCQkJCShkaXZfbCArIDEpICoNCiAgICA+PiArCQkJCQkJKFBXTV9BU1BFRURfRklY
RURfUEVSSU9EICsgMSksDQogICAgPj4gKwkJCQkJcmF0ZSk7DQogICAgPj4gKwlkdXR5X3B0ID0g
RElWX1JPVU5EX0RPV05fVUxMKHN0YXRlLT5kdXR5X2N5Y2xlICoNCiAgICA+PiArCQkJCQkgICAg
IChQV01fQVNQRUVEX0ZJWEVEX1BFUklPRCArIDEpLA0KICAgID4+ICsJCQkJICAgICBhcHBseV9w
ZXJpb2QpOw0KDQogICAgPiBEb24ndCBkaXZpZGUgYnkgdGhlIHJlc3VsdCBvZiBhIGRpdmlzaW9u
LiBTbyBiZXR0ZXIgdXNlOg0KDQogICAgPglzdGF0ZS0+ZHV0eV9jeWNsZSAqIHJhdGUNCiAgICA+
CS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAgICA+CU5TRUNfUEVS
X1NFQyAqIEJJVFVMTChkaXZfaCkgKiBkaXZfbCArIDENCg0KICAgID4gKElzIGl0IGNvcnJlY3Qg
dGhhdCBQV01fQVNQRUVEX0ZJWEVEX1BFUklPRCBkb2Vzbid0IGFwcGVhciBoZXJlPykNCg0KWWVz
LCBpdCBpcyBjb3JyZWN0Lg0KDQo=
