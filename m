Return-Path: <linux-pwm+bounces-5888-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2033AB2FA5
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 08:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9C63AB28E
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 06:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87B219E83E;
	Mon, 12 May 2025 06:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="iumBqGKk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011066.outbound.protection.outlook.com [40.107.74.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8845383;
	Mon, 12 May 2025 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747031602; cv=fail; b=MJtdR3sbf1u9M8Fum0O7g6rBl7Ak7l8xPO2RnITq9mahsPvG1JUmt/QcsgLAjQB3QPVI+lmKXEpaOgdUJBihcBctGuhmJN2tdtD+zYgzREV+Y0CLvlyYR33IHxSvoKKnrMjZIOsz22srYQ70pGUQrz6sAeAi2d5bCSa9Rk21cZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747031602; c=relaxed/simple;
	bh=NDaLmpvXiadE51giQsT0/QEyK5YZf8rQQryyotNTHEo=;
	h=Message-ID:To:From:Subject:Content-Type:Date:MIME-Version; b=Fha2Qrod0f9Z9Oc0qi4y/4diz6xQ28N20g5HDVHRHEtu2FhfSjN4xYKzdbScBnz31R8DZJhet0ZtxhBnQB7pE8+yN/+hW2KE6R0pSI3oSbMPJrTmGPf+nUfPpfRl7ow2LIoev1kHoadZrMNoiIHFkfxA4cl+mFakRgJTVtZXlCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=iumBqGKk; arc=fail smtp.client-ip=40.107.74.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajK+AO+g2WNJFlFFgGK6S997EyCMfjEGSNqI/nKVwruOSNAGDCm+zFCsPIMAQvtwxoCtJ2P0c718IFVJ4PeBerKhhXSLk4aSSQRErDHV1Qr+z7hSUfKJ1o4aki+egRav5W/0MI8f2k102eVGF3tYsMcxy37WU37tVg78ky39QV2Db9zoGgGYWbBoXQC70qi/QdNhT+fAN82d2K6dNAc0OQ5cDTYSy9NjlNLEi2mQjcbtm46OfjGsXjGIeZhQomEzqTB0GBnC68Dv0/3iIcTD0sAargTcgx4kTueLX0oyeAEkFiCe8FUVLVcqfQdLbr/C5LkxE5IG7z9FaUocWTLe4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpS+H5mWZ6vVklfrsDakD32KEs9g2KuCDOp8GciE5dk=;
 b=Vj8IePA91sB79E77nks4Qoseb35GuUTNDu/0ay7qoZLAt0GvPHvSFjQL3FVJTq9vorjCfPnB4gz14w6Qe382fejgNnbCA+XuirOiG4Jm8p2OpLyllv/WowIJVGBDpIqG0yDwtMmWITBYXrDWQjo9LF9AD7FTuNC+sqQji/N4YodmkFwL+fOmEEq4OrUH8lyeoQUchRDAXxaDfq/TuTmP5cSJMFvhDV+cokdVsD2lbb2MKzk/44wwjdHS68wgbBPifacnl6eJ0KayaiF2p8NlvPTiLoYXv4tAl196KLFDvlDiGcleA1hfqgxw5s3VI7A7NfDRJxQcAJ0Ffh94wqkaBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpS+H5mWZ6vVklfrsDakD32KEs9g2KuCDOp8GciE5dk=;
 b=iumBqGKkLcFzdOqjwukfqz3hbFK0MrKcDF9H3O27n+WxVPh2GFiT02kLxGcSiin30VqM8PIFH33eW9911rI8XYfUBfYoXp0XvTuJStXLr5O3Zus/4Tm5mNWAc4uWEdr/PFzygYi6jX8ccHW3aHHXP6dK1DnOLYQ9RL2Y2rHw/Sk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB11255.jpnprd01.prod.outlook.com
 (2603:1096:400:3bf::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 06:33:13 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 06:33:13 +0000
Message-ID: <877c2mxrrr.wl-kuninori.morimoto.gx@renesas.com>
To: =?ISO-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= <ukleinek@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Russell King <linux@armlinux.org.uk>, Will
 Deacon <will@kernel.org>, linux-pwm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v4] pwm: tidyup PWM menu for Renesas
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 12 May 2025 06:33:12 +0000
X-ClientProxiedBy: TYCPR01CA0178.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::19) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB11255:EE_
X-MS-Office365-Filtering-Correlation-Id: 9895a777-2f69-4c2e-05fd-08dd911ededc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I95S93s8OB4skcSQ9FPRzvZAohw+wu2IPwP0Yc90x2EWGsryDvdBKezitHPx?=
 =?us-ascii?Q?4Cx/GHqbdxX0Tj1tlplS5DIjUSfdKr4Vb0lUFJVrQDZ70h6CkE3q0kgca1Yc?=
 =?us-ascii?Q?QdXUgqNVDu65KOWxLCVTn0vcLIonybmR4FMhO6IZuaSMU1nNHMo0kzeFhgnR?=
 =?us-ascii?Q?JRxvdFbvADikikcrNKz32cvVqlVIM6nUle+Sb0KNzyBivoZnuGQi8hTcwFCX?=
 =?us-ascii?Q?tgew5c5rjKFYlLtjYV3WaB6ALmxs7JHfCVxaZLxJdKqfO1gsThz/1YDTUOoE?=
 =?us-ascii?Q?omrtacIHsJR5Jo4yBLCd32qKGzWCdk3FGr+lTZ6WULxp3G/4+v8LbsKYZgS9?=
 =?us-ascii?Q?gjs8n4qZfYVQuPV6Cix9YmT0HLH7CX/yBcAcpMYk/VabS0GudVs/5pBNd9qG?=
 =?us-ascii?Q?nYmpkh/2GOtfg18YCw9MBLEMuXBJ+hAGgj0mZ5uj9o9bhWDsvAf/YopZxX0b?=
 =?us-ascii?Q?/waik+JXD2siX71G8vOm5dN1F0yZ2qjCAgEpRN3fNRrrcYRkkoz2d30VAiua?=
 =?us-ascii?Q?P+jz7Fz1DmNHMKWgJnBMyIze7yLxf/ZcHfrubVGTCbl1tY+mUMd3mX/9rBtB?=
 =?us-ascii?Q?wtqoJiOLQtuHIOBS6W+hjiXBBNbSmTWFT7IFmlFIPt2rWJ/z2f0wDCSVrHF+?=
 =?us-ascii?Q?zeu2ua5TW8YHUeLBEnGT88nPXo9nthUDqvxWtqu8Vzb+E56lgn2XLxEavBAo?=
 =?us-ascii?Q?svXWHWwvzrgF9kWswYfTVpGp7kj3X92vjNJ46rRuZ+lupP1uMFagrtHsDBf6?=
 =?us-ascii?Q?b4rvBddB5Wtl0Lz866gYyDCklE6WF5cg9smrYoAkerxTgG5FRJYzdQdPemne?=
 =?us-ascii?Q?8wICHlNHp32i12tZsBSEXbdleAsVuT3kuWggxQMDgDsXUqpzYhlzD4qNXOvG?=
 =?us-ascii?Q?Pt6dBwDxIMd3hnaalX6AF4HwayRHgfybeYzS4nGvo6qTkaGzpWZVVG8wYh97?=
 =?us-ascii?Q?ehZG5G0h3y8+A7D+VqjjhSusGSHXoAxQYqoJHq5YGjiZQ779UTEVg23mXHGf?=
 =?us-ascii?Q?vcFCEprpR2G6lNu1qjloWEFi5XtLAIHGtUAAhhpTqP7vPs8dQWw5LZeAN6Hr?=
 =?us-ascii?Q?tlxROsFaCldJjCpEpbGS+BQG9Wu/M1j+FFQdOP3s7YMm4YqT/qHqts3IZ9Cy?=
 =?us-ascii?Q?inRYPQXhLPPPjYvsdWp0Jj/ymU5tZIs/215rshoJFNGMbCAgJNLjL0GolFhN?=
 =?us-ascii?Q?C8iSsQY8nFdEDI1NTRaGX2oY1w+PsjhRLAPaYTlo/621vBxWTmBrFoKV839q?=
 =?us-ascii?Q?Xft1RapgpUnWV2sA6I2z7SqX1lv76MtDu4pxSXcVf/1Y4kPsy/X8btxiNZYk?=
 =?us-ascii?Q?BbIgEF+NtYrzvSTUIArrQ4wiOm/fTP2A0c7bXe8IYU67iqQ/eCJjPYhWCP2i?=
 =?us-ascii?Q?XfNuBIlrkwzgh0xdOTNCD675khPEUbSbBeMR5OcIbmpXgY0rTk4lZgsQUkJK?=
 =?us-ascii?Q?sjRB67NbOP3RZMnueXVTCaubuxuvyo/XUFlkoL0YjDcUc6mupnlFng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zrBgda1Z/LVc/xjfUTf0/1DLpnYuNx7NR0J7cEemOuv5LBwa39mABJlorZaK?=
 =?us-ascii?Q?lDRUNyyaThLw0vOCRGqAd+/K25s+f7AcCk5BnhTCRLkA2XYIlWz3K5sV2DQd?=
 =?us-ascii?Q?gJlkoHweal8oY6svYhPbmiWoOXqr4TNv7a1Q1DB/GEllzFEfPAOl5E7cMTmB?=
 =?us-ascii?Q?0VvSv//iSqzxN9jPFS6+KvvEPppfQlIKrdN60AqqsfgsaR8YRm54jitZdO/R?=
 =?us-ascii?Q?ECn8E/UFtNl9yILUVl7RNPG4vm1O4DNZZG1uXe8c2gt8uRhbVKzDC0laDNw0?=
 =?us-ascii?Q?jNjWtu7yHKcxkgLnpT57EYXgCXn2EBJSUCdqBT95ez4myM3mI4wbj73X/4Hb?=
 =?us-ascii?Q?D/ObM05N0vNCtLVX+Tif/mS2+tDJlep8BnushOl6WvDHplZ0KqTz2qb76t0P?=
 =?us-ascii?Q?gFhdu97qZcC4y2oXCHObansJ264m0BfWS2Sq8t8L6ZeB0lyjApBvpCDqm6vA?=
 =?us-ascii?Q?jylciJnHVe3m0/zPrGZ5/5w5igUEOto07eQqp8jqSFl4NzROVEnDjyXyvJ3j?=
 =?us-ascii?Q?TdOG7rvskHCwvVdfh0Zs6e8oaEL9WRBFPlUxxtlUMpsQjpRfZMo1Zi4fGZv/?=
 =?us-ascii?Q?bq7+6v8aMIJ9wmRW8o6Nz2pIA7GsEIriSCgOhY3f0q5fiI/qV90peXNYF5eb?=
 =?us-ascii?Q?pi1EqJytimVmL60QpV5mTT7ADE2tV9AR9re187EyqDup5oZNHTucms6F096+?=
 =?us-ascii?Q?eQzOKsgR4eCFIjUtyQWDmn66yUL6npTC+LfFdPNKujY+V9Yjerk9a185CixC?=
 =?us-ascii?Q?tAkN9UPzWzgfOGFXei/5lc8N/FE/7jSaiYoJw0UMgIDKepNCl6VsNNUC4YYg?=
 =?us-ascii?Q?njsKqfYE1mZhpRmgQmCLsle1D54AOi5phYLVq84mWHZ1Jub8TE3j6/EEVv5K?=
 =?us-ascii?Q?Ddyr4FjpUWsGUfId9lbvf/9lNXodQtaET2hMezQrwyUQIZenj66AG9iJScNm?=
 =?us-ascii?Q?LPBuIKdW19G/TPkeZQSFUU1HAA0cnetDN3JicH2ousEOwVWR/WFkGoPjBweG?=
 =?us-ascii?Q?BthByF/odnn65V8zF+9BHhhF894AHnkPoJ9GsRifu49lTnOhFJeLO3SOxgg0?=
 =?us-ascii?Q?FcPLaD8NeCT+ayaPwyH9anDTpqDg+V9bNtHYpZQNZQN4BJ3+zpcIQRfbyRKQ?=
 =?us-ascii?Q?iXiaBYHMo++MdVoNthuDd+4YYoY1F55lfoF8eVB4eNC66RYpcfGYFKJa1gc+?=
 =?us-ascii?Q?4Zo/BpbXY4qNV2v+HVmbEucH2tK77RWGmIehylJA9kH2rG4jDKXr2WT5nD3L?=
 =?us-ascii?Q?0xcYTIvJZC2Ndd+uk7jGI1VQ+ohQiZ0bWLunB4U7k7v2z5MuPldSqGPVQg9J?=
 =?us-ascii?Q?BTVCTySCdv20WIae5BlALge5s/j/vc6qW1YZLmPjw/crv9Dl10H86e64OHB+?=
 =?us-ascii?Q?gq528dm8X7/AdvFzvvAzfk42leHNS1MaOOis7ftelpaj/FinovKe1zDL8beZ?=
 =?us-ascii?Q?QrFuV55iuBU5swn69mBIMvE+W11DLcK68r2JQVFAecZnpaRRoTffBvSF18M7?=
 =?us-ascii?Q?1B2MM9UMcMY2QtySb6We1C6d3I5enG30kKSzXLRQ/Kqm9JN9zbCOlCc8po9C?=
 =?us-ascii?Q?f6+Xr9DovySGu3FtfrJAW1cnNBasXqxiYYMAeGUiOlVikWIYphny1MaEGFby?=
 =?us-ascii?Q?K+YTu49FzKgK2H5kCg0NBuc=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9895a777-2f69-4c2e-05fd-08dd911ededc
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:33:13.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVOKGApzvV/GWQekuC+H0xUeu+SY59gV9NtaKs154UOGI4CFfxmgjE9AvzPdkHZ1SDxBCuMNAJ0mW23Nb1/wtf6hZyyJsJpBaiwoppY/hEagK50dt2PvEg2r24L7EP/z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11255

