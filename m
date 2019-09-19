Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F8AB7463
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Sep 2019 09:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfISHrl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Sep 2019 03:47:41 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:41007 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfISHrl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Sep 2019 03:47:41 -0400
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
IronPort-SDR: 3h6dpag7N5rKjPg0pJ0Yu0/Y1t/El6KXYl6Vra1dgA85AXqsZ3I67zEtO+SQNCi+qE9XCyv/iZ
 wDbag4v62GfYT9v7rWvS2oGPNJnEe58r9O9C3/k6DCDMU+fhC29PpG7g8lJTvNG3dSsg4KOM38
 tUOSHqnJGictf4dvFW8aCXz8NmqQdErIDD7ysVpJiJYDito4fN+Y9eeuoD0vLwRiu1Cf7JK4bQ
 iGuf7q8KgB+7AyufVaQE2VZ5+LBi6douS5h8pvuGk86IjBHiwQV9gK7H898CcXPBQ26fssLb3b
 iKk=
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; 
   d="scan'208";a="49492057"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Sep 2019 00:47:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Sep 2019 00:47:34 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 19 Sep 2019 00:47:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRq5K5M8IyIJh3XAEzW5yjmPcB35Y4FcwxWOIaLvS6iF1a8WQox/udATNUKfhIXJHtcwF/AmnbhW4CppPBy2WwSNM+gZ8WHHiA9iTvNWwBrqW+mAnJWhJ4QYOK+IkITpCAzChzxqKa10ho6j74MaYfO73vGjXCdMO1ebjRktLm3TqcFLANez9FVpqxy63pPB4fBoaxEKOh9xEiLXIYAoeIL3bbrysoJxZxuH4UBvlC5mW3GVcyDfEVal77ylG6It1FZBGaaJp9a88oStmTOFLEZlvCOHy9QVAtoMKo/WF/7smjdAEWBQnIUw/M/hNXtKe5/ZAe9jr4re26EUtskFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XQ/GAUEealLUZMMuK8niriOHs6GKPsnLIp2RDO+Mhk=;
 b=OVoQwKTGRR1ZH1lOpbOwcFHupDXd4OUEMAkkYMWbNldQzAOcK75aUUFxaOLOPB6ktmII59WIIEDHKrEWO26VEA5smV9CTf2y9PT+XwAjxt2AkAVdwvlrcarUZMI9cxh0O5EC8zL608V8lrUyGRxkN3xW5Xlg1eYNA726o5r955avVeyRUkrmFRA84l/K53n/zePOgRAED+vuP30Pf0cZLGtCJSIh3xAKiMv6Wtz2AZdr02yNrVXERKNt52r+xemk9VYFQ/7e169H/9KzSt6hOErSxzp2tb3rczb/BS/b4pjhiDdkwAtlHNuSdINaWGtADR0Ceu8QGMzjsjLuIVJnqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XQ/GAUEealLUZMMuK8niriOHs6GKPsnLIp2RDO+Mhk=;
 b=sSECsxonJo0rOGZFYgn5CTbwQU9ViGNeaOaJzJoJo9JtsUC6h3Cq9fZt9Gac6R1smEG48ZxPuFesF7h9pnDBGWYtBH4QahL6HjFWCgdW49tZdAnu/Nx2MiKkN2WqLLv1R01PgQvSNLfI7i2C4KBhzpRXJ9C4E8SPN3yq7iaQ/K0=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1680.namprd11.prod.outlook.com (10.172.54.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 07:47:27 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::e1f5:745f:84b4:7c7c]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::e1f5:745f:84b4:7c7c%12]) with mapi id 15.20.2263.023; Thu, 19 Sep
 2019 07:47:27 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <kamel.bouhara@bootlin.com>, <thierry.reding@gmail.com>,
        <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregory.clement@bootlin.com>, <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] pwm: atmel: Remove platform_device_id and use only dt
 bindings
