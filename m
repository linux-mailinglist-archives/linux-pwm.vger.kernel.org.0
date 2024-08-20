Return-Path: <linux-pwm+bounces-3045-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D52957F19
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2024 09:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53DF1C20DF9
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2024 07:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B5118E34A;
	Tue, 20 Aug 2024 07:10:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2098.outbound.protection.partner.outlook.cn [139.219.17.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA9028E8;
	Tue, 20 Aug 2024 07:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137831; cv=fail; b=fl9BELQfvh2e+19NlpxPhBXgky3Nvw5tQxxDEFucq7CVPsTiI0M4MI7FVS/ifNXiL2wqgmcY05Vqs6xnN4pRaMowcFI42CBPXfuTMfF9rMP6vjQL6NVWNScnT0ng29zXi/1+pQyCK3UrOsLAJ7iAM5Y85z4BqoOyBjBvCJ0kLrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137831; c=relaxed/simple;
	bh=1YSI7LK75zklSIN8fQPS5niDCiKOiwae0M3gQR5/Uz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jRWCCN+26eAh5/8Mn8bGZtyVUz3iCGgNezrSD00zBpd26bZHW/05nQbfPPqfXllv8tAif8VwTLKLXQQNSFpQ2LLwYAPzM5mRlYvhf4HRVUsiVCXPsmQGgRY05s8rGSrKPEdjN71uqSyk+RsRTUlcB8zWVr2O4Pid1X6ULyAx9uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knEL/ESoyElBNKViyZYUps9zdq+4Jpx9DTTgZ1tugLl46iSDfvoMDKSd0Euauey1gArfhNOi8vbTmpv4Um8BxFrL8FPWhnfLYhtrOKRIxRVn048yGMj8M65gJjDrPgxq+6Wiy/Pv9Aao8hE28pfN+a9bljMlum49FsiK/s3WpnUXlyZ3hkLS1CuJjDVq8yXE1hwOvy7A5sP5PShbgwhhirz4jEKLHhSsS4IjkAcoI2b4nzvkZPscS2zZOkI+XFyXoLAiPhsWTQo1BfXRFVm/d/ceh5QybIf4MrOnUAjPdNrNJTs2z+LVwNsor4JeXC0+ACvasjs9Pgwr26DxM4Hr+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YSI7LK75zklSIN8fQPS5niDCiKOiwae0M3gQR5/Uz0=;
 b=XwsgIO6R3XoArf4YnOpb7IaXJhvI8BNk4oH/HimZaiGAcUYOPn3B6eM55o6VxAw3G+aC0tZ159uPgZa8cGcV00Z9LY3p5SihmJm+8TvZUyLZwsWEXLsA1zBnMozn81FizGXeOZQrCjMa3bRoATqdQW8IyWEXQih425ajl31+5t/Nl5umXZcM4JuGM0CB729AvDxWa+jlw+x0tIOaMKSGDe0iXQpvb9qvhqpgU2SAtZMgYHL4QlCJE35+HbiJNurlO6ZU1dHzpzlwok2NXXsJFIn/uR95svMbPg2bd/m0Jdy4P8xhtuibLVx2/KEe62+iB4rYQfdJjtTnzWJJApLSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1270.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 06:36:52 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::6e83:b5ba:ad4b:3ad2]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::6e83:b5ba:ad4b:3ad2%4])
 with mapi id 15.20.7875.023; Tue, 20 Aug 2024 06:36:52 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
CC: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>, Hal Feng
	<hal.feng@starfivetech.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH v14] pwm: opencores: Add PWM driver support
Thread-Topic: [PATCH v14] pwm: opencores: Add PWM driver support
Thread-Index: AQHa6khLFQfDBGCji0iMTbyL6D9UbrIe2nuAgBDmnaA=
Date: Tue, 20 Aug 2024 06:36:52 +0000
Message-ID:
 <ZQ0PR01MB12536B55CDD3EFE49DF7DF349F8D2@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
References: <20240809103831.156436-1-william.qiu@starfivetech.com>
 <8ea19aa8-1c01-45ce-81e1-5b34f6738ac3@wanadoo.fr>
