Return-Path: <linux-pwm+bounces-2833-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881209331EB
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 21:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE011F253C2
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 19:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4771A2554;
	Tue, 16 Jul 2024 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NEFevBNI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013054.outbound.protection.outlook.com [52.101.67.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1921A2549;
	Tue, 16 Jul 2024 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158148; cv=fail; b=ESSkL1ETPIAtGOXTnnz9YyEu5WlvbD1HUpPgZX/DFrx8K8pC1ua6OAmKqO4TH9p9pY1r7KbaqOHWeY2t9GpMsHDM8DFn26Kygd/Y9BSmrg4xYHNc15du2P87ry3pIo6mQuqUeOwJvmoMl8T7hXsECb8nnvuAd5ldlk1oQohwSYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158148; c=relaxed/simple;
	bh=u6o5ZgVOhIDsk0rsR+s89WrDh8nd57MlF4eGf0tco7s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=t2XzVmT6jiTXVcz+slziEWVXtQtqjv49xCpYSyCnburg63wRomPkguaGnW014iCFkSuhjF0oYLyXiVXucuSg05A1hvnpzYNVAA5fcdLFJLO9QbLmpS5aWX9VVVtkiJ9yX7Ravr66zM+CtJsjlTfumHnPgHcOP68Z1fHMefKEy5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NEFevBNI; arc=fail smtp.client-ip=52.101.67.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4+we141gKYNvczBCXFZbpTa39fGlRyy+3MzdbZCdLxD9CStPUfwdxEzp4pSXOdP5W4VFAW1DLucfaVExmP5AQ0cGVOotLuYdwghWixpEyLYtCWoIBQjjfx4XRN9D4Va3HdkYP2og4O7blr9h2voJ1mmpapEk0M6Jc8wvcY8sSJmGCdoIeJUK2s1rD5+tu5yskNd8QVHZB7balMhz+NV3eDxZ743TEzhEjX2Z4jrIvFB8TF4ZjTrL1qu1nC3VciuntIvHWUx37L80SIZBcHODRGtWoxH6mfZdjgv6GdLz1njErMZmX3gg42WfKjJcAqiJxK+W3E4J68YcjGcWhYK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+w2t/T6iFzLfIMCDVpUfoX1P4V02RfiRLH2a5fsRmGM=;
 b=QoyL873/PKqX5N/DTnWGapUYb7W6z9LB/4vO10g53ITtZDLuXLcRpitld3YJALMBmAhWIbd9GteYrtqlWHzBdO8U3p91mJddkUH//MjrSQn2+XIUOsui3WSOX77Nvx0UKh14D5B0O+wAhYMpiUaO34NUdl9sBqyrFA9rFdzS2p8Z6gspDHWLSxCUj9T+tPxAIFud1WKiUrIRqG43kbgxHB6sC8L3Ekd4+3Q6DDJ51M8KRq2bALmiSaVh213YF4zfJqQG0lcym2giX9savwIhd9+dhFkTlvhNGFyN8M7HNAqQfO+YPQIwq374EBlnktXbzTreb5ibrGSkGonwDCP5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w2t/T6iFzLfIMCDVpUfoX1P4V02RfiRLH2a5fsRmGM=;
 b=NEFevBNI+zbhLgjopx5WkhLpEQaOQAI9uBS2LDZPmmweY4iYWAgMvHLSZf0glKkUy3F3gZVbHdtnROgRSvnN+/PiaZAnq1nSt04QpyFWgGGtTse7VkdMsy9Y1mIMo/Hx6WqaADLumQSRHPiTB6F7MaPSiVxMCLdfDtR5A3O9qUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7325.eurprd04.prod.outlook.com (2603:10a6:800:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 19:29:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 19:29:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 16 Jul 2024 15:28:26 -0400
Subject: [PATCH 3/6] gpio: adp5585-gpio: add adp5585-gpio support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-adi-v1-3-79c0122986e7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721158123; l=6743;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DWKFapoE8P1FSqk1OvDAEQl8OhrCjAiJ3y8kQN6BUkw=;
 b=Gu4DsNZiq6XDAIm8e7HIsiPXLc8qNgVRLwW+bQewKukNoK23sU/6uI3X5HxUSjQJkR+OShj5X
 mEwMIZ+4B16AfephX1ZeWSxAqc30cgK6A4pFL2FUZ+nSbK8nWn1Z25J
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
X-MS-Office365-Filtering-Correlation-Id: 0cd1a394-9e72-45d2-323e-08dca5cd8d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0NJRW9VcDBvbm1EenBVcWVEdkY3YWtWaGhFcDc5Z0c3QnpXdXNVZUtzdlVC?=
 =?utf-8?B?cW1qU2xLd0xJbERGR252TGJBaGhiRnpoZldOaXd0bTBQdytFNFNER3pHSitR?=
 =?utf-8?B?anVkL1UyK1RkQ2ZmajZueUlhckt5L0FldGtGdnNBTWQ4YU4vdWtkUWhaRTBV?=
 =?utf-8?B?aXE0VW1HVjd6b05PeFJDRlVXRHBCb3czVFJqYVdteHN1cFpyelVkR1EycTQx?=
 =?utf-8?B?dzAyeU0vcndDQjdZdHJPSkRTVmhwdkRaVlVxNExBR0NrL21VV0FKSTNiQ1Av?=
 =?utf-8?B?OGg3c3RkMXNlRURKQnNXMktXUEhMOURwTVN0b3FWQ2dZd1l3ZWg2eWNxOTI2?=
 =?utf-8?B?Q3p1c0JDVDNkLzVFNVJRRjdWanRLeVhrdWExVUJ6aTJKWTBqQkFlNTZZcW9n?=
 =?utf-8?B?TmpVSmhZcmUyTVBYM1A0VDBGaDZWTmhENkRKbVUzNExjbldId1NjVUtTeHNK?=
 =?utf-8?B?akp6SndmdDd4LytnSjB0RG05Y1FKOHVHQ1ZXUWs2NGhQcGFjZUZZOG0vWUZJ?=
 =?utf-8?B?aHJqQ3NINGxldmg1cjBjbFFqeXhQZDNwd1cyOXRUNDN2cUd4bkVseWxiOUZV?=
 =?utf-8?B?b3czZ29hVEZLcFlxaUpsV096RXFRWTg2MXI5a3ZvZjlVMmJaWXV4QWJqNmZN?=
 =?utf-8?B?RnBFczhvRTQ1d05GY3NUS2F3K1FaK0U2bzRsVUw2UXZ5RHZxRDc4aUVvOW9U?=
 =?utf-8?B?QWYxWEMyLzFKZDYvdENWcEc4alZ5WVg3YXpTL2J0VHpDSXlKc3hoOHc4czlG?=
 =?utf-8?B?aGJxZEhhaWdOT3A5T3ZPU0EyRmp4VHdXcmRrOU4vWFRVQTJvMWxtL0pRYUE5?=
 =?utf-8?B?YzdMT1NTSG9wNXVZQjJKMGd2NW9kMG8zOUJuTU94eHNjNmtVZkdUVnJYZFhk?=
 =?utf-8?B?ZGU1bVVyKzhiS04zVEdVcjZWYUZFelFLR3BTaXJIV1R0MzVIVndxVHN2VXVn?=
 =?utf-8?B?ditNU0tZdUg0cnByK1dlRmdrSjgreSswRjVtb1huRDlOaGh1eTVvdDlPc3ho?=
 =?utf-8?B?YnZ5eWNpaWZpWit4dHdDOHlGclRtR3dtZkZDaHpFMEtXOUhZN1RMY2xzcUJn?=
 =?utf-8?B?VkROMkJYR0FHRk1kb1huNlhtVlhZZUlpeFA5aUd5ZFUwVGxpeVZBMkRDQUNH?=
 =?utf-8?B?a0FiTms3R0s3OEtMaFVTZTc2L3g4UE1KYzRNdFgvaDZ1RlFOVEVhZGd0TjFE?=
 =?utf-8?B?TDRxUGtvSjdmaWhQek4vK2htdUhQTmF1UXljVUVWM24xTUsxdTEvVGFuSWpW?=
 =?utf-8?B?R1FCZy9oZFlkck9rNzNrTjFTNzhHaUNydVBCWmRxUWY1SUY4akRObXFMOVZV?=
 =?utf-8?B?MTdWNjVnNUJHbTJua1FaSEtXbVp1U3VOS1cxQTBzcmh6dks4VjRiTStHQ00v?=
 =?utf-8?B?YnBtZmJhTmhUeExqMjR2SndUUy9IU0NCUmhUSDM3NCtVVnJuaXh5WTNLSXV3?=
 =?utf-8?B?M2NpOW0zcjloa1pDS2lOMWorK1FYTE9Bby9UamtMZlFEb2V1eE9LNHBxRFhQ?=
 =?utf-8?B?R09jWVB3UXhRQWlyL0IxTmZXdktBRVAycnFrREtxa2pXbXlydVk5UVpnY0JR?=
 =?utf-8?B?UmRvT3ZxTTUzSjdPM3FPZFVYRGxTRjBUdUtCdno3MnFsMDczMFJZNVdXekNt?=
 =?utf-8?B?bG1rM3d5NktVY1pSd2hjMk91cWV2MnQyNnZrVVlkd2dwSGF4emYxYS9JMDF6?=
 =?utf-8?B?QVRDZ3pmd0hrRHVZWENuRFA5VTR1TWR3WG9RRkl6enJDUFJQbUtWZWRTRDBn?=
 =?utf-8?B?YVJ0UEgwK3FWT01yQzNzL1JITjdmeDJTdUxPSkt1M1NuU1ppTE5aVFBlTzFU?=
 =?utf-8?B?L0tVSjRlMVY2QVJGc2l6MEZTbGtJZUhaTThPTmVnTWNVTGxQZHRwMzJNUDFm?=
 =?utf-8?B?bVFENVdSUG9UWkZtTEpnM25iMmtFYjlWZVViRWlrZmZBOFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWw4b3VXdEpWYW93cXdBaDhFSERvMkJCMHdLOFRoWXY1Y2Z1RSthVS9tN1VD?=
 =?utf-8?B?d0NmbndOTjhJbEgvYVhlRWc1SFloK096cFc4RG1ISkdNWWRhR2o2M0lyY2JD?=
 =?utf-8?B?L0NIc0tXN1U0SE9ORW0ycnNQcWpjek9Mazc5QmJ2ZHFJZHlZODhPdnNlWFVE?=
 =?utf-8?B?SGYwM2xlMEorUnZPeW9uVXFVWDdBZk85VksvRmdoeFV4cS9TbTZnT2Zkdjlx?=
 =?utf-8?B?MFR3eUlVUU14RU1JZEw5TUhMelRscXlrK2lpeW5zS1pIM1U2ZEtxckpsQmN4?=
 =?utf-8?B?SEdjMmtlNHR0ckJiN1V6L3BOaUV3aWc1QUJVOHJsM2xtcFd0YXVzSzluenhE?=
 =?utf-8?B?SFFsODUzbkV5Vm5RRzVXZGQ5NFdyR1dsdmNzTW1kRlRMcWhDdTJkSy82QlRW?=
 =?utf-8?B?V1RiWjVtaGZ0OGNpWDgwK3RWaTNBZ1p4ODRUeEUwZnBaVTlJbDlZMHhhbDBB?=
 =?utf-8?B?Q0xaTWM0Rnd2dGxhSnRYV1FjdXhsM1pvVFBFeE9XZGlObG8rWW9Lcnh5OEsz?=
 =?utf-8?B?VTJXRHB2dTladmh0M2wzSEszNGlmNVc5S0xjSnZHUlFNWUhxdFVzclZUbm5H?=
 =?utf-8?B?ZnpJL3U1RmJ4bm5VMjU4VTBEUG1EUkVYYWY4d0xmVHVWVm81Mi9aRUprUVh5?=
 =?utf-8?B?b0JFeUw4RDVHeU9TaEp6eWFNVTQzYlJ2N2tITTQxb0hTNW9TTERoY3l6M3kr?=
 =?utf-8?B?MnUxbW52RmlleXYyenZMUHpKTDZ2SXNyVEFFVmxFeG96MWZWdFc2STBlU3Yv?=
 =?utf-8?B?Q3ptM3pncmY2bjZUYTJDZm01djVBaVJobVR2Z3VrVGZ3YjUycnRDang1Mjhx?=
 =?utf-8?B?V2ZjbUxnenVTVmo0cXZjT28xaCszTG1xcjFCYVk0MFQ2WEV5Y0wrK1dkZStM?=
 =?utf-8?B?Vnk4RVRNNHVHYVVpUnczQWRLdXRMQTJKUE1KeWVVc2xPTk1zei9LYUNjd2dQ?=
 =?utf-8?B?QXdTa24yai9rY3J4Z3I0MVd6bDZ4cnZkY3RmK3Q2NzFPQkJrcGxDQ2tmQk0y?=
 =?utf-8?B?ZmhjQ1NnbTFuOFlHU0tkcERyM3duK2wrZlRjVm1LQ3FHYlRycEZ2WG9Oazli?=
 =?utf-8?B?TTQzTjQ5L2RrYVBBZWNXaS9ybTVPVWFrengvZHh0ZzVwZDBVV09rRnpzVllh?=
 =?utf-8?B?eU1rMEJtTjZKQnRaV1VuTjEwRGkrU2ZHZGI2a0ZMYjRNRG1MUlBNSkEvdExv?=
 =?utf-8?B?NkVVUVM2RHQ3QmYyNlM0NytkSVJ2YUxNWGRNYlVxaG1oV2M2K3FVNTZGQ2l5?=
 =?utf-8?B?WnY0RkdQNzQ0Q0p3MFhhb0J2b0VtWWFIeG5FcFc1M01sMlFUSEY2YW1tU3Ur?=
 =?utf-8?B?a1lGUmFwbWc3czQvWVZyM0o3ekM2cDJ2VkFYYm14bU9VUGJ2TVc1NWJPZWZi?=
 =?utf-8?B?dGJEcmVhbWNOYXRzUENoVDFPM05WK1VXbksvQmoxRHdOcnRYZWZiVXYrTzhV?=
 =?utf-8?B?Y05aaEo4SjI5dy9ObXg3bm9STTE5ZkM3L25iTTB5WG9CZXNDYWJCekRMUWJT?=
 =?utf-8?B?dmd3cnJwcFdnc3dJaThJWmQ5azZQV2I1eFRmdnRrb0x4VnUwVnRYZ1puWTMz?=
 =?utf-8?B?Q1JnV1V6ekxxWFBjTHdld05KeGlxTzExaS82b0hFSW43bENvOEVlYVJndHJ6?=
 =?utf-8?B?bVRIZm5zakVDTFdZT0lVMUV2RG0xK1BVeTdNbHM1N1BqZWs3VjhORjNHZVRW?=
 =?utf-8?B?dW1CTjgycmdxZ1NuUmtKOG5BOGdSWWIrLzBKVXF1MFY5L1Jma2l5bjNZZlhz?=
 =?utf-8?B?RzNqUE5EcmdrRFdTMEVwWDZXUE1EVjc3Y3J3RS9qUEhhVVo3OHRDS2s2b1NI?=
 =?utf-8?B?TTFYSnlrYzVFSVIwMVdaZ2lnNldQZ2hnMndvRXIweExZTVlqZU9NTnpaUVlz?=
 =?utf-8?B?T2NDajc1RHFqWGp1ak01Ym0yWVVOSjVWS3NaUjRSQkV4eU9OWG03UVRJZGRE?=
 =?utf-8?B?WTdQNk9nMHhldGw5Q0dZTjVvekliVXVoMjlIY282cThIOE94b2ppVXNydkVQ?=
 =?utf-8?B?YnArNG14SlMrUkVkcEhwVnpKTUhTeDVlQzJSL1lsb0tubWFQd3A0amlTaGZB?=
 =?utf-8?B?N3YyTUl5YytXcVFXSEVEWWo5UVVvN2FYTHdXMkpEK3NhSHlXdGxZSmdyVTh4?=
 =?utf-8?Q?e/JM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd1a394-9e72-45d2-323e-08dca5cd8d36
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:29:03.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qB6OGAyCPX0NCdsT+lQ4mU3vLqI75Kau7+GIO9/YJtNZT4qXVv23ix9JCIdB2AKMkP1EsAlpJfrQL8z7EAEaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7325

From: Haibo Chen <haibo.chen@nxp.com>

Add gpio function support for MFD adp5585.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/gpio/Kconfig        |   7 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-adp5585.c | 184 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 58f43bcced7c1..20daa3d70abc7 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1233,6 +1233,13 @@ config GPIO_ADP5520
 	  This option enables support for on-chip GPIO found
 	  on Analog Devices ADP5520 PMICs.
 
+config GPIO_ADP5585
+	tristate "GPIO Support for ADP5585"
+	depends on MFD_ADP5585
+	help
+	  This option enables support for on-chip GPIO found on Analog
+	  devices ADP5585.
+
 config GPIO_ALTERA_A10SR
 	tristate "Altera Arria10 System Resource GPIO"
 	depends on MFD_ALTERA_A10SR
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 64dd6d9d730d5..1429e8c0229b9 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_GPIO_74X164)		+= gpio-74x164.o
 obj-$(CONFIG_GPIO_74XX_MMIO)		+= gpio-74xx-mmio.o
 obj-$(CONFIG_GPIO_ADNP)			+= gpio-adnp.o
 obj-$(CONFIG_GPIO_ADP5520)		+= gpio-adp5520.o
+obj-$(CONFIG_GPIO_ADP5585)		+= gpio-adp5585.o
 obj-$(CONFIG_GPIO_AGGREGATOR)		+= gpio-aggregator.o
 obj-$(CONFIG_GPIO_ALTERA_A10SR)		+= gpio-altera-a10sr.o
 obj-$(CONFIG_GPIO_ALTERA)  		+= gpio-altera.o
diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
new file mode 100644
index 0000000000000..7c9edbc16975b
--- /dev/null
+++ b/drivers/gpio/gpio-adp5585.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * GPIO driver for Analog Devices ADP5585 MFD
+ *
+ * Copyright 2024 NXP
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/adp5585.h>
+#include <linux/gpio/driver.h>
+
+#define ADP5585_GPIO_MAX 10
+
+struct adp5585_gpio_dev {
+	struct device *parent;
+	struct gpio_chip gpio_chip;
+	struct mutex lock;
+	u8 dat_out[2];
+	u8 dir[2];
+};
+
+static int adp5585_gpio_reg_read(struct adp5585_gpio_dev *adp5585_gpio, u8 reg, u8 *val)
+{
+	struct adp5585_dev *adp5585 = dev_get_drvdata(adp5585_gpio->parent);
+
+	return adp5585->read_reg(adp5585, reg, val);
+}
+
+static int adp5585_gpio_reg_write(struct adp5585_gpio_dev *adp5585_gpio, u8 reg, u8 val)
+{
+	struct adp5585_dev *adp5585 = dev_get_drvdata(adp5585_gpio->parent);
+
+	return adp5585->write_reg(adp5585, reg, val);
+}
+
+static int adp5585_gpio_get_value(struct gpio_chip *chip, unsigned int off)
+{
+	struct adp5585_gpio_dev *adp5585_gpio;
+	unsigned int bank, bit;
+	u8 val;
+
+	adp5585_gpio = gpiochip_get_data(chip);
+	bank = ADP5585_BANK(off);
+	bit = ADP5585_BIT(off);
+
+	guard(mutex)(&adp5585_gpio->lock);
+
+	/* There are dedicated registers for GPIO IN/OUT. */
+	if (adp5585_gpio->dir[bank] & bit)
+		val = adp5585_gpio->dat_out[bank];
+	else
+		adp5585_gpio_reg_read(adp5585_gpio, ADP5585_GPI_STATUS_A + bank, &val);
+
+	return !!(val & bit);
+}
+
+static void adp5585_gpio_set_value(struct gpio_chip *chip, unsigned int off, int val)
+{
+	struct adp5585_gpio_dev *adp5585_gpio;
+	unsigned int bank, bit;
+
+	adp5585_gpio = gpiochip_get_data(chip);
+	bank = ADP5585_BANK(off);
+	bit = ADP5585_BIT(off);
+
+	guard(mutex)(&adp5585_gpio->lock);
+
+	if (val)
+		adp5585_gpio->dat_out[bank] |= bit;
+	else
+		adp5585_gpio->dat_out[bank] &= ~bit;
+
+	adp5585_gpio_reg_write(adp5585_gpio, ADP5585_GPO_DATA_OUT_A + bank,
+			       adp5585_gpio->dat_out[bank]);
+}
+
+static int adp5585_gpio_direction_input(struct gpio_chip *chip, unsigned int off)
+{
+	struct adp5585_gpio_dev *adp5585_gpio;
+	unsigned int bank, bit;
+	int ret;
+
+	adp5585_gpio = gpiochip_get_data(chip);
+	bank = ADP5585_BANK(off);
+	bit = ADP5585_BIT(off);
+
+	guard(mutex)(&adp5585_gpio->lock);
+
+	adp5585_gpio->dir[bank] &= ~bit;
+	ret = adp5585_gpio_reg_write(adp5585_gpio, ADP5585_GPIO_DIRECTION_A + bank,
+				     adp5585_gpio->dir[bank]);
+	return ret;
+}
+
+static int adp5585_gpio_direction_output(struct gpio_chip *chip, unsigned int off, int val)
+{
+	struct adp5585_gpio_dev *adp5585_gpio;
+	unsigned int bank, bit;
+	int ret;
+
+	adp5585_gpio = gpiochip_get_data(chip);
+	bank = ADP5585_BANK(off);
+	bit = ADP5585_BIT(off);
+
+	guard(mutex)(&adp5585_gpio->lock);
+
+	adp5585_gpio->dir[bank] |= bit;
+
+	if (val)
+		adp5585_gpio->dat_out[bank] |= bit;
+	else
+		adp5585_gpio->dat_out[bank] &= ~bit;
+
+	ret = adp5585_gpio_reg_write(adp5585_gpio, ADP5585_GPO_DATA_OUT_A + bank,
+				     adp5585_gpio->dat_out[bank]);
+	ret |= adp5585_gpio_reg_write(adp5585_gpio, ADP5585_GPIO_DIRECTION_A + bank,
+				      adp5585_gpio->dir[bank]);
+
+	return ret;
+}
+
+static int adp5585_gpio_probe(struct platform_device *pdev)
+{
+	struct adp5585_gpio_dev *adp5585_gpio;
+	struct device *dev = &pdev->dev;
+	struct gpio_chip *gc;
+	int i;
+
+	adp5585_gpio = devm_kzalloc(&pdev->dev, sizeof(struct adp5585_gpio_dev), GFP_KERNEL);
+	if (!adp5585_gpio)
+		return -ENOMEM;
+
+	adp5585_gpio->parent = pdev->dev.parent;
+
+	gc = &adp5585_gpio->gpio_chip;
+	gc->parent = dev;
+	gc->direction_input  = adp5585_gpio_direction_input;
+	gc->direction_output = adp5585_gpio_direction_output;
+	gc->get = adp5585_gpio_get_value;
+	gc->set = adp5585_gpio_set_value;
+	gc->can_sleep = true;
+
+	gc->base = -1;
+	gc->ngpio = ADP5585_GPIO_MAX;
+	gc->label = pdev->name;
+	gc->owner = THIS_MODULE;
+
+	mutex_init(&adp5585_gpio->lock);
+
+	for (i = 0; i < 2; i++) {
+		u8 *dat_out, *dir;
+
+		dat_out = adp5585_gpio->dat_out;
+		dir = adp5585_gpio->dir;
+		adp5585_gpio_reg_read(adp5585_gpio, ADP5585_GPO_DATA_OUT_A + i, dat_out + i);
+		adp5585_gpio_reg_read(adp5585_gpio, ADP5585_GPIO_DIRECTION_A + i, dir + i);
+	}
+
+	return devm_gpiochip_add_data(&pdev->dev, &adp5585_gpio->gpio_chip, adp5585_gpio);
+}
+
+static const struct of_device_id adp5585_of_match[] = {
+	{.compatible = "adp5585-gpio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, adp5585_of_match);
+
+static struct platform_driver adp5585_gpio_driver = {
+	.driver	= {
+		.name	= "adp5585-gpio",
+		.of_match_table = adp5585_of_match,
+	},
+	.probe		= adp5585_gpio_probe,
+};
+
+module_platform_driver(adp5585_gpio_driver);
+
+MODULE_AUTHOR("Haibo Chen <haibo.chen@nxp.com>");
+MODULE_DESCRIPTION("GPIO ADP5585 Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


