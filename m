Return-Path: <linux-pwm+bounces-2980-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF43D94A842
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2024 15:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0451C20F7C
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2024 13:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00DF1DF666;
	Wed,  7 Aug 2024 13:05:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2094.outbound.protection.partner.outlook.cn [139.219.17.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C2A155C83;
	Wed,  7 Aug 2024 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035928; cv=fail; b=dPkm1PKWwN3o3+P9qfir9IG+yVIQDColSjxbqhi5gqhUh8I0pJqoYBRJ+Xu9+Mifw14dBUc6uL8se3GI8+sdIqqJIWwVLRLqCfXmjoipXWXPqRJN5QchmpDy6yHwCQNAGDLPZRyGx0T3S0JCYKWap1SIhd14VwyE6vb2xKe+JR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035928; c=relaxed/simple;
	bh=tPLKakYpNFYzkD9Z56Bng8KONYO7LSMCdHRnAHcexGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CFIz8QZmj8HnuOeW022K5PTUvDvBoZlLwjfTPfZdIBzRmFJKT+igqNpLplaO+3CjT6W+OZwtGucN2RQdH/kfc0ucvYf3g/aIBjMryC6L9Vyu6cFSl5FXGVYieWsHlOlkVDPVEQi/xj4kpx3en9Ui24IQDGD7KCuojd08x/VfgIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIi0JEvbxNvy3760o03DgIk+caQE5F20praz8Kx0Fw0Do3c109E2yJI+pZyGChCTHBy82ZeUy9TaC1prwrUqE+iY0XKt/+foJhqE9UhA2SQWA6R/6HcD0xljVlZmLuGWXvT9GH85GaYA3CyizphrqKnwhLzV0LcYgE/JFhK468ocIG83jlbmZ8lXqD888rFe6d9NkWrV/NNkWX/N9tvTi8C0wqQW070t9i/s9uYM0o63/n0i6+QURRSMdb0inJeHtf8qgvhkd8lLpC39L8h5eUlyNxstZaVIzvslYM1D8Xzrct+IcydqidNJ2gE4rDzft5oVhBl4Ttuu7GklzQ8geQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPLKakYpNFYzkD9Z56Bng8KONYO7LSMCdHRnAHcexGU=;
 b=Wy8sB08IMHcbhdK3TEZO6aoIAn3Yz7v2vSlIln/8kbHrw3MY1DFI9eGdgd8KX0a9Z6+N+RpaklKAkPIPTg2Skjtf6zDpNSd3k1H0+0f5JvBRE+18I3X/9lW6J6ssDAc2pbd6fw2ctHN6sKsW8C8Nd7cpRXz4ndOhPlgJeAahDHL1yOyWNM9bbTkXdg3ZE8uluD7K2N8xpVU/mAcNJaXZ0AlOfc9S6oe2dpHz7FopAoTzmkw3UBoFrN642Y830pYoxf7kqwYhb4QbUuuQ8RvWkEN3wa1fvR9Q9nJVG6dwSnvQpG96fMT3mazR9gQQxAzadS108c4Zq7AeWLxwlO+Fyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1078.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28; Wed, 7 Aug
 2024 07:29:32 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::6e83:b5ba:ad4b:3ad2]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::6e83:b5ba:ad4b:3ad2%4])
 with mapi id 15.20.7828.023; Wed, 7 Aug 2024 07:29:32 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Hal Feng
	<hal.feng@starfivetech.com>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH v13] pwm: opencores: Add PWM driver support
Thread-Topic: [PATCH v13] pwm: opencores: Add PWM driver support
Thread-Index: AQHazFtF3+eYJch9O0KeXWeTVmCD07IasNwAgACn6uCAACvGgIAAGZLA
Date: Wed, 7 Aug 2024 07:29:32 +0000
Message-ID:
 <ZQ0PR01MB1253BF74E45489EDBA1A8DB19FB82@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
References: <20240702083848.1947449-1-william.qiu@starfivetech.com>
 <hyzutti2cwarxqx32frw5ytui3xib5tus3hb2loekq6s4s3442@wit2usgcci6v>
 <ZQ0PR01MB12539F35A27177E1CCAC43D89FB82@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
 <jptwjtzpoxzvzkcdicjrye46iy5uretz5oqxh6gu2zinv7ikae@3vpemq2ewywj>
