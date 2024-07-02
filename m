Return-Path: <linux-pwm+bounces-2655-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A41923D03
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 13:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AB5281FDC
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 11:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B6B15B12A;
	Tue,  2 Jul 2024 11:58:14 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2119.outbound.protection.partner.outlook.cn [139.219.146.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16215B153;
	Tue,  2 Jul 2024 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921494; cv=fail; b=AvUE4/jdMBXxoGE5xHeXLgRYd5jFEH8sv8hNlt8QqPghxWwi11wWimucOtKtli5GiOkT+QHOrkQaK42XYSpmpzqX6D3xwaByWCB8QSuEbVFLLTUMaCq2bk1N4tNCWVgjE9zQ4DzMYAtrJ8teU7yhF2IDeRdmCMBUgBwvkGUtLF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921494; c=relaxed/simple;
	bh=/tXCeAT1jIhmXaJ38k0NGJ6BLVa96DNZn1K9naKRYJs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oh1Pen1n98Bw3sZP1drR3T5yx637Nmz91vgaKPTuGfnsFPqpUdi0lyhiJEwQyAb0ECp925a5qyrULnvZy5SAaCX8OiH5He8KiQdxOR06J3YNWnhlygTz5vWyXr4uqGZ1DvkNz2WuGDjMQzseMkhPxuNEGfg0qamJX7MHegM8m38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R68b/yD4Qf2Xpc/h2D0p53kdrkHQgY7nFscj3arx6EgZ283ucKRFOW+tH4Vu6rVAjCTIjA6lrnML+YTKjeaBhCZl8JntT1TEOP/0Vjc7QmxIy2CcIYKZyXkbUWN0yzeVnTe+46gRYyo3Jd09j0tTQXlFyS/ydmXZ4AQy8QUl2I2QqE0zzr6T/gCOXKR7+oTXwwQBAOKu8I+LJ1Laplmbbo/2afKZJRnPuNCisCnJcvD6ZIL21smxFz9RhM7lYj6UVGO7QyJ5hTN2PdeIlVcSCreJIr8trPVrfcYZf+7VIH5TppwRMGDtUCKI+UBDcucmRfdlqnn6Y3UX55WY72XM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tXCeAT1jIhmXaJ38k0NGJ6BLVa96DNZn1K9naKRYJs=;
 b=aLrLsf/NDPA4saZ/YZbloZGPaAyyJIyXZ3Ck/MFDiIOPYk9PHbAhxRYosZmYNor5Sr7NJ9uburdTzUeUXMG8uZKdBpgISRPAaRvNCkGFvzm2cz/91JJXK+JkeYq+12yXI4wIvt4cZtUjYsY6jqot6INfXDMfRuY22x3Q3LsZkY89cMrjWI1vr6tK8C+pgtqOoUOSOrj5GEHRdbaTOehhTCmRpiZxOVUc3wxK/ieH+I6HfK7acAwwtg7jqrJJqInYoEe4MNSk1Dwng6GYg0AT4kSLl0TuCvJJovQRqulo5lfZSMrqGDpSz3ctqjvQN9v7p6+2Vv5Zb7Y8mo83okntxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 09:23:47 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::6e83:b5ba:ad4b:3ad2]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::6e83:b5ba:ad4b:3ad2%4])
 with mapi id 15.20.7719.029; Tue, 2 Jul 2024 09:23:47 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
CC: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>, Hal Feng
	<hal.feng@starfivetech.com>
Subject: RE: [PATCH v13] pwm: opencores: Add PWM driver support
Thread-Topic: [PATCH v13] pwm: opencores: Add PWM driver support
Thread-Index: AQHazFtF3+eYJch9O0KeXWeTVmCD07HjKdGAgAAAZiA=
Date: Tue, 2 Jul 2024 09:23:47 +0000
Message-ID:
 <ZQ0PR01MB12531D76903B31ECD673C1D79FDC2@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
References: <20240702083848.1947449-1-william.qiu@starfivetech.com>
 <0e5f6a7652e9813f638b16314ad1ac9a6059ac8f.camel@pengutronix.de>
