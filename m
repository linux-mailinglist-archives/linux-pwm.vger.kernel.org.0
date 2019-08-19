Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE9D9203F
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2019 11:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfHSJ0M (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Aug 2019 05:26:12 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:40189 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfHSJ0M (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Aug 2019 05:26:12 -0400
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
IronPort-SDR: soSDdSX25CCBB5HhEF4/xoANgQHhsvItnCNkd8/KTwc1xwF58aEcz9Lw2e3KL1UFhv60f95rX5
 gJ2pOK1Gs0oe13w7DQOPedjoVYcEUFGi+4cPenoLjAO+j0gYOUG6dTCpXfbY0ktN0DWNaT1YFL
 1t7KaPG20WdIdwfg9sRt5qeJoAXCZkkua50hb4NGf/Y8gzEJEeKaHJAWNeik1PYkpjJt9hlLwi
 p8lZr8VOFoxZgO2pvRLh+/nwLLkZ3ga3wwgjvwJAZE47WUVjQ52rUbRBcw77BzC+Mz9asyybKZ
 A5w=
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="45735447"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2019 02:26:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 19 Aug 2019 02:26:08 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 19 Aug 2019 02:26:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfeIY1gNma3M5NqVt6Z26aBd1kEMoqxOVYvSBm2eqn8STFVmxcLV2xnM51sPkVdhSIESStu/xajMNPraZ9hU+xJCL3lHD0PtpL8kXxw6Xznxb/ZnLUSsoPczlRBVqa5dlcmoOUvXf7fivJSF/GPldnAazq74s2TqJKAqhi1/WEtKnsset1r9l/uuy+K/MgS/wwyG0g7mT5elkUWxEFanMrgc1PMwoPxCTbeo3QE/EggzzxQFX6ZbNRfHO0cKx+0FDbxQTjZQZRTxywBnr9OWuaWmYoh+j9ZbDc4w7tF0bpg6wwtzl14rvKsLJaoOevGTodlm5WDiBzcb3j3VrDwqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdUcZTR68iUcIyHS59BxzhT0cGzoSe9abCRW9fuXQ2g=;
 b=ekKE2+b79UWfmToXUwi85P64TQGmk+Humozj42Ilrb9i01u4Go9lfujwVvWeC0O7o0GzDiVaf4nrprHKaUTH3Ajzta2TrZya+9WznyXd2yXVjCVnT5KUJXVs3tYR9Hmxd1hmEuTLC09kGJnGmFsLpPzUxudD4PXfXRD/rM6p8cOn2gbGD0oWBGUrAZT999l+nKGuEWE7Rn7No/2OkPqex63Q/PjbK7Bz1Qn1GL9MmTnbrR5RDDegVHX8tC8o3dt4WyRYCObG3msAFg8PVkprzi9J4wLWd2rG930UbJt8rXJCjatJ04w7QCLqn1bN4nPqqqm2e5oNGJJhnmW46qQ49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdUcZTR68iUcIyHS59BxzhT0cGzoSe9abCRW9fuXQ2g=;
 b=CkEqFlHIM61eiN+MJZMLgWFxerL0uTPeJ6yoSmQXqQANX7CHOVSvDp3W8fogQFpP+NH/GKQh7Gx4sTirsX6gmabpMCfUvpwrn0XrWqDYUqU0iICh/7XZCpggQjaD+EcERx77d2e1fmezq5F7UTD5ADkIHRr3biuus9+ubd0bp7Q=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1840.namprd11.prod.outlook.com (10.175.55.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 09:26:04 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::512b:adf0:597f:3dec]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::512b:adf0:597f:3dec%11]) with mapi id 15.20.2178.018; Mon, 19 Aug
 2019 09:26:04 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <uwe@kleine-koenig.org>, <thierry.reding@gmail.com>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 4/3] pwm: atmel: document known weaknesses of both
 hardware and software
Thread-Topic: [PATCH 4/3] pwm: atmel: document known weaknesses of both
 hardware and software
