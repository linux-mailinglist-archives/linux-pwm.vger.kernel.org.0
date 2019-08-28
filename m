Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611BF9FFCE
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Aug 2019 12:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfH1K0W (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Aug 2019 06:26:22 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:29911 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfH1K0V (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Aug 2019 06:26:21 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: E6r/PQdmO31n+Qc8VsnIp5iv4Sdcg5KwZF24MxpvWlvLG2pvSY4zfSL/1rVxgcdBIdGeZWxgzC
 TSexgAUlYJGF6cnQgo1ZWJYkV/3kMfy+lvD8mHP6SwLoz3jiNY5RLPJuFVpe/EdK+EF0bGQrsG
 2U2HMCUtfxCDZFjgIpegtTBLNGfGlO4tI+Xfmk+yHHd+D9KDPCuPNiCTGzt903YhieZLuVLB/d
 mYxAT+46N44onCY/IOZbMalwZEc9Q7Msu+Nz5QEf4JEEHjuCCENDnqqhhSrQCjpigHIkEAk0wT
 Hpo=
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="46903512"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Aug 2019 03:26:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 28 Aug 2019 03:26:19 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 28 Aug 2019 03:26:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4vYMurnLRunC3031/wiwduMf7xvb+iA3ubEJAU+8193mWWCyTSh1eXvOSM4keA+5PL83w1i/7jBQPQYgSnZP+KCYuMfdJ92oNZ2cUvXtxDSzh6VpT1GJtHnVBkwBpgQAJzl5VDLyx8IPUPhWjxzNTxzlnO3kzboZUlSVUWHMNItlgGAO1J9B/Jvc4mIeiPRwH169Di5vy3biLfS0kMNN8GBqeelppx4cznaJKZ2DyzcIY/b1tCqzUXniHykdUUaVDHymHA5FxMDJz3EqX0V3rYLIGhpHUMPnvcFu9ZQRubmiRrRrglRt+EARb4oXo+w3Rd5ANT5P/DVH990sBFK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exbS2ahhWnhCIcddIKThWxbVxt3HYCRT4g9tsE+AgLI=;
 b=BxLW6a2vUCNfu/DnQ134yrU07/pL4hEN+2mXndACCDUPNCPZDxUxxRuczzxVEFZxq6RGXVfg4wL5A6DK7JQXs1JyHU/8b90sH3pQ8cSjMHA9hrTmaby/p5wfmSQ5e7A5oMvVeEgnEWf+6bmvwMaUMvxnNfYfN2yXjZ9UNeWBJOPfy7a0Rm0J9yzyGbDaSalvxAGKbTprGLe7iHmYlLmbn4JeHWqlVVkTAteB9lBuzvFKz/uVD7T0p7Jie3hRc/ZH8efJ9zqfp9aE27m6A0Zpe+EXuoCluDfVDfGdwc1h3Y4d9heFfw8hgjq5c3fUZzyFXcozaLCdx8R6RM6N4JmbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exbS2ahhWnhCIcddIKThWxbVxt3HYCRT4g9tsE+AgLI=;
 b=Bh0PqwHMgB8gC5kZu6ilxTXn2ILdcr2Ra9dUo/cqk9RYaFN27uxgThnmlc39kzcdtZ1xM8lB9RIZjeFpJ3ufy8HSKNLSh8mvFvzk5oqDRyy3TSqo+0bvprwT11u0Cet+le4QDrIbeSu9gezmcs1qN3Rp8PJW4a+G97oYByMM+bA=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1454.namprd11.prod.outlook.com (10.172.54.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Wed, 28 Aug 2019 10:26:18 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::9596:8d2b:63e5:9a36]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::9596:8d2b:63e5:9a36%3]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 10:26:18 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <uwe@kleine-koenig.org>, <thierry.reding@gmail.com>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] pwm: atmel: implement .get_state()
Thread-Topic: [PATCH v2 6/6] pwm: atmel: implement .get_state()
Thread-Index: AQHVXYsB0dfa//veNkO80NfMXm4q9A==
Date:   Wed, 28 Aug 2019 10:26:18 +0000
Message-ID: <8da4ef26-872f-beaf-b5cb-9d8cb93a2ce9@microchip.com>
References: <20190824001041.11007-1-uwe@kleine-koenig.org>
 <20190824001041.11007-7-uwe@kleine-koenig.org>
