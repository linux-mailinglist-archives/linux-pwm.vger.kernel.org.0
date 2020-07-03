Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D19921347E
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 08:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgGCGuy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 02:50:54 -0400
Received: from mail-vi1eur05on2045.outbound.protection.outlook.com ([40.107.21.45]:16416
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbgGCGuy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 3 Jul 2020 02:50:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwBCkDDZk5rjrIvXMdZqqR7O7n4ixtWgJd4AEvi6KY0k/Gbhgl+sfB/tk9klVcNoXlVF/DMk2TZnuanA0Yv7Q4st393BWb3oSDnTlY4InxSLTafNA3iQ4y/ZIL6JE1eQmvhiIqGyGUKZxZOyhkrvAzpYPxiRlXojiwZWKsWRFpTdJV/dYpRcx5gXBAAsu+2YDSmbOkGDNy4BOk0UmhMwtiZml5j9/0Qu2yd/RA6b+pBsg3OwrG/nBtSm7WDqdgfBg2ckxPQ06yYM82+LBH7d8UfxnRFns5araVp1RDT3n8NuJBkgxkIx5SO++B7YFJe9RShGfKw1HIW/EWwOpA61Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GtZOpI739HV15zfTD1RRJmSvG51rRmsfp1jIMmtExs=;
 b=JKPoH4OdPBPfCVlfQn2KuTDCFS9yjppX0hnBD8aXJZ19lSO/4RshGGwb1R2YuWLYLSqEDJdCnfiQieOoBgr/ilDJBx6GkEuVEoF4h7U+wcn/MMd8bYFk5WnjGUN1JCfyDBMUpN/fzHpkI77IHl3nWjcEN4EKdWPTJ1O/oRspaQOw2fDMYDMRfgTEmxaBaw8kWMlNRltHlMxP0OmkFSkD9yPGQjy06LkK8VR4p+EO13PiDCkBqNBbo0rJuHdZEBJ86vmlPt0+eh7eqavW2+lQdbUERnIDmgEzfWgUeaFOzTbmYhCTI2IU4VphcylBGnG1yTh0oYHhxfxd2Gln58axvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GtZOpI739HV15zfTD1RRJmSvG51rRmsfp1jIMmtExs=;
 b=TEQTOrhVEFODI36FY7RXMsEZdO/M1V1veaaa15nsLtcXCTwGnjmvY/uZrqagm2yXI0iIVYuJ5twH4RfVtDUPqyyDjGtQVAgUNBGbAF8Z3CwgWqXjCdnWtLivL1kYRYMH1jae9BwidwiPNZSpHHJgivOxiwHHucID+nRVQ3q1TWc=
Received: from DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11c::13)
 by DB6PR10MB1736.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:39::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Fri, 3 Jul
 2020 06:50:47 +0000
Received: from DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::843a:1bdd:adc4:3a56]) by DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::843a:1bdd:adc4:3a56%8]) with mapi id 15.20.3153.020; Fri, 3 Jul 2020
 06:50:47 +0000
From:   Roy Im <roy.im.opensource@diasemi.com>
To:     Jes Sorensen <jes.sorensen@gmail.com>,
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
Thread-Index: AQHWToqxLBZ+X/qhXECVbuzW09LfNaj0mKiAgADVbMA=
Date:   Fri, 3 Jul 2020 06:50:47 +0000
Message-ID: <DB8PR10MB3356C443A448F5B543C58BAC856A0@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1593435662.git.Roy.Im@diasemi.com>
 <c7b8cb993abe7bb771108bb94e5d9edbeb4f7103.1593435662.git.Roy.Im@diasemi.com>
 <31377d96-3e6d-e7b6-30de-0c7e9e6f9364@gmail.com>
