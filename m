Return-Path: <linux-pwm+bounces-8770-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P2eFNmL+Gn1wQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8770-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 14:06:49 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F09A44BCBE6
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 14:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58F54302AE05
	for <lists+linux-pwm@lfdr.de>; Mon,  4 May 2026 12:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D203CEB8C;
	Mon,  4 May 2026 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JzQMaXtg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC483CEBB1;
	Mon,  4 May 2026 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896382; cv=fail; b=q2SuEiC04LltDeHkXBtA1rP87c9MJs7J4kO6+hjrGznnS9whfP6nezYg5q06YEfeDt2sck9Umnthp+s8y/XrqbQVlzmEexwdnhC8pk5NR92GnfayUgbfF/QMCEGrg5foDQrCW6nG6VJF7QurYNGJcgVk1PaIAV14hl4YqjEC5nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896382; c=relaxed/simple;
	bh=jRwVDRIcFuN78q1994zuAxKWL3cIEhDeqDOniyuo15o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GXAilg6S0lNAn8lkZ3UwUvhlDt3ObhbVD05BmMKP1AQ/4FSGL8WL4lHf7nS01+rHdqNYN43JgE/2CKUBe3t/tMeeEw7M/96vyM8CQX9KBrCqWdp9pY97YewGXNEC1DtdAo2bRadB5arzXahNIM3iM0bhBxbf158aOkmP7dIN+wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JzQMaXtg; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64496nHh2211938;
	Mon, 4 May 2026 08:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jRwVD
	RIcFuN78q1994zuAxKWL3cIEhDeqDOniyuo15o=; b=JzQMaXtghJBMjCp8MYgI+
	l9/YKCYSIx8YtUmWZrAKXDinRilqItZ9WjQ1Lj55QQ1NeEU2GC58h8VnIKDbMVVf
	SaOt82/BBEuVjNLicbQUVa5wSJlQYapIRNyyBBcSB4F08GwQ+vpp2XBfJb8WLG/t
	DrLN+FU/epg3MRyOT4eoJzymxAkhUeMzObm43TRuRoOImxYkNRF9NAzhtP27Nz2f
	TZXg5ltv5yglEbO8/MpfBGUy4k8HEUrbHvJRsBdm5t9xeZQpVa7+LFWO6T7G63m1
	G2sRHOpQkiVNyDlkAsqwU+NS5U4AcuvZgE2KfQvkKI+4IWEpJbxfRJeVMqEmumVT
	Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dwb4374tq-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 08:05:58 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaV6e0ZNDRzU4tOjvwNS/TMpW/QayBpMuRLiWM0qbj0tYSc+IEcX45Gsi8d0V0IzzlxbJDBaNa384sTiekldznrJ1c2jEDRthhiE+1mUHOuTFMR2+7ICPfhInnXTH2VQsKJh8Gkgj0E2JXK8crxSNDWHO7MdUSPhCcLW3KJD/9e7uaXaYm5Ifh5AwXKk/0oe3jx0f4sNDQRpS+lqRm8Y1/Fvaqvydd2rca62sDsRj0WFmKTmxfgxxySHL9DiSQJYBc5Q0CCy6NcvlnMdsd1fG77FXFW8obanG1JYVyet/9BqeVMgIFfFC86oYQKagRAkzQYc0j2128BEuQub9SVOnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRwVDRIcFuN78q1994zuAxKWL3cIEhDeqDOniyuo15o=;
 b=WS3wehMZ9lIknU/LhYgpbpkC+/Zmzk/wKyzKVnc5QdUqTNabyCwOBI97I6cU3aXf0+RNrsajYfSnMxplmNTWZQT2FmC3eICXFa03wQvkCjJg2M1YxTpPNhhwNmwJYrmciqCDx5YwfgWeI8tpj4kLJ6f3PN1EmyAWTcwE/Cyqx6YNbHF4pgz1AKxP6mWyC/FGf6pKXrkMz1OT4JxRDulE2H97GAq1JAmmTl8ecm68dWCWaPV2kVm0BXoUJSDt+KJDIiUXrVv6lpUk8woLGN20dOOxt8Q/A6zE7etHlKMC3x3IqfrAEyhmWxFUYJ63swLLyaABpTcK4IpZlhre/xVJVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by MN2PR03MB5359.namprd03.prod.outlook.com (2603:10b6:208:19f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 12:05:55 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 12:05:55 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
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
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Linus Walleij
	<linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan
	<skhan@linuxfoundation.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
Subject: RE: [PATCH v9 3/6] iio: adc: ad4691: add triggered buffer support
Thread-Topic: [PATCH v9 3/6] iio: adc: ad4691: add triggered buffer support
Thread-Index: AQHc2Ip5b9xysBU1HEufEOvMimkIw7X9hksAgABEDkA=
Date: Mon, 4 May 2026 12:05:54 +0000
Message-ID:
 <LV9PR03MB841441B282275F8F36FD12C1F7312@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
 <20260430-ad4692-multichannel-sar-adc-driver-v9-3-33e439e4fb87@analog.com>
 <afhReLCsEdaEOT_H@ashevche-desk.local>
In-Reply-To: <afhReLCsEdaEOT_H@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|MN2PR03MB5359:EE_
x-ms-office365-filtering-correlation-id: 70db8efa-a539-44cb-1711-08dea9d57ea3
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 riuVRkccy+A91AKK0HnMY8gx/uR6KbeFDckFb+cagi1A87/B5dhZEH6oseKY5b1Yi1IFlCoFETOPoRA4CtGrYpkaRHTwn9k5ZgQNGiPrvQ4urmzYWp9T+IFd4MP8GWI5BP/dGSKb2Q0/DZkxpttBfGT9vWAkl+klQSD6b9oXalJW5LXNt1rirLvjhO920DkgRBKC8p7iOhqTmclHyNlnRJQjf0Av6/vdn7XrvmZU6HfmdGgC8jvulQyB8uRm097QxJXStp2xgEYj+qrcpEkfLXxHcP41OS+al6zeUifZZ9iH+IhD93zTnBFgy3cHflSryt0BJra/X5UWQKHQ3FY5VOqLl5tGxtf1JCUStLDLTpqHcb45fkbHmfvg9sBFpkV+4IbZen9KtJwJGiJUm4PYQULlk6tg6K9ATGW5phXhOPT11CQlg6jxjtLaS0r32b/tqPf7hP2kFTBLpoa6oFjD8tszW/JFjUlhnWrL+B5JHJyWa0QdakxbncUp1qvX9s1Shd1zXR4IQqkm5/UP0RTQfHOszPd9AtieIrn9oSR6fU3RUQsCd5vlhrs2NuxL+eJFSPJPNbgIr0qBemNUaYPobcNrzgRPPcLkWFOAEbgXkxRpT6sGJBG75FO6vapyZ/SQEj0O2XpatBusTpiks8Hc/opEdTZBsTsM7w3w0VO3MCYmcu+MV55EFvSdpBQ9UCiXPzzy51W6fnq5HBQms6ZOzRANSPuMGN3LAFEo0Gc696hL65Oi54tY90hAspgnUb5U
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2I1akJvanFjdnp1Z2lxdUVlMEo3cnBYMGZnMlFxVmhHU2JsRXN0bjl2ODFU?=
 =?utf-8?B?dHo0bVN6ckJHa3BsT3JhZkxPWmlqRWo5eFhiTnNaKytmNnBMN3JPbVZGQ2xH?=
 =?utf-8?B?OFBNVzQyNDM4bzRJT1FObE1PUTZDR1NJZXNoNmdmZDVHQUkwWnIvNUFGNDB3?=
 =?utf-8?B?Mk1SWmlnR3I2Vm5waW9GbDV4ZE5uWkU5MVRxT1NITVFCc3VIdXpXcDFkbWov?=
 =?utf-8?B?UlR0Z2YxSzhJYTVGY1c0dTBJYjExN0cvWG5XN0FuZTB6WW9zY2pjWkJZZXJa?=
 =?utf-8?B?Q2pzTkZFYnU0VUdDYVFhTlNVMUIzTmZ6SHRaMytSQU1Xd0xKSXlESlp2TnA0?=
 =?utf-8?B?U0FMU29YSGw0RkFJaDZFWW9ZVjVBbTJhakU0VDBrQS9wMDdRMGZVa3dNa2lu?=
 =?utf-8?B?RFhkbHh4d1BWU1k5Y0NPQ3JUQzZrSkhKZmh0V0VwMHU4NWxSVW9FM2xHNitZ?=
 =?utf-8?B?S09KU2RDc0FJbm5sRUdlc0E1SlJpWjdLQXNURWVJVkdrSWF6RGhTcSs5Mkhs?=
 =?utf-8?B?MnRpZTRpcUM5Wml6N2tyWDJSNWl0QTQ2bjhLSlNTV1ZTemNaQ0N1WHFiSG5p?=
 =?utf-8?B?QWpIaVZTdCtYdmM1ZzJYWWdMeVVVRHBOWStDRXFQUlk1T0gvV0JRQlJpMFRx?=
 =?utf-8?B?RDErenlEbUMzQzVjUjNrQmo2YWFhZWZMNDJDUEQ2YXQvNDNBMWpUdnpPYmVO?=
 =?utf-8?B?Z1ppbnF1eU5udXpvRktTQ2dkdFNGR0Y5UW5PTW1JRXBDY0dJakN1N3VXMjNU?=
 =?utf-8?B?Ly9KRW42UDI1NFJZOFp1Q0xPZ2VPcEFSMXd6cVQ0OEh1UG1xV2xSbHVKUHVO?=
 =?utf-8?B?M2lsVXpiTHZmY0VSOFdMZE1GK2hJVUdNMlBhc0pUczhYWk9qcFNxMkpyWG9E?=
 =?utf-8?B?aXVLRWRUcVZJN21IV0VPMEpSY1hHOUIrVG9ZbWdUaDNjemhncis1TVZSRTJP?=
 =?utf-8?B?aDJJNU8rNzMzZkw1YnFaRXhCK0VFVnlYdXppeHdZNFJCNVlyc0dvQ21iV3dk?=
 =?utf-8?B?aU11MzhmRGVYak0xOE9MRUlZVFJvL3h3TjVobTNKdk5tRjh6ZlRXbnZITUln?=
 =?utf-8?B?Y2prU2lveFMwOEVFRzIvV3lHNWZXQ292Q1NuWDZuc1pvNnhBOTYvWkVpM1g5?=
 =?utf-8?B?amFBSHlNQ041SXFCOXZjU3ZZa0VGeWFuRi9aNkxmK09OWURQRTJLRG4waVNW?=
 =?utf-8?B?NmZYNmZkb3piVVZWUEtRU0oxSHFzWUNrOGpKWWRPdE9JckxHdStLQTJzSHVW?=
 =?utf-8?B?ZExmSFB2RmRoc3NHaEtnTlBxa2ZrSllnWlVHbVY1SU83aWV0QnlIb2FXcm5y?=
 =?utf-8?B?ZUptS2htTVZPMmZQYVVnV0FCTW1wQXE0TzJPNUtRSUp3RTd5dFBrYVIwc1Fk?=
 =?utf-8?B?dzZFcjJIdThxcXJNL0NVZDY1SkVIaHJlWGhNbUc4eTQySytHOHNVMFRmOGdB?=
 =?utf-8?B?KzJLTTcya3BDWjBVSVhQeDBsWUNEUS9XZW1UQWMraVNwanM0VkJ0V3BqdE1J?=
 =?utf-8?B?cGdVSFBucnFIY09KU2JDZXFQOEpPU1ptR1lCSTJxSG8rZUMybHRiVy9lVHVp?=
 =?utf-8?B?bmN3Y0dGSGttMDQ2UkZ6bzlaTG9hSE56U1Zqalk0TnA1Ty83UUdSQk1qNmNq?=
 =?utf-8?B?blhsOEExNGtJbno4blVpZXVEeWJlYnBkZTI2RHMzMjZHQnF0YzVHcHpEQ2wv?=
 =?utf-8?B?blJ4LzdkRW1VeWg0N0x6RE1ITDZwWnkwaDlHejFpcUd6QkV4SHB5Rm1Pa0Q0?=
 =?utf-8?B?NjNzM3hLMTJGOFdqSndFNDI0ZDIxekF2UzZ0MTZtRllucGh0M1pveUV3aEow?=
 =?utf-8?B?bVJvblArUUpGZlVsck9sTEFkUU50MVdjUkpnZzg3WTFaWjAwN08xQS9JQVZB?=
 =?utf-8?B?N241VStKV0NQeUNXY0VBMG1KWWVuMkg2dTU2Z0pHbzFRZWJDV3VlSVhYQVpa?=
 =?utf-8?B?VFNZNFVKREhxMnpzNXpoYkZicHVTSTZKNXFZelFUYm53WEFVMVhVNHE4MU5X?=
 =?utf-8?B?MnA5L2YrOW80MGJLZmV6WmIvWUFJOUdvL2tGM2VpSWI3ZVZEcjVwK0ExTm1Q?=
 =?utf-8?B?UGRBTENoKzRwQUxGL2xGTFkzRTcyOUFuUXZSU0NVY0h5RXM3ZW1oSFR4YWI2?=
 =?utf-8?B?RCtsbllKZUNTLzd0NFRxbXBybHJLSXhNTXJLeXBJNjFNMnJVTUxoSmg0K1VG?=
 =?utf-8?B?OG40MUVwcVJoVk1VTnBobUNTNUpXZzgzMjA5UGwxQTdUT3lVVlM0S3lYdXZT?=
 =?utf-8?B?ZERGTXhlbDd5WklTMVVhRlpBM2hLNlFQdVNYS1FqQU5rU2wrNmkyZjF6b0Vm?=
 =?utf-8?B?M3ZjekFGZ21OZlFENFNpMzRNQnFLTkVmbHF6TzFjSTk5dldYTWZVQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Zmypn08qqxDMc8/ADd4qUU038aYVFNMN1DlwGxYPoedLLLupVSO5un3b7VzYsvgR6nxSrBh/F4fFrRYib+knGxDPcbbwcl7lty7xi512r3Gq9/CmjgGWmWin6CV6OJJ5jFRBEng5fgVZm/NBe1iLI4dhAcB+HrmpYwo0oB5g2Ez7jy1JLLDZyxgofqdqeQqbqjibI3abrdD8gNy2IUqn+hqN0vvWDoIeAhFCkfWatsZ8QFmTtwfboD30GwphdxrExguRbfexRra7JcjGR6xcDBuWtdrhnBPTwGkaHnHfzokoNpxoAAgFevJkBnQFxiFBooLiMQimbxPU7otC9tP7mQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70db8efa-a539-44cb-1711-08dea9d57ea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 12:05:55.0391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5PeqrvzjbkbKZYYVIz2ktxWHExgRRr0kRo+r6/0kg7XMtOhy+mUeu4ZAi2X8fFHEExCxasqtSZ5MLjmMkCqmtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5359
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEyNyBTYWx0ZWRfX2P3VdhE0fX/2
 1POLQ4Lz1/Bp90b2GQWdzUHmScGInR09jDIP0g6Atjbj8UZCc41tvSGWvDX3eZ0lyvSP3kmhARx
 KfZfLjbGIVllGu3jPrCnESufT2qKR/yX49WqTZYJLUMV2pGxbyQel9aqPGqF/+23gOhmLhsTfkm
 YseW/j28+vqG6V/An1EwWf2ts99dARJs6kqsSbNVrUPitj7vOudcb5uakkQIOY35FGSJ7EzFp9p
 dNwydyddPK87YgpDqSYdXcgIFgh85EOLsDbnyMhXlWxJwj8XIVfi4MwZAGpNspXNE4GOnbNyX7G
 B0fENPWrfGV5srXJhL2bu8XACj7pg0d21DvnttP0y08dCIMHw57DJdrha/A/zlK6Y+Fc01bLlUp
 drMLFtTGRE9Sf8poA5CUS4VZ/kZrF3wdR3t7JqyXTDg7N+nTnlB3ZZHWQ9soJOKILdSbT7HeKfr
 rqUKCtrDF8L9doYFMNQ==
X-Proofpoint-ORIG-GUID: yIiLzJVmicTHw1oS2S9iax3V3iNBZ1fM
X-Authority-Analysis: v=2.4 cv=AeeB2XXG c=1 sm=1 tr=0 ts=69f88ba6 cx=c_pps
 a=wqOHD3zG9oVgxNNyXktjPA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=NAAT6DcigphVuC-4cG0A:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: yIiLzJVmicTHw1oS2S9iax3V3iNBZ1fM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040127
X-Rspamd-Queue-Id: F09A44BCBE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8770-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,LV9PR03MB8414.namprd03.prod.outlook.com:mid,intel.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-0.994];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

