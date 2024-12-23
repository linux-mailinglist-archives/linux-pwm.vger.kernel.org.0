Return-Path: <linux-pwm+bounces-4452-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484C09FAD19
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 11:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDAF163B93
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 10:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA728190068;
	Mon, 23 Dec 2024 10:21:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29259157E9F;
	Mon, 23 Dec 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734949310; cv=fail; b=OVWk9PcYoJu0xNUj9lG8SjylosXot6wryoEh6RqdaW+wwZHIFCmNE9j3r4fLpJT8v/83UvAEZDDHKzVCR0wPfSA8ICBRlut8ildzXIicUA+TOdBj3Qu4ZxmGayFaKzPWGlGcp3xKw30e5ICO4ZXAhgDSrcwxDcL2USXOVS81Y6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734949310; c=relaxed/simple;
	bh=hDAwvSo2vb+jSvUZWWi06zo1gQEcOOjt6NDE+xlzytc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UFB/WVx3xIG+APijUtSW6h2SyemoTe8+HeTKQpCAqkjY+I7z8zsbKkMzp2Mc6IvDl5RYCTpBWMYSVt9Y6J/uThy8yj+wethjJfTzx+jYwjka341V4vBpjKClrwjWAAspbkCz07/szC2S36QS74TdW5w+Tv63vmxA3jHM3qMdPgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ch4aip1I00/nMWHq/NTWyNblT/siRmhuGJKQ6jIvqlj19ko3jSe9IFjISnUhmwbW6qywmAK7OfugDfdqoZ83fB+rAv7TLPlh/RL5zG27BBa8hSkPq71W9l7sVCgl7JxwfqbES0ozofhCkiPoQLu98LPO4ykWYVNg4FCTsagLzR1oAOkYy3R+OYWUqRmOhX7Vynzo3nFJXoETXaM27x/YOcNO6ZrTm1kav2u+NzvotSquIEFdQLtd+QUV0utzY5ejvYKD/eCpRNp+8O/vmyU3nXzxZDrOoRmT/h7/TjleRKuRDL/Zo9d7JGJtKukwyTgoqGjPD7/PFd8tv9qlJVnjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDAwvSo2vb+jSvUZWWi06zo1gQEcOOjt6NDE+xlzytc=;
 b=khalCr8/UjFE05J3F1NbI36ZQBlMdnd4+vzm/JqwC/Yn9kLakWPniiB+t/Azg87J6mizFAr/SE+TPqsxLPF71Nx9mfALhQ/GBE76UkU7X3de4L39YXXnOg3JvFBxcZoO3fr0o/HV4iPvRVw8llam5TYMU0dGrP8EJlym0oQ5G+kEwaWCzjmhRU+jNLWWAtHK8KrAQU9JMsYWUlFM44FJZu08Ha0NoohaQ4bPlPJ7t/ZWHebtctK1wIKjBgojZ6W78AYG79SAJalk7eLx7E2U/sZ9w1EgIl6dQGadPiEpyf8V0hxLucMJJODIeV2oTZAfJHUVX4F6ijGPTh8NeY3UmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1045.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Mon, 23 Dec
 2024 02:47:59 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::6e83:b5ba:ad4b:3ad2]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::6e83:b5ba:ad4b:3ad2%5])
 with mapi id 15.20.8272.013; Mon, 23 Dec 2024 02:47:59 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Hal Feng
	<hal.feng@starfivetech.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH v16] pwm: opencores: Add PWM driver support
Thread-Topic: [PATCH v16] pwm: opencores: Add PWM driver support
Thread-Index: AQHbKNsymVbYlUSgHUKyRrqbTLJ87bLuYDMAgAUWdxA=
Date: Mon, 23 Dec 2024 02:47:59 +0000
Message-ID:
 <ZQ0PR01MB1253A5B870FF90900A2643009F02A@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
References: <20241028014609.153997-1-william.qiu@starfivetech.com>
 <bfwpcffdrxqjes4atio6deltu5tgmd4ing7j4yewwp6jprqmmc@rv2x3qudlzo3>
