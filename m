Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEBDB9236B
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2019 14:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfHSM3E (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Aug 2019 08:29:04 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:14548 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfHSM3D (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Aug 2019 08:29:03 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 8YDOLV9RSQRwmJfyhnaFS7XBMZes+xMj/gtCJYLFG4ls9Vvhynuyb/zfNtITf1eWjDss/lBs2n
 /a06nBa4T2N87dbqujqHSW0OkUjrf1BGjQi7PU8j8rtzi9UGcDLUKAQanLnWCz65xeDRvG5D68
 uAJIoR+j4UOgp/WAliZ7G+01eBX+AcP9Xe5uxc0AtfNTv7QEeHX5jvT9nuYFz1Oj30ONc6Q7hP
 bCpy/E0eslhnI8dn4CVihXMHOFVPcnNinZ3uSQlreRsQo+NZNc2n8WA5p6+JWbqpqHHI24wpG1
 izY=
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="44090717"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2019 05:29:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 19 Aug 2019 05:29:02 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 19 Aug 2019 05:29:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTW2uNzTJXvgjLOnml3mAAN3LrfcPma1sM6pVGPEikk7/xFwzxtRQMZKWuw8Ldgd/fVPYhhqz0AgkfA0ej/19TLFJB653n1KGUMR4ZvKH99iM8ZkHhzC+GGH5BFCNhGRG6MdAOLb0hK9OkD/8rL5TXAGTkWdbcmFe9zW6oCUXsW1NQzj2C4M+a3BpkW+jGe9DdqhOAvn3mvvV+I/p1Ozs1B184Av5mjdFU3X+cg35Jc8rBEG4aDoeQlvNFa99k8oXp4iYkilp1otgOb9KWxAbUE+yE+zGTIWGtRGz0O9mpuQOpnjDSEMsUtlK1hKxbJWZIc/J+MBrTsXUzfB8HMgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPb6+G70LRfX20bu/fi2CUxGJXjiXqPqgs29pu70Sao=;
 b=fNNa00Gy4jjcNgzFdviPzM8hJeHNGuJnsgWJ/h45g1TrdqhgH3mPYTH0Hwx3KzxTU3qopYSfiQdKlVtXJ9p1VnXnHI4bZXO5B9NsIgmIU1d6BceovYw3sok9frJQOmSmyupKKvXAPWhIIAs2f7ww9rYfwZ12rVzstqOT9vdWDAKEdc/pXXXcSSc6jJEl5Oltn7FXoyGtmde0HdDYiRo2QBcIx3QiEKJRrND+cYk+TikGIYTNNrQPCS/hNHwcZh28Lb5vYEeJpvvtOxAlPrHr/cMRagDBb0R62xleJDVQqm5X9O4WIA7TBOrUZTFt9q3wK6ZwFa6kEsC8gMgou1D5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPb6+G70LRfX20bu/fi2CUxGJXjiXqPqgs29pu70Sao=;
 b=ZJMNVWVtE7i6PV3aPrsNM4dhDcTf1YvV6F90L4LUfjrQHQzkF5dU6Xr69VgmmdWJFs2leHDy6/FSNNmZ7aEI/PtZt1/CjGXPbqIbsgiKVG+wLj9L4KnSEeOH8O1YA6NycgZs8hqQSDYnNV4rqUNuJzmqGEf3ytmjMbjlCW3oyfI=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1887.namprd11.prod.outlook.com (10.175.50.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 12:29:00 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::512b:adf0:597f:3dec]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::512b:adf0:597f:3dec%11]) with mapi id 15.20.2178.018; Mon, 19 Aug
 2019 12:29:00 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>
CC:     <thierry.reding@gmail.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 4/3] pwm: atmel: document known weaknesses of both
 hardware and software
Thread-Topic: [PATCH 4/3] pwm: atmel: document known weaknesses of both
 hardware and software
Thread-Index: AQHVVBZQeReo2YDDMkewE2K7XK4HfacCOAWAgAAWdoCAABynAA==
Date:   Mon, 19 Aug 2019 12:28:59 +0000
Message-ID: <3029467b-be14-d78b-5580-8bd3842d86e2@microchip.com>
References: <20190815214133.11134-1-uwe@kleine-koenig.org>
 <20190816093748.11769-1-uwe@kleine-koenig.org>
 <0a389abe-15ef-0e63-109f-2db4cb36f4b9@microchip.com>
 <20190819104617.kujgwthxtjy6cssa@pengutronix.de>
