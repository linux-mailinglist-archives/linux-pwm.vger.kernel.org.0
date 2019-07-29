Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7BB7845A
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 07:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfG2FQj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jul 2019 01:16:39 -0400
Received: from mail-eopbgr1410135.outbound.protection.outlook.com ([40.107.141.135]:6073
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbfG2FQj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 29 Jul 2019 01:16:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhTmeeVdEj8rqOVQqUD41SuYXGQeao3wxc7rrdz317o+rkXKki9yMjlP3kcbKmpq3yUzR4HlFuyiTI9KrWkJoRnGnNAwlrn5ChXt07esXt8Gr3Eh/PQXbuwKXeOyJrkK07vg6vT08/Z06SJKjI6LZrjemChtSRhn+7u/hqUto6eBWZnB2x7RT4MisD0GLZ4MK38CzSLZ1oTT7cOCr372APnQ0tPKVhoZzjt/3I/NvXH5NQL/qyw8XJUojtTCkKsLBonbZZMsfUZAUD0VrB45kN3IXtsXLWbtzw5fU3zzkWScxfbRkYGPOFZl0jSHjhDKYI9eNnmjONbN5bBEYOSW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZxArvStRWHX7FSi0rJPXxfbOedP9Jm6KJTFeG7FxyM=;
 b=OlgtBNSeSb0Io2A0VxKaZWRDF5XSkk5eGpz7rzpokkrmDgN8lB2h7bqyj6ImQT3Te1vGRA5EoKHW3IEqMp0taeiF56VDVKP7cJ7ycKXeSZX5vhsMueTyOTyEQ7uscgjN6c0WUURQPftgxbedwFCfooryAPxdcotttZQ8QJyhvs6MHB6a0Vbe3PPguSOWP1jWZ6BIPGcvLc04CGHFPKMg2ED1DuxGYrPUjhm3GeXvOdDa2V0/LpT7ooMxpvdeBCJZtB8RqL80zVDxf6tYcEEX8fP7HirAYDMCabh0cFt7MWNNRwHdFndUmhA/lnkEvmeVdbA7JVDSDgG9c6ZIspDIOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=renesas.com;dmarc=pass action=none
 header.from=renesas.com;dkim=pass header.d=renesas.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZxArvStRWHX7FSi0rJPXxfbOedP9Jm6KJTFeG7FxyM=;
 b=h4SBMJAeNMlsCsBxGnSkS+qisogV6DL2f6fMHheAf0q9OhG+RaAcmzHwHhotG7c1awDJKR/vgZYsNVNE2hgvNjrQUKzyl3TEQL9Ibb2M915f1OAiqDArQ1R6xfZauiDQHtQMXlh6lcHpwzKixyhyOBKxj1UE5dzMq9HxnOS9KGc=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.174.85) by
 TYAPR01MB1965.jpnprd01.prod.outlook.com (52.133.178.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Mon, 29 Jul 2019 05:16:33 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::5c8d:f422:6a44:57a9]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::5c8d:f422:6a44:57a9%5]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 05:16:33 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 2/7] pinctrl: sh-pfc: remove incomplete flag
 "cfg->type"
Thread-Topic: [PATCH RFC 2/7] pinctrl: sh-pfc: remove incomplete flag
 "cfg->type"
