Return-Path: <linux-pwm+bounces-9075-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBErJ1L6D2qESAYAu9opvQ
	(envelope-from <linux-pwm+bounces-9075-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 08:40:18 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8535AF989
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 08:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A8EC30005A0
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 06:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB2D29B77C;
	Fri, 22 May 2026 06:31:44 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2137.outbound.protection.partner.outlook.cn [139.219.17.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2516F1DF73A;
	Fri, 22 May 2026 06:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779431504; cv=fail; b=XQcuqFOd3KyiEvum7k/ZNbVg2AIQQv/rVixbXC873rcWbMfth2SV0MvxyutADJFxC+9LaG2fx19dOcY8+p4gp11MlrP8DhGYWQk018m8SJKu8YViL1nHz0BsHzke+qlZRZV73H7HQoOpLqEdqVgkb7oWf2I7/aLDELc9wwTyuTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779431504; c=relaxed/simple;
	bh=/l3O6NYy5ZNayIgBc2X9wZa0bRo2S3WrfYc994/DdP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=COqNehwNLDbzy0lTvJk9nVj/0pIceLtOOC7vqN7j18sImY00oV+Ay+/ysxUgNQcVYWpTSRa+220mCI/DvyRadYGyp/2lRbWA8Z6AhbzL8lgwuXus/Fe5xg6FRNQyMDNKNmAcYtQMnubF2isOfi1qJOa1Cx2UuzkvNWQFVioXV/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3Zt7LEYfhpkikQa349/kHggubdPxwpX2oq1IsThW4qHT9AnJbhZkaWS+S1eumiSriiOdCLHpi4Yuu7GI3/vnP2fCBZQqVP1OJ5GllzMOo2SI6RIFwHACTJ2Kq5NW6J7sMkf9WfGAq9yG1f2lBnp/XXR/VEh02hZHzlNbRgM5IW8jmlczqmy2ISLwKMFCWvxNssEukZT7wKTe7CVNG4qMp6KyDpEXDD0Swr7FHUWiUzjLT9YyzxySAtU/DmP9F4fQyxlnrSrQgzoEYiw+jzfHCqPtH7z8Q1nrpflMD3W9ewZ4Zr/1c3zZVMG1VyRhGhkZT51n9wuBckQVUiUn+Q/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/l3O6NYy5ZNayIgBc2X9wZa0bRo2S3WrfYc994/DdP0=;
 b=Hqv+whv1vfrxTBKNyA0LznUjKYtQHks/l/cAbcJNNrgzCK0a5lcPDIK10yqFlQkDfWfKv7bUhmop1A6fNpNohv+YZhr+4aAVOMhgfGOVMbC6HucRaGsGqhRWtDL+2euEsIWCFrI+nQIxo10NfOQg+b4uPl9dQxNdKY9Pb66SNgpeVzoAS22n2DJO1A8a1seNSbKVRgmMVbR+yPNrEUKLGNiMCZ0mrs6uBNDC0BF3ZA/POvgEN1SV94xjpOj7DQLlDiDRpHR4/COzItJKOQUKUw1p6KLFUWiKyUcYYj9IKDWIrAuCs/IHOlicBhmDmup5/s80vyg9OMfgDPxDViKQDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1273.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 06:31:27 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%4])
 with mapi id 15.21.0048.016; Fri, 22 May 2026 06:31:27 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, Changhuang
 Liang <changhuang.liang@starfivetech.com>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v18 1/3] dt-bindings: pwm: opencores: Drop starfive
 compatibles and update maintainers
Thread-Topic: [PATCH v18 1/3] dt-bindings: pwm: opencores: Drop starfive
 compatibles and update maintainers
Thread-Index: AQHc5C5S9fqR/+n1kECZdRj+yravLbYPDuOAgAqR+tA=
Date: Fri, 22 May 2026 06:31:26 +0000
Message-ID:
 <ZQ2PR01MB1307DA0D079BD2912D31F658E60F2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20260515054723.25024-1-hal.feng@starfivetech.com>
 <20260515054723.25024-2-hal.feng@starfivetech.com>
 <20260515-blinked-gigabyte-d2882372b616@spud>
