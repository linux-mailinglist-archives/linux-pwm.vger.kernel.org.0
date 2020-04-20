Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E804F1B1109
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2020 18:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgDTQE7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Apr 2020 12:04:59 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:47683 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729550AbgDTQEL (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 20 Apr 2020 12:04:11 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9dc7f70000>; Tue, 21 Apr 2020 00:04:07 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 20 Apr 2020 09:04:07 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 20 Apr 2020 09:04:07 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr
 2020 16:04:07 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 20 Apr 2020 16:04:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxOFUovmHDXHZjvJEZBeXKdO95DQ1th5v6RbhifnY4igE9ZmWF7mYSZcDKZoBTbUCzYW9oeJiapnSyecDm2vhtKTZCkwyt41YV4iqo7YY4IrAu/maWNLOn+Jg+nmFXcl8JP2u0jiqycNyG3NfUdjS9ZKUfAsU0KW1FVO6vQgHiN8FCqOOtMkjFy3AYhqg6SOKZrlxE+ILGZ9uiMkBUJVTFmv9ZA++ulBjHIUQid4YvnQ8ZJ52TuUoXW+x0WAjtHbeqjZUYA34DkZhP7Qd/Gsg041mT6AJPn/esXJZkrguDGq9Zzu1ocxx4h5lKNlOIRYRR1Tt6CsfdsNjMXaDUY6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdozmJ0EaEapaHYVXkRkE0JMgmr2xRUPtRz3nyMv9LU=;
 b=hYDq3cdcBnmOhrz8C+pATw7CoQy2de573TIqUYbGdd+PfArJCN2KlsN4zn5Cnd3UphZxI97n3Sw5V3A826Ro5XgaOti8kbLnZG/ZcxpcANiqJayOJvLlIl8alfoNHgIic8v+aAAyLDuN49BgrgQQa2R0IbpK2uBxa77RuvQ8YBcWqMccqBF8ESbtJZFN9sIxxZ2s7eZ1wjQiF9bjr14y+1IM2gKfGqHS/DrGHvjFgLJXSucMg/axfWxagh4Sx7bHp5sgTvW3QBtzuKb8UPk8R/HTLH9UvwR/QZZYUWC6eX5CEg3t0UaXRohu1ncjaXvVSpW0MC/qK1vf7W3vDpLblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3014.namprd12.prod.outlook.com (2603:10b6:a03:d8::11)
 by BYAPR12MB3096.namprd12.prod.outlook.com (2603:10b6:a03:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Mon, 20 Apr
 2020 16:04:04 +0000
Received: from BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::5415:c583:e9b1:c13f]) by BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::5415:c583:e9b1:c13f%6]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 16:04:04 +0000
From:   Sandipan Patra <spatra@nvidia.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <treding@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bibek Basu <bbasu@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pwm: tegra: dynamic clk freq configuration by PWM driver
Thread-Topic: [PATCH] pwm: tegra: dynamic clk freq configuration by PWM driver
Thread-Index: AQHWCbRZ2okaHtzUPk25uDpHZH29f6hngLeAgBJsA7CAAGF1AIABo/5wgAF4t4CAAAj5wIABLd4AgAOj14A=
Date:   Mon, 20 Apr 2020 16:04:03 +0000
Message-ID: <BYAPR12MB3014BF7668051E085B2844C9ADD40@BYAPR12MB3014.namprd12.prod.outlook.com>
References: <1585917303-10573-1-git-send-email-spatra@nvidia.com>
 <20200403151050.nh2mrffkqdqtkozq@pengutronix.de>
 <BYAPR12MB3014C0178A7360662C6FA8B7ADDB0@BYAPR12MB3014.namprd12.prod.outlook.com>
 <20200415141856.ck3w3gtae4bsxyfl@pengutronix.de>
 <BYAPR12MB30149D2715DC575A030A7F59ADD90@BYAPR12MB3014.namprd12.prod.outlook.com>
 <20200417135027.wkj6bxiplnehsa5s@pengutronix.de>
 <BYAPR12MB3014041BFFC43AF5EB3BC27CADD90@BYAPR12MB3014.namprd12.prod.outlook.com>
 <20200418082300.mucrg2srysvvjbfn@pengutronix.de>
