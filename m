Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C2922BDAF
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Jul 2020 07:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgGXFrK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Jul 2020 01:47:10 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:59425
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbgGXFrK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 24 Jul 2020 01:47:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOtNaFjS6v35Ij0AllUgxaGt0Y4PHQmrAKaEtQ3IEv7w7BE58GKTUxkA+iGsi++kppefYnlg6AqkTSKcW4fTA9Z3w+72yGzsKRuJJ7mPrK+FoRpkl4SMBensDT6Yrtvh23551eGjmgjCaKLkGBRPfvqDrM68ehehgSod8nDWAitm5Cjgos0Ncuh/btQa9nU/a6nmNRf1Uyc6YD/m1uIJeEMyeQIfkidrlVGvOptJrSycgfjA44ytJZ0jffZqIg5IuGirCQ1qBszCdaSuk4hGeBowfR3ot+4pPsnlP0Yd0qfXMY7RMOJYe6Jd5qD3Gsb50r3rxv/SFwyWbVXNUQzR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfMLcuA1vzkw5JRQaxngJdevzm2Ug5KfCwSLqyop3Lc=;
 b=Wbcnl3kSBNwFjEYO+Z/m73YhqFDzzKRHUar6SteoyUrxGZtpNJ4+skpA1xtosv9ZbhuiCwGRO9kMs+yyDK4fTKXNIg8Sw124orj/zgCR+6c+0VN9de2Zh3m4ib5ROTAaa2VYcd2nMhmT32CjxHfG9l+E3sijGoDeI9Dbvw8brO+Lse+bgH8mGOSkDqVkNeIe4mhbdqaqbtGMhEQ2rVDV7EoTA6CmQOZFXz4wrHg/zrupLCHcjG6CL5Vt22yeAdEb3OGpEORW8iw0ES2RHv5i4PguXZlgNy7Dl/6901wm0p+9804t2eLBJHtyzI46sFRjAx2jI40FSuZ8ZUZJJaHq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfMLcuA1vzkw5JRQaxngJdevzm2Ug5KfCwSLqyop3Lc=;
 b=Repr1x99YJJxQYplKz3cTGNuS5D7h1zCurOJavz9yJr66gEOcEye1i28mIRlLgImbkzlihmwffzxZoNeLyggaIFp3+TZ50qEFMRuFdRtYbtjdLdn7jxHzzCpk+idp0HaE1OjfSXNOsIwjAt/v4XiwpLwx61EIuQu780L5+gzXvw=
Received: from DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e9::10)
 by DB6PR10MB1815.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:39::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 05:47:05 +0000
Received: from DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9913:d1be:cd0f:a620]) by DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9913:d1be:cd0f:a620%6]) with mapi id 15.20.3216.023; Fri, 24 Jul 2020
 05:47:05 +0000
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
Thread-Index: AQHWYRWk1fE308LH4Uerj7poX/VTYqkVo6qAgABU7YCAABFPAIAAIySw
Date:   Fri, 24 Jul 2020 05:47:04 +0000
Message-ID: <DB8PR10MB343624BF003338E8B34439AC85770@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1595516501.git.Roy.Im@diasemi.com>
 <c13d812871b7f09205c1f04e95f5bdf07f307eaf.1595516501.git.Roy.Im@diasemi.com>
 <71818ab8-0020-77db-c412-8d35a541ead3@infradead.org>
 <DB8PR10MB343644A6DADE61D62BEE157C85770@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
 <f549102d-4e69-c903-1672-f50bdb7994a3@infradead.org>
