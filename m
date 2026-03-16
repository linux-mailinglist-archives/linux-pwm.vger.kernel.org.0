Return-Path: <linux-pwm+bounces-8281-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A3xK1ApuGnhZgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8281-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 17:01:20 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE53629CEB3
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 17:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 978F630148A2
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E0C3CA49C;
	Mon, 16 Mar 2026 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="titAqXc1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B93C8736;
	Mon, 16 Mar 2026 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676855; cv=fail; b=G64bfizzrXCHp1/cKP5SbH5reoyY1pvn6Ji5D7m/PpPqIT2yiE9mcH7ju273pt2HOuqj9wxQ3L0AsS3o6FLvoJmWOyuf9Z3KoYcpvwQM5VUb1ng34oYJU/z+gCQITsvrysJJGvBj7920nbRHMIeNfCKtWf1zefMJ688OT3RE9ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676855; c=relaxed/simple;
	bh=h80mXc+gMvBRarIsy+cdmofSgRAo67KaMFANSgd7fHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KqrPLsOojVJIP8MtRKCYNrIYNMkvkr3RE/1oB5OcbwfQfOuX+5xeTZ2wKHAbBnWfVLKVv7n18Giu8JzOqeK/BFyqK9bsrJwKsx9MZaU0U7B4EYyKNP/S55eBITwHn0XmVqm0xhiShyGGaRzI1DId8mRV0o0v4pMAhOnAWxgS4Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=titAqXc1; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GEMLdv268654;
	Mon, 16 Mar 2026 12:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=h80mX
	c+gMvBRarIsy+cdmofSgRAo67KaMFANSgd7fHg=; b=titAqXc1eLtx45FfWAU4R
	yXsi+Senl+VzDHM32vmaL5Sx0r/j34HTWUaV4WnUsS8Iq+prYPnEdLFr2qJvjWGF
	xP6E3tiXw776eozKGG8eUsB0ghxmC060ER7ydRvuQOfSnpDTVCEf5QySl4xg6VJI
	tjuPvE8Krn1uPYtgoivWsMQ0c+D5/rIze8pSfHPcfPpWzTTwwmRwuEagiGlH+XTx
	sydfzV8Oj+Km5avCM91f0r/6yJqcDvBYsTcJYl9knBFhT03iYkKkV1jT7rDeqeBA
	rSCaN+wQ/K/7ky8DGm5+zdhpDL7vieWzUSeR4Cr2AKpU/1SntfMlsDSfITV0Tl8m
	A==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cw4k0y6j1-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 12:00:33 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhRmt0pPseGDrQuTe+x0Ip9skHZ5YAYbIw9VZpQ33b6Na5YnyiInNAlnSjbuD7pmxqaiAP7nAR4ceEapU9qCmUcJ53x8nXpo8DJxe21Dt1It/Qn91voV8frgi8W67gXwmfcZArqxAnJknjN2REj6PP2h5xyq2BVCQPUvNKe8tNfDkR4Piu8hAqoIX3x4yZh4UhTrjjabpFnSDbrssVtNc0Tt8QOld7vywCGtUXlMn85/zujH9Y+94yYQclQDRgDy9HGBrTcRAiwWYFwuPSbwCpXtcNsPzNhoJ1l9TOAeXJljj8+zCAVtJVRhDKfipe90P0i1dCS5rM8rDubTDTjzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h80mXc+gMvBRarIsy+cdmofSgRAo67KaMFANSgd7fHg=;
 b=s432LV2BpDq3LTEmICJhjMg0Du0Ep397l4KVjpnqFfa5R4D0bX0b8Dpa4CBWSlthWF7+uzURbAycbdWsn7SPeBG1THfvoAwzdKR7R1XTaZ/w9UkC+33SqnGauNuq3W0QM5hG9vlE4YHO+kwjGT35gYadvKfKCYyjhfOklWQpi2v8IEeIbaylD2keunQKJ4xJ/2NhSSnAYx3pUy1PqRNzLcXVHF61cOJyfZj4/Ji60XWVMt/SPVyPTqD2pCF5rqEElI2J27/jXCKzhKTWF1Lb3P+rfK4qfQK+yc6zs8cdEVo6jYPu0JO/Vn/cqSYme9Z4XC8FK6C4InEcRiDDiav7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by DM4PR03MB6191.namprd03.prod.outlook.com (2603:10b6:5:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 16:00:18 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 16:00:28 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<ukleinek@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski
	<brgl@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Topic: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Index: AQHcstE9wdxbJGrMMUOmE/HdBho5IrWt3ymAgANwCEA=
Date: Mon, 16 Mar 2026 16:00:28 +0000
Message-ID:
 <LV9PR03MB8414AD076945687ACB899808F740A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
	 <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
 <ccba355fd43585a9b0a2ae4a54ffa4beaeb3bc71.camel@gmail.com>
In-Reply-To: <ccba355fd43585a9b0a2ae4a54ffa4beaeb3bc71.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|DM4PR03MB6191:EE_
x-ms-office365-filtering-correlation-id: 516b080a-efd9-4999-a0b7-08de837524c6
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 4NTmWMwhDhomcIYrXiFLhWQNQHlaRe/JlTSXJCESsyZh8iHG1R37D17vLM3oSQsLWFCY9ywFMMCl0xvMUjxHEEgm+P07hXrJd47QrHXqEhXLIdYbs/optFSPmH2E1/KSxpKPEChYz6do9MjWvdkZgEDtY/nRdBs+IWokv3s9VY+FrfrJa9kWxByKZLlM2UDmMvHosz3G1qvVPOJH0rs0HAlEatHielvSRicShBcD2Lq92m3ZjdzEztpshAqIqC7yNVB/GkGElwUkxXJTopDlAFf9CWnluRVUBe0WuPDRda6VaS2qGyTcVAmGpxe0z4ttNs3ZxZNIE5R/t1s6mQ0ei6DzFe5wyRjloQ6dllsXHCHAaHFqiiv6W6IinkFoS6u7UY/zl5uO6v2VAliLJOBzKNWi81AkcBbCy0ZCYnfHwlYT14zMXR+IkFvYOo8u/3xC/Z/+7ZHFqqKZ8G0BQvjJ2kfLRlrFdlew5vZ6g1yyTaou0LoQMGTFlep0ZwuNW/GfLinwIber1sQa13Bo6RqYXqyEIZ35pfiy6J/gUrueDrLRbWpgwkilqjD7AD7M84x5ut6ZUoAf0M8AczB2303yIBm64NM86pkzpNHQ63yTgmCDNNbRqcmSn+Q96G0ydENtRI4Qcp26O1Ru0WGQTcRrMe+Uk+VQBhglUzu0z2RkrSpN9ScEGI06pO00/W147LNlHp/NzaP7KDlGUf/vIgE3Bt0BhrjV0U/vMGSX8acppaPefB56MF29LWEFPd90oCFRFx9yjeJONvpmLTiatwS7ntLFr3BLyuuyLuT/VHSoYqk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnlrTUw5bDJRdVZ4RVZNVllPdk1JaEZINDhZRXdSRWVuSjMrL3RVUENzSmds?=
 =?utf-8?B?SnNFcEtXejFuWkRuTjVmVUJqbTR1ZUI5a2hqZ1RtN0c1VEEvVlJrUGRSNmh4?=
 =?utf-8?B?eng3V3NjYVpNN1NQeXhhT0plNkdnQVZWcHd2aHQrZkFneGVQSWRMRjY4TWhh?=
 =?utf-8?B?RjNQT2Y0eUc5M0pUamlXQXRiVUV4WXIvK2RHcWZuYnpZa2h1L0dXWkFVZEdq?=
 =?utf-8?B?bkpJcnFWcXQrSU9Xc3Q0SW9GaVRMd3NiSWhlUWh6bTJmK0dMdGtoZC8rM2pj?=
 =?utf-8?B?RnVkUUh4dnprRXZwaE1xM2JiYjlhMGRIZHR5SDJjMU45aFJvY3lUUmwvaTVF?=
 =?utf-8?B?WjVlV2s4elViLzdLbmhobEpxeEU0dlZlZ0hORlpBU0dVaTBkc0NFcXBnQmc3?=
 =?utf-8?B?THE2ZlVBSVBjT2toeEJ2R0liOXdXMTdCSzdjeTRqRmpxcGdCdXFIZlFvZmJ6?=
 =?utf-8?B?b21GR1d4R3pyY213cEdsZTBRTDRKZWcvUUhPWU9kRFhCL08yczJ6alVJanNW?=
 =?utf-8?B?L0RnQnlPWEFnNytwRWV0TUI2REpXbnBqbktWTDdwQ2paN29IbzFMWHVuRWFX?=
 =?utf-8?B?enh1K2pxTXRRd2ozYVFpd1hZR0dPaDRFVitWaTdjL2VVaTBwTzRWcXFadGpD?=
 =?utf-8?B?MWFVQlhkWCtkUlpFWGVZWk82UlZDOE80dUlOVG1NN3ZIQUZhUzRTdEliZ0JX?=
 =?utf-8?B?REdCMkhMNVROZ0ZLMHprZGhmdVVpLzhTWXl4OVA2R2piaDd6UDgrbVQwZmND?=
 =?utf-8?B?RWFZQ1l3bHlMa2ZGeTF1eXNBeGUxWlZ4cGF5b010RS9KdVdEeDBKeWR1WTIr?=
 =?utf-8?B?YjNMNnQxSjkxRFg0NHlhMzB1N245RzNvRnNDQjlKMURLbDdqQWdIQWtqSUZN?=
 =?utf-8?B?ZXdFRE5MU3FSUXAyVEkzS3JQWVZhb24xZjZLWUZxQkYwRCtaVnNGbGdoMVdR?=
 =?utf-8?B?UStsbERRa3FHenZXSEpWRTEwWGMvc00vTG9xWEhpa0Q4Y0pkNXkwMVFTRkFC?=
 =?utf-8?B?bldmdGlXdVVCRnNvNmlUSHVpcEVxV2FvV1FEeWhQZjEvR1BtQmZuUzJ0VXE0?=
 =?utf-8?B?UGVUU2ZNVEdyTzQrTnp3OXJCQmRETXJNb3N5VG9WWW1QbjdNSVZDZXd0MmJw?=
 =?utf-8?B?QkxJMDFHSjRxeE1jYS9BZFc4ZEtvRmdVSjlMMi9WTkJaM1lVZk5TamRFRzF2?=
 =?utf-8?B?YWpvaVYyWmtVZWdaZURneW1ScmhuME1uWk80VDdnMjUxUUQvOW5QZ2tXVUhC?=
 =?utf-8?B?d05yaWhmYkp2cncraXVVdml3eG5IS1JEV09mRUsxQ3F1L1BtT0pZUmdDYjNY?=
 =?utf-8?B?N1NueXdJdnI3MDRaTjdNOG51S3pOTTU5eFlHUXhiMmNJQ25hSml4akJQc3dt?=
 =?utf-8?B?eFpXVmxBcEprejlxK0lXK2NSOGZtQ0g3ak45TFcvUmU0SjhZc0dJeFoxamJY?=
 =?utf-8?B?WWU4b3lyT1dlZ2tEc1FTYm44YWtKYkhMMFZGMGFQYmtzd2VsbXhYeXFOY3lt?=
 =?utf-8?B?UVNkM3BmUGN5Q0FTZ2NFVUZ2WDB3SWV1TnN2d0RicitpbzA4NjVRMHlvSVRU?=
 =?utf-8?B?UGY0TnhxcHNneDB0enZFUDFlVlZ1ekJERDhmUU9WbEl1clJYZU9GdFh6UDVL?=
 =?utf-8?B?Y0QxVDdnTjVuMnJNWWpHZHhicjgyelQzV2szZStyczFlU2hFNEppTkpMR1Jy?=
 =?utf-8?B?L2N1VUxCRDY3cjRkRml1RXYxZnNrUTNYMk9WVUczbkRLOFZJRVE2UE1wRWpi?=
 =?utf-8?B?ejd2RXJZWVlVZ2hRU0YwbnBrZmcvbFdLTEpWMlBRWjdyMzM5dWsrQVU2dmpN?=
 =?utf-8?B?YTFLK0MwWU8rM0EzOHlVRFRyeHJCeGlXYW9QVkZCKzVaK2N2VVEyUWllYzRF?=
 =?utf-8?B?c1ZZQzFUV3hUWlU2a1lxZktuUVlrSjlST05jZy94WFd5d3NGRm4yYkV0WEY2?=
 =?utf-8?B?SUVVYUNqSDdaTmxGMGU2dGJyeXdDVnlZVjNXQURBRnIrZVMxUjhrWXN2NkZz?=
 =?utf-8?B?cHJYOURLQWY4dmRXTTVrSmIxTVYwa2VtUEVneHpJelY1Ukl1SFNsN2wweGZL?=
 =?utf-8?B?azBuYTc1ZjA2cFlTaC90K0lkWHhYcXo3VEFSQUNrcFFJcFE4Z1JpdE92RTBq?=
 =?utf-8?B?Ynp3eXZSdExJN3VDYXliS2VtZkZZVWM1ZVlxQ2J0bmphaHo2L2o1VUl3YmZL?=
 =?utf-8?B?MUdYbWVvUXgwclFkaDJQTWI0Z3R2QnhidDVEMytVWXd5M1V2RTlaaFM2MTR2?=
 =?utf-8?B?a3FjdlZHdmtmbnh1M3g0ck9yVEgrbG1QaExZbWlka3FFUmVVWWVXczhkK21K?=
 =?utf-8?Q?F4CHibqX1v4jLCgApU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	btBR7WdcQPiuEcxJByIs7XKSbNPFpoleEUh4FjokMEZpSsJH0W8Hl5G9JCj7fY85Hxot8mY8Cn6GxgPlbKtfZoedH31U9iqFtkrS5NP6+FcCRZq2aKtgy0wKz47Msp2jLjRmHMNAxLEgjDBRDkZ00YMaP3kjjdyXZew7Z5VIm2yRX+ITKeJd/g40uH2vNZ6ZZP668nO8jT28IZ888h6weZOEK0hL9gAsPLltqK6i2xv7H05DFt6lKzAVXRePMY1HSwstSkb2xIVrr7fVYnBFEKCVcutYYCG8PE0XnHsK7w2EtIIr3riwtiU69gbXY3MkpWtkdtG3TsNLsLeZQUS49g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516b080a-efd9-4999-a0b7-08de837524c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 16:00:28.4580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QmMHo0oB9ypCulsN8qVfzY2LDeI1acpnMHwrTg3JrAQALat3VcKGber8UH9E1mRDyDrC2KwyqvIa2fxxk+E6ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6191
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEyMSBTYWx0ZWRfX4dKKUVOfqcNW
 jpJ9OvSt4v4AWSbARD7Gomsj9Ajz8NHqdz68rJUft5xZlo2vddwS3ITv2s1Tt3RnuarOuOhZTnD
 DPobkXZJQCKi6ACbuz2Wse/6mbJT8Zg0sm33CKzxa6uh/mgVwm+HuLpWC1D4kEYv5vGQLTcb6Xm
 VxduWKTGyz7RuJf4ldKkbvyOFJ+ZO6GPWRdLKUgQUGCZjNdQez1iGBJOit8UDXOD5NCTJ+lnmNK
 pHxJvD2Gca2TPKjL7TvNQDpZDMdPiWhAZKP3BS33jI2z8/965F79BgQrrL32tKECcZVwtxW33yu
 /O7wh8g44Keiy+mRPHwc9Bl9wv/xdRxLXGT3A5SUMZ6k3sFjc+ZFYQyeh0kBIdlX3iGQyZ7vjOE
 2yRTVqT/qYc17bC9ZmIEJwWBhjBZpsdEn4I0ezYS7yf/2XHcIBVfzZMsvMjGt6pJjaZO28IrVHX
 S1n7OlKTG5S2+xOOdmQ==
X-Proofpoint-ORIG-GUID: 1BR3VqDzYDxB4sdjiizmEl-BDV-zEjo7
X-Authority-Analysis: v=2.4 cv=bYZmkePB c=1 sm=1 tr=0 ts=69b82921 cx=c_pps
 a=Y/Y9x3HtMOqQL+YbCjVQEg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=pGLkceISAAAA:8 a=1ylxxyUdB3avPi6fatUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1BR3VqDzYDxB4sdjiizmEl-BDV-zEjo7
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
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-8281-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,metafoo.de,analog.com,kernel.org,baylibre.com,pengutronix.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,LV9PR03MB8414.namprd03.prod.outlook.com:mid,analog.com:dkim];
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
X-Rspamd-Queue-Id: BE53629CEB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTnVubyBTw6EgPG5vbmFt
ZS5udW5vQGdtYWlsLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIE1hcmNoIDE0LCAyMDI2IDE6MDUg
UE0NCg0KLi4uDQoNCj4gPiArDQo+ID4gKwlyZXNldF9jb250cm9sX2Fzc2VydChyc3QpOw0KPiAN
Cj4gWW91IGNhbiBnZXQgdGhlIHJlc2V0IGluIHRoZSBhc3NlcnRlZCBzdGF0ZSBhbHJlYWR5Lg0K
PiANCg0KSSdtIG5vdCBzdXJlIEkgZnVsbHkgZm9sbG93IHlvdXIgY29tbWVudC4gQ291bGQgeW91
IGNsYXJpZnkgd2hhdA0KeW91IGhhZCBpbiBtaW5kPw0KDQpBcyBmYXIgYXMgSSBjYW4gdGVsbCwg
ZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9leGNsdXNpdmUoKQ0KZG9lc24ndCBndWFy
YW50ZWUgdGhlIHJlc2V0IGxpbmUgaXMgaW4gYW55IHBhcnRpY3VsYXIgc3RhdGUgdXBvbg0KcmV0
dXJuIC0gaXQgZGVwZW5kcyBvbiB0aGUgc3lzdGVtL2Jvb3Rsb2FkZXIuIEtlZXBpbmcgdGhlDQpl
eHBsaWNpdCByZXNldF9jb250cm9sX2Fzc2VydCgpIGJlZm9yZSB0aGUgZGVsYXkgbWFrZXMgdGhl
DQpzZXF1ZW5jZSBjb3JyZWN0IHJlZ2FyZGxlc3Mgb2YgdGhlIGluaXRpYWwgaGFyZHdhcmUgc3Rh
dGUsDQphbmQgaXQncyBhIG5vLW9wIGlmIHRoZSByZXNldCBpcyBhbHJlYWR5IGFzc2VydGVkLg0K
DQpJZiB5b3UgYXJlIHRoaW5raW5nIG9mIGEgc3BlY2lmaWMgQVBJIG9yIHBhdHRlcm4gdGhhdCBn
ZXRzIHRoZSByZXNldA0KaGFuZGxlIGluIGFuIGFzc2VydGVkIHN0YXRlLCBJIGFtIG5vdCByZWFs
bHkgYXdhcmUgb2YgaXQgLSBidXQgaGFwcHkNCnRvIGJlIGNvcnJlY3RlZC4NCg0KVGhhbmtzLA0K
UmFkdQ0KDQo=

