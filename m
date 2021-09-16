Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC3540E98B
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Sep 2021 20:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344443AbhIPSIP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Sep 2021 14:08:15 -0400
Received: from mail-vi1eur05on2068.outbound.protection.outlook.com ([40.107.21.68]:9952
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352097AbhIPSH2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Sep 2021 14:07:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C25e1lqUbMMussbB0k51FG9pNL8nL9diMVPlN0oWgwHx4iv2i07EakS5Bg1k1U8rYfuojenads9bXFpON+5S/Y/GwlffrIcUWfw01e9ks3ZiY26n8CtTrijA7Qd4Lf/NHElNMHUHQO0XOrNlEnFGh5YZ9408gUea/JDhB2QQAOEge5HyPum4j0vO0hpJP16g67QbXslj53fm11AWap+AD+aWPcBzNNRyB5D9oZx8DQ2tvep7XtxC/3X8HlBfbFuCdQHxzkg0YV5/Qe6dThNvzS8PObDvT+jnmDdG+MMLybYf90jTqmooiGGrN9H9ay+uRiWBofqTMCi7G+YkBNqzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WyhbSOSfEtDxaR2RvJRtSUw3v0beGqXuYd/PyVIP5g0=;
 b=S7evU3TmWqLVeCUAGPtnM5jxrK7ytPM7YP+tdzKxtMpXDmt2qm3xbe+Wy/FLhKBjkVIsd82W4JHyqe7xxIkuoRlFULdTWkliH7OaXS4fdCSsBMzOcvQJtGmQQ/PkTVsRBE2/Sfex1uacXCTqbDUSDZItD1/fY5WCdSlbGP8s8Sph9hRcjRfwLO8lZhOvWX6IpEDJ1UDVQ62gZZJpUqN+p23MC4zf474NMplkvDhqsJKiu84oSn+8qOQHJc3Y7mmcARvoNuHCoGr9v7H84IS9q6BZBsAW6kVC6TKgeUague1kxxKzcV3nLIEOsrm2EEKwiUN19U/VPH5uTLUq8zW5NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyhbSOSfEtDxaR2RvJRtSUw3v0beGqXuYd/PyVIP5g0=;
 b=aL0f9L75u42rg3WAXT+Wtaih1fgiGISh0qB2lS+LNbW+7iNCQtO5vBP1f+6a9kryEglSW10HH82fKwQfHAS7Y2IiuN0Q7nLFpL+3u2hmnDsN786yx8zZsZ3rIY2RhLSPBK4zhgdV2ZJqgZHsr8td6xfD4IbODGKlRpgOKUq7Dp0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBAPR03MB6470.eurprd03.prod.outlook.com (2603:10a6:10:19f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 18:06:04 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 18:06:04 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, michal.simek@xilinx.com,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/3] dt-bindings: pwm: Add Xilinx AXI Timer
Date:   Thu, 16 Sep 2021 14:05:41 -0400
Message-Id: <20210916180544.2873770-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0051.namprd19.prod.outlook.com
 (2603:10b6:208:19b::28) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR19CA0051.namprd19.prod.outlook.com (2603:10b6:208:19b::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 18:06:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c54236e-7859-4125-4d1e-08d9793ca655
X-MS-TrafficTypeDiagnostic: DBAPR03MB6470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR03MB647036F7FD7BEA6C42C19AD896DC9@DBAPR03MB6470.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gQnKpiM+M5ohdUk0a7ki4bO93NzdVEHOSs+aSKL1pldz19e8vyiYZuKy7MXId5NvfcrJe3mHhpa4YfJZsuzSdie64i3xPWMhG5VXFQnI9JJh7OhWJcaQRW+4FzmuTXfDlG64DiBWaYzqhmr6tFSfm7qQ6MLhbMojVo7pNraP/grV7mCGoLPiHPlwLy5i2R1vJ5ChLj0NYVGpC3BDbz7ScyTFT/+A6zeMXbR2QdVaqYE1Pqsb8SKWy3FtO7NzQqV83Iy1rHvZQkhje4YriR6hPkARCm5p2aJlRnw5j9FILqDwofZOQTyEagzjfQV+DzC5YPZMYRZ5VzxE3slAK8ZaCyOAeimSDYg/G0nNq9RUuJC957dQlSrrT9BSRBT4BxAapLor0lBCfgiBGLrZiSFcgpEs7tO63q0FLg7Q9pwEWbdmNgFBCyuPF97QZ0V9SuVWjAem10qcEDyCIFbGdqdM8s+hM1+yGxtNs32Ndy3k7aEtZ+aNTp77atx/a3BgQxqHmdv0QtdGwIcNzVs1SX2xZ3vpAmwrZpTgQgmvdFKPsPBGsEM8fFVaGbyXSKAlmr4AC039DljwaxNjAdsL0QC9fOxK2etipnA39xeP6MSnz2sPG+CkZIj17CRCKqHrr9/6QWwcUBB7GIsDGxnOwpbePtnovCEPeycIKyfcg7en3dG7QhzmvQwCsylmRww1U/ePtScV9zV+qZOBMqmPIH28R0JFudonZ8hWgc5RkGuaC4ytViC9abqAOuh4QC5SUg9meJGqfNiTppvnIfM+tl1xyEBBQh2A9ZdKApxvSp6Txe4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39850400004)(366004)(346002)(396003)(376002)(966005)(6506007)(36756003)(6666004)(54906003)(6916009)(316002)(38350700002)(26005)(4326008)(66946007)(8936002)(5660300002)(2616005)(956004)(7416002)(478600001)(52116002)(83380400001)(66556008)(66476007)(44832011)(1076003)(6486002)(6512007)(86362001)(2906002)(186003)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I6CnB2kPjSEaWjhmS0yLMRf6kHaIkHWH5KcxHrHVHe6ckkIbYYN8Dc4zbU10?=
 =?us-ascii?Q?dKL0c/b7KFekdUz0ClbCGebwgHOLOlcMh8rAGMMNs8hwHQrkAvpGyB7HN5Ab?=
 =?us-ascii?Q?VZ5ETN2Kbc9aAAHc8bPYODnTZNZ1tcSAbh4g78RKReO8DvGEwWYrVk1dGBNr?=
 =?us-ascii?Q?DIThgv0JMnJyZgb3rFsAMhdPjKlm+WrT9BSGXXENEHK0VMFrOqOlltMen9Zp?=
 =?us-ascii?Q?We8T5GkxaIEPFcuMYHjnunEg/mSWUxEc011V5D+ewVvKKANF1YaDH2IJfbvJ?=
 =?us-ascii?Q?2oBAcrGrNHuqL2KTlJPbOw1O771F8d5NFYmLhqUbMXnVMQ/kaul4j+YCDp6A?=
 =?us-ascii?Q?0AGXQcnZezfezq330/9FGBog/fcNzjnBLqK91xo85RGkBcRhlAD14YeK2MTn?=
 =?us-ascii?Q?JLqFmLCaGsn2r4gbhyJcsFqquaNX5zJVl/WFLbDH7vs9u9cQ4eJs8BxTcMNL?=
 =?us-ascii?Q?AXIcWcCfUbiAznwG4WkRL95mN68Uk4ZPKCww8fkVlWCHa3WqjRRYmwl3GAyU?=
 =?us-ascii?Q?nmDEvzypMcNXblGTKb/Bu120N9JVQJq6IapAOZJFPy4IpQcRtMwzGv5WuBFW?=
 =?us-ascii?Q?Yux/vHSHcdlIU/HDSSmv733FrMiXoHztwYXneOQry7GuD++cOz7kYP2rpTBu?=
 =?us-ascii?Q?xmJgSYVwQoTJeXAmd7VOgeDBKkbO9umbMOfLwRGmQaVBgfMFXzhD3kxVlRr7?=
 =?us-ascii?Q?68EcpGm7IahkX3ysI3LVxh+wthY5M407xVt5SYyg8O7gYj9AAfMBN40B+t5Z?=
 =?us-ascii?Q?u6/+9DKghEcZiq2YetL1oYBaeXMPcD25SgvQhjDGUP8CrOOSIXQHH4PI5er8?=
 =?us-ascii?Q?XUesolrSgTAEX5QSEDg0qGG6gyoUnOxCGtYvr2qZcVBWTpygufky5vuHYGvj?=
 =?us-ascii?Q?bY4BWNmZHK8RRE25VpqWbUuB1+OqiRXAs4J7yBcS6OPL0Z47di6VWGRyHBqX?=
 =?us-ascii?Q?j7ukJvLMxzPXzphCj55M6DFjvNLYkk1eP19K88Ncm+pkb87WdEL4yaA4X5TU?=
 =?us-ascii?Q?jLjjkH0iVfC00GKI2ohYWD7sKhciV3x/HQ4woyZeZS2e8QNUVY0STLSX/FQY?=
 =?us-ascii?Q?WWgHnAXnDw1gzYtOD5tR8Bjkj1ELmcjHSWDslFtyTPVRfEcdeMDHYCyiGSwk?=
 =?us-ascii?Q?CRnoYrY0yi7T7xQhvl62N79GKqixLdhhwl7Ic+ZU9pER0R1oig+G5yN8htpG?=
 =?us-ascii?Q?IXYc4cRGXYlHm1pWjm7rFd4Dzvu3OcRjEavycQRJpa2dbFbkHD6kqwYYcAQK?=
 =?us-ascii?Q?hMLAzlhdZFkoI15kJ1SKZFPngomOhpfH1yn7vup7RooWeP2bCbicoZQ42Ahr?=
 =?us-ascii?Q?5+48k93z6IUeerh/Y+PYj4su?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c54236e-7859-4125-4d1e-08d9793ca655
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 18:06:04.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h58swTi+q66MdWAFDIyzHax3ejxbzpqpi/+uPxZpe8W0ml3prIcskUvB8hLJZhu7G3KASwD7ZG8QThnVU1VVEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6470
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

Changes in v7:
- Add #pwm-cells to properties
- Document why additionalProperties is true

Changes in v6:
- Enumerate possible counter widths
- Fix incorrect schema id

Changes in v5:
- Add example for timer binding
- Fix indentation lint
- Move schema into the timer directory
- Remove xlnx,axi-timer-2.0 compatible string
- Update commit message to reflect revisions

Changes in v4:
- Make some properties optional for clocksource drivers
- Predicate PWM driver on the presence of #pwm-cells
- Remove references to generate polarity so this can get merged

Changes in v3:
- Add an example with non-deprecated properties only.
- Add xlnx,pwm and xlnx,gen?-active-low properties.
- Make newer replacement properties mutually-exclusive with what they
  replace
- Mark all boolean-as-int properties as deprecated

Changes in v2:
- Use 32-bit addresses for example binding

 .../bindings/timer/xlnx,xps-timer.yaml        | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
new file mode 100644
index 000000000000..fa2f9b27018d
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
@@ -0,0 +1,94 @@
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
+  '#pwm-cells': true
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
+# The microblaze devicetree contains additional properties:
+# arch/microblaze/boot/dts/system.dt.yaml: timer@83c00000: 'xlnx,family', 'xlnx,gen0-assert', 'xlnx,gen1-assert', 'xlnx,trig0-assert', 'xlnx,trig1-assert'
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

