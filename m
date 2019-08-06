Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50BB3830D2
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Aug 2019 13:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbfHFLjP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Aug 2019 07:39:15 -0400
Received: from mail-eopbgr1400112.outbound.protection.outlook.com ([40.107.140.112]:64160
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726783AbfHFLjP (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 6 Aug 2019 07:39:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4VZwbobssPjEjAy5FZpy3nEFKZcQLAaJ+Hyz4r0adRCFefkXhM64Nxt+EaR/urzqZMpuRfgCEabgqUa99pyJSTf8qT0ZWB6WtB3EFj1ff+zeHarDaNNo30V4nAc8KacBJubVDwGlI3KrD5W+65pxO4JGotp+KfM9+R/b1UJKjSVd7c3rGkKHgrQwcVCQGZyfc0iJILTqPSZHVXm+cbMG0uIjSzvRjUWaiwMSYXMN0AZaPRjtSvisxDEfKUedMZRTF9wFlpEBr+re7Yax4FAOX87Lq66bJiM140q+wSZmFkGYenWxsWMn11dvZf4wtVe4dKqAzRg3XlgT90XNgoUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQvKW+E2IHMoxZtr8TjziqwGpP4kKjOzm+N4nWR0+XA=;
 b=H+TelW4DQPHnzVmCJipgafMmUzfVmx3hkIilaI4tePcPeyM8xQ2i7D7b7LiZjZ2W8NGeGtBkZIIUM+JcWcC6xsf8RStQziH+vIixJY20TLL6puaTHssfLrDQFxueRwBHyJfcIzaaWJMsEvtPNjN1l/9vm3/AO2j/HrbalDuVDvsl2Ao2dEYSpeKutwddIGNIw2U7wx5rzjOZxljb7Hghsi8MJN4qlqp+JNEsXo3OCn7bPrSuAIoZxl5LdDAF1HDGtGzxxD2UuIojLvkVEoY0oUoXDeDBUo3Mv/PSr2RQe2rkVGoWpJ+njrpznrBJ1VRdvcCjeFthrCyu5SvfGAX3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=renesas.com;dmarc=pass action=none
 header.from=renesas.com;dkim=pass header.d=renesas.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQvKW+E2IHMoxZtr8TjziqwGpP4kKjOzm+N4nWR0+XA=;
 b=EIeKAeZ/YTkP3v9tsxQ5IAuM3tMRyc1iEvSFGnOIxpb1QTOnMXRhreYSYd7NmR8WMwXSENgsx+/pFKLjPuzovLN8HfSai8T7qJ6b8AENQBGgY2b7VzJb4x2uYSx59ADr1ByLwWXvX/mVbwrgnX7U6wHjz4D+dGxau1PNS3qfsuo=
Received: from OSBPR01MB4536.jpnprd01.prod.outlook.com (20.179.180.215) by
 OSBPR01MB2197.jpnprd01.prod.outlook.com (52.134.243.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Tue, 6 Aug 2019 11:39:12 +0000
Received: from OSBPR01MB4536.jpnprd01.prod.outlook.com
 ([fe80::106b:32d9:ab57:e8f3]) by OSBPR01MB4536.jpnprd01.prod.outlook.com
 ([fe80::106b:32d9:ab57:e8f3%3]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 11:39:12 +0000
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
Subject: RE: [PATCH RFC 5/7] pwm: rcar: remove a redundant condition in
 rcar_pwm_apply()
Thread-Topic: [PATCH RFC 5/7] pwm: rcar: remove a redundant condition in
 rcar_pwm_apply()
Thread-Index: AQHVNWy7B3H0vTEfP02Bon2vW6tMB6buAVcAgAAqzwA=
Date:   Tue, 6 Aug 2019 11:39:12 +0000
Message-ID: <OSBPR01MB453629FB169C11ABD4856B45D8D50@OSBPR01MB4536.jpnprd01.prod.outlook.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdWw1Gh_CxgiO5gd+MY0vUvWX_ACDj+L3_Wcomkaf5Oo4Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWw1Gh_CxgiO5gd+MY0vUvWX_ACDj+L3_Wcomkaf5Oo4Q@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17368773-d748-4bac-d2a3-08d71a62b43b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:OSBPR01MB2197;
x-ms-traffictypediagnostic: OSBPR01MB2197:
x-microsoft-antispam-prvs: <OSBPR01MB21979BCF3CCF934AE980E266D8D50@OSBPR01MB2197.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(76176011)(53936002)(33656002)(76116006)(6436002)(81156014)(8676002)(52536014)(86362001)(316002)(6506007)(7696005)(53546011)(54906003)(5660300002)(186003)(55016002)(81166006)(229853002)(102836004)(99286004)(9686003)(4744005)(8936002)(71190400001)(476003)(14454004)(66066001)(4326008)(25786009)(6116002)(3846002)(68736007)(486006)(26005)(446003)(478600001)(66556008)(66476007)(66946007)(64756008)(7736002)(305945005)(7416002)(6246003)(6916009)(71200400001)(2906002)(256004)(74316002)(11346002)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2197;H:OSBPR01MB4536.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rRKjRyEhzUqw3wj4hD9/P9VH30fvTxVGz34CWPxnIzjZsAnlMupTj8X3Z9Zysf757gHKWU8xLViP2GLSdb5BLZQ38VnfCw5OyY761zuSkHy/zbbosy2jVw9oQCXSdf9bnR81mnnQug+4YEOlcfB49wJy1m9c+g2Im5jQeUNQfPDvTolaDb63tGObegsDVjul8JMDQTVk+bbVSCNLEHLkJ97UViga/hsnWVQZ3n5SoCBVcCrxfCCssSVvyu9rS2sLpDWvgGIzHjxeW8V7iTI484dDDPLg71+toMGcAOGsg4UE/lHUS/7p8LTDweJHCa/rb6gzkVim216NsJTN9EKLYCbpNIxk5PeVVjEXfyrZ97WBHphmBS6ihri/IPOA5zPrMvS28ffVPsAmVmGCg0+6ewUJt5+20DN2J5sLQFFDltM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17368773-d748-4bac-d2a3-08d71a62b43b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 11:39:12.7332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2197
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogVHVlc2Rh
eSwgQXVndXN0IDYsIDIwMTkgNjowNiBQTQ0KPiANCj4gSGkgU2hpbW9kYS1zYW4sDQo+IA0KPiBP
biBNb24sIEp1bCA4LCAyMDE5IGF0IDExOjA4IEFNIFlvc2hpaGlybyBTaGltb2RhDQo+IDx5b3No
aWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gU2luY2UgdGhlIHJjYXJf
cHdtX2FwcGx5KCkgaGFzIGFscmVhZHkgY2hlY2sgd2hlaHRlciBzdGF0ZS0+ZW5hYmxlZA0KPiA+
IGlzIG5vdCBzZXQgb3Igbm90LCB0aGlzIHBhdGNoIHJlbW92ZXMgYSByZWR1bmRhbnQgY29uZGl0
aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGly
by5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRl
cmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+DQoNClRoYW5rIHlvdSBmb3IgeW91ciBy
ZXZpZXchDQoNCj4gVGhpcyBpcyBjb21wbGV0ZWx5IGluZGVwZW5kZW50IGZyb20gdGhlIHJlc3Qg
b2YgdGhlIHNlcmllcywgYW5kIGNhbiBiZSBhcHBsaWVkDQo+IGltbWVkaWF0ZWx5LCByaWdodD8N
Cg0KVGhhdCdzIHJpZ2h0Lg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+
IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQN
Cj4gDQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExp
bnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25h
bCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhh
Y2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAi
cHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K
