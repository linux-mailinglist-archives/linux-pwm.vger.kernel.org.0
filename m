Return-Path: <linux-pwm+bounces-5370-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF654A7F4BD
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 08:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872F117D543
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 06:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670F6261577;
	Tue,  8 Apr 2025 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="b7QW5Pue"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011030.outbound.protection.outlook.com [52.101.125.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B344225F990;
	Tue,  8 Apr 2025 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092565; cv=fail; b=TSV7Ageslu6zi+L5gx28rkvgUzeW98ar9JMcL1sGVXOaFCAJ6anmpM0y/mUcviL88CtbYs9sgly1FmMhvjCvoV/sE7GOC0XxtZRYYwewSR4J6fuvmsgOUouMkb3pGwYnYIcTcF55MNxEokLTHASyOUmuR7v9rDquCF5pViwMW7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092565; c=relaxed/simple;
	bh=NWW5P6faFNan/KG8zHYS4SxpvbC8WOYtAFZxF5ZLJ1c=;
	h=Message-ID:To:From:Subject:Content-Type:Date:MIME-Version; b=nrf/PyzEotZrAanwst9OD7+OBrfvWPa/1GxyMqrbPXJEp8o2JrbTwye/ofhVFGBsabYp9Hq2Ips/h1iseZCIqs2gRkxBody1eNmmmEFk8DAtkeh3ucl1f2pYdRaEvpHIhOyPpD85N2OLg9IuVT6g3rkFI8rWHuvEmlEPzVI9wKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=b7QW5Pue; arc=fail smtp.client-ip=52.101.125.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WT8Pd+afkleYtOOCpsZs+um6Q8Hd0QvMGt867IddBVwFFZxNc0Sx4F5z8UlWJQvl0u+2HBcBInI+km8FNyOXz7hKmEzCH7t95piD7H8lJxRXgSogLVy6BFQCL7svlmYrjUjS9SbOIYITypjvwfbUYe0odPiu6PjlZAPukH6x1D3sz/GZ83qp+8Jwfracw63aGTE6SmWtdU89+6uOeEwJikAUC0C96VK6KjyAr6ZrKsipO3Jmpd4Ovk2PY3GDlwIR89fHhjiPXgTtpDPs09umlNUE055AR/JymG4YwlltIJcAQDNqmDGNRXH8eF281oMYaMObuGMAJV8VQGoHq5IqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75U7SoFY0vQmVElmz/j1fW51fbFeYGfoOzW/1FvhL2E=;
 b=Ls7qg2lCJXsMwL9JGxdxEv6D8tqaf0FpCTcC4hGr0z6t247psra4djI72IoIlfspo53dRT+cki5FB1hAzt8TLAa6lXTG3UhTKq+IgkUad241m3hXOjMZeCruFDF7srxfh0qsr7eeFjcOFeISgP1xT9FTh7QO+8OGNRHmy9g/vBY1JGAKo5KuPIKkpjclMRVdOy+jo8pgCogv+O/Tqfv4YjPQ2HSeLNL4QRJLVRcu2uEb58xBLg8aYq5Bxcsk2SgM2HFindxziRgjTM47NsaZ0x2TRYSDEubK2SNe7bToPG/b5yMm4wnEufU04KmXn2dJyWxC2uCBxqbKhmVNk7U1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75U7SoFY0vQmVElmz/j1fW51fbFeYGfoOzW/1FvhL2E=;
 b=b7QW5PuezrEvOzdXFsNo3WFROnp6z6EFAbAXMatdNAz3nQrRciugneb1HyJnkZSHpkK8ErUPWZcVZXl90m/T2y+xmmEEnaRY4Uf95l0pTNL9EZYtR8g56TmZmlkjb2yXjVLRvMHMx4EpVa5S+sf5JRyl8ve2AoRURHTcNS6f+6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYWPR01MB7257.jpnprd01.prod.outlook.com
 (2603:1096:400:c6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 06:09:16 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 06:09:16 +0000
Message-ID: <877c3vnq0k.wl-kuninori.morimoto.gx@renesas.com>
To: =?ISO-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= <ukleinek@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Laurent Pinchart
 <laurent.pinchart+renesas@ideasonboard.com>, Rob Herring <robh@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] dt-bindings: timer: renesas,tpu: remove DoC
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 8 Apr 2025 06:09:15 +0000
X-ClientProxiedBy: TYCP286CA0286.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::18) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYWPR01MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f08425-2d86-4556-d77c-08dd7663e427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZFsiJG0j0LJkUkmIgzrxdYeGgHdEx3W9ZEzEAZ6g1MVp2u/a7bPAQGT5+zuS?=
 =?us-ascii?Q?8+27NfOMj+jeGRYxEgiV0JKVzbySfCDGt1ShzjnnXFmhlwnuSIRj4FMNnMZw?=
 =?us-ascii?Q?4q7AWam6/G6Djm9kIiVxePNHX/8ylVF0YqhU+pVaZkB5RUemdHRl/UHOf/bw?=
 =?us-ascii?Q?sKlttHK+ZP4CKBb7t5hN8Qnx+Fy892wU6OmcHpghwW3dMgLR6azfdJGswRvO?=
 =?us-ascii?Q?Tww5cxJz32JGuPkjR8GMkiM67hBkma6vbSXbz6h7B2D65rvHjCGCq4CIBX47?=
 =?us-ascii?Q?1FDZcF8kBnTvuPfQg/oE/Jh5dCdvLrNhUl7pixhnRbGvIM5mp2pmcDityGru?=
 =?us-ascii?Q?382XhiJ/KCbNBN2qWNYj2w8vLn1Vy2c1HLE5lIvmoUIC+aRjnGDFfWltoSNK?=
 =?us-ascii?Q?nBH7p+lOeWg1rmHuM5Dxaa2T88y/RzfqPmMo+gIzMCmrv8pTPtftmyXW7ha5?=
 =?us-ascii?Q?w9nkM6cA+r01dnnxfm8veQ8ERzzfZ6YSP4vO4T6D1COCSLe9ilA5AcfgbZC9?=
 =?us-ascii?Q?JAImd/3BqyXrjSRCS0B/4ifBYfKJqz7g82EDGuKmh8pmd+aWsFbkIe0MJFnr?=
 =?us-ascii?Q?GqFRilRxoNS2F8yfZlbo4LHAduodfDucn0xaJUhtMJoBfJUn7Tv9AGpcLAZu?=
 =?us-ascii?Q?WPh4fz53nd0QrjfaxefMfna40on09wq62F++VQEAKwLiLlvnK0SmVrS10WdQ?=
 =?us-ascii?Q?ahGW+inCSdNbXLK+U+A2j+Np3pkTbuv0k1w0sWbfD8w4tc1Wtd1SFHINJ6DT?=
 =?us-ascii?Q?XzQCbFzRHLW7zNHNq6w+PUGsXj3wfdE9uw4KYFk42GU3CLrU4YdK0tF7OztW?=
 =?us-ascii?Q?9wy5urBrnJq0OZnsAfI5FUHTdf/xvmPGeO1wgaCNPC9I9GqlGcuGjxfym4xn?=
 =?us-ascii?Q?OtNmDpvKSrEeLQpLFut1Rw/+y2BjE2AAL93b5/aTY2/mmNnsDwxsnb0YXHvy?=
 =?us-ascii?Q?wjH/c1zoTUWjpnR9UZJh0m48KLMbR0S2c5FYCUhowodkZXVvPLPuTunaNCm2?=
 =?us-ascii?Q?UDH0wZm1DdtMV6bE/Ootn66Oki1PeVYuqrF7q2DDFJvjcUv8TPef/JTiey3P?=
 =?us-ascii?Q?DO6LyeXP6s0KQv0nqTUDSB3mNZRjGqJgdSrkXGBTGoOUUkl7doU/2ACzRsA8?=
 =?us-ascii?Q?G1Uq8cpUGaKGdcpMGHBMkQ5EP2Q+KfZJpCr51ssyYJsyuD3J9v4Uf+wfx8L2?=
 =?us-ascii?Q?yj8c5wnXIRFbA9gW9Rb6l1OEJYDA3KhjliV5hsDmjcZ22wUW53npA45rnd6A?=
 =?us-ascii?Q?kCvJ9POnsZO9r36pbTLWJKkdIgukdiSrGb8Czhv5aHV5AuMbHPIfJJPixbkZ?=
 =?us-ascii?Q?bCdHrIV8Oo/sCHItjP1W+Lfos7jEoDMylmM1l2uWvcMOIUpbjjdw/Cf0N4ZX?=
 =?us-ascii?Q?yZd+4F9kT7u+aS9jr7+8SbzV2bBaO+XUj0ztLYnsfmcHWrgzQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s9oAE8ghgOrKXJxB+f+oYQ9dkvlYkGTEGfgv8AhoUIvVsCrjEazfnU2qL2/Y?=
 =?us-ascii?Q?L6tKLBICMOiHhtcGHhQfMPcwsLUErESOrpr9hW7ShZbj7Eow9iRS7Dfhqm2E?=
 =?us-ascii?Q?OiLmltPzL8pSgYtPVJR04J2oXtl9FKNsnfsfMz83Ve9B4LMre8qUcgO1Xr/5?=
 =?us-ascii?Q?ETTYlBFrK/XM7noWDdg0dF3Q9xuOCyy7ZPPMtRBL7vS/NG+2BoUjhvNrAHHZ?=
 =?us-ascii?Q?N87bDXGO0tsafFXA4AShpYVA+AkX8BtXjIXNBVtpIGUXv0d7RVLKJ3mB/hOY?=
 =?us-ascii?Q?oziW/0LQeKhyYAafBEUy7wREGCTg/Snknv8ezCHUTpy1aOAzf5M2gSx/6c2o?=
 =?us-ascii?Q?ec3ge5/BB8o8qTDLb39VEcaF3lVYxgb6eXLYqr32OcdZfb+o39eyChvn2IlU?=
 =?us-ascii?Q?PLkCWvG2fqGVVnEiyB9lXbdFNG/ynEKVLbk8oft3kvY6NVVDG+c9Vwaq5sIq?=
 =?us-ascii?Q?H5G0OZmCInFT66qClKI1bG1R/LoWL4F4ZdmANLaij6ttaIwDXA68LhWYNuQz?=
 =?us-ascii?Q?aE5VNWnwsiD6mBywFmCCtPfn6KeKe7DAx45wN3WimLyIsvQDRfjV7plurdpf?=
 =?us-ascii?Q?4YY/i8gzeOVYaNMI8EIbl8OlbdCSGiK/t6vG5JpmsG/giDgUU9aYpa1y69Sv?=
 =?us-ascii?Q?l6T1n4lufQ6dY9vTvAQdUhe5AsFae+AigzF3Mi/SqYTe7eCXtPOyuyNxKxIE?=
 =?us-ascii?Q?ZTyHKUVkrkDauZWR7JcNMdF7A+35dnvjidw7bLk+98u441QtuhlAyMiFMmSY?=
 =?us-ascii?Q?Ruh4rYeD6yPe8aFBBP/K/cRl0Q7XsHVkSVyfhFwguXx7jJMlOWl3UmYHJA23?=
 =?us-ascii?Q?tRHlj3Tg0FyB4f3sDSPqYB4V+ByrI16fzfsOMxJUT4fh1nxNDVmEFhU5Y1CY?=
 =?us-ascii?Q?dZz+LVT9WgBjT2Iz869YyidVHsmAVpZro2ceOV4u8hFLp4Gp7MLAqbjC0Vxb?=
 =?us-ascii?Q?Xj1mWBSgodHWGO7FOmO5ihS+u2Fn7IzLU8i+9sEHZLeD1u0x92Qp+rk0VSjb?=
 =?us-ascii?Q?9iAnkyWkEHaZVkxHhvNQNxPYqORN2B6dLmC8UX0JRFfdqqYdZwz1mbJ+EzZG?=
 =?us-ascii?Q?J5xnVeEhqrDR/JeZdNIguavHLqR7u9hJwZZa9SyW6P1WglD5rd249pp12OBe?=
 =?us-ascii?Q?ISDuh1z2/x8aq+HKz5KNc491e128VakknTc3Xep/zg7XODrYms7WvYgwxK4B?=
 =?us-ascii?Q?1ouKXWt/NEYXNbH+WxHd/XP8oxUUD9Lf2IM4LDVrwTQkFAlkPmM6SPAsboHQ?=
 =?us-ascii?Q?wt4+qZitzyVJCdoVlPe5jmgghzmtL2IQywDY64GXvx5w/JmVyomJUnUVkIMj?=
 =?us-ascii?Q?yZch6Ardo/VnyEPoqc81flSKbUZfYU0fBRxwqb47gSF4CtT/swDeeZgWOvCI?=
 =?us-ascii?Q?Svn9KaSkZEUvXugC5L27qorEZMasdlO8oXJ4m15lUlFu7VkKA7SQZT1zVWlX?=
 =?us-ascii?Q?FH1rE/FfMf32iXjoZ2Nk2URNOpx62Cv0E2mRjjpBCGosFZiIXWb76Nh8Ppkr?=
 =?us-ascii?Q?u8dgTZBkXRi8cK3KyncOAjN+MTD2+IltG71xMr5V60Taf/QtAgejpT74/jsO?=
 =?us-ascii?Q?8w0GD1sU+Bsi6C1BBPIqyjY2ZcJL5rwvYWgTQBT8qiDQQ6qDut7QEqBdNiZC?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f08425-2d86-4556-d77c-08dd7663e427
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:09:15.9830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBUz5GClemVlv5jy0GGPfP/+Z7FXy0oW/hP8QKTwk8bYdloR6N8Rbit6V75MQdbhIQlZp23pNKsncM9gODDi1Lx8Vec+OmAheVzE3KlFMroL7Qsfffo6vvjj5W3UYKgO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7257

