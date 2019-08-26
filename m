Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E0D9CB6E
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Aug 2019 10:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfHZITp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Aug 2019 04:19:45 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:5276 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfHZITo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Aug 2019 04:19:44 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: Xl7IH3Ie0Ux2AjjIwDqzMIcPDZYGxY6oQOoN5J+SWFm2uymgH9WEOMJJxnWIDS3t8Hs/2lNIZd
 Uud6Zyi65s71mMZcWiZ0FFwujYZD3fuDrcbC0frENAaf2eZ1w6jaRm0MjvnPgIg+pWeZ75++P9
 IhlHPw3vaL8UgRDPWXp+GlY43p5GIy+VpiejkiYq5WLjCR0gLv59ZwrHlJPGsAdo+pe7aYjxQu
 vcovlyiiSP7CQ/czE5N0KmlXiEgRzIYXaOlOPz6hqH1SMAk1zM8j969NpItuIKJKvXC5DbTgUk
 iM0=
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="44969329"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2019 01:19:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Aug 2019 01:19:41 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 26 Aug 2019 01:19:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+Hm8YAYOk/3ZOrkWWi4nA7X09kiZ8FWegFniBECQGWeL19gSAVWzPM+M78tb+KpFKDt5Hl6rtVCeMpEr1XwkLVlVYTS6K1rdRUGDTh7GaHgcl8MuDZoAeoxdNOYNY8/uszx/fiAbOQoiHt2DaBh3FZ5HkSGKepKal3E0kIYXhVrMMOp4bVgY4aSvfUdboMS3RDTpFCbtsI1stDWNAuWCPRPG35cruAD/t1TUaW0kVwj1jPQZqVYR/Hiv5L2+9ag62EPRpCSFUIPfjBuOxYAtByYMOsOeaxSNkpLzPQopA+5O2HS0zF0jnv77aXMC05kxeAKPFkyQkq4Eq2g+7xC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PrT1Bfi/qgxOoEhURsfpLHYbWvTK3SWz8kIJYikq9M=;
 b=mLo+kQ4JHqP+Phzn+Taa7qMIraGq1gWsT0e7q+5iSG5NVeqNqTYgv56lm6M+81u1TS3lX0W/XKKCAy1oa3ATpNz/UM6f60uY88CHpblU749lxEmTVxYKswVY6d3PaEk9vkhH9BKrYUGDmJP+jR4teNSvF76vNvviq5cFHecilfK+1pwueiDzVOcfxKui9Pfu/eHAXPVbkJf1uU9EpHmyiLC+bDgpOeWPA0ltkjR/M5ZLP35lXhET3AgNXvcKhN3Eb3xuhLrFPix+CLBgilMPlDCqqiS+hGKp7ovwlZp4es33MBbUungDcrcoUPXs3JGa7yIzWluU1PioFueGvUy+Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PrT1Bfi/qgxOoEhURsfpLHYbWvTK3SWz8kIJYikq9M=;
 b=ac07Zrr3BSuk87d7+Lt3j7zf5MJi4LcgVxEvNrjj6t7yvdL7MwwGKLINvQGS3tAOXCcgQggRcwPTBjQTaDbGPxBJeGZJF2jzLQH2de9D+30jZC3fi8ZTdsHMaAupTiGqSDNgk6P9O9HGCebADUXL6AZqHZdvb5Ts5DcMYXxk2Wo=
Received: from MWHPR11MB1662.namprd11.prod.outlook.com (10.172.55.15) by
 MWHPR11MB1501.namprd11.prod.outlook.com (10.172.54.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Mon, 26 Aug 2019 08:19:38 +0000
Received: from MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::410a:9d4b:b1df:2134]) by MWHPR11MB1662.namprd11.prod.outlook.com
 ([fe80::410a:9d4b:b1df:2134%12]) with mapi id 15.20.2199.021; Mon, 26 Aug
 2019 08:19:37 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <uwe@kleine-koenig.org>, <Claudiu.Beznea@microchip.com>,
        <thierry.reding@gmail.com>
CC:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] pwm: atmel: Add a hint where to find hardware
 documentation
Thread-Topic: [PATCH v2 1/6] pwm: atmel: Add a hint where to find hardware
 documentation
Thread-Index: AQHVWhB7bx5c2fzBPkWHi9lIZ7RzVqcNGdYA
Date:   Mon, 26 Aug 2019 08:19:37 +0000
Message-ID: <be768ac4-fa2b-17f0-d98a-08617dea45d3@microchip.com>
References: <20190824001041.11007-1-uwe@kleine-koenig.org>
 <20190824001041.11007-2-uwe@kleine-koenig.org>
In-Reply-To: <20190824001041.11007-2-uwe@kleine-koenig.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0174.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::18) To MWHPR11MB1662.namprd11.prod.outlook.com
 (2603:10b6:301:e::15)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.41.198.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea228cdf-afb4-403c-82f9-08d729fe228e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1501;
