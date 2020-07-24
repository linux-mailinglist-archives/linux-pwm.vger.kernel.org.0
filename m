Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD3522BBC0
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Jul 2020 03:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgGXBym (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Jul 2020 21:54:42 -0400
Received: from mail-eopbgr40065.outbound.protection.outlook.com ([40.107.4.65]:28969
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726430AbgGXByl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 23 Jul 2020 21:54:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=li8ogG984eAKJtk4sRPRFmA3Khs6zcZwnzs2CZDio0Qnm9tvFfC84+rAv2h5/OtEVBBu/rbp8Rq0xAleHp/atNT7WWh99isa/elRJmCytZ0DoGvIZiaaoD7vexFtLETHwhdlua3KWc3r3vib8Ir6Niy89I6Ppszyn0RSKNDVcsRQnFyUVGYLUik/+oad/BafY+aUFJ3LdoOxsIITHWfoUw6hZaYwFhD4a9HBC+aCQ60KXXiJW9tT7KqWbSC7vdn4lKhCvwjDwShzssBvhMdVRk0EVy3WOC7Tto2iW2ZKPqwUDmiE1djIR6YbO03ynKAeqoFGeoWVw0UlhBu1a6u+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpLeVko46GnDtds/9NoCtI65fVhLpJ5jDhtKrfgiRWE=;
 b=L+aOUoDWC6rdRX4YsMLFWuSPT3N2I97bDtP165z0QaMAvNXEP7mnYXNbAgW+SdS84NE8ffjoXfmQvY2gRsiRWWyUK78L9Y+HupZamjBReMByfQM5eKxEG4menkUDAQzdXsfgRVuExJaKBZ/AiIsW8vsi23SFYz6TuAuouR1wld54VyOumv6Zzh8LcN+kfI2XhZ1BHmzXQf24TJlVBULFBuXbMivt53KdtprVM1lyqMWhi7gyI0ea97G9Yoyhes/hzrrJNSM/QIJw1c/OnG+23v1xffhdQtY/OL6aE97VwhRynN9En51WH44kHADJSQRsmHmVkrQP5Imzpv5tgDIL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpLeVko46GnDtds/9NoCtI65fVhLpJ5jDhtKrfgiRWE=;
 b=GqECJY9/XR0jKdnvvUf2WurXPCp/klVFj+OxJvO2hpqns2aTfRQgpJi4gsLZU/tHy8KlbUoLob+BK+4aKjGc1Mwj3vu0l3r7LENmsNWWQpgTWjs8AZpKnLR1uj5cKHormdab8HJ8LGlDjU0U/kERj33TdXoTPJGEp2qfflmKR7o=
Received: from DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e9::10)
 by DB8PR10MB3420.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:ef::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Fri, 24 Jul
 2020 01:54:35 +0000
Received: from DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9913:d1be:cd0f:a620]) by DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9913:d1be:cd0f:a620%6]) with mapi id 15.20.3216.023; Fri, 24 Jul 2020
 01:54:35 +0000
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
Subject: RE: [PATCH V17 3/3] Input: new da7280 haptic driver
Thread-Topic: [PATCH V17 3/3] Input: new da7280 haptic driver
Thread-Index: AQHWYRWk1fE308LH4Uerj7poX/VTYqkVo6qAgAA/hGA=
Date:   Fri, 24 Jul 2020 01:54:35 +0000
Message-ID: <DB8PR10MB343644A6DADE61D62BEE157C85770@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1595516501.git.Roy.Im@diasemi.com>
 <c13d812871b7f09205c1f04e95f5bdf07f307eaf.1595516501.git.Roy.Im@diasemi.com>
 <71818ab8-0020-77db-c412-8d35a541ead3@infradead.org>
