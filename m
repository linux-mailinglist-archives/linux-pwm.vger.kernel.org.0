Return-Path: <linux-pwm+bounces-6385-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0857ADB950
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 21:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469CC16A197
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 19:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D53204C1A;
	Mon, 16 Jun 2025 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aD+ZuquO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013045.outbound.protection.outlook.com [40.107.159.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D23C2F;
	Mon, 16 Jun 2025 19:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750100694; cv=fail; b=l7GCVv5PTA+93EomDdWjWF/mBqOss1PN+agck5OqCTWklt2iXxxMaxRrivWSFOKk4rmswNj6v9/ZpSQ6zQ6yl4b2GkD/RxjhKAT0Cc/XpPM3Zu8yF1hqVqP71MtVDxY1Uqu0/SdxDOfSsrEj1UsKZjDcY5vxZKS1Z4Q7I72GvNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750100694; c=relaxed/simple;
	bh=vbZiEZ90OVggMzJIuTOERYo5X31caIN1je3ygwrPidM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IrZWAww9vr3wwLsBaj7WKtS5ZTFG6bXJJyjbcCRUiCS+aS2PFnbGEsMM18mGcHuIcAbRCNh6qW0SeUIGoZMQT+XhRSHHoBxxsUsl66J5Zi8kU+Od8ok/vYahG/xUz71hXx944HNVtKx/0S6QUsA+VzYaEKhcPNT/w73loY7d8+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aD+ZuquO; arc=fail smtp.client-ip=40.107.159.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/BIqQRw3xlkQKzD9tluPsDYj57kEa/G9r+znsBzc69QT6j2d7paiknh2lDmtE+AxU70hlcWTFTc6uribGgcik9EQElgska0jbhVZcxQDZwNe9RwZ1NZB8/jGfFiYmijGpXbvqmMQlqgy9jv/nTR/DdMgoJFYhX4S5kZGFk06FD/PQBWwhu/uCbAYOi2LSQefYOnFnl3CD9ncVnp3ofGmZ00s1KjUlFiGHcvXWCJ/5xwG4wuk0Z86gVg0liawfRyUB782InOZQhnvNaRMbZzVDPVjxKN62u4WOXKRuGsY2Gzxa8pjWY3d9d8cl9dVWsQTeHa2eh+a8A/L29uypQfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0LWOogMVvlAzKvLnr0XCD/tSJOXzfykFIG3lpGBG7A=;
 b=yJROZ76Ua2lJ7Teg8y0mdTeJslZDYeZfTG9N9qawNU01PyJxvR+7rHjeOE9NdIajIaGTK7x8kkPoWWnlDbNubC3wQ0QMrD4jnLi6abhJzYw+0WFFPszLUTKSCwZUey4BaIJUhgVgy6vvQnVkUiyWkFXFQRe7J4mu7KOQgDYRni+9cjm1EDzsfMbjBsGwJRyvcAqJcUTQmkoDg26rPx/sPjyEXIM9JOs9LRg17Nc8pl5M/EjVkC8kaqJ6Q4c+NF/3QRLcM5YbhkB/EQvNJzYFit2Xu3mSo84nXcczLjuLe1nXRdEv6aieXwMqFX82ZjjHuaU171lm0SxTIweecyhPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0LWOogMVvlAzKvLnr0XCD/tSJOXzfykFIG3lpGBG7A=;
 b=aD+ZuquOL4sMouw6OxxV4VDWiJhm5fb0GM84Z3yutCkvkEh0XmACrNcici+FZi1P0pJd/HOWEBU/6fGJTlWxdXi7UFUj7t9sl2HL1bOYQ0OE4ZNNBqa+wnrHqDc35ZDqoWMtPO3DgRhGorIANv3uuKwbaNHvrDRjD3raucFBQFQdrwoMa/ZYx2DtUDRQDXzcqJRTLxUOkobQXc7QmHLxIUnew95DiDUUMgtckxm+CULQq/qKEYobhLpiamM4Hdwp3c6guBWZA/sqn1gus3CaOlbmT72JfRI6LnRTdM7jDEEO6+h5LZbNfyIrRuaV7usUtUQWPylK7I1OS2YITizQbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8955.eurprd04.prod.outlook.com (2603:10a6:20b:40a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 16 Jun
 2025 19:04:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 19:04:47 +0000
From: Frank Li <Frank.Li@nxp.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: pwm: convert lpc1850-sct-pwm.txt to yaml format
Date: Mon, 16 Jun 2025 15:04:34 -0400
Message-Id: <20250616190435.1998078-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:510:174::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 27da4aa6-aebe-456a-7d92-08ddad08a992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ntRnvNLnIMGRoJtzdh71oUX6nq2s9UtfdW6aTkRNciwiSWgPVXaC6XSF42S?=
 =?us-ascii?Q?ICJRxea9YRelqvf460FGI5UQbO+RD0XLuUjpLelOzPGci7h3w5N5CZLdyjNB?=
 =?us-ascii?Q?XASg+JgjLl7cSFqEoFruOyCbg4mw+WEkflSp8fQc0kXxwt4LOIWwPQLnIuc8?=
 =?us-ascii?Q?1ZRz+soPFqsM1UnroyXzfHL8tTIxqsQqHxsZEb5OKxrw/TNq7VPsHgoXEKXm?=
 =?us-ascii?Q?54330BBFODGGpjoHs/42iF1AufyrGkzxtMYfDHSy2omhKt2Q8v4fpOgi2uGM?=
 =?us-ascii?Q?mus0gqqqzyKuNrdChKIAN8FMiytpsMIbfgAqhGrg8jI7/cMd/tkyJFd+iERk?=
 =?us-ascii?Q?Nej5XPXMhXTZNy3JRAppu6RKSeesDZBDb+nlVIskASz2mb8ioTnM4i/gEFCL?=
 =?us-ascii?Q?URrXSeiHuRGihxG78sX2ihQEOJoK7ejJKX7cZvLyLMmFajjMT6Tk0MSE9tO+?=
 =?us-ascii?Q?pJ9hdKszQJ7dzYf5goQWffP0TT3+OTUtYcCZj8Nx8kbj13W6c85t6XKQbiyP?=
 =?us-ascii?Q?PLBVtBonkAp8P/jSGCY1nzHrLhuH1sCjNNu1cx+yoJj9AQ2pYoCo6c9tvRoY?=
 =?us-ascii?Q?QSB1I2UEW5Ux4LjGRU7QBaciND4thPSPPmT75JiZauamx+/PhW1mN4nFIR2t?=
 =?us-ascii?Q?3YNgOAusKxJXSt2u4kx9XXXZx+7ww5NYB3C78RU05p2Iv5nA8+9Si46qHWYj?=
 =?us-ascii?Q?+fthyjHIxV4VR3wCUw5bIaQpiC+L1CLVm2O2+z0QysUaGDavuQe2Dm9ib9ee?=
 =?us-ascii?Q?QhqfwSOhVaaCiqUfsMG2KTvxI93MZD4gdHM9fYC4kcvWjoiWtijhhOgrpdOB?=
 =?us-ascii?Q?lktN162oSuYgEBpB7qMTtY09T1o1z9PksyqjclTpzJBtyRJXNY5b/PbKsN9g?=
 =?us-ascii?Q?Uj8mp4lf9dhUpmFetoJpa3YH3DXD25/HmWMl5zLlFffqZrl4YDE9YmF+n5eF?=
 =?us-ascii?Q?YbZW7D4BNvGurNVDMAvEPTuFws6vmcE3rPe/A4rM8DiZNtQeHmPwFBXLnG5A?=
 =?us-ascii?Q?rpMe1iJQrhrUsms3NGy6XPTFNUO85CpEGb9jbuYkcpqGXSsNoP7pS8s/Rim5?=
 =?us-ascii?Q?wUJHxwaaIYUk7pt1zo99QrampK+sZ+mM84DTuXbJJFfxmTAZOSpJLJdy1vvy?=
 =?us-ascii?Q?BcR/4/B/EcSc4+OjEKP9OyvSIL0xgE17WxtIjYIsr7Wp15dI/im6ID2ZQQdg?=
 =?us-ascii?Q?c6RnAKdhFJMwFsximSON+P7KbpqktiY2s5PGtw7s8AYol3AIFQRSDbu+/lE3?=
 =?us-ascii?Q?N2pgl5YbnzSM8LowK4AqFbmlzA40GptwuXI4L3PIFrSS3eU8fal4kkb4Pa6J?=
 =?us-ascii?Q?8rUGGgojdcxjiGwo3MwWvoJJOmqgSUQuXvLu/kstUQ91uIxbXbPjDsjP9Ijw?=
 =?us-ascii?Q?ESlOz17AiiLggcXYbWkUuQYfHQtAi146T7oiATbM4Mg1aHP4eR0HMYGzu1gp?=
 =?us-ascii?Q?BmvEkPko+wyYspYYGyFYFTNLQrKK3fk7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x+h2HP6H7f3KnETSVISap+lWWIIPJvfL18ndCRMEgeAMhvGShW6hIALAhWXx?=
 =?us-ascii?Q?ywMknUlVpfHBmtpO2ub4N5vzwIfuTXp7ESySuytQt/+pm8WVYhPm19oeThkJ?=
 =?us-ascii?Q?gMeJNwGM+CyhkfXCt2dHNiEcr/AyHCJawOr0WTA+OIByJQzrJ5TOWsLBo7yk?=
 =?us-ascii?Q?VsPa7joz4yum6U+AVii/RY6E0P9c1eXoFVzlZlGNy5GKeauKTYmpAsEXxjG3?=
 =?us-ascii?Q?n4hrsEFYn1E3UmN9N5dakCpgtHfBKcsWXbRXqZ9Msc9N/CprI7FutYVVV1Oo?=
 =?us-ascii?Q?nq6rXsKTaTQs06HZv5jRbvLzCj+seNB0KeSO3L6J2DNHG/pGorLAr8eLP2xU?=
 =?us-ascii?Q?v/+Ddj2tA8EFWhz7hGc5cY6LUB70d9InzwbTOk+yBVa1bK+RXan1yFQStujV?=
 =?us-ascii?Q?xC+Q6YMPOOi4JlzEDHuX0HW9kNF660wZSLXFDizizVnCOabc4LVkpgPM+5C9?=
 =?us-ascii?Q?Sqeu8cKDE2LosYIU4/hU7npH94xhyGEVywu7qAitxFdT1JXLBprn/nQkYRc1?=
 =?us-ascii?Q?RhDaxt64Szfp6qPzNb2bLR1rolVyPyv0u31s2dfVYKqDtGVXEUU6iUn0guz9?=
 =?us-ascii?Q?DQ0ptxa1rxKoabRA+MA8bxEnYoBNsir6ZqYMEOzbQq1UoGW640wUdi3x4SfG?=
 =?us-ascii?Q?XpGTxXWbwxHUwXNa6KiTOnkrD6pGDl5VyuH9I6aeHm9EgmZUdMrZ1rjTFukL?=
 =?us-ascii?Q?HplSZj018ZxOAgFex6oHRj5a6qy/KlqdnB3eZjwk5Pn282PYysc3LoP9PsqP?=
 =?us-ascii?Q?7CsMlwqqaQwwLIq1Npy6rgbl3RNHZgbSNfRiGr5n7fTWW5ZIdDsVDPQqAM+c?=
 =?us-ascii?Q?aEVY89W4xk2S7qEYQeekq6yrzFSbPnCyeCjUbPLSTIUSIYaTgz46jzzfaMZo?=
 =?us-ascii?Q?OKs6BI08bDAy9oOQZoG/R0UveEKebbyATnQiEgjkXQq1iPyBe/QVMVmZ2G1L?=
 =?us-ascii?Q?si5hoEGozZHnVOsKvU/JzLfHmMoiuWdd3mGfLTTJ3iMfPmN6PUVGYWjEs5rv?=
 =?us-ascii?Q?Y+VCsn0YD0LhnE/vLvgWqh0pbrXQP7+70b+E954DYMuocNppBLetWmF+LMmP?=
 =?us-ascii?Q?A36rfN1jxfDfCEJm4mjm/pEVqNq+YFEAkmOlN1iezN04qWZ+wW7A7b3rPba3?=
 =?us-ascii?Q?07N8OCBDCHO1D1TBQyrijx3cCp+UHTL2szsRJerHPha9jCkPrqyWwIVxKONP?=
 =?us-ascii?Q?wo4YGjZBPjVgE8A0Op4fju+osJaSNrxjF46ekfZPnDXt5PDokiV7WEB8VBfi?=
 =?us-ascii?Q?KfYJl3Kf4ClfPqpXVpCPh296+WK0/lBfntFScnEt8xKpAJ53pktHGJKTGyfu?=
 =?us-ascii?Q?ht7pGttz2dCvKiZQlz+VCYh73ulOuB7z4qI5rzkrPQxHb6kIkB3I13ZIJQrN?=
 =?us-ascii?Q?6JvTN3p7QdL0rqZFsvZd807qhjj31G9s2fhjqAq1vqE5SIhIALpP5tvFt2SZ?=
 =?us-ascii?Q?j24tZh/NlVuoleOR33eSDCJ50m9aWDY8p5vTBQvW/iBmsju1C4pfvTf+Y7sG?=
 =?us-ascii?Q?EZ0YrcnGTsBcUJmVvXpW8z2KQhaM7Iyu/GS46w9TTe9Q5tIoceL+dgh342Lh?=
 =?us-ascii?Q?9pbrnq4ysp3oGfj9oIeYu1jROeR59NUVm6IAcoWB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27da4aa6-aebe-456a-7d92-08ddad08a992
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 19:04:47.4787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsDjq+80zE6vSG6SbtYA+Bgx3N4vHx1zteHUXLdinu6qTCtwBK3qkxlvX2Hj8mye1+rEkv2OCplKnXULUOHFNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8955

Convert lpc1850-sct-pwm.txt to yaml format.

Additional changes:
- add ref pwm.yaml.
- add resets property to match existed dts.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- add rob review tag
- add pwm-cells: 3
- add Vladimir Zapolskiy review tag
---
 .../bindings/pwm/lpc1850-sct-pwm.txt          | 20 -------
 .../bindings/pwm/nxp,lpc1850-sct-pwm.yaml     | 54 +++++++++++++++++++
 2 files changed, 54 insertions(+), 20 deletions(-)
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
index 0000000000000..ffda0123878ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nxp,lpc1850-sct-pwm.yaml
@@ -0,0 +1,54 @@
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
+  '#pwm-cells':
+    const: 3
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


