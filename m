Return-Path: <linux-pwm+bounces-2821-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A02D931BDB
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 22:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3A61F22A27
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 20:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4101442F0;
	Mon, 15 Jul 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f7oHbCkR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62CC143C6C;
	Mon, 15 Jul 2024 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075430; cv=fail; b=aZb3A107YjxfQj+XsJdvoE4DF3DFQ1Ei1cKEX7VT8+xX+ud4dUh/euRz6Bv3oCNfyfj01eAyr8lWObF9fcwjLXU3UdjoMQgWT8guQyeUpVZ79pzRBMvFdC81cuXzvs4N0sI/rYcryCngTe/7Ko+kb+GIxgxOdxtFpvkjaoY1P44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075430; c=relaxed/simple;
	bh=Io9k/6Chqe/RxeT+6sunyKqWzcFgWqXaDQgBQg3+vMM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GVb/4QP1PHl9Dza6W/vwLQKxoMoXDmpHrLKnN5WpdQMho1zo+sevOXEA3QmNCYgoB9OnvdbvamGyFxc1mlGGYnJzQgbSJRKLcuWfmPhS/3W++LrEBWyV3XvkwaI9FDbYkD4I/Vf61W8MrFoJP/SsCJTofPH40nO/54m1xGUGYlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=f7oHbCkR; arc=fail smtp.client-ip=52.101.70.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swz8MBfOq6o1lSmvHfl1orzhaOWLweivMWKZc9mn2/CjQzpbpwgAGngV/Mm0ZjE5qAJ+rLkzt5YJkH3QHu/HriTL0drC/Kmc9sA57MOXl1eJj/vxblgL+ORk0sMpy6i02NasPJfnZFLz++DwtK3BaKn+ca1MA61OWd4dp3+jZoZG03ETzPinzchC85LQBkoTLGUjPFGI7fPawBcRMnx0P1mUSSlwR5DvOZ5PS5lKSouFmZ7VDeh+8mvAqLLnpNb1DMS4w6x8zNgP4c5zcR2L72dCYgzixWJI/SD3fdfvmPLMVdyWib6UZFO3+e0IcfrVBFCm13eNFG0zt79QL6EIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jjq23hHJmyANEWygqMGhoMyEohbY3TN4P17gWnY6onw=;
 b=T5+E0UC73IGv2w+Hs4ClRrnXf4vwgkpRSIgV5cUdud8Y+Q1lBMTitfdw+RDO5X9nRg3do0yKp4IxcIeVi4nRmHqvt6J2ZSDv9luG2Q3ird2cnTgOwTdg78bKHGSYu8S3TGVD0UTmNeEJoPGIHv5RyEHs2ARHBrF2jPv95g4y8vRdMBedeVboUNx5IR2imTv/ydC4jb2qnf5DG9F/X03Ctw4MfpZLrdDecgQVQizzhaw/ma8CL0Z/KDJS483FCRz4YfevrAThU5iy9MElcq+YfsQ0Snrmp0dlsneWoKjMBCbPv4g995G7cjz2Ok0AzVmNjOd/uHeuaS5V3t9igUqKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jjq23hHJmyANEWygqMGhoMyEohbY3TN4P17gWnY6onw=;
 b=f7oHbCkR4SIjbcBiTw42ln5vBr5BePME3nkJT0ptpAp1iOwcCbx0Tg4A3wSeBz703W2mGfDChmmuBHH9181FdFL81kgnyvW/6x4W3t+eqwaIITa9+ppTuiZGSFT6hwSrwFaoU3Z9b8LtBVbW3SPEYQYKbtUhK9WJTIZDime5MVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9253.eurprd04.prod.outlook.com (2603:10a6:102:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 20:30:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 20:30:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Jul 2024 16:29:52 -0400
Subject: [PATCH v2 3/3] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pwm-v2-3-ff3eece83cbb@nxp.com>
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
 francesco@dolcini.it, Frank Li <Frank.Li@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Jun Li <jun.li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721075406; l=5471;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=2Fx4wXwCrUhiTONLxXSADi3uaxoZ+vACq4nDfpp5ot0=;
 b=DkA4Cq/DwLbRv7Lq8zNAJMA/ORNaYhHBbvql7FyI/3BKsWbbeYyq1iGI8D7aHfcDDhUHuTpX0
 Ywb7pJ1+n3VCXJb7qScGhF+KBbbZUi/VLwNrHOR+du2qZSTXgbUXTOJ
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
X-MS-Office365-Filtering-Correlation-Id: 7e38e6e6-af66-4821-0051-08dca50cf4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUUvWU4vbGpkelZwS284eGg2VnU2VXNDSlJVOUQ5TGFKOGtWNzRlRVY0U1BO?=
 =?utf-8?B?ekVCa0t3OWRwZXQ2R254SUtuRjBFaFJBczl4TkZMdGtxL214QWJaaG82cjM5?=
 =?utf-8?B?L3Z6ZGtWR1V6blZ1N0VFaTVCQUpVZ0lCaUxyM3p4bndTc012SXh4cWxyM0tK?=
 =?utf-8?B?c2NuK0lQQzFDZS80Q3RtdXZHaXF1RkFiUDZRRU11MVQ0M1Zxa2RJaTRDZERY?=
 =?utf-8?B?SVl5UkdQb0FLQndBT1JCZzVXZE9jN3ZmTHl3bldXd0ZIRXVYclptaGVQaXpU?=
 =?utf-8?B?NnEvZGYzblVYUWpHN0J0eWRlYndQM09lWUpOYnBJUkdwVXQ4dlBKVFRubXpY?=
 =?utf-8?B?RDlBbDhaQitrdHBtRWhHQTE0WVlDUEpVMlJNME8rVjRQOEcwK2RVMG9BWDIy?=
 =?utf-8?B?cEZOOEZ5b1JJSFloY0ZjcFJzMjlDbDNjVXJIeGgzVVg3TGhNd1BNSDYyc0JR?=
 =?utf-8?B?b3M5dkZ4dVN5azBHa1ZFK0tBQkJaTThqZGF2VTJDaFBUa0g2TFI5a2lXMFNH?=
 =?utf-8?B?T3AwZmFFQUo1Vk9KUEM1NUZpZzltczdzdytabGNYNk5YNFVtbWsrMytKSTd2?=
 =?utf-8?B?T0UyK0lPOHRWWURkaXFuaHQxemF3YWJGQzRCMDJyUUVRNEhuekcxb01rSE4w?=
 =?utf-8?B?Rkw1QjlsOUFmdnNBTGJmdDB0MXVoUXp0Sys2UzRjR1J1S2dvb1JXR3RuNHZr?=
 =?utf-8?B?ZU5uWnNlREY5aHNla2ZYR00rdkU4QWJQbVZ3WFp4T09BMDl1SDYrUE90SUFy?=
 =?utf-8?B?bTYvMnA5UFp3dlhaZGM1aHphNXVqNmo3ajhrVEwzUGY1cUl1eGoveUxYR1Zl?=
 =?utf-8?B?UkcyQzNyOXlIZGdXU2c5TEhWcUJCemdFYklyMFlycTQ4Qy9pTlVtc0g4VTA3?=
 =?utf-8?B?L3VteDVoODVPc0NETE1iY29xUVBlMTZMMWJRZ3RGdU9hdFVuUnZhL3ZQMUk3?=
 =?utf-8?B?MmNXYVZ2aC9GQU1oK2VJbDRiek9NT3c1aW91Z1V6MVduMGdOeDZMQTdhTkNs?=
 =?utf-8?B?UHU3T1B3cHJRUGpxb25YMmVzaUxCMUxTNnJHakppZno5UFFkb1NoUFdsdGdw?=
 =?utf-8?B?U0IrSFZOWmJzdmZXSCtYNXJsVkhqRW1OU003Y3NYYXZPbFdJTytDMnlPY1Vp?=
 =?utf-8?B?aXFiYmgvTDB2bkZWT3hKam13SlNOVmRqdmNGdmNzK00zeXFsb1RXZjRBR2ow?=
 =?utf-8?B?enBQalNidzlGQWF3aFZPWjAzaGxkbDg1b3FZRktiemMvK2JrZm5FRlM5Nzhq?=
 =?utf-8?B?dUdRQlJYdnR0eEtZSWNFcklVSDZ2YVpUSXNrOEd1ZFYrNldCMFRwOEE3MGhh?=
 =?utf-8?B?ZEZuZitTVSt2THBialM4Nk1ud1pUK0lSOVVKZk16ZHk3aHhYbnJ2bGs4K3d5?=
 =?utf-8?B?OVdESjhIbjh3MGhyWEZXbnRrdVhaMmtyVjNnY3ZDK04yR3J3dkQrcVhxbjg2?=
 =?utf-8?B?MFBpdkNjM0E3MklNWWtJeG94aytKaXcvZ2NlNkZUbHc3Mm1PM05VVWZ5YUpr?=
 =?utf-8?B?WjViVnhXekZVOTVIMVF3TmFteW03K05PK3RsUHNtekY1OFRnRkFRWFRQUXRx?=
 =?utf-8?B?TmtGRjU2OE5wMVZIQ2JiaWZObDJseDB6OHUzRWR5dVZ2ZVVHQ0tzdWFYY012?=
 =?utf-8?B?TE1uWllua0dHNHhwbDB0Z3oyY2ZkUXh0WXptMWhqVnoyWmRDMEMwVnFiYXVm?=
 =?utf-8?B?czFJbUtuU0ZTbFh3dlpPVUl2clJ0cm1aOTdrOXQyNkJGRW9MZXB4S204Zy8v?=
 =?utf-8?B?cUlwZ2hteTBLeUU0eldyNlhTUENZM2x0Mm1iSU5VUmdVUE1KenpLdTJ6QkZq?=
 =?utf-8?Q?3PreaUZ/jxdt3cjeHIolAVVG9fymcC22eg8vw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0owOXh1ZHB6bkw4VUFaRjBWNTZsZ09hbjBCVkw2SVJkT2hDYTIxOUkwZkwx?=
 =?utf-8?B?a0YrZlpCL0FLUDczUzBDVVpMN2tGNmFqRzdDQU1IQ2JiOXJKNDg5WWo0UElT?=
 =?utf-8?B?TWlCNFRUYU9raGFEK1A3aHdTb3dOdlVVcms3Q2VxM3pCV1gyTGJ4eUpkK0JS?=
 =?utf-8?B?cUkrU3c0YzQwaWsxSEVzMUp3cTRFZjVFRjIzL2ZVak9UNVVreWtWZzJYUWZh?=
 =?utf-8?B?SndrWjVrMEJxTFpGMWVYanROVzI4RDNlTUVOZlpTL2U5UFlzN3hZN2l6dUoy?=
 =?utf-8?B?TUgvWUgyQ09Gb2RveFo2UCsrMXk3a1JSaXdma0syNHV2aGFSK2ZEdEFoV2Jz?=
 =?utf-8?B?aUJRNjBOWUV5QzJKYnJsUFhSSEtaUVFTTG5pU3BpejlWWnAxVDRkbFFXOVlu?=
 =?utf-8?B?VWtSQTJPYjMwNVJ5TU8rVWFtUnNvdVowUHlmK3FQeWx5SWsxZUxjVWZzRUpx?=
 =?utf-8?B?OUZRcGV1VFQvZklzT2w4bGpMTXo4MjN3VlhQaW5uZC9NMkFkM3Jjd0NUa3hh?=
 =?utf-8?B?NDFpNnhFN3NSb1B5U2JuK1RQc1hnS1drNWN3MVFsMWhhMTUyTDg3eEZydXd2?=
 =?utf-8?B?KzdoZHg1eHVuUXAwckZkV0ZuWVRSL2ZMN0M0YmtXaGJFblZzMFhoc0d3QjlZ?=
 =?utf-8?B?WXRZUWY2dHg5dnEzYldxUkkwUVdURHNuU2RTajNCVC9ReENKRCtMM2dsR1BQ?=
 =?utf-8?B?cURBL3RvSTRHQVEyOEZjM1V4clAxTDlzcFFsN0pQU1NMbmk3NDBsNVpMb1cz?=
 =?utf-8?B?M2EvMWcrSUM4eDd2SkE3YkIvRTE5TEt2ZTVrVml1MGNJYW1ZWVQ0elMyejg1?=
 =?utf-8?B?Qm9UUDN6T0dVK2dFa2JKMVVwU3krd1ZrTlBtTWJCNVJ1Z2NGMGZTMWJ0dGht?=
 =?utf-8?B?a0pjdEFqalE2N3pkRld1MDZsblN2Rk1ISGV1cTBnRmJkS29hWUVpaFdxbjZz?=
 =?utf-8?B?elpBYmNWUXFJdWZWdXYzRmt5QkpjMlZBWDR1enUwUDhRMTN2Z3FmbzlDT0ds?=
 =?utf-8?B?MGRNNUxXMHF3V3YwOU5URjAxZEx4dlFBMlhRbFVUYW9jakI0RUZHbzB6Zmhq?=
 =?utf-8?B?QXM2YVkvSUFUWW1NbnVicXNFWTUwSkxyb0Q3VDdDUUZ5b2t1K2krK3V6ck5K?=
 =?utf-8?B?TXhwbU5pbUxrT0FUY2hQSytoS1M2aFpESitoV0RvVldUSUdmdGRqemdmdnpP?=
 =?utf-8?B?N1ZVNVJ0cUlUY0FwVU1tbWNseTNXTGpNa2JIWHpPRDdPZ0ZBNWszTW9aRWc1?=
 =?utf-8?B?Y1pwMVh1WDVqQ2lDZ3YvS0M5UWt2aDNrbnh5bDA4dmozeHkrWXRadk5VdUhZ?=
 =?utf-8?B?cysrenUvRnNySWVLM3RYZTFnVWZka05oK1FudjQxNjJTckcrZXE3SExSMHdY?=
 =?utf-8?B?L3pIU0JzSUZZSE5KVlRJWCtnNEc2dHhwYlNBS2xWbE1iTnRwZXdIUk5VYU8r?=
 =?utf-8?B?NXpDODdTck9aaFozZ0VSemd2OElNMFJSRXN0a1JsZ2Z2RHNLSkZ3Z0lYQ2d2?=
 =?utf-8?B?WFlyVzBXaDA4QWpFWEIzMnNwOGk3ZmhwTGdDQmZ6R1NodE9ZaXZHQmFOTzFJ?=
 =?utf-8?B?dCt4TlplK0VFMWZ2K1VkeU1LUy9iU015NlRjU0F2YUNIN1ZxOXlXOWpzSWJP?=
 =?utf-8?B?ZElWYzM5bFY3TmdkUVN6QkJLdW1YUWRLb3dHbXNXdEVEbVlFZEpqNXZPVC9X?=
 =?utf-8?B?aDQzUGdEbTVpanl6a1hRdEpTSkJSVWxibFF4YlRqd2wvSXRhblZxYU5MU1po?=
 =?utf-8?B?RW15Vi9jTzF2aWhvSSs2NDJDektNZG5od3U5NnVrZnl3R1N3ZzJPZnl6OE9O?=
 =?utf-8?B?Y0R2bjk5clFuN24vdTZZTGtCRXRUc1lzdzNPeHROUkE0VzRMcW1PSlQrbnh3?=
 =?utf-8?B?R1lHY2YybWtmSGxMTk1rMTZQc2o5eFRmZHlmSDZMUUpNd1lWZUJxdGhJTnZ0?=
 =?utf-8?B?emxLM2o5WjdaZGNBSXpYQW1ncDR4aVM2dTcyM0t1alZHZmI1VlN1ZnBBcmha?=
 =?utf-8?B?UDhHMDIzTHUyZzg2WFJhdGhnZndOdDZjUmdtRGV0dUR2NzVaZHBJRFhabFhp?=
 =?utf-8?B?N2xTUEJlT09EQmZuNWc3K2Q2MlE0Lyt0THVYeXo5SEpjQUxuRnFtbEJCVEZi?=
 =?utf-8?Q?MjnE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e38e6e6-af66-4821-0051-08dca50cf4df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 20:30:24.7227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ph5i0N4E7n7ByiALahESR+KlS6Otes+TLC5jyUrszfPjbKb7liT1ckUe2nYjunndnWkUvIc6kkkY2m/0B9gnCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9253

From: Clark Wang <xiaoning.wang@nxp.com>

Implement workaround for ERR051198
(https://www.nxp.com/docs/en/errata/IMX8MN_0N14Y.pdf)

PWM output may not function correctly if the FIFO is empty when a new SAR
value is programmed

Description:
  When the PWM FIFO is empty, a new value programmed to the PWM Sample
  register (PWM_PWMSAR) will be directly applied even if the current timer
  period has not expired. If the new SAMPLE value programmed in the
  PWM_PWMSAR register is less than the previous value, and the PWM counter
  register (PWM_PWMCNR) that contains the current COUNT value is greater
  than the new programmed SAMPLE value, the current period will not flip
  the level. This may result in an output pulse with a duty cycle of 100%.

Workaround:
  Program the current SAMPLE value in the PWM_PWMSAR register before
  updating the new duty cycle to the SAMPLE value in the PWM_PWMSAR
  register. This will ensure that the new SAMPLE value is modified during
  a non-empty FIFO, and can be successfully updated after the period
  expires.

Write the old SAR value before updating the new duty cycle to SAR. This
avoids writing the new value into an empty FIFO.

This only resolves the issue when the PWM period is longer than 2us
(or <500KHz) because write register is not quick enough when PWM period is
very short.

Fixes: 166091b1894d ("[ARM] MXC: add pwm driver for i.MX SoCs")
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- address comments in https://lore.kernel.org/linux-pwm/20211221095053.uz4qbnhdqziftymw@pengutronix.de/
  About disable/enable pwm instead of disable/enable irq:
  Some pmw periphal may sensitive to period. Disable/enable pwm will
increase period, althouhg it is okay for most case, such as LED backlight
or FAN speed. But some device such servo may require strict period.

- address comments in https://lore.kernel.org/linux-pwm/d72d1ae5-0378-4bac-8b77-0bb69f55accd@gmx.net/
  Using official errata number
  fix typo 'filp'
  add {} for else

I supposed fixed all previous issues, let me know if I missed one.
---
 drivers/pwm/pwm-imx27.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 253afe94c4776..e12eaaebe3499 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -27,6 +27,7 @@
 #define MX3_PWMSR			0x04    /* PWM Status Register */
 #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
 #define MX3_PWMPR			0x10    /* PWM Period Register */
+#define MX3_PWMCNR			0x14    /* PWM Counter Register */
 
 #define MX3_PWMCR_FWM			GENMASK(27, 26)
 #define MX3_PWMCR_STOPEN		BIT(25)
@@ -232,8 +233,11 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	unsigned long period_cycles, duty_cycles, prescale;
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
+	void __iomem *reg_sar = imx->mmio_base + MX3_PWMSAR;
 	unsigned long long c;
 	unsigned long long clkrate;
+	unsigned long flags;
+	int val;
 	int ret;
 	u32 cr;
 
@@ -274,7 +278,53 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		pwm_imx27_sw_reset(chip);
 	}
 
-	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	/*
+	 * This is a limited workaround. When the SAR FIFO is empty, the new
+	 * write value will be directly applied to SAR even the current period
+	 * is not over.
+	 *
+	 * If the new SAR value is less than the old one, and the counter is
+	 * greater than the new SAR value, the current period will not filp
+	 * the level. This will result in a pulse with a duty cycle of 100%.
+	 * So, writing the current value of the SAR to SAR here before updating
+	 * the new SAR value can avoid this issue.
+	 *
+	 * Add a spin lock and turn off the interrupt to ensure that the
+	 * real-time performance can be guaranteed as much as possible when
+	 * operating the following operations.
+	 *
+	 * 1. Add a threshold of 1.5us. If the time T between the read current
+	 * count value CNR and the end of the cycle is less than 1.5us, wait
+	 * for T to be longer than 1.5us before updating the SAR register.
+	 * This is to avoid the situation that when the first SAR is written,
+	 * the current cycle just ends and the SAR FIFO that just be written
+	 * is emptied again.
+	 *
+	 * 2. Use __raw_writel() to minimize the interval between two writes to
+	 * the SAR register to increase the fastest pwm frequency supported.
+	 *
+	 * When the PWM period is longer than 2us(or <500KHz), this workaround
+	 * can solve this problem.
+	 */
+	val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
+	if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
+		c = clkrate * 1500;
+		do_div(c, NSEC_PER_SEC);
+
+		local_irq_save(flags);
+		if (state->period >= 2000)
+			readl_poll_timeout_atomic(imx->mmio_base + MX3_PWMCNR, val,
+						  period_cycles - val >= c, 0, 10);
+
+		val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
+		if (!val)
+			writel_relaxed(imx->duty_cycle, reg_sar);
+		writel_relaxed(duty_cycles, reg_sar);
+		local_irq_restore(flags);
+	} else {
+		writel_relaxed(duty_cycles, reg_sar);
+	}
+
 	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
 	/*

-- 
2.34.1


