Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E721A20EC1B
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 05:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgF3Djb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jun 2020 23:39:31 -0400
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:20470
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728930AbgF3Dja (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 29 Jun 2020 23:39:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOmkqpRWR8+PelCSa0oWlBmbYaVycpssOvLtRic9BCPr3fSIMWUz9Py5KxFkIfLrcHsryPBavwzNLpggV4QtxYuTZjFX2lTuoH6Pw+hqe0H8k7abLP1ChrXZYxPL9HW2p/9Vs2wA3kU3/SWJoVOidHc6t4UfrMazn85V02GpqqMckDCi+KTE7d6h3S0GqGJ7YyWN9nRn3T9WlUbLtN8ER187MO/FBN+405PD2r9RRzs7U+8JQZmzp5Iqyl0eENuNRS8yR/WY+I/hcEnb1yPUnajkpc6ucVHX6gtr49f2Wfwc4nReMoVH+HfOCu2nFpmW+EHzLQ7NbymCIRR6Imc7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFbVeDpkEZiB3GHfBb4dAjahX614EmMhhkTdbG+Kzrc=;
 b=lIL01JJ+gfu/Od0gWs8iRl2IarckzqeZPe4hzkosiQMcBmJi4E+/vjNVjxO++CDyWP/IC1VWGwf+3BXYdyOYOryQcCmTpRi04dHiUHkVso4SI593vrSXuXJ3xMMaVRmO4escMENFEz06+vlZiFbZaEw+puQfFTavnGKOhn5qL9vKxkT4g78jBfQkxiHa/O8Uh4ZiYiuro00ySZ3tgKe3mbZOeN6NYsACOsQkDovQYDuKdxnava8AhF+SOy2mzk81LHKmDfWWhl5BrrB4q2+pWD+t7Iitetgql4EzJIyNn2d3UOKxBJpKOm1hUTQkT7iVZ56KQt7vLJRZC3FiRnaENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFbVeDpkEZiB3GHfBb4dAjahX614EmMhhkTdbG+Kzrc=;
 b=v4n/cqEbSovOLsXU6IUWo7VCCaW3VNDYCmjjZ/F6Fe8gXcPAQxWcCIx1WZ6tIALqc7FzyskezfAhGIFMbwXB01Wj6xDbHMVrT+Il5WZuM+qlQ/CcyXQivH5RHCH2T6uyr0r6HipA2+sNbZfuPeJGWan0rpk1lWQ4MY23CcmL97k=
Received: from DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11c::13)
 by DB8PR10MB3893.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Tue, 30 Jun
 2020 03:39:26 +0000
Received: from DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::843a:1bdd:adc4:3a56]) by DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::843a:1bdd:adc4:3a56%8]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 03:39:26 +0000
From:   Roy Im <roy.im.opensource@diasemi.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Roy Im <roy.im.opensource@diasemi.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [PATCH v15 3/3] Input: new da7280 haptic driver
Thread-Topic: [PATCH v15 3/3] Input: new da7280 haptic driver
Thread-Index: AQHWToqxLBZ+X/qhXECVbuzW09LfNajwe9sAgAAEvXA=
Date:   Tue, 30 Jun 2020 03:39:26 +0000
Message-ID: <DB8PR10MB3356EF71023E587911611C0C856F0@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1593435662.git.Roy.Im@diasemi.com>
 <c7b8cb993abe7bb771108bb94e5d9edbeb4f7103.1593435662.git.Roy.Im@diasemi.com>
 <602a5743-d27b-3e81-e917-d343f58d35e9@infradead.org>
