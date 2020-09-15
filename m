Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D949D26B1B4
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Sep 2020 00:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgIOWfJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Sep 2020 18:35:09 -0400
Received: from mail-bn8nam11on2072.outbound.protection.outlook.com ([40.107.236.72]:60257
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727581AbgIOQKn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 15 Sep 2020 12:10:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drfQfNB7/fiuMKck1/cbH3gAmlPOv8va8rbg4GzUz64monheHmnlx0krPVyvrykrZalZUekmTtQdNzFZb/685aTsQfJGHcZRQKMpjjhqnXDUDGLXT2AjkH8y81PAoD5zeddn+Fh+Mg6zCZ0IHsJx7/DZ0Ia6CJdcqr91jPu/amtmweF+o8P80ctE8zbOEf3rtF7iOv4lA1AqTINxv0glBW6fDVfbcY37l2ypH/vJGqCRaFI1KZCWCntaNTx8Uk8xYRiFBHhVCEPeCJvnxi8t8QS2lUJSJ+sN8uXsiM9vsJCP8eOa59Zvfxlvdr6b7C29eclsKquqqa8ChohA7K09Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjFUb7vTs5JToxwM5b7IfhF8omXVbCFvx086OiTs8Rw=;
 b=K/42TvsGr9BSffQ90jcydsTs/iOVx+slk/FWVXuOOEQhFZFPSsMscO/CPpFH0XJAiWyVF+xaxB9eaWEtcb+GQjljISpE2S2iMALE0UJtwmwXgdOWeyXfr8Yu+myTkTUl944TNuaO5pG0rHRsqihkp7cf9cUQGGCjA/qOLymgUiyRajydMejGgUq3GFILC6ZwPwWzxOoaBTHmz6ue3upLdyOV4n/RqE1ZVJa1/hzz00CAPnocGfifJZRXTTv5Q+VPsrQkZZN/jslG2fSGTv9EjcaUP7H/KzlwV+Un852IBdkuYm1Cq3E7AhCp1dxsB8DlMlgouqbUmmm46gg8MHLtIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=openfive.com;
 dkim=pass header.d=openfive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osportal.onmicrosoft.com; s=selector2-osportal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjFUb7vTs5JToxwM5b7IfhF8omXVbCFvx086OiTs8Rw=;
 b=kRAm4CF0pJADTy12JMqKIJt7PfbypSA+sgPrZTRtVBWR17MCY7QmzxHhNJ4nCGDIak0EG9Snc16vTg77RAScyyrO1Rj+PK+ty5IarfHMqeqEn4biBJ4HwRJBAn8b+1GJdH3heLZlIYPKsLwPUVMwJw02lp1bKsYDO22oKrEWnZs=
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM5PR13MB1499.namprd13.prod.outlook.com (2603:10b6:3:124::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.8; Tue, 15 Sep
 2020 16:08:39 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876%7]) with mapi id 15.20.3391.009; Tue, 15 Sep 2020
 16:08:38 +0000
From:   Sagar Kadam <sagar.kadam@openfive.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Yash Shah <yash.shah@openfive.com>
Subject: RE: [PATCH v1 1/3] dt-bindings: fu540: prci: convert PRCI bindings to
 json-schema
Thread-Topic: [PATCH v1 1/3] dt-bindings: fu540: prci: convert PRCI bindings
 to json-schema
Thread-Index: AQHWh19dauScmTya2kGXAdhgG1hjhKlo2YUAgAEFd1A=
Date:   Tue, 15 Sep 2020 16:08:38 +0000
Message-ID: <DM6PR13MB3451EE4E239C49BD9E7F032897200@DM6PR13MB3451.namprd13.prod.outlook.com>
References: <1599734644-4791-1-git-send-email-sagar.kadam@sifive.com>
 <1599734644-4791-2-git-send-email-sagar.kadam@sifive.com>
 <160012842007.4188128.14895985041717484631@swboyd.mtv.corp.google.com>