Because current PWM Kconfig is sorting by symbol name,
it looks strange ordering in menuconfig.

=>	[ ]   Renesas R-Car PWM support
=>	[ ]   Renesas TPU PWM support
	[ ]   Rockchip PWM support
=>	[ ]   Renesas RZ/G2L General PWM Timer support
=>	[ ]   Renesas RZ/G2L MTU3a PWM Timer support

Let's use common CONFIG_PWM_RENESAS_xxx symbol name for Renesas,
and sort it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v3 -> v4
	- Based on linux-next/master

 arch/arm/configs/multi_v7_defconfig |  2 +-
 arch/arm/configs/shmobile_defconfig |  2 +-
 arch/arm64/configs/defconfig        |  6 ++--
 drivers/pwm/Kconfig                 | 44 ++++++++++++++---------------
 drivers/pwm/Makefile                |  6 ++--
 5 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index dc4b722ad4b5..50c170b4619f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1184,7 +1184,7 @@ CONFIG_PWM_BCM2835=y
 CONFIG_PWM_BRCMSTB=m
 CONFIG_PWM_FSL_FTM=m
 CONFIG_PWM_MESON=m
-CONFIG_PWM_RCAR=m
+CONFIG_PWM_RENESAS_RCAR=m
 CONFIG_PWM_RENESAS_TPU=y
 CONFIG_PWM_ROCKCHIP=m
 CONFIG_PWM_SAMSUNG=m
diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 0ea34d5d797c..7c3d6a8f0038 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -203,7 +203,7 @@ CONFIG_RZ_DMAC=y
 CONFIG_IIO=y
 CONFIG_AK8975=y
 CONFIG_PWM=y
-CONFIG_PWM_RCAR=y
+CONFIG_PWM_RENESAS_RCAR=y
 CONFIG_PWM_RENESAS_TPU=y
 CONFIG_PHY_RCAR_GEN2=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d0768584647c..fe021cbb6393 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1536,11 +1536,11 @@ CONFIG_PWM_IMX27=m
 CONFIG_PWM_MESON=m
 CONFIG_PWM_MTK_DISP=m
 CONFIG_PWM_MEDIATEK=m
-CONFIG_PWM_RCAR=m
+CONFIG_PWM_RENESAS_RCAR=m
+CONFIG_PWM_RENESAS_RZG2L_GPT=m
+CONFIG_PWM_RENESAS_RZ_MTU3=m
 CONFIG_PWM_RENESAS_TPU=m
 CONFIG_PWM_ROCKCHIP=y
-CONFIG_PWM_RZG2L_GPT=m
-CONFIG_PWM_RZ_MTU3=m
 CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SL28CPLD=m
 CONFIG_PWM_SUN4I=m
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index c866ed388da9..d9bcd1e8413e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -534,7 +534,7 @@ config PWM_RASPBERRYPI_POE
 	  Enable Raspberry Pi firmware controller PWM bus used to control the
 	  official RPI PoE hat
 