Thread-Index: AQHVVBZQeReo2YDDMkewE2K7XK4HfacCOAWA
Date:   Mon, 19 Aug 2019 09:26:04 +0000
Message-ID: <0a389abe-15ef-0e63-109f-2db4cb36f4b9@microchip.com>
References: <20190815214133.11134-1-uwe@kleine-koenig.org>
 <20190816093748.11769-1-uwe@kleine-koenig.org>
In-Reply-To: <20190816093748.11769-1-uwe@kleine-koenig.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0003.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::13) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190819122553922
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77d0cb42-6d09-437e-8d74-08d7248741e0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1840;
x-ms-traffictypediagnostic: MWHPR11MB1840:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1840AD0F9FBEDEC2A639FD4F87A80@MWHPR11MB1840.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(346002)(396003)(189003)(199004)(5660300002)(14454004)(6246003)(31686004)(966005)(478600001)(186003)(52116002)(76176011)(66574012)(7736002)(305945005)(53546011)(102836004)(6486002)(6436002)(6306002)(229853002)(26005)(386003)(6512007)(6506007)(2616005)(11346002)(476003)(86362001)(446003)(25786009)(486006)(4326008)(31696002)(66066001)(14444005)(256004)(66446008)(99286004)(66946007)(66476007)(66556008)(71200400001)(71190400001)(64756008)(3846002)(6116002)(53936002)(316002)(36756003)(8676002)(81156014)(81166006)(8936002)(2906002)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1840;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zRuMdnwqWoxS4XtM16NOEqJpXFh0o0I/8LHAPEQqR8gzKCV+33enX2L31sxeJsx6NCBx1MwDxl2jDwMVMyV4Rg8wY3vtGvkoLpF3eaS6DSlLjbFQy1AtSB+JKpj47pONJy+g+8iw8CkKRPtGD5qsLfYqqYIZ24JmSyaDJaicCq+SA48/5V+LwkUByBHATslY6Mc9vEEl0bE+fGhdyAo3toFMQnihVPrEs9NY7NMZCnAa4l5OvitkI7cSjykxjXmsH4/5UWw03gGQVfCWpowM4P9SpMExer8N1Zd16IK+7Z5BUqeFQJy3r3wbEWtb4lN4M7SdBwxX2UUkkjXFaT2cNnizT+YYwse7Asskmoan2WPOkq8+pq/KUf7pSlIwdlXo9QkCV1PLycv7o87T/wKZ1nHIm3Im5fhH25FwkRhj/10=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED9A3A50549A4D46B13CE83539DBA31A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d0cb42-6d09-437e-8d74-08d7248741e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 09:26:04.3483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iiBGarsKX4VsaLaekcyNICTnWLGjMptgNlcaWWKSHm6FxgEP58LqZKAr7lcxJXOrId4lDhB8zfxQ2QLP/fV3vnbiXJszgldbPoNIhmmLixI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1840
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQoNCk9uIDE2LjA4LjIwMTkgMTI6MzcsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBFeHRl
cm5hbCBFLU1haWwNCj4gDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8
dXdlQGtsZWluZS1rb2VuaWcub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvcHdtL3B3bS1hdG1lbC5j
IHwgMTAgKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYyBiL2RyaXZlcnMvcHdtL3B3
bS1hdG1lbC5jDQo+IGluZGV4IDQyZmU3YmMwNDNhOC4uMWRkYjkzZGI5NjI3IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYw0KPiArKysgYi9kcml2ZXJzL3B3bS9wd20tYXRt
ZWwuYw0KPiBAQCAtNyw2ICs3LDE2IEBADQo+ICAgKg0KPiAgICogUmVmZXJlbmNlIG1hbnVhbCBm
b3IgImF0bWVsLGF0OTFzYW05cmwtcHdtIjoNCj4gICAqICAgaHR0cDovL3d3MS5taWNyb2NoaXAu
Y29tL2Rvd25sb2Fkcy9lbi9EZXZpY2VEb2MvQXRtZWwtMTEwMzItMzItYml0LUFSTTkyNkVKLVMt
TWljcm9jb250cm9sbGVyLVNBTTlHMjVfRGF0YXNoZWV0LnBkZg0KPiArICoNCj4gKyAqIExpbWl0
YXRpb25zOg0KPiArICogLSBQZXJpb2RzIHN0YXJ0IHdpdGggdGhlIGluYWN0aXZlIGxldmVsLg0K
DQpBcmUgeW91IHRhbGtpbmcgaGVyZSBhYm91dCB0aGUgbm9ybWFsIHBvbGFyaXR5IChmcm9tIGRv
Y3VtZW50YXRpb246IEJ5DQpkZWZpbml0aW9uLCBub3JtYWwgcG9sYXJpdHkgY2hhcmFjdGVyaXpl
cyBhIHNpZ25hbCBzdGFydHMgaGlnaCBmb3IgdGhlDQpkdXJhdGlvbiBvZiB0aGUgZHV0eSBjeWNs
ZSBhbmQgZ29lcyBsb3cgZm9yIHRoZSByZW1haW5kZXIgb2YgdGhlIHBlcmlvZC4pDQoNCklmIHll
cywgdGhpcyBzaG91bGQgYmUgc29sdmVkIGJ5IHBsYXlpbmcgd2l0aCBDUE9MIGJpdCBvZiBDTVIu
DQoNCj4gKyAqIC0gSGFyZHdhcmUgaGFzIHRvIGJlIHN0b3BwZWQgaW4gZ2VuZXJhbCB0byB1cGRh
dGUgc2V0dGluZ3MuDQoNClNhbWE1ZDIgaGFzIGR1dHkgY3ljbGUgdGhhdCBjb3VsZCBiZSB1cGRh
dGVkIG9uIHRoZSBmbHkuDQoNCj4gKyAqDQo+ICsgKiBTb2Z0d2FyZSBidWdzL3Bvc3NpYmxlIGlt
cHJvdmVtZW50czoNCj4gKyAqIC0gV2hlbiBhdG1lbF9wd21fYXBwbHkoKSBpcyBjYWxsZWQgd2l0
aCBzdGF0ZS0+ZW5hYmxlZD1mYWxzZSBhIGNoYW5nZSBpbg0KPiArICogICBzdGF0ZS0+cG9sYXJp
dHkgaXNuJ3QgaG9ub3JlZC4NCg0KSSBrbm93IHRoYXQgd2hlbiBjb25maWd1cmluZyBhIFBXTSBv
bmUgc2hvdWxkIGdldCB0aGUgY3VycmVudCBzdGF0ZSBvZiB0aGUNClBXTSwgY2hhbmdlIGl0LCB0
aGVuIHBhc3MgaXQgdG8gdGhlIGRyaXZlciB2aWEgcHdtX2FwcGx5X3N0YXRlKCkuIEluIGNhc2UN
Cm9uZSB3b3VsZCBjYWxsIHRoZSBwd21fYXBwbHlfc3RhdGUoKSB3aXRoIHN0YXRlLT5lbmFibGVk
ID0gZmFsc2UgdGhlIHN0YXRlDQp3b3VsZCBiZSBzdG9yZWQgaW4gUFdNIHNwZWNpZmljIG9iamVj
dCAob2YgdHlwZSBzdHJ1Y3QgcHdtX2RldmljZSkuIE9uIHRoZQ0KbmV4dCBhcHBseSwgd2l0aCBl
bmFibGVkID0gdHJ1ZSwgYWxsIHRoZSBQV00gcGFyYW1ldGVycyB3b3VsZCBiZSBhY3R1YWxseQ0K
YXBwbGllZCB0byBoYXJkd2FyZS4gU28sIHVudGlsIGVuYWJsZT10cnVlIHRoZSBQV00gc3RhdGUg
d291bGQgb25seSBiZQ0KY2FjaGVkIGJ5IFBXTSBjb3JlIHNwZWNpZmljIG9iamVjdHMgKGluIHB3
bV9hcHBseV9zdGF0ZSgpKS4NCg0KPiArICogLSBJbnN0ZWFkIG9mIHNsZWVwaW5nIHRvIHdhaXQg
Zm9yIGEgY29tcGxldGVkIHBlcmlvZCwgdGhlIGludGVycnVwdA0KPiArICogICBmdW5jdGlvbmFs
aXR5IGNvdWxkIGJlIHVzZWQuDQo+ICAgKi8NCj4gIA0KPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5o
Pg0KPiANCg==