Thread-Topic: [PATCH v2] pwm: atmel: Remove platform_device_id and use only dt
 bindings
Thread-Index: AQHVbr57StGtPvVBBke1anoyhO1u4A==
Date:   Thu, 19 Sep 2019 07:47:27 +0000
Message-ID: <e3a8f56f-7471-ac84-c266-1ee446531212@microchip.com>
References: <20190918145716.32022-1-kamel.bouhara@bootlin.com>
In-Reply-To: <20190918145716.32022-1-kamel.bouhara@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR10CA0095.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::24) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919104717861
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5708e556-b798-42ed-da3f-08d73cd59dc3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1680;
x-ms-traffictypediagnostic: MWHPR11MB1680:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1680FF4409690D3352E21D2087890@MWHPR11MB1680.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(54534003)(6116002)(3846002)(8936002)(2616005)(54906003)(53546011)(6506007)(386003)(11346002)(186003)(305945005)(7736002)(110136005)(52116002)(99286004)(486006)(316002)(76176011)(476003)(25786009)(478600001)(81166006)(446003)(102836004)(2906002)(26005)(8676002)(81156014)(71200400001)(71190400001)(229853002)(36756003)(66066001)(14454004)(6436002)(2501003)(31696002)(6486002)(6246003)(4326008)(256004)(5660300002)(66476007)(66946007)(66556008)(64756008)(66446008)(86362001)(31686004)(2201001)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1680;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sWwbQxQ/e57MKJB2QTe6EWpdQFG58xW3OpdxPlxYZWaIvtZ0O3p+7/Pljra0ib/VZWKgeJ4S2joLysKdBMp45DvJJTiuD2N2gsfpThzBphFXPttkd+59BoKQvOCSOWdLUg/OI+psnn4pyMlONH7ZlAN/glV/RaV6B+d6NcCJeDY/dIjG/nUwVubP+A57B+fnJLuqIzCT7owMgiJV1aOSBEgWgVGWjXT/SAo93FFoB7DxreTzoCQSxCerCr7DJ+biG+CNymkxtuiFLwj45p6GOQl7gGEzNVjBs2AvqUpsROjX8GUptzdUuj8wb/EHpBVtgggWXs6rtT+QcgaZBqHDGEDYAzzgnQG5/BtUB76JqWHU+rMPt+KlPXFbh0Tuxdk7LZdSSjRvFjzePBiIUBNOVyzOICypDS+d7wG5cInNqbk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E43012DF0B66B14781E1C204C02EE893@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5708e556-b798-42ed-da3f-08d73cd59dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 07:47:27.1412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rVx1aKAa4nvNX4dMrttRoTu2P08xR52cmbrXTvPIn4VaYSjay+5dZt8DKBlRfhV/JM4yiKy6EmsFcQla00okEFwLY25dVRhLc3deIwCWFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1680
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQoNCk9uIDE4LjA5LjIwMTkgMTc6NTcsIEthbWVsIEJvdWhhcmEgd3JvdGU6DQo+IFNpbmNlIGNv
bW1pdCAyNjIwMjg3M2JiNTEgKCJhdnIzMjogcmVtb3ZlIHN1cHBvcnQgZm9yIEFWUjMyDQo+IGFy
Y2hpdGVjdHVyZSIpIHRoZXJlIGlzIG5vIG1vcmUgdXNlciBvZiBwbGF0Zm9ybV9kZXZpY2VfaWQg
YW5kIHdlDQo+IHNob3VsZCBvbmx5IHVzZSBkdCBiaW5kaW5ncw0KPiANCj4gU2lnbmVkLW9mZi1i
eTogS2FtZWwgQm91aGFyYSA8a2FtZWwuYm91aGFyYUBib290bGluLmNvbT4NCg0KQWNrZWQtYnk6
IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0K
PiBDaGFuZ2Vsb2c6DQo+ICB2MS0+djINCj4gIA0KPiAgLSBSZW1vdmUgd2hvbGUgZnVuY3Rpb24g
YXRtZWxfcHdtX2dldF9kcml2ZXJfZGF0YSBhbmQgY2FsbA0KPiAgb2ZfZGV2aWNlX2dldF9tYXRj
aF9kYXRhIGZyb20gYXRtZWxfcHdtX3Byb2JlDQo+IA0KPiAgZHJpdmVycy9wd20vS2NvbmZpZyAg
ICAgfCAgMiArLQ0KPiAgZHJpdmVycy9wd20vcHdtLWF0bWVsLmMgfCAzNSArKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDMzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL0tjb25m
aWcgYi9kcml2ZXJzL3B3bS9LY29uZmlnDQo+IGluZGV4IGE3ZTU3NTE2OTU5ZS4uYjUxZmIxYTMz
YWEyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3B3bS9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMv
cHdtL0tjb25maWcNCj4gQEAgLTQ0LDcgKzQ0LDcgQEAgY29uZmlnIFBXTV9BQjg1MDANCj4gIA0K
PiAgY29uZmlnIFBXTV9BVE1FTA0KPiAgCXRyaXN0YXRlICJBdG1lbCBQV00gc3VwcG9ydCINCj4g
LQlkZXBlbmRzIG9uIEFSQ0hfQVQ5MQ0KPiArCWRlcGVuZHMgb24gQVJDSF9BVDkxICYmIE9GDQo+
ICAJaGVscA0KPiAgCSAgR2VuZXJpYyBQV00gZnJhbWV3b3JrIGRyaXZlciBmb3IgQXRtZWwgU29D
Lg0KPiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYyBiL2RyaXZlcnMv
cHdtL3B3bS1hdG1lbC5jDQo+IGluZGV4IGU1ZTFlYWYzNzJmYS4uZjdjZjBhODZhMzdjIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYw0KPiArKysgYi9kcml2ZXJzL3B3bS9w
d20tYXRtZWwuYw0KPiBAQCAtMzE4LDE5ICszMTgsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGF0
bWVsX3B3bV9kYXRhIG1jaHBfc2FtOXg2MF9wd21fZGF0YSA9IHsNCj4gIAl9LA0KPiAgfTsNCj4g
IA0KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2VfaWQgYXRtZWxfcHdtX2Rl
dnR5cGVzW10gPSB7DQo+IC0Jew0KPiAtCQkubmFtZSA9ICJhdDkxc2FtOXJsLXB3bSIsDQo+IC0J
CS5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkmYXRtZWxfc2FtOXJsX3B3bV9kYXRhLA0K
PiAtCX0sIHsNCj4gLQkJLm5hbWUgPSAic2FtYTVkMy1wd20iLA0KPiAtCQkuZHJpdmVyX2RhdGEg
PSAoa2VybmVsX3Vsb25nX3QpJmF0bWVsX3NhbWE1X3B3bV9kYXRhLA0KPiAtCX0sIHsNCj4gLQkJ
Lyogc2VudGluZWwgKi8NCj4gLQl9LA0KPiAtfTsNCj4gLU1PRFVMRV9ERVZJQ0VfVEFCTEUocGxh
dGZvcm0sIGF0bWVsX3B3bV9kZXZ0eXBlcyk7DQo+IC0NCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
b2ZfZGV2aWNlX2lkIGF0bWVsX3B3bV9kdF9pZHNbXSA9IHsNCj4gIAl7DQo+ICAJCS5jb21wYXRp
YmxlID0gImF0bWVsLGF0OTFzYW05cmwtcHdtIiwNCj4gQEAgLTM1MCwxOSArMzM3LDYgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYXRtZWxfcHdtX2R0X2lkc1tdID0gew0KPiAg
fTsNCj4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGF0bWVsX3B3bV9kdF9pZHMpOw0KPiAgDQo+
IC1zdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBhdG1lbF9wd21fZGF0YSAqDQo+IC1hdG1lbF9w
d21fZ2V0X2RyaXZlcl9kYXRhKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+IC17DQo+
IC0JY29uc3Qgc3RydWN0IHBsYXRmb3JtX2RldmljZV9pZCAqaWQ7DQo+IC0NCj4gLQlpZiAocGRl
di0+ZGV2Lm9mX25vZGUpDQo+IC0JCXJldHVybiBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoJnBk
ZXYtPmRldik7DQo+IC0NCj4gLQlpZCA9IHBsYXRmb3JtX2dldF9kZXZpY2VfaWQocGRldik7DQo+
IC0NCj4gLQlyZXR1cm4gKHN0cnVjdCBhdG1lbF9wd21fZGF0YSAqKWlkLT5kcml2ZXJfZGF0YTsN
Cj4gLX0NCj4gLQ0KPiAgc3RhdGljIGludCBhdG1lbF9wd21fcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gIHsNCj4gIAljb25zdCBzdHJ1Y3QgYXRtZWxfcHdtX2RhdGEgKmRh
dGE7DQo+IEBAIC0zNzAsNyArMzQ0LDcgQEAgc3RhdGljIGludCBhdG1lbF9wd21fcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4g
IAlpbnQgcmV0Ow0KPiAgDQo+IC0JZGF0YSA9IGF0bWVsX3B3bV9nZXRfZHJpdmVyX2RhdGEocGRl
dik7DQo+ICsJZGF0YSA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsNCj4g
IAlpZiAoIWRhdGEpDQo+ICAJCXJldHVybiAtRU5PREVWOw0KPiAgDQo+IEBAIC0zOTYsMTAgKzM3
MCw4IEBAIHN0YXRpYyBpbnQgYXRtZWxfcHdtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICAJYXRtZWxfcHdtLT5jaGlwLmRldiA9ICZwZGV2LT5kZXY7DQo+ICAJYXRtZWxf
cHdtLT5jaGlwLm9wcyA9ICZhdG1lbF9wd21fb3BzOw0KPiAgDQo+IC0JaWYgKHBkZXYtPmRldi5v
Zl9ub2RlKSB7DQo+IC0JCWF0bWVsX3B3bS0+Y2hpcC5vZl94bGF0ZSA9IG9mX3B3bV94bGF0ZV93
aXRoX2ZsYWdzOw0KPiAtCQlhdG1lbF9wd20tPmNoaXAub2ZfcHdtX25fY2VsbHMgPSAzOw0KPiAt
CX0NCj4gKwlhdG1lbF9wd20tPmNoaXAub2ZfeGxhdGUgPSBvZl9wd21feGxhdGVfd2l0aF9mbGFn
czsNCj4gKwlhdG1lbF9wd20tPmNoaXAub2ZfcHdtX25fY2VsbHMgPSAzOw0KPiAgDQo+ICAJYXRt
ZWxfcHdtLT5jaGlwLmJhc2UgPSAtMTsNCj4gIAlhdG1lbF9wd20tPmNoaXAubnB3bSA9IDQ7DQo+
IEBAIC00MzcsNyArNDA5LDYgQEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgYXRtZWxf
cHdtX2RyaXZlciA9IHsNCj4gIAkJLm5hbWUgPSAiYXRtZWwtcHdtIiwNCj4gIAkJLm9mX21hdGNo
X3RhYmxlID0gb2ZfbWF0Y2hfcHRyKGF0bWVsX3B3bV9kdF9pZHMpLA0KPiAgCX0sDQo+IC0JLmlk
X3RhYmxlID0gYXRtZWxfcHdtX2RldnR5cGVzLA0KPiAgCS5wcm9iZSA9IGF0bWVsX3B3bV9wcm9i
ZSwNCj4gIAkucmVtb3ZlID0gYXRtZWxfcHdtX3JlbW92ZSwNCj4gIH07DQo+IA0K