SGkgQW5keSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNo
ZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBN
YXkgNCwgMjAyNiAxMDo1OCBBTQ0KPiBUbzogU2FiYXUsIFJhZHUgYm9nZGFuIDxSYWR1LlNhYmF1
QGFuYWxvZy5jb20+DQo+IENjOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47
IEhlbm5lcmljaCwgTWljaGFlbA0KPiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IEpv
bmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+Ow0KPiBEYXZpZCBMZWNobmVyIDxkbGVj
aG5lckBiYXlsaWJyZS5jb20+OyBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPjsNCj4gQW5k
eSBTaGV2Y2hlbmtvIDxhbmR5QGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwu
b3JnPjsNCg0KLi4uDQoNCj4gPiArCS8qDQo+ID4gKwkgKiBDTlYgYnVyc3Q6IDE2IEFWR19JTiBh
ZGRyZXNzZXMgKyBzdGF0ZS1yZXNldCBhZGRyZXNzICsgc3RhdGUtcmVzZXQNCj4gPiArCSAqIHZh
bHVlID0gMTguICBNYW51YWw6IDE2IGNoYW5uZWwgY21kcyArIDEgTk9PUCA9IDE3Lg0KPiA+ICsJ
ICovDQo+ID4gKwlfX2JlMTYgc2Nhbl90eFsxOF0gX19hbGlnbmVkKElJT19ETUFfTUlOQUxJR04p
Ow0KPiA+ICsJLyoNCj4gPiArCSAqIFNjYW4gYnVmZmVyOiBvbmUgQkUxNiBzbG90IHBlciBhY3Rp
dmUgY2hhbm5lbCwgcGx1cyB0aW1lc3RhbXAuDQo+ID4gKwkgKiBETUEtYWxpZ25lZCBiZWNhdXNl
IHNjYW5feGZlcnMgcG9pbnQgcnhfYnVmIGRpcmVjdGx5IGludG8gdmFsc1tdLg0KPiA+ICsJICov
DQo+ID4gKwlJSU9fREVDTEFSRV9ETUFfQlVGRkVSX1dJVEhfVFMoX19iZTE2LCB2YWxzLCAxNik7
DQo+IA0KPiBIYXZlIHlvdSBydW4gYHBhaG9sZWA/IEknbSB3b25kZXJpbmcgaWYgdGhpcyBhbGln
bmVkIG1lbWJlciBjYW4gYmUgY291cGxlZA0KPiB3aXRoDQo+IHNvbWV0aGluZyB0aGF0IGdpdmVz
IGxlc3NlciBnYXAuDQo+IA0KDQpZZXAsIEkgcmFuIHBhaG9sZSwgYW5kIHRoaXMgd2FzIG15IGNv
bmNlcm4gYXMgd2VsbCBhdCBmaXJzdC4gVGhlIGhvbGVzIGFyZSBmb3JjZWQgYmVjYXVzZQ0Kb2Yg
RE1BIGFsaWdubWVudCB1c2VkIGJ5IHRoaXMgTUFDUk8gc28gYWx0aG91Z2ggSSB0cmllZCByZW9y
ZGVyaW5nIG9yIGNvdXBsaW5nIGl0IHdpdGgNCnNvbWV0aGluZyBlbHNlLCBpdCBkb2Vzbid0IHNl
ZW0gdG8gZWxpbWluYXRlIHRoZSBob2xlcy4NCg0KPiANCj4gPiArc3RhdGljIHNzaXplX3Qgc2Ft
cGxpbmdfZnJlcXVlbmN5X3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiArCQkJCQlzdHJ1
Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwNCj4gPiArCQkJCQljb25zdCBjaGFyICpidWYsIHNp
emVfdCBsZW4pDQoNCi4uLg0KDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShhZDQ2
OTFfZ3BfbmFtZXMpOyBpKyspIHsNCj4gPiArCQlpcnEgPSBmd25vZGVfaXJxX2dldF9ieW5hbWUo
ZGV2X2Z3bm9kZShkZXYpLA0KPiA+ICsJCQkJCSAgICBhZDQ2OTFfZ3BfbmFtZXNbaV0pOw0KPiA+
ICsJCWlmIChpcnEgPiAwKQ0KPiA+ICsJCQlicmVhazsNCj4gDQo+IFRoaXMgaXMgcHJvYmxlbWF0
aWMgaW4gY2FzZSB0aGUgYWJvdmUgcmV0dXJucyBFUFJPQkVfREVGRVIuIENhbiB5b3UgY29uZmly
bQ0KPiBpdA0KPiBtYXkgbm90IGV2ZXIgaGFwcGVuPyAoTm90ZSwgSSBkb24ndCBrbm93IHRoZSBh
bnN3ZXIuKQ0KPiANCg0KWW91IGFyZSByaWdodCwgdGhhbmtzIGZvciB0aGlzIQ0KDQo=