In-Reply-To: <20190819104617.kujgwthxtjy6cssa@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0701CA0041.eurprd07.prod.outlook.com
 (2603:10a6:800:90::27) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190819152850369
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f01ef5b-275a-4756-b81d-08d724a0cfd4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1887;
x-ms-traffictypediagnostic: MWHPR11MB1887:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB18878606DEFD31B90194E4BC87A80@MWHPR11MB1887.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39850400004)(396003)(376002)(346002)(189003)(199004)(53546011)(14454004)(11346002)(476003)(446003)(31686004)(4326008)(5660300002)(966005)(6116002)(3846002)(102836004)(486006)(26005)(305945005)(66066001)(76176011)(52116002)(81166006)(86362001)(81156014)(2616005)(316002)(99286004)(7736002)(8936002)(36756003)(54906003)(186003)(31696002)(8676002)(2906002)(66946007)(386003)(6506007)(66446008)(64756008)(66556008)(66476007)(25786009)(6436002)(229853002)(478600001)(66574012)(256004)(14444005)(6246003)(71190400001)(71200400001)(6916009)(6512007)(6306002)(53936002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1887;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JGRCc6IS6/yXkp23AoCJRWn0RlYhAk8tPYv37e7txDErVM3OjDkUxE+o7veqEzbltptmzq7czNRnpS/TllnwJ2VxTrK2W2Mamsv+OyD0s2vy2VHHLM81QArbyA3wCwtd+37I6fv5o9cd6h+q5kaX5khvSEb4lCcDWK6IuYpjpzEz7Mk3ESrKuk7q7gKMA4cxYmgxQ8L7YMAygknY8CtFYpb/o0cd196jNaBuBUyo3QMN3nS3K43BH0XbIgAMqlq+DcwraqmbsPNFvwzNvioMdG00Yv6V2h5C6bJBUlqIhMtGSoIRB25b1psEnnSE93fG/qJLuVsxNcYezSZuiCGCcrNn/nMANz6fWDKhDQPEAbSYpddm4f3z6sNBjekiZqpo8rhxfGIgKe4IaJQHnBpHtEXm331iUh+RDFlhC7NV9mg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <997F723013EEA34FAF558F7B04A29869@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f01ef5b-275a-4756-b81d-08d724a0cfd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 12:28:59.9135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWqp5Eu+NPpKeN/BE0zD+KQ78yxClwO6EytDFY4URxjM1Y7J2HxuafUvWK/TBZR8iv8lNKQV1em54wuXLCApI6uDEQK1Z4+ulA/P8ykgNAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1887
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQoNCk9uIDE5LjA4LjIwMTkgMTM6NDYsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBFeHRl
cm5hbCBFLU1haWwNCj4gDQo+IA0KPiBPbiBNb24sIEF1ZyAxOSwgMjAxOSBhdCAwOToyNjowNEFN
ICswMDAwLCBDbGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4NCj4+DQo+PiBP
biAxNi4wOC4yMDE5IDEyOjM3LCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4+PiBFeHRlcm5h
bCBFLU1haWwNCj4+Pg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcg
PHV3ZUBrbGVpbmUta29lbmlnLm9yZz4NCj4+PiAtLS0NCj4+PiAgZHJpdmVycy9wd20vcHdtLWF0
bWVsLmMgfCAxMCArKysrKysrKysrDQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLWF0bWVsLmMgYi9kcml2
ZXJzL3B3bS9wd20tYXRtZWwuYw0KPj4+IGluZGV4IDQyZmU3YmMwNDNhOC4uMWRkYjkzZGI5NjI3
IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC5jDQo+Pj4gKysrIGIvZHJp
dmVycy9wd20vcHdtLWF0bWVsLmMNCj4+PiBAQCAtNyw2ICs3LDE2IEBADQo+Pj4gICAqDQo+Pj4g
ICAqIFJlZmVyZW5jZSBtYW51YWwgZm9yICJhdG1lbCxhdDkxc2FtOXJsLXB3bSI6DQo+Pj4gICAq
ICAgaHR0cDovL3d3MS5taWNyb2NoaXAuY29tL2Rvd25sb2Fkcy9lbi9EZXZpY2VEb2MvQXRtZWwt
MTEwMzItMzItYml0LUFSTTkyNkVKLVMtTWljcm9jb250cm9sbGVyLVNBTTlHMjVfRGF0YXNoZWV0
LnBkZg0KPj4+ICsgKg0KPj4+ICsgKiBMaW1pdGF0aW9uczoNCj4+PiArICogLSBQZXJpb2RzIHN0
YXJ0IHdpdGggdGhlIGluYWN0aXZlIGxldmVsLg0KPj4NCj4+IEFyZSB5b3UgdGFsa2luZyBoZXJl
IGFib3V0IHRoZSBub3JtYWwgcG9sYXJpdHkgKGZyb20gZG9jdW1lbnRhdGlvbjogQnkNCj4+IGRl
ZmluaXRpb24sIG5vcm1hbCBwb2xhcml0eSBjaGFyYWN0ZXJpemVzIGEgc2lnbmFsIHN0YXJ0cyBo
aWdoIGZvciB0aGUNCj4+IGR1cmF0aW9uIG9mIHRoZSBkdXR5IGN5Y2xlIGFuZCBnb2VzIGxvdyBm
b3IgdGhlIHJlbWFpbmRlciBvZiB0aGUgcGVyaW9kLikNCj4gDQo+IFdoZW4gLnBvbGFyaXR5ID0g
UFdNX1BPTEFSSVRZX05PUk1BTCBpcyBwYXNzZWQgdG8gYXRtZWxfcHdtX2FwcGx5KCkgdGhlDQo+
IGRyaXZlcnMgc2V0cyBQV01fQ01SX0NQT0w9MCB3aGljaCBhY2NvcmRpbmcgdG8gdGhlIGRhdGFz
aGVldCAobGlua2VkDQo+IGFib3ZlKSBtZWFuczogIlRoZSBvdXRwdXQgd2F2ZWZvcm0gc3RhcnRz
IGF0IGEgbG93IGxldmVsLiINCj4gDQo+IFNvIG1heWJlIGp1c3QgdGhlIGxvZ2ljIGhhcyB0byBi
ZSBpbnZlcnRlZCB0aGVyZSwNCg0KQWdyZWUuDQoNCj4gYnV0IHRoZW4gbWF5YmUgdGhlDQo+IG91
dHB1dCBnZXRzIGFjdGl2ZSBpbnN0ZWFkIG9mIGluYWN0aXZlIHdoZW4gdGhlIFBXTSBpcyBkaXNh
YmxlZC4NCg0KWWVzLCB0aGlzIHdvdWxkIGhhcHBlbi4gUGxheWluZyBhZ2FpbiB3aXRoIENQT0wg
d2hlbiBkaXNhYmxpbmcgbWF5IGJlIGENCnNvbHV0aW9uLg0KDQo+IChXaGljaCBpbiBteSBib29r
IGlzIG9rLCBidXQgaXQncyBUaGllcnJ5J3Mgb3BpbmlvbiB0aGF0IGNvdW50cyBoZXJlLikNCj4g
DQo+PiBJZiB5ZXMsIHRoaXMgc2hvdWxkIGJlIHNvbHZlZCBieSBwbGF5aW5nIHdpdGggQ1BPTCBi
aXQgb2YgQ01SLg0KPj4NCj4+PiArICogLSBIYXJkd2FyZSBoYXMgdG8gYmUgc3RvcHBlZCBpbiBn
ZW5lcmFsIHRvIHVwZGF0ZSBzZXR0aW5ncy4NCj4+DQo+PiBTYW1hNWQyIGhhcyBkdXR5IGN5Y2xl
IHRoYXQgY291bGQgYmUgdXBkYXRlZCBvbiB0aGUgZmx5Lg0KPiANCj4gVGhlcmUgaXMgc29tZSBm
dW5jdGlvbmFsaXR5IGluIHRoZSA5RzI1LCB0b28uIEkgZGlkbid0IHVuZGVyc3RhbmQgaXQNCj4g
Y29tcGxldGVseSBidXQgbWF5YmUgaXQgb25seSBoZWxwcyB1cGRhdGluZyBvbmUgb2YgcGVyaW9k
IG9yIGR1dHkgY3ljbGUuDQo+ICANCj4+PiArICoNCj4+PiArICogU29mdHdhcmUgYnVncy9wb3Nz
aWJsZSBpbXByb3ZlbWVudHM6DQo+Pj4gKyAqIC0gV2hlbiBhdG1lbF9wd21fYXBwbHkoKSBpcyBj
YWxsZWQgd2l0aCBzdGF0ZS0+ZW5hYmxlZD1mYWxzZSBhIGNoYW5nZSBpbg0KPj4+ICsgKiAgIHN0
YXRlLT5wb2xhcml0eSBpc24ndCBob25vcmVkLg0KPj4NCj4+IEkga25vdyB0aGF0IHdoZW4gY29u
ZmlndXJpbmcgYSBQV00gb25lIHNob3VsZCBnZXQgdGhlIGN1cnJlbnQgc3RhdGUgb2YgdGhlDQo+
PiBQV00sIGNoYW5nZSBpdCwgdGhlbiBwYXNzIGl0IHRvIHRoZSBkcml2ZXIgdmlhIHB3bV9hcHBs
eV9zdGF0ZSgpLg0KPiANCj4gVGhhdCBzZWVtcyB0byBiZSBhIGNvbW1vbiBwYXR0ZXJuIGF0IGxl
YXN0LiBJTUhPIGxldHRpbmcgdGhlIGNvbnN1bWVyDQo+IGp1c3QgY29uZmlndXJlIHRoZSBzdGF0
ZSB0aGF0IHNob3VsZCBiZSB1c2VkIHNob3VsZCBiZSBmaW5lLCB0b28uPg0KPj4gSW4gY2FzZSBv
bmUgd291bGQgY2FsbCB0aGUgcHdtX2FwcGx5X3N0YXRlKCkgd2l0aCBzdGF0ZS0+ZW5hYmxlZCA9
DQo+PiBmYWxzZSB0aGUgc3RhdGUgd291bGQgYmUgc3RvcmVkIGluIFBXTSBzcGVjaWZpYyBvYmpl
Y3QgKG9mIHR5cGUgc3RydWN0DQo+PiBwd21fZGV2aWNlKS4gT24gdGhlIG5leHQgYXBwbHksIHdp
dGggZW5hYmxlZCA9IHRydWUsIGFsbCB0aGUgUFdNDQo+PiBwYXJhbWV0ZXJzIHdvdWxkIGJlIGFj
dHVhbGx5IGFwcGxpZWQgdG8gaGFyZHdhcmUuIFNvLCB1bnRpbA0KPj4gZW5hYmxlPXRydWUgdGhl
IFBXTSBzdGF0ZSB3b3VsZCBvbmx5IGJlIGNhY2hlZCBieSBQV00gY29yZSBzcGVjaWZpYw0KPj4g
b2JqZWN0cyAoaW4gcHdtX2FwcGx5X3N0YXRlKCkpLg0KPiANCj4gSSBmYWlsIHRvIGZvbGxvdyB3
aGF0IHlvdSBtZWFuIGhlcmUuIElmIGEgUFdNIHJ1bnMgd2l0aCAoc2F5KSBub3JtYWwNCj4gcG9s
YXJpdHkgYW5kIHlvdSBjYWxsIHB3bV9hcHBseV9zdGF0ZShteXB3bSwgeyAucG9sYXJpdHkgPQ0K
PiBQV01fUE9MQVJJVFlfSU5WRVJTRUQsIC5lbmFibGVkID0gZmFsc2UsIH0pOyB0aGUgYXBwbHkg
Y2FsbGJhY2sgb2YgdGhlDQo+IGxvd2xldmVsIGRyaXZlciBpcyBjYWxsZWQgYW5kIHN1cHBvc2Vk
IHRvIGNvbmZpZ3VyZSB0aGUgb3V0cHV0IHRvIHlpZWxkDQo+IGEgY29uc3RhbnQgaGlnaC4NCg0K
T2ssIEkgc2VlIGl0IG5vdy4gSSdsbCBwdXQgaXQgb24gbXkgcXVldWUuDQoNClRoYW5rIHlvdSwN
CkNsYXVkaXUgQmV6bmVhDQoNCj4gDQo+Pj4gKyAqIC0gSW5zdGVhZCBvZiBzbGVlcGluZyB0byB3
YWl0IGZvciBhIGNvbXBsZXRlZCBwZXJpb2QsIHRoZSBpbnRlcnJ1cHQNCj4+PiArICogICBmdW5j
dGlvbmFsaXR5IGNvdWxkIGJlIHVzZWQuDQo+Pj4gICAqLw0KPj4+ICANCj4+PiAgI2luY2x1ZGUg
PGxpbnV4L2Nsay5oPg0KPj4+DQo+IA0KPiBCZXN0IHJlZ2FyZHMNCj4gVXdlDQo+IA0K
