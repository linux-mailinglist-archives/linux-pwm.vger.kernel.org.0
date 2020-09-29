Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3953927D2CC
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Sep 2020 17:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgI2Pd2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Sep 2020 11:33:28 -0400
Received: from mail-dm6nam10on2051.outbound.protection.outlook.com ([40.107.93.51]:49249
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbgI2Pd1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 29 Sep 2020 11:33:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9Vw2pfLGqWkXDazY3g3pPWj3LFH90B4zdfJH89Wsl04uOLTc4slj5EKDTVqmsRsBcYLL/8ZqLFQVP0/ZLxlSteYdNtqZM4mVWAS+BxRDMujsgL2hxoVybqOECii2rAwvwJpyzuCQ7kB0nxHyuAF09aKh91Y3eXSHCfkQp5Iv+UjLT7q0N34i4x5ocuOifWkRPSNcth8s6TeOfO7ZElslLqlrcojIeX85rxjjB3cykpqYcI9A2OUv/R40MJ1iq4uCQ/89ePB+Y09WzQTflGkoxBQrhMVzTWCGrtP4N9U4Qprcy9ZBiC5sJ43akkqrjWUjRToMP4RVOIoS58n5xEasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVLi3hm8dY8UAaD88swyGcKhsfg8xrioM5NGLIP9jHM=;
 b=Mq8naD86rqlP+pvEClvThFyY7Z1jigXU+tdCEADQpwTY+y/i+1ILgkXDDItzgy10Mr2s0qgDBhT3hTMJNCYeGqUqu2Kvp0Pr30QnyOTvDNGRpEL43GmQVViLdeRjQOD9v89lt04qd3FP+SilX5kumnFPln+qw0HWAb1+snU84Nk1nEYOTFy1qAkj5gechSPshMetp5WglEow7SE5y7ELLzuklnHgGN402sJybu3o7/4N0J/6+5cTt4cFNWWocEVN+iQTSHBNdNcALBVf7knW9w5a3S89IAidG1RpAqiagwXcP0RWravv2Rdv9CvRIYN35fJdZ3/H9JaGlL0QsjTW1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVLi3hm8dY8UAaD88swyGcKhsfg8xrioM5NGLIP9jHM=;
 b=lgMMMP9YhLNvw6lrQX80hUTZLyfpBXO6x2nluI/5gLtAeM3WQM6EttmBQ2c+lgeUmoXpOh/cA9HQ9aaZbgjpZrPrJXMznWj3FSng7RmF9bX5FHFSDgXkSSYCpKXgQLJTyWuIJael8fkumucINaihy8MwulOsi7zBtkmVZkLNz/Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM6PR13MB2412.namprd13.prod.outlook.com (2603:10b6:5:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.14; Tue, 29 Sep
 2020 15:33:24 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 15:33:24 +0000
From:   Sagar Kadam <sagar.kadam@sifive.com>
To:     linux-clk@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        aou@eecs.berkeley.edu, yash.shah@sifive.com,
        Sagar Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v2 1/3] dt-bindings: fu540: prci: convert PRCI bindings to json-schema
Date:   Tue, 29 Sep 2020 21:02:09 +0530
Message-Id: <1601393531-2402-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601393531-2402-1-git-send-email-sagar.kadam@sifive.com>
References: <1601393531-2402-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-Originating-IP: [159.117.144.156]
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To DM6PR13MB3451.namprd13.prod.outlook.com
 (2603:10b6:5:1c3::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by SG2PR02CA0101.apcprd02.prod.outlook.com (2603:1096:4:92::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 15:33:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeafea32-6ad6-4c44-75c0-08d8648d0120
X-MS-TrafficTypeDiagnostic: DM6PR13MB2412:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR13MB24121FEE6F0C10A730CA748B97320@DM6PR13MB2412.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lSY30/lGufjhArTjubrX8YweZ7f39kMG/tljBmWeTko0SN4yooyh8pJlQbDn2+QeLqdwkORJ2gKOaI2ovPf1zJD6ueU6LaOePaXUFE66IhDZeI7S+STPGL84j5KOR/O/BjPkFSs0aLHrIoOoHRkZOdmddRSKW+yaHJTYuc7pFgKi9vYQV1xjJeYocxnWYnr2jUrUTRv7TSe44mi2jpVN7fhnnvvayTtTkol2O3vTWLmcoIAxfTFObzNyjPDl2tQk8yk7alnqA+oKSJQWAkpo2DHNjrNA0JmiEKX6D0QblkLeWvwVPoQJnk1lOSPv2RdBO1FY+KfA5iIjNfydVDOIwlaNMFPyeRZ5ck0flXn4cuOEs9rUU/nugjn+L+2zS9dCNlNtiOiLzFKzz3NOr1Zn9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(376002)(39850400004)(6512007)(966005)(44832011)(83380400001)(4326008)(66946007)(7416002)(52116002)(8676002)(83080400001)(2906002)(5660300002)(107886003)(6506007)(66476007)(66556008)(83170400001)(6666004)(36756003)(8936002)(2616005)(478600001)(6486002)(956004)(316002)(186003)(16526019)(26005)(42882007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5ajK3skSfIGikgPF5RQoSGOya3TpQOIwKt4TIXg561V0mVDDTyAGIEa1uv0dCgaiuVWltyOzjofJuUar/b8eBk2Ek4FqvqQ7ZqysVnCRSmDohalMa+IVFThsK2n98hIsCnvTivnoY9mw9BuUd3ymkczjfzv/MbeIxzZVXZ2FAy6uLSIqGP2RPWEPAKq4leXvadnCzs+zuV7ckO2Jf2lNrbNEIFlkzne16RH1KjexxqxJpVo8Czpcd6JNEuZ5bY1FfqKANGrEX0dEs2rW/q39och3GkS9Gup2Uwjeap7+s8KgZf38SPAMgv6+14/zhoX27oWYVV4VHnZIhu4fw6KTql3FUQo/nJ2vpMjt4klwixg0KBdFERlJ+DceMkN6YuZUhD1gR0o8G/qgNofvofi4j33O+Jdd1vbpAzpwVCWx4+Tz93jEZ/beRz2QoTDA2QFz3SyIw5pAxPblYXNpO2rI+Nnuu8NA4NU7kpkTYaPgBt/er/W/Xo/4Gi3FQzmoJp4PfJYcN+4UaMKFKZNh0CoQ2ZmJfHxx3D1L9ZhjKGo0QdhNl0PNS5gzWLsHHSd4zKM3nELOTMGNx7986KpsrpqvScbBM6xUcQ8KXaUNYY98DGwImtgB9SOFs0m1T7Mqj65QCFg75qKnvVn6dPSyAquw9Q==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeafea32-6ad6-4c44-75c0-08d8648d0120
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 15:33:24.7184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoR1K6CU8kZCCkzKiF/nHZiF9rOCdbDRr0egfVpBopy+fhcQO6IpgA/bpf6PXsTCldqMG7r6V+84IiTI/n/DyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2412
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

FU540-C000 SoC from SiFive has a PRCI block, here we convert
the device tree bindings from txt to YAML.

Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
---
 .../bindings/clock/sifive/fu540-prci.txt           | 46 -----------------
 .../bindings/clock/sifive/fu540-prci.yaml          | 60 ++++++++++++++++++++++
 2 files changed, 60 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml

diff --git a/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
deleted file mode 100644
index 349808f..0000000
--- a/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-SiFive FU540 PRCI bindings
-
-On the FU540 family of SoCs, most system-wide clock and reset integration
-is via the PRCI IP block.
-
-Required properties:
-- compatible: Should be "sifive,<chip>-prci".  Only one value is
-	supported: "sifive,fu540-c000-prci"
-- reg: Should describe the PRCI's register target physical address region
-- clocks: Should point to the hfclk device tree node and the rtcclk
-          device tree node.  The RTC clock here is not a time-of-day clock,
-	  but is instead a high-stability clock source for system timers
-	  and cycle counters.
-- #clock-cells: Should be <1>
-
-The clock consumer should specify the desired clock via the clock ID
-macros defined in include/dt-bindings/clock/sifive-fu540-prci.h.
-These macros begin with PRCI_CLK_.
-
-The hfclk and rtcclk nodes are required, and represent physical
-crystals or resonators located on the PCB.  These nodes should be present
-underneath /, rather than /soc.
-
-Examples:
-
-/* under /, in PCB-specific DT data */
-hfclk: hfclk {
-	#clock-cells = <0>;
-	compatible = "fixed-clock";
-	clock-frequency = <33333333>;
-	clock-output-names = "hfclk";
-};
-rtcclk: rtcclk {
-	#clock-cells = <0>;
-	compatible = "fixed-clock";
-	clock-frequency = <1000000>;
-	clock-output-names = "rtcclk";
-};
-
-/* under /soc, in SoC-specific DT data */
-prci: clock-controller@10000000 {
-	compatible = "sifive,fu540-c000-prci";
-	reg = <0x0 0x10000000 0x0 0x1000>;
-	clocks = <&hfclk>, <&rtcclk>;
-	#clock-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml
new file mode 100644
index 0000000..c3be1b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 SiFive, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sifive/fu540-prci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive FU540 Power Reset Clock Interrupt Controller (PRCI)
+
+maintainers:
+  - Sagar Kadam <sagar.kadam@sifive.com>
+  - Paul Walmsley  <paul.walmsley@sifive.com>
+
+description:
+  On the FU540 family of SoCs, most system-wide clock and reset integration
+  is via the PRCI IP block.
+  The clock consumer should specify the desired clock via the clock ID
+  macros defined in include/dt-bindings/clock/sifive-fu540-prci.h.
+  These macros begin with PRCI_CLK_.
+
+  The hfclk and rtcclk nodes are required, and represent physical
+  crystals or resonators located on the PCB.  These nodes should be present
+  underneath /, rather than /soc.
+
+properties:
+  compatible:
+    const: sifive,fu540-c000-prci
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: high frequency clock.
+      - description: RTL clock.
+
+  clock-names:
+    items:
+      - const: hfclk
+      - const: rtcclk
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    prci: clock-controller@10000000 {
+      compatible = "sifive,fu540-c000-prci";
+      reg = <0x10000000 0x1000>;
+      clocks = <&hfclk>, <&rtcclk>;
+      #clock-cells = <1>;
+    };
-- 
2.7.4

