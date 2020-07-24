Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FC722BBD9
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Jul 2020 04:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGXCG0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Jul 2020 22:06:26 -0400
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:25572
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbgGXCG0 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 23 Jul 2020 22:06:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4vr9GoyU94G9YKIvMl2M9Wt7g9SA7LiULp6W/Dy9A//NgTGp1oxl5KjMZNcJsD7VOooYM1x99SD3RjuNTxrUTeAjKrEKi+6xoOy09lrjdHm5AMkNMZryxMEZ/PNgDD03EX6K+Q+ibjLJoEopapAYXx4XYbCPQl22x5kHukd1EtFSxodMRg/0tWMle+cecvKZ/tQUYqlivS/P9acF4xjUUYbG8Nha+dobEopL1UN/d5h2jTvWTjtdvn7+TPLeRpmCdUUB0fsEWvYiEFJUSTyDpZ0Mor1SWVVEZjTqZ3OacvxQSm5MRcQK8M162ar5AgHvlS6NEwtyPf4OCat/BJXSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSMtl0zVAvcIWib6u7wc+DPcwiHB5zQsDVgU5NHYefE=;
 b=GD/LVOCIzRa3pB/3O29gnFSYwgBUq4SM8Zea2ozBH9V19V9ZzSmsn6PLzrMrV2zunqi2lc7H0TMalFEQmouuif6v6pei1L7hWb34QBWj6FytNBBAQRrKZLVSH//Fa08uzCjjJz6hEQfAJLxqTlNXFU1zR+m89qkiLRo6iQ1p8ol9HDyDFViz8xskNdba40cGTIhlzkkjEpvLpJ02ZGlc0nDXiNcB/XbGgK25/bCm6CwF4bLtGlhh7YlTaxdfAfNs03Jag20AnivL34vwYSllNr7FyTnXBvS1RP9/W9j3CG5D46iY8lLkjBFFymwIlXv6BBKJdLgye/aYGNiR8bXyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSMtl0zVAvcIWib6u7wc+DPcwiHB5zQsDVgU5NHYefE=;
 b=MTOiQPnD5h2wn9VYSkvZdVs2b5p1amFOsLWiQF8YnHR7ZEzt4HB5DNAj3kXQNk/+mRzp09QbuKFZcXF0mnlj0WVab1HZw0/UmthbehApeY8FQb3QnszC0fQQTH5f0B79DLVjcoi78kf8hVNjXvVUImwZuROjyi6mbwaQ0eTmf+A=
Received: from DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e9::10)
 by DB8PR10MB3481.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 02:06:22 +0000
Received: from DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9913:d1be:cd0f:a620]) by DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9913:d1be:cd0f:a620%6]) with mapi id 15.20.3216.023; Fri, 24 Jul 2020
 02:06:22 +0000
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
Thread-Index: AQHWYRWk1fE308LH4Uerj7poX/VTYqkVpOYAgABTu4A=
Date:   Fri, 24 Jul 2020 02:06:22 +0000
Message-ID: <DB8PR10MB3436A78B153E566464AA07E085770@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1595516501.git.Roy.Im@diasemi.com>
 <c13d812871b7f09205c1f04e95f5bdf07f307eaf.1595516501.git.Roy.Im@diasemi.com>
 <ad4f8a07-9e78-ce97-021f-094210d99a3c@infradead.org>
