Return-Path: <linux-pwm+bounces-2819-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC955931BD5
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 22:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08521C210DB
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 20:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F7D13BC26;
	Mon, 15 Jul 2024 20:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PEnu84Lm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750613AD05;
	Mon, 15 Jul 2024 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075421; cv=fail; b=XhC89XnWYzCmNCg04+47BsjbO7MJWTRMheFMUEVETmWWskOCDo9+pGbI3TrX03ul+n/5EOUlBf2rbd9yW8gH66NiQL7c2/vozZLzY+SFyj+FEFD/R8Ozes6EfFqprEOQgIrxZRom1O/fgK+iRs1+rZ11wqMLVBXk3WQrsdEIecE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075421; c=relaxed/simple;
	bh=N92j78PF7Ri+PngaXFFDMFFV6SHAvWi7UZCRPNN3Jsc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KWnNcE/i6qn7LviZGDewPcuUgkz3yCIHpifhoSes3FsPuVVmHZGUyYHS3VfGLuL+VgDfRy/uK9ZdsSWGftSXXow7Mboff4S7dZpr6kbIyLgeRWZG4J5eYkaPgk7ckWkPSM2UrPoVG5XlZ4RNRFyw10R4o2+PalgulVpvdnOQnT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PEnu84Lm; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5ikpfqFV/zlYuZQ9T6diNOHOMn7/tJ9kQAux3rebzH9/LUW46bu8vU6Yq1LmH5dC1lC1ngys7UZZnk/8+tPnPuGRyZvofEIGSutIQJWrEkZrqKnlz4ILVuEJF0XIP/mInJriyiewFeqF5tEuoD1T5lDEz8zdOkjNy01I3RP7kqQWMlO3+A1NU+zptLuHH/8tl+2OYg7TmhATif27G6XOzFophMHZTbAvbCWzTL7di/QE1OQniSXkaF0IajcxLZT+5zgkxUfFWsOXC3p6cEZBQi7A0PwgMteXw6agUQgFkA1RyqCmzjI9XtG07zawS5hyQ4NjykgTXSsCH9usKIlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObxXzQFhjjaq1HSh3InarSZnaei1qz4Q8BQ8Pedp2rY=;
 b=OvfCt5aj/r936Pf5piQIhkZRXAAWvPnsWmqEKplzazCsdn4WUYHWYkPtQcD7p5hIDou2VQjlic2cv9wZsok/j9Ff4DnJNzAVbP7FAKKt0WSyIkkAnVPL6g4CtlR0BiszDlOrXxpa7zOYV3BgsrJCmO72W/1efmy2qyli7WnB+0I/b5X1tjEq7gjOQhBMAmIi+TeNmPIMvhelztmZ0RCFLtN76O95X9OIYRyiGITqCl8L1Zm/15wofmwfUVvNQNVJwkNFnI5ElOrnT5TDWNLlUEcYEOVbPGoStzyzKEi6soMyZULfjyX/WDQOItbH9AuSRh9Pkt6WTkPEFp+3jUSUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObxXzQFhjjaq1HSh3InarSZnaei1qz4Q8BQ8Pedp2rY=;
 b=PEnu84LmDHhqsymqY2ym1EDwDTRfxgnbK0hzPVTH2aSFKhEw1IyJs0lpaU6t1hmMbiV14ZYY3Z/gJN445Z1TE/kEUFxHPSIrijbZuV7Y1Z2szUMzacslM+cQPtNDJbn50bsKcGdheVcdu6qgU+WKrbv/3Kpf5dBukgdiawSKyuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9253.eurprd04.prod.outlook.com (2603:10a6:102:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 20:30:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 20:30:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Jul 2024 16:29:50 -0400
Subject: [PATCH v2 1/3] dt-bindings: pwm: imx: Add optional clock '32k'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pwm-v2-1-ff3eece83cbb@nxp.com>
References: <20240715-pwm-v2-0-ff3eece83cbb@nxp.com>
In-Reply-To: <20240715-pwm-v2-0-ff3eece83cbb@nxp.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, pratikmanvar09@gmail.com, 
 francesco@dolcini.it, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721075406; l=962;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=N92j78PF7Ri+PngaXFFDMFFV6SHAvWi7UZCRPNN3Jsc=;
 b=sb8L0+kcfVcFhT6/BqjkO2Vsduepsk0r9dTSApE9oKrhLUT17iTIpAN1JMJssq1A4MIg7Aq3j
 Ha6VlMf/uTPA+HAX/ZRVzt8Cywjd88a+koKK5mHmAR5JX6+DgoJKiPR
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: 08769747-cba9-45d6-47d2-08dca50cefb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1UyUHFka1ZVd2IyaFMvTWxkdTV5S1F0dXBDQUZUNVJ3TXNqZGZOdkNMcmJY?=
 =?utf-8?B?M2RXTjBQQ1NSVEVPbG9aWllvQUg1QnI0MzZvZ08ybDM1V2tnNU9ZeXdYL2gv?=
 =?utf-8?B?Wm4yUk44TTVsbDBMcWwxc1V2VTMvMUFGYXgvZHpJUVQ1RWtRdDFzek80a1pi?=
 =?utf-8?B?aGlXWXY1OEg0WXZncmkvQUpMZVBtRkt3d3h2aEZiZ0huQWJ3YkVnVmdrcjVq?=
 =?utf-8?B?YkRrTVdiZG9tMXc0SndYVUlacmsyd2xwNS9ieUxsRmFaMEY5V0xYS3FRK3pE?=
 =?utf-8?B?V2w3aXNvNS9ZWmhOZk5pYlVQTkJqNkJmR0NmRjhsRG5KeGNxdzJFKytDMFo3?=
 =?utf-8?B?VFYzL0l3aXgzd1c1NzRpYmhiY0J4dEJOTU9ySWpEQkliL0V2ZWxsZ2lLZEJP?=
 =?utf-8?B?cEM5YUVFM3pSTGEzUUVReG5UOGJzT0RPZHdPemUvUzdwaXVicG5HOWtmbTFu?=
 =?utf-8?B?aGNMdm42Q2pORVI3RVlNdnliVlVwb1ZEcEwrUVd4RkIrU3NzVmVXRHNhdFRP?=
 =?utf-8?B?NTVIS2p5Wld4aWdsd0Jqa25TSko4YjUyTDhzMzh0R3l6ZGRiaGplT3pkNU43?=
 =?utf-8?B?VFFXdm1ONGVHYXUwU25uVDRBcE1nWXZaVjNvdkJnMGxOa2R3NmVId2ZQbU1I?=
 =?utf-8?B?RGs1K1pMdEFvU2JSTG5mZDV2RFVCTzdzVGdoYTNucVZzR3VTU0xOUm1sN0pz?=
 =?utf-8?B?ZXlSMUU5a1FRWk1EU2VPblU4Rk1RWDlhdTNLRk9yV3RsTDdjdWdTZG5KK1Y0?=
 =?utf-8?B?OE1SamFHNDRHVCtCbUd0Um5WemVrbnEwMTI2VVFBcWh4VjF3cTdqTk9LWk0z?=
 =?utf-8?B?ZWhTQXBpOXM3bmNScGx3RnpabmJ5UlBLYmYxa0VGWm5URytDVng0dmlPMkxE?=
 =?utf-8?B?Ujh1eSs4SXhwQnJrK2JKUmwyVDZoeEEyT2htYWJqMlVHSndJSUtrUE55ejA5?=
 =?utf-8?B?M3R4ai9RZEo4ZXZBK2QvT2ZaakdvL0d4akhsdWNXVDljZnR0bHdCN01jUERv?=
 =?utf-8?B?cityeTBlSnVPNVgwdlB0ckRBUTdtaTVjSUtPc0hreEhpV0xVK3ZKWjFWWkpR?=
 =?utf-8?B?RytkOVczQ0JCbEszQndvSDhMOU1NL3RydTdDeG9BWnR6RFBBREF0ZEpQUGlx?=
 =?utf-8?B?TStaOHlVVnl3SHhSMVdDb00wcHpxSEg5dFk1enZ4VVNLeTVpSFg1eGJHWkJj?=
 =?utf-8?B?YVBvK2JjQUI5NmZLd0ZlczFQMTFQSEt6N3h0MStmVjhvd3RaVVEvR21QbTU4?=
 =?utf-8?B?S2lXNWFWcXIybWlxRmVSYktRbUhhNlpkVGpCM0dSZzFJK0ZCb1VnZzJ1Tml2?=
 =?utf-8?B?ZWtOdTFHbTc3V28xV0hMbmppSXVQSUNEc01QbitGVUE1aTMyMHcrVXpHRlJw?=
 =?utf-8?B?SnpzZ1ZtVWZ5Q1lqdVVNQXJKUHBieFlQRG9qbnRKOGZQNmR2Y0J5dHBmREJ4?=
 =?utf-8?B?cm12RFEvdVFQQlhxcTdKOFhQNE0wZTFrYXliTGwzbk80TVhhRGJueEdvVHkr?=
 =?utf-8?B?U0RPYjlZV294UTZvUU9QZFArWGs3MUVUT3EzSjd0eU1yQmNKaHI3dDFCMlFE?=
 =?utf-8?B?ZjVRWE5id3RxYWUyTVBxcEZjdG1INTVCQnQxRHVzU1VuMmdFR0JQL1dJbFFr?=
 =?utf-8?B?b3dsbGpPRitDbjJEZVdmTGpvUy9ObG93QU9DTnJlNzNrU0RCdGNtZ2lmM1Ri?=
 =?utf-8?B?TU1rYVR1cXNDQ0V4S20rUjh4d1J2V1BTRXdKZTEwZCs0amdkQjVTZ1BqSWJV?=
 =?utf-8?B?eVJEYzBGRENna0tCcFVkSEk1UHg1YzdZL3pSRWhQWGE3SUlaSTJJZVBySmRI?=
 =?utf-8?B?VVF4WnRnV0Y2NG04OTk0dXBycWM3WTlwUDBTcDZVL3ZFMCt5bnFOcW00d2pF?=
 =?utf-8?B?QmxaUndYK1h6WWJOenhUa3dkOUpUdVNTVEZtcVFHelo3VXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHV6T2NvMDB4bGhnS2NLMzBrUWpEMTYxYit2KzY5TWpmRTdFY210L2NndzhO?=
 =?utf-8?B?aHpsZk5kSEhEVnEzeTdCbHFBaUtReGFWRkRCS2gwaVcvcnRTR1dDT0Jod2VM?=
 =?utf-8?B?eXlGRGg4Y0tYQ0h4engyU2lGdkhGVEppbkFEaGczakJGOUxjQ1RUZnVTQUpC?=
 =?utf-8?B?a3IzWEVEYXg0aVBKcnFVQmREa3NGWFJmWlcyMzdxd1M4UE92ck4ya0w0UkFR?=
 =?utf-8?B?SW1IZzQ2bU8wemp6ZHRrY0FLOTNaUjNIUEtuQUFyMStHV1BUbzdDM08xMHNT?=
 =?utf-8?B?c2ZXVmpWelhTbHdZeGRpcmpMWWxzenZLUE1TcWNDZkxkbm43U012SGx5d0pR?=
 =?utf-8?B?bEVPYWZSeGFFcCtPRkk2NngyUzlhZzVpdWx6UlgzalhiUXV5WDlwcXR6UDZU?=
 =?utf-8?B?S0NqZEhUMnEzOVhnRWtTU0lpaHdmR1h5VTRNMEI5NCtidVZhdzR3YkpnR0po?=
 =?utf-8?B?aThXYTU3QTZxcTdQc2xBK2dkV2NUN2hPK1N3OXprQUFaWklybGlEUnJhY3Z3?=
 =?utf-8?B?M3Q2TERxYUxneHJyZTVnd2ZiREVZSG5LalhkWGtySFdJZFIrTmhLU1V5eENz?=
 =?utf-8?B?YW11QXc0MDJZbXR0NFVZSGtFMGRNbW1kRmRCeVJJOG9lS3JTUWpKMDJjZ2hP?=
 =?utf-8?B?Q3cyYis5UlMxaGdaaXYzZ254bUx5VUdGY2FPTzg5MHdaNW8rVW1iWnpVeDQv?=
 =?utf-8?B?NnZObEJCc1Y2QnFrN1hRRTFnRmUxTSt6ZmZ3cjFYRmQybit0TmRkY2FIbzMr?=
 =?utf-8?B?RHQyUVM5NWhtUkU0S0VLcXVTVG0xMmdrQVdoaVlyZ2U5dGZERXp6WCtscGNj?=
 =?utf-8?B?OFRheW5qSVo3ZjYxOW5VS1M4eXRHbzdTMUQxRysycE1vd0R3UUhaNzZUa25M?=
 =?utf-8?B?QlJTY2gxemFJakx5RktUUGRzTDI4K1NuK0JuU2J6ZklNaG5scHFDdTgwYTJB?=
 =?utf-8?B?K2dLOGZ6bVJvTk10dWxRQ1hTMm1YRDIxNHdXMklGN0hodHdNS01BbGlGU3lC?=
 =?utf-8?B?c1lLemYxdWxQVTdOZ3FWNENKY1duWnhML3J0aGF2ajNZanZSM3JPdnV0TGMw?=
 =?utf-8?B?bFRZSCtEdTc4OTRrdExYaEQ2ZTNGR2hNcXB4d04rTU1qbFpHMzZqcitRR0lr?=
 =?utf-8?B?V0h6VnRwU0x4NjB1TnVPZFB4emFiUnVncmtmUTJIOTNmc0NWU3FuQXFKMzkz?=
 =?utf-8?B?R05XWlBQRVNHK3l3SUVHdkZNampxK083b0R3UFdjcG0xSlhHQjVJdWQ3SXg0?=
 =?utf-8?B?MmNUYndFL1ZObGt3TU9yQVlqQTI2eTh6bkZ0N2NNRm5jZ21nTGJzT0swK3Ir?=
 =?utf-8?B?MXNRNzFVRnBadVQ3VE90WDdMdjl4S1FjWFhLM003TGFJUjlVZGordU5GQ2Q4?=
 =?utf-8?B?OTU4MUdNWVk0cnpROTZ6UnRsZ0ZRNUx4SWlnY2Jia29HUVo1RmhWL1NvMUJj?=
 =?utf-8?B?OEFLK0NTTGhqYlpac0kxNDRSZmFiVS9kc0JkRi9JREVJRzAyMzFRWEZUbXFK?=
 =?utf-8?B?Qng0WFVpUHhuYkVmV0ducUk4MGVvUUZ2OGFEd252UElnWldiWFRGN1dENFpG?=
 =?utf-8?B?S3llRjJhelhWTHN1K0lKYmszT1kzS3hJUnROa09GN0dkdjJLWkd4eUpiaFln?=
 =?utf-8?B?bi92Rk9DelBSV05ZVTBjY01WckF6d0ROSnluaHlFaG9DYjZ2a2xPeFBKVXVF?=
 =?utf-8?B?ZXJqcnFsOWpZbnhGZXk5WTFrVk1PQlQ3M2pXZFZaSmpGQmFteHpad1F6YnEr?=
 =?utf-8?B?ZitwWHpvQTZVSjRIUGVyT0FLOFJBdnFwdXdFeTFBdEhyU0JLLzJERS9aVWoy?=
 =?utf-8?B?Mk0wc2tBRkFIZmlqYVRFNExLUVFmQkRpNEFwRW5RTW9oQk8vYmlBRUZFdVQ2?=
 =?utf-8?B?dGRRN3pjOFAzVXQ3akU1RWgxV1B4UyswSjBETTliQXJXS05nTEgxVU9JbSt3?=
 =?utf-8?B?UHhUNDl2S3VxQzdLb0FLeFBPT2gyUFN0bTFrY0xhbEhRakVHc3dTNi9DZE51?=
 =?utf-8?B?R3J6NXQ5a2JuU2JjdHFXRkVTWDZ3MVF6N3BocVBvQm05QlhyTDZvcUZ4eHI3?=
 =?utf-8?B?UWRLYUlPeHVSeFJabXpxZjNWa3RTSjZwZDJCeTIrOXJ2QUtuUGdKVk5FcXc0?=
 =?utf-8?Q?XV0c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08769747-cba9-45d6-47d2-08dca50cefb4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 20:30:16.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ht6rOyTDca03yTcHbb4LR3M4X6USDW5a635Q9ct3JAOoBRP8dGkelDvOLRzRgN2WG5wWmE+uJwlGa7dejWn0FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9253

The pwm in imx8qxp mipi subsystem require one extra '32k' clock. So
increase maxItems for clock and clock-names.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- remove compatible string fsl,imx8qxp-mipi-pwm
---
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
index 04148198e34d0..bc6991bd466e1 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
@@ -51,11 +51,15 @@ properties:
     items:
       - description: SoC PWM ipg clock
       - description: SoC PWM per clock
+      - description: 32k clock
+    minItems: 2
 
   clock-names:
     items:
       - const: ipg
       - const: per
+      - const: 32k
+    minItems: 2
 
   interrupts:
     maxItems: 1

-- 
2.34.1


