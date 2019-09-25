Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75459BD665
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2019 04:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411378AbfIYCgV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Sep 2019 22:36:21 -0400
Received: from mail-eopbgr130054.outbound.protection.outlook.com ([40.107.13.54]:18434
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389764AbfIYCgV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 24 Sep 2019 22:36:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBtoDBtkoz0lQkfdualSj5SI9idwkkgIS4StGySE2GclLxRajBHCpJx+nQexPnXTpIdbOVUtOXHRm3pWRfqmAf5e31kxV6GK1Zpj37wxXGIEMDtqdT6GnJrZz/CObH/s4yYJKzmvzeHIoE/b/gcOlBmBCU72RIDD2T8QuIoCCJTTORao8Uc2wspF6EoCxdT06rokIRsWYSakBRbPJ4yrdGpJsBl77lxj8Bd1J/790Jh6iMa+nN7RnSKOB7sSiviRnq999557z+Zcwss98WgCQMnUIpzlNgtO7uo/ez+o9JUNqvIKc7/gg5qPj5f6Uutf+6eS5uPzKAebVMrAyLS5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTMY0GcYbBLTZctPnUK/z/R3ID7zD3s50PYhxLe9Mdg=;
 b=XMGVsxEwOlAYqOe6Svjot1evG/Qn4bkJNUIMcxrCwB5H4AEDYl3rEEeZEecaHPAM/KkheTf74PGDA5MUbMpN8MP9gPZoG1B+TrLCed9sDyCOPbWvuWOU6W2lfwMrE/T+CYLFpB8StYASYyBjYSStkuzKTzR2jcsY/UU11gBucn6H8yoWciaFPid2/DW0xZ0x8kX3hZAlFoCPpXsLcVbW0fe1P9i9CyqoaesVbirDeLdcgk9DBX1aK3TkRygEm6MMg80+0AFVGsJdcbQ6RMhWk13sLJkNcFVrvH2svc8kEQqrFa065Gge/OSiBo+rmz6Huk39Gh1QnKjSchIk72muuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTMY0GcYbBLTZctPnUK/z/R3ID7zD3s50PYhxLe9Mdg=;
 b=ZCNkPX0Y8ErBdzktxHStLv4zMflH4OX5JFpLC0fpLwNiwHoOYVPAU5IiODLvS5j7MCfvbKlhbnn9NTEuOmsNdFaIFHMug6q+q+KqUJvMcqyxz9DHdbSmmyqIQxuwRGQsjRy5M2PNaTwigzpAeunAlERaXjmKusHBLyZ1jjKmDIc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3913.eurprd04.prod.outlook.com (52.134.65.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 02:36:16 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8958:299c:bc54:2a38%7]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 02:36:16 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] pwm: pwm-imx27: Use 'dev' instead of dereferencing it
 repeatedly
Thread-Topic: [PATCH] pwm: pwm-imx27: Use 'dev' instead of dereferencing it
 repeatedly
Thread-Index: AQHVcra4SlIMDowCwkO5fDgX0dE1dKc6lGgAgAADXwCAAAyggIABCfgA
Date:   Wed, 25 Sep 2019 02:36:16 +0000
Message-ID: <DB3PR0402MB3916A7A0C79C10B82B304BAAF5870@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1569315593-769-1-git-send-email-Anson.Huang@nxp.com>
 <6cfb1595992b46dc884731555e6f0334@AcuMS.aculab.com>
 <DB3PR0402MB3916FFD66797DAC0AB1110D8F5840@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <37b2481ac9094f27bf21325e2770abdb@AcuMS.aculab.com>
