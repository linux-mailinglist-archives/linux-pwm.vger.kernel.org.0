Return-Path: <linux-pwm+bounces-3612-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EFE99B1EE
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 10:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5202840B1
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 08:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C87137742;
	Sat, 12 Oct 2024 08:03:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2097.outbound.protection.partner.outlook.cn [139.219.146.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A06A7EF09;
	Sat, 12 Oct 2024 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728720182; cv=fail; b=FCw4jfPV/IIo+knCl3/FAgeHt0f3jBsCx1LwDri7MIY0NGQEPNwcdNl1pkIMLCNfzWF4IT39tHacH2/z8Ew+bQCzV8NAAdVPb8hq2UfG1tBDygco/9KtkJ/CYdjy6pmNFSxo8Qg/jYIlckRAKhwYETDYYdnWvB9dxEUHZDmi/e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728720182; c=relaxed/simple;
	bh=4xervHejjtGaiQcL64lDeVthjZrEiXYKbQipT6wWi7w=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oEJo7Cgy6AQdfe3Ck1CZZC7juu3UgthGWpl5dJl1fi/dcviPtSJxgdIOUjHfVyZhJ3ovHSCqDKHGdULCAIgp0UV60uqTaGvYxvHIjzdW/E8BfjhM0wP9zf3u39noCgFl04r5pFU7RQQDkdtDTGeVU6lJXI8RbdV/gpSy3o4x2W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkDXVzgcrr6sj8KjLXwjkdDgCm4jVyxXdm1XI02YG9pG3S3OBIYu5hgb6kGeOaZWdupB0a4/XYQeB0w/sp85zzJw+ymRd0y1ry2x742adC+RzeUZJzLHuf/1ejVDWJxUwZjZcx8O3cM8rHXPB/qE/p1h3o1HvqGCudps5Xx0VBPeQEb5t2IJUG+UDCEsi4vguBuPxjXbRgSeyQDcYg/7sndXkOTgBgV3Oot72q5H8wmzVr7Mh6hm2D8wOx9CRQRCfoSBS4+PMp3J7dyanseV2//XjWW2Q3BpPFjzDQdFnuctbu2cjaMTshGjMv4bQzX40/X2q6ydaM10krm9BDDFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xervHejjtGaiQcL64lDeVthjZrEiXYKbQipT6wWi7w=;
 b=a03/9XFKPxsfCvjPUhVHSNPkYtxnyHTMiG94BzTyEw7pcRKMch9RZNZCGqEtCy7m9ieAbIyRRONZBzLYtCglnZpXgdEVenoIBW+yjAnhSUzUtICczBkTadhwEQEQ5NI8yKmTUnKbhor6tSKiSRq3wUQ/Fjq4tVglnrFcmsRDSshVjOCanv1axaF9xG3cqouMz454drZJp0QWkcIgMwI3H53w/yjLiu1bj6K0IftJhbUcd4KiB4eqFWrO6k1DEhnbEMYdMixgymgBnrjkg4TyYkD7t4dMlnJ/gMg5yW9QdOyZxwCQha/iEpQd2e4KbOHifo8zkyQBjkhqHx11wCkxEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Sat, 12 Oct
 2024 08:02:58 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::6e83:b5ba:ad4b:3ad2]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::6e83:b5ba:ad4b:3ad2%4])
 with mapi id 15.20.8048.020; Sat, 12 Oct 2024 08:02:57 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Hal Feng
	<hal.feng@starfivetech.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH v15] pwm: opencores: Add PWM driver support
Thread-Index: AQHbBounjjlcGdtaekWJl+TXMzB5nLJ+OF0AgANNGRCAAWVCsA==
Date: Sat, 12 Oct 2024 08:02:57 +0000
Message-ID:
 <ZQ0PR01MB12538557D7C48C3B2ABEFBA89F7A2@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1302:EE_
