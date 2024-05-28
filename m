Return-Path: <linux-pwm+bounces-2263-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7E58D25A8
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 22:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9BF1C21170
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 20:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7C0131E38;
	Tue, 28 May 2024 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BUOB7e0r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2043.outbound.protection.outlook.com [40.107.8.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9153A1A8;
	Tue, 28 May 2024 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927646; cv=fail; b=EOD61jR/XN5pYRF+kxSMSpLBl8H8cAGAxEU1o7T8imr5zZDhjb/e4iDT+eQ5RFpKzmcpfquMxcqOQIjqRJQtZaUiag8U7kLqZc09YWDhlxfHfPObN/wcPsQgZOW2l73+mqjAV/vsApEcfnsJUiLpnWrBYOHMkLHag/qDcvjReG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927646; c=relaxed/simple;
	bh=CPNhT57cUA9XLuYuQF2Yjg+KyRrsQZs22hN/lSg1sRY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZtXRWziDh0D2QayRpP4mp80fVg7NfvEq8bAkjpzXljDrlXcKCGCLk6unNKdu0f/KyhSP4xNTJp0Jw6a3nD2eWx+Gn8VhoJmNhMTvQfOxC0NSuYcoPVbh1eQQh+SzGqLoE8GCBrWDS770Ef3lKONWIswjjwazcUhEK2VmXUJFaRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BUOB7e0r; arc=fail smtp.client-ip=40.107.8.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLINpUC3iHtAdYawA7/ORKLvtDY7+xXb1RYEDKLhTfIWisExXzjdmIxwbeTVWBUi7Ki/f6Y3XxZ36rySsTa+FVqQ7KROCw/luJVhQM08RkUlD5JdcAwkXfbrQdedPwJHVCe7SSYBhuCLDzAR2cCeyvOCs6Ta/339uUsydym4l7jwm7DSYKgv+6VcnsrE86nSuTHBFNaJqsWQy1fVr1Mn/mM1HQOXNBEtjuL2Qk1QSp8kocFqRtCo2DchwZH+2gEu+VdylX5b1T6nCZoilltstlnA5OqGKOlXkDYfoauT5QcYJGzgSevAf/YhfwV2Op9wu/mF8cmWsWmNmslxflTDtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9xE1YLSTVmEjrpS9GGuEscbCvYOnMDDEDAexVmAQB4=;
 b=QNlHCtW+Bu/z3I7+9RDunqYxqBfRDBDQ7Sx1WczPk7oQX1TY9sBzaJyf0Q/DRVxHW/+j1IAXwxE24TSy2cDmxhfrMtzj9Kjvp9g4rJpAZMlSeHRknUUDvOBZD3DVfrOSrJh3FLGj2TijBwL/3a6GcOOAi0zTKag0ukC0ieNBqnUZW9QuaAjeXQnW4MA/jPqN1eDDP+Q7tjcBMfnBlWDT5eqB8l9MTVKExpTjvg+K6/ZWAGI2eLfufogb/631+Gbmkg/oiFxlHkaABYK3KpDi8/qmg9MOu88W67bzl6+C0FWuApIdfs2nO7TuuzoWlV1KUVaDPTpTXI9Vwq0HRQyQyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9xE1YLSTVmEjrpS9GGuEscbCvYOnMDDEDAexVmAQB4=;
 b=BUOB7e0riVSQu1x33NFHJeayhRyoeCYgMC8N1NAcbQ0oQMuD4wUoYY0KLIldJBesSNB6TaUG7Ox1PVnbyykYyiG0CjQvJxyIvxctQvorSYs/UtTTq/Bmz2Vk1dq1p8iqzx2Iq/6D9H+fCGt1JiIDZs6kO+qNRya3sxsvHSjqSfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8972.eurprd04.prod.outlook.com (2603:10a6:20b:40b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 20:20:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 20:20:40 +0000
From: Frank Li <Frank.Li@nxp.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: pwm: fsl-ftm: Convert to yaml format
Date: Tue, 28 May 2024 16:20:24 -0400
Message-Id: <20240528202025.2919358-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a42932-a0c0-49d5-e717-08dc7f53a47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+WICzILef1SqcbW+pxoLTENjfD36fRn/wOjARczEZUZ+vLHC3O+/TfAW7EBO?=
 =?us-ascii?Q?8OeTUD+x8x0A72eD1LDg8AEV/KKqCEzp9mWVMCKBnZRWe4lOIpfVDSTOpZQ0?=
 =?us-ascii?Q?4fH1LBNSzRVH3e2kPVO4RvBrVh6mXk7bubkM8U/KNaQtOKMNxXSKg5Z5fLOJ?=
 =?us-ascii?Q?MUZzowJYr37IBqL4ORg296HiKTbAGHvElKrLZxbAmnfq1K2YrBr8CFKqx1RL?=
 =?us-ascii?Q?dYvfO5pMParnft7PPpYAZktj37o/BMxL4r8NqTkoTbfC/6FZKXAY28e1+RUO?=
 =?us-ascii?Q?TPuP9Q0EnvBz+p/LOKOcx+5ZKDq4GPm1r9X9iHELR67ZXs35uYUCt3Mnf8YX?=
 =?us-ascii?Q?eUqbnDNYJoefRCw/sOFxzXSEPb0jUo6bbusfnQujdxu2Eecy5i6ESoDar7Yb?=
 =?us-ascii?Q?dO1Gut+CTE5vvMoNpGfUvBaX3xPPLI6DbwQoMoUS412nRlC81YKU27LDnrd7?=
 =?us-ascii?Q?TQGYrj7ba/coSqrKPQEvKlv8iOMxpCkJJQ+YlN+E+bWaiIiAq1XlvdNK1NH1?=
 =?us-ascii?Q?7RyO3uu0HltsZ3ZPc42VLpn1BEggZqmyeOpsAQggqDGqG5Votxve8+i+0UfE?=
 =?us-ascii?Q?6myDkaT4Ydudt6rr5END35F3R+fXC7PAQPYUYjqjPgskC6TzeqFv3ZAs1Arz?=
 =?us-ascii?Q?LfLxt/VuNVKxJIsx7OhXF/H2LP4wm0DFfS3yBXV+MDTZaALdXHgcKRubBQkC?=
 =?us-ascii?Q?EQkMFGOFSbVzgJCG2YeyrGmYq6irr2AFKeBgY99zaXP2eznccZz2YB/cZCbo?=
 =?us-ascii?Q?Y/jDDb0XN/8I8+FtnXdpTw8tHx0Pbx4Yc7ncgOJ3Y0e6QZ8pXnDSDdA7m0H6?=
 =?us-ascii?Q?EeBTMqji7KQvlcvE1bhj4gSphLZwxXH+SOPI7OfUyVJ9srDACQnGgG1I/OM0?=
 =?us-ascii?Q?So0+1UQEi6Z4j7z8N7/7PdNpu0oiG8MNOUkTQeR0iyprq2GprVozrA9jiQKf?=
 =?us-ascii?Q?RaneVmkLWG/iH5VWCkhj7wPp4+/7C/wmJcz1rYFRJSEoth9PO5nbTTXmldIS?=
 =?us-ascii?Q?bIi9lxEHKIUaIvonE5cWMjeSQTjP0e1Kv0sj2GLaGqfOKfLQDl7WZ8tt8x1T?=
 =?us-ascii?Q?uVSyU8hNBL8HX9Zy0VRlncSeqfbruC3bVhYVMqV5V/r9RgcZVqRT9lRMahXw?=
 =?us-ascii?Q?URescqi5uT8GGBc3ndGKNI5rLpaw77Gb2M/vLOEq0J9tXNhti/AUrEXwQxz/?=
 =?us-ascii?Q?mHUW3PbXTSI4SzbJYH6u71kVAIaMJ7BI19tf8hVc5wWhoanCTfMStB+Rk34x?=
 =?us-ascii?Q?pUgjQRmKOoS52v9rF0E4KofSf2GRlFOQW3OOasPZM9AL5ci24jyOTN/krU5o?=
 =?us-ascii?Q?Ttw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gXSnCrBfW+rEHaTZsUI/iGohdVV35uo9ahdlEl3l8Z+KTALxCK5bCRs1qt1/?=
 =?us-ascii?Q?RFL+RtGTngaogqt0tIr3ClnFUk5zntMadbqPEDXL3g0RCAo/Wrt+jT3xcMqO?=
 =?us-ascii?Q?UMKbmxMmYk8Qb1Kjp3BKhqDeJe5rw/lnte2u61cTe7iOLTBqiLlQVttU08Mz?=
 =?us-ascii?Q?SwMMBeGGDAWgnCi/QZaWy2Vk669COlA9pB3ZmLNxDoVbMvNMrSzR0uPnIVdG?=
 =?us-ascii?Q?GlpzAnq6XFUNVVjvOod/pNqP/Dm4W55c1N9lbT7dKRrboqXgzG0pwzqEs4B4?=
 =?us-ascii?Q?0sGCEDH3L41vcYqKulHObRy5gQ9Oobxee3V+eDOE7VBatgnAW16p/2MZORjh?=
 =?us-ascii?Q?NUJ9RqcSfIGXXLAWpIW9MTcFzGD5Dl9utOE9gVSqvcLJk4Q8B80V0skF7Q0z?=
 =?us-ascii?Q?0Qecq43W4yayHgMPxZK5W3uKlcIxpK+UCehGud/X7HHEj48FUykuRHbP778b?=
 =?us-ascii?Q?2hMBM+iGY9vNeMtZE+KDJusMgd7mZPVqVf1TR4dSdJJ0fnZNKaCIIJuO7fCT?=
 =?us-ascii?Q?/mTrZUDWAjTE3UHI+DEQRoxya7Vc9iutGK0W98T787COL6Kdcgax/iuFyUjL?=
 =?us-ascii?Q?+D39/XP3e6sooulndipWQDhQ9tvZxx/L4rhZU59bdj5woqNIdGZHxpl+lUY2?=
 =?us-ascii?Q?G7pYyIGUBnTrjC3xA+OZtPPoomLZcRnrTAlZaQKECVO0uKqgYlnx5//Ec9Sf?=
 =?us-ascii?Q?1yacc7dgyJjRCYH0Py4UHGwakW13U8mRcxVrJwEG13ny08Znjdc/VXLdOKiE?=
 =?us-ascii?Q?i1H8OiC0sWIKm+QDqBFp2EXQqPF7AGxsUUvhH1aPbfuCdBkidCg5kSPrPAC+?=
 =?us-ascii?Q?8hnNEsWDy51W40xiwILFjlsutdUWVl/VqeWXltWqJ7srWDBK0FOdxkJPzxXM?=
 =?us-ascii?Q?MXP+Psvvr8+TSgtlfMxznsXZfDLAFGWBOuKfEpeAwF9JGK6RpW/ReJponfm5?=
 =?us-ascii?Q?R0xsdOam/xj92LqGKGxQA65/dK/OcPf9tlQHgYyqUvQkM+wEJsIhbAymhpjJ?=
 =?us-ascii?Q?AOuIw0qQ8BkJ5De0eiytKoptiugDxqMjIQerkQ7oK/9SsKYBEaeAiPTk2EyA?=
 =?us-ascii?Q?kzdF3eZgk3LnpXAk+TWHZqfybidO7HlpCmF3IH9BwA3oTMp5tOLmemNK8vsf?=
 =?us-ascii?Q?yUqoIZEp4LhcqlWhYpVEKAlhd7vxFz9lT0e6qoMxEADmmezaC/Ai2uv49DWT?=
 =?us-ascii?Q?gi0bdWel2ayQFbdorE3DPhhNS1WYOgc2j3zZloZsNQ5fVjN7Ibg4NJRjR905?=
 =?us-ascii?Q?rrr8n6laIQHjhlT86yn+cIzM+53c14gUmwjsajbiO5qiYRq/IEqI4DASM8n8?=
 =?us-ascii?Q?l7FqJb+UqDrZgqgeqdS3vWKPyYr1dQL/z7WV9zP8SRpQAiRGCveWGtdNtbAG?=
 =?us-ascii?Q?nzzyiJSgwhKRecLqpUh+uiLnA4F08WC1N+MrpfFAOmcPr2JIii/mHsDj0Y8j?=
 =?us-ascii?Q?JZ6TJ2sUkqG7t17cd/VFeJ+SyOfcXYKwcdZP9zV2TR7VVukDMR3o/y+5Vdo6?=
 =?us-ascii?Q?Qaux5hG4/FoTR6i5Sv+iBFy8mJjJzcfKFCtnY9m8Ab8/26RkG6LwkxwPLJsD?=
 =?us-ascii?Q?Qw2X99LiizHvlC1EiitvvUhgbkUbpV7fzGkbL9CH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a42932-a0c0-49d5-e717-08dc7f53a47f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 20:20:40.0113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoA2KSX3nf33WodX794dopRggzDDWTUH8NUIYLwoX1TIaVvEm23JGDfPOtb5NmC3sw/CrCvovtLgCLylHuwd4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8972

Convert dt-bindings pwm-fsl-ftm.txt to yaml format.

Additional change during convert:
- "big-endian" is not required property.
- Add "sleep" to pinctrl-names.
- Change pinctrl-NNN to pinctrl-0 and pinctrl-1.
- Remove label "pwm0" in example.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    pass dt_binding_check:
    
    make dt_binding_check DT_SCHEMA_FILES=fsl,vf610-ftm-pwm.yaml
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      CHKDT   Documentation/devicetree/bindings
      LINT    Documentation/devicetree/bindings
      DTEX    Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.example.dts
      DTC_CHK Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.example.dtb

 .../bindings/pwm/fsl,vf610-ftm-pwm.yaml       | 92 +++++++++++++++++++
 .../devicetree/bindings/pwm/pwm-fsl-ftm.txt   | 55 -----------
 2 files changed, 92 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt

diff --git a/Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml b/Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml
new file mode 100644
index 0000000000000..7f9f72d95e7a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/fsl,vf610-ftm-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale FlexTimer Module (FTM) PWM controller
+
+description: |
+  The same FTM PWM device can have a different endianness on different SoCs. The
+  device tree provides a property to describing this so that an operating system
+  device driver can handle all variants of the device. Refer to the table below
+  for the endianness of the FTM PWM block as integrated into the existing SoCs:
+
+  SoC     | FTM-PWM endianness
+  --------+-------------------
+  Vybrid  | LE
+  LS1     | BE
+  LS2     | LE
+
+  Please see ../regmap/regmap.txt for more detail about how to specify endian
+  modes in device tree.
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,vf610-ftm-pwm
+      - fsl,imx8qm-ftm-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  clocks:
+    minItems: 4
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: ftm_sys
+      - const: ftm_ext
+      - const: ftm_fix
+      - const: ftm_cnt_clk_en
+
+  pinctrl-0: true
+  pinctrl-1: true
+
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+      - const: sleep
+
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Boolean property, required if the FTM PWM registers use a big-
+      endian rather than little-endian layout.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: pwm.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/vf610-clock.h>
+
+    pwm@40038000 {
+        compatible = "fsl,vf610-ftm-pwm";
+        reg = <0x40038000 0x1000>;
+        #pwm-cells = <3>;
+        clocks = <&clks VF610_CLK_FTM0>,
+                 <&clks VF610_CLK_FTM0_EXT_SEL>,
+                 <&clks VF610_CLK_FTM0_FIX_SEL>,
+                 <&clks VF610_CLK_FTM0_EXT_FIX_EN>;
+        clock-names = "ftm_sys", "ftm_ext", "ftm_fix", "ftm_cnt_clk_en";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_pwm0_1>;
+        big-endian;
+    };
diff --git a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
deleted file mode 100644
index 36532cd5ab25b..0000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-Freescale FlexTimer Module (FTM) PWM controller
-
-The same FTM PWM device can have a different endianness on different SoCs. The
-device tree provides a property to describing this so that an operating system
-device driver can handle all variants of the device. Refer to the table below
-for the endianness of the FTM PWM block as integrated into the existing SoCs:
-
-	SoC     | FTM-PWM endianness
-	--------+-------------------
-	Vybrid  | LE
-	LS1     | BE
-	LS2     | LE
-
-Please see ../regmap/regmap.txt for more detail about how to specify endian
-modes in device tree.
-
-
-Required properties:
-- compatible : should be "fsl,<soc>-ftm-pwm" and one of the following
-   compatible strings:
-  - "fsl,vf610-ftm-pwm" for PWM compatible with the one integrated on VF610
-  - "fsl,imx8qm-ftm-pwm" for PWM compatible with the one integrated on i.MX8QM
-- reg: Physical base address and length of the controller's registers
-- #pwm-cells: Should be 3. See pwm.yaml in this directory for a description of
-  the cells format.
-- clock-names: Should include the following module clock source entries:
-    "ftm_sys" (module clock, also can be used as counter clock),
-    "ftm_ext" (external counter clock),
-    "ftm_fix" (fixed counter clock),
-    "ftm_cnt_clk_en" (external and fixed counter clock enable/disable).
-- clocks: Must contain a phandle and clock specifier for each entry in
-  clock-names, please see clock/clock-bindings.txt for details of the property
-  values.
-- pinctrl-names: Must contain a "default" entry.
-- pinctrl-NNN: One property must exist for each entry in pinctrl-names.
-  See pinctrl/pinctrl-bindings.txt for details of the property values.
-- big-endian: Boolean property, required if the FTM PWM registers use a big-
-  endian rather than little-endian layout.
-
-Example:
-
-pwm0: pwm@40038000 {
-		compatible = "fsl,vf610-ftm-pwm";
-		reg = <0x40038000 0x1000>;
-		#pwm-cells = <3>;
-		clock-names = "ftm_sys", "ftm_ext",
-				"ftm_fix", "ftm_cnt_clk_en";
-		clocks = <&clks VF610_CLK_FTM0>,
-			<&clks VF610_CLK_FTM0_EXT_SEL>,
-			<&clks VF610_CLK_FTM0_FIX_SEL>,
-			<&clks VF610_CLK_FTM0_EXT_FIX_EN>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pwm0_1>;
-		big-endian;
-};
-- 
2.34.1


