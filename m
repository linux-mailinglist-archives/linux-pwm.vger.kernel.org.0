Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CF43F9018
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Aug 2021 23:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbhHZVTc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 26 Aug 2021 17:19:32 -0400
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:60380
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230182AbhHZVTb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 26 Aug 2021 17:19:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBYST5239Li6Kz2BrqHGn3dqTHyMjl+yom2PXswl/g/R8g9EBb4iiH+gIfBocn9xAy9Jvxw5OZ1kF/5lwG1XmCni6NLwl7zaURH+XvAFswIsAIhWog0jJR7i57pQIupr5ZGEk8XBbd14ub8znpadwZtz4vlZ3iUrNM9+4YhcstbFuKUVm/ch0gRk8JD5wGG0qedzUKvp47Nb8/STFK0dxe9Os7yyUdawGGeOOomVzwfUEJKk5V3f2ONarprzRGYJQhVv+GDY/lCysawseF9nqC5KTs77r9N6gDYoZt7OEl7gpOKuKuht76W6uG2hl/IFRCYkLwA9a2n+2NdRm/I/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkpsHXFmnCZxjsuFlqpUXqJIWrypXB/Px1dml5a1ahM=;
 b=KOA3OlOCFSOeIyA60edcdRsIErudf1Ne5hVk8MP+/qKIVPaDdlIpaCbAfBj7Vz0GLt1LbbsRHeW9TH8rbjfmUEvb5HJZwyj/RRStmU9wLA9zmFm4qCaDJnTugGEO7ZPvYj/aI+j7TaMdoLQjbV2y1Lu5ekRX8W9DclYl8/RmQVURY8kzZxutzVS1n89QUE+oAL/tLOonRKPTf7QSMAkpcrPPTKV+anp0+C+iiUAupAne/DhznFFZhWwFH8ZB4pPfzpK2V30QeZJm7sJvPLG7JZF/svF67zKMElLv2T4lyN6dUah89E9ACS+dar2RbFDyRt7IBSbSWdlduLbmEfDf1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkpsHXFmnCZxjsuFlqpUXqJIWrypXB/Px1dml5a1ahM=;
 b=N15T996vB5gLJUKc1H4MZQDd7IWbowEE25lewBKxc9Nzg4lSnVUVdCuFnfCczVeLEDyc4e0okJCNkN3JE5XWS5GHiC2IrVbN8FGZ8rP1w3GcHIurO1XZJpgSFBwgV/xoLUCLOvf4tGEtF8R/E1CAjutGxvVLLxemhIPOJ+HD/RA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR0301MB2182.eurprd03.prod.outlook.com (2603:10a6:4:49::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Thu, 26 Aug
 2021 21:18:40 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4436.025; Thu, 26 Aug 2021
 21:18:40 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Alvaro Gamez <alvaro.gamez@hazent.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/3] dt-bindings: pwm: Add Xilinx AXI Timer