In-Reply-To: <602a5743-d27b-3e81-e917-d343f58d35e9@infradead.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.234.57.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ef6509e-211f-475d-f05b-08d81ca73006
x-ms-traffictypediagnostic: DB8PR10MB3893:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB3893910BB13C8335E2926F81A26F0@DB8PR10MB3893.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AAX3NsRKAJizRAr5MH3tc6gogKsR8K3fkCKUAzYCBSVtyVStVUS7+M9dJU5SWanJ9RwWYQXpzgtxlo42A5T6KlrNrFvDL/ip6+z5yIkedOSFrE52myS6arXPNpr1c1oT4fQ7KLIAWumexP6WKNe0uYKlJZJEXEkVIv2YJI8YkeEFRnW1SAE7mgejmcsOUm4Kv8kli6SEk1dmkbAxCmXfMF8o+PV1ZiLdioZKu1+hqQ1VPFPonoc4qr3QeCs1Zg2AYe0kACpkk3wCiPEGgAgr0PSv08SgeTp6+Aay9wjCv3wgTAQ9aLNKFtC+v71/uAM3G1GxhHP9MeodtoaZvUqYo7CBHHKg5PMMpT6JxFlA/r39llbWqfYYHmjIfoGGYSHg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(316002)(4326008)(66446008)(64756008)(8936002)(66476007)(66556008)(52536014)(110136005)(54906003)(66946007)(7416002)(33656002)(2906002)(86362001)(9686003)(55016002)(8676002)(76116006)(26005)(53546011)(83380400001)(6506007)(186003)(71200400001)(5660300002)(7696005)(478600001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: iGgOYRebembPSwgkzBCd0nBVx03zBeEBi5rmNf49AzDUwJTdAB7HGpFPu6L1ScLQoJ0xijD9VZtm+MyUKxndCn3fQNV7+J/eRh1Ri/uQq74RrOI7br1WvKAQ02V2fVmqIL4VEmz+zVEUaqlVrB7IQ83YwEplIxm3sNLyswVpP1/vT0ChcUb60Y9QTkK1V/8sqEz21kLUj6hyNAUXfCyhFDzihJjwoEHzeJMlWhEFqlgYgS4aGM6AvuDedz+aCnZLol7xh3u8qeBQtBBYPGVcJhaUhzUSVWx4S70maxzjciP4UbAcfD3NfAJYu/Xp+/ULBKeG2Mep4GmS1S21Blmf+iSQeY0UVUN5xiSdaArkLDDephj0uXM0JLJH3uLpo14bkKp0FizQmiBbRacyj4R12ar8HFhKJA9ddrVfTfQW6/M65VCO5MEqbhIVYoM+D8B2dfStp1cv6Y6cj1GYd9drRVOselMhOwTOjsHP/qEt5zo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef6509e-211f-475d-f05b-08d81ca73006
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 03:39:26.2916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4U+cIpuXHWrcW1OHATu83S50bdp/xbiiTn7bXYcfBreZMT0j9R8v6vgDycgSNxZg2xyiCf9rlyrinAYH58EcSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3893
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gVHVlLCBKdW5lIDMwLCAyMDIwIDEyOjE0IFBNLCBSYW5keSBEdW5sYXAgd3JvdGU6IA0KPiBP
biA2LzI5LzIwIDY6MDEgQU0sIFJveSBJbSB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pbnB1dC9taXNjL0tjb25maWcgYi9kcml2ZXJzL2lucHV0L21pc2MvS2NvbmZpZw0KPiA+IGlu
ZGV4IDM2MmU4YTAuLjc5ZmJkZGIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pbnB1dC9taXNj
L0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL2lucHV0L21pc2MvS2NvbmZpZw0KPiA+IEBAIC04
NjksNCArODY5LDE3IEBAIGNvbmZpZyBJTlBVVF9TVFBNSUMxX09OS0VZDQo+ID4gIAkgIFRvIGNv
bXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZQ0KPiA+ICAJ
ICBtb2R1bGUgd2lsbCBiZSBjYWxsZWQgc3RwbWljMV9vbmtleS4NCj4gPg0KPiA+ICtjb25maWcg
SU5QVVRfREE3MjgwX0hBUFRJQ1MNCj4gPiArCXRyaXN0YXRlICJEaWFsb2cgU2VtaWNvbmR1Y3Rv
ciBEQTcyODAgaGFwdGljcyBzdXBwb3J0Ig0KPiA+ICsJZGVwZW5kcyBvbiBJTlBVVCAmJiBJMkMN
Cj4gPiArCXNlbGVjdCBJTlBVVF9GRl9NRU1MRVNTDQo+ID4gKwlzZWxlY3QgUkVHTUFQX0kyQw0K
PiA+ICsJaGVscA0KPiA+ICsJICBTYXkgWSB0byBlbmFibGUgc3VwcG9ydCBmb3IgdGhlIERpYWxv
ZyBEQTcyODAgaGFwdGljcyBkcml2ZXIuDQo+ID4gKwkgIFRoZSBoYXB0aWNzIGNhbiBiZSBjb250
cm9sbGVkIGJ5IGkyYyBjb21tdW5pY2F0aW9uLA0KPiANCj4gSWYgeW91IG1ha2UgYW55IG1vcmUg
dXBkYXRlcywgbWFrZSB0aGlzOiAgIEkyQyBjb21tdW5pY2F0aW9uLA0KPiBwbGVhc2UuDQoNCk9L
LCBJIHdpbGwgZG8uIFRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQo+IA0KPiA+ICsJICBvciBi
eSBQV00gaW5wdXQsIG9yIGJ5IEdQSS4NCj4gPiArDQo+ID4gKwkgIFRvIGNvbXBpbGUgdGhpcyBk
cml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZQ0KPiA+ICsJICBtb2R1bGUgd2ls
bCBiZSBjYWxsZWQgZGE3MjgwLg0KPiA+ICsNCj4gPiAgZW5kaWYNCj4gDQo+IHRoYW5rcy4NCj4g
LS0NCj4gflJhbmR5DQoNCg==
