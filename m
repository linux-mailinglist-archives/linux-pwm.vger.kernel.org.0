Return-Path: <linux-pwm+bounces-2835-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEBB9331F7
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 21:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963B6282CDB
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 19:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FE41A2C3F;
	Tue, 16 Jul 2024 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MIkklO6r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2D1A2576;
	Tue, 16 Jul 2024 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158158; cv=fail; b=b2U9Z+104QtB1GQKaNPJsMPoH7SSX3SCSH7phJOcSJ3HVpp/foqEC018q+433w2Q9/tjSM06qRxb+eoO9FdVm4u06oMK3qlmnNaRyhrAY/rfKlz5hX1TyMuIIgqSdCQ6J7ozi6bxOyhFTeZplEVnA9ElUTZzGSxriIQylcwAhuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158158; c=relaxed/simple;
	bh=uufbwtMH8Q4FcaHsYoiDpdowRKaQgK3Y3yz2947Q2s4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WgkndZFHrjHEe94GmJnbdkrbQNnySD60AmVD6wZMyDbH0rhQDLDiiAW2YKABg0dr1Q1Vxe7N+NTGl97Lm8EE2+tWSGK3ukrJSODdPjhen3YmUU1WlPGcmSXbSF1cagKRXyKMmqtazjA27psKOhiMChnxR5O/+keB5mwE3WwafGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MIkklO6r; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taSngX2xKOG1jCCNCWb+ENN60ye+oiKjzJenkjo292lqvu73nhseJV7okNI2nB4ntU7HtsX0Z6ZdBCdTaC727S1C5vl2liGOsGLloL9BPMkqcACdLdFtDQh5liRWn1BgEqa3p2r/faHb9abnHOakQbRrBsDwXazvYJfngPvZrSeKcaSsy9D808HbXIB8yXFyE7ocbj9CepSgyn/uVwRyqm77b1tps4GQMaSenbCvAfeSxl/fkJa3q2/g+2xoMXn9C9Qi0kvRJEAjsHmhSkGhw5zyUiJTko5qrCKK7xepPe+QrMFRqH1PUBus5xMWfD4ahwimpQbs80YvkfezQ/c3Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUMG4X1O8TFBRzq+Frl5S1x2kYBoqEitLdvdlDy43Ng=;
 b=kuZ/X0DZ0Vgor5xS4YW3NH3MRcVAVh8eJbL4UiWVJOPGQSiUslnl7n3ZAP4Vjz/ubMZ/FyRYIQ/OgaR+ckt0zpDRrqJoLTyFrK7A0NPzIEy46K25RkudOmGkf4jvhbU5dNWbvqFKn7fmDEnIE5ICQUCMOFbpvM/UngmfMTeUHRIGnWI/poYMhAbxCJtl3purOcItd73wipqEu1O9fF6/udEqe2Vz6OYfNX3Bvo5MRzolQ4O9BicJeAPKSWmJH8thizUoq+thy55y3AcjmvykTkb9rz4/1UTvpN/gifkjoFCAwIr3Sqk+Q1s69hnZeZWsXhSpsBVvdSQqU7CC3pECVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUMG4X1O8TFBRzq+Frl5S1x2kYBoqEitLdvdlDy43Ng=;
 b=MIkklO6rth4+/HWUoLsXSu1Exi3lGVnt2LxlrNODCM+BzHIPBOVn1lntkiuU5ugodTYrZ+euhvYA626ZWopfGQc5PTJW2GSg7KDmYABzmyCwVmoTbRfKzIyDYqtkU/KBJlnbVJJNNpeVRWKJdjhGUXhudaW5iAWS58HHQ87xlMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7325.eurprd04.prod.outlook.com (2603:10a6:800:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 19:29:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 19:29:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 16 Jul 2024 15:28:28 -0400
Subject: [PATCH 5/6] arm64: dts: imx93-11x11-evk: add adi,adp5585 gpio and
 pwm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-adi-v1-5-79c0122986e7@nxp.com>
References: <20240716-adi-v1-0-79c0122986e7@nxp.com>
In-Reply-To: <20240716-adi-v1-0-79c0122986e7@nxp.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721158123; l=865;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=uufbwtMH8Q4FcaHsYoiDpdowRKaQgK3Y3yz2947Q2s4=;
 b=lG7oqtHmWcsId33oB9iTm0k58jlm5f2ABLmtxtCik1gNCklvSep1FTPPVD55P332uICHR/lPh
 i8tZ/HVLdHgCPxqg+jOGmQMPHFMHQJqvc5guEsnNCRj30uPMiPvchI9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c986f20-53b7-4112-7066-08dca5cd934d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWtOeVhsVXBMQXNCbm8wVTR6TnFsNm9OY0xrNEwrQmt5K3BndDlDenZCRnRC?=
 =?utf-8?B?b2lCZ2dCU3BzVXZKODN2UEVwS0lUY2pTaEM3NEtYYkI2WXExcjYwN1RlTWpn?=
 =?utf-8?B?REpqMHFMcGxtblUyTjFXV2JTWjdlL2dWTHlTY0VsVjBxMXM2SjZ5NDJIUURR?=
 =?utf-8?B?TWhuQ1hCWGRZbGE3SFBjZmV4QzhqY0hlUUZaTmZ3RHRpOEpIdFpnd0VCQlUv?=
 =?utf-8?B?RTV2cUl1bW9nNVVXY0ZIb1hIUE1RM1V1TGkvSTZ2YzVrWlVVZkQxa1p6Vzdp?=
 =?utf-8?B?SGJiL1FJVFNPTEdiRjBSSE5jRXRtOTJzNW1BWGRLbEMrcm1USzFnQWI1MlNt?=
 =?utf-8?B?bjZQdVdaUWZwRk5Kcy8zMDVubTd2N3V6bWI2WG1jMGE1Mmk2aUJiak1sLzdv?=
 =?utf-8?B?QU9BQ1FXeFdBekg3Mm0vampCNkdneGNvRVE1TlNXb294L1g1aVptQmFFZG1N?=
 =?utf-8?B?RzJ4dEliNk91c2FIa2tpd1lRTzc5RUp6NWI2cWVPb2NrWmdSSjZaTTZBTFg0?=
 =?utf-8?B?SmFEU3RlR05vZnV6RDBvdERkWjFCdThvVGhBeGx6cXhwbGRyOG9ua0lrSVJ1?=
 =?utf-8?B?MnM4VVd0Um1nSG5uaEkvdkRIZDNTUHlJcnJxb2xydEhWTXFCOHlpUUtUT2dN?=
 =?utf-8?B?d0oyUEVHcm9tSEdtR1Z4R09RakhCQ2NYZGRiaHpQd0ZzV1R1NlJZeTMxR0g0?=
 =?utf-8?B?ejU1K0lrNXlXNkVETXNLdzh3cmFMTnQvRFpWbmo2K1pEbE0zeEwyeE9uMHhU?=
 =?utf-8?B?TksyRTU4ZUNQNjFkeGRva3dVNGZZWFlka29ldkRvVEZxVGg5cTBMMWtzMU5F?=
 =?utf-8?B?eGxHZXlHZDcyaGNobkErdkhkZk1EeVdnTHV1SlI3cnJTNjlRWTdVVjdVSGJR?=
 =?utf-8?B?SzBmbW1oQjZHNnYzSUpFTjBzenM0UGtVOVVTRTN2M09DNndMNURmM2h5VXJI?=
 =?utf-8?B?Qk83SFFTRUNHMytDR1BzMUFvVVlGUnhPd2M5VmlyaTlqSVdBSFV1T3gvRy9W?=
 =?utf-8?B?TUN1S29pWVBZMUM0cHZSanRTQ3RuOHJUYnpmNXZwdld0ak5MSlRQU3FLTWZ2?=
 =?utf-8?B?RDJRWHNyZzZzRnU3dHR1cUVvL04rK2ptekQyMEcvaWlVYUFXakphRFRRNVMw?=
 =?utf-8?B?Y20vZmFCbWRsTXBNS3hJdjZWVmFRdEFoZi9ENmsxWE05MHZoUDdyMFhtdWsx?=
 =?utf-8?B?a2h6c01PeGJ2VE43UzBQckZsYzV1Q25ZcVUvWGl0L1Rzc1ArMjdsQVRJMmNy?=
 =?utf-8?B?Y2psTWFhdFB1V3hBRndtNnN1NW04U2ZEWDJOeFVzcGVPb3FxWWg4bUpJRUpI?=
 =?utf-8?B?b25XTVlkakJkMk1wdUJ1dkhpWCtta2hxZkpGRnlZRDV1d1NpdmFFUjFTczho?=
 =?utf-8?B?M1lDVDZpUXRZeXJoZDdpajVNVDRDZHlOdkJYV1o3ZGJFSldLYWZoQmFJeVRN?=
 =?utf-8?B?WGdFNk8xcGRWUWlnU3JFRHVBUm5IQmFGMUw5RDdXUnZpL3YzRW1oL0RVTW1z?=
 =?utf-8?B?VXduOTcxbmpOdFB1bzNnL2lMQlB2ejBPcWpFdjgyOEpDK3huNENTMDlINEtF?=
 =?utf-8?B?ZWFwRENQSjlpblFIUDd0cFRma21SZmtiZ1VkTWovdm1HUG1vKzRLTjFTUWtI?=
 =?utf-8?B?NVIzRzl4bE9vUjRNSHl4SkNyalltNFZvRmp4ZFVEOFlraU9Ea1lLdGZWTHJW?=
 =?utf-8?B?UmY3dityaHVVZkNGaFE0U3hjeEdZRWUxaXRFRlBPZitCMmZBcXhFK3IzcU94?=
 =?utf-8?B?Zk5kNTVMaHY5WThKNjlRcktsUUZmc2MrRHErY3ovcWduZkp3SXNkMTFueTVM?=
 =?utf-8?B?SStSejJsaklmVDVwUURFMnZIdEFpRXFObG1RRUZvOW9qOWtNb2dLNEJxeSs1?=
 =?utf-8?B?Z1dYRDRJdFJndWlhWXZhdWlXN2JxcytwRFoxemkrWDNHL2UvNUxrUGdveHVT?=
 =?utf-8?Q?EmxLGf96AV0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MllScjB6b0JkWXJzbFFyVkNuZXJ3L2VKWThyaC9uemdYdkNQVWpCZ2tDcm93?=
 =?utf-8?B?M3lJU2xLT3YyQTJwTndzUlZwR0t1d0dWeDlEYnE2ZGFlTDZXS1VxUVBMejJL?=
 =?utf-8?B?NUs1cUsyeWxScTh4dzA1VE9RZXhoR0xYSXlUZ3BzeFVpTDBySVRZd1o3Rkh2?=
 =?utf-8?B?dDBQY0ZDdS9BNHYwQ2VRWHVpcXpld1BPNTJYR2pZMldpWDA1SVc1bkkvWTBM?=
 =?utf-8?B?bFZ3VWJKT04vNmp4V2szRzcyNFNEc01yQzd4WnFHN2txaEpnbWxCNEdGN2Nv?=
 =?utf-8?B?dm43MVBabkE1L1F4OU5YK0dRVC9HZzhoSmZYZStPMmVCTy9tck04QmVhSHNM?=
 =?utf-8?B?MXdURkRGcjRpNjJBSE5kT3FuTTJFVGtPMzBZZFRqbW8yZlltZ1ZEc3l4Rmtu?=
 =?utf-8?B?cUJtVitna1pVU0lSanAyWlE3cXhOK09CQzNyWm9qWFplb252YlM2OFJ2TnU5?=
 =?utf-8?B?M2NXYVVDMmlHYUVOZHZFVlRDNUd4YzFaRStzYzJScU5aVFd0RXdUQXZpanRk?=
 =?utf-8?B?a3hYdUhpMTR6VWovT2s0aUh5YXZQY3A1VzVVbytHbDREN29vTUlmTXRwQ2RQ?=
 =?utf-8?B?bGFDZWZ0TnRQNm8xUmZwSTd0cFIvc0p4czE4ODZJTDBGTlR2c3RzcTV0WWJP?=
 =?utf-8?B?enpvM1Y4eTJDZzR0eTVzMnpNVEhHbFRyQm1tRTE5Wm0yRGE3SU5DREh3Yi9E?=
 =?utf-8?B?RlhvNk9nbWNIV2tHakZIUVptL0swR1g2ZFVSZCtRaGhDSUEzc3M5aDlaVWtN?=
 =?utf-8?B?OXZQbWU1L3lkUGhmZGpvajdCYk8xbUxZUTBTQm4zM3RiVVZIdlR0cmlwbGVi?=
 =?utf-8?B?Y0FML1JreURra0twcytLQ0NOYm9xNStNSVp3am5rN2w5R3Q4QWZCSWloZjl2?=
 =?utf-8?B?WldzUEl0MmJOZ3o1WGdLcWU3MG83bHlaTHMwVDhsNi9XQWRub0hZbFErV0tK?=
 =?utf-8?B?WG94MFVXRml1dmFHRlNxZnMwVDJwVk9oRGxqL2VKSmRsWEdXSzhIUXN1OTd2?=
 =?utf-8?B?WnRZbVJQaVA5SnY3U2oxL2ZxT2EycllieXJCYjh6alQ2Uyt4a243SFd4SEtl?=
 =?utf-8?B?YVMvUmhINzhqQXduejB2NDlSYWQrd3VtT0hxa3dvbXpGN3Y3bmlZNWg5cm8v?=
 =?utf-8?B?M1p1dEtrbllwdUM4Rm1UMitwSmJjaEFzTWZ0YlgzTkNIaUJhNWExUnlBbW9t?=
 =?utf-8?B?Ymo4ZHFKSE5ScVZ4ZTBxcmpjQ055c3VIR0t4ckFlZ01kWU1rSXlHZUw5L0tQ?=
 =?utf-8?B?dFBvNWx3Z3pyckhHMGZOYmgrMEVUUGxqLzh0TzdNUXlWUUdYajhpZXdpQ2Ro?=
 =?utf-8?B?SE4remh3SzdVaUxWc25oR3h1M1lCa2Z1VFJxa1Zxa1FCY1VteDBoTzBEUW96?=
 =?utf-8?B?U0QvTWp0NlNZVUsvRlFXTGdzMmFDeXBsQ3RtOUVxZHJsdXVvSE9RMlIzTHNn?=
 =?utf-8?B?aFdSUDAydzEvVHdFUnN2eFZzcXg3Nm5hOEVoOGczWGhZWU9yTFg1SW5zZktt?=
 =?utf-8?B?eHZWTi95Nkc3czJnMVZ2WlRlOTRWVGdybnZhajVNNTNDNCsvQm5QWm5DQ1ZS?=
 =?utf-8?B?cEs5OCtGdHVoNUFTSGI2dGxGYUR4UGNOZ084Qm5heGxOWGhZSGlyTHJpM0hD?=
 =?utf-8?B?Ullpb016ME9mTmIzVzFOSzFBQ2lQcXdDbzFOZ21FVFE3K2tGM1pIbHJvWTBt?=
 =?utf-8?B?TW9oeG4wOVNiQnBSWXpQSEFyN2tBMENCeG9sTVh2d01ML0NhUGh4QjlNS1Nk?=
 =?utf-8?B?WUFyQ3N1QllUeEcrZ3dXclZZMVQ1R2VOYldoYUNCdXZVSG9GV2RJRXIvMlFm?=
 =?utf-8?B?bnF4TkFSM0Z5VHZLNjZ2MGlWbFpNRFR4YUJMWitONnZGcHVTQ1dOeUhKN29x?=
 =?utf-8?B?YUhTUVUzSHRNK3pXbVNLcHpTNEt3UmUyOEFCU290WlQ4aXJXVFM2RkdYY3R6?=
 =?utf-8?B?VEE3TE01aHZhVVdmY1lBbUZQbFBoakdsc0MxcWcxbkg2elZvVGhLK0hHWXU0?=
 =?utf-8?B?MXphNWltNHlvTWZHbXhkSlFYZHhKdVJnWVZLL3FCcE9yTnlrMkd4NVhsVjhH?=
 =?utf-8?B?OVZLSU4vVGc2eStBR1RMbW1idjZDMGlpS2d0dnZwY2JRbXpPTlFsb1h2bnRm?=
 =?utf-8?Q?3Ltk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c986f20-53b7-4112-7066-08dca5cd934d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:29:13.9302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XBuE8ZrYsjsLtNUGO63mwGTL/fBlIFNY1MZ4Zu5MEzw+jVZdLzz5D5QZcQuR2xxDxV4XZvVR+vG75f0frAA5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7325

Add adi,adp5585 gpio and pwm for imx93-11x11-evk board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index a15987f49e8d6..6bfb90f4da63a 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -241,6 +241,22 @@ ldo5: LDO5 {
 			};
 		};
 	};
+
+	adp5585: mfd@34 {
+		compatible = "adi,adp5585";
+		reg = <0x34>;
+
+		adp5585gpio: gpio {
+			compatible = "adp5585-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		adp5585pwm: pwm {
+			compatible = "adp5585-pwm";
+			#pwm-cells = <3>;
+		};
+	};
 };
 
 &lpi2c3 {

-- 
2.34.1


