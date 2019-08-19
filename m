Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BACB892045
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2019 11:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfHSJ10 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Aug 2019 05:27:26 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:21204 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSJ1Z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Aug 2019 05:27:25 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 63NIcoqWHk3gbC3ELwk1n2W+enSt/F45rbP9XgSmbPSXJ7By0N5HCUu7+wkhpylKSySgfRYDwV
 XYqzD5zL9DPUbAdYY/4hH7lJnPo+BjbhpSIA46OH6wycmAYAo3lFV/sumBSO/b7DCb92Y6UqnB
 2iPbmSYhm5U+1CqfoOZU040nvQPrJ/sjX1ldkgVYeLsG5moNKESTvBT70Py9g6gEYD5P1P9tCB
 JTRI6lKjUD8GE30A5Awy5MespB61kL+DK/CorTzxgHHSbq9PT0He7VveSI6rAiRlyx+BUn1Cx4
 VGA=
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="45651718"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2019 02:27:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 19 Aug 2019 02:27:23 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 19 Aug 2019 02:27:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nazym0cWFC+UQF4gKciQg44QmGJehntWxt1EJPMRON+4Ozi/FboAx1F3f3y5+/Q7urMV8E5aSi8OpwvOj2+7AP5cv7P6mYtmV4XMvdo4HjpK0AEIj0qnmO2pUO3Tvl/vtzGoHPEPG7uhPf/aUAXmDNwmGPWAMu9zd+C0nw8MTTmZhDXYVaIPY/E+jw2fZ38JdH43RV9VrWA10nkvtXJWjVpbvm/y26ADItPtFf/a0LnWc7em5kqntMYFNJaA45e2SP5dhUqo8p89lT7zCggNdhXElMqiIosoGu9IqhgTMqWm8rD07Lau4DLf358hGMjDqVBKJQncxq/hWYdomQt7IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR+cWYLOEeq9AUc4LcBFeyNZtKtdaOiAwosRqbuaSBk=;
 b=NIYrTgIFxYWiTfWDxDhc4INnGiFXcX3tnxiZzAqcO6aP3pAVC3b3frKyFwVlxHnSr1T6XU46fiDDyz7HZ2Nr1OXLgEosKztDbNd85hGpM6PMJMbBHERkpGCykMf5+Hc282a/Ribon6es9ZA4eps7mNebem53dFDk1JeXaQkiO95cb9U4FAm5Gn8hjp80KrdAcEVV/Tg2OzdxiQ51BH57BHHk91zS3ONavC5qeSs+k4Uks2FEFrMogBEwngxiujGCKwNU1IG+jaUbwyuirlANEaXK0wwvPRvwTi+t6bXp8cocH4BW8ckaNOlKDN/JMq2GhWR7uzRM3rBSmeUBuDd2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR+cWYLOEeq9AUc4LcBFeyNZtKtdaOiAwosRqbuaSBk=;
 b=nzj9xO9supsOgxAjGdkzivpfxhvKgpzIxLcfoMHtt6+PNEatetoYw+pxzu/IrcYO9JwUpatIoPdnsBINAeGWPUk+BFGCKoXmE4SRVUaWmlWLUODRqbA66Su6UsDuXZKB/j17WxlcH4g/9ZU/E2U0hQ6gtrYyWZL2pcx1DvWzFqQ=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1840.namprd11.prod.outlook.com (10.175.55.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 09:27:23 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::512b:adf0:597f:3dec]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::512b:adf0:597f:3dec%11]) with mapi id 15.20.2178.018; Mon, 19 Aug
 2019 09:27:23 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <uwe@kleine-koenig.org>, <thierry.reding@gmail.com>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 2/3] pwm: atmel: use a constant for maximum prescale value
Thread-Topic: [PATCH 2/3] pwm: atmel: use a constant for maximum prescale
 value
Thread-Index: AQHVU7JNlI8LP8fm1keXWjHQ+MFN/qcCOS0A
Date:   Mon, 19 Aug 2019 09:27:23 +0000
Message-ID: <65d0bea5-b1f2-d0d3-509f-944551cb9ec2@microchip.com>
References: <20190815214133.11134-1-uwe@kleine-koenig.org>
 <20190815214133.11134-2-uwe@kleine-koenig.org>
