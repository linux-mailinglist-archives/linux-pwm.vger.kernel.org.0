Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAE392047
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2019 11:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHSJ1x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Aug 2019 05:27:53 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:47063 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSJ1w (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Aug 2019 05:27:52 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: lKrahjtZktp6lLRKIuXjAuDG5SqOtMg2cQLvVuYiPh+50sdsJOkK274zo3wZV6T1+NIxV5Kr80
 e1zUaHug/mQk8BjGD8PN3KEPucTZ+6z0ptpj2u8qqmJexiMxab6bUL+8sMOjzNWSWLaPQNTTPF
 gcftJXtRbwGY8bXNi7hrIkM54ZlYv0l8Mlloqb0LzXRB1ufFDx7YD6rgQMPsBs8D4U28YSadca
 ZryFWvgtLYE628q5Sb/zDfzwNdycExITFG6jP4oWXrbzvkrULwEJE3h3JSnCvC5RpFJq/OZd96
 ls4=
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="47022962"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2019 02:27:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 19 Aug 2019 02:27:51 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 19 Aug 2019 02:27:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqeGx9Ygui6Dmxz98HUL+Rc4pkxTFa2nhQ2hhPW2soFY/Dr9RX5jogiZDwdR0yny1rgWP73UfmZ38x2sBofDEPx9fvvV87sM2dDdosxHd+uOOs9z/UolZ3x7WptA74tmAfwS5JwTmRXFXRQyj8nFV/8K42UySA60Zjc4EoRJmTYBjdU2shiBWcsEIwGJhKpI8C+jx4kF+UgHsRHspkVCx9y/Tz0c8DIviGwr1if5jx3wg0wTgsPisuqqBjXbEq8NKZ2rjmwV572ArobqncRVA+FIdAVYywQCtWUSz7Lz1D+Gnl0EzqKrz6lXRB2UV0u0AoDHHTsiR0j6OiXg5pPazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP73nV1JuLQUgnXudhdinBOixtEbBUFrm3MheXjYSe4=;
 b=JwEffToCU/DEaLEIMZGsV3/Azx42z9gMU7I46iZQ5zYFmh7XMz1Vq07rAyUX6AbyXDDdjJZh6BfRqSHbItwgoQfQzwVhdBGUsxcMV33ZeqP+wKe9VnDFrM1RbkIoHPl5QLf4dpTyiF3CcN5xysYlxrNLuQfoph1DM/vQl8SyN2CT7Pq0kF+r1V2e2XiykvvfQIQG5ZEfB1I7HjACNmS4Zg+Gmk7+TsoPKqhgdk+EnraCIGfT/UCs9+yllSJVnXjM8Ovyb9z+Jegut81JfCLNkNdegxhWfmN90gc/IBrB1pP2F2xVhxiZMRwQijZPUDDXaIzzjY9w/8qG9O01jPCiIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP73nV1JuLQUgnXudhdinBOixtEbBUFrm3MheXjYSe4=;
 b=VRfcB8m9PKE2jK3EB/hzsUo4U5kQSzi8TnSlhExRxSHeRjBPYb8BlIfgxHVMLyPOSDTX5GLrzfqBI1OvpwvL5PKEkRZ6OyYUT+5FCe09W1hoL2bV5vWT9ixTT2CdpLxiZd/msZFcVr1cMlStYBFo0Sr5bue30o/W1jiqqoU3sks=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1840.namprd11.prod.outlook.com (10.175.55.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 09:27:49 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::512b:adf0:597f:3dec]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::512b:adf0:597f:3dec%11]) with mapi id 15.20.2178.018; Mon, 19 Aug
 2019 09:27:49 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <uwe@kleine-koenig.org>, <thierry.reding@gmail.com>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 3/3] pwm: atmel: replace loop in prescale calculation by
 ad-hoc calculation
Thread-Topic: [PATCH 3/3] pwm: atmel: replace loop in prescale calculation by
 ad-hoc calculation
Thread-Index: AQHVU7JOhM9gxlZlVEG6dlqRurI3lqcCOUuA
Date:   Mon, 19 Aug 2019 09:27:49 +0000
Message-ID: <6bc48dde-e6ff-c2c5-1fd0-11a10862eb7a@microchip.com>
References: <20190815214133.11134-1-uwe@kleine-koenig.org>
 <20190815214133.11134-3-uwe@kleine-koenig.org>