In-Reply-To: <20260515-blinked-gigabyte-d2882372b616@spud>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1273:EE_
x-ms-office365-filtering-correlation-id: b978336d-87ae-4db6-6e7f-08deb7cbc096
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|18002099003|56012099003|22082099003|3023799007|4143699003;
x-microsoft-antispam-message-info:
 WoHgJyI79tyDbokk9w95t4vYxO3JqZqnt2qkTyOask65TUlb8ccOr4CwqY1Wfwv6poKl3KNHslIWLtrS9sFmXJNV8bI21E1CKdK//0XcsMljW8wyWwCNUkpj7SsoGdjNexi28JVkVXSctX1IzblknXbPJrt1U1ldNqPgcELS1WdpfRPm+fFi8onpFeT38B4iV731//wHJcFsGYhSCwsA6+b/D5BOgc3Ty9nQLzb9RGr+gSOBjtU+jJsHjU/kb+Iaxq3Awz23Znz0daJehTwH93rvng2J/DaMpKAovCPtA8Eeob3Ur+AjqctHArp7/OA28Iuthqq/5xRulYLQGwLFv9b07oCFdabiD+MRZxYe5KRNebdLYTDoKCdJyMVBvxMI5JrCBY+RF0fktbtHrt0m9MDcXqbDsaDZG1RMwJOp2Dph8snDd4euAT7JZOxooFI3c/ijmGB6jWEzteF8jjVWd63I0q6XSWSLXWjjNQNPj22WprreXCs4Q6LE752QNCnxHytnAcvCFR4fjUzJux/3g1lmlITGrZGJ9PhEW07xeRe6u9r53GtPNZM/VwgcEY3X
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(18002099003)(56012099003)(22082099003)(3023799007)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1p5a3VwTWgvbzV2MkdxaUdXTlRvY1EwVHBXOVZaVjlUNEdOMXREcGV4WUxJ?=
 =?utf-8?B?ejFXRXR2RGZnNUFuSVdCWmZLRnp6TkE2aHJ6Y3RmcFF2VTlnNU5nbzJmcUhk?=
 =?utf-8?B?SkVaZTdHSE9nMmhHT0NrVjArb1FVaUtXaGJGRHI4Vy9WenMwTFNJbXZraGhS?=
 =?utf-8?B?MVM0M3M3cmowa1hWd0s4c3JINlNTdytBdzdVUnVmc3ZCN3I0N2FPOENIc2Rv?=
 =?utf-8?B?TmV0OWJ2NnFtVWJBcHA2ZGdacHJZNHptSGJxNkNpYkdSL0NCWnVJSS9pcUsr?=
 =?utf-8?B?dWZ5M25aeUtIdDV1Si9ncmtVNEtHcVZybU9EOGlRaVkvOE44cFN1YlN6eDRt?=
 =?utf-8?B?dWFTaXMrTFl5RmlZWFFicjJzSUtQS3kwR3hoM0t5ekQ5U2tBUWl1dHVBRENJ?=
 =?utf-8?B?VjNlRVM3aERISXM5b2RxYmxKRmhaYTloRHJab1N0ZWxQYUFTcEI4aXgvcFRa?=
 =?utf-8?B?cUtjTDlTc3A0MThMUlRvbzJsUjluR1lGaW9tRU1FbWhyekRLazVldzhpcVkv?=
 =?utf-8?B?OXZMVS8xVUIzYStNaFFaM21lbEFlbUJhcTNWcDdpK0hlbWlkODYyYnVJZDlX?=
 =?utf-8?B?L2hObVdjdUk2bTl5T3lnTHdaSFZ0L0hBdGpuR25ZL1ZRSlZjaHJEU2RIdEY3?=
 =?utf-8?B?bzJ5WmFwcnVUTUdZelQxTER3Q05WY3Y2NlhwaVdCVnpzUVFzNEEwcGxsT1Bx?=
 =?utf-8?B?dW05SGorK2xDcWw4aGNwamcrY1pxczJPeUpBR1gzL3RFVzhXeVA5MVM2dm5R?=
 =?utf-8?B?YnpFZnMzRWk0NWNNbWpxOG9iNXVPSTBia1lKOFpmV0NHYTBSRm5manBGMTM3?=
 =?utf-8?B?UERlSzRPTjdRTkZ2SUtMVGg2ZFZaNDduNFppbWZwVldOR2lsVnZnUDcrQno3?=
 =?utf-8?B?clJ2bFpDSjVjWVhhNDBvYktPZ2J4QlpFZUVNQ2ZqWU5oa1FWNEdLVjBML0hD?=
 =?utf-8?B?YmN3MmVWWnFES2FEeTBtWGVILy9SakErTGlxRmhPQWw4anQzVjRGSDlMdTda?=
 =?utf-8?B?alBWZ053dmdRZXZSYnhtSjhHd2NGYnNhbFhkbDZncnB5RWFFMXRXZytzRzIv?=
 =?utf-8?B?ai92TW4yQktidXFHK2VyeFdtekJmWkhRRnNvZVhkREZTZ0daMXl0UDV4dnl1?=
 =?utf-8?B?WVBPaURIb1E4eUhXSGtUTGVDRlQ0K2Y5aXYwckVITzR0cGc5WWlTOGNtLzAy?=
 =?utf-8?B?T0xXMTl5bDE0WW9CZkxKWFk0SHVYV2RES0VSTUJaL0dqL2U5UW5vN1VxZTlJ?=
 =?utf-8?B?MDJlVjhIdUVvSEZqT3V5Z1ZBU2xOU3dXREJHZHRFTGQ3WVc4NTJwZURQWUox?=
 =?utf-8?B?Y1B6cjcvNmdmTFl1TVRnYTZzNUx0YU5hbDdDMVA0UjdqcWNIcENscVlqY2tl?=
 =?utf-8?B?Q1doUmxyMHU1K0d0SWNkbmhUN1hIZ240eEY2MURuWHpsN3E0K3VJRWxOVGgy?=
 =?utf-8?B?a1NORy81MWk0M0hORTRjU0pZSVUrbmxySnN0aTYzNTBrOWJPV3A3cng2Sk92?=
 =?utf-8?B?WEE3WFBNcUZjaHpyUDBoYjlIakllbk1qV3NRQmtBVHcwUldndldrNytaN3Az?=
 =?utf-8?B?NGQ3c0crZG5qUUZjU3VkY0FGSXRFVjlZTjVCNTJlOFhnei9ibXk0NlRpUUdv?=
 =?utf-8?B?Z2hFdGVabWZTdlI4YXhBZW5BWjBnUWQ2R2llY3cwR2hsZ2FZMnRubDVwRXBL?=
 =?utf-8?B?NVUzQ2szQVZzYmp6OTg3eW41bzZEdHNjR0thR2g4bGMzVk9icGNXRytDSDU3?=
 =?utf-8?B?RmlEd2kvaEtJOXlxQ1BuQkNYcWdFaEFhWXZFSFVpam1HTG9hTDJJMW1NZERp?=
 =?utf-8?B?czlPc05LeXJiRlBOS2JyVlJCSmlyUENxSVNYTHU4bjVrdlFDVm5scmxESHF3?=
 =?utf-8?B?aE1NNE5KbmR5R1ZCMm91dDRqUmxaWUxwUzZHeGZTT3BKdkU4TDEwRnc0Z1hx?=
 =?utf-8?B?eklwNEFMSjNQQVRKT1JhRG56eXc1d0xGRkp5bXlLam90MXBNQ1BzbVBDZFBx?=
 =?utf-8?B?eHVpRUhqYUtJcnRYM3NBWkNHczFZOElpUElqcVBFM2xMZGZFd0xZTmsrMjFW?=
 =?utf-8?B?amVnL3FQNFpFUnBPT2RXQkhsVEp3K1d4YTVnUEtEU0ptNGh6RFBhNWtYbmkr?=
 =?utf-8?B?R3hHWE94dVd2bzZWcTBDNS9kWTk4eGx5K2VIUzV2cnVxdG1ITisvZEVocitm?=
 =?utf-8?B?RlBMVGo1eExFL3RqbEJBb3VpVGxvb2lpWll6dU9wNGdHeXVnWlNtclZwSHBv?=
 =?utf-8?B?d1dIZU1yOFdSTnY5WHMvM3Z5Sml4UGhKWGc4S05oSlcyN2FQaGNwanVXNVkr?=
 =?utf-8?B?RWI0TERLRWJiLytMelhHRGszQWsyMy9lajdkUUhCTEZBalpRcU5uZz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: b978336d-87ae-4db6-6e7f-08deb7cbc096
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 06:31:27.0158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: URPhdUC1ehZuoVUfn1sYDOdgNm4TnA6oG2+GwJghIyya9GoVRrqHC4GD06JVEwKZdthpaJRgbIZ+5hR3PttjvAet1KLox5IvHi5DHkih+lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1273
X-Spamd-Result: default: False [4.64 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9075-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[hal.feng@starfivetech.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.951];
	DBL_PROHIBIT(0.00)[0.190.149.16:email];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,devicetree.org:url]