In-Reply-To: <0e5f6a7652e9813f638b16314ad1ac9a6059ac8f.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1206:EE_
x-ms-office365-filtering-correlation-id: 867d89b6-7ef0-47b9-98f0-08dc9a78ad28
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|1800799024|38070700018;
x-microsoft-antispam-message-info:
 HMEWgBps7ZErd0c8eTiow7EHLnmo0MpnboOrPpNanoZW2PiyqKRXoXd9us45sLsdmgIEZURvC7YZAKDzqPW+HszKsI8gaw7YQx1mzkn4C4Ksh2wpe/OV+26SryMGHXQhbr9zydZTsmcq2brSPjmtXVVQv/S/Hl3m1d41KzCH5LhWzpQKl0GUp+s3tUlQXMzTWkJioZbsCyhBmHQBUdg5cKri0Nc1iBmfb0iyQkgO0a3lK8byMskE6Kr6oM3dt+CinpvODBE5R+ShB/+LqciuGK1cdk4I0HJ+wHSlr3t2tLLY4eMejCbYCTL4ZSkjb3gT3AlGarYPoWpg+gDuYRMuqKmaWOJQaMVZnJZzSCZpOhouefSAs9DeRCd4oGB/DfMryapva2Q0dG+iXapKRgywa6H7pSkI5gYU7kWnyFD6pOaXwlr4lwJ8j91m1mbaL5szzJEeFiWWl9LlbTtGNowCc1tVHhcKYjsyK/gm5XbXlAQ0DKi1KNIu7tA9ovIcnwK8AaYBs7Ttcpz85msDob1SKMp9r3sWXLbtQU+/YJR6mV/u6cNTCc3iqV8IxHIJurELdzEcFdQzQst97E9UikKiYZpmMevKr7plssLFBA3jKwnivLj/lrXSnGV+R0s4aZrn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STVnNzVVL0lJMDRaeFFGY2lZNEcweHFIZko3aCtVM21hbjZHUXhCTHgvVEFE?=
 =?utf-8?B?dmRhOGpSSENKSWpVekpsbllhSTFsZTNVTldaWVQ5S2JSeXpSWnFtck5jUUdx?=
 =?utf-8?B?RURiaDZ6ZzJSalIvVzQwYzA2VTBIT25hMXZLWmJ2ZjZvWDBjUnFUaDdFU01B?=
 =?utf-8?B?Vlp1SFFhQ3MwTHg2VU1pKzNMeStJd1k5aHpFS3NNVVNOcHBrS1dnVXRDdUVm?=
 =?utf-8?B?Z2ZPc1o2aTVzMUlIVUtGK0tzMjRpcnBuMXdKdzdqRWRJeTA5UTZMVkdYMjVN?=
 =?utf-8?B?L1J4WWxwMDdRTmdadWtQdGUrUTNlNXJob1FYRzY5b3JlTmo1dTBZVVF4STJa?=
 =?utf-8?B?WU8zVTBpRFkwR3YzMjhkQ3I2bU5JTmQxQ1I0Y1BBWTNaMlRiY211Z1Q2OTNl?=
 =?utf-8?B?M3VsYzZqVmhnUmg4OEUzV0UxL0FQaVZiK2dHOFVET3FYc01VeThkMXNpazg0?=
 =?utf-8?B?aWhsbjB2b2hxaFZWbWZCY0g2eXlzMmJwaERuK0FtaU5GZEhVWDVXSEdpdkdR?=
 =?utf-8?B?aXlaZnlQdVFoZm1pUDRzWVN5NHBsZUFkeDQxSzh1cWJlY0VTb1FHMG04VzJa?=
 =?utf-8?B?Q3JBbWJTYmdXbyszS3k0V05neWdla0hKU3I4NnNPU21TdEY5SVVKczdYN3FH?=
 =?utf-8?B?Q2swNVlPN095bDN1Wlo3LzIvcmxHRlJtczUxWGhsMFFvZUMreFJvVmtMQ3du?=
 =?utf-8?B?aXpuczdIOGIyQ0psamRHZGs1NVFoSmt5cVlWTGtZNSt5QXlNcjBTdnUyTzl0?=
 =?utf-8?B?YjJ4OHBrN1hPNXBVN2t0aDdaL1dieXk1WHF1ZjBwaWlVOEJQRjl0ZWt1V2VT?=
 =?utf-8?B?R2lTcE9HbTcrbkxLQnljdk4zd2lCdElxNG1oYklJN3IyRDl6WHFSVjBMUnVy?=
 =?utf-8?B?b201NXdHelZkWU1JRGMwNWZ4cTZ0TEVaVkZMTzFkWTVFcDI2SkpLeVpsYkhR?=
 =?utf-8?B?VVNtRXhmTjBqb2M1NFR2bUpXTUF4V09hSXJNUjFmdzZNc1ZpSUVmTGVlZmJq?=
 =?utf-8?B?MUt3WFNNU2NMZWhlcmNMZzVMVmdHZXoyZjFFdmFUQ1ZEbGk4UVJ4d1lOSGd6?=
 =?utf-8?B?NGNucHg3bjZpcWFRcC80T3V1eUYxUDdtdWM3TjMxTTAvdDVjNHYrL29Xa04y?=
 =?utf-8?B?d0g0Ni9MVjlrdkRQK2UySmpqOFBSY1UvWGRQN29Xb0hWdFlFdTY2bkQyY3hn?=
 =?utf-8?B?UVNWTW9TRjVudzAyNVBQVmRKVi9SNUVyQi9vcENQamlFYmVoNS92T2dZWDla?=
 =?utf-8?B?Nzc5UkRsWTk0U2liQlVBLzI0ZVhTMUNld1NFcjYwN3YrdlBuM0hnZW1Tenhn?=
 =?utf-8?B?RVlJbGtubG5ycElVT2gzUmRKcGNlcUV0eGJVMDVyc005djJKN3MrSEdXZndL?=
 =?utf-8?B?dmZlNVMyd0orZnQwSlpmcEIzeFMwZEZKaDRrVWpoZ2laaTJLT1VjZGVUZUtQ?=
 =?utf-8?B?eEpvYk5kT051djlXL3JieDBGZStCTitVdEhIa3Vrb3oyWENrYkNBcTNqUGV4?=
 =?utf-8?B?M3MwUUF0ZzZqVEIzaWYzejhEWXo1V05FN3lxcGNZOW5wN2ZZZXpEd3hMd0I2?=
 =?utf-8?B?Y3BtZnpwNyt5UXVERGh6UHU4c0tpdjkrRlJCVXBlWFJtQ2xCL3BnN0c4SG9F?=
 =?utf-8?B?UTAwdmdyWnVKUE5XbVZGaGYzSmtZcXRENEdpUk5zcUYzQVR0U3hGczhKdjRE?=
 =?utf-8?B?Wm1WT1NaNmZHbTNBa3llWmttYW9YQjZMYnd0YzJOQjJoY1YydE5ZT3B3NXZQ?=
 =?utf-8?B?aWpUS2dVVWVSdEtLbEM5U2RuK3dIRlNmdmhrRGFiYjlaQ1BPUWU2c2N6MGp0?=
 =?utf-8?B?L1BrcjAzckZwa1NUKzdDSWV6STd5S2dZNGNZek5jeUo3cXkwb3Y0SHp6d3BG?=
 =?utf-8?B?N0YvYkJXSlc4cHZBS0NvZzlmRWZYQkJiZ1BkQXdydGdyKzBIb3pYbE5UeWYy?=
 =?utf-8?B?MWZXb2dWS3Z5M1dPODFjRE5rRXZjUDYydldybWZpLzZRZ3RpeWNXNkhqMnpS?=
 =?utf-8?B?MnR6aitSMjdIMGNOZ0RyQXU0ZTN4STB5SU9VTFlzUHNXN0JGMUp6M0lNQ0tp?=
 =?utf-8?B?Z2t6MlN4ZmZZNWd3QW85SXVGVDJHbmtEcHluM3YxOEV0UE9TUkhZOHRIZUlG?=
 =?utf-8?B?L0ZVWlZBMUVaVkRSMW9VekJqSExtU0QxQlQ2WlFNQytjSkVZS0hwYzBHVmN6?=
 =?utf-8?B?NUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 867d89b6-7ef0-47b9-98f0-08dc9a78ad28
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 09:23:47.1274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVeFqdiXy9770MxJcPNEE0ZY/z+58CojaTskxDyBabMi1EOsT4Cq+eMX4u0WR9vmHTLqbvlYaqBKUXOZ8m2pI6iQuOet2r8JZc6wvdIxhqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1206

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcCBaYWJlbCA8
cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyNOW5tDfmnIgy5pelIDE3OjIyDQo+
IFRvOiBXaWxsaWFtIFFpdSA8d2lsbGlhbS5xaXVAc3RhcmZpdmV0ZWNoLmNvbT47IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXB3bUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IFV3ZSBLbGVpbmUtS8O2bmlnIDx1a2xlaW5la0BrZXJuZWwub3JnPjsgSGFsIEZlbmcNCj4gPGhh
bC5mZW5nQHN0YXJmaXZldGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEzXSBwd206
IG9wZW5jb3JlczogQWRkIFBXTSBkcml2ZXIgc3VwcG9ydA0KPiANCj4gT24gRGksIDIwMjQtMDct
MDIgYXQgMTY6MzggKzA4MDAsIFdpbGxpYW0gUWl1IHdyb3RlOg0KPiA+IEFkZCBkcml2ZXIgZm9y
IE9wZW5Db3JlcyBQV00gQ29udHJvbGxlci4gQW5kIGFkZCBjb21wYXRpYmlsaXR5IGNvZGUNCj4g
PiB3aGljaCBiYXNlZCBvbiBTdGFyRml2ZSBTb0MuDQo+ID4NCj4gPiBDby1kZXZlbG9wZWQtYnk6
IEhhbCBGZW5nIDxoYWwuZmVuZ0BzdGFyZml2ZXRlY2guY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEhhbCBGZW5nIDxoYWwuZmVuZ0BzdGFyZml2ZXRlY2guY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFdpbGxpYW0gUWl1IDx3aWxsaWFtLnFpdUBzdGFyZml2ZXRlY2guY29tPg0KPiA+IC0tLQ0KPiA+
ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgfCAgIDcgKysNCj4gPiAgZHJpdmVycy9wd20vS2Nv
bmZpZyAgICAgIHwgIDEyICsrDQo+ID4gIGRyaXZlcnMvcHdtL01ha2VmaWxlICAgICB8ICAgMSAr
DQo+ID4gIGRyaXZlcnMvcHdtL3B3bS1vY29yZXMuYyB8IDIzOQ0KPiA+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDI1OSBpbnNl
cnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3B3bS9wd20tb2NvcmVz
LmMNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTIGluZGV4
DQo+ID4gM2M0ZmRmNzRhM2Y5Li4zYjU0N2VkZTJjZTUgMTAwNjQ0DQo+ID4gLS0tIGEvTUFJTlRB
SU5FUlMNCj4gPiArKysgYi9NQUlOVEFJTkVSUw0KPiA+IEBAIC0xNjgyNCw2ICsxNjgyNCwxMyBA
QCBGOglEb2N1bWVudGF0aW9uL2kyYy9idXNzZXMvaTJjLW9jb3Jlcy5yc3QNCj4gPiAgRjoJZHJp
dmVycy9pMmMvYnVzc2VzL2kyYy1vY29yZXMuYw0KPiA+ICBGOglpbmNsdWRlL2xpbnV4L3BsYXRm
b3JtX2RhdGEvaTJjLW9jb3Jlcy5oDQo+ID4NCj4gPiArT1BFTkNPUkVTIFBXTSBEUklWRVINCj4g
PiArTToJV2lsbGlhbSBRaXUgPHdpbGxpYW0ucWl1QHN0YXJmaXZldGVjaC5jb20+DQo+ID4gK006
CUhhbCBGZW5nIDxoYWwuZmVuZ0BzdGFyZml2ZXRlY2guY29tPg0KPiA+ICtTOglTdXBwb3J0ZWQN
Cj4gPiArRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9vcGVuY29yZXMs
cHdtLnlhbWwNCj4gPiArRjoJZHJpdmVycy9wd20vcHdtLW9jb3Jlcy5jDQo+ID4gKw0KPiA+ICBP
UEVOUklTQyBBUkNISVRFQ1RVUkUNCj4gPiAgTToJSm9uYXMgQm9ubiA8am9uYXNAc291dGhwb2xl
LnNlPg0KPiA+ICBNOglTdGVmYW4gS3Jpc3RpYW5zc29uIDxzdGVmYW4ua3Jpc3RpYW5zc29uQHNh
dW5hbGFodGkuZmk+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL0tjb25maWcgYi9kcml2
ZXJzL3B3bS9LY29uZmlnIGluZGV4DQo+ID4gMWRkNzkyMTE5NGY1Li40MjE1OGJjMWM4YmMgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wd20vS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvcHdt
L0tjb25maWcNCj4gPiBAQCAtNDQwLDYgKzQ0MCwxOCBAQCBjb25maWcgUFdNX05UWEVDDQo+ID4g
IAkgIGNvbnRyb2xsZXIgZm91bmQgaW4gY2VydGFpbiBlLWJvb2sgcmVhZGVycyBkZXNpZ25lZCBi
eSB0aGUgb3JpZ2luYWwNCj4gPiAgCSAgZGVzaWduIG1hbnVmYWN0dXJlciBOZXRyb25peC4NCj4g
Pg0KPiA+ICtjb25maWcgUFdNX09DT1JFUw0KPiA+ICsJdHJpc3RhdGUgIk9wZW5Db3JlcyBQVEMg
UFdNIHN1cHBvcnQiDQo+ID4gKwlkZXBlbmRzIG9uIEhBU19JT01FTSAmJiBPRg0KPiA+ICsJZGVw
ZW5kcyBvbiBDT01NT05fQ0xLICYmIFJFU0VUX0NPTlRST0xMRVINCj4gDQo+IFRoZSByZXNldCBj
b250cm9sbGVyIEFQSSBoYXMgc3R1YnMgaW4gY2FzZSBSRVNFVF9DT05UUk9MTEVSIGlzIGRpc2Fi
bGVkLCBzbyBpbg0KPiBnZW5lcmFsIHJlc2V0IGNvbnN1bWVycyBkb24ndCBuZWVkIHRvIGRlcGVu
ZCBvbiBpdC4NCj4gDQo+IHJlZ2FyZHMNCj4gUGhpbGlwcA0KDQpJIHNlZSwgSSdsbCBkcm9wIGl0
Lg0KDQpCZXN0IFJlZ2FyZHMsDQpXaWxsaWFtDQo=