In-Reply-To: <37b2481ac9094f27bf21325e2770abdb@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 966542ed-75ff-4499-c164-08d741612403
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3913;
x-ms-traffictypediagnostic: DB3PR0402MB3913:|DB3PR0402MB3913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB3913AA66297A44A31AADAA38F5870@DB3PR0402MB3913.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(71200400001)(6246003)(6506007)(186003)(5660300002)(76176011)(6436002)(7696005)(316002)(81166006)(55016002)(99286004)(86362001)(25786009)(2501003)(446003)(26005)(102836004)(229853002)(110136005)(6116002)(52536014)(8936002)(256004)(8676002)(81156014)(14444005)(476003)(66066001)(66946007)(2201001)(66446008)(3846002)(2906002)(76116006)(4326008)(11346002)(9686003)(14454004)(478600001)(66476007)(66556008)(7736002)(33656002)(305945005)(44832011)(486006)(74316002)(71190400001)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3913;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: otlQjttsMe/3TA8fYLn6yB0Nt4RxCdK+hWQAkTzLh+NRPMmm2CpLOdJAek9ohhaDhfo8Vo3/0crbftFZFZIMZl3xSZSbjR9PuRGMunzkvWHkNM8Pz6Av0iXl6zu+qrJa5VNtWvhfo7B31W6JIe5sBQ5tCf8pwNz713kFTkVRtl1WOnm21jMDFHpL0Zzg0aQ+uZwoR0Z0R+CfYWlfLPo/7HOGTIPWYC23XwiqawSSsHYy2MmDYYNoh4yJhoKeGAFpbfdnq7kvjC+qM/pHwDaV0aMUZb91cmwOYm1nQGQu7zbglRnwYswaAFltWAsmQpuTncEN/4keqqEWb1jZ1aHn6w+p53i5j4as4eThrCZC0aQIU1QjT2XbHoNFREXFBcetuyB/bDgvALb+mqya6R6N0vBuu3h6qNFg6JcVP9gRPuo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966542ed-75ff-4499-c164-08d741612403
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 02:36:16.6934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2qjkrbUiVkHnw1imT2VaYrznRiYBDRgUub4oFYSjX1xzliuGItB8yzRC4+uexH4Eq4rDSlmol4ZUe/XfXcrz0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3913
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGksIERhdmlkDQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gcHdtOiBwd20taW14Mjc6IFVzZSAn
ZGV2JyBpbnN0ZWFkIG9mIGRlcmVmZXJlbmNpbmcgaXQNCj4gcmVwZWF0ZWRseQ0KPiANCj4gRnJv
bTogQW5zb24gSHVhbmcNCj4gPiBTZW50OiAyNCBTZXB0ZW1iZXIgMjAxOSAxMTowMw0KPiA+IEhp
LCBEYXZpZA0KPiA+DQo+ID4gPiBTdWJqZWN0OiBSRTogW1BBVENIXSBwd206IHB3bS1pbXgyNzog
VXNlICdkZXYnIGluc3RlYWQgb2YNCj4gPiA+IGRlcmVmZXJlbmNpbmcgaXQgcmVwZWF0ZWRseQ0K
PiA+ID4NCj4gPiA+IEZyb206IEFuc29uIEh1YW5nDQo+ID4gPiA+IFNlbnQ6IDI0IFNlcHRlbWJl
ciAyMDE5IDEwOjAwDQo+ID4gPiA+IEFkZCBoZWxwZXIgdmFyaWFibGUgZGV2ID0gJnBkZXYtPmRl
diB0byBzaW1wbHkgdGhlIGNvZGUuDQo+ID4gPiA+DQo+IC4uLg0KPiA+ID4gPiAgc3RhdGljIGlu
dCBwd21faW14MjdfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgIHsNCj4gPiA+
ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ID4gPiAgCXN0cnVjdCBw
d21faW14MjdfY2hpcCAqaW14Ow0KPiA+ID4gPg0KPiA+ID4gPiAtCWlteCA9IGRldm1fa3phbGxv
YygmcGRldi0+ZGV2LCBzaXplb2YoKmlteCksIEdGUF9LRVJORUwpOw0KPiA+ID4gPiArCWlteCA9
IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqaW14KSwgR0ZQX0tFUk5FTCk7DQo+IC4uLg0KPiA+
ID4gSG9wZWZ1bGx5IHRoZSBjb21waWxlciB3aWxsIG9wdGltaXNlIHRoaXMgYmFjayBvdGhlcndp
c2UgeW91J3ZlDQo+ID4gPiBhZGRlZCBhbm90aGVyIGxvY2FsIHZhcmlhYmxlIHdoaWNoIG1heSBj
YXVzZSBzcGlsbGluZyB0byBzdGFjay4NCj4gPiA+IEZvciBhIHNldHVwIGZ1bmN0aW9uIGl0IHBy
b2JhYmx5IGRvZXNuJ3QgbWF0dGVyLCBidXQgaW4gZ2VuZXJhbCBpdA0KPiA+ID4gbWlnaHQgaGF2
ZSBhIHNtYWxsIG5lZ2F0aXZlIHBlcmZvcm1hbmNlIGltcGFjdC4NCj4gPiA+DQo+ID4gPiBJbiBh
bnkgY2FzZSB0aGlzIGRvZXNuJ3Qgc2hvcnRlbiBhbnkgbGluZXMgZW5vdWdoIHRvIHJlbW92ZQ0K
PiA+ID4gbGluZS13cmFwIGFuZCB1c2luZyAmcGRldi0+ZGV2IGlzIHJlYWxseSBvbmUgbGVzcyB2
YXJpYWJsZSB0bw0KPiA+ID4gbWVudGFsbHkgdHJhY2sgd2hlbiByZWFkaW5nIHRoZSBjb2RlLg0K
PiA+DQo+ID4gRG8gd2Uga25vdyB3aGljaCBjb21waWxlciB3aWxsIG9wdGltaXplIHRoaXM/IEkg
c2F3IG1hbnkgb2YgdGhlDQo+ID4gcGF0Y2hlcyBkb2luZyB0aGlzIHRvIGF2b2lkIGEgbG90IG9m
IGRlcmVmZXJlbmNlLCBJIHVuZGVyc3RhbmQgaXQgZG9lcw0KPiA+IE5PVCBzYXZlIGxpbmVzLCBi
dXQgbXkgaW50ZW50aW9uIGlzIHRvIGF2b2lkIGRlcmVmZXJlbmNlIHdoaWNoIG1pZ2h0IHNhdmUN
Cj4gc29tZSBpbnN0cnVjdGlvbnMuDQo+ID4NCj4gPiBJIHRob3VnaHQgc2F2aW5nIGluc3RydWN0
aW9ucyBpcyBtb3JlIGltcG9ydGFudC4gU28gbm93IHRoZXJlIGFyZQ0KPiA+IGRpZmZlcmVudCBv
cGluaW9uIGFib3V0IGRvaW5nIHRoaXM/DQo+IA0KPiBSZW1lbWJlciAmcGRldi0+ZGV2IGlzIGp1
c3QgJ3BkZXYgKyBjb25zdGFudCcuDQo+IEFzc3VtaW5nICdwZGV2JyBpcyBoZWxkIGluIGEgY2Fs
bGVlIHNhdmVkIHJlZ2lzdGVyICh3aGljaCB5b3Ugd2FudCBpdCB0byBiZSkNCj4gdGhlbiB0byBh
Y2Nlc3MNCj4gZGV2LT5mb28gdGhlIGNvbXBpbGVyIGNhbiByZW1lbWJlciB0aGUgY29uc3RhbnQg
YW5kIHVzZSBhbiBvZmZzZXQgZnJvbQ0KPiBkZXYtPidwZGV2JyBpbnN0ZWFkIG9mDQo+IGFuIGV4
dHJhICdkZXYnIHZhcmlhYmxlLg0KPiBPbiBtb3N0IG1vZGVybiBBQkkgdGhlIGZpcnN0IGZ1bmN0
aW9uIGNhbGwgYXJndW1lbnRzIGFyZSBwYXNzZWQgaW4gcmVnaXN0ZXJzLg0KPiBTbyBhbiBhZGQg
IGluc3RydWN0aW9uIChwcm9iYWJseSBsZWEpIGNhbiBiZSB1c2VkIHRvIGFkZCB0aGUgY29uc3Rh
bnQgb2Zmc2V0DQo+IGF0IHRoZSBzYW1lIHRpbWUgYXMgdGhlIHZhbHVlIGlzIG1vdmVkIGludG8g
dGhlIGFyZ3VtZW50IHJlZ2lzdGVyLg0KPiANCj4gSG93ZXZlciB5b3VyIGV4dHJhIHZhcmlhYmxl
IGNvdWxkIGVhc2lseSBnZXQgc3BpbGxlZCBvdXQgdG8gdGhlIHN0YWNrLg0KPiBTbyB5b3UgZ2V0
IGFuIGV4dHJhIG1lbW9yeSByZWFkIHJhdGhlciB0aGFuIChhdCBtb3N0KSBhbiBleHRyYSAnYWRk
Jw0KPiBpbnN0cnVjdGlvbi4NCj4gDQo+IEV2ZW4gaWYgcGRldi0+ZGV2IHdlcmUgYSBwb2ludGVy
LCByZXBlYXRlZGx5IHJlYWRpbmcgaXQgZnJvbSBwZGV2LT5kZXYNCj4gY291bGQgZWFzaWx5IGdl
bmVyYXRlIGJldHRlciBjb2RlIHRoYW4gaGF2aW5nIGFuIGV4dHJhIHZhcmlhYmxlIHRoYXQgd291
bGQNCj4gbWVhbiB0aGUgdmFsdWUgd2FzIHJlcGVhdGVkbHkgcmVhZCBmcm9tIHRoZSBzdGFjay4N
Cg0KVGhhbmtzIGZvciBkZXRhaWwgZWR1Y2F0aW9uIGFib3V0IGl0LCBwbGVhc2UgaWdub3JlIHRo
ZXNlIHBhdGNoZXMuDQoNClRoYW5rcywNCkFuc29uDQo=