-config PWM_RCAR
+config PWM_RENESAS_RCAR
 	tristate "Renesas R-Car PWM support"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on HAS_IOMEM
@@ -545,26 +545,7 @@ config PWM_RCAR
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-rcar.
 
-config PWM_RENESAS_TPU
-	tristate "Renesas TPU PWM support"
-	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  This driver exposes the Timer Pulse Unit (TPU) PWM controller found
-	  in Renesas chips through the PWM API.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-renesas-tpu.
-
-config PWM_ROCKCHIP
-	tristate "Rockchip PWM support"
-	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Generic PWM framework driver for the PWM controller found on
-	  Rockchip SoCs.
-
-config PWM_RZG2L_GPT
+config PWM_RENESAS_RZG2L_GPT
 	tristate "Renesas RZ/G2L General PWM Timer support"
 	depends on ARCH_RZG2L || COMPILE_TEST
 	depends on HAS_IOMEM
@@ -575,7 +556,7 @@ config PWM_RZG2L_GPT
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-rzg2l-gpt.
 
-config PWM_RZ_MTU3
+config PWM_RENESAS_RZ_MTU3
 	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
 	depends on RZ_MTU3
 	depends on HAS_IOMEM
@@ -586,6 +567,25 @@ config PWM_RZ_MTU3
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-rz-mtu3.
 
+config PWM_RENESAS_TPU
+	tristate "Renesas TPU PWM support"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This driver exposes the Timer Pulse Unit (TPU) PWM controller found
+	  in Renesas chips through the PWM API.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-renesas-tpu.
+
+config PWM_ROCKCHIP
+	tristate "Rockchip PWM support"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Generic PWM framework driver for the PWM controller found on
+	  Rockchip SoCs.
+
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 5c782af8f49b..96160f4257fc 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -48,11 +48,11 @@ obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
 obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+= pwm-raspberrypi-poe.o
-obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
+obj-$(CONFIG_PWM_RENESAS_RCAR)	+= pwm-rcar.o
+obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
+obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
-obj-$(CONFIG_PWM_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
-obj-$(CONFIG_PWM_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
-- 
2.43.0