X-Rspamd-Queue-Id: 9A8535AF989
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiAyNS4wNS4xNSAyMTowNiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBGcmksIE1heSAx
NSwgMjAyNiBhdCAwMTo0NzoyMFBNICswODAwLCBIYWwgRmVuZyB3cm90ZToNCj4gPiBFYWNoIG9m
IHRoZSBTdGFyRml2ZSBKSDcxMDAvSkg3MTEwL0pIODEwMCBTb0NzIGhhcyA4IE9wZW5Db3JlcyBQ
VEMgSVANCj4gPiBjb3Jlcy4gT25lIE9wZW5Db3JlcyBQVEMgSVAgY29yZSBjYW4gb3V0cHV0IG9u
ZSBQV00gY2hhbm5lbC4gVGhlIG9ubHkNCj4gPiBkaWZmZXJlbmNlIGFtb25nIHRoZW0gaXMgdGhl
IHJlZ2lzdGVyIGJhc2UgYWRkcmVzcy4gVGhlcmUgaXMgbm8gbmVlZA0KPiA+IHRvIGFkZCBzdGFy
Zml2ZSBjb21wYXRpYmxlcyB0byBkaXN0aW5ndWlzaCB0aGVtLg0KPiANCj4gTkFLLCB0aGF0J3Mg
bm90IGFuIGFjY2VwdGFibGUgcmVhc29uIHRvIHJlbW92ZSBzb2Mtc3BlY2lmaWMgY29tcGF0aWJs
ZXMuDQoNCkdvdCBpdCwgYmVjYXVzZSBpdCB3aWxsIGJyZWFrIERldmljZSBUcmVlIEFCSS4NCg0K
QmVzdCByZWdhcmRzLA0KSGFsDQoNCj4gDQo+IHB3LWJvdDogY2hhbmdlcy1yZXF1ZXN0ZWQNCj4g
DQo+ID4NCj4gPiBJIHdpbGwgbWFpbnRhaW4gdGhlIHB3bSBtb2R1bGUgaW4gcGxhY2Ugb2YgV2ls
bGlhbS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhhbCBGZW5nIDxoYWwuZmVuZ0BzdGFyZml2
ZXRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vb3Bl
bmNvcmVzLHB3bS55YW1sICAgICAgICAgfCAxMCArKystLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9vcGVuY29yZXMscHdtLnlh
bWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vb3BlbmNvcmVz
LHB3bS55YW1sDQo+ID4gaW5kZXggNTJhNTlkMjQ1Y2RiLi44MzRmYjE3ZWM1OTUgMTAwNjQ0DQo+
ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9vcGVuY29yZXMs
cHdtLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdt
L29wZW5jb3Jlcyxwd20ueWFtbA0KPiA+IEBAIC03LDcgKzcsNyBAQCAkc2NoZW1hOg0KPiBodHRw
Oi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiAgdGl0bGU6IE9w
ZW5Db3JlcyBQV00gY29udHJvbGxlcg0KPiA+DQo+ID4gIG1haW50YWluZXJzOg0KPiA+IC0gIC0g
V2lsbGlhbSBRaXUgPHdpbGxpYW0ucWl1QHN0YXJmaXZldGVjaC5jb20+DQo+ID4gKyAgLSBIYWwg
RmVuZyA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPg0KPiA+ICBkZXNjcmlwdGlvbjoN
Cj4gPiAgICBUaGUgT3BlbkNvcmVzIFBUQyBpcCBjb3JlIGNvbnRhaW5zIGEgUFdNIGNvbnRyb2xs
ZXIuIFdoZW4gb3BlcmF0aW5nDQo+ID4gaW4gUFdNIEBAIC0yMCwxMCArMjAsNiBAQCBhbGxPZjoN
Cj4gPiAgcHJvcGVydGllczoNCj4gPiAgICBjb21wYXRpYmxlOg0KPiA+ICAgICAgaXRlbXM6DQo+
ID4gLSAgICAgIC0gZW51bToNCj4gPiAtICAgICAgICAgIC0gc3RhcmZpdmUsamg3MTAwLXB3bQ0K
PiA+IC0gICAgICAgICAgLSBzdGFyZml2ZSxqaDcxMTAtcHdtDQo+ID4gLSAgICAgICAgICAtIHN0
YXJmaXZlLGpoODEwMC1wd20NCj4gPiAgICAgICAgLSBjb25zdDogb3BlbmNvcmVzLHB3bS12MQ0K
PiA+DQo+ID4gICAgcmVnOg0KPiA+IEBAIC00OCw4ICs0NCw4IEBAIGFkZGl0aW9uYWxQcm9wZXJ0
aWVzOiBmYWxzZQ0KPiA+ICBleGFtcGxlczoNCj4gPiAgICAtIHwNCj4gPiAgICAgIHB3bUAxMjQ5
MDAwMCB7DQo+ID4gLSAgICAgICAgY29tcGF0aWJsZSA9ICJzdGFyZml2ZSxqaDcxMTAtcHdtIiwg
Im9wZW5jb3Jlcyxwd20tdjEiOw0KPiA+IC0gICAgICAgIHJlZyA9IDwweDEyNDkwMDAwIDB4MTAw
MDA+Ow0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAib3BlbmNvcmVzLHB3bS12MSI7DQo+ID4g
KyAgICAgICAgcmVnID0gPDB4MTI0OTAwMDAgMHgxMD47DQo+ID4gICAgICAgICAgY2xvY2tzID0g
PCZjbGtnZW4gMTgxPjsNCj4gPiAgICAgICAgICByZXNldHMgPSA8JnJzdGdlbiAxMDk+Ow0KPiA+
ICAgICAgICAgICNwd20tY2VsbHMgPSA8Mz47DQo+ID4gLS0NCj4gPiAyLjQzLjINCj4gPg0K

