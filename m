Return-Path: <linux-pwm+bounces-8227-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA+yDCe8sGlXmgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8227-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 01:49:43 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3A925A280
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 01:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52CF43055411
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 00:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8F636605D;
	Wed, 11 Mar 2026 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oCezI95H"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3913FEE;
	Wed, 11 Mar 2026 00:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190151; cv=fail; b=es+qv2VN0iq7uaBf6UCQr1CME7sumXO4ygsKOXPQDWvOGrqqKJHgnmwYV7RqmvuJZgKMDbh3I9/kq/vUJBA/Xz+AqqlZl+xMktl2CtqL1gySQR8RKIOxuZSX/yzkAnrCZR0NC4fsiu7FT3Qx/EyAbcQU1JS7OH8hvIljViQQcyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190151; c=relaxed/simple;
	bh=mQXavUcgvRlh3K+M2uO5GiLyC0fytdB0YZJCk89SVEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EbmUqZoiLtihygkEndqFe8YRUml0LNXUrUry5BDnjbOZ7a80rZ9kZl7+vWC3ShSeyNafoG9G8Rdf0rtITUGoMaSnzbV4qK4pLrpG+Zxsaf4VvMlfNBqSS4xGxOqPia0gd07Xrkk1ucskz7HanUqk4g7cIbyA2gcaRfjcpx8ISpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oCezI95H; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AI9Msb3503258;
	Tue, 10 Mar 2026 20:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cu/JY
	KR8eVz8g7pqsVf39j5rdCYLC98y4PFYk3oWOhk=; b=oCezI95H76FcObzeqHmyE
	G0S4ed2bmHwaAB+Kjdw6B6kuMxxrU6+aef3adMh1F009TiHuitB32FHht1JY8QQh
	DAUUVBWigKExGG82elJvXPPYd3EG5Cc8anP8IYotZ/hKTMXDfgImRNToXs9ZjWzW
	zL6ZnfpAXEuNSXqzAQ203ETNxeQUvaeKn9kKU7xN8VEl7NMfjfhAU13JVdUbQcke
	6rw9iCOqIuYyD+pLbgugsSWlnEz3zeRJ+HoELtNmw6EtPblUsJ3hrhfLzltxfwyq
	zHiQqViZWxlTgRhFGYH3bLqSxH4WeU4EYzHMRyZDPm+IIoMB0nPPFDStAQHvCbyh
	A==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cs5bg3shd-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 20:48:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owYEAlFCzfCpHxZF3nBfTT7WTMODa4gsafwCq/EpDGbPudDhrRgSxf8qBFIhqocEUbmdZrdiabPKTY/uipxKl1ff0v8VNg0DOxmuM1gzPa3KOmPMUD827foQtsHDmOFgdwMkmmcMfn7QKbFTIJ9ilV5eCh9D2QfAP9NwisDJgweRv2KjI+PpCKvujprROqDD+fYZqKACy7Zh9Idg6cT4KzCmX5okVXmabO8qVLbyXQMwy6Y3+T9REiPjShCTb+ba+PwA+NyM9Pv82AoFuVVgm7+fP3nQNc7i2M2DiqMIWTewTsuUfNdx6OXEi75RVQ2gD7Z47bipZLWSjM1MbvY/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu/JYKR8eVz8g7pqsVf39j5rdCYLC98y4PFYk3oWOhk=;
 b=YC19OvxvgfV5HWKpMEnPZo+xGXVGReuiWydu1Xm5zkdR7K9F8vF/uMyNaMTPmDKcUDvYTDlExj6rM+BhrDGpYh4Lh5c2JLDaEZDl4HXfdMb9AnTUvDXomHiHC21TZcPDXkXIQz9LZ/GcUXMCaiMWfe/IfORuDJynqn/QbPLP+Grcax9C9aoVdIQHVPShVFJMFRfLPizo8iSZj+JntwHwlgc/4Motpg8ufHSucfI9KiJEINP2YYwxBL/XlMFoTwuuDymca4aTEOgNeNWJpuPTxcnaxPQf7Ii/naySzAHJymufBlObVTtWhhFLVsFbtsAWkElNoXmWwVGciJyJyqOmEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by SA5PR03MB8404.namprd03.prod.outlook.com (2603:10b6:806:47d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 00:48:52 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 00:48:52 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
To: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>,
        Lars-Peter
 Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] dt-bindings: iio: dac: Add binding for AD5706R
