Return-Path: <linux-pwm+bounces-3873-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E89C9AFED7
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 11:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E508FB213BF
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA14D1D3633;
	Fri, 25 Oct 2024 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Hmodkkn8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021118.outbound.protection.outlook.com [52.101.129.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D712FB1B;
	Fri, 25 Oct 2024 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849780; cv=fail; b=czN13Ra+jidAf3R/VwEyuOC18L4IqPN+p+0/hWqP+rY3E0yvdCvprODYUloL0n3hY7yzTXHMMn7aE7qlFIZPw2/JGN6EfQfDV1JbM190INxhDB4/2QrYQKpL2ULz5Adv+30mVlqyCyDUM+rY+ggybbu4C8wEklU4vOa2gMuZJSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849780; c=relaxed/simple;
	bh=EfvoSHwpv1nhS2+pmDIFZwjYw3GLBLSXKF7sXFG8ah8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n8e8d7Wt5Frq40k6SVsIRBQux8/LkxZDlQjk1tr2jzTo5KK8MbE7RnpIK9I/uCuQVPPh9K4vSSFR93mJhTPobglZGxwzY4UGvfGCS5hgz5N2L1YZ1o8k4+ZOhgdhzHOMBk4LQhDLYa2cFPXQ5mR7r0ImIxaoM7ox0o8+xYyVpQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Hmodkkn8; arc=fail smtp.client-ip=52.101.129.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPkvpYDUff/feflJIW9udAf7+p85+xY3rkexvlU2EEYBEQ/RjbRiN++zn1xxHZA9gU0G9aKPWPZkV2zqSSWLk350tzudQsSubznLmCy4KPNqc44d++UeTNxRdZiw2i7LT0LJpaOLA5+pzjgHyp1zJV9pz0q3KFgmcSNAjwngvKZ6LzfmuGtO0M5czt15JLlvt37LlKuzz1MDy8rdsOQcC8au0P5LBC60qQOVKWnuKz6F0Rvc7pftQx34Xg5FsTnVyI/krp6VFpPiOgTHJNJfsumYSt+bwVRtLBB+Gqf/O5HeZfXc1nvZi/eu97H8jcv083XWCUSIgPTl5AvoInu/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsJtPk5K6i29LFEHwAYXIRGKFJExCidg5Vp9TlZqPl4=;
 b=CZOA1Kycx4eTW6NWmrsU2aOpnCCFDO8APgOOlawfGIcI7FGnRwG1nUrZxtU+YNHE+rD2xE5p9iqHtH8P9s+mxTFvo+wTA0DaLA9G5RBB9DInwscr9H9RjNZ+sWXJHp4hgwe+jVq9wENjPcuN0cLPc0sxizf8mhH2Cc4bif/4YyzS//P12LvNc3xo0pW6CoWlROVu5omLNk5fCBEj7nmmXmEQ7cF1ZjAeJztddaU5FjMHq8Sm1phFlb7KICDhAVMU5cr04+hY8Y9XPD/cilFqykyeHS6QQxKfhkL1NLebdsyz08yX6l7qM8HjDqfL7qmkybzeRHUBahpPfe4H6UqJuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsJtPk5K6i29LFEHwAYXIRGKFJExCidg5Vp9TlZqPl4=;
 b=Hmodkkn8jTahbM/I/QPC5k3wgqQN38hGD2sz2PciWtl4hM85NmVlFXq2XYG2v3iENyfPI9kzxBT6J/L/umUsKoBiQeIVUmkJbo59jjKYz9688ukashp3bWu4i4W7sQgTWiF6OnT7jK5aMR+gB8nIQDKRnW98HVKimmIMknamN+i0Hw7FU8bPx066rlaMWFTkiGc4n1qVxEKFTxIGdZ3rb7UWGoZN6oeK/EpIRXg8dbR82GYztsbUMyZIsLkfEt/bjF1pFxF253ctiLi068z0tEn3Wxl4xiI3HUafV1Ywe/RbWKj9CeiMTW1hlhZeD+MsB+pcvY0eKugfbkuYLyM1gw==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by SEZPR06MB6485.apcprd06.prod.outlook.com (2603:1096:101:17e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 09:49:30 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::814e:819a:7d52:7448%7]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 09:49:30 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: =?Windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Guenter Roeck <linux@roeck-us.net>, "jdelvare@suse.com"
	<jdelvare@suse.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH v1 0/2] Enable WDT reload feature