x-ms-office365-filtering-correlation-id: aadb62af-6b29-47b0-3ab5-08dcea9448d1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|41320700013|38070700018;
x-microsoft-antispam-message-info:
 rrCklYtidS7t/l7pmMAZOBSw+xqzrlxwGLku20CAYT3lt6bTJyKJP2Owo3XiyM7anqUdkIZ4fNLKVX/362heqvro6k62njndiMo1hkBzXJDdhTgVpTf0KtMQvAqZ5iP7IUsuNPTMdXQoLQ546VMFkOlpUchmTAgqKE5Oe7pe48wuEEKbS1TNwrF1PoYAFaPKiNjb1kLpk5L+yWKNLp0R4FAiHPI/mjrbQW7F27DXDzEc5cdz7BcBU7somLJCEg4mopbK7znBvwUsZOcxzXS1DOUTUnFacm0Gcaj5kUeZDzxTZYjtgSDJ7AwwTZ46qQzy2U8jrar9xBIzvzhcFBWxI6leAu1uaW3hzXTmhEYPR4B21sCZIlqbKq2MtW4+U4a9MxQqyzRduccZR+XR+haeK0kIgPhjyChbJ+Hf0P+J3ryZRBIqfqblLrbMPY3PwBDrCwQPN1yaw5+sJ3GyOTwvpZYZR2b0/ioFHR+s2YpRn7ASnZJt77m2d18cPLEt86coHKeIPSJiIljngsRnsdIYfk1haafHEpdvdYM+QUsXt9vbg+XjnVaozOGMgzVz9aP1nmHhjVcInZCtP0z/f97unLKCuig9olqTBHO4katZEuKybdvtUmCJEnoYw0SXYbom
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(41320700013)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkkzUkJjR0x3YlFFYWxGZm1jWmdIZFpVNDYrVzByNjg4OHdBODBVK25CR0E2?=
 =?utf-8?B?TWRaUit0QTNsL0YxalhPeXdyRE83bzVUL081SmIyTjhxSkxOODNYYzE3a1d1?=
 =?utf-8?B?ekZhZWdYTHk4enRiMmd5UThESldWRFBmS0VRM1FjVVdydFpyaTdlUG81Sk1D?=
 =?utf-8?B?dmR2YVhIeHVKZzBVK2c2Qmk1OHArVXlZd05uZDZiQjErQkZVZStnZkh5TEF2?=
 =?utf-8?B?MElOYkJkL2xNb3dsTUJMYXQvR0R1TFhoMkpPWDVXMEZnN0p1TktHZHoyZkF5?=
 =?utf-8?B?Z1NBdWYvV25uVWVIY3pZdjZqYlNFeTlROUs5S2tBdFBhV3pKcUFCMDh2YnpI?=
 =?utf-8?B?RUxIY241WmlCZHA1aEd6Q2ZCZDhNMjAwc0F3MkY0bzM4TVFYdW1YM3ltYkwy?=
 =?utf-8?B?dTZQZDk3V1VMRHRYVW1EZHdQMFhxMVVDUEtHNDNKMlViQ3hFeVhWcUp3QlZJ?=
 =?utf-8?B?aG1pRStWemhpR21VNTRDNHlmSzFaSGs3aGVPWFdKcWI1TjRtMDgrWFAwanZx?=
 =?utf-8?B?VkFxdnJqK3JHY0Z3SThrZDZPM2EycHk1Vk5yQ2FONEhHcVBSK1BJMTBVaWhG?=
 =?utf-8?B?NDY4M2hnRjZiOVB0SWpsWXg4ems2VGZmY0VrY3ZsUmx2SFVYTzNiTDRJVFB3?=
 =?utf-8?B?NXdXc2pQYnk2N0FwTlRONVQydkN1d2JjcnVHbys4bjU5cG5tZGEwNGxXbDNz?=
 =?utf-8?B?WEFORkNPOU5tS2M5SGsrbG1rMkNrOERFNkNZRWI0NTlrWDdjU3ZZYmFFNVBC?=
 =?utf-8?B?K0h0WUx0VzRQeDlST3M3Tm9OTEdud0tQVlphTkpLbk5nMFAxeDlrZnZySWsy?=
 =?utf-8?B?ZVhjQXE5bzd1TmNoNklJRk9NeUcrRlp6MTZEU3AzTTU0RFpNaWZJTjRPMnJ1?=
 =?utf-8?B?WkVJblJsZDVTc3ByNlhHeWRpMmtrbHdudmpqdGQ2SjlwZitvS3RVU3dOMGp3?=
 =?utf-8?B?ZlUzV2lrQU5oS3lOcjhLQ0FZVmhDZDA1SkFMM1dDSVZoWnBIOTZONTBSS2tw?=
 =?utf-8?B?TEV2WGtrVFJoUXkyR2U3WURCeVVPVFVZaVJHdUZwWjRVMEdjRmRrdGRXeUQ2?=
 =?utf-8?B?OHNlbjlPTUl6ZVFRZmtSVTBvVHluczZIcDRkaWo2MjRMVVlFRUZRaithM3RV?=
 =?utf-8?B?SFVQZlJWRmFsaUxTM2tYRUcxNEVxS3lIalBuSU5kSEJJTjVtWWZQQWdlQ2Rz?=
 =?utf-8?B?VHVGT24zdkY3TnBRRUxwUTZLNlFvWjJIOHpxWEQ0UUFUaDk5eVZPTDEvRjRF?=
 =?utf-8?B?RldCM0lSWkJwc1NPd3cyWGFna0lDUHhZQzFpMWVNY1FFc0xyYmVEYUNCL0pX?=
 =?utf-8?B?YzhweWhYR01vMlNxaG1FZ0RnUThUZU00NXc4UFBMZGRTUUo3Kys0aDFvVkcy?=
 =?utf-8?B?S0YwUDNEZzEyU1NEVGZWSTg4aGd4ZnJWaVIwa2ZRbmc0Q1A5dFBFdTErZHph?=
 =?utf-8?B?OFYwL0JrTXNQbmhJWG9PaEx2eGdoekl3a0R2d3I4VzRFY1EzNG1UcXQ1ajZo?=
 =?utf-8?B?V1pNa3hTcnJUUmZUOUtqY0U2N1FGUmJDLzd3OVd3STdKTC9acURWbDZTTzU5?=
 =?utf-8?B?UTNrNncyWTdUN2w5L1RYQVB4bE52am1vNk1FZjZaWGdKdnQzUW9GbEFOeHk1?=
 =?utf-8?B?RDA4ZDREelBMbmhmZlEvZy83cE82Z0hJQkJPckdyVkRMbWVqRFc1SlUrSG5x?=
 =?utf-8?B?S2FhaEhPS2dIcTNNakZjREdQZ1VtcXFjVm5UeWpSSXFJdWN1dmJzU04wemdz?=
 =?utf-8?B?QjRtQVVIcGxxMUF4c0dGN1d1cHFJbE5DUGIwRmF1T0FJeVFRNVE4MjFUM2F3?=
 =?utf-8?B?Rk9EM3A0NUFyeFRGSy9JUVF0ZC9tNE5VUzBEdjZQVFV4czFzWlNMTm1UTUtv?=
 =?utf-8?B?N045QlhORUk5LzZTaW9Jc1Z5Y3U2ZXYrcmI2bTFqZGF2SEt6WnpPREhxZHNR?=
 =?utf-8?B?anhmNkN2STNUOGZPQmJWTHdQODlLejBuS0hGTkM4a29KVlJleHVSWmFvMzRD?=
 =?utf-8?B?VU5KOWMxSG96SWdBRTAyRnArL3ZqcHZ6QlorSkFyK3IyVndpUjNJdStmUWo0?=
 =?utf-8?B?WkJqMW5rbTRTYjhkM2JVN2FxdHhzMlRiUVYxRCt5Slh5NWZUa0xBbDZkdHFS?=
 =?utf-8?B?cy8vOXVIS0NtL3lNbHNYc0wzbDVlbjkrWjR6RURqZnMyYklzaXRMS0s5OFd6?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: aadb62af-6b29-47b0-3ab5-08dcea9448d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2024 08:02:57.7027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3wKZoo1euDodlMs9+HI+h9meoPpuBRzW0Yin15Z7CMlDjry/vyfMTZ2f3xS3WEBzMKcwSFP77NSZaYnmL+wahYxYZKqGYpMKFfwMGsICNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1302

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV2lsbGlhbSBRaXUNCj4g
U2VudDogMjAyNOW5tDEw5pyIMTHml6UgMTg6NDMNCj4gVG86IFV3ZSBLbGVpbmUtS8O2bmlnIDx1
LmtsZWluZS1rb2VuaWdAYmF5bGlicmUuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtcHdtQHZnZXIua2VybmVsLm9yZzsgSGFsIEZlbmcNCj4gPGhhbC5mZW5n
QHN0YXJmaXZldGVjaC5jb20+OyBQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRl
Pg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYxNV0gcHdtOiBvcGVuY29yZXM6IEFkZCBQV00gZHJp
dmVyIHN1cHBvcnQNCj4gDQo+ID4gK3N0YXRpYyB2b2lkIF9faW9tZW0gKnN0YXJmaXZlX2dldF9j
aF9iYXNlKHZvaWQgX19pb21lbSAqYmFzZSwNCj4gKwkJCQkJICB1bnNpZ25lZCBpbnQgY2hhbm5l
bCkNCj4gPg0KPiA+IFdvdWxkIGJlIGdyZWF0IGlmIGFsbCBmdW5jdGlvbnMgaGFkIHRoZSBzYW1l
IHByZWZpeC4gVGhpcyBzaW1wbGlmaWVzDQo+ID4gZGVidWdnaW5nIHdpdGggdHJhY2luZywgYmVj
YXVzZSB5b3UgY2FuIGp1c3QgZW5hYmxlIHRyYWNlcyBmb3INCj4gIm9jb3Jlc19wd21fKiIuDQo+
ID4NCj4gV2lsbCB1cGRhdGUuDQoNCkkgd2FudCB0byBleHBsYWluIHNvbWV0aGluZyBhYm91dCB0
aGlzLiBUaGlzIGludGVyZmFjZSBvbmx5IHdvcmtzIG9uDQpTdGFyRml2ZSBib2FyZHMsIHNvIHRo
ZSAic3RhcmZpdmUiIHByZWZpeCBpcyB1c2VkLCBJIGRvbid0IHRoaW5rIHRoZQ0KIm9jb3Jlc19w
d20iIHByZWZpeCBpcyBhcHByb3ByaWF0ZSBoZXJlLg0KDQpVd2UsIHdoYXQgZG8geW91IHRoaW5r
Pw0KDQpCZXN0IFJlZ2FyZHMsDQpXaWxsaWFtDQo=