In-Reply-To: <ad4f8a07-9e78-ce97-021f-094210d99a3c@infradead.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.240.7.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00f517ab-54e8-4e3b-f0d4-08d82f762993
x-ms-traffictypediagnostic: DB8PR10MB3481:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB3481D689A76094075F11D075A2770@DB8PR10MB3481.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v3RhacOPEv3SsqYdl7D/rbOvcIJKXVBSb4kMD/ffDaieft64TJL76QE5wf6NqNIeIwZQMDQRnSuZDzfdKCc8p3rghEge6xJziZJTFzNax2k1Hz+0Ubof1NBYdSOBzMchiXfgXZzbYeJDkeYiYsWZtcX/cFZy6gm/zwbAWd7OH2sNgpidkz5va8BxRvgBRlGZX/wx1P0cIm2uZBcNzWTyU8Sha+9DjH9QREJ6A3XoLYndN0qbkyf3e0qFMZg/WZaEu8WB0733nZRH6kUbrm2bsTkNn9eHiixQnQJ9TKJ/aWnOOgPXisvMTuZl5AGcdrYQaFQVShn2gPPLjS0MO0HxW9c7Q6YKLOj6GDa4/Z5zWtS5FC6DD2O/x6UQHlBT3tgj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(71200400001)(316002)(8676002)(86362001)(6506007)(33656002)(478600001)(54906003)(53546011)(2906002)(8936002)(83380400001)(9686003)(110136005)(76116006)(186003)(26005)(55016002)(64756008)(52536014)(7696005)(4326008)(5660300002)(66946007)(66476007)(66446008)(7416002)(66556008)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: prSMkGGmwxQVzcjHNPnGcp+XEXpV1bJbmDmOFDjjqc9VLgUKk6FvkC7hHU+6wsdqC3TyxF1PR9XDzy+abyytnxW6QGrWrrp48lSExbRHVD9VX6HH04qCZrXeTZbXpy+DR8CXCwjBf4QXokBB6CA5RBZLNHCPyG+nebe+J0x4O3BdEPMtnRBXyvKQLN3eCyIF33XGeXTXDt74fkEMo7NKUNNsgxTXBn9ppigDspoDX+KBrm/JZrUB4EHShwXnRaKhkvojhXTurxHGmxwdAUTkXnNIFD8fzxDoUabWd9giDBmIEn7h1NF5xfYY/z1K7Svi+yYow1DmaJyWvRtFJbOpVYM0OAI4gfPWORyKjQeyJhzjS7KBvXTSjiw5ei7Mmwt9rgEB7nWQ1/6gQ+siq8k6mJH9y8/FXc0wTbi3cw61p99jcY5QGhWlOXNAkkGXUYTqXFRbDW4OUcYjtCj2lJMtZS3aWOitEVFBPqppKpDOQd8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f517ab-54e8-4e3b-f0d4-08d82f762993
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 02:06:22.1483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7aviD4+KYN26Jv25tDPF3onz+Qw8dv7ttVMH5OhDxiv14mxB9XAPiSH+D1UlyU76bg9Zs4rvplNsP+bif9LzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3481
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gRnJpIEp1bHkgMjQsIDIwMjAgNTo1NSBBTSwgUmFuZHkgRHVubGFwIHdyb3RlOiANCj4gT24g
Ny8yMy8yMCA4OjAxIEFNLCBSb3kgSW0gd3JvdGU6DQo+ID4gQWRkcyBzdXBwb3J0IGZvciB0aGUg
RGlhbG9nIERBNzI4MCBMUkEvRVJNIEhhcHRpYyBEcml2ZXIgd2l0aCBtdWx0aXBsZQ0KPiA+IG1v
ZGUgYW5kIGludGVncmF0ZWQgd2F2ZWZvcm0gbWVtb3J5IGFuZCB3aWRlYmFuZCBzdXBwb3J0Lg0K
PiA+IEl0IGNvbW11bmljYXRlcyB2aWEgYW4gSTJDIGJ1cyB0byB0aGUgZGV2aWNlLg0KPiA+DQo+
ID4gUmV2aWV3ZWQtYnk6IEplcyBTb3JlbnNlbiA8SmVzLlNvcmVuc2VuQGdtYWlsLmNvbT4uDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSb3kgSW0gPHJveS5pbS5vcGVuc291cmNlQGRpYXNlbWku
Y29tPg0KPiA+DQo+ID4gLS0tDQo+ID4NCj4gPg0KPiA+ICBkcml2ZXJzL2lucHV0L21pc2MvS2Nv
bmZpZyAgfCAgIDEzICsNCj4gPiAgZHJpdmVycy9pbnB1dC9taXNjL01ha2VmaWxlIHwgICAgMSAr
DQo+ID4gIGRyaXZlcnMvaW5wdXQvbWlzYy9kYTcyODAuYyB8IDE4NDANCj4gPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwg
MTg1NCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lucHV0
L21pc2MvZGE3MjgwLmMNCj4gPg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnB1dC9t
aXNjL2RhNzI4MC5jIGIvZHJpdmVycy9pbnB1dC9taXNjL2RhNzI4MC5jDQo+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQgaW5kZXggMDAwMDAwMC4uNmUzZWFkNQ0KPiA+IC0tLSAvZGV2L251bGwNCj4g
PiArKysgYi9kcml2ZXJzL2lucHV0L21pc2MvZGE3MjgwLmMNCj4gPiBAQCAtMCwwICsxLDE4NDAg
QEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+ID4gKy8qDQo+
ID4gKyAqIERBNzI4MCBIYXB0aWMgZGV2aWNlIGRyaXZlcg0KPiA+ICsgKg0KPiA+ICsgKiBDb3B5
cmlnaHQgKGMpIDIwMjAgRGlhbG9nIFNlbWljb25kdWN0b3IuDQo+ID4gKyAqIEF1dGhvcjogUm95
IEltIDxSb3kuSW0uT3BlbnNvdXJjZUBkaWFzZW1pLmNvbT4gICovDQo+ID4gKw0KPiA+ICsjaW5j
bHVkZSA8bGludXgvZXJyLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pMmMuaD4NCj4gPiArI2lu
Y2x1ZGUgPGxpbnV4L2lucHV0Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcHdt
Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4
L3dvcmtxdWV1ZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPg0KPiA+ICsjaW5j
bHVkZSA8bGludXgvYml0b3BzLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9iaXRmaWVsZC5oPg0K
PiA+ICsNCj4gDQo+IC4uLg0KPiANCj4gDQo+ID4gK3N0YXRpYyBpbnQgZGE3MjgwX2hhcHRpY19z
ZXRfcHdtKHN0cnVjdCBkYTcyODBfaGFwdGljICpoYXB0aWNzLCBib29sDQo+ID4gK2VuYWJsZWQp
IHsNCj4gPiArCXN0cnVjdCBwd21fc3RhdGUgc3RhdGU7DQo+ID4gKwl1NjQgcGVyaW9kX21hZ19t
dWx0aTsNCj4gPiArCWludCBlcnJvcjsNCj4gPiArDQo+ID4gKwlpZiAoIWhhcHRpY3MtPmdhaW4g
JiYgZW5hYmxlZCkgew0KPiA+ICsJCWRldl9lcnIoaGFwdGljcy0+ZGV2LA0KPiA+ICsJCQkiUGxl
YXNlIHNldCB0aGUgZ2FpbiBmaXJzdCBmb3IgdGhlIHB3bSBtb2RlXG4iKTsNCj4gPiArCQlyZXR1
cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlwd21fZ2V0X3N0YXRlKGhhcHRpY3Mt
PnB3bV9kZXYsICZzdGF0ZSk7DQo+ID4gKwlzdGF0ZS5lbmFibGVkID0gZW5hYmxlZDsNCj4gPiAr
CWlmIChlbmFibGVkKSB7DQo+ID4gKwkJcGVyaW9kX21hZ19tdWx0aSA9ICh1NjQpc3RhdGUucGVy
aW9kICogaGFwdGljcy0+Z2FpbjsNCj4gPiArCQlwZXJpb2RfbWFnX211bHRpID4+PSBNQVhfTUFH
TklUVURFX1NISUZUOw0KPiA+ICsNCj4gPiArCQkvKiBUaGUgaW50ZXJwcmV0YXRpb24gb2YgZHV0
eSBjeWNsZSBkZXBlbmRzIG9uIHRoZSBhY2NfZW4sDQo+ID4gKwkJICogaXQgc2hvdWxkIGJlIGJl
dHdlZW4gNTAlIGFuZCAxMDAlIGZvciBhY2NfZW4gPSAwLg0KPiA+ICsJCSAqIFNlZSBkYXRhc2hl
ZXQgJ1BXTSBtb2RlJyBzZWN0aW9uLg0KPiA+ICsJCSAqLw0KPiANCj4gZnJvbSBjb2Rpbmctc3R5
bGUucnN0Og0KPiANCj4gCS8qDQo+IAkgKiBUaGlzIGlzIHRoZSBwcmVmZXJyZWQgc3R5bGUgZm9y
IG11bHRpLWxpbmUNCj4gCSAqIGNvbW1lbnRzIGluIHRoZSBMaW51eCBrZXJuZWwgc291cmNlIGNv
ZGUuDQo+IAkgKiBQbGVhc2UgdXNlIGl0IGNvbnNpc3RlbnRseS4NCj4gCSAqDQo+IAkgKiBEZXNj
cmlwdGlvbjogIEEgY29sdW1uIG9mIGFzdGVyaXNrcyBvbiB0aGUgbGVmdCBzaWRlLA0KPiAJICog
d2l0aCBiZWdpbm5pbmcgYW5kIGVuZGluZyBhbG1vc3QtYmxhbmsgbGluZXMuDQo+IAkgKi8NCj4g
DQo+IChleGNlcHQgZm9yIG5ldHdvcmtpbmcgY29kZSkNCj4gDQo+IFBsZWFzZSBmaXggbXVsdGlw
bGUgbG9jYXRpb25zLg0KT0ssIEkgd2lsbCBmaXggdGhlbS4NCg0KPiANCj4gDQo+IHRoYW5rcy4N
Cj4gLS0NCj4gflJhbmR5DQoNCktpbmQgcmVnYXJkcywNClJveQ0K