In-Reply-To: <71818ab8-0020-77db-c412-8d35a541ead3@infradead.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.240.7.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70b9f8f3-4906-4700-45a0-08d82f748425
x-ms-traffictypediagnostic: DB8PR10MB3420:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB3420C65773A3E36B52EDB07BA2770@DB8PR10MB3420.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oYCSSynjv3zv9G75+U3lFEQXELf6d/1UWIVMFXquPcwcAXIMNY3u4h1Wo8FxCCZebctd6ZIncvAHnrtQON6hRkdCRXw+k20OOh3TdkqxeyrCMJpdHHXb1iE0SKDddqC6n1wj7vxNAAkmJ+Ra8u76tHT/esNpXhMhsIRB+c04jEQ6ZrtzPqgFJ8BR/mxGFJpx/Ju4bPFK1DwpOIVejxU8W74gcMNP2N16UokjNPptaE8wRWah4EGLAMcYgQKu/Uyzc8qHY+Sz9+hPZXDa6/svMprAq7X+AJqE7C+WGeTH4QQsfthb10uzgr5DazzoeAzGx+zxilgKx0oAFSU4c8qV0dEUC6eK5iHjiWN0pkcn0TvPT2okZxkv/GNOVbv6NEDR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(52536014)(186003)(26005)(54906003)(478600001)(53546011)(7696005)(110136005)(83380400001)(8676002)(6506007)(8936002)(4326008)(76116006)(66476007)(66946007)(66556008)(64756008)(66446008)(71200400001)(5660300002)(7416002)(316002)(9686003)(55016002)(86362001)(2906002)(33656002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vHH9+KzGaPmZT84eL1QKWaHmxGQ0JnSs1VD0SOXdMBb/kNpJD25b5LkWZFUc5hZfd1F/u0Pt+C3fuhx3n36XGOZOYzEl1IJfxXZQ51RWxoPQEkuUwE/SlRwxQMBhLyy6HCGNN8yFhDiTBWAX/84e3X02H2s4XgTnuh2tcsFTo6TmEGxN8uqRQuFK+CyQYN12TQSpyObMUcn/4DHmL+/4G7Thuh8/oVhrfYKWzIAOo8DvA4yXMrcli78I7khyGm0ANa4lCIAsFyMR2LmHSC/l5yNngD0EkGmQ9sstqaiMMX2waR5i1cjGFEqMBppDWKbM8glJWjTjpqufS/68YrGTPiio9DBp+sGzMLYFxr1ItqRTtp/X+YM/nN7AlCEEq/ApZbGsLJOIep6YS0XUTZGRMvIt7yaa3cd4TymtXEyKP8F3bAowI9RF2Q91XOLI5X4KeGEGNj93U9fq/jnvS6adTJ0mrJWKHHrexW9BZVP2b3Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b9f8f3-4906-4700-45a0-08d82f748425
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 01:54:35.0753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXfG6T8PLEmy/LhK87YO4Ugenx9Na/acwSvEBnmpW3lOdp27DOCPlxzq3Gjf3QQGqJAioA5d7kxJSgE8nJFcRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3420
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gRnJpLCBKdWx5IDI0LCAyMDIwIDU6NTEgQU0sIFJhbmR5IER1bmxhcCB3cm90ZQ0KPiBPbiA3
LzIzLzIwIDg6MDEgQU0sIFJveSBJbSB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
bnB1dC9taXNjL0tjb25maWcgYi9kcml2ZXJzL2lucHV0L21pc2MvS2NvbmZpZw0KPiA+IGluZGV4
IDM2MmU4YTAuLjA2ZGM1YTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pbnB1dC9taXNjL0tj
b25maWcNCj4gPiArKysgYi9kcml2ZXJzL2lucHV0L21pc2MvS2NvbmZpZw0KPiA+IEBAIC04Njks
NCArODY5LDE3IEBAIGNvbmZpZyBJTlBVVF9TVFBNSUMxX09OS0VZDQo+ID4gIAkgIFRvIGNvbXBp
bGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRoZQ0KPiA+ICAJICBt
b2R1bGUgd2lsbCBiZSBjYWxsZWQgc3RwbWljMV9vbmtleS4NCj4gPg0KPiA+ICtjb25maWcgSU5Q
VVRfREE3MjgwX0hBUFRJQ1MNCj4gPiArCXRyaXN0YXRlICJEaWFsb2cgU2VtaWNvbmR1Y3RvciBE
QTcyODAgaGFwdGljcyBzdXBwb3J0Ig0KPiA+ICsJZGVwZW5kcyBvbiBJTlBVVCAmJiBJMkMNCj4g
PiArCXNlbGVjdCBJTlBVVF9GRl9NRU1MRVNTDQo+ID4gKwlzZWxlY3QgUkVHTUFQX0kyQw0KPiA+
ICsJaGVscA0KPiA+ICsJICBTYXkgWSB0byBlbmFibGUgc3VwcG9ydCBmb3IgdGhlIERpYWxvZyBE
QTcyODAgaGFwdGljcyBkcml2ZXIuDQo+ID4gKwkgIFRoZSBoYXB0aWNzIGNhbiBiZSBjb250cm9s
bGVkIGJ5IEkyQyBjb21tdW5pY2F0aW9uLA0KPiA+ICsJICBvciBieSBQV00gaW5wdXQsIG9yIGJ5
IEdQSS4NCj4gDQo+IAkgIElzIHRoYXQgICAgICAgICAgICAgICAgR1BJTy4NCj4gPw0KVGhlIEhh
cHRpY3MgY2FuIGJlIHdvcmtpbmcgYnkgR1BJKGlmIHNlZSBmcm9tIHRoZSBoYXB0aWMgZGV2aWNl
KSwgYnV0IGZyb20gdGhlIEhvc3QgaXQgaXMgR1BPLiBEbyB5b3UgdGhpbmsgdGhlIEdQSU8gaXMg
Y29ycmVjdD8NCg0KPiANCj4gQ2FuIHRoZSBoYXB0aWNzIGJlIGNvbnRyb2xsZWQgb25seSBieSBQ
V00gb3Igb25seSBieSBHUEkoTyk/DQo+IA0KPiBKdXN0IGN1cmlvdXM6IHdoeSBpcyBJMkMgcmVx
dWlyZWQgdG8gYnVpbGQgdGhlIGRyaXZlciBpZiBhIHVzZXIgaXMgb25seSBjb250cm9sbGluZyB0
aGUgZGV2aWNlIGJ5IFBXTSBvciBHUEk/DQoNCkkyQyBpcyByZXF1aXJlZCB0byBjb250cm9sIHJl
Z2lzdGVycyBhbmQgaXQgY2FuIGJlIHRyaWdnZXJlZCBieSBJMkMgb3IgUFdNIG9yIEdQSShjb250
cm9sbGVkIGJ5IGhvc3Qgb3V0c2lkZSB0aGlzIGRyaXZlciksIHNvIFBXTSBhbmQgR1BJIGFyZSBv
cHRpb25hbC4NCldpdGggeW91ciBjb21tZW50cywgSSB0aGluayBpdCdzIGJldHRlciB0byByZW1v
dmUgYmVsb3cgbGluZXMoLy9yZW1vdmUpIHRvIGF2b2lkIGNvbmZ1c2lvbiBhbmQgYWRkIFBXTSBh
cyBiZWxvdyBpZiB5b3UgYWdyZWUuDQogICAgICAgICAvLyByZW1vdmUNCgkgIFRoZSBoYXB0aWNz
IGNhbiBiZSBjb250cm9sbGVkIGJ5IEkyQyBjb21tdW5pY2F0aW9uLA0KCSAgb3IgYnkgUFdNIGlu
cHV0LCBvciBieSBHUEkuDQogICAgICAgICAvLyB1cGRhdGUsIGFkZGluZyB8fCBQV00NCiAgICAg
ICAgIGRlcGVuZHMgb24gKElOUFVUICYmIEkyQykgfHwgUFdNDQo+IA0KPiANCj4gPiArDQo+ID4g
KwkgIFRvIGNvbXBpbGUgdGhpcyBkcml2ZXIgYXMgYSBtb2R1bGUsIGNob29zZSBNIGhlcmU6IHRo
ZQ0KPiA+ICsJICBtb2R1bGUgd2lsbCBiZSBjYWxsZWQgZGE3MjgwLg0KPiA+ICsNCj4gPiAgZW5k
aWYNCj4gDQo+IHRoYW5rcy4NCj4gLS0NCj4gflJhbmR5DQoNCktpbmQgcmVnYXJkcywNClJveQ0K
