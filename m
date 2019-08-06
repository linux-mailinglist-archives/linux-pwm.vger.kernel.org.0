Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0419F830F4
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Aug 2019 13:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfHFLtB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Aug 2019 07:49:01 -0400
Received: from mail-eopbgr1410125.outbound.protection.outlook.com ([40.107.141.125]:17248
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfHFLtB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 6 Aug 2019 07:49:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRNS5Mg7FY7wIr60sjkBly7N0QM2/qXGSDWuLIaOJkpulzqx2ygvNIfD4khrb2lZvvMBh6XF8UTWCQeYVmtgzcbsJwEFHXG8xjh5Dd2jJuS7H6XUn3T5FpgBgicIZVTj5vVNm/PYzWf8Lr8qTkCP7KnLlxCUvUL+UmSZ+T2KNbtNvrWUIiXSQyLv8TyNs7qr210tO5c56YK80zq/OFQae/gXqSFn9HU/zu2U2CmzBz2Om8ABNEkrODto6fYhhXDEXc3I6/tHv/igfrahBkTrvTQEVpMfM4aq5SM4FBRYpFnmjmDj5WdYvRDQhrQMwBK+YoqQ2BImz47EoLgOdBn3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwCzcxnr2DSnm2Zz77KXuUwzBqBHXbgLnYGUwhU6X8k=;
 b=VuFtBZKm+TGHos7joKlNS1wnnaAICDvhGs9nlKK4RQ3IK68LFpUMm794ezGlh9BZ8jmFsS8V33gdqDXLya2dKzLMMMm8kReqQdqEvDsq3dPV7DM1TW/lUkmFrI2QlFjMChWK5HEE2h3g6/gpbzo6/FWy5ILnMsGgMgXHrBMEkcM/aqjKUtBXKiDJ+SrRTkwPDItR/HE5BNQQIyN1dffbgeeVOwCbvvG39QYgvaGCQ2wy/Vy2Kib+0ij3+wMBLQLe8hIqHWZ7gR2g0f72GqRj67e5AsHR9VCs8ogAoNtoYqBPNTNmmhSmBPL/M0mdVeOYrFEXxmfU19GR7CYhsKOf9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=renesas.com;dmarc=pass action=none
 header.from=renesas.com;dkim=pass header.d=renesas.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwCzcxnr2DSnm2Zz77KXuUwzBqBHXbgLnYGUwhU6X8k=;
 b=if8qbv7yozXc9OgPP4l1D3GyrHBCVv+VDaVpoHf41tNfJ5PHx2RgwwKTLw21DVnLMYVGYgesDbP4Ik1nd3GeYyyfDvApQTRF5WHmHFWOkAniZyZh83ZF4QWbkel/9B3zqN2SnBGNaSxaXjk0ByQoM7hsX/71fLDyhr4MVJEKv6U=
Received: from OSBPR01MB4536.jpnprd01.prod.outlook.com (20.179.180.215) by
 OSBPR01MB4294.jpnprd01.prod.outlook.com (20.179.180.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.19; Tue, 6 Aug 2019 11:48:57 +0000
Received: from OSBPR01MB4536.jpnprd01.prod.outlook.com
 ([fe80::106b:32d9:ab57:e8f3]) by OSBPR01MB4536.jpnprd01.prod.outlook.com
 ([fe80::106b:32d9:ab57:e8f3%3]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 11:48:57 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 2/7] pinctrl: sh-pfc: remove incomplete flag
 "cfg->type"
Thread-Topic: [PATCH RFC 2/7] pinctrl: sh-pfc: remove incomplete flag
 "cfg->type"
Thread-Index: AQHVNWy6yAT6N18acUCgmyJX7u1APKbuBmyAgAAnuPA=
Date:   Tue, 6 Aug 2019 11:48:57 +0000
Message-ID: <OSBPR01MB45363201E328DF9C15D2833FD8D50@OSBPR01MB4536.jpnprd01.prod.outlook.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdVcAw_ApKMmrV7DaoJBGUZ1GzW3kmxnsTn72FtCGWhXPA@mail.gmail.com>
In-Reply-To: <CAMuHMdVcAw_ApKMmrV7DaoJBGUZ1GzW3kmxnsTn72FtCGWhXPA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e574cd7c-e605-4d6f-6419-08d71a6410c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:OSBPR01MB4294;
x-ms-traffictypediagnostic: OSBPR01MB4294:
x-microsoft-antispam-prvs: <OSBPR01MB4294488DF334BF906904F95FD8D50@OSBPR01MB4294.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:565;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(199004)(189003)(55016002)(33656002)(6246003)(81156014)(4326008)(6436002)(5660300002)(8936002)(81166006)(8676002)(305945005)(74316002)(7736002)(478600001)(9686003)(14454004)(6506007)(99286004)(53546011)(25786009)(53936002)(7696005)(6116002)(68736007)(7416002)(54906003)(6916009)(446003)(476003)(76176011)(316002)(486006)(186003)(26005)(52536014)(11346002)(2906002)(229853002)(86362001)(66446008)(64756008)(66066001)(256004)(76116006)(14444005)(3846002)(66946007)(66556008)(102836004)(66476007)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB4294;H:OSBPR01MB4536.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H8P+Mbp/I4qyDjavhk8zVG7YF4MxL3vaN7kWsBFa6aJ8XAfcDdEF2lWgS57nvEVaZOcCQt+AcrCN6orS7pFCj8EjMVqRRqUzTrr7nm8DMmxSJzELuZiLCbmuNZ41G52OuHuZ6Gee5Wc3Mi3A+suYLQMKsvJ14OYkiWxAl9ogrkOGptLRj0JHaxp3SKd5b9d423+FYNJDuJ+NGeB0/UaG22j/xu5UAKgP9F0wlxHwVWOaMgLFCi535y253yoY8qPIFE+CIZnLADMSKtjkMBDmtcVit7GVppwmwbL6dP1FRd8c8ARE0BE/ot1IB3ToEuZD3B+doQbVF41xGujnEGwYfsH7ieZarYbei0Ol8eJVDloKNRy0o02VxPWdX8CKK9Rkbr5AZ/ewN+sXBYtkIm8Dk9qhbkAjVsn0MB4Hy4vEnog=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e574cd7c-e605-4d6f-6419-08d71a6410c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 11:48:57.4128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4294
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogVHVlc2Rh
eSwgQXVndXN0IDYsIDIwMTkgNjoyNCBQTQ0KPiANCj4gSGkgU2hpbW9kYS1zYW4sDQo+IA0KPiBP
biBNb24sIEp1bCA4LCAyMDE5IGF0IDExOjA4IEFNIFlvc2hpaGlybyBTaGltb2RhDQo+IDx5b3No
aWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gVGhlIG9sZCBjb21taXQg
YzU4ZDljMWIyNmUzICgic2gtcGZjOiBJbXBsZW1lbnQgZ2VuZXJpYyBwaW5jb25mDQo+ID4gc3Vw
cG9ydCIpIGJyb2tlIHRoZSBjZmctPnR5cGUgZmxhZyB0byBQSU5NVVhfVFlQRV9GVU5DVElPTiBi
ZWNhdXNlDQo+ID4gc2hfcGZjX3BpbmNvbmZfc2V0KCkgZGlkbid0IGNhbGwgc2hfcGZjX3JlY29u
ZmlnX3BpbigpLg0KPiA+IE5vdyBpZiB3ZSBmaXggdGhlIGNmZy0+dHlwZSBjb25kaXRpb24sIGl0
IGdldHMgd29yc2UgYmVjYXVzZToNCj4gPiAgLSBTb21lIGRyaXZlcnMgbWlnaHQgYmUgZGVmZXJy
ZWQgc28gdGhhdCAuc2V0X211eCgpIHdpbGwgYmUgY2FsbGVkDQo+ID4gICAgbXVsdGlwbGUgdGlt
ZXMuDQo+ID4gIC0gSW4gc3VjaCB0aGUgY2FzZSwgdGhlIHNoLXBmYyBkcml2ZXIgcmV0dXJucyAt
RUJVU1kgZXZlbiBpZg0KPiA+ICAgIHRoZSBncm91cCBpcyB0aGUgc2FtZSwgYW5kIHRoZW4gdGhh
dCBkcml2ZXIgZmFpbHMgdG8gcHJvYmUuDQo+ID4NCj4gPiBTaW5jZSB0aGUgcGluY3RybCBzdWJz
eXN0ZW0gYWxyZWFkeSBoYXMgc3VjaCBjb25kaXRpb25zIGFjY29yZGluZw0KPiA+IHRvIEBzZXRf
bXV4IGFuZCBAZ3Bpb19yZXF1ZXN0X2VuYWJsZSwgdGhpcyBwYXRjaCBqdXN0IHJlbW92ZQ0KPiA+
IHRoZSBpbmNvbXBsZXRlIGZsYWcgZnJvbSBzaC1wZmMvcGluY3RybC5jLg0KPiANCj4gRG8gd2Ug
bmVlZCB0byBzZXQgc2hfcGZjX3Bpbm11eF9vcHMuc3RyaWN0ID0gdHJ1ZT8NCg0KSWYgdGhlIC5z
dHJpY3QgPSB0cnVlLCB0aGUgZmluYWwgcHdtIHBhdGNoIG9uIHRoaXMgc2VyaWVzIGZhaWxlZCB3
aXRoIHRoZSBmb2xsb3dpbmcgZXJyb3I6DQoNClsgICAxMS40NTM3MTZdIHNoLXBmYyBlNjA2MDAw
MC5waW4tY29udHJvbGxlcjogcGluIEdQXzJfNyBhbHJlYWR5IHJlcXVlc3RlZCBieSBlNmUzMTAw
MC5wd207IGNhbm5vdCBjbGFpbSBmb3IgZTYwNTIwMDAuZ3Bpbzo0NTkNCg0KQmVzdCByZWdhcmRz
LA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4g
LS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsu
b3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3Bs
ZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91
cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4N
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