Thread-Topic: [PATCH v2 1/3] dt-bindings: iio: dac: Add binding for AD5706R
Thread-Index: AQHcsO1aec71L3K8Tke0YXSEl4cr1LWofIqQ
Date: Wed, 11 Mar 2026 00:48:52 +0000
Message-ID:
 <PH0PR03MB6351FFE17AC1F64928D49F6DF147A@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
 <20260311-dev_ad5706r-v2-1-f367063dbd1b@analog.com>
In-Reply-To: <20260311-dev_ad5706r-v2-1-f367063dbd1b@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|SA5PR03MB8404:EE_
x-ms-office365-filtering-correlation-id: c1730bda-dac5-4707-4323-08de7f07f77e
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 xdKrOdBi7KVvf6parPXbgR223N5yXQH8RuTqMHi0pGWyvVxFhUvjbTFVXfp3x8Rn2AMOT7dSRnKiSBNWOgoUgVsKMp1AlVTEEiDQHGlNbVkSL/envQOMXNBXgSC+Kw5qf5knuLFtFyoGsNZJrcmpMK9rgURSf5WKOzL/jeg0T3zmsdsFvmO5Yzsl+ALeTnmOZmMt18sm7ExJPXQ+QcARD40l4IaYnhX+2T4v/CFzx9HbJ3svloDR/aIYe6CqtbBV29wptKvBJgojSKVsgoCtuUMKJWdy2Y1aqA0WqU3jaTDCfhdyIXCITMHV+vTDQWW7kUGjoyaoYEQcwiEKGKwwrAfrsf8R4AHYi+3L0lrkaU4N/fNvVzwNaTp+nvBOqbigE52kBrmza8VnccfHgz0tOn6Rl2WxSqYAN+jQAleWyXh4GlqwZ/hXSP7GaA+duMMeQ62P9lfO5qXuBCOgfA/QwsdIvf9+e6WEP13U97xuXZpJlrSgxWCn5Nsz2kzbG8GpNppfO/FNNaDigATTruDFkvRH8pbmYIRu7E5whjL0eVFnhDMh06Vky3RQ5w8FmRgJdP6VGK/WbkIpv+TydCDXFzi/XxA4veIy9c70TTCqWA4dNF319qf9KKUtpe69GH9YHaG4DOGm4htVs45nAWcjtHwUzZd8p5SGAkMhW7l71pX4yDVIv9ilMHYSl1DpbaullsGT0kRWfHPVECVMd0OFUnbuN2Tkqu8SSvGZea/Rjy9+/nzR58NzQsdR1R2gbdfFPP44Q9MqyLsJ39SDKr7bYCAFpDsltAXiGoLT/c20yfzgfKnssfbkvLzL7zuvkOA3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ic5V1i20l/XkBAlQ6/pOQ7wHdZWTYgoJ9OBihWaufPJXNrNv1ge8vzYkl8?=
 =?iso-8859-1?Q?pRiZ4sLWv/E0+LJ52KNdgsbkWnSNM8kZt04XG9gHdIduvYe83cCECRvEul?=
 =?iso-8859-1?Q?mIeZL8F6gO5cCUo8QxQAsYewvPl2ECxhvH3yqbpzHS0+OtQ6803XtZZ2Jw?=
 =?iso-8859-1?Q?o2QMzVQ7v8PU4yEXNV0b62BBwW2AxEGLiaCKAxjtFnoCSB6b7gPanZG7TT?=
 =?iso-8859-1?Q?qcHiaB1Adz+iZ9tPnVQPmRSbnyoM2a+JCpJabPCbadDOfC2mFgFKxvvwmI?=
 =?iso-8859-1?Q?82hxQ608sdiGsQQIgnajtLN9eBukrKetTIWXl2VXkhzjRG5B312bu63rk/?=
 =?iso-8859-1?Q?7P+vAGhaHW4ii0HBFanr64B+nUJoRdQXrYxpbxS7jBwlKXskDNYj1o46pl?=
 =?iso-8859-1?Q?Dk0JWpFAzWExGpA3j8CNw2PxUwGZju7QpSyb4JKDe2WxtmQe/5lUXB+0H8?=
 =?iso-8859-1?Q?wriyTjIZXHkiSUFyZRZEdB+UsbexD8SAFtZrjdQN3fwbeAPNRc7QjqqvAh?=
 =?iso-8859-1?Q?WgxcG+5i+FJxvkOepJhcjGIXrDegNmV+AKhwFZq2j3l9039XkbMs2tOD3A?=
 =?iso-8859-1?Q?RaBqaCnPbGS199Rrx53zkU2KBNeYydnZTzAQq7lOG/GzjwrKPb16cOoF7+?=
 =?iso-8859-1?Q?Q9cPblrMK8mhmmzV1zOPDzd5DDVjoTDlrNey8O5rEgC73GYJ/3ePoZEiPw?=
 =?iso-8859-1?Q?15fdEi7lO8RAv2lakcvQeHnGXxQQpVLhuDKpAFDYlTmyE/aL6SBmHRtCC2?=
 =?iso-8859-1?Q?0TOls2CK7sGgv+b5boTu1wvmjA5HSjUi8G+BJjcPGvSmMeHZdxMg164EGO?=
 =?iso-8859-1?Q?7/XFA2NWszTIrKhMt3c3lXSktvyKevAix0DOqgDqCExDGgEWcX+mmcDXJ2?=
 =?iso-8859-1?Q?YbUtsQm+YaSuu8HRqHFvPDPN2S8cF88AGMlaAk0AOoMdFdEReKIqVXg0gP?=
 =?iso-8859-1?Q?J7cpTnsFgofUeTM1tZYwq9FnSDKCKmEs1bId7NUmrmpAWYS5hz33ABPw3I?=
 =?iso-8859-1?Q?z1eUPtmK5lytYO3noKA5rLITEQbIS21D7hjrBtVSVvtT54V7yrr4QdaI/1?=
 =?iso-8859-1?Q?0tNednp6fsrs33ZsJHy3mk4aI2r+K55LFPgFsIkzhx/hGd8VLkRZ1SYsx1?=
 =?iso-8859-1?Q?uqGi1t3TAd6WYirn4YcNHWFcfU1jVhCqimQn/wfbP8xoyjm/NrgqKiENke?=
 =?iso-8859-1?Q?SdYDnAY7jlPa33ynZAExcGqQEyhbKLwCK517R6jbejgu9zi9wkDYUCrWj0?=
 =?iso-8859-1?Q?AXeftZ2Z1i25rfeObUFBswGziK/uqi3rJUbVuWNvIWI/efy3YUolhurbID?=
 =?iso-8859-1?Q?svgT37nj6fzqd4SZ1Ko4mDlslr31af414qt2sDR6jMrKFVTT+Va2H9hj0l?=
 =?iso-8859-1?Q?TZlUaSYkCHzxqVr6b5vRPUQOqvG9u7i3UzOaUKJh2d3T+swdYJAI/B6ojK?=
 =?iso-8859-1?Q?Ap+bsswE/06eyZ9fKin/D7xGbaomjrfOruvWjraEXb/k4dXwCToeAbbbK4?=
 =?iso-8859-1?Q?7L1zOHikRHaC4x6MLGN0f2G9DxpSSlbXUTgJI10dEAbLQyF6gxKs0X3ieY?=
 =?iso-8859-1?Q?wKOC3wRVrnTT0HKrAeB4nMgQJrcadeUtDDQEr4v+qzNHZAftnOXGVXWfFH?=
 =?iso-8859-1?Q?+RJET8Trv11m0fqGEB2tluIEmlloz682XgZcIqjTe+QX3sJIHMFQj9Z13V?=
 =?iso-8859-1?Q?x1GjbnzvYJCrBrmZaafP+5E8G0hfPIefMXN9518oI8kZcPGIyWGxaW4B2h?=
 =?iso-8859-1?Q?dxMqjvPyz/Nzb3tCh9W+1+orEI4/wBlPN5NksjYYAQWKsDG5Jc6548E0UB?=
 =?iso-8859-1?Q?2RHhor9Fe1695ZM3+vzAyy0ipmyQh7Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	F10cPR0eiw7Zc2reD7zmyLs4GLLF77fpdOnN0WgT2N8kX9GvmVgEoPGdx3qIIugALd+eofoiHbPUlkWVvM3f47fM9VWcmWhf+WGnH3F1SwJ9RFfy37DyFlbSeSDdTswpZtLQEOnvCBj03QIBZyWroOqVzP/ZKEr/j3F5oI6p88/2bnKo0pdTh0gwRhPLAl7ix+yzBTHP2HPRY8D4l6nxSfaCdkfKciBGIoylmJgbJUhnsFeoHhF5aODUZoKW58bVovC49EvLm1UUZ8uCHlpptkHHrlQ7oSegrqDV8AT9aoYMU8OPkDbB5caAphzS7OdcYTM2HdYyrQ0vAmD0C0S49w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1730bda-dac5-4707-4323-08de7f07f77e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 00:48:52.6446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3CJwwplGKDfUS0LPhZI844NDI72lrB9VPFtVAJenNCV4ypNgLYkEzohd/2qQVrPAB0PpMCYF442tiIB1CtbaHO4jaA1nzUzjJBjlNzTgBXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8404