In-Reply-To: <8ea19aa8-1c01-45ce-81e1-5b34f6738ac3@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1270:EE_
x-ms-office365-filtering-correlation-id: 0ea26398-f936-4466-92cd-08dcc0e27a36
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|41320700013|366016|38070700018;
x-microsoft-antispam-message-info:
 lF9on0k2DwAy8hB3Z7NX9Y+UZ/vE5LUZOh6WRglcwNxNL5DKVabP57zSazfygJnW/2TUfinhKb9rBy3tDzmdJY6Cs/cy7YcTQ64THAHqNVsaiiWlINMQVUbC9WhOnVg6+xbFDV5zbjT0C48xRYeK+rXAyyI7PzV12k1MYY4G9FFr2S2oioU4FsM85aS7N4G6hRPitNpXE+Ju70BxfAKmRU98pp5v02OmegKNfWTo/WkRUfRlsx8NlJlKjtN/1LM3XuoEKUryZOVAQn4yLyTBlxmeNcarGLM98jUXYEb3ZvodKcB0OJFEYoh6KuhYFnY493Sn28C8Pc3d5LWnRGxwDk0U0WrpfATyuH19mgPZpDBTfMRR1FI88mil3C5yrLRVcXg562exlN8PNtCkgLadmlvNjZJeuAr1UbXQlpm6eTEVcLRmS0qkFbeVqCjDXgTNPp39TcsBdEe5Ow0ZWzZUpykN2ndckAfpF5F+xAai0BH+ovyFeBtvv+uGmdJng5diCVM+HORB8jqXzJeUUyNhoG+Br4sEGrGQNbT0u4T7WAi7/OX5eIjE8YcEubRosMN9DeJ4ur5hTayJbxvcf00PGeVzvdGBBwVt+UhMRxWdvIXYj1sdj+jJl8bY0hm2Op+r
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzlHNHRUcm1ZMndEWlJDRWpIZkhoT3RmR0RZbm1HaWRSRGZXZ1lpczh4MHNn?=
 =?utf-8?B?Yy92VFdTVzhOampoQjFGOUZrYWNhME1ITHA4Y3krZ3VyNUlWNGszNm1yMzZa?=
 =?utf-8?B?WnpNWThsSEozOG9jMzBIZ25kY0trY3pRZUw5azhOM0R5aWdkYlJ6di9ZRnFz?=
 =?utf-8?B?S2s4VWxMbm1KUmpWZ05ONCtkeTlOc3RqRS9mUks3Wko3cUpnOXN4MW5yTG5D?=
 =?utf-8?B?MitaS3RUWTlXM2xvbXpYSWZLUmJsRXF6RTBpMit1UEUyK3F4T2xqdjJzSCt1?=
 =?utf-8?B?RG9ENkxDRDVvejdUWlpSRkdwNTluTXJaWnRMWis3bWVZbEJKRld4UCtCMG1I?=
 =?utf-8?B?OGpFdmFucFNzT0lRZnRYUHd2WEFFYURGVTdCeGJmb0QxYmQxQXRxa0hUdUoy?=
 =?utf-8?B?ZXdLcnQ0MHhYUDJFSm0zbTBxUHBucEMrQy90TE9ocHJlWXc2WDJXdlJ1TG1B?=
 =?utf-8?B?L2NlV04xWnJNQzlHYSs3MmcreU1Bam5WbGlvY0NQNC9JOXlzUmN4T0ljZGpN?=
 =?utf-8?B?UVgrTG9VZnhTeEpUT3E5TDl3MHpYcnRvNWtsbVF3MmtHaDNiTW1TRnNLR2dD?=
 =?utf-8?B?TkIraExuZ1djbjFlU2IxRFlWOHNLbHIxVkV2SUU0RlVFdWlOSTZnenJjNStn?=
 =?utf-8?B?dWxHcWhhL3I1ZmMydHFCS0x3aVp5RTFGMUVFdzhXZlpBU0wvM0VuemVvUXFt?=
 =?utf-8?B?Ymd3QnhxbjJWSGhyTmVxdFMrVHU2QUV2K0tjaGs3cm9Kb2xBVzVSMkRQVlFG?=
 =?utf-8?B?MThvT3FCYTVQeVEwVmNjUjFPNmJtcXdwRlRDaHQvK2Y2NWd2cU44ZGFnblZU?=
 =?utf-8?B?SWRweEt6SnpWbWZSdlVBRU41d1hRbVVaS1lSRzkxZXlkSU9leFg1RkF4RkJq?=
 =?utf-8?B?clpoNzMwZ1F3WDIvaWZ3NUF5RWp0eHhaQkZRMTAxdzJXMkpiTUNpVHB5RHNT?=
 =?utf-8?B?SW5lWWRoYU10bGxUeXZCMEw3eUpOOU5JcXhxMUpoQ3JPZ0RCYjY4Mzg3VGhS?=
 =?utf-8?B?YW8vVjNPeEFJUGI1bzFXbTNzckE1T0pvV2VhM2VSZ2dTcjNiWGxqdDVTb0dZ?=
 =?utf-8?B?VFVXWjNrV0d3M0N6ZjRHVi9NdXI1bkZHNE9oZ2lKbTZscm1nUVl1Qk0wRndX?=
 =?utf-8?B?V3FLQTNydTQxMTBGWks1cytQVDZVMDBJRjZoYk1QeHFPMDE2WVVKUkQ2ZHFk?=
 =?utf-8?B?cmhXM0FYdU9XRGJSOFVwVlcyamJoWGJXWjJHbHRvOUNnSGpLNGRJMTVBTHUr?=
 =?utf-8?B?bDBONHArZW1DU3M1MlhxOVVhK3F2QW5SdXFNQlAvY0h1ekpac08xc1VOSkxp?=
 =?utf-8?B?S1FLTXdqTzZmMkVwanNBRmFOT1RYMFpZSE1yNDU2QlptT1lacWpMWUVzNjhY?=
 =?utf-8?B?enZCdkhucWNCZFZwRVBBYmRpMjg1VnJrV2pYMDFUWll4c05EdC8wY3hLTmRD?=
 =?utf-8?B?bndwTkpzR2hOZ0x1OFdBa2JodUpYc1g0azdkMTIvZUpZWGVoT3JZaVJJY0FN?=
 =?utf-8?B?Ny84bTRLeWkrdjlGV3J1WGt2RXRMZ3hUNnlreHBnOEFRRkd6QU9NY1dFQTUw?=
 =?utf-8?B?VkVUd0d5RzI5UW1vcm0ycExRSSszV0M0SXVzbE0xeG9tYzgyN0hhaDJ5b0dp?=
 =?utf-8?B?cGl3bmpNaEFQMDVoVUtaanM5bHJvVzhVSEZOS0l6aE9BSmp2S1FjNG5ZcmY4?=
 =?utf-8?B?R3dUcm8wTzNRbDc1N0FoTkw5djlIbWc5ZDF6LzBhYWZZOGQ3TFBCKys0ZUpo?=
 =?utf-8?B?YnpsZDFXMkJjKzQ5YjdhL2pvZVM1eFVNQlN5WHgybFMvWU1rbkpwT2tRdmlQ?=
 =?utf-8?B?STVqWVd5dTQxWHQ0KzFTYXNXd3ZUK3hTckI5a3BqbHNxMVE2SWpWekYyVkZG?=
 =?utf-8?B?Y0NWeFptZkRDaUM1ZHR5a004UFNoYS83M3lVMzRpVzducmVzLzlzSU1CYmYw?=
 =?utf-8?B?TXU3VWszYm5aNlArMEFyTlRTOFFNQ0grNDNESzhRK2tHRHRQQ2l2L2FLbW9y?=
 =?utf-8?B?NjBUV3huWllxYkQ2N3ovWG1WclgxWCtMOTFYL1FNanhuTjkydXBuYU10NEJ5?=
 =?utf-8?B?cU4vczVuQ0g1VnJWbDVLUnZ4SGxocFd1Ulp2cndRdDJjVzhMZXl4bDJHYjNy?=
 =?utf-8?B?bFdEVkR0RDIxM3lNcjZ3aDBxU0RjTkk3Z3laYk12NzRnaTFob1R4ZFZudFhh?=
 =?utf-8?B?ZGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea26398-f936-4466-92cd-08dcc0e27a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 06:36:52.4993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUu3RzZ6pQkkmTzCzPUIu3PTQPAk6v150wvgyYhWlGDs0BG475d67kMzWP0cEbBk3daAIQr2q9vbkYYpQWW5+tBmfBhTHGYejrjlE2vOsIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1270

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3RvcGhlIEpBSUxMRVQg
PGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZyPg0KPiBTZW50OiAyMDI05bm0OOaciDnml6Ug
MjA6MjgNCj4gVG86IFdpbGxpYW0gUWl1IDx3aWxsaWFtLnFpdUBzdGFyZml2ZXRlY2guY29tPjsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtcHdtQHZnZXIua2VybmVsLm9y
Zw0KPiBDYzogVXdlIEtsZWluZS1Lw7ZuaWcgPHVrbGVpbmVrQGtlcm5lbC5vcmc+OyBIYWwgRmVu
Zw0KPiA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT47IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxA
cGVuZ3V0cm9uaXguZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjE0XSBwd206IG9wZW5jb3Jl
czogQWRkIFBXTSBkcml2ZXIgc3VwcG9ydA0KPiANCj4gTGUgMDkvMDgvMjAyNCDDoCAxMjozOCwg
V2lsbGlhbSBRaXUgYSDDqWNyaXTCoDoNCj4gPiBBZGQgZHJpdmVyIGZvciBPcGVuQ29yZXMgUFdN
IENvbnRyb2xsZXIuIEFuZCBhZGQgY29tcGF0aWJpbGl0eSBjb2RlDQo+ID4gd2hpY2ggYmFzZWQg
b24gU3RhckZpdmUgU29DLg0KPiA+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBIYWwgRmVuZyA8aGFs
LmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWwgRmVuZyA8aGFs
LmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXaWxsaWFtIFFpdSA8
d2lsbGlhbS5xaXVAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gDQo+IEhpLA0KPiANCj4g
Li4uDQo+IA0KPiA+ICtzdGF0aWMgaW50IG9jb3Jlc19wd21fYXBwbHkoc3RydWN0IHB3bV9jaGlw
ICpjaGlwLA0KPiA+ICsJCQkgICAgc3RydWN0IHB3bV9kZXZpY2UgKnB3bSwNCj4gPiArCQkJICAg
IGNvbnN0IHN0cnVjdCBwd21fc3RhdGUgKnN0YXRlKSB7DQo+ID4gKwlzdHJ1Y3Qgb2NvcmVzX3B3
bV9kZXZpY2UgKmRkYXRhID0gY2hpcF90b19vY29yZXMoY2hpcCk7DQo+ID4gKwl1MzIgY3RybF9k
YXRhID0gMDsNCj4gPiArCXU2NCBwZXJpb2RfZGF0YSwgZHV0eV9kYXRhOw0KPiA+ICsNCj4gPiAr
CWlmIChzdGF0ZS0+cG9sYXJpdHkgIT0gUFdNX1BPTEFSSVRZX0lOVkVSU0VEKQ0KPiA+ICsJCXJl
dHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArCXBlcmlvZF9kYXRhID0gbXVsX3U2NF91MzJfZGl2
KHN0YXRlLT5wZXJpb2QsIGRkYXRhLT5jbGtfcmF0ZSwNCj4gTlNFQ19QRVJfU0VDKTsNCj4gPiAr
CWlmICghcGVyaW9kX2RhdGEpDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsJ
aWYgKHBlcmlvZF9kYXRhID4gVTMyX01BWCkNCj4gPiArCQlwZXJpb2RfZGF0YSA9IFUzMl9NQVg7
DQo+ID4gKw0KPiA+ICsJb2NvcmVzX3B3bV93cml0ZWwoZGRhdGEsIHB3bS0+aHdwd20sIFJFR19P
Q1BXTV9MUkMsDQo+ID4gKyh1MzIpcGVyaW9kX2RhdGEpOw0KPiA+ICsNCj4gPiArCWR1dHlfZGF0
YSA9IG11bF91NjRfdTMyX2RpdihzdGF0ZS0+ZHV0eV9jeWNsZSwgZGRhdGEtPmNsa19yYXRlLA0K
PiBOU0VDX1BFUl9TRUMpOw0KPiA+ICsJaWYgKGR1dHlfZGF0YSA8PSBVMzJfTUFYKQ0KPiA+ICsJ
CW9jb3Jlc19wd21fd3JpdGVsKGRkYXRhLCBwd20tPmh3cHdtLCBSRUdfT0NQV01fSFJDLA0KPiAo
dTMyKWR1dHlfZGF0YSk7DQo+ID4gKwllbHNlIGlmIChkdXR5X2RhdGEgPiBVMzJfTUFYKQ0KPiA+
ICsJCWR1dHlfZGF0YSA9IFUzMl9NQVg7DQo+ID4gKwkJb2NvcmVzX3B3bV93cml0ZWwoZGRhdGEs
IHB3bS0+aHdwd20sIFJFR19PQ1BXTV9IUkMsDQo+ID4gKyh1MzIpZHV0eV9kYXRhKTsNCj4gDQo+
IEkgZ3Vlc3MgdGhhdCBzb21lIHt9IGFyZSBtaXNzaW5nLg0KPiBCVFcsIGRvZXMgaXQgZXZlbiBj
b21waWxlIHdpdGhvdXQgaXQ/Pz8NCj4gDQpJdCBkb2VzIG1pc3Mge307IFdpbGwgYWRkIGl0Lg0K
PiA+ICsJZWxzZQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiANCj4gV2hhdCBpcyB0aGUgdXNl
IG9mIHRoaXMgZWxzZT8NCj4gZHV0eV9kYXRhIGlzIGVpdGhlciA8PSBVMzJfTUFYIG9yID4gVTMy
X01BWC4NCj4gT3IgSSBtaXNzZWQgc29tZXRoaW5nPw0KPiANCj4gTWF5YmUganVzdCBzaW1wbGlm
eSB0aGluZ3MgYW5kIHdyaXRlIHNvbWV0aGluZyBhcyBkb25lIHdpdGggcGVyaW9kX2RhdGEganVz
dCBhDQo+IGZldyBsaW5lcyBhYm92ZT8NCj4gDQpXaWxsIHVwZGF0ZS4NCj4gPiArDQo+ID4gKwlj
dHJsX2RhdGEgPSBvY29yZXNfcHdtX3JlYWRsKGRkYXRhLCBwd20tPmh3cHdtLA0KPiBSRUdfT0NQ
V01fQ1RSTCk7DQo+ID4gKwlpZiAoc3RhdGUtPmVuYWJsZWQpDQo+ID4gKwkJb2NvcmVzX3B3bV93
cml0ZWwoZGRhdGEsIHB3bS0+aHdwd20sIFJFR19PQ1BXTV9DVFJMLA0KPiA+ICsJCQkJICBjdHJs
X2RhdGEgfCBSRUdfT0NQV01fQ05UUl9FTiB8DQo+IFJFR19PQ1BXTV9DTlRSX09FKTsNCj4gPiAr
CWVsc2UNCj4gPiArCQlvY29yZXNfcHdtX3dyaXRlbChkZGF0YSwgcHdtLT5od3B3bSwgUkVHX09D
UFdNX0NUUkwsDQo+ID4gKwkJCQkgIGN0cmxfZGF0YSAmIH4oUkVHX09DUFdNX0NOVFJfRU4gfA0K
PiBSRUdfT0NQV01fQ05UUl9PRSkpOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+
IA0KPiAuLi4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgb2NvcmVzX3B3bV9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KSB7DQo+ID4gKwljb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICpp
ZDsNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKwlzdHJ1Y3Qg
b2NvcmVzX3B3bV9kZXZpY2UgKmRkYXRhOw0KPiA+ICsJc3RydWN0IHB3bV9jaGlwICpjaGlwOw0K
PiA+ICsJc3RydWN0IGNsayAqY2xrOw0KPiA+ICsJc3RydWN0IHJlc2V0X2NvbnRyb2wgKnJzdDsN
Cj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJaWQgPSBvZl9tYXRjaF9kZXZpY2Uob2NvcmVz
X3B3bV9vZl9tYXRjaCwgZGV2KTsNCj4gPiArCWlmICghaWQpDQo+ID4gKwkJcmV0dXJuIC1FSU5W
QUw7DQo+ID4gKw0KPiA+ICsJY2hpcCA9IGRldm1fcHdtY2hpcF9hbGxvYygmcGRldi0+ZGV2LCA4
LCBzaXplb2YoKmRkYXRhKSk7DQo+ID4gKwlpZiAoSVNfRVJSKGNoaXApKQ0KPiA+ICsJCXJldHVy
biAtRU5PTUVNOw0KPiA+ICsNCj4gPiArCWRkYXRhID0gY2hpcF90b19vY29yZXMoY2hpcCk7DQo+
ID4gKwlkZGF0YS0+ZGF0YSA9IGlkLT5kYXRhOw0KPiA+ICsJY2hpcC0+b3BzID0gJm9jb3Jlc19w
d21fb3BzOw0KPiA+ICsNCj4gPiArCWRkYXRhLT5yZWdzID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFw
X3Jlc291cmNlKHBkZXYsIDApOw0KPiA+ICsJaWYgKElTX0VSUihkZGF0YS0+cmVncykpDQo+ID4g
KwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKGRkYXRhLT5yZWdzKSwNCj4gPiAr
CQkJCSAgICAgIlVuYWJsZSB0byBtYXAgSU8gcmVzb3VyY2VzXG4iKTsNCj4gPiArDQo+ID4gKwlj
bGsgPSBkZXZtX2Nsa19nZXRfZW5hYmxlZChkZXYsIE5VTEwpOw0KPiA+ICsJaWYgKElTX0VSUihj
bGspKQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihjbGspLA0KPiA+
ICsJCQkJICAgICAiVW5hYmxlIHRvIGdldCBwd20ncyBjbG9ja1xuIik7DQo+ID4gKw0KPiA+ICsJ
cmV0ID0gZGV2bV9jbGtfcmF0ZV9leGNsdXNpdmVfZ2V0KGRldiwgY2xrKTsNCj4gPiArCWlmIChy
ZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwlyc3QgPSBkZXZtX3Jlc2V0X2Nv
bnRyb2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZShkZXYsIE5VTEwpOw0KPiA+ICsJaWYgKElTX0VS
Uihyc3QpKQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihyc3QpLA0K
PiA+ICsJCQkJICAgICAiVW5hYmxlIHRvIGdldCBwd20ncyByZXNldFxuIik7DQo+ID4gKw0KPiA+
ICsJcmV0ID0gcmVzZXRfY29udHJvbF9kZWFzc2VydChyc3QpOw0KPiA+ICsJaWYgKHJldCkNCj4g
PiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCXJldCA9IGRldm1fYWRkX2FjdGlvbl9vcl9y
ZXNldChkZXYsIG9jb3Jlc19wd21fcmVzZXRfY29udHJvbF9hc3NlcnQsDQo+IHJzdCk7DQo+ID4g
KwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJZGRhdGEtPmNsa19y
YXRlID0gY2xrX2dldF9yYXRlKGNsayk7DQo+ID4gKwlpZiAoZGRhdGEtPmNsa19yYXRlID4gTlNF
Q19QRVJfU0VDKQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgZGRhdGEtPmNsa19y
YXRlLA0KPiANCj4gRG9lcyBpdCB3b3JrPw0KPiBJIHdvdWxkIGV4cGVjdCAtRUlOVkFMLg0KPiAN
CldpbGwgdXBkYXRlLg0KPiA+ICsJCQkJICAgICAiVW5hYmxlIHRvIGdldCBjbG9jaydzIHJhdGVc
biIpOw0KPiA+ICsNCj4gPiArCXJldCA9IGRldm1fcHdtY2hpcF9hZGQoZGV2LCBjaGlwKTsNCj4g
PiArCWlmIChyZXQgPCAwKQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAi
Q291bGQgbm90IHJlZ2lzdGVyIFBXTSBjaGlwXG4iKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsN
Cj4gPiArfQ0KPiANCj4gLi4uDQo+IA0KPiBDSg0KVGhhbmtzIGZvciB0YWtpbmcgdGltZSBmb3Ig
cmV2aWV3IHRoaXMgcGF0Y2guDQoNCkJlc3QgUmVnYXJkcywNCldpbGxpYW0gDQo=

