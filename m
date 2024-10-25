Return-Path: <linux-pwm+bounces-3848-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97049AF730
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 04:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B531C212C2
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 02:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6474745979;
	Fri, 25 Oct 2024 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Nrd2PLWB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023097.outbound.protection.outlook.com [40.107.44.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F264B4409;
	Fri, 25 Oct 2024 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729821650; cv=fail; b=LdJtTlneQEa/EPZm3yeFuWAa+sRNy+rUwXIy+5pB/Bd7LH9Kcw9F8lvbuHxg1TdYecrpiRMkgWFcm1XcQQoBOmFCPmm8QyBLdtpLrLomPfJZfFLO3NrxlGY8qPCDETkztpMiCu+pIOHW1NA5CqqmKtjIsexLMLMmfCOfQiVB24k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729821650; c=relaxed/simple;
	bh=T4FjnRE5uxlGs70h1EDpmF8BxZ1uXkPC2Fe9ZHpFTOM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cstYdApcot69d0VspRFaDL/eYhxOD8BpFZCz4OfOWM++gBrBrP9dpHjMrIfleyA6QF8pfSojCt8wZqOzDj3JuKnGuHOgGjKHRFNi3Ho8e+2oimMMdyWieynMbRIevYkCvlTse+XipX6F2t9lro2OEqd9cXo+UqHPdABEQud+qp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Nrd2PLWB; arc=fail smtp.client-ip=40.107.44.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGkHC2cazMAWd4u3K9KnEzbBHBQS7ZI1ruhX108Abu4ifz2dOIn7Un67xW2woKKmrATO6sbzqoG/uUf0tQ2M5GwzNYa4P/5xOqxHLV9qCO2a6Th8SgC6FHNbb9u7e6J0BXI551FMvSAlJ7TnBaXQTYvOSPPG4R5tAlOlz2J+F0V1H6Bo8PfSEho/14TX6jDETQtt1OILXrGhGj/Mf+9MJlERdjOx/5ZQcVnBjz8gkAF9d+GcckZp3Gc5gMEmVGzM1sMj3N/dOSL61X08Cst3jdrwuuFlCd0MOIUsozGq6Xraknf5mOi1DZPvl3NInxoRo+UsjJ/BOJaRpjt2qd/N8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIBItyeLgS4NsJoFHC3Mns5cjUi0/WCdrZeWtr8m5OI=;
 b=gwKrruzB8SosnxgaQDQNereudcENu8+THtEzB0BABpfclokhC/AC2GHGVhFIxUjnwrOMlQ2U1rs4u6JlZw915Qtc0Rvjq4tsFGp7UvcnjqbR4gxttWvvQiL5cSS+nxUJI8me5CX2jQ+Ip339XQvnmUT++L+WU51gDW2Q9EeLuqcN1VbUba09rmmSoa72UB2Lj58/HScM1QqngPCGK9iV52TFEWCok4++EGCPstXMIWT643zntSM14PBPBO1ZmTvwTT9Q/mf6DAWIvIw3Z9WEM0oVsEQfJBy+W2MEcQ+JbeiHv8jT6uHcIO+WV+1vwrsM0ikA4y/hW67kqRvaLeYmog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIBItyeLgS4NsJoFHC3Mns5cjUi0/WCdrZeWtr8m5OI=;
 b=Nrd2PLWBeuQSOm3wGVMl8Hv18l9IOKtxHgAhxXvGG/r3uXQYfeHCi4qNHxU1i8RCpqKTlTOS8yu8y2PO/elo0jPhPwEBLBav5gpsD5LSQD280MgHTskqc9HB+pN7t7JCwuV1f82SojQOAhFnobGuU9sFukj3NNrNxGb30bS0qz2P7N5bsmmk1YW883r9NH3Pp0Hg+t5cfjmytYnVFLsvOqCdOFRWPbsGkT7VYfwQE7R3ubgg+anfBmy5f1CpEeGbXA5piA5DaCjYtaI1lVgJGnIoz5aqdCC+xvIrek9J+oGNIWQjCNGIrL35Ok7S7peIGa/ApxHx7pMr9gzt0U6ulg==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by TY0PR06MB5658.apcprd06.prod.outlook.com (2603:1096:400:276::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Fri, 25 Oct
 2024 02:00:39 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448%7]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 02:00:39 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Guenter Roeck <linux@roeck-us.net>, =?Windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@baylibre.com>
CC: "jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH v1 0/2] Enable WDT reload feature
Thread-Topic: [PATCH v1 0/2] Enable WDT reload feature
Thread-Index: AQHbJeSSyha0WSkjXEyiFAbwEDTDJrKWCnCAgAAHbgCAAKOQ0w==
Date: Fri, 25 Oct 2024 02:00:39 +0000
Message-ID:
 <OSQPR06MB72529E67E67D0D07E59AF1C08B4F2@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
 <nm4ckxv6swajr6hnqlkq5uoo6ncjzlg6yfxroftat6dubiefyi@xbhi4dvqacxm>
 <ea1be8af-0948-46b1-a1f4-fe572861cde4@roeck-us.net>
In-Reply-To: <ea1be8af-0948-46b1-a1f4-fe572861cde4@roeck-us.net>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|TY0PR06MB5658:EE_
x-ms-office365-filtering-correlation-id: c026687c-aae9-47fc-86d1-08dcf498d2fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?rjei5sVMOeLX2o9Mz5wQk8Lh5EbGFVdiQgzSLl3rnY3UA40sVg/qJVh2?=
 =?Windows-1252?Q?6KLLv13lyfk5O+ZepKaoBCssKxB4tyilUvyWxE0LDl7kT9Tm58FtkxFV?=
 =?Windows-1252?Q?KmLV7IrmRrEWiYfYqEH1Bj6V4LvBqgCXAn/UYibvxe55iYt+x5jNfcJP?=
 =?Windows-1252?Q?2FeuP7dEzyEpGY3Bj56QkCAhatqmVlHPoEbo56GXLMHP7SzbSIRIY51a?=
 =?Windows-1252?Q?2txq3amCgeGu+8tAT7Ei4xyfhnIHBC+i66oOKgz3i40MkbDUKQ7ay4cn?=
 =?Windows-1252?Q?zdol9lLS6jMNeaqHKH9sxOuvYeEsEafN5wcNo7m0lrGWERyWQKEY4G5h?=
 =?Windows-1252?Q?pT0D2mTCjAOeOHeEprMofRY57I7zj7tPT7ocgwFMbPl/s7cVQxNRvVWi?=
 =?Windows-1252?Q?ahgVCkEuvAtw1ViUgiez52cZaoJpH7Yv2CuKaYxyRXnMqxh6OsYteP3S?=
 =?Windows-1252?Q?Jte42dOmAgPiQcMZrTF6LYv6dfpVgheROf18wOee6tCuf+n0eUFqDgT+?=
 =?Windows-1252?Q?bl2TX0+dhizxkAcllY8D1+I2IH4GAPXFkBr62NOJ713kbuW4rkrbOnVq?=
 =?Windows-1252?Q?QyMj8pQJsN+tADgjm2UtRe02ZzlpMEnn0ABnYATHB2RKMRkXVdtvYtpW?=
 =?Windows-1252?Q?p2f3+D+0yIEC8Dv5NibdMyqd5a/NDmEA5mneAY0Qckzt5Oh8KjXnpHY1?=
 =?Windows-1252?Q?9jXwa2dvol7eTH++IsnI60O9k0y3b/GUNPXnXXGb1S/G7RcKFuvKm8Z5?=
 =?Windows-1252?Q?xMozSGSO7/JrROlAH/IWNJcb+7qm2L6hUmJ91QfskFamC2RQrob9n5ey?=
 =?Windows-1252?Q?KHPFrAVX34ZLqHK759QwYerae1cGmurRbeneIAT56ZG7ItNl/nDQtuI8?=
 =?Windows-1252?Q?rDW63KxVE1Gg0LKGuAzot7dETyqeEC9y2OAmfjDhwkEeXO3PVlt535Eq?=
 =?Windows-1252?Q?XePnm/ElEqJib8v4ABZhYAuZI5ZisaO9FP979ymVnoAqYQwYX83zJfcY?=
 =?Windows-1252?Q?uxQmbkDof0qPSICG9qMoWYzEVCxGLWlbWmz2IAdXGNjoIYub3sJL9lyV?=
 =?Windows-1252?Q?90Wp6JxSwD3qD+9mHsj2qQzh2fJh3WSnGReruGft+ec0wi8fnCijbClN?=
 =?Windows-1252?Q?Mckf/K8FCdwPMO55KWQMc1YxsGzEzW7+T7Z8nxwIMC1RMXDw4ZRh/IoR?=
 =?Windows-1252?Q?dHBZMgYSwQVAZpYM3wjYhtfY3sqP7ONXPhwLw7qH822ptyMvJg/8k8ZF?=
 =?Windows-1252?Q?cAL3wA4M8q5UL152X2T9rJhNZaQ324ifWWypc4X8KQ0vNLekp31+V4ZS?=
 =?Windows-1252?Q?KRpTgDNYwTFyTyL/yS3XrjfD0SyUGofzn5BwMn6Pao4eAQX6H5iSgTKN?=
 =?Windows-1252?Q?7Lc4sWiVXD7oxTpu5p0/Xn9Y6fzP2pZ0iHkqyySGisdENSqRrrfGhYPl?=
 =?Windows-1252?Q?0819yW1HhYXS7dDJ/2vDSEys17ZClrryUlgmVQNiMco=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?Ul+0Ml2yaGancrIxQ0kkGKIMviwsAVbwJyhBlhuQTTzazjW1DnLIv7mq?=
 =?Windows-1252?Q?p+afNV5EdXe2x1olFZOxe7UFwiWxPQeGyNpYgfkyDQs8C1AUZfgXDr85?=
 =?Windows-1252?Q?3ypxYxRkop/7y9x1qQHQy4XxrDO0Izh9ToJPr/kT+vI3MhOuzr+8eB1C?=
 =?Windows-1252?Q?m4n1QCUKbDkYDvuKotpRse5ITyxihdzfnnm/alOKJQY3PvVxz/ohEVdB?=
 =?Windows-1252?Q?/kv3y5AAYu6wlrJ2mlBa1mRmQEmofq71Htg6VIgQXFkzqdQ3QbFHQ66/?=
 =?Windows-1252?Q?4C7T4ac4sCN+AbRNdagZX9xXhCNdVYrGn05mG71hoSniVovmonxekP1L?=
 =?Windows-1252?Q?0/soch5SsW5WzFuvWrN6EPbsT+OiEnqNjUmM2uM+bCxVXHF52rYAqRl2?=
 =?Windows-1252?Q?unjFCXZG7OUz+huWMoTRFGDavEc+n6mWUcwAJRx08aF7ln/a70pPDJnH?=
 =?Windows-1252?Q?yt2xn2li2bzMZjFbwOqALdQyHjF2+Df3iWE/WkmajsxM8+oGyBlRo04F?=
 =?Windows-1252?Q?3gUD2OVF+/Xus3sthvvFW8Rhm0ymDeche4XVE36c5GLypWmdxBishGmm?=
 =?Windows-1252?Q?vs6K2It0Xxd04F3gTClWOHk6cquZM0esPoUL3EuDTGUwxs+8F+WWcukb?=
 =?Windows-1252?Q?H3kMqogXwyjjZ3rSBHgYSaBn25VG/JhHHT4FtCkkTbLx2Un+N4f4+ZgS?=
 =?Windows-1252?Q?jc5XSWLgqDlYDfyA22Hay+NCvs4XF6oDATgwfsUN29XnBaf2VBkLMzRP?=
 =?Windows-1252?Q?XQAJ8dGygBnSFKm4ha4KmKALP/ngKGvQKZHEYfm2bMlmx8od2TLXxgko?=
 =?Windows-1252?Q?P2u0jeXQhvzAin8jLMiDWYAYkX5stJ9hgfD7NCA9Q9TMkmnPEQ6QbdjP?=
 =?Windows-1252?Q?iEHdKaRa3OABX97983R2KgTGrAM6694L/Db8ZMuqcCB4RR4J2BMK/JUF?=
 =?Windows-1252?Q?Uu/vZtsFKPQcp1JAblqjqg+HqzySrMMPNc8qdCnIRO8/UP1gAIY+x065?=
 =?Windows-1252?Q?NbLmEpNrYjY7od/ak8dQ4kZAlkYstwfXnExBLjhVgKjkbe1NMcI5jazF?=
 =?Windows-1252?Q?/3ugp6ZDY1iGP/5T6UROufI8QHS6GKTLogSjouS8c6OoMGOElMyb+rxe?=
 =?Windows-1252?Q?khZdVx8Ft84aDQyqSuXTgpBC+nbUUXSYnDZW6/t06BnYjYF2o/0OWhV0?=
 =?Windows-1252?Q?kdAZblwDqdFRCFJJ4eg2QfwaagWh61ptK4N9W8L0ydIpUHjUexbK+Z05?=
 =?Windows-1252?Q?EH4xMWcb8YRCnK3Mp5aBbHw0RJ3GqFFG+88SuV3AiB8ulBAo8xj0/rSK?=
 =?Windows-1252?Q?Amj6FsARvBud9pGdro7HxWMB3+GoDS1ZPrGu/A4kXOnkVJehcRwLoisk?=
 =?Windows-1252?Q?N/ULKkTarEaEOGInaI8d1b8AGxdoc+4pI3Q+XgbNFFvhdwGgRisS95mC?=
 =?Windows-1252?Q?pfojbyVv86cPs1uX1nEV8mlyQLokaJ8z3P3rwdz2144ktjvPsHh5SnpD?=
 =?Windows-1252?Q?J6BCvQzmPpZcgJ1y+vGTc8vdTVIvqhyVp1ZYuzAi4984bcBY1Nxdnog6?=
 =?Windows-1252?Q?ipSszhPwzu9OizF6914sAtcw5LUlzASB7yiQl7rvcQvtT53bpMp9GamL?=
 =?Windows-1252?Q?BjAHDBfKsu92gA2kuqHqvukXg4DmdhXak/LnKdd22eBxIv9nXYln+fxv?=
 =?Windows-1252?Q?cx46AWW2cbstaKeE8IdCl2MHEv+dq48e?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c026687c-aae9-47fc-86d1-08dcf498d2fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 02:00:39.1464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AvSnIgNuUaSWsxAmVQxmw1hdrgoQy3yG5f/anKM1dfdBbt4aNXUZIvzoO159/t08YbhqEgugA0puVM9AbQcxkqLDSDUCGrkG74SDnMT3q+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5658

> On 10/24/24 08:40, Uwe Kleine-K=F6nig wrote:=0A=
> > Hello,=0A=
> >=0A=
> > On Thu, Oct 24, 2024 at 03:15:46PM +0800, Billy Tsai wrote:=0A=
> >> Aspeed PWM controller has the WDT reload feature, which changes the du=
ty=0A=
> >> cycle to a preprogrammed value after a WDT/EXTRST#.=0A=
> >>=0A=
> >> Billy Tsai (2):=0A=
> >>    hwmon: (aspeed-g6-pwm-tacho): Extend the #pwm-cells to 4=0A=
> >>    hwmon: (aspeed-g6-pwm-tacho): Support the WDT reload=0A=
> >=0A=
> > Huh, I'm not convinced that extending #pwm-cells for that feature is a=
=0A=
> > good idea. Unless I'm missing something none of the other supported PWM=
=0A=
> > chips can do that, so I hesitate to change a standard for it. I suggest=
=0A=
> > to make this a separate property instead.=0A=
> >=0A=
=0A=
> Agreed.=0A=
> Guenter=0A=
=0A=
Hi Uwe and Guenter,=0A=
=0A=
Using a separate property to enable this feature is a straightforward metho=
d, but I don=92t understand why extending #pwm-cells isn=92t a good idea in=
 my situation. The feature =91WDT reload=92 can be set for individual PWM c=
hannels, and the PWM subsystem has the of_xlate callback hook, which allows=
 each driver to define its arguments for the PWM consumer. I=92m unsure if =
I misunderstood this callback usage, as I couldn=92t find examples. If my u=
nderstanding is correct, this method is better for adding our specific feat=
ure, rather than using child nodes or separate properties to indicate which=
 PWM channel should enable this feature with the corresponding duty cycle v=
alues. I think using separate properties to achieve this feature would be q=
uite cumbersome.=0A=
As I know the arguments for this usage are as follows:=0A=
First: PWM channel index=0A=
Second: PWM period in ns=0A=
Third: PWM polarity=0A=
Therefore, I extended our feature to a fourth argument to avoid any confusi=
on regarding usage and added the description in our yaml file.=0A=
=0A=
If my thinking is incorrect or doesn=92t make sense, please let me know.=0A=
=0A=
Thanks=0A=
=0A=