In-Reply-To: <20200418082300.mucrg2srysvvjbfn@pengutronix.de>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=spatra@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-04-20T16:04:01.0469540Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=65d327e3-8ba5-4b65-8426-527d1a8e8bbd;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=spatra@nvidia.com; 
x-originating-ip: [115.114.90.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85e9ee96-1d76-4715-5212-08d7e54472ec
x-ms-traffictypediagnostic: BYAPR12MB3096:|BYAPR12MB3096:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3096F16A4842B4585D3F42C5ADD40@BYAPR12MB3096.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3014.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(54906003)(4326008)(66946007)(76116006)(66556008)(66476007)(66574012)(66446008)(64756008)(478600001)(7696005)(6916009)(966005)(6506007)(2906002)(5660300002)(53546011)(71200400001)(52536014)(86362001)(33656002)(9686003)(186003)(81156014)(55016002)(83080400001)(26005)(8676002)(8936002)(55236004)(316002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pHERPBRjbyyYKB0bAoviek5ChCxOmOnUjaYRbFx9GXJAdnO5RC4ZE4U3KrcHE9jDFPJGdJESmzbxbHvwHQsRoxd0Uu1xgaZAx8qB5X8bgR8kBxiMPKBgfip1y8FN46QnlrUF7VritEY5N1RowMRTV1de0BrNqlGcuYYSbJoS7OaiLYJGWN+uZHO19n+pWaSv08qOTD9d6NtK7D1Ck/k4/5Ct7ibYdkXsF5OJlvMrBNwrZs+Cx/GeID1PYovqhaHfJbbTfwPyztOv+2HRtXsaqVy9sc7HWT8iVaYHiDsa2O85fjjn1FzpYS0d10ToS6wKsCGEvoZr3ALRHdTLJwEap0qX2YArq7OvEq2ZohmtcY/qkBfx2l1cwEi87o20zaKH++IfmYwZlcUvwkWVlLIu1vkysu0nUztuS6FNcIV0MKaevZnatter6v7ce4+KG5Tu79pe/u+lXN0OQWXc4a5P8PgqCCkIoe6A6jJ4yf1F2IykPcErRiYBq7KV5oPVjYtApxm6wYIIbG9GUWqGLySstQ==
x-ms-exchange-antispam-messagedata: ayLmoCHstgsFt+Z/q8BHpEUXUleBZec/mAzIysskVRDZVrI5k2hlAB6ceq1sYaNFnpmcTjuuOIxQhevclghJk5QNmaQDnWnA+gL/+YRyaX9UU/SuWDo8fAQ/xX3S5G3N3Z+zybDA9DT0gLN95kYrhg==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e9ee96-1d76-4715-5212-08d7e54472ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 16:04:04.3532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7BASF6tw51gUGPxGBiSJi2dj0qDuBK7/vPP6wPRu1EmgvLCnUSiGfb2bY6FZDY8nbM4ujGZCSIPVFTu70hEIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3096
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587398647; bh=vdozmJ0EaEapaHYVXkRkE0JMgmr2xRUPtRz3nyMv9LU=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:
         x-ms-exchange-antispam-messagedata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=pCOscK6WiemLZig0BBJuz0wTMA7xy4DAVbe83RZMTu5FXC88Hdlp1lJtww9E7Q+xv
         kcixhX82N6cPN1FnidIEKTi/qqWFb5pBVdU8a6e+4uIMbJDg0CXZKqmBdS3iD3vpWZ
         n/3td1f+MF25ARATwL+ZjbVD3kxVx/Z02y6coe6/f8/E1yBlpMAhGI/lekcu1uMLv7
         rULbf9enBUqxYohIfWgf/tEUHzyJvXvAjgzmGjTb8UDEn3Pso3KAh4xcCU4cr3hOTA
         TQreEe0bxZitv8HuPGU5mU2qsbmuTsR17rjuDcWpH0bjy+p1btnfxFHZ4lrisb38Zv
         d9fp/RuYlJXBA==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgVXdlLA0KDQpUaGFua3MgZm9yIHJldmlld2luZyBhbmQgcHJvdmlkaW5nIHlvdXIgaW5wdXRz
IHRvIHRoZSBjaGFuZ2VzLg0KDQpUaGUgcmV2aWV3IGNvbW1lbnRzIGFyZSBhZGRyZXNzZWQgaW4g
dGhlIG5ldyBwYXRjaC4NClBhdGNoIChWMikgaXMgcmVhZHkgdG8gYmUgcmV2aWV3ZWQgYXQ6DQpo
dHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXgtcHdtL3BhdGNoLzE1ODcz
OTgwNDMtMTg3NjctMS1naXQtc2VuZC1lbWFpbC1zcGF0cmFAbnZpZGlhLmNvbS8NClBsZWFzZSBo
ZWxwIHJldmlld2luZyBmdXJ0aGVyLg0KDQoNClRoYW5rcyAmIFJlZ2FyZHMsDQpTYW5kaXBhbg0K
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVXdlIEtsZWluZS1Lw7Zu
aWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gU2VudDogU2F0dXJkYXksIEFw
cmlsIDE4LCAyMDIwIDE6NTMgUE0NCj4gVG86IFNhbmRpcGFuIFBhdHJhIDxzcGF0cmFAbnZpZGlh
LmNvbT4NCj4gQ2M6IFRoaWVycnkgUmVkaW5nIDx0cmVkaW5nQG52aWRpYS5jb20+OyByb2JoK2R0
QGtlcm5lbC5vcmc7IEpvbmF0aGFuDQo+IEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5jb20+OyBC
aWJlayBCYXN1IDxiYmFzdUBudmlkaWEuY29tPjsgTGF4bWFuDQo+IERld2FuZ2FuIDxsZGV3YW5n
YW5AbnZpZGlhLmNvbT47IGxpbnV4LXB3bUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC10ZWdyYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHB3bTogdGVncmE6
IGR5bmFtaWMgY2xrIGZyZXEgY29uZmlndXJhdGlvbiBieSBQV00gZHJpdmVyDQo+IA0KPiBFeHRl
cm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiAN
Cj4gDQo+IEhlbGxvLA0KPiANCj4gT24gRnJpLCBBcHIgMTcsIDIwMjAgYXQgMDI6NTM6MjJQTSAr
MDAwMCwgU2FuZGlwYW4gUGF0cmEgd3JvdGU6DQo+ID4gPiBUbyBwdXQgbXkgZXhwcmVzc2lvbiBp
biB3b3JkczogcGljayB0aGUgbWF4aW11bSBvZiB0aGUgcG9zc2libGUNCj4gPiA+IHBlcmlvZHMg
dGhhdCBhcmUgbGVzcyBvciBlcXVhbCB0byB0aGUgcmVxdWVzdGVkIHZhbHVlLiAgTWF5YmUgdGhp
cw0KPiA+ID4gaXMgYmV0dGVyDQo+ID4gPiB1bmRlcnN0YW5kYWJsZToNCj4gPiA+DQo+ID4gPiAg
ICAgICAgIG1heCB7IHgg4oiKIGltcGxlbWVudGFibGVQZXJpb2RzIHwgeCA8PSByZXF1ZXN0ZWRQ
ZXJpb2QgfQ0KPiA+ID4NCj4gPiA+ID8NCj4gPg0KPiA+IEkgdGhpbmsgSSBnb3QgeW91ciBxdWVz
dGlvbi4NCj4gPiBTaG91bGQgdGVncmFfcHdtX2NvbmZpZygpIG5vdCByZXR1cm4gZXJyb3IgKEVJ
TlZBTCkgd2hlbiB0aGUgcmVxdWVzdGVkDQo+ID4gcGVyaW9kIGlzIGludmFsaWQgYnV0IGl0IHNo
b3VsZCBjb25maWd1cmUgdG8gYSBuZWFyZXN0IHBvc3NpYmxlIHZhbHVlPw0KPiANCj4gSWYgeW91
IGNhbm5vdCBjb25maWd1cmUgYWNjb3JkaW5nIHRvIHRoZSBhYm92ZSBydWxlLCB5ZXMsIHJldHVy
biBhbiBlcnJvciBjb2RlLg0KPiBFSU5WQUwgaXMgdGhlIHVzdWFsIG9uZSBJIHRoaW5rIChzb21l
IGFsc28gcmV0dXJuIEVSQU5HRSkuDQo+IA0KPiA+ID4gPiBZZXMsIHRoZSBvdXRwdXQgc3RvcHMg
YXMgc29vbiBhcyB0aGUgUFdNX0VOQUJMRSBiaXQgaXMgY2xlYXJlZCBpbg0KPiA+ID4gPiBoYXJk
d2FyZS4gVGhlbiBUaGUgb3V0cHV0IGlzIHNldCB0byAwICh3aGljaCBpcyBpbmFjdGl2ZSkuDQo+
ID4gPiA+IE9uY2UgLmRpc2FibGUoKSA9PiB0ZWdyYV9wd21fZGlzYWJsZSgpIGdldHMgaW52b2tl
ZCwgZW5hYmxlIGJpdCBpcw0KPiA+ID4gPiBjbGVhcmVkIGFuZCBoZW5jZSBQV00gd2lsbCBwb3Nz
ZXNzIG5vIG91dHB1dCBzaWduYWwuDQo+ID4gPiA+IHRlZ3JhX3B3bV9jb25maWcoKSB3aWxsIGJl
IGludm9rZWQgZm9yIGFueSBuZXcgY29uZmlndXJhdGlvbiByZXF1ZXN0Lg0KPiA+ID4NCj4gPiA+
IFNvbWUgZHJpdmVycyBhbHJlYWR5IGhhdmUgYSAiTGltaXRhdGlvbnMiIHNlY3Rpb24gaW4gdGhl
aXIgaGVhZGVyLg0KPiA+ID4gUGxlYXNlIHRha2UgYSBsb29rIGF0IHRoZSBleGlzdGluZyBleGFt
cGxlcyBhbmQgcHJvdmlkZSBzb21ldGhpbmcNCj4gPiA+IHNpbWlsYXIuIChOb3RlIHlvdSBzdGls
bCBkaWRuJ3QgYW5zd2VyICJIb3cgZG9lcyBhIHJ1bm5pbmcgUFdNDQo+ID4gPiBiZWhhdmUgd2hl
biB0aGUgcmVnaXN0ZXIgaXMgdXBkYXRlZD8gRG9lcyBpdCBjb21wbGV0ZSB0aGUgY3VycmVudGx5
DQo+ID4gPiBydW5uaW5nIHBlcmlvZD8iLiBJIGFzc3VtZSB0aGUgYW5zd2VyIHRvIHRoZSBzZWNv
bmQgcXVlc3Rpb24gaXMgIk5vIg0KPiA+ID4gKGFuZCB0aGUgZmlyc3QgaXMgb25seSB0aGVyZSBm
b3IgcmhldG9yaWMgcmVhc29ucykuKQ0KPiA+ID4NCj4gPg0KPiA+IDEuIEkgd2lsbCBhZGQgdGhl
IGJlbG93IGNvbW1lbnRzIGFzIExpbWl0YXRpb25zOg0KPiA+IC0gICAgIFdoZW4gUFdNIGlzIGRp
c2FibGVkLCB0aGUgb3V0cHV0IGlzIGRyaXZlbiB0byAwIGFuZA0KPiANCj4gSW4gZmFjdCwgdGhp
cyBpcyBhIGdvb2QgcHJvcGVydHkuIFNvIHRoZSBvbmx5IHByb2JsZW0gaXMsIHRoYXQgZm9yIGJv
dGggc3RvcCBhbmQNCj4gcmVjb25maWd1cmF0aW9uIHRoZSBjdXJyZW50bHkgcnVubmluZyBwZXJp
b2QgaXNuJ3QgY29tcGxldGVkLg0KPiANCj4gQmVzdCByZWdhcmRzDQo+IFV3ZQ0KPiANCj4gLS0N
Cj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgVXdlIEtsZWlu
ZS1Lw7ZuaWcgICAgICAgICAgICB8DQo+IEluZHVzdHJpYWwgTGludXggU29sdXRpb25zICAgICAg
ICAgICAgICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlLyB8DQo=