In-Reply-To: <160012842007.4188128.14895985041717484631@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=openfive.com;
x-originating-ip: [116.74.150.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b99558e6-0033-42a6-5ada-08d859919bad
x-ms-traffictypediagnostic: DM5PR13MB1499:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR13MB1499DF8FD07A0990836039E997200@DM5PR13MB1499.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Do4AIX+ryad3lQJOqgIzQxxCtrwlR7qcRguaDW6Dxs9Dvyw8xok7FQfOOl8b0nSdmVKuNVBtML27EC2MmDUjzhyM9e9nH8s9hQ0asCsISji1Kg2tu399a2Nk6edrrRp9r8mdKc5gn/bxAx3tkQqfODGEar8l/RQjRdIWDw+qkVFR7IeXfk/LcRNG+bfXzzt4A0rJaouqJSlbGjtKYCAh9yCU0nihkIQ6hjg0VTDVjblNzsnpz4C3Gq3Wrj1v/KodpVwzptAo/tiazAN1yDJdI1x32TrhVS/R+i3PXPX9TZ6N+4KDSwnCVT/Docl33PmYscBs4L5whaeC6r/Jt8G1oFPTkblcqQgW6rvqfys4nxl61d9j4HmSeyP7aDmIlVEJViFfDUy/pDWNXOYEzoZCPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(366004)(136003)(346002)(376002)(478600001)(52536014)(55016002)(8676002)(83380400001)(8936002)(33656002)(66556008)(64756008)(66446008)(4326008)(71200400001)(66946007)(66476007)(2906002)(76116006)(107886003)(316002)(86362001)(9686003)(44832011)(5660300002)(966005)(110136005)(6506007)(7696005)(186003)(7416002)(55236004)(53546011)(26005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: GVvFcGb7P082hn23jYC6PyW3x3gq8Kit5ymVEoRcT67w3WqrinuzVRvYFla47n5ytWrBg+NNpsS9XHo8B2Q1pgIQhrZQZ+EqDxLrNLNFC2TH+d1aDUPFpKJbDj0ZS7euFdMiLFhQItClbf0SsyHj8EyR9BuZvEiwr0D56e6xUm7u95+89bUedGLdES07mekZbRsKlVGDWNhoH9A/IHpYVmBRxXwnIU3OKGDYnQpC8BO1SQ26+UQo/68JlDEfg0Bq055tAJkAX9vKFJi5BXAaEVMjnPhvNJ6BCE2O/Td230B71430DtPPpTJ5BxWhliFSDswe9D9SAskRgnGFfAIfmxy+t414fhnYjQCUNIaO/XMncljVAiPD2EjeH4N+0l/lpFbkTSFhh08KfWWWZR+QoQmiH2mViQ+anjGwUk+ReqQ2mNTpR32VlubaTMWme2fTXOtWFg9FyvFWkmQWftCscuUGHZJKWvRZH3/UGtlPIXIcLzBNoxQf+Z5t91w5LkbqskQ3K5qhttC0JOIcfJsvagVDWD0EYJp7WvYKTWrYzqV98W9GAOe3X9vDvG6OYalPBNdx85Exa1YivcmcYWHFMJNCoticvFV6+b2B6Ml1jc71z2ce9qNT/yECID5Ot1t750HJD+q6peemaFbBPhaasQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: openfive.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99558e6-0033-42a6-5ada-08d859919bad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 16:08:38.8415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oiQeeOUqWLj6CjDFZGvQSFna9vTG858V4MsW+UevwhXQq4EQjQ/9PePNqk4nMTrM5vurRAyqws4y2sl++VLvGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1499
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGVsbG8gU3RlcGhlbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBT
dGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJl
ciAxNSwgMjAyMCA1OjM3IEFNDQo+IFRvOiBTYWdhciBLYWRhbSA8c2FnYXIua2FkYW1Ab3BlbmZp
dmUuY29tPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWNsa0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wd21Admdl
ci5rZXJuZWwub3JnOyBsaW51eC0NCj4gcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBDYzog
bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgUGF1bCBXYWxtc2xl
eSAoIFNpZml2ZSkNCj4gPHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbT47IHBhbG1lckBkYWJiZWx0
LmNvbTsgdGdseEBsaW51dHJvbml4LmRlOw0KPiBqYXNvbkBsYWtlZGFlbW9uLm5ldDsgbWF6QGtl
cm5lbC5vcmc7IHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbTsNCj4gdS5rbGVpbmUta29lbmlnQHBl
bmd1dHJvbml4LmRlOyBsZWUuam9uZXNAbGluYXJvLm9yZzsNCj4gYW91QGVlY3MuYmVya2VsZXku
ZWR1OyBZYXNoIFNoYWggPHlhc2guc2hhaEBvcGVuZml2ZS5jb20+OyBTYWdhcg0KPiBLYWRhbSA8
c2FnYXIua2FkYW1Ab3BlbmZpdmUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvM10g
ZHQtYmluZGluZ3M6IGZ1NTQwOiBwcmNpOiBjb252ZXJ0IFBSQ0kgYmluZGluZ3MNCj4gdG8ganNv
bi1zY2hlbWENCj4gDQo+IFtFeHRlcm5hbCBFbWFpbF0gRG8gbm90IGNsaWNrIGxpbmtzIG9yIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZQ0KPiBzZW5kZXIgYW5kIGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gUXVvdGluZyBTYWdhciBLYWRhbSAoMjAyMC0wOS0xMCAw
Mzo0NDowMikNCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvY2xvY2svc2lmaXZlL2Z1NTQwLXByY2kueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL3NpZml2ZS9mdTU0MC1wcmNpLnlhbWwNCj4gPiBu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAuLjQ5Mzg2Y2QNCj4gPiAtLS0g
L2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Ns
b2NrL3NpZml2ZS9mdTU0MC1wcmNpLnlhbWwNCj4gPiBAQCAtMCwwICsxLDc1IEBADQo+ID4gKyMg
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAj
IENvcHlyaWdodA0KPiA+ICsoQykgMjAyMCBTaUZpdmUsIEluYy4NCj4gPiArJVlBTUwgMS4yDQo+
ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2Nsb2NrL3Np
Zml2ZS9mdTU0MC1wcmNpLnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IFNpRml2ZSBGVTU0
MCBQb3dlciBSZXNldCBDbG9jayBJbnRlcnJ1cHQgQ29udHJvbGxlciAoUFJDSSkNCj4gPiArDQo+
ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gU2FnYXIgS2FkYW0gPHNhZ2FyLmthZGFtQHNpZml2
ZS5jb20+DQo+ID4gKyAgLSBQYXVsIFdhbG1zbGV5ICA8cGF1bC53YWxtc2xleUBzaWZpdmUuY29t
Pg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246DQo+ID4gKyAgT24gdGhlIEZVNTQwIGZhbWlseSBv
ZiBTb0NzLCBtb3N0IHN5c3RlbS13aWRlIGNsb2NrIGFuZCByZXNldA0KPiA+ICtpbnRlZ3JhdGlv
bg0KPiA+ICsgIGlzIHZpYSB0aGUgUFJDSSBJUCBibG9jay4NCj4gPiArICBUaGUgY2xvY2sgY29u
c3VtZXIgc2hvdWxkIHNwZWNpZnkgdGhlIGRlc2lyZWQgY2xvY2sgdmlhIHRoZSBjbG9jaw0KPiA+
ICtJRA0KPiA+ICsgIG1hY3JvcyBkZWZpbmVkIGluIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2sv
c2lmaXZlLWZ1NTQwLXByY2kuaC4NCj4gPiArICBUaGVzZSBtYWNyb3MgYmVnaW4gd2l0aCBQUkNJ
X0NMS18uDQo+ID4gKw0KPiA+ICsgIFRoZSBoZmNsayBhbmQgcnRjY2xrIG5vZGVzIGFyZSByZXF1
aXJlZCwgYW5kIHJlcHJlc2VudCBwaHlzaWNhbA0KPiA+ICsgY3J5c3RhbHMgb3IgcmVzb25hdG9y
cyBsb2NhdGVkIG9uIHRoZSBQQ0IuICBUaGVzZSBub2RlcyBzaG91bGQgYmUNCj4gPiArIHByZXNl
bnQgIHVuZGVybmVhdGggLywgcmF0aGVyIHRoYW4gL3NvYy4NCj4gPiArDQo+ID4gK3Byb3BlcnRp
ZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAgIC0gc2lm
aXZlLGZ1NTQwLWMwMDAtcHJjaQ0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIFNo
b3VsZCBoYXZlICJzaWZpdmUsPHNvYz4tcHJjaSIsIG9ubHkgb25lIHZhbHVlIGlzIHN1cHBvcnRl
ZA0KPiANCj4gRHJvcCBkZXNjcmlwdGlvbiBhbmQgaGF2ZQ0KPiANCj4gICAgIGNvbXBhdGlibGU6
DQo+ICAgICAgIGNvbnN0OiBzaWZpdmUsZnU1NDAtYzAwMC1wcmNpDQo+IA0KVGhhbmsgeW91IGZv
ciBzdWdnZXN0aW9uIGhlcmUsIEkgd2lsbCByZW1vdmUgdGhpcy4NCj4gPiArDQo+ID4gKyAgcmVn
Og0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArICAgIGRlc2NyaXB0aW9uOiBEZXNjcmliZSB0
aGUgUFJDSSdzIHJlZ2lzdGVyIHRhcmdldCBwaHlzaWNhbCBhZGRyZXNzDQo+ID4gKyByZWdpb24N
Cj4gDQo+IERyb3AgZGVzY3JpcHRpb24uDQo+IA0KT2theS4NCj4gPiArDQo+ID4gKyAgY2xvY2tz
Og0KPiA+ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIFNob3VsZCBwb2ludCB0byB0aGUg
aGZjbGsgZGV2aWNlIHRyZWUgbm9kZSBhbmQgdGhlIHJ0Y2NsayBkZXZpY2UgdHJlZQ0KPiBub2Rl
Lg0KPiANCj4gcy9kZXZpY2UgdHJlZSBub2RlLy9nDQoNCk9rYXksIHdpbGwgcmVtb3ZlIHRoZXNl
Lg0KDQo+IA0KPiA+ICsgICAgICBUaGUgUlRDIGNsb2NrIGhlcmUgaXMgbm90IGEgdGltZS1vZi1k
YXkgY2xvY2ssIGJ1dCBpcyBpbnN0ZWFkIGEgaGlnaC0NCj4gc3RhYmlsaXR5DQo+ID4gKyAgICAg
IGNsb2NrIHNvdXJjZSBmb3Igc3lzdGVtIHRpbWVycyBhbmQgY3ljbGUgY291bnRlcnMuDQo+IA0K
PiBCZXR0ZXIgdG8gaGF2ZToNCj4gDQo+ICAgICBjbG9ja3M6DQo+ICAgICAgIGl0ZW1zOg0KPiAg
ICAgICAgIC0gY29uc3Q6IGhpZ2ggZnJlcXVlbmN5IGNsb2NrDQo+ICAgICAgICAgLSBjb25zdDog
UlRDIGNsb2NrDQo+IA0KPiBDYW4geW91IGFkZCBjbG9jay1uYW1lcyB0b28/IE1ha2luZyBpdCBv
cHRpb25hbCBpcyBPSy4NCk9rYXksIEkgd2lsbCBpbmNsdWRlIHRoZXNlIG9wdGlvbmFsIHByb3Bl
cnRpZXMgYXMNCiAgICAgICAgICAgIC1jb25zdDogImhmY2xrIg0KICAgICAgICAgICAgLWNvbnN0
OiAicnRjY2xrIg0KPiANCj4gPiArICAiI2Nsb2NrLWNlbGxzIjoNCj4gPiArICAgIGNvbnN0OiAx
DQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJl
Zw0KPiA+ICsgIC0gY2xvY2tzDQo+ID4gKyAgLSAiI2Nsb2NrLWNlbGxzIg0KPiA+ICsNCj4gPiAr
YWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiAr
ICAtIHwNCj4gPiArICAgIC8vaGZjbGsgYW5kIHJ0Y2NsayBwcmVzZW50IHVuZGVyIC8sIGluIFBD
Qi1zcGVjaWZpYyBEVCBkYXRhDQo+ID4gKyAgICBoZmNsazogaGZjbGsgew0KPiA+ICsgICAgICAj
Y2xvY2stY2VsbHMgPSA8MD47DQo+ID4gKyAgICAgIGNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2si
Ow0KPiA+ICsgICAgICBjbG9jay1mcmVxdWVuY3kgPSA8MzMzMzMzMzM+Ow0KPiA+ICsgICAgICBj
bG9jay1vdXRwdXQtbmFtZXMgPSAiaGZjbGsiOw0KPiA+ICsgICAgfTsNCj4gDQo+IEFkZCBhIG5l
d2xpbmUgaGVyZT8NCj4gDQpPa2F5Lg0KPiA+ICsgICAgcnRjY2xrOiBydGNjbGsgew0KPiA+ICsg
ICAgICAjY2xvY2stY2VsbHMgPSA8MD47DQo+ID4gKyAgICAgIGNvbXBhdGlibGUgPSAiZml4ZWQt
Y2xvY2siOw0KPiA+ICsgICAgICBjbG9jay1mcmVxdWVuY3kgPSA8MTAwMDAwMD47DQo+ID4gKyAg
ICAgIGNsb2NrLW91dHB1dC1uYW1lcyA9ICJydGNjbGsiOw0KPiA+ICsgICAgfTsNCj4gDQo+IFRo
ZXNlIG1heSBub3QgYmUgbmVjZXNzYXJ5IGVpdGhlciwganVzdCBoYXZlIHRoZSBjbG9jay1jb250
cm9sbGVyIG5vZGUNCj4gcmVmZXJlbmNlIHBoYW5kbGVzPw0KPiANCk9rYXkuDQo+ID4gKw0KPiA+
ICsgICAgLy91bmRlciAvc29jLCBpbiBTb0Mtc3BlY2lmaWMgRFQgZGF0YQ0KPiANCj4gRG9uJ3Qg
dGhpbmsgdGhpcyBjb21tZW50IGlzIG5lY2Vzc2FyeS4NCj4gDQpPa2F5Lg0KDQpUaGFua3MgJiBC
UiwNClNhZ2FyDQoNCj4gPiArICAgIHByY2k6IGNsb2NrLWNvbnRyb2xsZXJAMTAwMDAwMDAgew0K
PiA+ICsgICAgICBjb21wYXRpYmxlID0gInNpZml2ZSxmdTU0MC1jMDAwLXByY2kiOw0KPiA+ICsg
ICAgICByZWcgPSA8MHgxMDAwMDAwMCAweDEwMDA+Ow0KPiA+ICsgICAgICBjbG9ja3MgPSA8Jmhm
Y2xrPiwgPCZydGNjbGs+Ow0KPiA+ICsgICAgICAjY2xvY2stY2VsbHMgPSA8MT47DQo+ID4gKyAg
ICB9Ow0K
