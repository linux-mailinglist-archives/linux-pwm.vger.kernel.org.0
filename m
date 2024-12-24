Return-Path: <linux-pwm+bounces-4483-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FE19FB931
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 05:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F66118826D7
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 04:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C7F13C9A6;
	Tue, 24 Dec 2024 04:24:20 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2097.outbound.protection.partner.outlook.cn [139.219.146.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF091392;
	Tue, 24 Dec 2024 04:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735014260; cv=fail; b=tFaidGjipPFGOSbk852aUrTebOqZm5ZwUo8n6Qkscll8999ZzLy0VhQBqsIrJCelkdkc0DrzzxORjRlDra1Ei92PWoD1TmFowAdQVsyo4rdC0jRo8RudqONipbqsJ9v8RCAzqmWXGkKIPa9lTF0+l4+EV8KJM421xm3mkguGA4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735014260; c=relaxed/simple;
	bh=hDf/jVHcPSEUS3SZ/i7vZtoq5KvMR9I45F8TyhhvBwU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=szcVU0Ii346qkPeRTiXcm4JRwtkNNIiNFdiLFc/tjeLHHWLHzxHdD1MToL+4IHv5TGMsjKakAL6D6IiIPcZXnIBOrAA1l6WhHBTrLbOPegxoqRpt+S/PJWQmtYAERAG41rUcgj/TKE84QNLdbCZTzJQ/7GG4lYrIdN9Yw1Pvo3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LotXe1K+IoZL6zC6xDm0zl3iuGtRSwFnpavzIFabIDrBywjVUoQ7q20Q7OtFTAPQ4PLEiNNN3yegaDa/Uyy1YDoFFUHAonaBhYrIrb08dbP0rY1/bf5Ib7N/hSHwPznKr3wrvZDUMnY04JUqulbGKYAje2IrYxSv/gQrqXKwp3H3EWiuvWrec+CgOcXsH0BHXjugGple2SzmiGTBTBBsIlVTSIaJp2eBr/vr60cC/RUBbOOXfmhnYH7V3QvEP0ursJFl6LoUwPzTD3ilpaSGCGKW8T58J7a0fWZ4I3dccLN+z7NYMnvvrVj4pNEPdrahEiB1W2asRSlUDYHIKMcKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDf/jVHcPSEUS3SZ/i7vZtoq5KvMR9I45F8TyhhvBwU=;
 b=PA9fXdI9m6rTgNU2P44HOwe/DaejvqLT/yS3W+x0MZHV4+js+3iuynWQ/daUx6rl2egk/nruOLVyUoiH8fHEn62fzxIRuGakUzYkOEezwY69hW+KGVqp5hV6cMKISXML8wPpX0HoDaqcdRtVqAzi67wGflpi1R1udVDkbgyQekeYwKxq8mOkBJe6E9nrmJIf2p8WnjSCixF/62MmP7XYH47F0SMBMzqac0HSG/LiioVsbUf0WK7WLgnQOjqqaRSn8VhLKU+wA5+LhoI1s6yZzpgZMs2qmq2eBQgUDOy/k1n+u5+IxaDsWeSDnCk5xp++PzJc7o0fpDkSPZ4g0+ejHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1174.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 01:53:03 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::6e83:b5ba:ad4b:3ad2]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::6e83:b5ba:ad4b:3ad2%5])
 with mapi id 15.20.8272.013; Tue, 24 Dec 2024 01:53:03 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Hal Feng
	<hal.feng@starfivetech.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH v16] pwm: opencores: Add PWM driver support
Thread-Topic: [PATCH v16] pwm: opencores: Add PWM driver support
Thread-Index: AQHbKNsymVbYlUSgHUKyRrqbTLJ87bLuYDMAgAUWdxCAAPMzgIAAkMTg
Date: Tue, 24 Dec 2024 01:53:03 +0000
Message-ID:
 <ZQ0PR01MB12530DDB9AF830296773C7AF9F03A@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
