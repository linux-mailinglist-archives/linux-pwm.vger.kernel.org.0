Return-Path: <linux-pwm+bounces-6215-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 916FAACB1A4
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3B0194109F
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA30022DA0C;
	Mon,  2 Jun 2025 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ltvmGKNY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3722D9F3;
	Mon,  2 Jun 2025 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873261; cv=fail; b=fD0uF8wpfY09D/qk3rck3rhF2RE48N6n9RKURZkBOwPgsB8OtsoJY7dMFJFf3KWhMvppcf07t90G7+xOlBwgfQuLPQOuQHD8OrgxFzzpVCqEajxeWr1ND/JITWp+FLoww6UMn42EMeRJc1N0PgkhP1h3JqSEz8CD95+WwkQEv9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873261; c=relaxed/simple;
	bh=LrVWHFHZV7M8pmbUMOOc3OI1JuDYIlqhziyoUtvGisY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GDqVuRXfwaSgVJXTUElcz44oOmfrPM6zyTnvd93ilx+2/BpE5T5HUH918DfDWhGGnNJ046h857iGiiaj83m14U33PzHjouWVP49Lc0ZTMgv23EJztml6poXFA64QDwlpCm+V2bOXLHeVKoAJdHnUQea/sg7qpR/e7mZu9NRqxh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ltvmGKNY; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzGxzVzEptA9elnAtgtcPTTeyc0PfJRiOoqVkkn3gVlKyl2fiq2HIBHe2m/w33XYB2+n0eeZ8jxpQXN5FeUPCJ65hFYBwMSrjsyjHVbVYFachir77ab8yz0m4mZY2At1rcBZ+iT9EqxHtjMAG2b6IefQrjjrwcdhVf/vrO3foYj3yISW5RDKqbXZ5nVxGtNXlC9IWAvNJxVnrKfUkR1koj5N5YwlNGtrU8lsAcNMWiXSmaA2ZY3opCx6qrZEurUenwIHiW2ec9WM/BTW3DPe4ggNxBUZuwao8RhRPLTD0dCx7yQDabTyi9qGC1WPQSgFDjdVOKtcwA5Y1bEtAlpR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAcqyRM9YyiL53/Pp+oEGH34fI0/3ea5fnG2+PHL8NM=;
 b=qPAyQzYQXiHhYytgy4nsUTBJWUzTGoy+H9rc3rOntzQulCnnpHxnZ5i9jHwUhfQvvDreOIrbCsE1tlxp9LU1CRQeirF28B1bKb8cKi8ENUfCz07P4eBkvktVqBnccw19lsb5VGBySf0+DumLNKtZluhuKCUuUeHXIlQkSwuI67kZ8nci8T26ybNIgg9XIiomYH7FN8riYmA4eP9jfZpPVGyS6sVDltp/5d5YL4ZVHEjF2Vwvl4WvnAnXbSfIO71MAqthgVyVMe4gyMVpLC0ArzrsQKZmo0Jh1I9njFMnSU3ZaJaeyIyCPMBrZ2/xJM6dyUs2Rfk4Q4uO0uIXXloRRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAcqyRM9YyiL53/Pp+oEGH34fI0/3ea5fnG2+PHL8NM=;
 b=ltvmGKNYJbYWagGgmAN5F1D14TlsyRqqL0x2cnwOSpMb7Q8WC+BvgGivCq4I88RtX0CojDBzgj43+37z8ND3iD4yDjNIcu+ryDW2nqrOqDUbx6mLGuhbHCvOO7nG1jPhCiv8/o9Olr44G4nPiW9EQwmCQQ4MnNtizQkeo2Plns8dZFzOwi7ZUp1qMfCKwl8Wc4ACTc4iQaB5dfF4vb4RTjiEaqhLIk8GpGfbzFKSraRt8WvhGCiYk8UjYarWGDajxEICLMT5diyNKVmvpe0hGHKEkXVhYUtd+/c0rv/Od8zaDqwjPROdDCA05fQL4mlFcg+qz0vUHwbRiRiOssQ/CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7051.eurprd04.prod.outlook.com (2603:10a6:10:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 14:07:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8769.025; Mon, 2 Jun 2025
 14:07:34 +0000
From: Frank Li <Frank.Li@nxp.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: pwm: convert lpc1850-sct-pwm.txt to yaml format
Date: Mon,  2 Jun 2025 10:07:21 -0400
Message-Id: <20250602140722.941002-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 498bb486-7615-4518-321c-08dda1ded287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E+waY0RVHbQV8YHNGVd1Ldb9YHTVjcxIZD6oOFRJie8xD0b0O0OFNlL7P8nY?=
 =?us-ascii?Q?ULzfYS/Uko3XZcC9PtD9HUekuezLx1SiVSjiIj/Nyd2MdJy7osOSZx3hdeMQ?=
 =?us-ascii?Q?iu8CMn8GtULUlPoDXmdHkKCSlm87e7pfeIy47mTWMAfumKnFyUyna8bwqIEh?=
 =?us-ascii?Q?40L0rlclACk2qcGCZ2d3R0U9xfymupSorzyGLzg6ZimI84yth8kedPM5fSs2?=
 =?us-ascii?Q?4fkd4kMUpGzyBr9hzW0q9Mnqmo6Th7xjmEgeIGm6GRu87ZnsOl/Qqj+0cLvV?=
 =?us-ascii?Q?ex3KybA3iN67t5OeXf01LUhOzEwCmGFxJW4avG/BrgWSUvoG3A3NT0WIp6ko?=
 =?us-ascii?Q?R2+0d0MIOl5YxcQuzBHjISKh0HRbV1A2Sr86ziAqvWbXodCLNNIxqspOpFaY?=
 =?us-ascii?Q?OatV4FOTyvo1tv4doneakFuEk5Y/TCyFk9UQXHQ8/DW93hxfdvvL/cHidhAI?=
 =?us-ascii?Q?eAYvWJ4ZQXBW20Bq/0Dfv5mmNc7UtxEaL2Hayltrm2rpNF+TaxVzLqd0qCO9?=
 =?us-ascii?Q?zdGmQUExplgi8dXV+oUGTltsqwomlnozPl0HT9Eimfrg90zvv+N5okHsK67Z?=
 =?us-ascii?Q?YMUaQWkIWy6LAUwFaw/5IUTlSui1yC20BDweOl8+NG8lhuzajCGwnpJ55+ih?=
 =?us-ascii?Q?WsAj3lZSh00wkTF3uRsl0AXwcHxK179jltaVi8maLRyho1zMoWQLWGBKiUse?=
 =?us-ascii?Q?i5E55XEOOIpuv+h+vt62k9O8tiY5NHIEWAJWB3zRDzABc66WNf9cF9mXA1Bi?=
 =?us-ascii?Q?+dyE8n5qKw8uiIpGtZbLCfidGaQdLuKoGOMlSvU+VTNkTh5seyi9IiqgbU5k?=
 =?us-ascii?Q?co1WTeQ7g2/xhse21PhaszrR118IDQzFCoWPJjiM4y0ZW6zmyrj3oa0PBK6h?=
 =?us-ascii?Q?tpKoaBeQr4met1P+oNu7rBcmhfJMNmxuZW6FqTS2jsZpbrAmrZ51nrCVP0R1?=
 =?us-ascii?Q?LIb624cMCI8WoEYnH1xMGLZ3bVG2wnqvvzAiAlbfHmiNqKgLUNIPChGmDl4l?=
 =?us-ascii?Q?8vILRprfduCeouXcU/Cjqz+GJPOd68sGRrZDTRfsv0i1dJFCpkFKrX9EpDVk?=
 =?us-ascii?Q?oMLbxaZMU3ZSmGHRHnP8pfYxu+7r/sjF4T/NwuG+xRFg967RTdzoFzuHrLcq?=
 =?us-ascii?Q?v4ghRS26rzzQgkrK1mlNbHDDo18/Y1fZmVx48fkc8Kqfr5oImjoAGBlweDa2?=
 =?us-ascii?Q?tW/5RWPFf99tA1vHDsTOf2ArYnpLYN+iYyPeyz2pgd38tZYNfpdEu7toCEOH?=
 =?us-ascii?Q?8T0orOQJHB9ZGWYYRn1nF+/yB2BFfyNHkISVDap4v05bWb1LsE2Q+sJ6OW33?=
 =?us-ascii?Q?6srcev8VDUG5SHwAup6IvRYykET707uWg+rzQrZVWxxdkF/hYmYZ4h9BYYYC?=
 =?us-ascii?Q?Gzg9lWZojH4GybDClsV8a1XTzSUCHohoostU9Zf2XKOpbTbheEcZSRGJ9QCO?=
 =?us-ascii?Q?airbSjKKcaqgwSDUZ/XnJEw2Y0YeTrVg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z0gWEgcHsQ4YkU4LHtMoUWZuoGp5q1J1GxoyprHau77sufcUEl8EKM1iZSPe?=
 =?us-ascii?Q?bK/r2pLofXIMu17ugzyvlNR+0jkdlkJnS7wPyIbjZ5Tv15Y8QXebHioY/D8T?=
 =?us-ascii?Q?PbNNH3bfu1xCuELUG8dQ6aWCrZpBLO2DMcmlKMi4yOlGdsxqziKnkCFC5roy?=
 =?us-ascii?Q?ztS6hCfxXwNLjDJi3QVxPYI8TUMANFIdsB13cfL2QHif5Og+aQ6NxByBGbu7?=
 =?us-ascii?Q?f3Uzo2XDYSsyR57T46xispWQ7WOsRHOB/YFcOUV+9kBf/SgHtnEvPdixuoeL?=
 =?us-ascii?Q?5pDJ4Y5V07ydnMELsVak6IFfC0vyO52bExildgg9amMyV7dEaXnaUqm80Dn5?=
 =?us-ascii?Q?ul22UJKtyTN+bc7n7bHZHF8YeJcvHGHgeuCacJSfdjZ4CgL7mID3KA5vA6Ll?=
 =?us-ascii?Q?Nns/t3txoOrawANHmau4Rn4Ju4wfsLlfOY3/u6ruja/9NAzLLBmqC3chQBzB?=
 =?us-ascii?Q?hDa8QrkHGRpgBAyMI3NhLFzOC7ZxxbtCsQj645niB0bbfFUcricwy0NnYHVt?=
 =?us-ascii?Q?hEQOzCiY7Ueb5MPFQZ+IBLxbO4NipcHp0vyDK9/NOUFTT+FAxkJImevvZTlS?=
 =?us-ascii?Q?atrhZFFGHDrP5lC/Iw0Zpjrpnf+dniXJPBSHVjKlKBL2iobFcMqh9iBII20R?=
 =?us-ascii?Q?0D5SSM6twc4vq8nUFuKXmYbLHE4YSWZdy2Syg1eUqBJexDUWRJtJGbVZZ55p?=
 =?us-ascii?Q?B8/RS6pLMgjE+dIQqxXzewp1scZOCWVjS+pIkh75hPtbGWcf8YXfnoPWXmL0?=
 =?us-ascii?Q?ouB/UPp1XooLHlx11XuM/VFZ0HZwQ5SjsbwPM2+sQlJwdCpPiG18ZV4gmLMg?=
 =?us-ascii?Q?7ZxPnHy1U8KfC6JOcMoToOa0MBHHVpq6PJPaf0I7Lgi8PSaRTYxPaN/t1Kek?=
 =?us-ascii?Q?llQeEASw+L+qV1bDMDcIOdWR1XZrQYNJyws6JBoF1Qoc4oH/OKPbpxOrSBMn?=
 =?us-ascii?Q?GezlW2/HV+cJQAtB4vUbTx/R1XbjCMO8dSvDTYCNnltC1IiDavvSrcCfa8LM?=
 =?us-ascii?Q?6BhXzZtN6ehw1DUGMQUNv/tuF5VJ4vR28CqXZDQ0QCtq7LBwzrNQVwkk60CK?=
 =?us-ascii?Q?nlrqg7M0KH+LImcbUx6lhV/3169AWL6O/V01KFzqOVXg3BbDIxvyObwH+NSB?=
 =?us-ascii?Q?BZg5Ni01KAiJaKUGhLCEJ8JFjPtYaUZstp0ac1fOKhbluO6sV/+/Lt+39ErX?=
 =?us-ascii?Q?NbEP9EKEQhvXUd2DEDRkj1UWzveQCzHrb+rzChoQuOdxHQyBraHBxdyh2Xxn?=
 =?us-ascii?Q?nQM1m1jUtyggOjbLgz5KiMmc1Bh23fldbH58zlH0h9S2uSeBiINS95Sy1sxa?=
 =?us-ascii?Q?aPcz6blI+zIuqcqzLPJFroAzPgKOjb0E82BQ6oolJ5+23rpAvlyNutuxD9qs?=
 =?us-ascii?Q?lbH714i+N1h0aXOQLHP39gZyeaLyL7+dmeN9g1eDGzPJfFvu1w5D60MjEEyv?=
 =?us-ascii?Q?DNnpShB0A0fOIinCXzPnnI6uF7QGeZE9JuyOHirKUsPX6LL26nmcQgoV5bGv?=
 =?us-ascii?Q?JgyjGQS+Mtsj5hthh874lwACvepJ4JPHy5ddhBGsz+9G8+8zsczZUF3XHkc9?=
 =?us-ascii?Q?AZhagCc84WroQBIwlcE9O0PGgdvCeACuxhHUeXAp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498bb486-7615-4518-321c-08dda1ded287
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 14:07:34.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leU0GuZZr1XaVF8ysMN2SeBKR2LKa8hQgJyGShavYEpmjzejWd7jMjTJGET0Tw6KTkBKGAbSpq3yZOqJymXZOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7051

Convert lpc1850-sct-pwm.txt to yaml format.

Additional changes:
- add ref pwm.yaml.
- add resets property to match existed dts.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/pwm/lpc1850-sct-pwm.txt          | 20 --------
 .../bindings/pwm/nxp,lpc1850-sct-pwm.yaml     | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,lpc1850-sct-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.txt
deleted file mode 100644
index 43d9f4f08a2e2..0000000000000
--- a/Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-* NXP LPC18xx State Configurable Timer - Pulse Width Modulator driver
-
-Required properties:
-  - compatible: Should be "nxp,lpc1850-sct-pwm"
-  - reg: Should contain physical base address and length of pwm registers.
-  - clocks: Must contain an entry for each entry in clock-names.
-    See ../clock/clock-bindings.txt for details.
-  - clock-names: Must include the following entries.
-    - pwm: PWM operating clock.
-  - #pwm-cells: Should be 3. See pwm.yaml in this directory for the description
-    of the cells format.
-
-Example:
-  pwm: pwm@40000000 {
-    compatible = "nxp,lpc1850-sct-pwm";
-    reg = <0x40000000 0x1000>;
-    clocks =<&ccu1 CLK_CPU_SCT>;
-    clock-names = "pwm";
-    #pwm-cells = <3>;
-  };
diff --git a/Documentation/devicetree/bindings/pwm/nxp,lpc1850-sct-pwm.yaml b/Documentation/devicetree/bindings/pwm/nxp,lpc1850-sct-pwm.yaml
new file mode 100644
index 0000000000000..b524978695979
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nxp,lpc1850-sct-pwm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/nxp,lpc1850-sct-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC18xx State Configurable Timer
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    const: nxp,lpc1850-sct-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pwm
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#pwm-cells'
+
+allOf:
+  - $ref: pwm.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/lpc18xx-ccu.h>
+
+    pwm@40000000 {
+        compatible = "nxp,lpc1850-sct-pwm";
+        reg = <0x40000000 0x1000>;
+        clocks =<&ccu1 CLK_CPU_SCT>;
+        clock-names = "pwm";
+        #pwm-cells = <3>;
+    };
-- 
2.34.1


