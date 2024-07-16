Return-Path: <linux-pwm+bounces-2832-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DCF9331E6
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 21:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CBC282A2A
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 19:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42D31A0B17;
	Tue, 16 Jul 2024 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DJZENCTW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645461A0AF8;
	Tue, 16 Jul 2024 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158143; cv=fail; b=jQK/YIYxPKgcGzlbNH2OUz28+QHKKpVt+3xKU44E5MsOnT4qSo+E5+pN+bJN9q/B1qdLcEzwBNfHh8DD/U6FKIUGdkJ4c66/DtCLNtCPq1cx2U/sXx+XRQy43psY9SNa2/nepN4U5AuRPxBqMSgesqLmewsGrITpXM2V8KHqhKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158143; c=relaxed/simple;
	bh=tIN866nRYnmFKyNS/7v8vyjqhbmngZVnDLPmy5zmBiU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=O6xjgNP6DA91+xJBn5vpNDa6HeR6rsm6zu9h0Q7WC/qyPievAgLFYYV+StOpL52uN6kf3ctNwo6x3+SkJod1YphYKbGUeB9yNwqDjTBufGHpYBhydENxM08064StSyd8afu9bkMhPaRnJ+uHFtwXmrWgfk+VNnC+OqNKuNK3mwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DJZENCTW; arc=fail smtp.client-ip=52.101.70.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwkSVNHle4llXnqi7KdW1VSi39R+ULX50vH36x0Nizm3bJwweb/Wr/W22gKsbNsDWoPvmHBakUqd4rEpWLdw/wagq6qbogPjviodMlJJMgTsH2vmqAtYHalJ8Bs2ZjpEOEDwqP4PGn+GbrU7L4/tkEEGCjZH8LvgQ0hsfcqOApQwDJNsJd32VSZ2wdZo30B/dPX4BfYHpKnvgpVEvjTCO8+3s0DYHf38Ub0s4LpfDpYkXBuy0Ei+4nNkmrCkVQJ1AUaQNQ9DsljC4+879VecvKt0VhuDSf2QkYxZZjffWl7QzEMimqknQZhlNKZHUdpU8FFqegJEVWcSt2FKB3oHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTm/uWu9I7Njd1rjkCT57wQ/5Tb6Wr1OXZdDFiTUb4A=;
 b=g+YJ2Fw66IIqhS219kmQ5jdB7d9msesUFkmGIEOficSnflkSXVu5o+2C4OGc3mfdcMeFyZzRpQ+Tg/KZfVnndsJV+rHLckt7Rnu9eKKA3yCjHKZhe4C8t0DMgvApbVpsOUJZ3VHfoOZUSHVRKNeNdIX0syh06kI8v1yhaJPsxMwqvJwEAbjCXFOwOsyXC5fMZoKnPzk3W9Zq3VgSMxgF3czNAzgdjXo/KFVC6EJWiqmtuzHeedZthgi0AOdy0YVp3KMLuCtaoL30Ue6YCKpt6dcD0NHG/iGTDU6saC3okNLII5z4eORIRpIBKuYC4uqiEO4NbTr8e6LjLJRI4C7Ixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTm/uWu9I7Njd1rjkCT57wQ/5Tb6Wr1OXZdDFiTUb4A=;
 b=DJZENCTW/gagGk8lQX2Q4rpaY9WRfdl/082b+Mz4X2alAGfDJ5GFM7fbqbfeHzNT2e8LlMCullLivHFGNV3xdKWYACK4l0PHbyrPH7broyEijq1B1V5jhocTcB9lv73ajvXYq3BzHL0TQwpqhAZQmx4cf3TxSK9GF9BVOxaWaPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7325.eurprd04.prod.outlook.com (2603:10a6:800:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 19:28:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 19:28:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 16 Jul 2024 15:28:25 -0400
Subject: [PATCH 2/6] mfd: adp5585: add ADI adp5585 core support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-adi-v1-2-79c0122986e7@nxp.com>
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
 Haibo Chen <haibo.chen@nxp.com>, Jun Li <jun.li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721158123; l=8573;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IgJgFjLtK71g/mE/vm/NQBQ8b9zZWkXeIiGyZdg1VU0=;
 b=MAisj5ry27ICOsujoveLXygl5TIl/VDUYhD4Fq1OYoFJHfjO66z5GqPMFLXs8m9uCM00r0AZ8
 mGCVYoLTsBICIa1/XwqonzB/BDjC/48n6fmN+y6/X9+7M6wAcT2nAnM
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
X-MS-Office365-Filtering-Correlation-Id: 5c13976a-f558-45e6-f1a4-08dca5cd8a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXNxN0VCZVdORjhjSXFrWnJJTzRDbkJpNzRiQUFpWDB4QU5saTM2R3UxYnl6?=
 =?utf-8?B?R2hPa1NUaHJFNmU1ZzIySHNoM3g5SHJLT0hVbmtUa3ZxMGcrTGp0UHZaeU9Y?=
 =?utf-8?B?bXArNHZLUTZnNTZmZ25pVkVyZzNnZFhlbVBSL0dvTVBocWVkY2lFYVJJTXZj?=
 =?utf-8?B?RlhRYkxwSHZ3Znh0cjM5bWNkYU1wMXJjVDFFT01NWnBQZm90WnY0ektxd2ZD?=
 =?utf-8?B?RkU4dlk3d1Y3NE03bE1YZFpyRE5VNTRxL1QxU3Jnd2l6alIwK21KVGZ0QkRn?=
 =?utf-8?B?RzlKenZpdzBZTGxzSXc2MTdBNFNHeWkxdzMxZkxwZ05yNHFnR2xYRENJZkVY?=
 =?utf-8?B?SHYyUHBySWJIN2FYWHNqb1dDL0ZUOWlGckRZV0lGS2ZEQ0lSSzhSY0lRTjJw?=
 =?utf-8?B?dW1paFRVSFJLUjV1S2tIeEtjT05SVzlFRlMwM0lqakdLNXRpV1psQ3c3R2U1?=
 =?utf-8?B?RXJzWlhYK0Vqck8xOUhpSTU4R1BMNnE3dVZSaTIwdmpnQm9namNMT3VmL2lN?=
 =?utf-8?B?VTREaVBNL2FYczdGbXBSanRsVndzOTB4OHp1SXRRZU1reTRBUzFERjltNnJV?=
 =?utf-8?B?dkx0eTZuc0k3Rll4amFZRFRmc2d0VmNmQm5CbEJMYUJqandnU2ZOYmZ1c1VJ?=
 =?utf-8?B?OW05c3FabmNHUHJiTnpxMnNrODMwYnl0ei9EOTlrbkRQQ0ZUN2hQdVl5bEYw?=
 =?utf-8?B?VkxHZERCQWtCMnpmdmJKZTQ0L3V4akxrQTNEZkVnZWZhVnJQNWY5cTA1N1VN?=
 =?utf-8?B?emRLT054NXZZZzJRN3FyVGdGSDluMTlhT01UdS9YWVBhVEMyYkN2MktKbFM5?=
 =?utf-8?B?RDEwbHJoSnExN3ZUL3FHeldFZHVEd1R4akpHTUswV3RBclVVS1pjcGZYZlNH?=
 =?utf-8?B?eXc1bEhVSnh2MGlTVW5wY1lBZnNlMTljT1pRdjJseUxmZmpkdzNrN0xvaXRC?=
 =?utf-8?B?TDc3YlJzVktzQk1vWmVqczRCNEQ5T0tIaWJicmFteVRSbzhLRWlGVmhmUUFu?=
 =?utf-8?B?YTlxQTd6RzNpSGlJZG1kM0t3b2tiTlVFMFdzU3UwR0VrbUMxVDVCc1htT1Fr?=
 =?utf-8?B?dGwxUXA1RE1lZ2xVY1BkNlY3VDBodTRsRTRpQ3BNdnVNeDFPcWY5a20xNXYv?=
 =?utf-8?B?RWxrZjZyamN1NVFML2xlaGQ0cTRMektJeUFudU5FREZEUVRaUVFtNjNNOWpG?=
 =?utf-8?B?OTRXa2E0dUNYNk5XWVFPYlpWdHZKNUhONUNHTVFkVytqQTVDajNQbTVEUzd2?=
 =?utf-8?B?SzNDUkV6S3BlYURWcThlNlNMSmFUWEY2d0tobVBKQ3hKd2JrUnNpNk16bzVx?=
 =?utf-8?B?a2FXRWRRbU9ucVJ0VUZ2TktrWjZnMmVlaEUwOXVXT2pvalBmR3RGVWdoVDN1?=
 =?utf-8?B?SzFzTmJBNm02Y3Z1S1EzczhJNjdhUU8rdUhoVXBzay9EUitMM0NtN1phcXRX?=
 =?utf-8?B?SEtKaXN4SU1PdnZrRkpmZ3QrRDhXczg1UEJTRlUvcTJsSGQxcUZTMU84eUVs?=
 =?utf-8?B?c2xxY0xoMFBoelZQMG1KTCtYalJsY0NjZ0ZoTUk2U3RrNkJpd0Z4alE5STNH?=
 =?utf-8?B?QS8vcUlTOHo2RWIycEpwaGdIdXQ2NWx4NkJWZCtnYmJSYXRMVEVhMWtaRDN0?=
 =?utf-8?B?THlrVlB6SHNZY21Yc1NZUFRXM3BRbUxod3dUSk4zVmM0MTd2V1JGNmpjRUtv?=
 =?utf-8?B?QlZYNml2SWI0NHgrcHpuaFBhV2xPU2gyM3o3NWZpODlveVBIU3VVejlVWkFB?=
 =?utf-8?B?K0RCYjdXRk9ISXBpVWxaUzVhcmxWcUd1Z2laSHR1Z3g1THZxRjdTQTdoOGdF?=
 =?utf-8?B?VHI4ZUwwT0FmQmxWazlSbW1WdlNCOWIwaW1rODNhWDNJVEN5akNHaTArVFpw?=
 =?utf-8?B?R0tuZWR3WGsyQWVMN3NoZ2t0RWtnVE53S1VFaDZIem9pVVNGWmJHRkh0UzdR?=
 =?utf-8?Q?j0+m3kkDSBg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGxmYUIveVVla3Jvemg2TkNVczBWdzIwd3FpVUFxWkVFQnBQcjYrQkUyUllK?=
 =?utf-8?B?WEZvZTNMWkFTSmNGY2lzVzd5M2pMSU1XdmZyS2QrRHg2eTdpTHVGTHZldDJB?=
 =?utf-8?B?Qnh3NVlWa3JiTlpxMkoxdEg2ZVlFWkhvQUVXdTUybDRUSDFqUzlqSWJVOWlI?=
 =?utf-8?B?NUtBcnIySFphOVJ1L2o1b2k4NWx5NFFlMHlsRGlwWThhaWtTcEtqZjJUNUdB?=
 =?utf-8?B?N0w4cysxazJhQjIraC9IQy9XTHNrR1JnOUpTMXJ0NmJaZGNRbThrV1IwWXda?=
 =?utf-8?B?MFlLRzE4TVZnOUozU3Q2VktOT1ZKZll2MUVSQ2YzVFJDOHVWL2hpR0JyMnFx?=
 =?utf-8?B?KzlFblA3NGdRMUxxTjMxb2xjeC9kNzI0b0hKNU1HalAzdHg0VWFJMWsrazJ4?=
 =?utf-8?B?Vk9ELzdINHJDN3JqenROTnV0bFlkMXEzQXErYXZYVUlScjJMV2xZNEFaTzN1?=
 =?utf-8?B?a3VPOHd4UUpMc2t0VFlMTXU3c2VTRnBQV1p3U201NERPRUVuMFYwSEdnWUhE?=
 =?utf-8?B?VlJkY3A5c1AwK2krWnUzcUIxSzcwVGpPNHRTRmRrMCtTOUozS2Nrb3lTYkJH?=
 =?utf-8?B?NGdZZFNuaGx0T21nQXk1aHVmM1VNcXllMjNtakFqMzFTWHUzWVlIVnlXNDhm?=
 =?utf-8?B?MzhMdlpPWDBMRDdzR3lXdG8vcGhZZWgwQVVXMDgvTHNWaTdhNzVTeU9GdnFo?=
 =?utf-8?B?TW9wNHZHMWNqSnI1R0NidGVvc0UxSmZ5STZISFlpUWpNYTFWemJGcjhOczNL?=
 =?utf-8?B?U3NYMFhxTG4vUE11QzBYcDN1cWZ3Z3A3ZWNlanFXbTlFUis3WmNKTDVZV3gz?=
 =?utf-8?B?c2l6MWM1N2ZqYUdpbUNWbit6d2IvbjlwenZyR3dzdS8wVVBKcEpyakk2MWZZ?=
 =?utf-8?B?bGU4UmxZZjBIQ1VOajZFZE9uQ24rVDlONS9TYWVvOVVLYUtDSnEwckpDcVRr?=
 =?utf-8?B?Nm1oSytvOHlxY3V1Z0c4bExPWXZYaWU0dlduMUlRVXJGM3FMZ1lkeWgrZFF6?=
 =?utf-8?B?RURIak1yemExN3BXYmRkR0grN1B1ZFM2ektWSk9KaDExVkU3RnQrbDY5NjZX?=
 =?utf-8?B?Mk1nNUJjV0dmaHY4MlVzd09YaHFLbHY5cWRlUU1rNHIwK2NxeG5kQVhxbHFQ?=
 =?utf-8?B?ZHQzdWhOWGwvTlBkOFczVU9LWU1hNHN2S2s1bXUzQmdHV3R6THNUYXhuSmIv?=
 =?utf-8?B?Y1F4S0pUY1d3Tk82R0RnTXcrcFF0Z1VGazA5Wk0zSHFhcC9RbjkzY3hDOHRB?=
 =?utf-8?B?QnVqRnBjVXNBVXJmS0RJTTVJZFVxTzliWVcvMHhSU053V2FDTUphNlRuVjRm?=
 =?utf-8?B?OG5veUFQMTJaekVtYzNkT0hYd0w5SU56Q0JmeUsxS09yMytiZkNJVkk3aWNY?=
 =?utf-8?B?NjB1SEs2K05iNCt1REx5c0JMTVFsWENnVEJKVDgyR2ZuWHlkeG9Tckt2RzlB?=
 =?utf-8?B?N0VRSk5QcFpRMjJ3UDF5NHFhaTRVQk5qRWhNWVl4RHdMODlvT1BWVFZqdDVO?=
 =?utf-8?B?K2NqL3p2QzU4anRiaDBXRURsNEtvVDZsdUtISmZuUkZnYXFCOWMyZTgyQThV?=
 =?utf-8?B?dGFzRTNOTzY1S1M4aVFyKzdFTkwzd3NncjRoOC9CeUg2a2kvWXNCWDh0dmlM?=
 =?utf-8?B?enhkais1cTdRaGtDUDlwTjJIUkN6WHorbVdKcmk5dll1VGRWWkRudEszak9z?=
 =?utf-8?B?T3hBdVV2Ym4wMmd6d3BZNHVkUkxiUXprck11bGVWRk1tcllHc25DZGxBL1Ew?=
 =?utf-8?B?UjVNSlphN0lxMFQ0d2Y1Y3Y1UE1WTGhJdXA4blh1aHY4MXFkeTlRbldvYzJW?=
 =?utf-8?B?YzJQWlVZc05LZnh5WmFZeGFPN3dqNVZHZnk3RnZMa1hCY2hGeFA3VEhEM01Q?=
 =?utf-8?B?YytZYWw4c25pL20yMWxSSkhWQmFDRWlDY2RPdWdjSDFjL3VZeW8vcmk5Tzd2?=
 =?utf-8?B?STBvV3gzQy9ybDU1ZXpoMmVhU0g2SVJTa21LM0puRy9Wb1hjamlnTklzRUlF?=
 =?utf-8?B?aTQxMWtEeWd5QTVNeWgwQmZyTW5VL0d3UnNXbUpzOXhNRVpiZTBaSk5uSUVM?=
 =?utf-8?B?eFF2YUFVK1RqR3VVR2grRUY2d2k4cXpKWHlZZ2FJQWpIcnl5UDhTanhKY2tw?=
 =?utf-8?Q?TdHMhWfc+VhBS2MF2yHbyQpaj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c13976a-f558-45e6-f1a4-08dca5cd8a3b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:28:58.6992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNhWgtCyY2YqVmoY0T22pI1Ejp6UU6GZltIa9kWcRmn+f+iJw5WODCtdjuhFkf2N9pOPk3yYFEUFzcx63DpuHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7325

From: Haibo Chen <haibo.chen@nxp.com>

ADP5585 support multi function, include expander GPIO, pwm, keypad
controller.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/mfd/Kconfig         |   9 +++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/adp5585.c       | 134 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/adp5585.h | 100 +++++++++++++++++++++++++++++++++
 4 files changed, 244 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index bc8be2e593b6b..62a967ee8ae1c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -20,6 +20,15 @@ config MFD_CS5535
 	  This is the core driver for CS5535/CS5536 MFD functions.  This is
 	  necessary for using the board's GPIO and MFGPT functionality.
 
+config MFD_ADP5585
+	tristate "ADI ADP5585 core functions"
+	select MFD_CORE
+	depends on I2C && OF
+
+	help
+	  This is ADI adp5585 core support, implement the support for
+	  communication through i2c bus.
+
 config MFD_ALTERA_A10SR
 	bool "Altera Arria10 DevKit System Resource chip"
 	depends on ARCH_INTEL_SOCFPGA && SPI_MASTER=y && OF
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 02b651cd75352..2a9f91e81af83 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -193,6 +193,7 @@ obj-$(CONFIG_MFD_DB8500_PRCMU)	+= db8500-prcmu.o
 obj-$(CONFIG_AB8500_CORE)	+= ab8500-core.o ab8500-sysctrl.o
 obj-$(CONFIG_MFD_TIMBERDALE)    += timberdale.o
 obj-$(CONFIG_PMIC_ADP5520)	+= adp5520.o
+obj-$(CONFIG_MFD_ADP5585)	+= adp5585.o
 obj-$(CONFIG_MFD_KEMPLD)	+= kempld-core.o
 obj-$(CONFIG_MFD_INTEL_QUARK_I2C_GPIO)	+= intel_quark_i2c_gpio.o
 obj-$(CONFIG_LPC_SCH)		+= lpc_sch.o
diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
new file mode 100644
index 0000000000000..52cc0d38bf2c3
--- /dev/null
+++ b/drivers/mfd/adp5585.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* ADP5585 IO Expander, Key controller core driver.
+ *
+ * Copyright 2024 NXP
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/adp5585.h>
+
+static const struct mfd_cell adp5585_devs[] = {
+	{
+		.name = "adp5585-gpio",
+		.of_compatible = "adp5585-gpio",
+	},
+	{
+		.name = "adp5585-pwm",
+		.of_compatible = "adp5585-pwm",
+	},
+};
+
+static int adp5585_i2c_read_reg(struct adp5585_dev *adp5585, u8 reg, u8 *val)
+{
+	struct i2c_client *i2c = adp5585->i2c_client;
+	struct i2c_msg xfer[2];
+	int ret;
+
+	/* Write register */
+	xfer[0].addr = i2c->addr;
+	xfer[0].flags = 0;
+	xfer[0].len = 1;
+	xfer[0].buf = &reg;
+
+	/* Read data */
+	xfer[1].addr = i2c->addr;
+	xfer[1].flags = I2C_M_RD;
+	xfer[1].len = 1;
+	xfer[1].buf = val;
+
+	ret = i2c_transfer(i2c->adapter, xfer, 2);
+	if (ret == 2)
+		return 0;
+
+	dev_err(&i2c->dev, "Failed to read reg 0x%02x, ret is %d\n", reg, ret);
+
+	return ret >= 0 ? -EIO : ret;
+}
+
+static int adp5585_i2c_write_reg(struct adp5585_dev *adp5585, u8 reg, u8 val)
+{
+	struct i2c_client *i2c = adp5585->i2c_client;
+	u8 msg[2];
+	int ret;
+
+	msg[0] = reg;
+	msg[1] = val;
+	ret = i2c_master_send(i2c, msg, 2);
+	if (ret == 2)
+		return 0;
+
+	dev_err(&i2c->dev, "Failed to write reg 0x%02x, ret is %d\n", reg, ret);
+
+	return ret >= 0 ? -EIO : ret;
+}
+
+static int adp5585_i2c_probe(struct i2c_client *i2c)
+{
+	struct adp5585_dev *adp;
+	u8 reg;
+	int ret;
+
+	adp = devm_kzalloc(&i2c->dev, sizeof(struct adp5585_dev), GFP_KERNEL);
+	if (!adp)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, adp);
+	adp->dev = &i2c->dev;
+	adp->i2c_client = i2c;
+	adp->read_reg = adp5585_i2c_read_reg;
+	adp->write_reg = adp5585_i2c_write_reg;
+
+	ret = adp5585_i2c_read_reg(adp, ADP5585_ID, &reg);
+	if (ret)
+		return ret;
+
+	return devm_mfd_add_devices(adp->dev, PLATFORM_DEVID_AUTO,
+				    adp5585_devs, ARRAY_SIZE(adp5585_devs),
+				    NULL, 0, NULL);
+}
+
+static const struct i2c_device_id adp5585_i2c_id[] = {
+	{ "adp5585", 0 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(i2c, adp5585_i2c_id);
+
+static const struct of_device_id adp5585_of_match[] = {
+	{.compatible = "adi,adp5585", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, adp5585_of_match);
+
+static struct i2c_driver adp5585_i2c_driver = {
+	.driver = {
+		   .name = "adp5585",
+		   .of_match_table = of_match_ptr(adp5585_of_match),
+	},
+	.probe = adp5585_i2c_probe,
+	.id_table = adp5585_i2c_id,
+};
+
+static int __init adp5585_i2c_init(void)
+{
+	return i2c_add_driver(&adp5585_i2c_driver);
+}
+
+/* init early so consumer devices can complete system boot */
+subsys_initcall(adp5585_i2c_init);
+
+static void __exit adp5585_i2c_exit(void)
+{
+	i2c_del_driver(&adp5585_i2c_driver);
+}
+module_exit(adp5585_i2c_exit);
+
+MODULE_DESCRIPTION("ADP5585 core driver");
+MODULE_AUTHOR("Haibo Chen <haibo.chen@nxp.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
new file mode 100644
index 0000000000000..58a9f84c9a75a
--- /dev/null
+++ b/include/linux/mfd/adp5585.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Analog Devices ADP5585 I/O Expander, keypad controller,
+ * PWM contorller.
+ *
+ * Copyright 2022 NXP
+ */
+
+#ifndef __ADP5585_H_
+#define __ADP5585_H_
+
+#define ADP5585_ID			0x00
+#define ADP5585_INT_STATUS		0x01
+#define ADP5585_STATUS			0x02
+#define ADP5585_FIFO_1			0x03
+#define ADP5585_FIFO_2			0x04
+#define ADP5585_FIFO_3			0x05
+#define ADP5585_FIFO_4			0x06
+#define ADP5585_FIFO_5			0x07
+#define ADP5585_FIFO_6			0x08
+#define ADP5585_FIFO_7			0x09
+#define ADP5585_FIFO_8			0x0A
+#define ADP5585_FIFO_9			0x0B
+#define ADP5585_FIFO_10			0x0C
+#define ADP5585_FIFO_11			0x0D
+#define ADP5585_FIFO_12			0x0E
+#define ADP5585_FIFO_13			0x0F
+#define ADP5585_FIFO_14			0x10
+#define ADP5585_FIFO_15			0x11
+#define ADP5585_FIFO_16			0x12
+#define ADP5585_GPI_INT_STAT_A		0x13
+#define ADP5585_GPI_INT_STAT_B		0x14
+#define ADP5585_GPI_STATUS_A		0x15
+#define ADP5585_GPI_STATUS_B		0x16
+#define ADP5585_RPULL_CONFIG_A		0x17
+#define ADP5585_RPULL_CONFIG_B		0x18
+#define ADP5585_RPULL_CONFIG_C		0x19
+#define ADP5585_RPULL_CONFIG_D		0x1A
+#define ADP5585_GPI_INT_LEVEL_A		0x1B
+#define ADP5585_GPI_INT_LEVEL_B		0x1C
+#define ADP5585_GPI_EVENT_EN_A		0x1D
+#define ADP5585_GPI_EVENT_EN_B		0x1E
+#define ADP5585_GPI_INTERRUPT_EN_A	0x1F
+#define ADP5585_GPI_INTERRUPT_EN_B	0x20
+#define ADP5585_DEBOUNCE_DIS_A		0x21
+#define ADP5585_DEBOUNCE_DIS_B		0x22
+#define ADP5585_GPO_DATA_OUT_A		0x23
+#define ADP5585_GPO_DATA_OUT_B		0x24
+#define ADP5585_GPO_OUT_MODE_A		0x25
+#define ADP5585_GPO_OUT_MODE_B		0x26
+#define ADP5585_GPIO_DIRECTION_A	0x27
+#define ADP5585_GPIO_DIRECTION_B	0x28
+#define ADP5585_RESET1_EVENT_A		0x29
+#define ADP5585_RESET1_EVENT_B		0x2A
+#define ADP5585_RESET1_EVENT_C		0x2B
+#define ADP5585_RESET2_EVENT_A		0x2C
+#define ADP5585_RESET2_EVENT_B		0x2D
+#define ADP5585_RESET_CFG		0x2E
+#define ADP5585_PWM_OFFT_LOW		0x2F
+#define ADP5585_PWM_OFFT_HIGH		0x30
+#define ADP5585_PWM_ONT_LOW		0x31
+#define ADP5585_PWM_ONT_HIGH		0x32
+#define ADP5585_PWM_CFG			0x33
+#define ADP5585_LOGIC_CFG		0x34
+#define ADP5585_LOGIC_FF_CFG		0x35
+#define ADP5585_LOGIC_INT_EVENT_EN	0x36
+#define ADP5585_POLL_PTIME_CFG		0x37
+#define ADP5585_PIN_CONFIG_A		0x38
+#define ADP5585_PIN_CONFIG_B		0x39
+#define ADP5585_PIN_CONFIG_C		0x3A
+#define ADP5585_GENERAL_CFG		0x3B
+#define ADP5585_INT_EN			0x3C
+
+/* ID Register */
+#define ADP5585_DEVICE_ID_MASK	0xF
+#define ADP5585_MAN_ID_MASK	0xF
+#define ADP5585_MAN_ID_SHIFT	4
+#define ADP5585_MAN_ID		0x02
+
+#define ADP5585_PWM_CFG_EN		0x1
+#define ADP5585_PWM_CFG_MODE		0x2
+#define ADP5585_PIN_CONFIG_R3_PWM	0x8
+#define ADP5585_PIN_CONFIG_R3_MASK	0xC
+#define ADP5585_GENERAL_CFG_OSC_EN	0x80
+
+#define ADP5585_REG_MASK		0xFF
+
+#define ADP5585_BANK(offs)		((offs) > 4)
+#define ADP5585_BIT(offs)		((offs) > 4 ? \
+					1u << ((offs) - 5) : 1u << (offs))
+
+struct adp5585_dev {
+	struct device *dev;
+	struct i2c_client *i2c_client;
+
+	int (*read_reg)(struct adp5585_dev *adp5585, u8 reg, u8 *val);
+	int (*write_reg)(struct adp5585_dev *adp5585, u8 reg, u8 val);
+};
+
+#endif

-- 
2.34.1


