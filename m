Return-Path: <linux-pwm+bounces-2834-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E109331F5
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 21:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58383B2423C
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15721A2C1D;
	Tue, 16 Jul 2024 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fzfDjYz8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BE91A072C;
	Tue, 16 Jul 2024 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158154; cv=fail; b=K/CidBTBH/qjofIdWdU3GfaHhOBLErgk21cnwsxUekTK7Zkoc61Lwh2gsqyi8CqlC/mFYLjxNjywnR33qRUsypqIb3MkHCKBP7B73WsHBVbjUrHcjgwye/vurrmimedtwUpKQK1clb80p8LENKWCk5hYfLqPm1IDhE6Wz8wwB2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158154; c=relaxed/simple;
	bh=po8Ool7o3UM4Uh/jsHpDjST0Gs9nOujmSWm9VP/qA9k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kY2321HXdRb3cSbBYxGk/cYN3FUG+rYfdeI5JSYMDdFxmLYrbEHxUvnpQfUnXAJq2umAQbnjVBvqN09/VQ0A0oetz4IwBfSvcxyFUqN8yKfpB1C0dJeZWSCx4WB1V1ZfrogcfL1uPeAK6lHZF4S9oyCjuDiWBkqENwwNp0q/80M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fzfDjYz8; arc=fail smtp.client-ip=52.101.70.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVtZrR+PtCHAK8iSlGrAk3C6ma7EMDbHpJDHcHzoJOiF/s2p9bCFjDk3bfJX2WEo5T9HJF18+oojjn7uO9LlEwnecbnmMUzMn0G90kE6PkyJPWFN0dLKkXMGrjozU/aRRrxWHS1Sxcae8zoZSPBtEHo2bhYFWHyXcBA2KdTWKIjMixC9LYzqRtl1DCY58DegTB6OHaKFBKWO7diDC/TxanJZgmqcPy4iHOJ+dpL2ts9q/5Oh8/ykA/ZgGSsSCa+mb3+as3jFJ6LkTE0I90gh606QwROALQbYH7pIv9hFcYb2IITNMRLFfoMIRMMjTprKOOkPO75WvLSDkLPFfMrRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=audpQSg28RPcK+jB538LSGRNrGBU1eaNPR6AG8d/TA8=;
 b=oaJ/hECclSPN9PIh8ByyHgP1YfgfsNkhGQyLjwY8ZDfQGGzkZhgHmsBqKkuushUYpE5eFmFWCQNfqcrqy0oObQRLQqCuBJlfIe86ygrwJ+GoCW0hKm8v4A08I+4zmTRJj0okliJcs/0ZBXY6WRj15mPHsiO1JqDRWwpj2/fJtOwpL2717vCI4qyQf0gxjimrANYzBonE0y9OgW6RxHlYq34otdXiJ4Sp5O4P5eehB4YeLjh3SiCNm/jKXgnmsRxjRWgcPoBgDeluR4jpIdLl9nRuEPJ0MieCDgUpPlpXSbuBV8sSw7j3ud58YhPc0hRd0KIPnGPMhL63xf5nRpAVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=audpQSg28RPcK+jB538LSGRNrGBU1eaNPR6AG8d/TA8=;
 b=fzfDjYz8QjQSlIdLTuAuRhJj/5OacXaZiBjbsSDM8U+MMrBtkZ7e32wp2mxuLDN9OlN8f3y4AONHK3mTlUY1dfXOo87fziHtZlqyUI1rB/cJlBprQGKjBqI95P+MXHAC5hziEMuZd+OTqhlimR4z2nfINUCxM4p/kwSGDnmcSI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7325.eurprd04.prod.outlook.com (2603:10a6:800:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 19:29:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 19:29:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 16 Jul 2024 15:28:27 -0400
Subject: [PATCH 4/6] pwm: adp5585: add adp5585 PWM support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-adi-v1-4-79c0122986e7@nxp.com>
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
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Jindong Yue <jindong.yue@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721158123; l=8057;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=EiVtoqMy75CK5ERMMGoJ/yXXvz/dg9oechvT32M0l38=;
 b=1VYa+Ewde+HKap6V5bmlRBVVooCEKmoZmOOrKajOsUzO6feYCNXSKQz9yq/kEfIlGTuEeQl/Y
 wtJgQJ0SDynAYynpwWRoamyZh3jVn3RV9yo7YAfMank6hHzR5GwrzgF
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
X-MS-Office365-Filtering-Correlation-Id: 64b77f8a-08f5-496b-2a73-08dca5cd9096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OG9uaUZaeU9nT2diZmlsVTEraFVHSHlyU3lBU0g0Q2w2Z3FSQ1NkYUJWeTRm?=
 =?utf-8?B?T0JtR1FDQjRBUVJpbTNHS3cwS3pwN1lBYWRBcUVJdkVFKzlnZThOYUgzRWVO?=
 =?utf-8?B?U2xkK2tnZXBVdkk4ZWQ1VDI4YnVCMGd3V2lyS3RYVW04MnNJYXRjZkQ4eUJM?=
 =?utf-8?B?WDV5TlVzTHJiZjB0QjVGblhlR2ZpQlcxMWk1ZEpUVjJyZG4zOVljcHdjWmZP?=
 =?utf-8?B?WVFLd25wQmZRc2s3cEZPOW0zdHcyNUp6OHdkNTNHUjd5NG5PMVM1WlBGbHNm?=
 =?utf-8?B?SkFsSmJYYmpnVFNiQnFaV3J2YTA5WEV1Rm5KTm9DNVZDQnRMK3pPbVpwVVY4?=
 =?utf-8?B?L3lITWo4T21JOXhHcDZOSGVTZWlOVXphNEZQdjFMMU5Nd2NqTnFsN2o0TXV0?=
 =?utf-8?B?eGZyclFhdU1VdkVUWjVGT0V1cmlIRVRQR2FJRmZ3YkNVWTFDcnppTmdtaUNV?=
 =?utf-8?B?ZmsvTzBid2hPRzVYTnE0RndWNzdya0lxQk9tZ1ROWkFBbXpLczh6VGRMWnZu?=
 =?utf-8?B?RUl0VDRnMDlwZE1vMWJYM1JXRXlBM2pHTHQ0cmtHdldUQWl0MWxYR1BJYUdk?=
 =?utf-8?B?V3pjNUZXYm90Q1Y5cjRURWk5WUFURFlHR1lpMkRJcTd6Q0VxR3FPRE5FalFI?=
 =?utf-8?B?cDFWM3VKUUdhUlZ0bDB4WUJYdVNzNnpVMldYTE9DMVNDZ3B0aWNvbC9pNE5L?=
 =?utf-8?B?aWtSakorcTRiUUhzcXFXZnJ1b3JESWRFV1BWaHlyd1BwdG9DUzdFVGVBTXNl?=
 =?utf-8?B?eEMxUmpvZ1lqeHkxVzlEYUl5TFNXUmNWY1M4bnNNQzZSRmVJQ0hhMkZPazVV?=
 =?utf-8?B?Uy9vMUpITzUrNFA2NVJhN2VMZHFGbHBoV1hlQ1lyV0VtYlNtVTdRTVZmakgy?=
 =?utf-8?B?ZG5hUXB0V1gwcllSVzhnOWRQeFVLWisyUklJK0pUKzkvbFVTeHZWNXBBVVVz?=
 =?utf-8?B?UVB0V1NFUURvMm9FeEltYWNhL201L2Q0LzdGZHNQbFdEaGVGNlIybW1KQUc0?=
 =?utf-8?B?YWhpa1lIdnNobkFSSjM2L2ZyVCtWTkQ4VUNSenBaT0Vha1dHUkVEbkUyajg2?=
 =?utf-8?B?aUZpZEtKc1ErNlNvUkpvS0ZzM1BCR2EvRVBENVNpSzVWZUJtR21iL0VxbGhu?=
 =?utf-8?B?aXNDcDlKNkl0MUNhclVLMGdDZ1Nkd2pDYWRaTHFZaEtFVGp4RXFyQ1hJQ2tk?=
 =?utf-8?B?NFJ2TkJGdFp2SnVQUGZXVHZmems0SG0yUW45MHRZeE9FalFQVzhpTkcrekww?=
 =?utf-8?B?Qk9TSEsvUGxDRlVpK1U2L0Z6TTQzSUVZRkl2SWpPeVJJaTdtS0tUNTFvbnR5?=
 =?utf-8?B?QnVwUlFrWGZuWi9IZTJab1hRTDRyRU5FOHh2eW9aNnEwQk5mUGlsWVBSYmFa?=
 =?utf-8?B?eVNhczBmdjF4Lzcza2FNM1J6VHFabENoRHlVbit5NW5xZWYvUHBjemhDcVVP?=
 =?utf-8?B?RUhkRmtxenNJOWhRRVRnRUdCVzVUTW4yRWlQdGlFbEZFYXJCK2FVZlVtSElH?=
 =?utf-8?B?akhBVTZwdUE4SEpGR0M3czQ2N2xuVlJZRWdKNzRpQmVrczR2VWVUVGdFbDFq?=
 =?utf-8?B?ZE12K0pKVGpGTklLZ201NVRXNURIZGpMOFRCZjJsNXMwYlFoTVpIN1gxcFM5?=
 =?utf-8?B?QU80Y1hYbkFBbDM4dFNRSk4xZWlVbzFFUGVtdEs3S3o5WS9BMVo4L3ZQVmZN?=
 =?utf-8?B?WFcyYVJ2Q2tSTGxtWkNJRXRnV0hnbVlIK2FCa0I0WTNsNDE3Y1lCL1RZWnox?=
 =?utf-8?B?ZndwSytZcXI3anV4RXV1dFZrczIwV2JCL2k3RlhTVzdsRDJlcTZqZzNpdGtK?=
 =?utf-8?B?VERjcUw2RWxMVkdKZXZudnFGN2FIcHhmdDlqa0ExdS9VODA2WHBpaVF2RUJF?=
 =?utf-8?B?dTBWNEdEWGM1QzVIOHVYRWxiL2ZsV0R5VEJWRzhuVE5yTHVMcDZwZFloVFBT?=
 =?utf-8?Q?16gaOi9Opno=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3F2YkUrZTdPWHZrNkFGTnlZN2t1VTVFSm8yeVU4NXl0VE1tbjJXRS9zb2N6?=
 =?utf-8?B?YVBLaktDZXY0R0JZaThobGhERjNnVG1iY3pmbWFyQXJ4Z0twY1hGekYyRkF3?=
 =?utf-8?B?YklLenAxSXlVZFBNblZxT3BTMk1lKzRaa3VvTmxZM056UGVrNVN1ZEMzUUE1?=
 =?utf-8?B?Z01xbXFuUE5BM2NFd09sdVFWdHBqU0N0TnRjRlpzZ2tROTlQL3RzZjg1R2pO?=
 =?utf-8?B?bXdGM0UwaWhodjZaUGUzdGlFZGt6S1QzVkEvbUg5Y016UXJnYWkrcktSd2RV?=
 =?utf-8?B?aUNmLys2dTZWVnNtUzZTN3llNFZwWlpUek14KytCY2tZdkt1UVFwdnlsTEJz?=
 =?utf-8?B?aVFuMTcyMllQQUx6TGYzbW4zYWxoZmtKam05Rkh2UnN0Qm9tVjN1cDNxc0t0?=
 =?utf-8?B?N1c0Rk5Xb2lKZFQ4WkpXZ3VWWUpYa2lvamZWQ3QrUjh5WjRIL3RvNklSc0cy?=
 =?utf-8?B?MDAyZzEwckgvbWRkY2dndWxqaEtORmtzdllRcWQ1eEY2bmhacmpxY1QxeFp2?=
 =?utf-8?B?Y0lMYStTVTdlbXFlM1pTMElNY0I4czdFZkVZOWxOYVZBMkdTaVU2ZTd0V1JV?=
 =?utf-8?B?VGFVWkx3V0xlM3NCYytaeHhBV1U3d3FXaSt5d29HeGNQYnNVbWh4OGp0U0ho?=
 =?utf-8?B?MmVVOXViMHNRM1JiSkcwVHByek1zV0ErUlBIblVILzlXckQ0QnpmNGZyQSt0?=
 =?utf-8?B?bVJBb1doNW05VjFDWmlVUUNuZGhZZnQwcXE0THJzU0M1RjYrdUxJRGFkTVYx?=
 =?utf-8?B?ZkdyK1Rjd2IwMGVjYTB6bzlraTB2Rkx2VnZKSTFaWHZteWJLUFU4SHlGT1Vl?=
 =?utf-8?B?ekk5UVBjejZkR05zMEk5Y1B5N1d3cFpYWGE5b2hwU0xLYTY3Q254TTdzTmZl?=
 =?utf-8?B?VHJTMG9ZcHorU3RoZnZSRnAvTXVyVlJXR0ZEcGFvc2Q1cExYQzhUYUxpbmVs?=
 =?utf-8?B?SGJTSUE3VjBjMTBtbUxyaEJJMHZXN1Rmdzk3S1Zxem1FQ1BtRUNNRlVtQmNP?=
 =?utf-8?B?RDJFMW1JOUxBTUdlMEZFajZwSzIyaGlWZ1hiUXl0R2JzYWFXSnZqS2kvRkYw?=
 =?utf-8?B?R2JlS2M5QVB3eXdyYnFTczZ1OGdCVVZaSENsT21rZERiaGZVN0hRNEF3RHE2?=
 =?utf-8?B?QXN6TU1XL2MxVTdNL0c0Z0EvMUJLbDFoV1FsRENhcXFpV0VtR0ZvMUZycnFZ?=
 =?utf-8?B?cC9XYXllRWlEWUVHNFRjYW95OUVkU2RQa00wSVU4eE5saVd0Rkw3SnZuQ3Zn?=
 =?utf-8?B?QVR2VUF2RVJUWlZtZVVoQlhrTFBwZCt1bkNIdEVQblo2c3RUK2YwOERiS3ZZ?=
 =?utf-8?B?MWV3dm5sL0liRXZGWlpPNDNSVFNiVTV3RnBIQ1hvVVVGczl0c3ZKOWhpQ2d1?=
 =?utf-8?B?MjJvVk14OGlVbFk4emdObGJEeFM5Nm1md0JVWVZiS1B1WHE5ejZVOEFxTkRE?=
 =?utf-8?B?ZDcyTFN2cEpySXVTZWZ5dEFNMHFpM2pmMHphZzFhK2laamgzUzl6QmlHQkFq?=
 =?utf-8?B?S1o0OU9xRXpxaHVmU0xCT0ViVjVLc29yeEdYMlZHUnd1TXlBZ0hQMUJodUJ0?=
 =?utf-8?B?SHh1WG5RcFJJSThKbnBKYU8zNjc3aHNka1RUM0pleVlwcitkQnRVcGY2bERm?=
 =?utf-8?B?eEpyRXNPNE10bWtTaE02QmhLVGNPbFd5ZlpRaDdnc1BlNUtIbTZrR2FCVGVo?=
 =?utf-8?B?WldWMzBGQlQ2YmZwckl1ZHBXSERFejJhcWJlaEFJdXFiOXBTcnFkY2RwM3NX?=
 =?utf-8?B?a3pzUUtrWjYxT3BmRjAyQU5vMXJGM3MzUXNKWUZiTGVXYjgwMWhhOWNYcGJm?=
 =?utf-8?B?Z1d6OWhGYUxkMFE0ZGZnTWovbzdQSTQwSTNVMVIxNm0zdU1UMjlpV0pEVDB0?=
 =?utf-8?B?TXJzTnRLYXNxL0NHS055QUhGZ1Y3cFZiSHg3RXVZK083TnZrSll4TXJkWlhN?=
 =?utf-8?B?ODNzeFQ1Nk5majF1b2Fxb0RNcmxGdEMvaTRvMG0vVHFMSUk4YzIwRkFSZHNw?=
 =?utf-8?B?RzU0SXpxYUIrMERBUHVlRHRzWkljRkd1NW5KbkFvdkY1b1loZjErTmNaa2dP?=
 =?utf-8?B?YldObG05RTRsZUVyc09NLzBUOG9wMXpvbjNkeXUva2szYWt3TXEwTzk4UjVz?=
 =?utf-8?Q?ovYU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b77f8a-08f5-496b-2a73-08dca5cd9096
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:29:09.3616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ok7AGpBEwoU+aoFzu/jU65joWEhCwqV1NwzGcCao5HQU9jMWavrp7SxyXISHRQFnmeBybzD05Kbs80QJosC2EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7325

From: Clark Wang <xiaoning.wang@nxp.com>

Add PWM function support for MFD adp5585.

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pwm/Kconfig       |   8 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-adp5585.c | 215 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 3e53838990f5b..baaadf877b9c6 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -38,6 +38,14 @@ config PWM_DEBUG
 	  It is expected to introduce some runtime overhead and diagnostic
 	  output to the kernel log, so only enable while working on a driver.
 
+config PWM_ADP5585
+	tristate "ADP5585 PWM support"
+	depends on MFD_ADP5585
+	help
+	  This option enables support for on-chip PWM found
+	  on Analog Devices ADP5585.
+
+
 config PWM_AB8500
 	tristate "AB8500 PWM support"
 	depends on AB8500_CORE && ARCH_U8500
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0be4f3e6dd432..161131a261e94 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
 obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
+obj-$(CONFIG_PWM_ADP5585)	+= pwm-adp5585.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
new file mode 100644
index 0000000000000..f578d24df5c74
--- /dev/null
+++ b/drivers/pwm/pwm-adp5585.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PWM driver for Analog Devices ADP5585 MFD
+ *
+ * Copyright 2024 NXP
+ */
+
+#include <linux/clk.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/mfd/adp5585.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+
+#define ADP5585_PWM_CHAN_NUM		1
+#define ADP5585_PWM_FASTEST_PERIOD_NS	2000
+#define ADP5585_PWM_SLOWEST_PERIOD_NS	131070000
+
+struct adp5585_pwm_chip {
+	struct device *parent;
+	struct mutex lock;
+	u8 pin_config_val;
+};
+
+static inline struct adp5585_pwm_chip *
+to_adp5585_pwm_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static int adp5585_pwm_reg_read(struct adp5585_pwm_chip *adp5585_pwm, u8 reg, u8 *val)
+{
+	struct adp5585_dev *adp5585  = dev_get_drvdata(adp5585_pwm->parent);
+
+	return adp5585->read_reg(adp5585, reg, val);
+}
+
+static int adp5585_pwm_reg_write(struct adp5585_pwm_chip *adp5585_pwm, u8 reg, u8 val)
+{
+	struct adp5585_dev *adp5585  = dev_get_drvdata(adp5585_pwm->parent);
+
+	return adp5585->write_reg(adp5585, reg, val);
+}
+
+static int pwm_adp5585_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	struct adp5585_pwm_chip *adp5585_pwm = to_adp5585_pwm_chip(chip);
+	u32 on, off;
+	u8 temp;
+
+	/* get period */
+	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_OFFT_LOW, &temp);
+	off = temp;
+	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_OFFT_HIGH, &temp);
+	off |= temp << 8;
+	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_ONT_LOW, &temp);
+	on = temp;
+	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_ONT_HIGH, &temp);
+	on |= temp << 8;
+	state->period = (on + off) * NSEC_PER_USEC;
+
+	state->duty_cycle = on;
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	/* get channel status */
+	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_CFG, &temp);
+	state->enabled = temp & ADP5585_PWM_CFG_EN;
+
+	return 0;
+}
+
+static int pwm_adp5585_apply(struct pwm_chip *chip,
+			     struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct adp5585_pwm_chip *adp5585_pwm = to_adp5585_pwm_chip(chip);
+	u32 on, off;
+	u8 enabled;
+	int ret;
+
+	if (state->period > ADP5585_PWM_SLOWEST_PERIOD_NS ||
+	    state->period < ADP5585_PWM_FASTEST_PERIOD_NS)
+		return -EINVAL;
+
+	guard(mutex)(&adp5585_pwm->lock);
+
+	/* set on/off cycle*/
+	on = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, NSEC_PER_USEC);
+	off = DIV_ROUND_CLOSEST_ULL((state->period - state->duty_cycle), NSEC_PER_USEC);
+
+	ret = adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_OFFT_LOW, off & ADP5585_REG_MASK);
+	if (ret)
+		return ret;
+
+	ret = adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_OFFT_HIGH,
+				    (off >> 8) & ADP5585_REG_MASK);
+	if (ret)
+		return ret;
+
+	ret = adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_ONT_LOW, on & ADP5585_REG_MASK);
+	if (ret)
+		return ret;
+
+	ret = adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_ONT_HIGH,
+				    (on >> 8) & ADP5585_REG_MASK);
+	if (ret)
+		return ret;
+
+	/* enable PWM and set to continuous PWM mode*/
+	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PWM_CFG, &enabled);
+	if (state->enabled)
+		ret = adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_CFG, ADP5585_PWM_CFG_EN);
+	else
+		ret = adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PWM_CFG, 0);
+
+	return ret;
+}
+
+static int pwm_adp5585_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct adp5585_pwm_chip *adp5585_pwm = to_adp5585_pwm_chip(chip);
+	u8 reg_cfg;
+	int ret;
+
+	guard(mutex)(&adp5585_pwm->lock);
+
+	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PIN_CONFIG_C, &adp5585_pwm->pin_config_val);
+	reg_cfg = adp5585_pwm->pin_config_val & ~ADP5585_PIN_CONFIG_R3_MASK;
+	reg_cfg |= ADP5585_PIN_CONFIG_R3_PWM;
+	ret = adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PIN_CONFIG_C, reg_cfg);
+
+	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_GENERAL_CFG, &adp5585_pwm->pin_config_val);
+	reg_cfg |= ADP5585_GENERAL_CFG_OSC_EN;
+	ret = adp5585_pwm_reg_write(adp5585_pwm, ADP5585_GENERAL_CFG, reg_cfg);
+
+	return ret;
+}
+
+static void pwm_adp5585_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct adp5585_pwm_chip *adp5585_pwm = to_adp5585_pwm_chip(chip);
+	u8 reg_cfg;
+
+	guard(mutex)(&adp5585_pwm->lock);
+
+	adp5585_pwm_reg_read(adp5585_pwm, ADP5585_PIN_CONFIG_C, &reg_cfg);
+	reg_cfg &= ~ADP5585_PIN_CONFIG_R3_MASK;
+	reg_cfg |= adp5585_pwm->pin_config_val & ADP5585_PIN_CONFIG_R3_MASK;
+	adp5585_pwm_reg_write(adp5585_pwm, ADP5585_PIN_CONFIG_C, reg_cfg);
+}
+
+static const struct pwm_ops adp5585_pwm_ops = {
+	.request = pwm_adp5585_request,
+	.free = pwm_adp5585_free,
+	.get_state = pwm_adp5585_get_state,
+	.apply = pwm_adp5585_apply,
+};
+
+static int adp5585_pwm_probe(struct platform_device *pdev)
+{
+	struct adp5585_pwm_chip *adp5585_pwm;
+	struct pwm_chip *chip;
+	unsigned int npwm = ADP5585_PWM_CHAN_NUM;
+	int ret;
+
+	chip = devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*adp5585_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	adp5585_pwm = to_adp5585_pwm_chip(chip);
+	adp5585_pwm->parent = pdev->dev.parent;
+
+	platform_set_drvdata(pdev, adp5585_pwm);
+
+	chip->ops = &adp5585_pwm_ops;
+	mutex_init(&adp5585_pwm->lock);
+
+	ret = devm_pwmchip_add(&pdev->dev, chip);
+	if (ret)
+		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
+
+	return ret;
+}
+
+static void adp5585_pwm_remove(struct platform_device *pdev)
+{
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+
+	pwmchip_remove(chip);
+}
+
+static const struct of_device_id adp5585_pwm_of_match[] = {
+	{.compatible = "adp5585-pwm", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, adp5585_pwm_of_match);
+
+static struct platform_driver adp5585_pwm_driver = {
+	.driver	= {
+		.name	= "adp5585-pwm",
+		.of_match_table = adp5585_pwm_of_match,
+	},
+	.probe		= adp5585_pwm_probe,
+	.remove		= adp5585_pwm_remove,
+};
+module_platform_driver(adp5585_pwm_driver);
+
+MODULE_AUTHOR("Xiaoning Wang <xiaoning.wang@nxp.com>");
+MODULE_DESCRIPTION("ADP5585 PWM Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


