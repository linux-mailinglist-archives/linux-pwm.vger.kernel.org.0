Return-Path: <linux-pwm+bounces-6520-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B416AAE7058
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 22:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9124D7A721A
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 20:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1BA2E8885;
	Tue, 24 Jun 2025 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EDKoiyQm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A042550D3;
	Tue, 24 Jun 2025 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750795812; cv=fail; b=IPI87lKpews4fV05PcoTcLuKf12aXj9iJF0J3Q0JcfCU9iZZATVxUDcnAvNqYdKYvEb0SZg+oyHRGUrQWyoP460B8eUM9cswcWhbjaH+pas8ZtA8dLMqSzLrpyDNUl/njf4/s70Pe3OtaSTpkCCyY9+iW9iIPL5UbFoUqZsEhVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750795812; c=relaxed/simple;
	bh=0Y7t6QgHIbGiMlSmWuXCA5Y34t4T95OAjiwudeRflVs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=g0RCYXFQcuW6PmhAmeXpZOUiY46ieCZJ5DC844/xSu9o7AvG34jaZH+agaRcWUywJDRRpXMa0+fXVsHLb/uqdMCy1S195tkgVBU7Sd5Fq2mK5/njJrMFg4d1pY5PPGjDeIVqv7pRp+HzCL7HwfOeWaQvndUXBxePXHZYfNH02x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EDKoiyQm; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bS46REZdwrmKmw6KuU7KgDX1m6U5RFpJK49fze/YgW19/GFKzxYn0fJIkCyGcH+1QzBUQrfkMJUyaqwKnjIhw2g+o5GVSmkxDWw4VGANitxRDvZjoYdvwGGYkdjspx26I94qIuhTdaA5iLpi0/5V+Rd0rrP7gYigfyNYGxgThgRw8NXmKnzo3VcQfSwJ0u66G1ZfdPJ9OZ9wwtrnX6U0sK6PASJ0+CoCKx3G9Bc9E0Tk5z0D293HoTle+S4ZWA7PxyFdPy6/wgnkA+VK96rCEmL15+C7r0/SWgGJwVcqfzZ9ogH+EFfiKcxsHaciqlMjxphDDl6mzAr7Qhpzs7vlDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvarJm+IQm0017z7PxVoVO5mWJUrC/RzOnRjXq2QodQ=;
 b=Z5OH1bWzD8EZxjMZrurBRVb5ZzrVrAy7hPMTqufvT/D7XtK4K0ruyarfo5h+108z0pqG7twZ7GyYqt5PV2eggJ22QNDPQDNywGRJt1W3Ru4JXTRvAeMiFI12lniZoHEeYD5+FfThvJf5rLmpAFqgEclP2DEVT+UOmCN0O5tSSvgMt7is34y3mu/UGKJhhhTikM01lMNAi/3UgPakhyHGIoBqeYK5d3df19Lf7asGomhkyFPQf1woBLAsSm4wfC0KgH+5w0gxUqR6rjD/xrFcq7KYbyvHD8ewcoAVgmj63IhI/WSxK4VzKw6ZgdZY+O7/HnvnqUGbzU0H1ZQuG5QPZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvarJm+IQm0017z7PxVoVO5mWJUrC/RzOnRjXq2QodQ=;
 b=EDKoiyQmuUYswtc1f6SnMN+wt35Edc5YKXhSThoH47CYJi3UVDGL5H3Xz0ha5+O0V8dzgnyiMRGtJ/UKqBoaJXC91HWh/8eXgbKiHC0Yo5pYeBkeZPACnnwvY/Fhpt4ZyQCbuxubodGCmM/MB8zg+MuOYsFyCHxd1xClFfDDw4wFFB1VQTCZPsveMBikFBTs1VIwKPf/6h0Url6wNvB05mL7AuCluJOm4q85muqTle1bgJ3C12IMWKd22S90AD6ajuxQqvhvzuB9NfCRFL0hEnbM8vlmlhoW3b2CAnqfumDiSkmdarT9vA1OREO1ag3HfrLC2Jr31CE1GSz/docIIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11458.eurprd04.prod.outlook.com (2603:10a6:10:5d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 20:10:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 20:10:05 +0000
From: Frank Li <Frank.Li@nxp.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/LPC32XX SOC SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: pwm: convert lpc32xx-pwm.txt to yaml format
Date: Tue, 24 Jun 2025 16:09:54 -0400
Message-Id: <20250624200955.2514896-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0006.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11458:EE_
X-MS-Office365-Filtering-Correlation-Id: fd70f6eb-7860-4b8d-5ad5-08ddb35b1c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dGzvVOEBt0TgAXEWMZVqHb4JLz+9MhEjAXsWn2tg5UzKTXYBjB4yMzZ/csoC?=
 =?us-ascii?Q?cC0A5Qo54g5SpM8av1RQufbF/Z1sAzQFsoQqSS8RjYg6Ks9M2iofjSUoYw84?=
 =?us-ascii?Q?LPYdn920Orq0fo2GGR/I112M2W4TFv7sj8znXVPvyAo4W5SLow5XrqP282t+?=
 =?us-ascii?Q?DTrNHFTS+L+F7l6Ld0Yi2heOSg/Lw8eImymxasRB8rFL0aV43HIlnK1WTR6g?=
 =?us-ascii?Q?OkIorCLp0VMasEsoTC1POFBQDpCZSY++YGc3yB6iZ/LZTUaJIpwG1hWxlHb/?=
 =?us-ascii?Q?vpDdguexlJvDej+ZoInhqxkX7Is1kT7sSvf7BpIVTI6w7zC83Ez6puTCC6VF?=
 =?us-ascii?Q?juDfgSxT+0POtCCkbNp0lqSSFl3KXV4L4VlkMtLgYAC5TsVy3O3+KveO4B+r?=
 =?us-ascii?Q?UmppNNYNbsU5SQPsBkxrsGI3p5rAwqaO2LjNlK1KVZPgrVxvhMHva5Hfdcfw?=
 =?us-ascii?Q?lGUg6bMSN4Dagz34Fu2T2dRURoYiRMBC7Cu1PpOiH6VFnmV5pvhpM2+3h84y?=
 =?us-ascii?Q?4RpibYQtBtsPAFUPzCFaTGP+PXn0csS8MixN1unBQNnuKPWBa8LNcAxf/Q91?=
 =?us-ascii?Q?JjZA2NpAZF+JBsMbb3GKzc/3Kz+CaNd7AS06nUrK2AuXy46KoncCIPu/Ho+Q?=
 =?us-ascii?Q?MRA8CcBP4Q7cVk6SUFscUm2pCNuh0nl2a5U4ZjLwZ2lCgXQ5zBAU65Lu49kz?=
 =?us-ascii?Q?APxRxbqm+VaKGpeeLgr8MQxF+RmBUPEI6SXM7gTRqdkPGaqIIdgqFMuCDR/b?=
 =?us-ascii?Q?hvpmSlr+cCOTQsI1zhg2xp2PX0H1xwIK/UfS087htTyUrVBnxRUuTAKfGLKh?=
 =?us-ascii?Q?rx9GPRCTE7Bs1ngLu0iciB7D90x6tw/YXbXqyBm8JXGc9kUePKCChxTTPaIg?=
 =?us-ascii?Q?BArntd4PTGtXjlrXFHjPj7QvTF52eCrYbYKy11V396/SgXt0e/5L0Shv0iDj?=
 =?us-ascii?Q?aCpzgK8q4OimwSkHh8xGcA44S+JcrL13t4L3WWyGNW+wPJKLymFFQSjsuOid?=
 =?us-ascii?Q?7OiY8qO8UAMwQ2djzQ+JeX23Py6JmPQSvoKIIIghOgdgVcmma3MaOdPMTpZZ?=
 =?us-ascii?Q?0+N5trDbdxjkR09ghG0Z4llTmf7bXigNjkVud0K6/62YTwwfJwVYUjoP9Mt6?=
 =?us-ascii?Q?qCw5SaQ7kzoSg6FNhn01DeDaPvylF6l9g93qFaeGiEqT/G71HoQ4cIOEA7yR?=
 =?us-ascii?Q?TKGlOSsOZYVyke/FMJGfgM592DmgzFhYYkuoXFn9iMSr7SkBZmN+MEC9uf0t?=
 =?us-ascii?Q?CwKwg7bEQ1FeebjAers9KPnoptllq8a37tvo6/s5Cq6I8QlToCtO76x9CvBw?=
 =?us-ascii?Q?tIABryNhg4LLtD9ub5E7e9zT3uLUYrW4gyowaPCNbvZdGUBBWBHBFrQ4Jihx?=
 =?us-ascii?Q?TpgfRb7ViLrokCerUReI3tpMU+LMvngU9vczoBKidkiGZuPpPQifAFZMxZli?=
 =?us-ascii?Q?26fGxbEOM89YY0cuBlQxSfPA0ABJ7c6FkQgDx5/TNjwEcowLYjhJmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zBiottPwssTSezjjjMHQ43zfU2iCEmPlpRZyTeFLhjbHrN7Kyhw81j5wAD2W?=
 =?us-ascii?Q?OgQ0x9dR9lVI3r30WHzLESZUS28kmIf8LWsquz7j7A0r11foeCgUhOjMQy20?=
 =?us-ascii?Q?r2tMA2bbP1bpx0V9L0i/kOm6bF9zEuH+W8h6vO371m+ff0FjFgC4hJfUXtX7?=
 =?us-ascii?Q?N/zIEpXj1kwFah3yPcSfWXfSfChHjJ5xdWuoFPZ4XgcpGMT/JKvcfgLDxa4L?=
 =?us-ascii?Q?8edUejCbc+NKcXTXtO2dmPCQRjYxgZx73m+INqObBoS5/bd6WXihY204Xiqv?=
 =?us-ascii?Q?v6ikunoJbCApuBU542+Pytq1mu/KP47y5rx/zNDjetbv+bfkyC8HFRRf2YAu?=
 =?us-ascii?Q?g9VLq/anJkREk1n4y/VNEXPq/TpxjEHNq5eJzRNhNxAGtvFgZuwtCdK4/Cwi?=
 =?us-ascii?Q?Pf7TXHx7uvTUnaNuFlSs/j0juLw4gdyUpXT6TcdofmboIFnyafuLpSTZWuqz?=
 =?us-ascii?Q?gvjgyUIaanBHFkEyQixhFVwlylC3G3gO/HmVtYjiBviKbCum/ESek4Z7U+8C?=
 =?us-ascii?Q?mOJN7Jl9PLToZP76qap46XpBzCPMapSTfMY/cJx0IAOqlyKMCXSPSrrpLneZ?=
 =?us-ascii?Q?uKZ9nbOtriJ8fFDF0BWKH+B6pXHKkNPZFLllo98ueqx55eEpG7AyLbI4C2qc?=
 =?us-ascii?Q?btIdk9EQ5cRzCdfeBEPTb+/KdfPmw/NJVV5AhM1hM/p8FzsHBHXljPtMKeLE?=
 =?us-ascii?Q?68xpbuUdHVIAumMFh2nk1SAHK1Khqf0QtJrnobIfmIXvLUP9hPCouK0k+VSH?=
 =?us-ascii?Q?zeUZM63pkYQNyoyKfLuoz/9evxXo1jQYnnokUNWAn0tcKlj07+xMHAnjwP5w?=
 =?us-ascii?Q?YjICdOSNCQ26eTiYG/5NtfMnt28iQ7yfrwYCcJWqTNHe8/djxURxUDE6obK6?=
 =?us-ascii?Q?mQibT9lbmbnnVeTJKSoi5KsYh+SnZyPHtVTUdKsPVYdLfcQm5VwqvwU5u2gT?=
 =?us-ascii?Q?utvlkY4ttCx4f4ekz3/OoyY1KvmMQ9CKFPaPDu9TrLyp6F8HcMd1lMNE+BJf?=
 =?us-ascii?Q?CgAbbBbLAywJD0jOpBwZlV1kqWgEZin8bdjIlFksYHU0JqwIE83vSae5GADP?=
 =?us-ascii?Q?ZJuoQkAj5pJAyiu0NC/TH0LWxjVgHV8ulDzKx/6h4bHV5grPlKDgDJTTbNdK?=
 =?us-ascii?Q?ROrjpUvb8ib4UDy5S5F7XORry7A2emQvNr0RlWuiw1Xveig51Jq61NWCsc/X?=
 =?us-ascii?Q?xMNwXfVJqLT8jObKKq57ulDWyuXqHkR30YBFprkP/4QBsMI+PV+cXqN4zxX5?=
 =?us-ascii?Q?yS8u0l4ZyQQqz7ixp04skPsWJp5PHgp5h66rKzMgz6k0AwX45wE1sIdqd+3i?=
 =?us-ascii?Q?dSovVoGqAktszB71gW1of5fGaQ6xjtwCwolJfcoRNws0XnOhzVv+F8WHcydP?=
 =?us-ascii?Q?ym4r+ae2+n2umIoDkuPrQUyamafY82rfydbQLF9I9Z+kDC/vnoHucYKou/rB?=
 =?us-ascii?Q?7fe7u5DnaVZsMOCmEa8NjDzcaGpKK0JJLr8XctAwphzLKN+lxqxJvxtGRlxU?=
 =?us-ascii?Q?5sSN9vqBIhT1vDdiBepNNyGkkWRLRf2GNEsSRsV3xuyZpxrqCXioihPX4gfg?=
 =?us-ascii?Q?B+jhXmSAeedgj9KPs81vOALN9k6N2q5wXWhDuanf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd70f6eb-7860-4b8d-5ad5-08ddb35b1c5f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 20:10:05.8764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKDAzDScrk0I42KRNqM15Wdj8a8ZWQZq0BZp0Msb9u8v/Oee5zG9X8jMVQvOS2NdLgkIygE8/8wadH8V/Zs2Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11458

Convert pc32xx-pwm.txt to yaml format.

Additional changes:
- add ref to pwm.yaml
- restrict #pwm-cells to 3

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/pwm/lpc32xx-pwm.txt   | 17 --------
 .../bindings/pwm/nxp,lpc3220-pwm.yaml         | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
deleted file mode 100644
index 74b5bc5dd19ac..0000000000000
--- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-LPC32XX PWM controller
-
-Required properties:
-- compatible: should be "nxp,lpc3220-pwm"
-- reg: physical base address and length of the controller's registers
-
-Examples:
-
-pwm@4005c000 {
-	compatible = "nxp,lpc3220-pwm";
-	reg = <0x4005c000 0x4>;
-};
-
-pwm@4005c004 {
-	compatible = "nxp,lpc3220-pwm";
-	reg = <0x4005c004 0x4>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
new file mode 100644
index 0000000000000..b82d52f583df8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/nxp,lpc3220-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC32XX PWM controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - nxp,lpc3220-pwm
+      - nxp,lpc3220-motor-pwm
+
+  reg:
+    maxItems: 1
+
+  '#pwm-cells':
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - '#pwm-cells'
+
+allOf:
+  - $ref: pwm.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pwm@4005c000 {
+        compatible = "nxp,lpc3220-pwm";
+        reg = <0x4005c000 0x4>;
+        #pwm-cells = <3>;
+    };
+
-- 
2.34.1