In-Reply-To: <f549102d-4e69-c903-1672-f50bdb7994a3@infradead.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.240.7.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 301bd3cc-3552-4e1a-fc09-08d82f94fef5
x-ms-traffictypediagnostic: DB6PR10MB1815:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR10MB18157F9B6EA98FB9ECDD13F3A2770@DB6PR10MB1815.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VvTMIkJgG0mPWSDDsY++HUnVJOKC/zAgTAPwLWBeAaPvnRy5afDvrHen7I/LbYWAhKbE3jTCYcR4mEsErS1qmkTkccd+y3nsCuQtQRtVL6jcpa5kQuCG6hDBwFWYxBQjljUrc626k9Tji91N7kYBh74IUYp19wVFdOsvwhqqt4mWrMEvdi5oIM5OkTmnKxyE1NKgyj+DgDjeRQhm0zC8pvbdI/bBWkpNKCxtrZE4Rm9z/ujaU17vy1FpcNCXY77AYSlNSrm8HznL0MBvR/kX3CuIubxIoK0lk+hm2pobw2RQy0N0eFgV+mwyzDFO7lJW46jmDylxjDMXibj12bgamEtsL0s9IZegbKUxm/0tJTCyPv1/G/0mhzhcCSIj5zLE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(7696005)(26005)(186003)(83380400001)(5660300002)(66446008)(64756008)(76116006)(53546011)(6506007)(33656002)(9686003)(66476007)(66946007)(66556008)(55016002)(71200400001)(316002)(478600001)(86362001)(7416002)(8936002)(52536014)(110136005)(54906003)(4326008)(8676002)(2906002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: sEQ0uKX3gLQlq0SljMqoQtnAfUvZo8pMcSiTauYX9izwzsq6cnQ+ozziuXkgb02/SXLqjBwa1TG7HcLVLxWkrf86rl7D6U9FCz5sbge6EbaoO6FJHr7SSq+ylV2tCUc+WMearjv5kRuBlVGMgd1E59FNuxyfZGHRLIBz9ScRhV1doty+H6bvJLrjkSMGaypMu8bDs1Xdfe+t86hxHvVpUCPZxVCg9lRYmm8ekrGhWhUP+aUswh2I716PMJgo/bsz6XbLP8s9nwod6BsREh7q8TLlcC1BhdlaXIVgqERv2YZIdySyC38HT27KAfh+AxxwzJBqp1JwHv/Lk3HVGibcaP6HE5VxZRuZsM4UWJApHGPncalbtfDy1g33bSm0kh+Ztf7aIhZP+WLMr4qhgiJoAyNucXMtKNk1TncU3skgfjx5k9Ey3gPA0/UwlwFQNdXD9pmbr2AyyB92CoAKqBvwS3BYrCfDyxvvvOo9ckTXXoU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 301bd3cc-3552-4e1a-fc09-08d82f94fef5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 05:47:05.0934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8NsuYAprjff4R9hpEhNKj74PoZkTkush0BhT9w2S0rS3sSEN/dhzw3lJeq0YtZqQTYtjFiKpIS3O0u69CfAgwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1815
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

RnJpZGF5LCBKdWx5IDI0LCAyMDIwIDExOjU3IEFNLCBSYW5keSBEdW5sYXAgd3JvdGUgDQo+IE9u
IDcvMjMvMjAgNjo1NCBQTSwgUm95IEltIHdyb3RlOg0KPiA+IE9uIEZyaSwgSnVseSAyNCwgMjAy
MCA1OjUxIEFNLCBSYW5keSBEdW5sYXAgd3JvdGUNCj4gPj4gT24gNy8yMy8yMCA4OjAxIEFNLCBS
b3kgSW0gd3JvdGU6DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbnB1dC9taXNjL0tjb25m
aWcgYi9kcml2ZXJzL2lucHV0L21pc2MvS2NvbmZpZw0KPiA+Pj4gaW5kZXggMzYyZThhMC4uMDZk
YzVhMyAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvaW5wdXQvbWlzYy9LY29uZmlnDQo+ID4+
PiArKysgYi9kcml2ZXJzL2lucHV0L21pc2MvS2NvbmZpZw0KPiA+Pj4gQEAgLTg2OSw0ICs4Njks
MTcgQEAgY29uZmlnIElOUFVUX1NUUE1JQzFfT05LRVkNCj4gPj4+ICAJICBUbyBjb21waWxlIHRo
aXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0aGUNCj4gPj4+ICAJICBtb2R1
bGUgd2lsbCBiZSBjYWxsZWQgc3RwbWljMV9vbmtleS4NCj4gPj4+DQo+ID4+PiArY29uZmlnIElO
UFVUX0RBNzI4MF9IQVBUSUNTDQo+ID4+PiArCXRyaXN0YXRlICJEaWFsb2cgU2VtaWNvbmR1Y3Rv
ciBEQTcyODAgaGFwdGljcyBzdXBwb3J0Ig0KPiA+Pj4gKwlkZXBlbmRzIG9uIElOUFVUICYmIEky
Qw0KPiA+Pj4gKwlzZWxlY3QgSU5QVVRfRkZfTUVNTEVTUw0KPiA+Pj4gKwlzZWxlY3QgUkVHTUFQ
X0kyQw0KPiA+Pj4gKwloZWxwDQo+ID4+PiArCSAgU2F5IFkgdG8gZW5hYmxlIHN1cHBvcnQgZm9y
IHRoZSBEaWFsb2cgREE3MjgwIGhhcHRpY3MgZHJpdmVyLg0KPiA+Pj4gKwkgIFRoZSBoYXB0aWNz
IGNhbiBiZSBjb250cm9sbGVkIGJ5IEkyQyBjb21tdW5pY2F0aW9uLA0KPiA+Pj4gKwkgIG9yIGJ5
IFBXTSBpbnB1dCwgb3IgYnkgR1BJLg0KPiA+Pg0KPiA+PiAJICBJcyB0aGF0ICAgICAgICAgICAg
ICAgIEdQSU8uDQo+ID4+ID8NCj4gPiBUaGUgSGFwdGljcyBjYW4gYmUgd29ya2luZyBieSBHUEko
aWYgc2VlIGZyb20gdGhlIGhhcHRpYyBkZXZpY2UpLCBidXQgZnJvbSB0aGUgSG9zdCBpdCBpcyBH
UE8uIERvIHlvdSB0aGluayB0aGUgR1BJTyBpcw0KPiBjb3JyZWN0Pw0KPiANCj4gVG8gbWUgaXQg
bmVlZHMgdG8gcmVwcmVzZW50IHdoYXQgc2VydmljZXMvaW50ZXJmYWNlcy9mYWNpbGl0aWVzIGFy
ZSB1c2VkIGJ5IHRoaXMgZHJpdmVyIHRoYXQgYXJlIHByb3ZpZGVkIGJ5IHRoZSBMaW51eCBrZXJu
ZWwuDQo+IElmIGl0IHVzZXMgTGludXggR1BJTyBzZXJ2aWNlcywgdGhlbiBpdCBzaG91bGQgc2F5
IEdQSU8gLS0gYWx0aG91Z2ggSSBkb24ndCBzZWUgaXQgdXNpbmcgYW55IExpbnV4IEdQSU8gc2Vy
dmljZXMuDQoNCk9LLCBsZXQgbWUgY2hhbmdlIHRvIEdQSU8uDQoNCj4gDQo+ID4+DQo+ID4+IENh
biB0aGUgaGFwdGljcyBiZSBjb250cm9sbGVkIG9ubHkgYnkgUFdNIG9yIG9ubHkgYnkgR1BJKE8p
Pw0KPiA+Pg0KPiA+PiBKdXN0IGN1cmlvdXM6IHdoeSBpcyBJMkMgcmVxdWlyZWQgdG8gYnVpbGQg
dGhlIGRyaXZlciBpZiBhIHVzZXIgaXMgb25seSBjb250cm9sbGluZyB0aGUgZGV2aWNlIGJ5IFBX
TSBvciBHUEk/DQo+ID4NCj4gPiBJMkMgaXMgcmVxdWlyZWQgdG8gY29udHJvbCByZWdpc3RlcnMg
YW5kIGl0IGNhbiBiZSB0cmlnZ2VyZWQgYnkgSTJDIG9yIFBXTSBvciBHUEkoY29udHJvbGxlZCBi
eSBob3N0IG91dHNpZGUgdGhpcyBkcml2ZXIpLA0KPiBzbyBQV00gYW5kIEdQSSBhcmUgb3B0aW9u
YWwuDQo+ID4gV2l0aCB5b3VyIGNvbW1lbnRzLCBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIHJlbW92
ZSBiZWxvdyBsaW5lcygvL3JlbW92ZSkgdG8gYXZvaWQgY29uZnVzaW9uIGFuZCBhZGQgUFdNIGFz
IGJlbG93IGlmDQo+IHlvdSBhZ3JlZS4NCj4gPiAgICAgICAgICAvLyByZW1vdmUNCj4gPiAJICBU
aGUgaGFwdGljcyBjYW4gYmUgY29udHJvbGxlZCBieSBJMkMgY29tbXVuaWNhdGlvbiwNCj4gPiAJ
ICBvciBieSBQV00gaW5wdXQsIG9yIGJ5IEdQSS4NCj4gPiAgICAgICAgICAvLyB1cGRhdGUsIGFk
ZGluZyB8fCBQV00NCj4gPiAgICAgICAgICBkZXBlbmRzIG9uIChJTlBVVCAmJiBJMkMpIHx8IFBX
TQ0KPiANCj4gU2luY2UgPGxpbnV4L3B3bS5oPiBwcm92aWRlcyBzdHVicyBmb3Igd2hlbiBDT05G
SUdfUFdNIGlzIG5vdCBlbmFibGVkLCBpdCBhcHBlYXJzIHRoYXQgImRlcGVuZHMgb24gIFBXTSIg
aXMgbm90DQo+IHJlcXVpcmVkLg0KPiANCj4gSSdsbCBsZWF2ZSBpdCB1cCB0byB5b3UuIEkgd2Fz
IGp1c3QgdHJ5aW5nIHRvIHVuZGVyc3RhbmQgYmV0dGVyLg0KPiBJdCBtYXkgYmUgdGhhdCBubyBj
aGFuZ2VzIGFyZSBuZWVkZWQuDQoNCk9LLCB0aGFua3MgZm9yIHlvdXIgY29tbWVudHMuIFRvIGJl
IGNsZWFyZXIsIEkgd291bGQgbGlrZSB0byB1cGRhdGUgYXMgYmVsb3cgaWYgeW91IGFncmVlDQoJ
DQoJZGVwZW5kcyBvbiBJTlBVVCAmJiBJMkMNCi4uLg0KCVRoZSBoYXB0aWNzIGNhbiBiZSBjb250
cm9sbGVkIGJ5IFBXTSBvciBHUElPDQoJd2l0aCBJMkMgY29tbXVuaWNhdGlvbi4NCj4gDQo+IA0K
PiB0aGFua3MuDQo+IC0tDQo+IH5SYW5keQ0KDQpLaW5kIHJlZ2FyZHMsDQpSb3kNCg==