Thread-Topic: [PATCH v1 0/2] Enable WDT reload feature
Thread-Index: AQHbJeSSyha0WSkjXEyiFAbwEDTDJrKWCnCAgAAHbgCAAKOQ04AAaXgAgAAbgMU=
Date: Fri, 25 Oct 2024 09:49:30 +0000
Message-ID:
 <OSQPR06MB7252631EAA027245135735638B4F2@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
 <nm4ckxv6swajr6hnqlkq5uoo6ncjzlg6yfxroftat6dubiefyi@xbhi4dvqacxm>
 <ea1be8af-0948-46b1-a1f4-fe572861cde4@roeck-us.net>
 <OSQPR06MB72529E67E67D0D07E59AF1C08B4F2@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <6hkiqbgqkpdlr5f27drs7vcee7pb2uahek4zz5pd5ndativk53@42otb625deil>
In-Reply-To: <6hkiqbgqkpdlr5f27drs7vcee7pb2uahek4zz5pd5ndativk53@42otb625deil>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|SEZPR06MB6485:EE_
x-ms-office365-filtering-correlation-id: 804ba0de-c0af-4610-6db0-08dcf4da527e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?HGxQt3J2DTYKBBW8/pkQdP2l2NI8LpB1imSnEg5a2g6iaSodf0vPVkeT?=
 =?Windows-1252?Q?Uf8nQ3sQdnwU8S84XrVm4ZUkh7K0C9ago+t03vQDVv5RcvWz6rtzLKCs?=
 =?Windows-1252?Q?2HJCbY/BaRE932f6FpCQdnyK7mo9MY5l66POSNaLzmdX0osKrIGnbsA4?=
 =?Windows-1252?Q?tuFDTuG+rlEekBpcMysZ7ALO47C2GRh1vq/0UGqLP0xyCghb95TdPGjN?=
 =?Windows-1252?Q?8bGQOyE36xCPT0HMNJQXUHTPSOfINXiAGbqAsMHcV7RCGf8SyHfQIMoX?=
 =?Windows-1252?Q?lk9PIiT+zc2jAEnrez5P+gjuudF3HkLNKZ4INE1vaJHTXKEm6yqlVoWc?=
 =?Windows-1252?Q?RR73dzG1j37AVE4ug45lGrvP/Qphy0arGNqTsKdOGG7l9rjPtx4MKsAa?=
 =?Windows-1252?Q?u3zPDPv5dQLXeiybmPCwmdlSn7iR0Mq/b0gMJwNR3un/XOUb7V3dSXz1?=
 =?Windows-1252?Q?PyoGMlECVZFyZBYuvL4DdZKUmQ5BHMeQv2VnoC5B2Im4Tc0aUjnvY45i?=
 =?Windows-1252?Q?CNt0bvTfoq0173H3sXpdyc8P4HEaW8igFI/MxjB8lcmsIXjQ66wxgJv2?=
 =?Windows-1252?Q?RPU0MnDY+TsaOdNmApGhBgFuWb7b5708l4Ru78kuVkzA7EChXxpuF4f2?=
 =?Windows-1252?Q?ULjtfGo1/UB4wQUJs3EVRgxakr6bd0T1ahYE3iyyX6sQcpZXNjF+xAqB?=
 =?Windows-1252?Q?GnIXzkiQah6ZLee0bM672E/BDvvw67b5u2uOqjry59SIc1g9TP74NhRr?=
 =?Windows-1252?Q?jPCSVxG917jCBuGtJ+vvpPOqOyG3HkPK9unLzSlq+ZedXT5L11A2bBM/?=
 =?Windows-1252?Q?QkIAXUoMIq0hcCnqw4kFjfUhAuqGX/E4+s+3acLm+Zu0dvzNZX3x0BDd?=
 =?Windows-1252?Q?wGIij/p/C1nKnTF7Fwesgon8kIBgGUQJEPZDMKyI/UOsOeBvTfbjaf0F?=
 =?Windows-1252?Q?MAy21LTPeByYoOPS6bI/4xJMdv0Q4eTxKGIW0LwUS7O1BJ6cBkeSbz8f?=
 =?Windows-1252?Q?Td5f3O57MLIwFX9MWshJ0xv8VBl5L1Dj745gVADFOdKGJHPDlDaZorKU?=
 =?Windows-1252?Q?2PoKZ5Kag9L745OLKPln8woNYG2mcesxW+FQk1FMY4QZRXoiH8/T8GEj?=
 =?Windows-1252?Q?qiWmZMEJagCzo5RiSAQjug2OBDHoDCtJA2bK9oqdueV/ow/no/nab6ML?=
 =?Windows-1252?Q?yIAm1ziy9NCj6oHw2J3z0Uk3qhe1CcC5NZnf0wK2OaxcGMN2tnPrGlUw?=
 =?Windows-1252?Q?F6Wg1P15T6PPrkKizuLBxMpyri5Q5layA7u2W2SYZMJfZc/jUaOIr6/E?=
 =?Windows-1252?Q?kqQEQLWDJ+CTvr9tOMLDI3ugrW8zP6q6hrSzYe9QRLtxSezYjGTw0By9?=
 =?Windows-1252?Q?OUFEHKXwe9atnLrWfdlhw8xN9TD499jGTxYiAiLegqeiNNW9IfJ2kE2U?=
 =?Windows-1252?Q?OAj6XoIEsnt4rDjxEcbzziSDrMCuZ7VHCW68uYrFVyM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?Na/gYLPxG1qoXpha0Yzv7/AY60dKCbHCLgc1OFlmyQkM7umHeRj4k6lB?=
 =?Windows-1252?Q?8xKD8nOoaiujK64AviqcD5Pvxv5VZeebVaEEBABkQenjHugzof0MoExl?=
 =?Windows-1252?Q?GriYMq5j2/+DG/m/OCsjHCm3pFT/xpfs355j7d0BrhhPzSWIDD2UIb41?=
 =?Windows-1252?Q?BTNfVvHCas06hVaI/tm64zPyneAwIOYV8TEHSeKcpCliFtsOELnNtRAR?=
 =?Windows-1252?Q?b3eP4AO7mos27qIq7zcgm7tkpxvZdIgWffL/h6oO971JCGO0EPKAEa8j?=
 =?Windows-1252?Q?/o8XMvCxsQ4lADm4wNyPvZeCb0mvD/7zyn92pJfZtWDzwsodUsh1nZvV?=
 =?Windows-1252?Q?RrSKeMCpPYbYm7vO57cn5OH0+EM3Xyaf8YdNHoL3b6le4fw3TzGlKQ5z?=
 =?Windows-1252?Q?UdHG47UtoiUYV3+foFky8PIa6+BCHJm0Kk9fr/B3T10EmJhma8W+38KL?=
 =?Windows-1252?Q?tnJFTvwDh4q70EdqSKTA0A/ssBw1STGRr4nny6WWIY7HXIZRepnIO9Fm?=
 =?Windows-1252?Q?VSeoUIPhr/mCxqhXmZ5sM09uBWaf4/JuWT88fA051Vs2gmAaIExT4C/T?=
 =?Windows-1252?Q?SmCCCLqpNc7CSHvpE4/1/+NSvW+p+rM3nbrEndsfhu76y4/A34uLXWQG?=
 =?Windows-1252?Q?dolu+h0qW51f5sfin/kBhZX1Fi9sP1J7D38UkdrAzLiv5XlATu6CeqnK?=
 =?Windows-1252?Q?MBYVAZbKdWG5D64wJNirMMbjcrs8CjtBkfR1lAGQQPMheQp0TUAEqZb/?=
 =?Windows-1252?Q?FGnckSBNdzuLAX4EA4zgkXZtP6BU4Y/z+imMoC5B+V230O1PshtwYgib?=
 =?Windows-1252?Q?IUIPEV8zpnonpa7c4fFbpcrT7H4TCdedQbSspztILnOZ1LRuiK/cHGmR?=
 =?Windows-1252?Q?wXudICvwuMFJa7q4b3cfakAar1Xl0FW7Ec1t1UzB6aSjqpgZVRq5UH79?=
 =?Windows-1252?Q?U/lbD5snvyELYnZGQ++Gxz6j0z/gzDOv0M0XrFdAHof4b0NpJIk6g0xa?=
 =?Windows-1252?Q?8xrhEvPH8KGSNvsUqURovueNOCd429S6MTCFEe8Lkzm+hGqdh5e3mBSc?=
 =?Windows-1252?Q?gCBbm92ge8gmB6cLVCclR9tFdGwHP/4sE5c7jHlsWNZYRNac5oPVM39a?=
 =?Windows-1252?Q?xATZZqpCCWekcbfUwNYN3YEk6Sh9PHFhCpAylJMDHmcrVGyMWrr5Z5C3?=
 =?Windows-1252?Q?2hUjVJeSwOT6G4PzUqpUsvkVa/waz76wmW42D5mnFLqBqza9AhGp/q0a?=
 =?Windows-1252?Q?xlySUTc1rpk6OU0wRR8u4PrHkIFu2CgEnlue1lsGH90G8XffKV1UHh7P?=
 =?Windows-1252?Q?Jxu+urrsA8rt0WqPRQuUVEcnwoMRgBNorroubRmV3MsCIrDKRePgpnLn?=
 =?Windows-1252?Q?2Kligc2RbdeoHoY8TPI81vb4qxfDbh5QwDnTTlQELsyaPJ2K7v2nnIsO?=
 =?Windows-1252?Q?w3Mzm418+RoeFGImesgg9dWDbLG6vlRkTck4ngznSSOygDYKJOgCcesz?=
 =?Windows-1252?Q?37qHGoB2zZOQ9nrkS7ahg388d85oq3N2mRHpVQ3PbTb+jjBsghZEdEqX?=
 =?Windows-1252?Q?+Foz2oLl4SX48/ON/yZ3Q7csRdO4SIQEJSKb56fhsBk6CbhV0tb1Ny9X?=
 =?Windows-1252?Q?3ih6ke4XaKizUPrab8PCm8LGfLbKzoAG1K1PZKEF4LFVhKc2EB2wOYyY?=
 =?Windows-1252?Q?vnSdLr4+JjpukHjX+/XpEF0f3296ScZk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 804ba0de-c0af-4610-6db0-08dcf4da527e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 09:49:30.3238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9kzGMW54R6VXrSOAQnRfH5Q2e/cNUpweJ4aHEwedCuDXBeU8umWaHeBnw5VaWp0q6GkPMJ5auO+SsmzQJtBB6NFna/T8GNvFQWqczZp8xU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6485