X-Authority-Analysis: v=2.4 cv=IP4PywvG c=1 sm=1 tr=0 ts=69b0bbf7 cx=c_pps
 a=0PDhd3HO6khzWhHQYbQRQA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=9DYP_U8_eHSy6fKrKSoA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: RJjfTzfZPfJOq5lEnLaw4pbXOKqDwQa9
X-Proofpoint-GUID: RJjfTzfZPfJOq5lEnLaw4pbXOKqDwQa9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAwNSBTYWx0ZWRfXwb+OJdfk9ISb
 63wbjaj4Ri/HksiF4g07SQ1EYznO0z5wY3mwvQifBadB00RQSJQSCu58iIR73om6Gi2W+JyacMF
 rI6yCK5/zO6K2AEYLawsyprcqg0emlO9SdXJ+zlPccVGX9LisdcTZYZTbWZYZQ43kcALOwTLatQ
 jbvxIaNoN0RAVBMrZ2v/1ACaxyWFZf0LHFN4imlLrkHnwGfpocecLFLctxE/ZoKAtj8oOn1a2Ij
 1NenFTckFW9g5iYX6mSBRxCB2qxchqb67hoJ/BFYx5AY3Z7PnkmbRlkJVcCksg7EOjxiU/fFWIJ
 B/7VLJFQBuYA5Yfc5Y9Tt0S0t7WORnCwurBnlZWShBvKh/Vx9NTkJBR77ltugWnRwaRNpttF3Uu
 5w3o4yBJdFl6SYCKAtaO/snu8RYJpE8TLUu/oBUyYOLrcs1lnjlS2QQGU4qdSRIR/YK6Tz/JQp3
 Ojy1cL5CAZii8fk1g3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110005