References: <20241028014609.153997-1-william.qiu@starfivetech.com>
 <bfwpcffdrxqjes4atio6deltu5tgmd4ing7j4yewwp6jprqmmc@rv2x3qudlzo3>
 <ZQ0PR01MB1253A5B870FF90900A2643009F02A@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
 <52j6gtyzf4uwfkxxlfschygnvuwl2l4iaf7mzbi2nbzxtmlemf@dktywu73nldg>
In-Reply-To: <52j6gtyzf4uwfkxxlfschygnvuwl2l4iaf7mzbi2nbzxtmlemf@dktywu73nldg>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1174:EE_
x-ms-office365-filtering-correlation-id: 0bcae02b-4b9b-4b18-9db7-08dd23bdb435
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|41320700013|366016|38070700018;
x-microsoft-antispam-message-info:
 nwmKfHEOZbbyhCH+c2OhZCBBLYrSdmWQWsDbEkOzkZCgzU8+T+PxP2AxKITSTjDqO8pF8JwPXjRNFMaJneR8hmBIEMTi7gEvWkARbgwY7WK9dHaqb513tzVQQMy4arAgvxZsT+bCUTnxdlMyFzgKdGBxqbXLLST2mEuSfuZBsuIbGr9zg79lj2RbCJLJz7dJt7rGXyGDiOm3IkMigt54qNpN0uknAoL++fm46ZCMmi68XDL39PzorRPPMoADlqN2C49n9cvxWoVJ5u89RX6Dc5vEecwuNvWVOOff4AKkYIyPc3NtDxCQF5mTm+20Ulo22qwF691Krulr4lBLjMa4KC+BPU0h2n35/skX7RQ2cT04ASwBUXYK61VR5NHFE50ePMBqYhxWoUtKILbEhptv9J/nbkHVas7qQ7ou7db5srvVk9+VdqDlUCfjjow2TOqXDI82+1VgFxdpXZEtgdyPddY8U0rI9jYJDEm9/k/svfknULs5yWmNxRR+er5evQ6j0bqO3MBkplMoiLHZF/E5EGeu/UYk2mJj5j7dhe1UBpDTnDex/ZEQu9N4akL0INJwEmTADMVNg9tcceGvm/dwlIC25ARLcT6GnqmSHFCT8Kc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eEFBWXhXZCtrUER6SlRqVlQyT2RsdzJPZngvS1pSZFNJejRlbG1RT2xHTnF6?=
 =?utf-8?B?MU05RWwrZ01ONE1pYmhqblYrbkJ2c3JvOFJFcFJwUStvbnAzNGswaEl1ZzE3?=
 =?utf-8?B?NFhyN3RrUGh3WEN1SmFtZEpZZjdTUzBTTFg5cGZTc1RaWnUraTdOdVRrc1dM?=
 =?utf-8?B?RTZuVk9qSVZGZzdJaysybEN0Y3BIeTNnVmIydFJyZktMUzFaN2QxM0UyUGUy?=
 =?utf-8?B?VDB4dnd4OFR6YmJIaG9UUFhqbDdicFpNZ2tyVlhDcWE4TkhOV053TmdTZjk0?=
 =?utf-8?B?SEtiVHF2aXpTemVxdDkyczlERzFkVERqWTJjZXpUNmNVbkQvbHhmL2FDZ3h0?=
 =?utf-8?B?VXFiZEM2WW8vL01zTXJnanU2aXptK0lnTUgvbzQ2NWRNVHdlSjdJM2xjazR6?=
 =?utf-8?B?WFkzakFWbHBJUWdiaWZ1QkFQUkcxU3Jqb0pHWTVBd3Jwb2V3TytReC8wOVN3?=
 =?utf-8?B?d1FraVNiOHFHeGJMSmtHTGhLOVJMWU5WN3JTV09EY0d3TXk5UjZObFMrdGtV?=
 =?utf-8?B?OW9zQm5RVzRFQzNSR0xlYnNWcWpoaG5MMmhqamV5aXB0Vm9GbDRXMHF2UVgw?=
 =?utf-8?B?QTNXL0h4S0VZampzZWxLazlRUnM3OTdsNEdiZmZpSTJXd3ZRekEyT0NoTjZ5?=
 =?utf-8?B?OW5lR3dkU1FVYmJRYjNXN1RpSExoSGdvdWIvMzlQTUdNc0loVVFuc0twaThT?=
 =?utf-8?B?cFFLNUkxa3lGNStocGJranlIaVMvdmQ3cEtXaXVXSUFiYW5YTHErWm5IRXJE?=
 =?utf-8?B?ZHpCRGxZcXZOQlowZHJYMFhMYmo5cE8xQWY0bUhqdHNHKzJ1MVNJa3hvWGxi?=
 =?utf-8?B?RjY4RzlZMFZkUnd1RDJxanRuQlNRVFRsQk5pVEFWYlZDbEpQKzBjUHczQXNR?=
 =?utf-8?B?c2FVTXBtNk5XQWJ4OEd6MytTMUk3azhmUVo0NjMrYWFSWVVLZ0Z1Q1JsUXZD?=
 =?utf-8?B?L1B5ZjI0Z2lFT010UkZpZ2srWkxxK0ZUd01QVmxwc0VpVjB1aEpMUjdYYjhH?=
 =?utf-8?B?SVNRTDhuTW41QkpmOTQybjhPejJmMFB5Y1lUMXdUcFVuRHo1K2JkWUNWeWlP?=
 =?utf-8?B?MnMvaWN0WFFjcjBWQ2M0UzdsTTV5YXl6WjBzNCtmK1hmcTAweUZ3TlBTS2Jy?=
 =?utf-8?B?Q1c3dFRJWDVobVBvcnlyYXhIRGYraHZsNDRFOHVFQ015aTlaN0xOWTJUaHRL?=
 =?utf-8?B?b21yaFQzbktyUG9GMk1BSmgyZUhaZUxPTE90aXBZNGlHcFRPYk5lbWxJTWY5?=
 =?utf-8?B?TWQ4akNmZzdQR0F0QkxycXNqRTc4cGtkdlNDSm1lMnVlQ1YxQS9KamxObWt5?=
 =?utf-8?B?N0VzZ0VYa29oaTZiTGt0dTh6Y2dacUJuUjlFbGxybUFuL1dDYlZjWUJQaTVR?=
 =?utf-8?B?Z2FQOW1kcW5jVSs5NXFoUm84d2ZmWW42dUU0T2YvdGFMVnVIL1phajN5aHRI?=
 =?utf-8?B?Y080dGdzSnpFMFh2THRodWFmTTQwRzVCYUJHdlA5blBIbjhlZDVScTAyTDJn?=
 =?utf-8?B?VjI1K2hkVWZCcDdkcktNazVhMXA0WnBuVkMzTCtjaHFJbmFEM2dRZVVUTjJL?=
 =?utf-8?B?eXErdC9KUWtsTGJBQW1XT2ZDQ255N2NqWWdreEM2OUROb2FXUkFtM1lXdXA5?=
 =?utf-8?B?UjUrNnU1MW40Z3k1MGZ6aFUyWXdEbkZzb0ROWCtjSDdFR1FoUW5jRFJPM211?=
 =?utf-8?B?MkRCeFpITnNJT3hBbDhpOW9Tb3c2LzBTK1dieCtDbFV1OVVWZ3N1ZmVtTzR2?=
 =?utf-8?B?REt2b1MxMFhYb0x5YmdVa2xlU3l0WDYvdldTekVoZ254K2cvaDNaMUZkWERQ?=
 =?utf-8?B?d25WdFB1bEJHVFpYaXkxNm9IZ0djZUpGQWkrMGFZZTNlZERLSjVIU00xWDBW?=
 =?utf-8?B?cENWVkk4VENJVVpyMldDWU9NTmJ5YmgrdVhjdWlxNjVXOTIxbStUQ2tjOG82?=
 =?utf-8?B?dEpuK0hIS25KdTdBVDk0Y2krSkpIbVdYVDRWbUtSTmRLUXN0UkM2UE5aamhB?=
 =?utf-8?B?MkMxUTA1Z1h0bEFQU2h1cmprMzBUKzFQS1J4amRwRkRUZlJxdGo0S3ZkV3BE?=
 =?utf-8?B?dEdYbDY1QkFMMkF2QWJvZ1Flb25wTE5ROWZIblRvSHBaUDdBTnhOZzZPZnFz?=
 =?utf-8?B?dWRERmxoMG4vOHBQODZlNGh0eTl3Y2lDZTY3TkRYRUIwdlZSNy9uK0d2ZmVw?=
 =?utf-8?B?SXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcae02b-4b9b-4b18-9db7-08dd23bdb435
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2024 01:53:03.5265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BY3l/uVIfSpUCsh50ACTeQqa/rYKl4bX2spLI1027m0Xp8r7BECf0Z0BHRbT1oqgxp8JivWYZvtXajMa43R1mtnTaUKUY7fm9yevOogGEaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1174

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVd2UgS2xlaW5lLUvDtm5pZyA8
dWtsZWluZWtAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNOW5tDEy5pyIMjTml6UgMToxMg0KPiBU
bzogV2lsbGlhbSBRaXUgPHdpbGxpYW0ucWl1QHN0YXJmaXZldGVjaC5jb20+DQo+IENjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wd21Admdlci5rZXJuZWwub3JnOyBIYWwg
RmVuZw0KPiA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT47IFBoaWxpcHAgWmFiZWwgPHAuemFi
ZWxAcGVuZ3V0cm9uaXguZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjE2XSBwd206IG9wZW5j
b3JlczogQWRkIFBXTSBkcml2ZXIgc3VwcG9ydA0KPiANCj4gSGVsbG8gV2lsbGlhbSwNCj4gDQo+
IE9uIE1vbiwgRGVjIDIzLCAyMDI0IGF0IDAyOjQ3OjU5QU0gKzAwMDAsIFdpbGxpYW0gUWl1IHdy
b3RlOg0KPiA+ID4gPiArCWR1dHlfZGF0YSA9IG11bF91NjRfdTMyX2RpdihzdGF0ZS0+ZHV0eV9j
eWNsZSwgZGRhdGEtPmNsa19yYXRlLA0KPiA+ID4gTlNFQ19QRVJfU0VDKTsNCj4gPiA+ID4gKwlp
ZiAoIWR1dHlfZGF0YSkNCj4gPiA+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPg0KPiA+ID4g
SSBjYW4gdW5kZXJzdGFuZCB0aGF0IHBlcmlvZF9kYXRhID09IDAgaXMgYW4gZXJyb3IsIGJ1dCBk
dXR5X2RhdGEgPT0NCj4gPiA+IDAgY291bGQvc2hvdWxkIGp1c3Qgd29yaz8hDQo+ID4NCj4gPiBJ
dCBtZWFucyBubyBuZWVkIHRvIGNoZWNrIHdoZXRoZXIgdGhlIGR1dHkgaXMgdmFsaWQ/DQo+IA0K
PiBObywgaXQgbWVhbnMgdGhhdCBJIGV4cGVjdCB0aGF0IGR1dHlfZGF0YSA9PSAwIGlzIGEgdmFs
aWQgc2V0dGluZyBhbmQgbW9zdA0KPiBjb250cm9sbGVycyBzdXBwb3J0IGl0Lg0KPiANCj4gQmVz
dCByZWdhcmRzDQo+IFV3ZQ0KDQpTbyB3ZSBqdXN0IG5lZWQgdG8gY2hlY2sgZHV0eSA8IDA/DQoN
CkJlc3QgUmVnYXJkcywNCldpbGxpYW0NCg==