In-Reply-To: <jptwjtzpoxzvzkcdicjrye46iy5uretz5oqxh6gu2zinv7ikae@3vpemq2ewywj>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1078:EE_
x-ms-office365-filtering-correlation-id: cd057bd1-8b62-4af5-08a7-08dcb6b2ae23
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 Q4OqmC5KaM1zWQqYKELB54LLHxd+RL1bwdwEmcXGyUEyR0eiM2nBFUo33oLwYmjFZG7XR+2mCeN0uxde5cHTkwjSMxMuW0V/BovdTx5zCR7WyJ6V6tTifSiT7atLp97d5lMDOanwUz2Ny14AqsLMaAXyFTD7rq9NcR9GeCYQ94LkYRlKJR6Vfm8qS5JRVoCOj6rb/7KunG7DyRgBUXxd8+NixZ3SWs91koYqbrK5BkLdqqavW8vSHDqYyLKyOFAlaUd0miMAvEKeZYu2QMDncOxE2Uu7LrQxn1RuwFYJHZM2v/8mHBb3rKV4FwxAuN95IzR6h2DJBLJ+hmaOvu3mzdoydBFQcRxMqaoSXgSv8opoOHa7TQYb98x5opqnUsqbzPjSXygCYFOq9FgKk6ad/w0ID0d4YCKfTDpmKYjZDbv8hDZTOi+9LVVImw27wsPJl6uBbtCjwN7NzZJiyoVBxlzVL6NjOP6I4vxV8MkAO+W+GioXGs+NJlQcs6BLXBpOIPuhnx8SYxeYnWBKk2LMFmpm4hKDhWKVtsSDXHc99HNxdPv95dEoHfnX0ao/E1oCVm+1vCkFCv/TmJFrtrO99IXBalt4r91xYpboVvFygQCoLbPKlUI4tcbWJyIgLg8G
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGZHY2c1VjZYdy9tdm5WNC9XODJ3V1pFdFVRSE1vaUR4bGw1OTE1V3Fhbmgr?=
 =?utf-8?B?SWxhdnRTbVV6WVBPV3g3M29oSjBTZjFpYk5tYVFOZW5NSEcrUXc3WEtEVDFa?=
 =?utf-8?B?MXdMcWlGUWgwL0xBc1loYkJHSisrMlRXV1RhR0JiejZJSEJNNEx4REhuZUFy?=
 =?utf-8?B?ZDBRMU45elBVYVFIcUVlRjBwR0xJWTFTNWRWakxMMHQ5Sm5VNHNldDdXeER2?=
 =?utf-8?B?aEErc0tkSDFZVVpnZmZ5d1NSNHBFaXJHS0luRVRWeU9nTmZ1cFJFL29NZDJY?=
 =?utf-8?B?QkpBejFMZUJaSU5EaFlvdStKUndwMEdJTENKVUU3cllpeTM4TjFWZDNOTHJS?=
 =?utf-8?B?STl2TFVYVkFLYUNlSlFiMm90RlgyTDBHMG45OUFTVlRoUTlPY3NrREpEQVZw?=
 =?utf-8?B?Q0pXOUludTJoMnhnS3UwaTdaNEFwOFRBb2pCVjhiVXo0eC96VUNSZVpJS2Zk?=
 =?utf-8?B?Y043eTkvTlR5VTdZNWVDc0RtaW5FOVdCWTJWUGl0bGVXZFROT3NCYXRrTkt1?=
 =?utf-8?B?U1EwV3JKMzYxbHNzWkM3SzUzeS8yQTFGcFJ0UmwySGF3S2NtTlFvZG90VjJz?=
 =?utf-8?B?ejFFeFBKYkROc0ZKbVdMYk1mUitVRGFYU3FlWjZDWDVBQkFhS3NqQWdTdENS?=
 =?utf-8?B?aXJ3S1pYdCtDdEQwQjl1QnE5WE5hS0JKK1VrclVWNk0zSmJjN3pwRzJNYzVP?=
 =?utf-8?B?cnN4cElOUE1Sdm9PbEZ2aGV6Q0sxQ2ZsT0FGcUZOb1Mya2ZrTG5TUGFsaWxu?=
 =?utf-8?B?SmU0dHQ0WlhsWkkwWm80TVNzamNKMi9kbHFPWjdQMmFSSGhsbWpCbHMyVHFP?=
 =?utf-8?B?RjNSZFpKbTMwL2xwL25LcUNuL1lJNi9wMllCdG5lOWdUTUIya3dlOW5NaWNQ?=
 =?utf-8?B?ZmhYeXNvL2Y5c3JFRytuVU1YRy9PSnpkUnNSNWJySDZaL2lCSkNieHRZMUVv?=
 =?utf-8?B?RXRaNmJCbC9OZHQ0eHNjSWJQdVUzamNSL3lyemMvMGV5Wk84dzl2VUdFMzFr?=
 =?utf-8?B?bjBvdUFLZUZHVXJFbHROdnVXT3hJZ2ExZVZNdE5QUGNvQ0J3bFBpVlZjL3Bq?=
 =?utf-8?B?bW9VOW5TTXArZ1BKTFNoTE0vMjkwcTljb09kanlLY2RCTHA0bFc4TUNmZUJU?=
 =?utf-8?B?WTVPbzNidUtIeVE0bHY4YUs2NnA3NVpWNVRxdG9qUmdxRENpQmw5QXZPaEQv?=
 =?utf-8?B?NUVLTTFxdHdKSDFielhQSnRnYkJCdGlUQmp4R0N5UHRvb3BnZVBoRXJQdDZo?=
 =?utf-8?B?a21zdHpwZnk2VVBmTnF5aWJaTGlGbWx3eXJLaEZuSUpiZld1ZCt0clBGandm?=
 =?utf-8?B?dHBKTE1rZmRPbE1uZkFkRHhEMElGWnF0VTRLOUpTMjlmSnpadFAvWUxGN3M3?=
 =?utf-8?B?SCtVbjlJVGJvSXp3LzRMRG96ZXNlZG5IdVBEZThGQ1hwRzg3YURQOFI0MHVS?=
 =?utf-8?B?ZUhTSzROQkxhOGFhRDBoYUswUXVoU2ZDWUZDQ2VndzRib0l5ZXFCdEJRYWRK?=
 =?utf-8?B?RERjTFVkRTRKUDFsT1FDM3UxR1lxQjNxckp3Y215aWhzbXBOYVZTN3lUMER5?=
 =?utf-8?B?cHBab1I3TWlGckRGS0JFd3RHeHpVRGhyaVdBS1UzcUtpR3ZtOE02NS9TYjc0?=
 =?utf-8?B?M2xCNmZWVnF0aHdYa01yMGs0VDBiYkZuN1BzUTI3cEVieFAzdUs1RXk2WDNn?=
 =?utf-8?B?OVh1elgyY25MSnV0emg2T3FBWFBVUE9pU1c4aHBTUXlnY3dzbjNWOUV6bk51?=
 =?utf-8?B?bjdQbGVLZFJrUllrTFF3c1FoOXB0Wkp2dTZVdlBSL0tFbWsvK1N3Qmp3VmNH?=
 =?utf-8?B?cThHSEc0dkdOVCsyUVJPbytkb3o2Q01vZmovNzltZnpjdWRVSmlPaW42NGs1?=
 =?utf-8?B?WlpTSUFWYlhKRlVlQkpWMTdBK1k1RkhLWUphRTBVYWlTMEpFZE4vKzBhS0x4?=
 =?utf-8?B?SVVLejlVM1FlUmI0TXI5cmlaZWxxQ01xMVJaVEwzcGp3ZjI2U01iV1puUEYy?=
 =?utf-8?B?aUt1SnFCNzBUdXpRRlRWc3BOUHBGR2hnZjFuQU9nTWQwUHNjQnZ6L3dXWmdH?=
 =?utf-8?B?YnRnSG5nZm9hWE1LOTJETzB5cHpqRitNeWVhcmRydHYxdk9jc09lOXRQZTh6?=
 =?utf-8?B?dWUxR0M5N21tV2V1K2ZxMTJRMk1SS0drVEJ2dk44UThnaUJpcFY1ZURDVHFq?=
 =?utf-8?B?UUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cd057bd1-8b62-4af5-08a7-08dcb6b2ae23
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 07:29:32.1389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIz/ksjaGck9/Z1X0xHxnYFOg2ur0TcOyYpPmEiRl0rMwG7Mc0iFvOj9ttveOzny2YvSAKQreHPYqgEyp0ra9zNDq4yx33aDCKZnrOVpDLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1078

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVXdlIEtsZWluZS1Lw7Zu
aWcgPHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb20+DQo+IFNlbnQ6IDIwMjTlubQ45pyIN+aX
pSAxMzo1Nw0KPiBUbzogV2lsbGlhbSBRaXUgPHdpbGxpYW0ucWl1QHN0YXJmaXZldGVjaC5jb20+
DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wd21Admdlci5rZXJu
ZWwub3JnOyBIYWwgRmVuZw0KPiA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT47IFBoaWxpcHAg
WmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEz
XSBwd206IG9wZW5jb3JlczogQWRkIFBXTSBkcml2ZXIgc3VwcG9ydA0KPiANCj4gSGVsbG8gV2ls
bGlhbSwNCj4gDQo+IE9uIFdlZCwgQXVnIDA3LCAyMDI0IGF0IDAzOjQxOjE1QU0gKzAwMDAsIFdp
bGxpYW0gUWl1IHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+
IEZyb206IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAYmF5bGlicmUuY29tPiBb
Li4uXSBPbiBUdWUsDQo+ID4gPiBKdWwgMDIsIDIwMjQgYXQgMDQ6Mzg6NDhQTSArMDgwMCwgV2ls
bGlhbSBRaXUgd3JvdGU6DQo+ID4gPiA+ICsgKiAtIFRoZSBoYXJkd2FyZSB3aWxsIGhhdmUgYSBj
b252ZXJzaW9uIGN5Y2xlIHdoZW4gcmVjb25maWd1cmluZy4NCj4gPiA+DQo+ID4gPiBJIGRvbid0
IHVuZGVyc3RhbmQgdGhhdC4NCj4gPiA+IC4NCj4gPiBGb3IgZXhhbXBsZSwgYWZ0ZXIgdGhlIFBX
TSBkdXR5IGN5Y2xlIGlzIGNoYW5nZWQgZnJvbSA1MCUgdG8gODAlLCBpdA0KPiA+IGlzIG5vdCBh
IGRpcmVjdCBjaGFuZ2UsIGJ1dCB0aGVyZSBpcyBhIGNvbnZlcnNpb24gcGVyaW9kLiBUaGUgd2F2
ZWZvcm0NCj4gPiBkdXJpbmcgdGhlIGNvbnZlcnNpb24gcGVyaW9kIHdpbGwgdmFyeSBkZXBlbmRp
bmcgb24gd2hldGhlciBpdCBpcyBoaWdoDQo+ID4gb3IgbG93IHdoZW4gcmVjb25maWd1cmVkLg0K
PiANCj4gSXMgaXQgImp1c3QiIHRoYXQgdGhlIG5ldyBzZXR0aW5ncyBiZWNvbWUgYWN0aXZlIGlt
bWVkaWF0ZWx5IGFuZCBzbyBpZiB5b3UNCj4gY2hhbmdlIHRoZSByZWxhdGl2ZSBkdXR5X2N5Y2xl
IGZyb20gNTAlIHRvIDgwJSBhbmQgdGhlIGN1cnJlbnQgcGVyaW9kIGlzDQo+ICJkb25lIiBiZXR3
ZWVuIDUwJSBhbmQgODAlIHlvdSBnZXQgdGhyZWUgaW5zdGVhZCBvZiBvbmUgbGV2ZWwgY2hhbmdl
IGR1cmluZw0KPiB0aGF0IHBlcmlvZD8NCj4gDQo+IElmIGl0J3MgdGhhdCwgSSdkIGRlc2NyaWJl
IHRoYXQgYXM6IFdoZW4gY29uZmlndXJhdGlvbiBjaGFuZ2VzIGFyZSBkb25lLCB0aGV5IGdldA0K
PiBhY3RpdmUgaW1tZWRpYXRlbHkgd2l0aG91dCByZXNldHRpbmcgdGhlIGNvdW50ZXIuIFRoaXMg
bWlnaHQgcmVzdWx0IGluIG9uZQ0KPiBwZXJpb2QgYWZmZWN0ZWQgYnkgYm90aCBvbGQgYW5kIG5l
dyBzZXR0aW5ncy4NCj4gDQo+IEJlc3QgcmVnYXJkcw0KPiBVd2UNCkZpbmUsIEknbGwgZGVzY3Jp
YmUganVzdCBsaWtlIHRoYXQuDQoNCkJlc3QgUmVnYXJkcywNCldpbGxpYW0NCg==