X-Rspamd-Queue-Id: 8C3A925A280
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8227-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,analog.com:dkim,analog.com:email,analog.com:url];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[analog.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[AlexisCzezar.Torreno@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.0.0.0:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


> Subject: [PATCH v2 1/3] dt-bindings: iio: dac: Add binding for AD5706R
>=20
> Add device tree binding documentation for the Analog Devices AD5706R 4-
> channel 16-bit current output digital-to-analog converter.
>=20
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
>=20
> ---
> Changes since v1:
>   - Removed clocks, clock-names, pwms, pwm-names, gpio properties
>   - Simplified example to use plain SPI bus
> ---

...

> +description: |
> +  The AD5706R is a 16-bit, 4-channel current output digital-to-analog
> +  converter with SPI interface.
> +
> +  Datasheet:
> +    https://www.analog.com/en/products/ad5706r.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5706r
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 50000000
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

Hi All,

Apologies, feel free to skip reviewing this for now.=20

This file only trimmed the original yaml and does not contain the feedbacks=
 from
Version 1.

I'll be more careful next time, will apply it on v3.

Did not apply the ff feedback:
- vcc (lacking)
- allOf + ref: (lacking)
- change additionalprop -> unevaluatedprop

> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        dac@0 {
> +            compatible =3D "adi,ad5706r";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <50000000>;
> +        };
> +    };
> +...
>=20
> --
> 2.34.1