x-ms-traffictypediagnostic: MWHPR11MB1501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1501835D6B29D3665223E15BE0A10@MWHPR11MB1501.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(186003)(305945005)(102836004)(8936002)(26005)(99286004)(7736002)(36756003)(6246003)(81166006)(2616005)(229853002)(52116002)(386003)(3846002)(76176011)(6116002)(54906003)(110136005)(53546011)(8676002)(256004)(6436002)(66446008)(64756008)(66556008)(66476007)(66946007)(5660300002)(476003)(11346002)(2906002)(71190400001)(14444005)(6506007)(446003)(86362001)(31696002)(25786009)(4326008)(31686004)(14454004)(6512007)(6486002)(478600001)(66574012)(71200400001)(486006)(81156014)(53936002)(316002)(66066001)(37363001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1501;H:MWHPR11MB1662.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rjGBMFYBCaWSiAobwA+HDCvPpZ8y5q9e8jB/tTtl08tODSbPvZx73HOTOCYcZt5q0pukHu2sK7sVJptzmn9kOmvh2VwlEelJt7aQIqTVv9/oq9PzSeZiI0Phigecn5c3GBP9ZP1hAiLmWvBOvn1sJ1r7xDxTsi8xYHwFX9c8f383xSHM5AJkRgqVtwAGezY1URUG0hycwAzDOxJM3lG28cRXY6C8v4v1a8gl10Pmy98jD1tP1nTrpB9LRc75F1SdfiYAz7DH7dutdLrRb9jYHMHrrkLdgPzA+0t3Yu7wGt0BtGfDQIxoEQMBSfWahPmARjsb0jcsHpsU6G45Teed0GtLUeytBgXLHZZVSRtVQh/Xx/WQv4DKp8+EleJ8IunTN6ntWitSeOnMdUBXqujxISAh966VbRwP40Qa63ikR34=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FC23A5051CF2243A0273BC335043A30@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ea228cdf-afb4-403c-82f9-08d729fe228e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 08:19:37.7300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8mbtwYA85yDDewafSOjUNmXgFsBGLcoBNVWh/H6p+Pnon+pfodq9yglS3r49X5mr5SdGhUIVyJaU5Wd8BQMKfn8ThNIu8tqQ9X8m7KjMrNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1501
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gMjQvMDgvMjAxOSBhdCAwMjoxMCwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IEV4dGVy
bmFsIEUtTWFpbA0KPiANCj4gDQo+IE1vc3QgTWljcm9jaGlwIChmb3JtZXJseSBBdG1lbCkgY2hp
cHMgaGF2ZSBwdWJsaWNseSBhdmFpbGFibGUgbWFudWFscy4NCj4gQSBjb21wcmVoZW5zaXZlIGxp
c3QgaXMgYWxyZWFkeSBjb250YWluZWQgaW4gdGhlIGRvY3VtZW50YXRpb24gZm9sZGVyLg0KPiBS
ZWZlcmVuY2UgdGhpcyBsaXN0IGluIHRoZSBoZWFkZXIgb2YgdGhlIGRyaXZlciB0byBhbGxvdyBy
ZXZpZXdlcnMgdG8NCj4gZmluZCB0aGUgcmVsZXZhbnQgbWFudWFscy4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1d2VAa2xlaW5lLWtvZW5pZy5vcmc+DQoNCkFja2Vk
LWJ5OiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQpUaGFua3Mg
VXdlIQ0KDQpCZXN0IHJlZ2FyZHMsDQogICBOaWNvbGFzDQoNCj4gLS0tDQo+IENoYW5nZXMgc2lu
Y2UgKGltcGxpY2l0KSB2MSBzZW50IHdpdGggTWVzc2FnZS1JZDoNCj4gMjAxOTA4MTUyMTQxMzMu
MTExMzQtMS11d2VAa2xlaW5lLWtvZW5pZy5vcmc6DQo+IA0KPiAgIC0gT25seSByZWZlcmVuY2Ug
RG9jdW1lbnRhdGlvbi9hcm0vbWljcm9jaGlwLnJzdCBpbnN0ZWFkIG9mIHN0YXJ0aW5nDQo+ICAg
ICBhbm90aGVyIGxpc3Qgb2YgbGlua3MNCj4gDQo+ICAgZHJpdmVycy9wd20vcHdtLWF0bWVsLmMg
fCAzICsrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYyBiL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC5j
DQo+IGluZGV4IGU1ZTFlYWYzNzJmYS4uYTYxYTMwZmE4YjdlIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3B3bS9wd20tYXRtZWwuYw0KPiArKysgYi9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYw0KPiBA
QCAtNCw2ICs0LDkgQEANCj4gICAgKg0KPiAgICAqIENvcHlyaWdodCAoQykgMjAxMyBBdG1lbCBD
b3Jwb3JhdGlvbg0KPiAgICAqCQkgQm8gU2hlbiA8dm9pY2Uuc2hlbkBhdG1lbC5jb20+DQo+ICsg
Kg0KPiArICogTGlua3MgdG8gcmVmZXJlbmNlIG1hbnVhbHMgZm9yIHRoZSBzdXBwb3J0ZWQgUFdN
IGNoaXBzIGNhbiBiZSBmb3VuZCBpbg0KPiArICogRG9jdW1lbnRhdGlvbi9hcm0vbWljcm9jaGlw
LnJzdC4NCj4gICAgKi8NCj4gICANCj4gICAjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+IA0KDQoN
Ci0tIA0KTmljb2xhcyBGZXJyZQ0K