In-Reply-To: <31377d96-3e6d-e7b6-30de-0c7e9e6f9364@gmail.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.234.57.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21a69ba6-9772-4b4c-5f9b-08d81f1d6aca
x-ms-traffictypediagnostic: DB6PR10MB1736:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR10MB1736098AA8C8A634480BB015A26A0@DB6PR10MB1736.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UUJVnmN0b+/lOhJwos7+Q7hPPg1GV0DSAGnvRtAvPYr5NeLMZdCOL9CWkTbYdpsVO57M65k2ApPZ8XkFZ/dNa0p27joEhzoYRWuozjiPzLNC41zPEUqI1pIpqrQHQ6nWDA4FqHd99Y59tTYcmQ7B65XMdWeA83P57+Wq8aCfLHsxqeQ6FrE6DSj/QcikovPyuzOmf/rZZjx75QOQ9zcYKu0ZRPG/OSfHTX4CP7FXD2OMZ2DjzglSR6DrzZ/V3PwM7xV356Rd16gE3JF13cgC5P7MOaSwvkw/zLzuXSlUwlmzUANrAMQtCyUFPydjm6zizp9XOL4TpENVxQCQmIXFcRhHIh/0dWn086VlT6U/CDX/+5k7wskAEkn2Xdwe+5FJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(76116006)(4326008)(83380400001)(2906002)(7416002)(110136005)(316002)(33656002)(71200400001)(8676002)(9686003)(55016002)(5660300002)(54906003)(66946007)(26005)(64756008)(86362001)(186003)(66476007)(53546011)(6506007)(8936002)(7696005)(478600001)(66446008)(52536014)(66556008)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VUS7RW+tk/zqv43rdkJrq4R9io6QgoUlutCBTuKm2BxyaGv6GY4l/YMknIlYEp8/wzv7quqCvrzJ7s/R20ZXBKoHgXq8c5bEKz8Vm4jQxTsPQcDh1BAPY4KVC80saGzUi0d46zGKw7Q4WcjcAucuj3so7JEylPye9QPkeSo0ZIHCUH0nrGmcoQrgKXLlsEY39Tt4eIHWb6wFKvVNw0a2Ez6r6k+/BLCYC4vGSkCJGU89Zq96Q/+VvdygyXafF6jRglUr8LqnlvrEFypMtXYwWM4TcgOBCVYu6bGOa7Bd7+k/sQMSkKecluqfbkbPQa3SEHn7JJLhVlE5WGgeyMLKhoKoKWD6rj2iPpC47Fwwav2K9qoo1hYX5mXq7/purslC5VhXeQ7p8SXkdhWjyEi4qa8YtlD4SnCOA6eBupyfR2SiFDLdfNus7AXPCJCkWOuKZfmZIH+GLQYhT9QuvxM6AGSYjzxL5gUaibhWGUaFvwA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a69ba6-9772-4b4c-5f9b-08d81f1d6aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 06:50:47.8030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/Hylx008vhO3h6axhurV1m+yJ1d0WtAF+ztZEiyQ/126eTt9pU+SUeZEvFUPhFGRyyv28lrQ9euGEOCYFoeSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1736
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQpPbiBGcmksIEp1bHkgMywgMjAyMCAzOjAyIEFNLCBKZXMgU29yZW5zZW4gd3JvdGU6DQo+IE9u
IDYvMjkvMjAgOTowMSBBTSwgUm95IEltIHdyb3RlOg0KPiA+IEFkZHMgc3VwcG9ydCBmb3IgdGhl
IERpYWxvZyBEQTcyODAgTFJBL0VSTSBIYXB0aWMgRHJpdmVyIHdpdGggbXVsdGlwbGUNCj4gPiBt
b2RlIGFuZCBpbnRlZ3JhdGVkIHdhdmVmb3JtIG1lbW9yeSBhbmQgd2lkZWJhbmQgc3VwcG9ydC4N
Cj4gPiBJdCBjb21tdW5pY2F0ZXMgdmlhIGFuIEkyQyBidXMgdG8gdGhlIGRldmljZS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFJveSBJbSA8cm95LmltLm9wZW5zb3VyY2VAZGlhc2VtaS5jb20+
DQo+ID4gLS0tDQo+ID4gdjE1Og0KPiA+IAktIFJlbW92ZWQgc29tZSBkZWZpbmVzIGFuZCB1cGRh
dGVkIHNvbWUgY29tbWVudHMuDQo+ID4gdjE0Og0KPiA+IAktIFVwZGF0ZWQgcHdtIHJlbGF0ZWQg
Y29kZSwgYWxpZ25tZW50cyBhbmQgY29tbWVudHMuDQo+ID4gdjEzOg0KPiA+IAktIFVwZGF0ZWQg
c29tZSBjb25kaXRpb25zIGluIHB3bSBmdW5jdGlvbiBhbmQgYWxpZ25tZW50cy4NCj4gPiB2MTI6
IE5vIGNoYW5nZXMuDQo+ID4gdjExOg0KPiA+IAktIFVwZGF0ZWQgdGhlIHB3bSByZWxhdGVkIGNv
ZGUsIGNvbW1lbnRzIGFuZCB0eXBvLg0KPiA+IHYxMDoNCj4gPiAJLSBVcGRhdGVkIHRoZSBwd20g
cmVsYXRlZCBmdW5jdGlvbiBhbmQgYWRkZWQgc29tZSBjb21tZW50cy4NCj4gPiB2OToNCj4gPiAJ
LSBSZW1vdmVkIHRoZSBoZWFkZXIgZmlsZSBhbmQgcHV0IHRoZSBkZWZpbml0aW9ucyBpbnRvIHRo
ZSBjIGZpbGUuDQo+ID4gCS0gVXBkYXRlZCB0aGUgcHdtIGNvZGUgYW5kIGVycm9yIGxvZ3Mgd2l0
aCAlcEUNCj4gPiB2ODoNCj4gPiAJLSBBZGRlZCBjaGFuZ2VzIHRvIHN1cHBvcnQgRkZfUEVSSU9E
SUMvRkZfQ1VTVE9NIGFuZCBGRl9DT05TVEFOVC4NCj4gPiAJLSBVcGRhdGVkIHRoZSBkdC1yZWxh
dGVkIGNvZGUuDQo+ID4gCS0gUmVtb3ZlZCBtZW1sZXNzIHJlbGF0ZWQgZnVuY3Rpb25zLg0KPiA+
IHY3Og0KPiA+IAktIEFkZGVkIG1vcmUgYXR0cmlidXRlcyB0byBoYW5kbGUgb25lIHZhbHVlIHBl
ciBmaWxlLg0KPiA+IAktIFJlcGxhY2VkIGFuZCB1cGRhdGVkIHRoZSBkdC1yZWxhdGVkIGNvZGUg
YW5kIGZ1bmN0aW9ucyBjYWxsZWQuDQo+ID4gCS0gRml4ZWQgZXJyb3IvZnVuY3Rpb25zLg0KPiA+
IHY2OiBObyBjaGFuZ2VzLg0KPiA+IHY1OiBGaXhlZCBlcnJvcnMgaW4gS2NvbmZpZyBmaWxlLg0K
PiA+IHY0OiBVcGRhdGVkIGNvZGUgYXMgZHQtYmluZGluZ3MgYXJlIGNoYW5nZWQuDQo+ID4gdjM6
IE5vIGNoYW5nZXMuDQo+ID4gdjI6IEZpeGVkIGtidWlsZCBlcnJvci93YXJuaW5nDQo+ID4NCj4g
Pg0KPiA+ICBkcml2ZXJzL2lucHV0L21pc2MvS2NvbmZpZyAgfCAgIDEzICsNCj4gPiAgZHJpdmVy
cy9pbnB1dC9taXNjL01ha2VmaWxlIHwgICAgMSArDQo+ID4gIGRyaXZlcnMvaW5wdXQvbWlzYy9k
YTcyODAuYyB8IDE4MzgNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTg1MiBpbnNlcnRpb25zKCspDQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lucHV0L21pc2MvZGE3MjgwLmMNCj4gDQo+IFtzbmlw
XQ0KPiANCj4gPiArc3RhdGljIHNzaXplX3QNCj4gPiArcGF0dGVybnNfc3RvcmUoc3RydWN0IGRl
dmljZSAqZGV2LA0KPiA+ICsJICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLA0K
PiA+ICsJICAgICAgIGNvbnN0IGNoYXIgKmJ1ZiwNCj4gPiArCSAgICAgICBzaXplX3QgY291bnQp
DQo+ID4gK3sNCj4gPiArCXN0cnVjdCBkYTcyODBfaGFwdGljICpoYXB0aWNzID0gZGV2X2dldF9k
cnZkYXRhKGRldik7DQo+ID4gKwljaGFyIGNtZFtNQVhfVVNFUl9JTlBVVF9MRU5dOw0KPiA+ICsJ
c3RydWN0IHBhcnNlX2RhdGFfdCBtZW07DQo+ID4gKwl1bnNpZ25lZCBpbnQgdmFsOw0KPiA+ICsJ
aW50IGVycm9yOw0KPiA+ICsNCj4gPiArCWVycm9yID0gcmVnbWFwX3JlYWQoaGFwdGljcy0+cmVn
bWFwLCBEQTcyODBfTUVNX0NUTDEsICZ2YWwpOw0KPiA+ICsJaWYgKGVycm9yKQ0KPiA+ICsJCXJl
dHVybiBlcnJvcjsNCj4gPiArDQo+ID4gKwlpZiAoY291bnQgPiBNQVhfVVNFUl9JTlBVVF9MRU4p
DQo+ID4gKwkJbWVtY3B5KGNtZCwgYnVmLCBNQVhfVVNFUl9JTlBVVF9MRU4pOw0KPiA+ICsJZWxz
ZQ0KPiA+ICsJCW1lbWNweShjbWQsIGJ1ZiwgY291bnQpOw0KPiA+ICsNCj4gPiArCS8qIGNob3Ag
b2YgJ1xuJyBpbnRyb2R1Y2VkIGJ5IGVjaG8gYXQgdGhlIGVuZCBvZiB0aGUgaW5wdXQgKi8NCj4g
PiArCWlmIChjbWRbY291bnQgLSAxXSA9PSAnXG4nKQ0KPiA+ICsJCWNtZFtjb3VudCAtIDFdID0g
J1wwJzsNCj4gDQo+IFlvdSBoYXZlIGEgcG90ZW50aWFsIG1lbW9yeSBjb3JydXB0aW9uIGJ1ZyBo
ZXJlIGZvciB0aGUgY2FzZSB3aGVyZSAgY291bnQgPiBNQVhfVVNFUl9JTlBVVF9MRU4uIFRoZSBj
b2RlDQo+IGNvcnJlY3RseSBjbGFtcHMgdGhlIG1lbWNweSgpIGxlbmd0aCwgYnV0IGl0IHN0aWxs
IGlzIGF0IHJpc2sgb2Ygd3JpdGluZyBiZXlvbmQgdGhlIGVuZCBvZiB0aGUgY21kIGJ1ZmZlciB3
aGVuIGRvaW5nIHRoZSBcMA0KPiB0ZXJtaW5hdGlvbi4NCj4gDQo+IElmIHlvdSBjaGFuZ2UgdGhl
IGNvZGUgYWJvdmUgdG8gc2F5DQo+IA0KPiAJaWYgKGNvdW50ID4gTUFYX1VTRVJfSU5QVVRfTEVO
KQ0KPiAJCWNvdW50ID0gTUFYX1VTRVJfSU5QVVRfTEVODQo+IAltZW1jcHkoY21kLCBidWYsIGNv
dW50KTsNCj4gDQo+IGl0IHNob3VsZCB0YWtlIGNhcmUgb2YgaXQsIGFuZCBpdCB3aWxsIGFsc28g
cmV0dXJuIHRoZSBhY3R1YWwgY291bnQgd3JpdHRlbiB0byB0aGUgY2FsbGVyLg0KDQpZb3UgYXJl
IHJpZ2h0IGFuZCB0aGFua3MgZm9yIHlvdXIgY29tbWVudCwgSSB3aWxsIGNoYW5nZSB0aGUgY29k
ZSBhcyB5b3Ugc3VnZ2VzdGVkLg0KDQpLaW5kIHJlZ2FyZHMsDQpSb3kNCg==