Thread-Index: AQHVNWy6yAT6N18acUCgmyJX7u1APKbgxiMAgABnjvA=
Date:   Mon, 29 Jul 2019 05:16:33 +0000
Message-ID: <TYAPR01MB4544031C6A027A3690FFFB77D8DD0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CACRpkdZqTaA04bja16xh338JiwoSqFpH_2rV95FaF7YhawQzMg@mail.gmail.com>
In-Reply-To: <CACRpkdZqTaA04bja16xh338JiwoSqFpH_2rV95FaF7YhawQzMg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7fe0ef2-ce7e-4e27-5b2b-08d713e3ec1d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB1965;
x-ms-traffictypediagnostic: TYAPR01MB1965:
x-microsoft-antispam-prvs: <TYAPR01MB1965EE414199868BE3BB6C16D8DD0@TYAPR01MB1965.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(189003)(199004)(14454004)(76116006)(71190400001)(7696005)(6246003)(68736007)(229853002)(53546011)(110136005)(26005)(53936002)(6506007)(316002)(52536014)(478600001)(76176011)(66446008)(64756008)(66556008)(66476007)(71200400001)(54906003)(2906002)(99286004)(86362001)(5660300002)(66946007)(102836004)(186003)(256004)(14444005)(9686003)(66066001)(55016002)(7736002)(486006)(25786009)(476003)(74316002)(33656002)(446003)(11346002)(81156014)(81166006)(8676002)(6436002)(8936002)(305945005)(6116002)(3846002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB1965;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NdAjSKH5M0Z28WYEXG87w6Coepihco2FXjNzuQyLej6m+IPv1Dor5zZ5oP/ooax+mS55PfyN6TX/fBTwKw1EsT8+Dg4ol5EljkgizJgmB4iMuYWsPn/47QCLy+Utp6ruoLpcsScyq4fx1oGVT4ufjWJFuGQXmXCUn1b5G668ABBUc89D2xXAEENQitg8gbDZMj7j5vrZMF7eqmqCsqd+qys5g7WIR8IajFYP9NxupXNoWTO7x2r6IQ4GFzu8sOhpMnlEGqUrfqEgU+IxZucAbivEIreJpnIfV/Tzdm0rD8lBP9XyOQIh59P2xpI/PgdSMRH0VO9iv8exM3a0CH6vVNYYqY7P9Em5Q1SrQ5vj54ILCbYdSWNgh71/2+KQ0M7KRbi3aYI4pvmRIBWzpWHyvY1EFzPoQ8ivDwTC1EEI0YE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fe0ef2-ce7e-4e27-5b2b-08d713e3ec1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 05:16:33.4945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB1965
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgTGludXMsIEdlZXJ0LA0KDQo+IEZyb206IExpbnVzIFdhbGxlaWosIFNlbnQ6IE1vbmRheSwg
SnVseSAyOSwgMjAxOSA4OjAyIEFNDQo+IA0KPiBPbiBNb24sIEp1bCA4LCAyMDE5IGF0IDExOjA4
IEFNIFlvc2hpaGlybyBTaGltb2RhDQo+IDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNv
bT4gd3JvdGU6DQo+IA0KPiA+IFRoZSBvbGQgY29tbWl0IGM1OGQ5YzFiMjZlMyAoInNoLXBmYzog
SW1wbGVtZW50IGdlbmVyaWMgcGluY29uZg0KPiA+IHN1cHBvcnQiKSBicm9rZSB0aGUgY2ZnLT50
eXBlIGZsYWcgdG8gUElOTVVYX1RZUEVfRlVOQ1RJT04gYmVjYXVzZQ0KPiA+IHNoX3BmY19waW5j
b25mX3NldCgpIGRpZG4ndCBjYWxsIHNoX3BmY19yZWNvbmZpZ19waW4oKS4NCj4gPiBOb3cgaWYg
d2UgZml4IHRoZSBjZmctPnR5cGUgY29uZGl0aW9uLCBpdCBnZXRzIHdvcnNlIGJlY2F1c2U6DQo+
ID4gIC0gU29tZSBkcml2ZXJzIG1pZ2h0IGJlIGRlZmVycmVkIHNvIHRoYXQgLnNldF9tdXgoKSB3
aWxsIGJlIGNhbGxlZA0KPiA+ICAgIG11bHRpcGxlIHRpbWVzLg0KPiA+ICAtIEluIHN1Y2ggdGhl
IGNhc2UsIHRoZSBzaC1wZmMgZHJpdmVyIHJldHVybnMgLUVCVVNZIGV2ZW4gaWYNCj4gPiAgICB0
aGUgZ3JvdXAgaXMgdGhlIHNhbWUsIGFuZCB0aGVuIHRoYXQgZHJpdmVyIGZhaWxzIHRvIHByb2Jl
Lg0KPiA+DQo+ID4gU2luY2UgdGhlIHBpbmN0cmwgc3Vic3lzdGVtIGFscmVhZHkgaGFzIHN1Y2gg
Y29uZGl0aW9ucyBhY2NvcmRpbmcNCj4gPiB0byBAc2V0X211eCBhbmQgQGdwaW9fcmVxdWVzdF9l
bmFibGUsIHRoaXMgcGF0Y2gganVzdCByZW1vdmUNCj4gPiB0aGUgaW5jb21wbGV0ZSBmbGFnIGZy
b20gc2gtcGZjL3BpbmN0cmwuYy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvc2hpaGlybyBT
aGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gDQo+IFRoaXMgbG9v
a3MgbGlrZSBpdCBzaG91bGQgaGF2ZSBhIEZpeGVzOiB0YWcgYXMgd2VsbC4NCg0KSSBnb3QgaXQu
IFRoZSBGaXhlcyB0YWcgc2hvdWxkIGJlOg0KDQpGaXhlczogYzU4ZDljMWIyNmUzICgic2gtcGZj
OiBJbXBsZW1lbnQgZ2VuZXJpYyBwaW5jb25mIHN1cHBvcnQiKQ0KDQo+IEdlZXJ0IHdpbGwgZGVj
aWRlIHdoYXQgdG8gZG8gd2l0aCB0aGlzLg0KDQpJIGdvdCBpdC4NCg0KPiBDYW4gYWxsIHRoZSBw
aW5jdHJsIHBhdGNoZXMgYmUgYXBwbGllZCBpbmRlcGVuZGVudGx5IG9mIHRoZSBvdGhlcg0KPiBj
aGFuZ2VzIHNvIEdlZXJ0IGNhbiBhcHBseSBhbmQgc2VuZCBtZSB0aG9zZSBwYXRjaGVzIGluIGhp
cyBwdWxsDQo+IHJlcXVlc3RzPw0KDQpUaGUgcGluY3RybCBwYXRjaGVzICgxLzcgdGhyb3VnaCAz
LzcpIGNhbiBiZSBhcHBsaWVkIG9uIG5leHQtMjAxOTA3MjYNCnNvIEkgdGhpbmsgR2VlcnQgY2Fu
IGFwcGx5IHRoZXNlIHBhdGNoZXMgaW50byBoaXMgcmVwby4NCg0KR2VlcnQsIGlmIEkgc2hvdWxk
IHJlc2VuZCB0aGUgcGluY3RybCBwYXRjaGVzLCBwbGVhc2UgbGV0IG1lIGtub3chDQoNCkJlc3Qg
cmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gWW91cnMsDQo+IExpbnVzIFdhbGxlaWoN
Cg==
