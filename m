Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6157F85B33
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Aug 2019 09:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbfHHHDM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Aug 2019 03:03:12 -0400
Received: from mail-eopbgr1410100.outbound.protection.outlook.com ([40.107.141.100]:10880
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725817AbfHHHDM (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 8 Aug 2019 03:03:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVeq7o6cM1gbqTwrpY7r28w1el9WazdHo/NIk9eGOc3c83dnQXcReOqc1RsF56deodFPs0F25vyVGA6n+e90ayHbV9o2y1dtGaBg3KgcyWBpvuYRphS4hf/jPF7cSohi5oN+AmxrmGoHZXZq3B3SHH/qQgWkYAZZJOrDILQJpHeAfeomw7QvlWVxsRI2za9kkhEzaYLg0rqCFWA2qXrsDnVpwB0fT46Baz1p2BkWxVSZr+9nGaXKtdFxWyQdknApDW/4boZiENiP1/J6dQkWoKSdB++iSL4al6T0zJJ0IxV84lTFTF15xlIV/upwYAI7TSbVl0Xm2WRfgta/f6nKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+zDmoeNrWbwUMbVIqLyuQodfH4HTVLg4sah0OCysRU=;
 b=a9rCPwAdrHrTfr9R9jXGTY7ZivJ280QToekj++Q6cc4pBXI+FwQ8LXK+RcRYd2wMlZBK7bfqyWIxLzSMuFMeSprzTKhjKYfOn9QtZhfx/ygA12EQaKMlTTG7N9SiC5xS0ilUYit/BRWkjxYXQcqOeGsVVSJwyT0+O1mBzzEKFLX+bd/4QxxlW8BITy+wCGQxi8poxfcLLfMcSoabxxG5BL6q4YtIYxWAvDQVuSkuB+azP8Nv4/UtXAGER7FAXlHo38m8nKbLtbanB/0DbRAYq1Hd+EBMqoK0pBUo9rV5x5kPqhocU77DL2Sw5/GMtX3t4Ev0JqxnMTM7xI9g5l5BVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+zDmoeNrWbwUMbVIqLyuQodfH4HTVLg4sah0OCysRU=;
 b=bNtjklDs3QdhHLJlKI2mVbb5QR21LRZhadj2FTGqxq0oHDGYgfnkiCExz6E4Lr2gOyrbB4MGZ0dtDlslAMaB2zezwmXsG4lCT+V5F2h72ehWl7oiXlfkwAUHpEQu1nYBEz7q0IzrNXMTpW6mKPzV6RcCIpCHznhCtM7LU0BYkIQ=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2064.jpnprd01.prod.outlook.com (52.133.178.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Thu, 8 Aug 2019 07:02:56 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::6564:f61f:f179:facf%5]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 07:02:56 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 6/7] pwm: rcar: Add gpio support to output duty zero
Thread-Topic: [PATCH RFC 6/7] pwm: rcar: Add gpio support to output duty zero
Thread-Index: AQHVNWy7V8gL2ZngqkqByKUc3gWdAabvcZEAgAFBsMCAAEyxgIAAAsDQ
Date:   Thu, 8 Aug 2019 07:02:55 +0000
Message-ID: <TYAPR01MB45447F9F1768D94E862DFDF0D8D70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190807070326.cgkbt4kpzhqvo5a3@pengutronix.de>
 <TYAPR01MB45445D854C1FDBB473A89559D8D70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CAMuHMdUQpTvwk=PxhwJGbW8izBXSzHw0sNvypzONPovR7sZutA@mail.gmail.com>
In-Reply-To: <CAMuHMdUQpTvwk=PxhwJGbW8izBXSzHw0sNvypzONPovR7sZutA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 809d33d2-efc3-4de7-9d0f-08d71bce7075
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:TYAPR01MB2064;
x-ms-traffictypediagnostic: TYAPR01MB2064:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <TYAPR01MB20641E9B110E0A5CA1216F6CD8D70@TYAPR01MB2064.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39850400004)(366004)(346002)(376002)(396003)(199004)(189003)(6306002)(99286004)(9686003)(6436002)(8936002)(55016002)(5660300002)(66556008)(66946007)(76116006)(54906003)(229853002)(52536014)(66446008)(81166006)(186003)(66066001)(64756008)(102836004)(6506007)(81156014)(7696005)(8676002)(7416002)(2906002)(53546011)(26005)(6246003)(74316002)(3846002)(6116002)(33656002)(4326008)(53936002)(305945005)(6916009)(76176011)(7736002)(446003)(25786009)(66476007)(11346002)(476003)(71190400001)(71200400001)(486006)(14454004)(966005)(86362001)(478600001)(256004)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2064;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iABs5HvvXStV4+dOoMNG9Pn7x0PPoS4E1QTRFvqJk5SGeAE33puYrRey0g1dLGz/EKuUq5DxmmsBjQyHLLmjps+TCmS0cW3wncbTIgTkauTiAAM7fzbF6oXGFR+bF3GNh0Xt0pTmGdTOrL6BER5V57ZFjQ0W6chuUHbz6fEBExrJ0cl4mKC213uQ36ayox9ny1KtAxnZP77r3haURn03q6CLT9hHCtUWxvQ4dHNiSjKafXSHMGRYcVitYyF3oY5IWB3hwQ9n00FhrVnhOt7X9PX7Gb/q4A9OT7n41BxUy2/HSDlTX7G69n3P6HNcZzYQv/XZB1f6a8WTDrhH77Kvabete6tjBrZy3jJ0zICgfN0rfWbXSj68NN2H4qhNfMiF9+ZT7MeBnIgTYh7itjny4fUHu0j08eT4JZ2mzRrL1BQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809d33d2-efc3-4de7-9d0f-08d71bce7075
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 07:02:55.8854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kz7k5rLBYHvNGdY3a9RSSdp39wZCiYkfjmTKDF1u0JmOOVhT8j8MwjfG3DoVCPGvtN4kuJEJPsX6Y9JBLaOdLMJQqqYZ14tGuBBDBk16Z8P3DtdPjLFxYy3nJkFFQNtL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2064
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogVGh1cnNk
YXksIEF1Z3VzdCA4LCAyMDE5IDM6NDkgUE0NCj4gDQo+IEhpIFNoaW1vZGEtc2FuLA0KPiANCj4g
T24gVGh1LCBBdWcgOCwgMjAxOSBhdCA1OjUzIEFNIFlvc2hpaGlybyBTaGltb2RhDQo+IDx5b3No
aWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gPiBGcm9tOiBVd2UgS2xl
aW5lLUvDtm5pZywgU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgNywgMjAxOSA0OjAzIFBNDQo+ID4g
PiBXaGlsZSBhdCBpdDogSWYgdGhlcmUgaXMgYSBwdWJsaWNseSBhdmFpbGFibGUgcmVmZXJlbmNl
IG1hbnVhbCBhZGRpbmcgYSBsaW5lOg0KPiA+ID4NCj4gPiA+ICAgICAgIFJlZmVyZW5jZSBNYW51
YWw6IGh0dHBzOi8vLi4uDQo+ID4gPg0KPiA+ID4gd291bGQgYmUgZ3JlYXQsIHRvby4NCj4gPg0K
PiA+IFVuZm9ydHVuYXRlbHksIHRoZSBkb2N1bWVudCBpcyBub3QgcHVibGljLi4uDQo+IA0KPiBS
Wi9HMSBoYXMgdGhlIHNhbWUgaGFyZHdhcmUgYmxvY2ssIHJpZ2h0Pw0KPiBJdHMgSGFyZHdhcmUg
VXNlcidzIE1hbnVhbCBpcyBwdWJsaWNseSBhdmFpbGFibGUsIGUuZy4gZm9yIFJaL0cxTToNCj4g
aHR0cHM6Ly93d3cucmVuZXNhcy5jb20vZXUvZW4vcHJvZHVjdHMvbWljcm9jb250cm9sbGVycy1t
aWNyb3Byb2Nlc3NvcnMvcnovcnpnL3J6ZzFtLmh0bWwjZG9jdW1lbnRzDQoNCllvdSdyZSByaWdo
dC4NCiMgU2luY2UgSSBjb3VsZCBnZXQgUlovRzIgc2VyaWVzIGhhcmR3YXJlIHVzZXIncyBtYW51
YWwgZnJvbSBwdWJsaWMgd2Vic2l0ZSB5ZXN0ZXJkYXksDQojIEkgd2FzIHRoaW5raW5nIGFueSBt
YW51YWxzIGFyZSBub3QgcHVibGljLi4uDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGlt
b2RhDQoNCg0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3Rz
IG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJbiBw
ZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2Vs
ZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0
IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