In-Reply-To: <bfwpcffdrxqjes4atio6deltu5tgmd4ing7j4yewwp6jprqmmc@rv2x3qudlzo3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1045:EE_
x-ms-office365-filtering-correlation-id: 74c1be3f-09b2-48fc-aac9-08dd22fc3647
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|41320700013|38070700018;
x-microsoft-antispam-message-info:
 py0FZBVwxMu0KLRKoi50QjT8QOeDQmoNErZrrphto1uzOte0LXlIVQdea+Iv5aMczHxsyZSwE5+JpFZ8MyONPj6lcMw0l3YkVNDBFrfl+mk+B+yKAz/PpP/YTaL58NGFEOJe1XOyXn13WGLRGlQvrWjkijQeS69i2kTnh8AgF25qTxhxwXEpkC1plPjjo73LG8JO0kkxrXTWy47pJVpk338yIzPdJWmOB/ykIUvq+2+v4GftwZ9S+o3PKscQZVzWaRQ7/MKJLla4zgTmQXg6jY3HmIDSBsgfziSmYvqFdZGDYwqyYwHWlj8w4XSe4VlQGJ4uWnuAlkxFpDKZxV9DpU/Ro45PxnJ0fWdwmO7VUR00ygNeRdtnQ1wEOFbPZN8BOPABz8J1k6be/K0i4+aOkWvVQDRcnms1JFxtJrEKSyK3UslIEIrJiUQSmo0boLq0K1h4dZZ/CgByHQcKL9w63nf1XsCh433o0Y2R+6pyWrdNjuGDwCXKgsibewon/oiI3gA7iey4/ukW/8+b3+eUuOoeLZcb/LltWm67hTUOtzTyw7l3Tdl8pGBXAtrxaInI5pNx1Octh0DCO2pz5HoTaSo6PCcHEbBb3zpY5MUhao8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(41320700013)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzNCcFZnRit6dXJCYkh1ZjltZWxndFJ6V250S1FTRlRBVVdObTIxVEF6OS9p?=
 =?utf-8?B?bjduL0oxZTNxVHFvSGNQejA5UVpmSlNvaWNzYjZibkpDcEZKelVyc0ZaV1Jx?=
 =?utf-8?B?UGxaVjFKUGZtVlVQVFF6VG9NaVdTUnozdEJ2Y3lRQmtCMkgvSU9pVUlMdlo0?=
 =?utf-8?B?M2FSMU5kM2dvZEUwUEZjZUpXOHN6Vzg0QmhLdG1yV2NNMWRqRzhMNVFLYWUv?=
 =?utf-8?B?d2h5NDdDUjhiSWN5ZW03QVkxNllXUlVza0psNVh4K3dmWVlqM0RoMDBDMVRP?=
 =?utf-8?B?NzR4WkFoaWdyalRSODQyelUzWW15bEJkUUF1YWJaTEZGbnRhOTBLS1dBL0tJ?=
 =?utf-8?B?ejEyR1FKWDBwQ1pGV0lxVXRGVVBtSWdXOVJic2dRcDNrNzh0alhIT2pVOXBU?=
 =?utf-8?B?MGwyakZUcE1COUs4djhESFl0eVFqcC9hU2tEdnJQVkw5RWV2aVJtb01SYlFk?=
 =?utf-8?B?MlpOTUo4ay8xdXZqWU5BakdNOTRYYnE3OEk1R3NWMUsza1NselNsUmJpeEwv?=
 =?utf-8?B?QlR0UzdDdEJPaVkzZUVldVBIdGRmVHptbUg1WGhNM1AwclhGTXhIanBxRnZC?=
 =?utf-8?B?SitoNXZBdDJRc1NKZ1B4NytpcDFCTTJHNkVzYjErWjh0WTQzZXd4cTVlZDRw?=
 =?utf-8?B?cE9xRlR5RFJEU3RKb2oraDRWUXR2SFFsaWZpVDl6aWhOMXdaZEp2TUloUXBY?=
 =?utf-8?B?QmREZ3FRbXFBR3E2eVVhS3dXU0hMbnF5MVAyWWIyRnFNTzcyc3d6ZmdYRDhO?=
 =?utf-8?B?QjdzVDJ1ZS93dnFsNVVwbDFEK3FEQjMvcUduNDNzaURqWTUwVmlmbnJMNlFo?=
 =?utf-8?B?bTlYK2NpQ1dua0ZaT3gyWTVuUzNUYlgyaGlHYjVJamE4MnF1cG5YN3R2cXh6?=
 =?utf-8?B?YU44citIM1J5ak0xWXBVVVRoQ2VrSzIzc05iajNhMmxoL3UzTlA2TFkrQU5v?=
 =?utf-8?B?S3JqVUVkS3lra0kxWWxCTnl2K1g4MHo0eDRBSzVoZjBNZVVQemVmenR4VE9R?=
 =?utf-8?B?REYrYVRsdzR2TktPdUJvUHJOdTBHZW9BSDJmOGVPK3pMYnlua1FoNTR5RWg2?=
 =?utf-8?B?eUJyQUwxMHJLMGNLSnZsdm1XTGtjZzRudlkrRzNjcUE2ZU1GWDVkNStDdmhm?=
 =?utf-8?B?MWplWm5iTXBXUk9STk1taCtJdkZOUnQvUFVOeHdNQnprcDBJWlFsbGRuUEFH?=
 =?utf-8?B?NVd1a0NCbHU0Uzl2ZGVCaGo0Tjh1dmFNK2JQRmIrMWRmc2hCbEl5eVJnQTZw?=
 =?utf-8?B?UVBBNEtBQjNCMTVmNC9NV1VPdlhEcEpDTkhKUE03RnF1amVSL3pNOWF6bExG?=
 =?utf-8?B?R0F5aENvSkJMcEd1ZWpKL3MwbmZBWG1OQ094UnQ1Y25iZGVWTUtRcWFDMXRS?=
 =?utf-8?B?a0VmWHlnOEFpZ0p5LzhHSUF6TEVVOEhINVZtaHV0MWJ3L0FTTk5NaWptSVV2?=
 =?utf-8?B?K3E0TStKNGcvWnBMbS9ZdE0rT1NwV1pLVWhxQjBDYlBBSFF5RW1BUXNvaDl2?=
 =?utf-8?B?d3d1MzExOUVrWTUxY3J6b0dESG50RHhBVE94OFVzOWZ0TUEwQ1lVTDJaemU5?=
 =?utf-8?B?MitOY0Z0cmxFZU1Qb0pSeEgwa2ZSL3hWdDFHRWFoVzRjdzNIN2JtWXBERzVh?=
 =?utf-8?B?cHluc1VFczJTWGRFaFpGdFA0clB4d3NEZE9IRlZObnBqRkR1MHI4VWhKc016?=
 =?utf-8?B?dUZnOVl6NmdiMjRycG85aENSSWpLUlVkeG1XOGF3MlBEOWVBaTMxTmVGbHNo?=
 =?utf-8?B?RE5TS2NockREVEFIeHdINmJHWlBHK0haaGN1MGsvd2lxSDU4bFdoajU3dzJN?=
 =?utf-8?B?clEyUEt6RU9MOWphUURTS2JRTFNia3JMVzl1cVg3clFIQ1JMbkQwZzRnRERp?=
 =?utf-8?B?TTBOMTdWVGZBN2J1cW5wbEdaeERNWkJvR2orYW9sRW5QeDNEaHpkOE1GMVAr?=
 =?utf-8?B?WmowaFRSakJQclV2S0l0SXBoTjJqV0hvNzhlN1pJL0tkNitFWEJJRjE5ZkE2?=
 =?utf-8?B?S1NDV1ZkZDJIY0RUdU91ZmI0dHM0RVF6dTJFaEFoOTR2MzBlcVdIcjJEK0hM?=
 =?utf-8?B?a1U3RXFNRjc2QWNOOFBuL0lMTnZtZzZIVHAwR2pXSjJvamVOVjNwL2RacStu?=
 =?utf-8?Q?jvAI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c1be3f-09b2-48fc-aac9-08dd22fc3647
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2024 02:47:59.4197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrfS3baTlSXtdGJ/lSaqppzK7GPssbv7uLbnRFWhYNZCwKEHmKj63yF5pFGBGfLrU91vDCnxNh+vqN+Vkv9iKGVtbiRvQSeCWA+gTjAFlbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1045

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVd2UgS2xlaW5lLUvDtm5pZyA8
dWtsZWluZWtAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNOW5tDEy5pyIMjDml6UgNTowMA0KPiBU
bzogV2lsbGlhbSBRaXUgPHdpbGxpYW0ucWl1QHN0YXJmaXZldGVjaC5jb20+DQo+IENjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wd21Admdlci5rZXJuZWwub3JnOyBIYWwg
RmVuZw0KPiA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT47IFBoaWxpcHAgWmFiZWwgPHAuemFi
ZWxAcGVuZ3V0cm9uaXguZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjE2XSBwd206IG9wZW5j
b3JlczogQWRkIFBXTSBkcml2ZXIgc3VwcG9ydA0KPiANCj4gSGVsbG8sDQo+IA0KPiBPbiBNb24s
IE9jdCAyOCwgMjAyNCBhdCAwOTo0NjowOUFNICswODAwLCBXaWxsaWFtIFFpdSB3cm90ZToNCj4g
PiArc3RhdGljIGludCBvY29yZXNfcHdtX2FwcGx5KHN0cnVjdCBwd21fY2hpcCAqY2hpcCwNCj4g
PiArCQkJICAgIHN0cnVjdCBwd21fZGV2aWNlICpwd20sDQo+ID4gKwkJCSAgICBjb25zdCBzdHJ1
Y3QgcHdtX3N0YXRlICpzdGF0ZSkgew0KPiA+ICsJc3RydWN0IG9jb3Jlc19wd21fZGV2aWNlICpk
ZGF0YSA9IGNoaXBfdG9fb2NvcmVzKGNoaXApOw0KPiA+ICsJdTMyIGN0cmxfZGF0YSA9IDA7DQo+
ID4gKwl1NjQgcGVyaW9kX2RhdGEsIGR1dHlfZGF0YTsNCj4gPiArDQo+ID4gKwlpZiAoc3RhdGUt
PnBvbGFyaXR5ICE9IFBXTV9QT0xBUklUWV9JTlZFUlNFRCkNCj4gPiArCQlyZXR1cm4gLUVJTlZB
TDsNCj4gPiArDQo+ID4gKwlwZXJpb2RfZGF0YSA9IG11bF91NjRfdTMyX2RpdihzdGF0ZS0+cGVy
aW9kLCBkZGF0YS0+Y2xrX3JhdGUsDQo+IE5TRUNfUEVSX1NFQyk7DQo+ID4gKwlpZiAoIXBlcmlv
ZF9kYXRhKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiArCWlmIChwZXJpb2Rf
ZGF0YSA+IFUzMl9NQVgpDQo+ID4gKwkJcGVyaW9kX2RhdGEgPSBVMzJfTUFYOw0KPiA+ICsNCj4g
PiArCW9jb3Jlc19wd21fd3JpdGVsKGRkYXRhLCBwd20tPmh3cHdtLCBSRUdfT0NQV01fTFJDLA0K
PiBwZXJpb2RfZGF0YSk7DQo+ID4gKw0KPiA+ICsJZHV0eV9kYXRhID0gbXVsX3U2NF91MzJfZGl2
KHN0YXRlLT5kdXR5X2N5Y2xlLCBkZGF0YS0+Y2xrX3JhdGUsDQo+IE5TRUNfUEVSX1NFQyk7DQo+
ID4gKwlpZiAoIWR1dHlfZGF0YSkNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+IEkgY2Fu
IHVuZGVyc3RhbmQgdGhhdCBwZXJpb2RfZGF0YSA9PSAwIGlzIGFuIGVycm9yLCBidXQgZHV0eV9k
YXRhID09IDANCj4gY291bGQvc2hvdWxkIGp1c3Qgd29yaz8hDQo+IA0KSXQgbWVhbnMgbm8gbmVl
ZCB0byBjaGVjayB3aGV0aGVyIHRoZSBkdXR5IGlzIHZhbGlkPyANCj4gPiArDQo+ID4gKwlpZiAo
ZHV0eV9kYXRhID4gVTMyX01BWCkNCj4gPiArCQlkdXR5X2RhdGEgPSBVMzJfTUFYOw0KPiA+ICsN
Cj4gPiArCW9jb3Jlc19wd21fd3JpdGVsKGRkYXRhLCBwd20tPmh3cHdtLCBSRUdfT0NQV01fSFJD
LA0KPiBkdXR5X2RhdGEpOw0KPiA+ICsNCj4gPiArCWN0cmxfZGF0YSA9IG9jb3Jlc19wd21fcmVh
ZGwoZGRhdGEsIHB3bS0+aHdwd20sDQo+IFJFR19PQ1BXTV9DVFJMKTsNCj4gPiArCWlmIChzdGF0
ZS0+ZW5hYmxlZCkNCj4gPiArCQlvY29yZXNfcHdtX3dyaXRlbChkZGF0YSwgcHdtLT5od3B3bSwg
UkVHX09DUFdNX0NUUkwsDQo+ID4gKwkJCQkgIGN0cmxfZGF0YSB8IFJFR19PQ1BXTV9DTlRSX0VO
IHwNCj4gUkVHX09DUFdNX0NOVFJfT0UpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCW9jb3Jlc19wd21f
d3JpdGVsKGRkYXRhLCBwd20tPmh3cHdtLCBSRUdfT0NQV01fQ1RSTCwNCj4gPiArCQkJCSAgY3Ry
bF9kYXRhICYgfihSRUdfT0NQV01fQ05UUl9FTiB8DQo+IFJFR19PQ1BXTV9DTlRSX09FKSk7DQo+
ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiBbLi4uXQ0KPiA+ICtzdGF0aWMgaW50
IG9jb3Jlc19wd21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+ICsJ
Y29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqaWQ7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYg
PSAmcGRldi0+ZGV2Ow0KPiA+ICsJc3RydWN0IG9jb3Jlc19wd21fZGV2aWNlICpkZGF0YTsNCj4g
PiArCXN0cnVjdCBwd21fY2hpcCAqY2hpcDsNCj4gPiArCXN0cnVjdCBjbGsgKmNsazsNCj4gPiAr
CXN0cnVjdCByZXNldF9jb250cm9sICpyc3Q7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiAr
CWlkID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCZwZGV2LT5kZXYpOw0KPiA+ICsJaWYgKCFp
ZCkNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiArDQo+ID4gKwljaGlwID0gZGV2bV9wd21j
aGlwX2FsbG9jKCZwZGV2LT5kZXYsIDgsIHNpemVvZigqZGRhdGEpKTsNCj4gPiArCWlmIChJU19F
UlIoY2hpcCkpDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJZGRhdGEgPSBj
aGlwX3RvX29jb3JlcyhjaGlwKTsNCj4gPiArCWRkYXRhLT5kYXRhID0gaWQtPmRhdGE7DQo+ID4g
KwljaGlwLT5vcHMgPSAmb2NvcmVzX3B3bV9vcHM7DQo+ID4gKw0KPiA+ICsJZGRhdGEtPnJlZ3Mg
PSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7DQo+ID4gKwlpZiAoSVNf
RVJSKGRkYXRhLT5yZWdzKSkNCj4gPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9F
UlIoZGRhdGEtPnJlZ3MpLA0KPiA+ICsJCQkJICAgICAiVW5hYmxlIHRvIG1hcCBJTyByZXNvdXJj
ZXNcbiIpOw0KPiA+ICsNCj4gPiArCWNsayA9IGRldm1fY2xrX2dldF9lbmFibGVkKGRldiwgTlVM
TCk7DQo+ID4gKwlpZiAoSVNfRVJSKGNsaykpDQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUo
ZGV2LCBQVFJfRVJSKGNsayksDQo+ID4gKwkJCQkgICAgICJVbmFibGUgdG8gZ2V0IHB3bSdzIGNs
b2NrXG4iKTsNCj4gPiArDQo+ID4gKwlyZXQgPSBkZXZtX2Nsa19yYXRlX2V4Y2x1c2l2ZV9nZXQo
ZGV2LCBjbGspOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4g
PiArCXJzdCA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfb3B0aW9uYWxfZXhjbHVzaXZlKGRldiwg
TlVMTCk7DQo+ID4gKwlpZiAoSVNfRVJSKHJzdCkpDQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJv
YmUoZGV2LCBQVFJfRVJSKHJzdCksDQo+ID4gKwkJCQkgICAgICJVbmFibGUgdG8gZ2V0IHB3bSdz
IHJlc2V0XG4iKTsNCj4gPiArDQo+ID4gKwlyZXQgPSByZXNldF9jb250cm9sX2RlYXNzZXJ0KHJz
dCk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0
ID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KGRldiwgb2NvcmVzX3B3bV9yZXNldF9jb250cm9s
X2Fzc2VydCwNCj4gcnN0KTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4g
PiArDQo+ID4gKwlkZGF0YS0+Y2xrX3JhdGUgPSBjbGtfZ2V0X3JhdGUoY2xrKTsNCj4gPiArCWlm
IChkZGF0YS0+Y2xrX3JhdGUgPiBOU0VDX1BFUl9TRUMpDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7
DQo+IA0KPiBNaXNzaW5nIGVycm9yIG1lc3NhZ2VzIGZvciB0aGUgdGhyZWUgY2hlY2tzIGFib3Zl
Lg0KPiANCldpbGwgYWRkLg0KPiA+ICsJcmV0ID0gZGV2bV9wd21jaGlwX2FkZChkZXYsIGNoaXAp
Ow0KPiA+ICsJaWYgKHJldCA8IDApDQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBy
ZXQsICJDb3VsZCBub3QgcmVnaXN0ZXIgUFdNIGNoaXBcbiIpOw0KPiA+ICsNCj4gPiArCXJldHVy
biAwOw0KPiA+ICt9DQo+IA0KPiBCZXN0IHJlZ2FyZHMNCj4gVXdlDQo=