In-Reply-To: <20190824001041.11007-7-uwe@kleine-koenig.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR10CA0109.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::38) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190828132609155
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28dc8361-200d-44d6-29df-08d72ba229ae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1454;
x-ms-traffictypediagnostic: MWHPR11MB1454:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB14544EFF9065C38CA1C93C8587A30@MWHPR11MB1454.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(376002)(136003)(189003)(199004)(476003)(66066001)(7736002)(305945005)(25786009)(66574012)(86362001)(66946007)(66556008)(66476007)(478600001)(64756008)(26005)(102836004)(76176011)(8936002)(2906002)(14454004)(186003)(486006)(4326008)(71200400001)(71190400001)(66446008)(6116002)(316002)(31686004)(5660300002)(3846002)(8676002)(110136005)(81156014)(81166006)(52116002)(99286004)(229853002)(6486002)(54906003)(11346002)(36756003)(53546011)(6512007)(6506007)(386003)(2616005)(6436002)(446003)(256004)(6246003)(53936002)(14444005)(31696002)(142923001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1454;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bDzV+sYkpJWrMZ4Bjs8QiXnxb4eJDNQ/NhECsaqjDUNFh/LT1mzAxzZro2YB4eTjMm9AkNEkcpoDzFV6LBCN7GjO3NpU1sme+45lfiOA155DgEUZ/k1/90dGGwtFne/rQHTD0xmCm70Umm+6DAAAc39KgyHZSEtWZnsBZk5kD/VErFa1OJ6/NLNEC0lf0XIV885nO4UvR8+R20LNqPTahQQp7+7w13hrsHJ7NU2+rfl4uOH3Pn4hdkGhHg5ZQzEd5XXVzva4aO42wR9dqEFvVZHkMPBH/LSOObyhmAg4aJGsEXKhWIq/AO9aomgQYgp9FZQYrcwV6fbRFiStwj2bh1EDQ9Q3kDoxr9CW2JO6GRosj0Fx8zfCZKUreKk4o6oK92mdesqRB8edTB6dbTVWkWCxIduuU4ISDHv1I2x38ic=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5B7CFECC7B0094FB3579B1E4A09AC42@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 28dc8361-200d-44d6-29df-08d72ba229ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 10:26:18.4119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCXDc/NWVpdpfr+5ixt6VX5v7ie/Zpq3Cp7rU8zzD7e8LgZE/6Ym4oL3NkrXMiJT/wBcywLEowb+b/7761FS11z88FhTSshGMAadVVz1qFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1454
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQoNCk9uIDI0LjA4LjIwMTkgMDM6MTAsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBFeHRl
cm5hbCBFLU1haWwNCj4gDQo+IA0KPiBUaGlzIGZ1bmN0aW9uIHJlYWRzIGJhY2sgdGhlIGNvbmZp
Z3VyZWQgcGFyYW1ldGVycyBmcm9tIHRoZSBoYXJkd2FyZS4gQXMNCj4gLmFwcGx5IHJvdW5kcyBk
b3duIChtb3N0bHkpIEknbSByb3VuZGluZyB1cCBpbiAuZ2V0X3N0YXRlKCkgdG8gYWNoaWV2ZQ0K
PiB0aGF0IGFwcGx5aW5nIGEgc3RhdGUganVzdCByZWFkIGZyb20gaGFyZHdhcmUgaXMgYSBuby1v
cC4NCg0KU2luY2UgdGhpcyByZWFkIGlzIG9ubHkgYXQgcHJvYmluZywgYXQgbGVhc3QgZm9yIHRo
ZSBtb21lbnQsIGFuZCwgYXMgZmFyIGFzDQpJIHJlbWVtYmVyLCB0aGUgaWRlYSB3LyAuZ2V0X3N0
YXRlIHdhcyB0byByZWZsZWN0IGluIExpbnV4IHRoZSBzdGF0ZXMgb2YNClBXTXMgdGhhdCB3ZXJl
IHNldHVwIGJlZm9yZSBMaW51eCB0YWtlcyBjb250cm9sIChlLmcuIFBXTXMgc2V0dXAgaW4NCmJv
b3Rsb2FkZXJzKSBJIHRoaW5rIGl0IHdvdWxkIG5vIHByb2JsZW0gaWYgaXQgd291bGQgYmUgbm8t
b3BzIGluIHRoaXMNCnNjZW5hcmlvLiBJbiBjYXNlIG9mIHJ1bi10aW1lIHN0YXRlIHJldHJpZXZh
bCwgcHdtX2dldF9zdGF0ZSgpIHNob3VsZCBiZQ0KZW5vdWdoLiBJZiBvbmUgd291bGQgZ2V0IHRo
ZSBzdGF0ZSBwcmV2aW91c2x5IHNhdmVkIHcvIHRoaXMgLmdldF9zdGF0ZSBBUEkNCmhlL3NoZSB3
b3VsZCBjaGFuZ2UgaXQsIHRoZW4gaXQgd291bGQgYXBwbHkgdGhlIGNoYW5nZXMgdG8gdGhlIGhh
cmR3YXJlLiBObw0KY2hhbmdlcyBvZiBQV00gc3RhdGUgd291bGQgYmUgYW55d2F5IHNraXBwZWQg
ZnJvbSB0aGUgYmVnaW5uaW5nLCBpbg0KcHdtX2FwcGx5X3N0YXRlKCkgYnkgdGhpcyBjb2RlOg0K
DQogICAgICAgIGlmIChzdGF0ZS0+cGVyaW9kID09IHB3bS0+c3RhdGUucGVyaW9kICYmDQogICAg
ICAgICAgICBzdGF0ZS0+ZHV0eV9jeWNsZSA9PSBwd20tPnN0YXRlLmR1dHlfY3ljbGUgJiYNCgkg
ICAgc3RhdGUtPnBvbGFyaXR5ID09IHB3bS0+c3RhdGUucG9sYXJpdHkgJiYNCiAgICAgICAgICAg
IHN0YXRlLT5lbmFibGVkID09IHB3bS0+c3RhdGUuZW5hYmxlZCkNCgkJcmV0dXJuIDA7DQoNCkJ1
dCBtYXliZSBJJ20gbWlzc2luZyBzb21ldGhpbmcuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFV3
ZSBLbGVpbmUtS8O2bmlnIDx1d2VAa2xlaW5lLWtvZW5pZy5vcmc+DQo+IC0tLQ0KPiBOZXcgaW4g
djINCj4gDQo+ICBkcml2ZXJzL3B3bS9wd20tYXRtZWwuYyB8IDM5ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYyBiL2RyaXZlcnMv
cHdtL3B3bS1hdG1lbC5jDQo+IGluZGV4IDE1MmMyYjdkZDZkZi4uZjc4ODUwMWFiNmNhIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYw0KPiArKysgYi9kcml2ZXJzL3B3bS9w
d20tYXRtZWwuYw0KPiBAQCAtMjk1LDggKzI5NSw0NyBAQCBzdGF0aWMgaW50IGF0bWVsX3B3bV9h
cHBseShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20sDQo+ICAJ
cmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyB2b2lkIGF0bWVsX3B3bV9nZXRfc3RhdGUo
c3RydWN0IHB3bV9jaGlwICpjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0KPiArCQkJCXN0
cnVjdCBwd21fc3RhdGUgKnN0YXRlKQ0KPiArew0KPiArCXN0cnVjdCBhdG1lbF9wd21fY2hpcCAq
YXRtZWxfcHdtID0gdG9fYXRtZWxfcHdtX2NoaXAoY2hpcCk7DQo+ICsJdTMyIHNyLCBjbXI7DQo+
ICsNCj4gKwlzciA9IGF0bWVsX3B3bV9yZWFkbChhdG1lbF9wd20sIFBXTV9TUik7DQo+ICsJY21y
ID0gYXRtZWxfcHdtX2NoX3JlYWRsKGF0bWVsX3B3bSwgcHdtLT5od3B3bSwgUFdNX0NNUik7DQo+
ICsNCj4gKwlpZiAoc3IgJiAoMSA8PCBwd20tPmh3cHdtKSkgew0KPiArCQl1bnNpZ25lZCBsb25n
IHJhdGUgPSBjbGtfZ2V0X3JhdGUoYXRtZWxfcHdtLT5jbGspOw0KPiArCQl1MzIgY2R0eSwgY3By
ZCwgcHJlczsgDQoNClRoZXJlIGlzIGEgd2hpdGVzcGFjZSBhdCB0aGUgZW5kIG9mIHRoaXMgbGlu
ZS4NCg0KPiArCQl1NjQgdG1wOw0KPiArDQo+ICsJCXByZXMgPSBjbXIgJiBQV01fQ01SX0NQUkVf
TVNLOw0KPiArDQo+ICsJCWNwcmQgPSBhdG1lbF9wd21fY2hfcmVhZGwoYXRtZWxfcHdtLCBwd20t
Pmh3cHdtLCBhdG1lbF9wd20tPmRhdGEtPnJlZ3MucGVyaW9kKTsNCg0KSWYgdGhpcyBpcyBwb3Nz
aWJsZSwgcGxlYXNlIHRyeSB0byBrZWVwIGl0IGF0IDgwIGNoYXJzIHBlciBsaW5lLiBJbiBteQ0K
b3BpbmlvbiB0aGlzIHN0aWxsIGxvb2tzIGdvb2Q6DQoJCWNwcmQgPSBhdG1lbF9wd21fY2hfcmVh
ZGwoYXRtZWxfcHdtLCBwd20tPmh3cHdtLA0KCQkJCQkgIGF0bWVsX3B3bS0+ZGF0YS0+cmVncy5w
ZXJpb2QpOw0KDQo+ICsJCXRtcCA9ICh1NjQpY3ByZCAqIE5TRUNfUEVSX1NFQzsNCj4gKwkJdG1w
IDw8PSBwcmVzOw0KPiArCQlzdGF0ZS0+cGVyaW9kID0gRElWNjRfVTY0X1JPVU5EX1VQKHRtcCwg
cmF0ZSk7DQo+ICsNCj4gKwkJY2R0eSA9IGF0bWVsX3B3bV9jaF9yZWFkbChhdG1lbF9wd20sIHB3
bS0+aHdwd20sIGF0bWVsX3B3bS0+ZGF0YS0+cmVncy5kdXR5KTsNCg0KRGl0dG8uDQoNCj4gKwkJ
dG1wID0gKHU2NCljZHR5ICogTlNFQ19QRVJfU0VDOw0KPiArCQl0bXAgPDw9IHByZXM7DQo+ICsJ
CXN0YXRlLT5kdXR5X2N5Y2xlID0gRElWNjRfVTY0X1JPVU5EX1VQKHRtcCwgcmF0ZSk7DQo+ICsN
Cj4gKwkJc3RhdGUtPmVuYWJsZWQgPSB0cnVlOw0KPiArCX0gZWxzZSB7DQo+ICsJCXN0YXRlLT5l
bmFibGVkID0gZmFsc2U7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKGNtciAmIFBXTV9DTVJfQ1BPTCkN
Cj4gKwkJc3RhdGUtPnBvbGFyaXR5ID0gUFdNX1BPTEFSSVRZX0lOVkVSU0VEOw0KPiArCWVsc2UN
Cj4gKwkJc3RhdGUtPnBvbGFyaXR5ID0gUFdNX1BPTEFSSVRZX05PUk1BTDsNCj4gKw0KPiArfQ0K
PiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHB3bV9vcHMgYXRtZWxfcHdtX29wcyA9IHsNCj4g
IAkuYXBwbHkgPSBhdG1lbF9wd21fYXBwbHksDQo+ICsJLmdldF9zdGF0ZSA9IGF0bWVsX3B3bV9n
ZXRfc3RhdGUsDQo+ICAJLm93bmVyID0gVEhJU19NT0RVTEUsDQo+ICB9Ow0KDQpPdGhlciB0aGFu
IHRoZSBtaW5vciB0aGluZ3MgYWJvdmUsDQpBY2tlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVk
aXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCj4gIA0KPiANCg==