> > > On 10/24/24 08:40, Uwe Kleine-K=F6nig wrote:=0A=
> > > > On Thu, Oct 24, 2024 at 03:15:46PM +0800, Billy Tsai wrote:=0A=
> > > >> Aspeed PWM controller has the WDT reload feature, which changes th=
e duty=0A=
> > > >> cycle to a preprogrammed value after a WDT/EXTRST#.=0A=
> > > >>=0A=
> > > >> Billy Tsai (2):=0A=
> > > >>    hwmon: (aspeed-g6-pwm-tacho): Extend the #pwm-cells to 4=0A=
> > > >>    hwmon: (aspeed-g6-pwm-tacho): Support the WDT reload=0A=
> > > >=0A=
> > > > Huh, I'm not convinced that extending #pwm-cells for that feature i=
s a=0A=
> > > > good idea. Unless I'm missing something none of the other supported=
 PWM=0A=
> > > > chips can do that, so I hesitate to change a standard for it. I sug=
gest=0A=
> > > > to make this a separate property instead.=0A=
> >=0A=
> > Using a separate property to enable this feature is a straightforward=
=0A=
> > method, but I don=92t understand why extending #pwm-cells isn=92t a goo=
d=0A=
> > idea in my situation. The feature =91WDT reload=92 can be set for=0A=
> > individual PWM channels, and the PWM subsystem has the of_xlate=0A=
> > callback hook, which allows each driver to define its arguments for=0A=
> > the PWM consumer. I=92m unsure if I misunderstood this callback usage,=
=0A=
> > as I couldn=92t find examples. If my understanding is correct, this=0A=
> > method is better for adding our specific feature, rather than using=0A=
> > child nodes or separate properties to indicate which PWM channel=0A=
> > should enable this feature with the corresponding duty cycle values. I=
=0A=
> > think using separate properties to achieve this feature would be quite=
=0A=
> > cumbersome.=0A=
> > As I know the arguments for this usage are as follows:=0A=
> > First: PWM channel index=0A=
> > Second: PWM period in ns=0A=
> > Third: PWM polarity=0A=
> > Therefore, I extended our feature to a fourth argument to avoid any con=
fusion regarding usage and added the description in our yaml file.=0A=
> >=0A=
> > If my thinking is incorrect or doesn=92t make sense, please let me know=
.=0A=
=0A=
> It might make sense if your bubble only contains that single PWM=0A=
> hardware. However if you extend the pwm cells semantic for your PWM to=0A=
> mean "period if the PWM watchdog triggers", i can hardly refuse the next=
=0A=
> developer who wants to extend for "period of the secondary output pin of=
=0A=
> the PWM" or a step counter or some property that defines how the duty=0A=
> cycle is modulated over time. And should the next one also use the 4th=0A=
> u32 for his purpose, or should we consider it reserved now for your=0A=
> purpose such that the duty_cycle modulation goes into the 7th cell?=0A=
=0A=
Hi Uwe,=0A=
=0A=
In my view, the order of arguments=97such as PWM number, PWM period in ns, =
and PWM polarity=97is just=0A=
a convention for PWM consumers to follow. Even if another driver doesn=92t =
adhere strictly to this=0A=
rule, it shouldn=92t be considered an error if the YAML file documents the =
usage of each argument.=0A=
For example, some PWM controllers set #pwm-cells to 1, where the first argu=
ment isn=92t necessarily=0A=
the PWM number. In google,cros-ec-pwm.yaml, it=92s treated as the PWM index=
, while in marvell,pxa-pwm.yaml,=0A=
it represents the period in ns.=0A=
=0A=
If users want to work with these PWM controllers, they should confirm the p=
urpose of each argument from the=0A=
YAML file, rather than assuming the PWM driver follows a conventional argum=
ent order. If the YAML file doesn=92t=0A=
specify details, it can be treated as described in pwm.yaml, which is fine.=
 However, if there are any differences,=0A=
I think recording them in their own YAML file is sufficient (Like the examp=
le google,cros-ec-pwm.yaml and  marvell,pxa-pwm.yaml).=0A=
=0A=
> Today the bindings are (well nearly) used in the same way for all=0A=
> hardwares and I want to keep it that way. If your PWM has a special=0A=
> feature, give it a speaking name that the occasional dts reader has a=0A=
> chance to understand without reading HW docs or dt bindings.=0A=
=0A=
Using another DTS property to achieve this isn=92t as elegant as utilizing =
PWM arguments, which will only=0A=
be applied when the PWM consumer uses it. This is another reason I want to =
extend the PWM cells semantics.=0A=
=0A=
Thanks=0A=
=0A=
Best regards=0A=
Billy Tsai=0A=
=0A=