Date:   Thu, 26 Aug 2021 17:18:28 -0400
Message-Id: <20210826211830.3311140-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:208:23d::21) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR06CA0016.namprd06.prod.outlook.com (2603:10b6:208:23d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend Transport; Thu, 26 Aug 2021 21:18:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b58a0555-7e22-47ae-b0d6-08d968d71379
X-MS-TrafficTypeDiagnostic: DB6PR0301MB2182:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0301MB2182E51AE0BAAD6EE78623C096C79@DB6PR0301MB2182.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJh3Qo11Y4B2EGpGGC1z3KDSU3NnUUuyVohvlzFlitMfLzYWtXJCdQNRTu1BAO66MvU261/Waqlbn5gqFuXmC/jhl/uZE3rOovX1RMLzE3fB7sfN3NkEuEYjFP/VC3QeTcHYBvOKkFb5mS71lU1w3+AzZkRAiXASdRky78Kblkv7ycgQ2LTd/1vO06iD8lODSlmlK1QcjSD21sSoIDV3zepSSoOgF4gQc5lKLeHobJWww5IGKnC6u6gVcb/6+RKD8kqKKreZkq42UYVxl8+jlWShEmeMG7skbXhw/lLT013UrL5eQ7Dj7HFHxJuF0VnLE0jU5C2FXiDlTc6xtAA7hU8ErrKTB8wkYehbNOKI8hA/hCBloeKk/qkzx8N+0WOBDgKQjMThwt/g0gvvVkbEgP57N8Dh8iIUjLB2KQro4secB4EvEo6UiLEy5wZCkfCO1JkIWcajOCnHhoazi4KGdYzB2+23yjDGn4Eao/MQhAibKLXwVO4zFxyakf3q5bmsnolrPUddgnD4w26xXCjhnoEh1PJ/5avgM6zcboXtBtrfXCcwNsZTGjDpG4/xHvLBj5MtWT03/nj8RV/145TSuWAQKqj1K6HYMMH9AVwTSnCoxBw1gU0wqhJCv3MfqR081fLL+INlGl55f5juAcBOhDvR6XacAslvBI4NSdtjkNxOGDCywaq15gCjbuFPTS5Hu0PvhQ5KUCK/zVjhaMCYbTetzL3HzX9mEMC6U5UXJmJy0CFfoQoBVuzW9Rkvs0Mb8MayWpVBCdQNyhpc24E3KyoxaC3BC31CMxCiPNUZMkI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(136003)(39840400004)(36756003)(5660300002)(38100700002)(6506007)(38350700002)(966005)(44832011)(478600001)(83380400001)(6916009)(316002)(2616005)(26005)(86362001)(54906003)(6512007)(956004)(6486002)(66946007)(1076003)(8676002)(8936002)(6666004)(7416002)(4326008)(2906002)(186003)(66476007)(52116002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zimzdMI0k3sqcMxCNHNQzqo/WNZ8ZidkfGwxlgxnGVbXpSqLshMaoS3MvC5y?=
 =?us-ascii?Q?WOE5Ln3Z5b/3cAdciRNG45vfs4iry016eILShxZAEBcJ3Jv4CPK8k3T7Muf2?=
 =?us-ascii?Q?LFinZ1JUc4Z7jHR1ycutNWI+PWX+WehzUHR1dwUEqdDQ/TrfgmmeceQK03tL?=
 =?us-ascii?Q?S2+XSMBAXzdD8REz4sfzD62FlUMb3Dm5Ok/eVXxPgYmlhvBHW8PK+UUe+HMm?=
 =?us-ascii?Q?FoXoglsbpL0r3HNj53iJAgb2P86vpfVUH42nmkPW1Wr/g5qyrZW8w6LTOe9+?=
 =?us-ascii?Q?XmkM9EYrgaDCqiEPU3jQcC/A8ro8j6J7Ob2KdyqdfM3g70YR+wJ2HhWsDg0y?=
 =?us-ascii?Q?xdxrbB8d2rwharfSehMMXQ5Oeo9DkK0PpRURSfoUl+tTZTjrKgDKmhGzU9YV?=
 =?us-ascii?Q?p1HUyNS5gKc3c6LLoQoN4zT3c9d/TyGJy6Vscjw44yKVfAjuGtPHMtGRoT3D?=
 =?us-ascii?Q?KYq8TDunrm5nKPvyW9BYwEU2D6axB5Q4Lt3kAo1XlfOUkWFdMObo2zkoVsQ+?=
 =?us-ascii?Q?VSkZrS2HgLZhdwke3bOnpK4O6/3cRc3iFSeS6SMiLhTwFuPhz5/f/jC0+4x4?=
 =?us-ascii?Q?JwVv6knRxK63pgIbPJH2DEYYlUEjvHtFhFG6KrmC9lR+bJFyPx9y33+BQJE3?=
 =?us-ascii?Q?7Wp610qn8SQ09fQRM4Sltd3PYkZtMhlf1If2ezeOD+2qL+Avu+jRKfS0hOHq?=
 =?us-ascii?Q?SWntnXy2GC0BteAiK9OH+zJnTJ8GSdx1YCIeUchwNbcIOsU/jz2VnCxdbsrs?=
 =?us-ascii?Q?92uvwaqtjuLdrGbC8tcOrAzrxu6PJ+0NYFU5LkJDq/zBxm3jKo+jGBNgeRrR?=
 =?us-ascii?Q?f8yd+IY5FOSnERN5od98Vx9JqvNKt1EMP9c+35UnzR2WXmVPulJovea7+2S3?=
 =?us-ascii?Q?UWwiP4UzCbvOQ3NcHxUHZPW1Qfr+d8C+lsmz1eAEEYAu/Sw6bxCXmJTQeKQ0?=
 =?us-ascii?Q?BB10v+1yhsbdXRD3X5ife4GkuAmkaGyAtBKl3DcTBAH+0T/4/YxhLTiaBmY1?=
 =?us-ascii?Q?8/s9ZVbIdDOhB3wZk/DcZHrYOtUYytzstaZ5R85A+xJsoBJWsfHotU1ZKV3k?=
 =?us-ascii?Q?DE1deEmYUHmqmHQ+CxV2L9rkqfh0Vo2ACsUbAJfHxzuos18fuSchqH0rcZRo?=
 =?us-ascii?Q?nS30QyMpJ3BZ/gfxm/sh2d6XO2jFssWF5s/vFjYaYTVeKmUeCGaftZpnB2MU?=
 =?us-ascii?Q?qTeVe8XCeIaDTZjEoMG9Qc5MUexSslWpT5gLp1pBbkfA+YJP4QbFTLrPF1QJ?=
 =?us-ascii?Q?epdeHIq/U8xd7hCUn7DKTQ9BqbJ5Bf/U4zCp9JzHNnmE1tcrNZyqXOT6+WSd?=
 =?us-ascii?Q?+ntWTEC+f8qSPD+kVaPcoMFJ?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58a0555-7e22-47ae-b0d6-08d968d71379
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 21:18:40.5064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLECfsUWBvyEZRBuQDnQas6VSMGPbFaRsD3Qpp3zS7y7hzWirUyAB446sqSMi39J6oQQjCzzV1MVkeylgi6Qbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2182
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is a
"soft" block, so it has some parameters which would not be configurable in
most hardware. This binding is usually automatically generated by Xilinx's
tools, so the names and values of some properties should be kept as they
are, if possible. In addition, this binding is already in the kernel at
arch/microblaze/boot/dts/system.dts, and in user software such as QEMU.

The existing driver uses the clock-frequency property, or alternatively the
/cpus/timebase-frequency property as its frequency input. Because these
properties are deprecated, they have not been included with this schema.
All new bindings should use the clocks/clock-names properties to specify
the parent clock.

Because we need to init timer devices so early in boot, we determine if we
should use the PWM driver or the clocksource/clockevent driver by the
presence/absence, respectively, of #pwm-cells. Because both counters are
used by the PWM, there is no need for a separate property specifying which
counters are to be used for the PWM.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v6:
- Fix incorrect schema id
- Enumerate possible counter widths

Changes in v5:
- Update commit message to reflect revisions
- Fix indentation lint
- Add example for timer binding
- Remove xlnx,axi-timer-2.0 compatible string
- Move schema into the timer directory

Changes in v4:
- Remove references to generate polarity so this can get merged
- Predicate PWM driver on the presence of #pwm-cells
- Make some properties optional for clocksource drivers

Changes in v3:
- Mark all boolean-as-int properties as deprecated
- Add xlnx,pwm and xlnx,gen?-active-low properties.
- Make newer replacement properties mutually-exclusive with what they
  replace
- Add an example with non-deprecated properties only.

Changes in v2:
- Use 32-bit addresses for example binding

 .../bindings/timer/xlnx,xps-timer.yaml        | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
new file mode 100644
index 000000000000..5be353a642aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/xlnx,xps-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx LogiCORE IP AXI Timer Device Tree Binding
+
+maintainers:
+  - Sean Anderson <sean.anderson@seco.com>
+
+properties:
+  compatible:
+    contains:
+      const: xlnx,xps-timer-1.00.a
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: s_axi_aclk
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  xlnx,count-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [8, 16, 32]
+    default: 32
+    description:
+      The width of the counter(s), in bits.
+
+  xlnx,one-timer-only:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    description:
+      Whether only one timer is present in this block.
+
+required:
+  - compatible
+  - reg
+  - xlnx,one-timer-only
+
+allOf:
+  - if:
+      required:
+        - '#pwm-cells'
+    then:
+      allOf:
+        - required:
+            - clocks
+        - properties:
+            xlnx,one-timer-only:
+              const: 0
+    else:
+      required:
+        - interrupts
+  - if:
+      required:
+        - clocks
+    then:
+      required:
+        - clock-names
+
+additionalProperties: true
+
+examples:
+  - |
+    timer@800e0000 {
+        clock-names = "s_axi_aclk";
+        clocks = <&zynqmp_clk 71>;
+        compatible = "xlnx,xps-timer-1.00.a";
+        reg = <0x800e0000 0x10000>;
+        interrupts = <0 39 2>;
+        xlnx,count-width = <16>;
+        xlnx,one-timer-only = <0x0>;
+    };
+
+    timer@800f0000 {
+        #pwm-cells = <0>;
+        clock-names = "s_axi_aclk";
+        clocks = <&zynqmp_clk 71>;
+        compatible = "xlnx,xps-timer-1.00.a";
+        reg = <0x800e0000 0x10000>;
+        xlnx,count-width = <32>;
+        xlnx,one-timer-only = <0x0>;
+    };
-- 
2.25.1