In-Reply-To: <20190815214133.11134-3-uwe@kleine-koenig.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0144.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::37) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190819122739240
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9244b7e0-6b0d-4c5e-d0c7-08d724878068
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1840;
x-ms-traffictypediagnostic: MWHPR11MB1840:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB18400E851190399471E1902087A80@MWHPR11MB1840.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(346002)(396003)(189003)(199004)(5660300002)(14454004)(6246003)(31686004)(478600001)(186003)(52116002)(76176011)(66574012)(7736002)(305945005)(53546011)(102836004)(6486002)(6436002)(229853002)(26005)(386003)(6512007)(6506007)(2616005)(11346002)(476003)(86362001)(446003)(25786009)(486006)(4326008)(31696002)(66066001)(14444005)(256004)(66446008)(99286004)(66946007)(66476007)(66556008)(71200400001)(71190400001)(64756008)(3846002)(6116002)(53936002)(316002)(36756003)(8676002)(81156014)(81166006)(8936002)(2906002)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1840;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 01bo6cc7b5VhePbL5thxIpQQh5zfm6/9PYTo2/YSMOkTqtDOMuO6TCynnSGYcE9Z5xnEByO6uqopfpw5f50mk6UVuOemnNVZHSAtTQwS8KwguDM2xEO/40f3f/AxuEOpphXZVwJkN+0YroPpQ66M4gK0tGFUmlT1J1O6qukLFPIz6IC/u9DLgQFLDoy+RN/NDmRdaxa6Hle8A0YmJvOu4c0skbf6JLvwu3Any5jRNDrIWLopCvGM7T0VhTnGO3IuNRkCPozrDK8RdNQIATxuqMe52lV+2Jfo++pxz133IaOvTMTABxoPQi5ZXS175O/Bj8qkAixl16jZKnxBrsZtLQEcR37B24GadvFXuf74iPcsCpYzIQ41KWTKC+R8KCDjL+g9VImYtnl6CQy3WpjBKRxhYixrwAhUODOtm7NFHhM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4772937B258F0941B111A2C82EC805CD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9244b7e0-6b0d-4c5e-d0c7-08d724878068
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 09:27:49.1631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6M0ExmlnuLvZb5LNc/+aPjQgz92/FXhe0N7r0+ShryYYXW4ug3wewZPQPZqza+1ilxKWh6C19jmuLs+hB8MMNw+Xl/XZy5CnbrTmzwPNme4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1840
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQoNCk9uIDE2LjA4LjIwMTkgMDA6NDEsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBFeHRl
cm5hbCBFLU1haWwNCj4gDQo+IA0KPiBUaGUgY2FsY3VsYXRlZCB2YWx1ZXMgYXJlIHRoZSBzYW1l
IHdpdGggdGhlIG1vZGlmaWVkIGFsZ29yaXRobS4gVGhlIG9ubHkNCj4gZGlmZmVyZW5jZSBpcyB0
aGF0IHRoZSBjYWxjdWxhdGlvbiBpcyBhIGJpdCBtb3JlIGVmZmljaWVudC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1d2VAa2xlaW5lLWtvZW5pZy5vcmc+DQoNCkFj
a2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0K
VGVzdGVkIG9uIFNBTUE1RDJfWHBsYWluZWQuDQoNCj4gLS0tDQo+ICBkcml2ZXJzL3B3bS9wd20t
YXRtZWwuYyB8IDI0ICsrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDE3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wd20vcHdtLWF0bWVsLmMgYi9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYw0KPiBpbmRleCBk
N2E2ZDMyYjU3NzQuLjQyZmU3YmMwNDNhOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wd20vcHdt
LWF0bWVsLmMNCj4gKysrIGIvZHJpdmVycy9wd20vcHdtLWF0bWVsLmMNCj4gQEAgLTYwLDcgKzYw
LDcgQEAgc3RydWN0IGF0bWVsX3B3bV9yZWdpc3RlcnMgew0KPiAgfTsNCj4gIA0KPiAgc3RydWN0
IGF0bWVsX3B3bV9jb25maWcgew0KPiAtCXUzMiBtYXhfcGVyaW9kOw0KPiArCXUzMiBwZXJpb2Rf
Yml0czsNCj4gIH07DQo+ICANCj4gIHN0cnVjdCBhdG1lbF9wd21fZGF0YSB7DQo+IEBAIC0xMTks
MTcgKzExOSwyNyBAQCBzdGF0aWMgaW50IGF0bWVsX3B3bV9jYWxjdWxhdGVfY3ByZF9hbmRfcHJl
cyhzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsDQo+ICB7DQo+ICAJc3RydWN0IGF0bWVsX3B3bV9jaGlw
ICphdG1lbF9wd20gPSB0b19hdG1lbF9wd21fY2hpcChjaGlwKTsNCj4gIAl1bnNpZ25lZCBsb25n
IGxvbmcgY3ljbGVzID0gc3RhdGUtPnBlcmlvZDsNCj4gKwlpbnQgc2hpZnQ7DQo+ICANCj4gIAkv
KiBDYWxjdWxhdGUgdGhlIHBlcmlvZCBjeWNsZXMgYW5kIHByZXNjYWxlIHZhbHVlICovDQo+ICAJ
Y3ljbGVzICo9IGNsa19nZXRfcmF0ZShhdG1lbF9wd20tPmNsayk7DQo+ICAJZG9fZGl2KGN5Y2xl
cywgTlNFQ19QRVJfU0VDKTsNCj4gIA0KPiAtCWZvciAoKnByZXMgPSAwOyBjeWNsZXMgPiBhdG1l
bF9wd20tPmRhdGEtPmNmZy5tYXhfcGVyaW9kOyBjeWNsZXMgPj49IDEpDQo+IC0JCSgqcHJlcykr
KzsNCj4gKwkvKg0KPiArCSAqIFRoZSByZWdpc3RlciBmb3IgdGhlIHBlcmlvZCBsZW5ndGggaXMg
Y2ZnLnBlcmlvZF9iaXRzIGJpdHMgd2lkZS4NCj4gKwkgKiBTbyBmb3IgZWFjaCBiaXQgdGhlIG51
bWJlciBvZiBjbG9jayBjeWNsZXMgaXMgd2lkZXIgZGl2aWRlIHRoZSBpbnB1dA0KPiArCSAqIGNs
b2NrIGZyZXF1ZW5jeSBieSB0d28gdXNpbmcgcHJlcyBhbmQgc2hpZnQgY3ByZCBhY2NvcmRpbmds
eS4NCj4gKwkgKi8NCj4gKwlzaGlmdCA9IGZscyhjeWNsZXMpIC0gYXRtZWxfcHdtLT5kYXRhLT5j
ZmcucGVyaW9kX2JpdHM7DQo+ICANCj4gLQlpZiAoKnByZXMgPiBQV01fTUFYX1BSRVMpIHsNCj4g
KwlpZiAoc2hpZnQgPiBQV01fTUFYX1BSRVMpIHsNCj4gIAkJZGV2X2VycihjaGlwLT5kZXYsICJw
cmVzIGV4Y2VlZHMgdGhlIG1heGltdW0gdmFsdWVcbiIpOw0KPiAgCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gKwl9IGVsc2UgaWYgKHNoaWZ0ID4gMCkgew0KPiArCQkqcHJlcyA9IHNoaWZ0Ow0KPiArCQlj
eWNsZXMgPj49ICpwcmVzOw0KPiArCX0gZWxzZSB7DQo+ICsJCSpwcmVzID0gMDsNCj4gIAl9DQo+
ICANCj4gIAkqY3ByZCA9IGN5Y2xlczsNCj4gQEAgLTI4OSw3ICsyOTksNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGF0bWVsX3B3bV9kYXRhIGF0bWVsX3NhbTlybF9wd21fZGF0YSA9IHsNCj4gIAl9
LA0KPiAgCS5jZmcgPSB7DQo+ICAJCS8qIDE2IGJpdHMgdG8ga2VlcCBwZXJpb2QgYW5kIGR1dHku
ICovDQo+IC0JCS5tYXhfcGVyaW9kCT0gMHhmZmZmLA0KPiArCQkucGVyaW9kX2JpdHMJPSAxNiwN
Cj4gIAl9LA0KPiAgfTsNCj4gIA0KPiBAQCAtMzAyLDcgKzMxMiw3IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgYXRtZWxfcHdtX2RhdGEgYXRtZWxfc2FtYTVfcHdtX2RhdGEgPSB7DQo+ICAJfSwNCj4g
IAkuY2ZnID0gew0KPiAgCQkvKiAxNiBiaXRzIHRvIGtlZXAgcGVyaW9kIGFuZCBkdXR5LiAqLw0K
PiAtCQkubWF4X3BlcmlvZAk9IDB4ZmZmZiwNCj4gKwkJLnBlcmlvZF9iaXRzCT0gMTYsDQo+ICAJ
fSwNCj4gIH07DQo+ICANCj4gQEAgLTMxNSw3ICszMjUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGF0bWVsX3B3bV9kYXRhIG1jaHBfc2FtOXg2MF9wd21fZGF0YSA9IHsNCj4gIAl9LA0KPiAgCS5j
ZmcgPSB7DQo+ICAJCS8qIDMyIGJpdHMgdG8ga2VlcCBwZXJpb2QgYW5kIGR1dHkuICovDQo+IC0J
CS5tYXhfcGVyaW9kCT0gMHhmZmZmZmZmZiwNCj4gKwkJLnBlcmlvZF9iaXRzCT0gMzIsDQo+ICAJ
fSwNCj4gIH07DQo+ICANCj4gDQo=