In-Reply-To: <20190815214133.11134-2-uwe@kleine-koenig.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0155.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::48) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190819122714058
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b509e94e-4ba1-4034-ce4b-08d7248770ec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1840;
x-ms-traffictypediagnostic: MWHPR11MB1840:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1840D3C7E4F7EE6F0D742C7087A80@MWHPR11MB1840.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(346002)(396003)(189003)(199004)(5660300002)(14454004)(6246003)(31686004)(478600001)(186003)(52116002)(76176011)(66574012)(7736002)(305945005)(53546011)(102836004)(6486002)(6436002)(229853002)(26005)(386003)(6512007)(6506007)(2616005)(11346002)(476003)(86362001)(446003)(25786009)(486006)(4326008)(31696002)(66066001)(14444005)(256004)(66446008)(99286004)(66946007)(66476007)(66556008)(71200400001)(71190400001)(64756008)(3846002)(6116002)(53936002)(316002)(36756003)(8676002)(81156014)(81166006)(8936002)(2906002)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1840;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zCLde+pioUFR4ym8Jt472NPHFh4L+xddMXErZ+Ocw7njCynymmIVQHNY8YbxuWber0mbuzGgmYVxKWGrmUUu7hh7dttpGIbftc+5mDH6W4tRkTJUX/zrYDktmIsbrrlrq9YihxwmTPLdbc2IvDuZuYVJKog/DMncqWLOnLc9mzWhVvwjsRNBdqtC6e7ZMXheaisOh3pj1NX7YYQLlPjMtBPmLu5KkGkcCYQQQTXOTGrVGpgCU32FL+ScLFww6c9O9d2iiFup3sZW4KVnQ7gkIgbTUkr+aoxEPyJ7/rG1XpwDpH66iFFkPjf4KPZVwnlpZN4AhTbZie7mDPcGc5tjgDwsGW/ZtY2V2e09IFXa7GBddLKc8ZSo6himIT7/SqcZ7hCKGEQM4ZDoWhfa4dRmTGFbFdLuzgr6sI0Hwo2se98=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0EC598242FF2442BC0A18C3FE9DF68A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b509e94e-4ba1-4034-ce4b-08d7248770ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 09:27:23.1306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMl0cjhUZ95oiMC67PacE6XCCGTxSGYKZEFHDqwO+xBUFk7Zs8I51mIxCgFji63wGS+w5gEJlSmeybT+0zss0bMgzSylosNpDp9j4tFk19A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1840
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQoNCk9uIDE2LjA4LjIwMTkgMDA6NDEsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBFeHRl
cm5hbCBFLU1haWwNCj4gDQo+IA0KPiBUaGUgbWF4aW1hbCBwcmVzY2FsZSB2YWx1ZSBpcyAxMCBm
b3IgYWxsIHN1cHBvcnRlZCB2YXJpYW50cy4gU28gZHJvcCB0aGUNCj4gbWVtYmVyIGluIHRoZSB2
YXJpYW50IGRlc2NyaXB0aW9uIGFuZCBpbnRyb2R1Y2UgYSBnbG9iYWwgY29uc3RhbnQgaW5zdGVh
ZC4NCj4gDQo+IFRoaXMgcmVkdWNlcyB0aGUgc2l6ZSBvZiB0aGUgdmFyaWFudCBkZXNjcmlwdGlv
bnMgYW5kIHRoZSAuYXBwbHkoKSBjYWxsYmFjaw0KPiBjYW4gYmUgY29tcGlsZWQgYSBiaXQgbW9y
ZSBlZmZlY3RpdmVseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1
d2VAa2xlaW5lLWtvZW5pZy5vcmc+DQoNCkFja2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRp
dS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KVGVzdGVkIG9uIFNBTUE1RDJfWHBsYWluZWQuDQoN
Cj4gLS0tDQo+ICBkcml2ZXJzL3B3bS9wd20tYXRtZWwuYyB8IDggKysrLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wd20vcHdtLWF0bWVsLmMgYi9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYw0K
PiBpbmRleCBhYzNkN2EyMDBiOWUuLmQ3YTZkMzJiNTc3NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9wd20vcHdtLWF0bWVsLmMNCj4gKysrIGIvZHJpdmVycy9wd20vcHdtLWF0bWVsLmMNCj4gQEAg
LTUwLDYgKzUwLDggQEANCj4gICNkZWZpbmUgUFdNVjJfQ1BSRAkJMHgwQw0KPiAgI2RlZmluZSBQ
V01WMl9DUFJEVVBECQkweDEwDQo+ICANCj4gKyNkZWZpbmUgUFdNX01BWF9QUkVTCQkxMA0KPiAr
DQo+ICBzdHJ1Y3QgYXRtZWxfcHdtX3JlZ2lzdGVycyB7DQo+ICAJdTggcGVyaW9kOw0KPiAgCXU4
IHBlcmlvZF91cGQ7DQo+IEBAIC01OSw3ICs2MSw2IEBAIHN0cnVjdCBhdG1lbF9wd21fcmVnaXN0
ZXJzIHsNCj4gIA0KPiAgc3RydWN0IGF0bWVsX3B3bV9jb25maWcgew0KPiAgCXUzMiBtYXhfcGVy
aW9kOw0KPiAtCXUzMiBtYXhfcHJlczsNCj4gIH07DQo+ICANCj4gIHN0cnVjdCBhdG1lbF9wd21f
ZGF0YSB7DQo+IEBAIC0xMjYsNyArMTI3LDcgQEAgc3RhdGljIGludCBhdG1lbF9wd21fY2FsY3Vs
YXRlX2NwcmRfYW5kX3ByZXMoc3RydWN0IHB3bV9jaGlwICpjaGlwLA0KPiAgCWZvciAoKnByZXMg
PSAwOyBjeWNsZXMgPiBhdG1lbF9wd20tPmRhdGEtPmNmZy5tYXhfcGVyaW9kOyBjeWNsZXMgPj49
IDEpDQo+ICAJCSgqcHJlcykrKzsNCj4gIA0KPiAtCWlmICgqcHJlcyA+IGF0bWVsX3B3bS0+ZGF0
YS0+Y2ZnLm1heF9wcmVzKSB7DQo+ICsJaWYgKCpwcmVzID4gUFdNX01BWF9QUkVTKSB7DQo+ICAJ
CWRldl9lcnIoY2hpcC0+ZGV2LCAicHJlcyBleGNlZWRzIHRoZSBtYXhpbXVtIHZhbHVlXG4iKTsN
Cj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICAJfQ0KPiBAQCAtMjg5LDcgKzI5MCw2IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgYXRtZWxfcHdtX2RhdGEgYXRtZWxfc2FtOXJsX3B3bV9kYXRhID0gew0K
PiAgCS5jZmcgPSB7DQo+ICAJCS8qIDE2IGJpdHMgdG8ga2VlcCBwZXJpb2QgYW5kIGR1dHkuICov
DQo+ICAJCS5tYXhfcGVyaW9kCT0gMHhmZmZmLA0KPiAtCQkubWF4X3ByZXMJPSAxMCwNCj4gIAl9
LA0KPiAgfTsNCj4gIA0KPiBAQCAtMzAzLDcgKzMwMyw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
YXRtZWxfcHdtX2RhdGEgYXRtZWxfc2FtYTVfcHdtX2RhdGEgPSB7DQo+ICAJLmNmZyA9IHsNCj4g
IAkJLyogMTYgYml0cyB0byBrZWVwIHBlcmlvZCBhbmQgZHV0eS4gKi8NCj4gIAkJLm1heF9wZXJp
b2QJPSAweGZmZmYsDQo+IC0JCS5tYXhfcHJlcwk9IDEwLA0KPiAgCX0sDQo+ICB9Ow0KPiAgDQo+
IEBAIC0zMTcsNyArMzE2LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhdG1lbF9wd21fZGF0YSBt
Y2hwX3NhbTl4NjBfcHdtX2RhdGEgPSB7DQo+ICAJLmNmZyA9IHsNCj4gIAkJLyogMzIgYml0cyB0
byBrZWVwIHBlcmlvZCBhbmQgZHV0eS4gKi8NCj4gIAkJLm1heF9wZXJpb2QJPSAweGZmZmZmZmZm
LA0KPiAtCQkubWF4X3ByZXMJPSAxMCwNCj4gIAl9LA0KPiAgfTsNCj4gIA0KPiANCg==