commit 1c4b5ecb7ea1 ("remove the h8300 architecture") removes Renesas TPU
timer driver. Let's remove its Doc.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/pwm/renesas,tpu-pwm.yaml         |  9 ---
 .../bindings/timer/renesas,tpu.yaml           | 56 -------------------
 2 files changed, 65 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/renesas,tpu.yaml

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index a4dfa09344dd7..f85ee5d20ccbb 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -9,15 +9,6 @@ title: Renesas R-Car Timer Pulse Unit PWM Controller
 maintainers:
   - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
 
-select:
-  properties:
-    compatible:
-      contains:
-        const: renesas,tpu
-  required:
-    - compatible
-    - '#pwm-cells'
-
 properties:
   compatible:
     items:
diff --git a/Documentation/devicetree/bindings/timer/renesas,tpu.yaml b/Documentation/devicetree/bindings/timer/renesas,tpu.yaml
deleted file mode 100644
index 7a473b3027751..0000000000000
--- a/Documentation/devicetree/bindings/timer/renesas,tpu.yaml
+++ /dev/null
@@ -1,56 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/timer/renesas,tpu.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Renesas H8/300 Timer Pulse Unit
-
-maintainers:
-  - Yoshinori Sato <ysato@users.sourceforge.jp>
-
-description:
-  The TPU is a 16bit timer/counter with configurable clock inputs and
-  programmable compare match.
-  This implementation supports only cascade mode.
-
-select:
-  properties:
-    compatible:
-      contains:
-        const: renesas,tpu
-    '#pwm-cells': false
-  required:
-    - compatible
-
-properties:
-  compatible:
-    const: renesas,tpu
-
-  reg:
-    items:
-      - description: First channel
-      - description: Second channel
-
-  clocks:
-    maxItems: 1
-
-  clock-names:
-    const: fck
-
-required:
-  - compatible
-  - reg
-  - clocks
-  - clock-names
-
-additionalProperties: false
-
-examples:
-  - |
-    tpu: tpu@ffffe0 {
-        compatible = "renesas,tpu";
-        reg = <0xffffe0 16>, <0xfffff0 12>;
-        clocks = <&pclk>;
-        clock-names = "fck";
-    };
-- 
2.43.0


