Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A7A1E21A3
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2020 14:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbgEZMIX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 May 2020 08:08:23 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:14839 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729062AbgEZMIW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 26 May 2020 08:08:22 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ecd06b10001>; Tue, 26 May 2020 20:08:17 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 May 2020 05:08:17 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 26 May 2020 05:08:17 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 May
 2020 12:08:17 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.50) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 26 May 2020 12:08:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQmQNp99m+ZdNfuuBrnB7OPfPdSbM6UpGMZjItLmOgnVP8c+snrcIeCE2x1qim20Sgcr1AxLufvEBRXjSXvWXdIbJym6c041Bi7CIHwxyFAgqVHF8sobVOw8ofl2BMRFydLt69MSNJKtB2vkkmwI94SH2JzXyaAISDyDUZlASzeSGXTWOeDV7eYGTskZliDMcXNIpYu/eT38dC1RWwqocDSdsFTW4Reddunn9HmVgG74RvwzqMJ/VQeN5uvilZJi7Zkq3oFrykXeeG3U5iigqeC/LshKyUKkxU/HuOiWsvEciFw82TjEjuaV3DjOj/i1OVtqnNGUOOBdERsvxC0J0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDPTDFnpOfS4bsZMNe4onIbn3X4+jpNXTtVH1rIm7dg=;
 b=nde1DE3QUDbuSmTJyGzQpguSn/0wSg6qL8VZNRDFiSuPcAO+rE6WRB3DNgfuuSN73HoejlfPdYS7OX1s9nLVV65yq4L3zxucMSqWZBp9g979PII+ZpBsTGx/xgk5vdqlF+d8/4rN2Bt6FIYHL5B9VFXk+mGZO6y+60CcVyFoz/Mpu8q0nz5utAjlb58uesBJvUpMItRgSdNbwAosqzNRvNAZrVn0z4EkvKwesLVDDE3Us4r+iMj6Hvgp1h+iqPfEYe4Adwa+lt5VqqJUXtZWIsiYsn35UaHweqN6+YxTVCFuuT+Fb0Iv5JNgMFApEhvjWjI67ghAl4uj0tZkg2kC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3014.namprd12.prod.outlook.com (2603:10b6:a03:d8::11)
 by BYAPR12MB3463.namprd12.prod.outlook.com (2603:10b6:a03:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Tue, 26 May
 2020 12:08:15 +0000
Received: from BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::ad7c:1862:e032:66f6]) by BYAPR12MB3014.namprd12.prod.outlook.com
 ([fe80::ad7c:1862:e032:66f6%7]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 12:08:14 +0000
From:   Sandipan Patra <spatra@nvidia.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "kamil@wypas.org" <kamil@wypas.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Bibek Basu <bbasu@nvidia.com>, Bitan Biswas <bbiswas@nvidia.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remove
 module support
Thread-Topic: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remove
 module support
Thread-Index: AQHWMxtmVPDRpufQoUeveXztGYgnVKi6PzOAgAAEX/A=
Date:   Tue, 26 May 2020 12:08:14 +0000
Message-ID: <BYAPR12MB30145EC4578F64EAD1233357ADB00@BYAPR12MB3014.namprd12.prod.outlook.com>
References: <1590469565-14953-1-git-send-email-spatra@nvidia.com>
 <53619c02-8c0f-3eec-cccc-16e779b8c425@roeck-us.net>
In-Reply-To: <53619c02-8c0f-3eec-cccc-16e779b8c425@roeck-us.net>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=spatra@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-05-26T12:08:11.8694480Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=132bc317-5ca9-4b07-a311-d93334cdd251;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [124.123.74.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43c69598-980e-4c5b-00b5-08d8016d77f5
x-ms-traffictypediagnostic: BYAPR12MB3463:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3463ECB96FFB35C0747F3852ADB00@BYAPR12MB3463.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KYtluHhAasvcMDuhhVLc1fbC+P55j4Gv5rJ7gy8+qUsWWp70foqIx6p1i5hEkjBv+aXZsS0SlEcdjfG70Y26yF3N87+n0jiKDQHMEYeJhEu2hdAdL4Gddgy8NjLnOYaZ/dHFKV8vriA6PTCum27RNA881+9Old7gkCQYPQr1qczatZkR77ebAicpi5EcCG6XFgru492WoGllZu2FOh/hcljqHfaRJpqKX00d32zFbi8gUMSTxp3fN43QFMEbhHDYIiL4sxlnSpnGcr5ZkEGQYUuEFx6h1XxZPHyKCxAHwgbLCuNh56eQazdkeqC2ZazkQ8Drp6RA91wdOx0d3+yd9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3014.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(346002)(376002)(366004)(396003)(55016002)(66946007)(9686003)(53546011)(6506007)(186003)(54906003)(86362001)(71200400001)(4326008)(316002)(52536014)(110136005)(7696005)(5660300002)(64756008)(2906002)(66446008)(478600001)(76116006)(8936002)(26005)(66476007)(66556008)(33656002)(8676002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: L1nMdTWreQImNdQgcTx02dW0+HX4G/aSJARehlFuWhcrOpu9Dy6cDfR+Fg/oRR3M/ivFHBO/iV5ZXHXl63Pvg1RjQAQvbpF70Ar1Zp7xbNV+T3dfSZX3t+vzyAv4sD65EhURGoRZ50AstPgyKslm/yL7kdd6u/Fzs0BTqbUxYs0yMLjytrACZTrepa0qfPk5s9WjzpMNXD6qM0m2FEAU4j6PDtKhh7LB7CIXFetlAAntWslvVhvuhXsRBMsarfJqvpIEVmvRKALsQ57riwA/ZcWPMlpIIhyKhuBpe3b83rfeWSEwkG7mzBvO2l6oRG3s4nH1wDPzrlgWBDat6VFylMMhWelMp2d07QkeDUrWTRwbmxdHfukrdf/zKWgVqORGNB3LfusGcsDX4j0w0AkRwLMJih6DS/y14GNLUINnls3qAOjLDoFrSjh8TtlmCP5iehtZ4wH2hbgt1sDC9eKLEFB1wj20BV412O2s/jJfMWM=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c69598-980e-4c5b-00b5-08d8016d77f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 12:08:14.6354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6eSP+FOIFJQRYcgjgJcOk/J2KHX21Kq+5ImlxYoFz/of5TsJvC2vEnfhgackvMbM9zXJ93OMfZuouHYafr1OuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3463
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590494897; bh=ZDPTDFnpOfS4bsZMNe4onIbn3X4+jpNXTtVH1rIm7dg=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=lVQuxTuczD0XN4ig3mg+HykBsbgzbj7RAW9i860H4KbEIpGh8RTNTse2GXW7XYEPe
         Tf0oHqPPtSyz14rKMEY1kmnuYxLrSIZdRjMaGAhkyqbJ+SYqspt8Hv6cnfWjMfrYt3
         vlTd8246EPjuDKhXKdSWOs+9iqS5RM/KvU8HnyL5uziz1LQk8H/Hfu+7xQ6khFMjgh
         PHb2+bE4w/uyefGj2RY1e4UpoejV18doRUAx3uiaLwn92IBZelohZc3HUhWl6WSE5/
         rnjI2LrGcyU/KoEf4Cjz/ScLU3tXseC9idTzX1gOtIczMaoOfgdcaps7pL+cBDZChx
         nDU/NmKPtu+lg==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGksDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHdWVudGVyIFJv
ZWNrIDxncm9lY2s3QGdtYWlsLmNvbT4gT24gQmVoYWxmIE9mIEd1ZW50ZXIgUm9lY2sNCj4gU2Vu
dDogVHVlc2RheSwgTWF5IDI2LCAyMDIwIDU6MTIgUE0NCj4gVG86IFNhbmRpcGFuIFBhdHJhIDxz
cGF0cmFAbnZpZGlhLmNvbT47IFRoaWVycnkgUmVkaW5nDQo+IDx0cmVkaW5nQG52aWRpYS5jb20+
OyBKb25hdGhhbiBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPjsgdS5rbGVpbmUtDQo+IGtv
ZW5pZ0BwZW5ndXRyb25peC5kZTsga2FtaWxAd3lwYXMub3JnOyBqZGVsdmFyZUBzdXNlLmNvbTsN
Cj4gcm9iaCtkdEBrZXJuZWwub3JnDQo+IENjOiBCaWJlayBCYXN1IDxiYmFzdUBudmlkaWEuY29t
PjsgQml0YW4gQmlzd2FzIDxiYmlzd2FzQG52aWRpYS5jb20+Ow0KPiBsaW51eC1wd21Admdlci5r
ZXJuZWwub3JnOyBsaW51eC1od21vbkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC10ZWdyYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBod21vbjogcHdt
LWZhbjogQWRkIHByb2ZpbGUgc3VwcG9ydCBhbmQgYWRkIHJlbW92ZQ0KPiBtb2R1bGUgc3VwcG9y
dA0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0
YWNobWVudHMNCj4gDQo+IA0KPiBPbiA1LzI1LzIwIDEwOjA2IFBNLCBTYW5kaXBhbiBQYXRyYSB3
cm90ZToNCj4gPiBUaGlzIGNoYW5nZSBoYXMgMiBwYXJ0czoNCj4gPiAxLiBBZGQgc3VwcG9ydCBm
b3IgcHJvZmlsZXMgbW9kZSBzZXR0aW5ncy4NCj4gPiAgICAgVGhpcyBhbGxvd3MgZGlmZmVyZW50
IGZhbiBzZXR0aW5ncyBmb3IgdHJpcCBwb2ludCB0ZW1wL2h5c3QvcHdtLg0KPiA+ICAgICBUMTk0
IGhhcyBtdWx0aXBsZSBmYW4tcHJvZmlsZXMgc3VwcG9ydC4NCj4gPg0KPiA+IDIuIEFkZCBwd20t
ZmFuIHJlbW92ZSBzdXBwb3J0LiBUaGlzIGlzIGVzc2VudGlhbCBzaW5jZSB0aGUgY29uZmlnIGlz
DQo+ID4gICAgIHRyaXN0YXRlIGNhcGFibGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYW5k
aXBhbiBQYXRyYSA8c3BhdHJhQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaHdt
b24vcHdtLWZhbi5jIHwgMTEyDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMDAgaW5zZXJ0aW9ucygrKSwg
MTIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9od21vbi9wd20t
ZmFuLmMgYi9kcml2ZXJzL2h3bW9uL3B3bS1mYW4uYyBpbmRleA0KPiA+IDMwYjdiM2UuLjI2ZGI1
ODkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9od21vbi9wd20tZmFuLmMNCj4gPiArKysgYi9k
cml2ZXJzL2h3bW9uL3B3bS1mYW4uYw0KPiANCj4gWyAuLi4gXQ0KPiANCj4gPg0KPiA+ICtzdGF0
aWMgaW50IHB3bV9mYW5fcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4g
PiArICAgICBzdHJ1Y3QgcHdtX2Zhbl9jdHggKmN0eCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBk
ZXYpOw0KPiA+ICsgICAgIHN0cnVjdCBwd21fYXJncyBhcmdzOw0KPiA+ICsNCj4gPiArICAgICBp
ZiAoIWN0eCkNCj4gPiArICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiAr
ICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdfVEhFUk1BTCkpDQo+ID4gKyAgICAgICAgICAgICB0
aGVybWFsX2Nvb2xpbmdfZGV2aWNlX3VucmVnaXN0ZXIoY3R4LT5jZGV2KTsNCj4gPiArDQo+ID4g
KyAgICAgcHdtX2dldF9hcmdzKGN0eC0+cHdtLCAmYXJncyk7DQo+ID4gKyAgICAgcHdtX2NvbmZp
ZyhjdHgtPnB3bSwgMCwgYXJncy5wZXJpb2QpOw0KPiA+ICsgICAgIHB3bV9kaXNhYmxlKGN0eC0+
cHdtKTsNCj4gPiArDQo+ID4gKyAgICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+IA0KPiBJ
IGRvbid0IHRoaW5rIHlvdSBhY3R1YWxseSB0ZXN0ZWQgdGhpcy4gSSB3b3VsZCBzdWdnZXN0IHRv
IG1ha2UgeW91cnNlbGYgZmFtaWxpYXINCj4gd2l0aCAnZGV2bScgZnVuY3Rpb25zIGFuZCB0aGVp
ciB1c2UsIGFuZCB0aGVuIHJlc3VibWl0Lg0KPiANCg0KVGhhbmtzIEd1ZW50ZXIuDQpJIG1pc3Nl
ZCB0byBtZW50aW9uIGFib3V0IGRldm0gd2hpbGUgdW5yZWdpc3RlcmluZyB0aGUgY29vbGluZyBk
ZXZpY2UuDQpUaGF0IHdvdWxkIGRlZmluaXRlbHkgY2F1c2UgYSBtaXN0YWtlIGluIGNvZGUuIEkg
YW0gbm90aW5nIGl0IGZvciBmdXJ0aGVyIHBhdGNoLg0KDQpGb3IgYSBiZXR0ZXIgY2xhcml0eSwg
SSB3aWxsIHB1c2ggbmV4dCB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2ggdG8gaGFuZGxlIG9ubHkgbXVs
dGlwbGUgcHJvZmlsZXMgc3VwcG9ydC4NCiJyZW1vdmUgZmFuIG1vZHVsZSIgd2lsbCBiZSBzdXBw
b3J0ZWQgYnkgYSBzZXBhcmF0ZSBwYXRjaCBhbHRvZ2V0aGVyLg0KDQoNClRoYW5rcyAmIFJlZ2Fy
ZHMsDQpTYW5kaXBhbg0KDQo+IFRoYW5rcywNCj4gR3VlbnRlcg0K
