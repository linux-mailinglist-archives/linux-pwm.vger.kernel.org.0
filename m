Return-Path: <linux-pwm+bounces-8280-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC6ENaIouGnhZgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8280-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 16:58:26 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEDC29CDBF
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 16:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E31253013C99
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 15:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A193B8BB6;
	Mon, 16 Mar 2026 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="X5Aw/Re5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E843B8957;
	Mon, 16 Mar 2026 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676700; cv=fail; b=l/6BGzXDUvTihjhsdzIO5rknmVlekx2mYy+1hbTSeNSDbr8IMYJBoYwCYlQda09yyxugDQOSsjV6GNOA1euwwstw9msXfeXwbfRxmc/vU7jJz3DcwGRwT+GJ1VuXUt+vDhMNJyikkiQJXQGLoxcSGzsmx3BURN5Vzansh6wdJjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676700; c=relaxed/simple;
	bh=QraQiNC3ToeGGM3Kfc8G70JYc3SrOVKTvIMJqGARJoU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BadAVsQzxicX7OrPrNvp5Ux95YeseCiLk7lvb/vmexMNTl9+cr9h/8q3E8Rejd2bDzPmEEAdXVvAh0geLKmuR4aQI9V85bufiO67zMjokDzOyh4bj1QcnMEj+/l4iC6sb+0Ut8H74EejNKVks0K1urEm/4pv4p6JyUiQJWsUX38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=X5Aw/Re5; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GExLeD270160;
	Mon, 16 Mar 2026 11:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QraQi
	NC3ToeGGM3Kfc8G70JYc3SrOVKTvIMJqGARJoU=; b=X5Aw/Re5KJAiyKCv53O1k
	RSE4bXYUWQg3Nn0S2XpPwSty0VCQ563aBlbRgJJI1TGJebkFYuIVfd1vXmDncLp1
	kxG8sIj6Gh9f5hMHBkv/+MhpJ66Vj4W/5h/4/uDg5FeyaHgcf0JCpWOpCWmcQNdE
	9h1L3LJrMWw0Jg2x3o7aTXcbAq8Xh1G23P/wdL9BXjRNNceplbac2rRGo3EIA0sP
	Fwqu3RF3/Zf+xL3nxm/PAmzPxmYAj+YZwGpVrN0/nySeaBgHcgqjOvvbwATIVCUI
	HkI6hOH0z11V+7zoFOWjHLz33wF8RyjtZ7XSAPQcuPzF1T88r7FMICAqlp1mGzkA
	Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cw4k0y668-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 11:57:57 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgkCB40KjoLg9I2BZXvctCww6fcOuEhM87M/YVmYNHUXCZz4UqaBh/OiD8B9xsSKyc36QXckXJhMtLo8uZ0LAtdrNUiDjdHg2acDEOF4ZOJ3vH99/du0IpE1J+9THV5aFVipR2DtK0A1p/BSJdhNPGnKcGN6G7PK4L72lk1kCdTCP6gnOMcPvm6FhA0053bE7P4TCg/I51NUZoHjT/PFBODZ4YJAUcNWco4Ih/xmHR57F+Z3WQUUYuz1qFZZh0NW0MdPdfA+4SS4z+Jy7wi3r8Nk2TlSEthLN4zHsneDBz31YCZscrBI48TcXQOoju+YLOqOWFX3XoKwSvomYeK70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QraQiNC3ToeGGM3Kfc8G70JYc3SrOVKTvIMJqGARJoU=;
 b=hYTVhFoUigqR04Sm1ZUQSZ61r1oDH+5EP06gRG7EdrugmtmJzTp1C4jsY2PsMYEkc6IQCCgbcvWXl5rEG8pSn4Ev8HsoESWoRcoslDvXrpgGxWnA/O29p1K09YXUnIm87WJtB9E6PdKt0kKQkWKFrBnU570zPH2p8B04Kdwo/wRlNW8uKb9ToP6wD+3Yn63Huau+kw2rLWAHUPAA35yG+uua9Zj5Cy7Sy/hcq667dZTkIqALSKY0qrvf+/A2EEeVZGrfJw9CR8pbyVlVzfUpCwtmGsUieg44A/Na62pCk2e+QMDC4eZOnpk9ZDjNb1iWbu7Eeo+NXjp8aCoRlMgK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by DM4PR03MB6191.namprd03.prod.outlook.com (2603:10b6:5:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 15:57:43 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 15:57:53 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Sa,
 Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<ukleinek@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski
	<brgl@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Topic: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Index: AQHcstE9wdxbJGrMMUOmE/HdBho5IrWsSumAgAT5J6CAAA/NAIAAAaNQ
Date: Mon, 16 Mar 2026 15:57:53 +0000
Message-ID:
 <LV9PR03MB84141484B1472E01578A2243F740A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
 <abPtv0Y_QWYoMuAO@ashevche-desk.local>
 <LV9PR03MB84148A9A0A7F6544CF370B7DF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
 <e33b0096-c7b6-45e5-a9d1-8da11714ac8e@baylibre.com>
In-Reply-To: <e33b0096-c7b6-45e5-a9d1-8da11714ac8e@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|DM4PR03MB6191:EE_
x-ms-office365-filtering-correlation-id: 6386d987-191a-45d4-e0db-08de8374c83b
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 kRaXqZ7C3sS7r9QiFbWxfx5kKdTPgFipm2zxd8IwD2rMKt8tbgdOTVrWEHS69D8u4KFW/wPJNYzBAeWihL8pih4apgMVg4GwTnYcWgUUfxffRCY0c08ShLaF6eZYvaDzenGsrufT4cG8Dm1dga2DXf0gzcRlpt0leJhxgFZNyEeWgclkFs9+ytSHVMdAn5OIrtIX2jxCW77eiXUcPmxr3VlYc38FI/ugam7x1roMmnWr1Ahnv8lxtuKbe/Q/wnspE7vVqoO/EFWwk0ZsGJBHvsexVcbhcHhcv+K9p6HuhL/XhLQy1N24t1n9Oya8YmexZYWH0/RXoAbAikNsWR/8PzULQIpMzFQ5GD4VEl910qitdWcFj3iC1oq0VdEJEHxKUpKeVEwP6CloNrLE1P22YGV6DN/AwQrEYoUGjUX9pfmQKSwhR3LoVHgjuMr4YZG1RxRCCGkeLnDA+HYGqP/MP+c2Biob15ScWCur1zGrGirhNa+1WVJbxmBFZHuT9US+z2JWzXqBxGaIR4dHhqXXVFbYU8FMpnMv2MAv+rTKAiwj6TbFrc0l6PYhuAK1cqq8na4tDpvekl7kTGFuSKsSM1sBiDLtMalkxUZkJ2wVUf0H+CdHIdB+rdkDiezJGRXSBlFmIsjXOI4y74OtJqgBQ13lWp8vhrSCV5UYhlLkiB9heFLDYFyBConm7rZoRvlzAH1PXYHbH5gdWdLbfHVqC7DKRjIpFSwMyGqFqUq2NIQBqINzVM7cNU21MlxW6SdlfTZdgGC40vQcIWYgoHlqQ6IAzm9QUANTBtP2pWnTVkU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yi9sL3RPV2VscWZudWN1KzNTYWNoTzdJUUZ5ZXRoRXVFWk9oUW53Mm11b1o2?=
 =?utf-8?B?WXRRSi9KVFpYNUdEckVvME4yQUFCdWNYbjd3akZHd05RN3pTTUw3bkl2UjRS?=
 =?utf-8?B?TlpEVnQ3UUdrNGMwUFU2Y2lLVUpkRlRzWUd5UklmZyt0SGlNSXZqeWhOZno1?=
 =?utf-8?B?cnF2bVFrSjl1THZIUjB1V09vdlVuc2hOM0p0MWlHU3pRZFJzc1h1THFlQnE3?=
 =?utf-8?B?WGZyNkUreTlxblZ2N3VmUjM0TUZ1YzIwRHhxcnhzRWpDcnpaazl3SzNSNUdh?=
 =?utf-8?B?bVdaVlIrdEYrRFZxTGZ4STNVV1JGOEgrOHZjYUhzQjhCblhNdEU1TmQ5d01r?=
 =?utf-8?B?Z2xLWDI2WTZDSkRQYjlqNWJZVExMVXZSSGNkUmdZQTFuMlE0VUVtaS9GdXFx?=
 =?utf-8?B?RDJ6NGRyVW9zdmtKSnFNRk55N0puYTBadzZSZW5MVHJxaDd2Y0UyMElVVXQy?=
 =?utf-8?B?b3hnaTlISEtUdkxYUE14cUEvUnQzYmdZbW40eXp4UjVRbkVjQ0NNSkRkOWpC?=
 =?utf-8?B?Skc1U21SZlFjVHBnR2Z6UldUcElpVU5CUVovdE9pM2JOajdGVStnbytkeFEv?=
 =?utf-8?B?MkkrdE9QTFFybmVhaFpwSnIrWGxVbGVpbTRFQWRyUHYxMHdoVjk0cEVFN1lD?=
 =?utf-8?B?RzI4TUZZNmVIM29oa2JMb3hKeFhYRU84cWZsekFJR3R4am8yWnN0aUVuNlZL?=
 =?utf-8?B?RTNCRUpjRFlqbUE1YkhURUUxSFZON2lNQTliYXFYSFNuL0hSOUVZSXZPU1hC?=
 =?utf-8?B?S1F6ZSt1bGJTU1lLUkZKSEhONm1vOWwxc1EyeVd5dUFUS3YvQTdNRzNuOFZZ?=
 =?utf-8?B?aXFraHNrbU9MRWVvSTI4YVhoMHRYQnJuUHQza2dPSGFkbndxMFhqM2owVTBj?=
 =?utf-8?B?Qzc0bCs1bW82SVpxS3hUd2hkRXZ0b0s3N0dEdlAxdHcydjZZcGlOdTVwS2J2?=
 =?utf-8?B?em00NVE3b1pmbkpDb2N3cXUxQUdPWWtJOUhOS2M5NGQ1blBpNjFwMmpudk5z?=
 =?utf-8?B?S2JRbTdKRzdkcFdsTXZDbTZtaTE5dHBVT1Z6aitzTDJwTWdvV1BMaXNrNTQz?=
 =?utf-8?B?NW04VFEvaEszNHA5Rkt1NlpKVjBna3RsTSs1QUxFaFZ3ZTY5c0MyME9oZ25P?=
 =?utf-8?B?c2FQMWxZNnlvbkpVMHR4L09ZR3VGUGZYN1JXZXZuQURuQ2hrSlpLdWJ2cFVn?=
 =?utf-8?B?L2xtZGU3M3padDFtZ3I4QVhHeHJmQzVLdHNoc1VPZExMQXZFN3JLMk5iK1JJ?=
 =?utf-8?B?OFg4c1dGRE9SWGRQUUQ0TEtLRkYvQysySlRYMmhsbWR4Nk5vbDFyYnUrbnZK?=
 =?utf-8?B?U0I0dVRFNW93Sm9DTElvSlNxelJyYkVwTjllcmJ5TGFzWHJCOFpsQ0ZZSkc3?=
 =?utf-8?B?bEg5N3NBOHNpeEpwRjhlRmlhcmNhODhoSzZqb1crajdwZ2I0WEgvaEtEYnJR?=
 =?utf-8?B?Yk1YaGN1UG9PbVkzeXJxY2wveTh3MG5vbWZhQjUvMWFJK1pZU2VpRlRWUk1X?=
 =?utf-8?B?UDVpNDh4UnNma2h0TjRoT2FzYkdUbFZqdlc2ajhuZmVhSzd3V0VuTUdxRlVD?=
 =?utf-8?B?eHh3R1dJQnd2UHNheGI3ZkxxNEoxNFVMN1BTVjFNNFdlYmxVY2JKWjJ0eDk5?=
 =?utf-8?B?Q0JlQ2ZOM1VybGpyTGhtcXIyeWpmVGZUaFdDaE53b0NRamJrQnQxWWsyRlN6?=
 =?utf-8?B?Yld6T25LV0pTcElxNWhJMlZML2N3MU00dUNqRXpKRFNKVnZwYW9DTjlvb3Jl?=
 =?utf-8?B?KzlVRExFa1hsa3hvUDV4Lzk3dEphTENzd0RPZU5qR00xT1p3WUYxWlNRaXB4?=
 =?utf-8?B?dnRrRVhkKzI3eGVsMDdhTTlaK0VLcngzZUFIeTFQQm1SZ1NaSkhGSFBjVFdo?=
 =?utf-8?B?WndhbitTWWNCbWl0OHQ5V0l4ZVAyQTBNK2JtTUV1OExxUHN4RU5reTJGMjN4?=
 =?utf-8?B?U0IyVWtqRUY5a0Y1WFdRMlR6MnFhQlNvZHBGZFdFandMSGprUE15bkNzejA1?=
 =?utf-8?B?WkJvU2cwYlJhRnhYOWpGdkEya0NSWldsb0pyMUk2WjVYRXZyYm1yR2JRU05W?=
 =?utf-8?B?cFdlL2IzYit4R2xyS2NqNk02RHdNc0NySmhlRDYyU2RWSnZadmlINmVRcFUz?=
 =?utf-8?B?QWY4bzRaSFNpOVZTdkJRaWh4ZDdNUDNTUjRrNDcvOXR6S2ovUHdhNm4yNk1h?=
 =?utf-8?B?MWlSNmdRVmR3cXpEa00zb1BBZnhKY2R5OHlDc0tBVVpjZXNnNUM3d3BMeXlW?=
 =?utf-8?B?S3NFcjBXSlAzL1RsTUg2M2VjRlFjNkZFWGRLUmJhL3ByRWlSQkRRY2g0VkNC?=
 =?utf-8?Q?odGQkJdkLWmfwaWBQM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	O7XpgE/FEkBBz+WBh8wEQbqKue6zRMsylLAhC22bl0ezx1wHQWUyKj7rusMpWWNKRmPXH/Mvn7CYwW3Hywm9dhqk+qTOsTuBjLgsJblMjl9SfehWX7jDfU4+93Evsll6LL/En+nWcIkcx5uz7vkOmbizzFYI8YHvEoCkC1Mq0dplz71MLnmqCv32gSYnj/tLxXiVXIcKwMPiVgU95NW4VH0Tcl7Pha+nZ3OrZ6XWuWl+ozrs6OgQOqC0FRHo0g5YzNVfClm8QzNHYNckZNpvcrizKKTcOrj8lNNBkxLy12HS29BuTOe1ewalFnrh9xKpisIbAZnvM0AbriNHwc3Qpw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6386d987-191a-45d4-e0db-08de8374c83b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 15:57:53.1475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0JgJFOAxB0NvR/En0GnX3jYb5IqE/Vnn+VbnCiIhZlfzmTRbnfgRnWDzTluugN422q2N6PZqv7Oqw2PsxJl7MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6191
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEyMSBTYWx0ZWRfXy7pR9rQhcQsk
 wzJXasdw/uqFV6XZXAev2HUBd1XUwix5qq/N8m975NRXZ95C+TcJlfLGBKbPonc/OU6DOTFVPQZ
 8XVVuNvVo6vzxu7oSJOlLbfr8XJqNc8CwE7Ps43+KF5eLEMdktcHOQ9fMJwYgiNlkWktU4WspzI
 gtnjY6fzdmtFVGqD2hEun9oJR9kHdyeaulVY7Zj4IqKx+Mj6npGxPVpAq+IBdSyDdaOshh23W+X
 WSxQl/So59aqDcm07OcD3WjzUazGyJoqRkxQjEfdHkXvxfidpulNwzIYtdxzeq8z1FB9Jpls8si
 sHqC50EV/TADrMh7VtSiKYPn6q5xM3p26tZ4YWEyTzO+84xoEXBunet5mucDj0xLt9u8aqLAouQ
 PsKS602CqgFQNs4NTrT6/Ed/gprAJd/f4dA4fOO6amBfoL/zC2V2qAcA4xI2rnWdikPy6AXCIi2
 uBPh5kvQ403xOkuUprg==
X-Proofpoint-ORIG-GUID: B1msMlp1xBSXH9OOycd5JPUP4WKudg6M
X-Authority-Analysis: v=2.4 cv=bYZmkePB c=1 sm=1 tr=0 ts=69b82885 cx=c_pps
 a=ouBVT1c3MJkzDXWVqRnxag==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=xLNx2DLV2KPprmsAIcgA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: B1msMlp1xBSXH9OOycd5JPUP4WKudg6M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160121
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8280-lists,linux-pwm=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CAEDC29CDBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDE2LCAyMDI2IDU6
NTEgUE0NCj4gVG86IFNhYmF1LCBSYWR1IGJvZ2RhbiA8UmFkdS5TYWJhdUBhbmFsb2cuY29tPjsg
QW5keSBTaGV2Y2hlbmtvDQo+IDxhbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+DQo+IENjOiBM
YXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IEhlbm5lcmljaCwgTWljaGFlbA0K
PiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IEpvbmF0aGFuIENhbWVyb24gPGppYzIz
QGtlcm5lbC5vcmc+Ow0KPiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPjsgQW5keSBTaGV2
Y2hlbmtvIDxhbmR5QGtlcm5lbC5vcmc+Ow0KPiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
PjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsNCj4gQ29ub3IgRG9v
bGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgVXdlIEtsZWluZS1Lw7ZuaWcNCj4gPHVrbGVpbmVr
QGtlcm5lbC5vcmc+OyBMaWFtIEdpcmR3b29kIDxsZ2lyZHdvb2RAZ21haWwuY29tPjsgTWFyayBC
cm93bg0KPiA8YnJvb25pZUBrZXJuZWwub3JnPjsgTGludXMgV2FsbGVpaiA8bGludXN3QGtlcm5l
bC5vcmc+OyBCYXJ0b3N6DQo+IEdvbGFzemV3c2tpIDxicmdsQGtlcm5lbC5vcmc+OyBQaGlsaXBw
IFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPjsNCj4gbGludXgtaWlvQHZnZXIua2VybmVs
Lm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1wd21Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZ3Bpb0B2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzRdIGlpbzogYWRjOiBhZDQ2
OTE6IGFkZCBpbml0aWFsIGRyaXZlciBmb3IgQUQ0NjkxDQo+IGZhbWlseQ0KPiANCj4gW0V4dGVy
bmFsXQ0KPiANCj4gT24gMy8xNi8yNiAxMDoyOSBBTSwgU2FiYXUsIFJhZHUgYm9nZGFuIHdyb3Rl
Og0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTog
QW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+DQo+ID4+IFNlbnQ6
IEZyaWRheSwgTWFyY2ggMTMsIDIwMjYgMTI6NTggUE0NCj4gPj4gVG86IFNhYmF1LCBSYWR1IGJv
Z2RhbiA8UmFkdS5TYWJhdUBhbmFsb2cuY29tPg0KPiA+Pg0KPiA+Pj4gKwl1MzIgYWNjX21hc2tb
Ml0gPSB7IG1hc2sgJiAweEZGLCBtYXNrID4+IDggfTsNCj4gPj4NCj4gPj4gVGhpcyBsb29rcyBx
dWl0ZSB3cm9uZy4gSXMgaXQgZm9yIHN1cmUgbGlrZSB0d28gMzItYml0IHN0YW5jZXMgcGVyIGVh
Y2ggbWFzaw0KPiA+PiBieXRlPyBJZiBub3QsIHRoaXMgc2hvdWxkIGJlIF9fbGUxNiBhY2NfbWFz
ayA9IGNwdV90b19sZTE2KH5CSVQoLi4uKSk7DQo+ID4+DQo+ID4NCj4gPiBIaSBBbmR5LA0KPiA+
DQo+ID4gRWFjaCBhY2NfbWFzayBoYXMgaXRzIG93biByZWdpc3RlciwgdGhlcmVmb3JlIHRoZSB1
MzIgYWNjX21hc2tbMl0gaXMNCj4gPiBpbnRlbnRpb25hbCAtIHNpbmNlIHRoZSByZWdtYXAgaXMg
Y29uZmlndXJlZCB3aXRoIHZhbF9iaXRzPTMyIC0gdGhlIDQtYnl0ZQ0KPiA+IHN0cmlkZSBtYXRj
aGVzIHdoYXQgcmVnbWFwIHJlYWRzLiBIb3dldmVyLCBJIHVuZGVyc3RhbmQgaG93IHRoaXMNCj4g
PiBjYW4gYmUgY29uZnVzaW5nIGZvciBhbnlvbmUgcmVhZGluZyB0aGUgY29kZSwgdGhlcmVmb3Jl
IEkgcHJvcG9zZQ0KPiA+IHR3byB3YXlzIGZvciB0aGlzIDoNCj4gPg0KPiA+IDEuIEtlZXAgcmVn
bWFwX2J1bGtfd3JpdGUgYW5kIGFkZCBhIGNvbW1lbnQgYWJvdmUgYWNjX21hc2sgZXhwbGFpbmlu
Zw0KPiA+IHdoeSB1MzIgaXMgdXNlZCwgYWx0aG91Z2ggdGhlc2UgcmVnaXN0ZXIgdmFsdWVzIGFy
ZSA4IGJpdHMuDQo+ID4gMi4gU3dpdGNoIHRvIHJlZ21hcF9tdWx0aV9yZWdfd3JpdGUsIHdoaWNo
IHRha2VzIGV4cGxpY2l0IChyZWcsIHZhbHVlKSBwYWlycw0KPiA+IGFuZCBzaWRlc3RlcHMgdGhl
IGFtYmlndWl0eSBlbnRpcmVseS4NCj4gPg0KPiA+IERvIHlvdSBoYXZlIGEgcHJlZmVyZW5jZT8N
Cj4gDQo+IFNpbmNlIHdlIGFscmVhZHkgaGF2ZSBhIGN1c3RvbSByZWFkL3dyaXRlIGZ1bmN0aW9u
cyB0byBoYW5kbGUgZGlmZmVyZW50DQo+IHJlZ2lzdGVyIHNpemVzIGFuZCB0aGUgY2hpcCBjYW4g
cmVhZCBtb3JlIHRoYW4gb25lIGNvbnNlY3V0aXZlIHJlZ2lzdGVyDQo+IGF0IG9uY2UsIGNhbiB3
ZSBqdXN0IGNhbGwgdGhpcyBhIHNpbmdsZSByZWdpc3RlciBhbmQgYWRkIGEgc3BlY2lhbCBjYXNl
DQo+IHRvIGFkNDY5MV9yZWdfcmVhZC93cml0ZSgpIHRvIGhhbmRsZSBpdD8gVGhlbiB3ZSBjYW4g
anVzdCBkbyBhIHJlZ3VsYXINCj4gcmVnbWFwX3JlYWQvd3JpdGUoKSBmdW5jdGlvbnMgdG8gYWNj
ZXNzIGl0IGFzIGEgc2luZ2xlIDE2LWJpdCB2YWx1ZS4NCg0KVGhpcyBzb3VuZHMgZXZlbiBiZXR0
ZXIhIEkgd2lsbCBoYXZlIHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbiENCg0K

