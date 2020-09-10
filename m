Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A836264485
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Sep 2020 12:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgIJKrJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Sep 2020 06:47:09 -0400
Received: from mail-dm6nam12on2075.outbound.protection.outlook.com ([40.107.243.75]:54274
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730309AbgIJKpH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 10 Sep 2020 06:45:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yjy0HS5G36unS4bTJm1hEvy2mSKtc8q1lH9Q7sYino1L/FY8zVqrFEASOJFDVJuabutFuHzGs1C7W6jmUAhEMIA6BYajTiZTsBhxz02VgzMYY3D84mQurBfSVFGUJRF+wBAAO+MJWW5UT5CCbPnjB8XTXLfvnBPUROKItO4POYhU22m81d2guLFJ3idSvlAKeXHLtbddyr0Ay71UyeEf9fYhJgS3QG7ttubj/nqaj3ovhZ3XvmA0Ke9cN6MIATQVo7DkEO3eXHeRParfSLZO6GxFRuFp4ZvZSy8c/kDgXYT+ml6UwoIt/WQ6Bbb+MHmtUsk4mhtnQyth79wuLbQIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/Y5UFAS8jg3hwNSRezgrUk3SZSrwCM5pFV1VsZZCQI=;
 b=XrBnKt7RMaPlFReVL48VJEWPz1/M9G8WQt1OU/+XZB5EoTt6R9XO8Itm/vTs7X3wnpg9Swz18cjS5Bmo/bSQ5Q2oXuRfe9EdEF526hZmGzKK7jn3dtVtxgkmTvfEQyqnpp9Zz2Xbdjh3DPccTkNR89Ih4Tu1jYr+v+3Vjx1rZx/zp5vR6hlY5C8IzRMEc7kT4UNfs8V4nbDKSGBUCsbW5Osk8BQCE690zxj+TxDx3LY25ItqA/x4UEbdz2c0BZZbLeDSZVXHXkHC/meGL8nOF5EvXdHjHR3l92So2LYGaCAaBYIOQt43HKh57cpeJmIXsdZVJwaU+rBfcHxTLzLNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/Y5UFAS8jg3hwNSRezgrUk3SZSrwCM5pFV1VsZZCQI=;
 b=A5DZnhujmkNu74Ghz6Jk3NKlqXTyrOulr6GRI83465llCTEp1jBbDvx7xn8dPlvDQLemRXPP7hEGVNIxlImr8tZUg/31qiHCm2dx8eOcbDVK1ZQAfyNVCY/Esx9OvCIWZBGpk2RSMPhoyXdSd/F1r2lfi/rOoOEUWuH/fCVt6z8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM5PR1301MB2106.namprd13.prod.outlook.com (2603:10b6:4:32::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5; Thu, 10 Sep
 2020 10:44:32 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876%7]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 10:44:32 +0000
From:   Sagar Kadam <sagar.kadam@sifive.com>
To:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        aou@eecs.berkeley.edu, yash.shah@sifive.com,
        Sagar Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v1 1/3] dt-bindings: fu540: prci: convert PRCI bindings to json-schema
Date:   Thu, 10 Sep 2020 16:14:02 +0530
Message-Id: <1599734644-4791-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599734644-4791-1-git-send-email-sagar.kadam@sifive.com>
References: <1599734644-4791-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::27) To DM6PR13MB3451.namprd13.prod.outlook.com
 (2603:10b6:5:1c3::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by BMXPR01CA0087.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:54::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.19 via Frontend Transport; Thu, 10 Sep 2020 10:44:26 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efee3447-8780-43a4-a909-08d85576801d
X-MS-TrafficTypeDiagnostic: DM5PR1301MB2106:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1301MB21067E2F2BF9E73EB198139B97270@DM5PR1301MB2106.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ncxYyA2RS9/LZ7/7Z22wEsDQpkNVPp+Ro1qeG2pIvBDjK0U68Y5YkrO87ilufXfYpD3g3wXgOqQJK9zMWPEo3XmQ09o6BfhcTE80/Cs8x42h2r5OS7o+6X6+6ez5QV6ApxFGvZjqbM/pcl3LnPZoU0Hr+tQ1IHTin11gMAhsxcS74eh1a9r42nKsSlCT2MCdCRhiGJx2z+GUa8yFZC8Kba/ooVmwY5YCQFjtOId2NxGlBlhRILe/sbvhHrbpFbmZYjfAzKH5ofKKpLKE1MED3o/mYBWesm8zWs7eEu6O3ZH32W0aSdfyFwJtBmfs6hTxE1gt9uiu1DcLmVTznM0TjiD6+LDvivagWILj7wVhc2r8ulwmwTax3qUaCKNtFA1PWu8scFJ249do5yz4oqDilA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(346002)(376002)(136003)(366004)(396003)(6666004)(6512007)(316002)(26005)(966005)(8676002)(6486002)(66556008)(66476007)(52116002)(2616005)(956004)(186003)(66946007)(5660300002)(4326008)(42882007)(107886003)(8936002)(36756003)(2906002)(478600001)(83380400001)(6506007)(83170400001)(7416002)(16526019)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gT2Ybo/8DLkJMLa+h3uxKQymENYb5G1OTOMAJoFE6GXJbV7jLWrQhebrBo9CeFZRGGM0xlnvEH3bxCM8u+vr6kWMChZUObIdxkGDj9e7xyppp3sxQhvjl0LfOKcmjMPU5kseF8TdiEvWVbuJJKwiIAxWYhF1qR51+LBjlVD86/3egxTiRDHwH/zR9qp70Wbk34vji3mV9eQVJspu+hJeJrphcWtH8KDMbNTGwW+BgpVUPWF9VMu4Y6X+lx1JAHmjBR0DApUsBq9EN704+ynN6IpH2WHQ/PN7/3sqN+5vHZGb4b7oGbKzFcmzHFz3NYgLb483Y30lVCPdzZB6jJOU1QrFS91rq5+Qe4g7asnuPZLCCKCGR6e3gTef1swt0S9O9VSoJ/Ze+ovcSQVZKLD9lOXsBT4C5I0B5njzmPndtv7uL78xk0/iWKksplrHlBE6LNKMnqx55FBELuvFv/6iwTvSvN4Dwbl+OKosMmVmogjtm/FV4rjNl/DzTXRKs/8vKoNjs6qSVZhkxlFHCL1AgGoznoPwpsv3xeHvWGhcImRPjOVWRX+8D0qa1LYS7NsVS320mK5i3PdHsBW3hPPte1uuG0vWmwlmNGXUKbzbjDhL3q23yBijg8SiofVJqJbSw8CS4AGpFbC0TwO4YmbzhQ==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efee3447-8780-43a4-a909-08d85576801d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 10:44:31.8863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFKbIT7/FdOkiJsEZPFfb2GZl2fBsSqDjInXUtfsSL0AMvaxInV9MCaRmbzSOqv4tbOV0ZEu5h9BAvYiAXHX2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2106
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

FU540-C000 SoC from SiFive has a PRCI block, here we convert
the device tree bindings from txt to YAML.

Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
---
 .../bindings/clock/sifive/fu540-prci.txt           | 46 -------------
 .../bindings/clock/sifive/fu540-prci.yaml          | 75 ++++++++++++++++++++++
 2 files changed, 75 insertions(+), 46 deletions(-)
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
index 0000000..49386cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml
@@ -0,0 +1,75 @@
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
+    enum:
+      - sifive,fu540-c000-prci
+    description:
+      Should have "sifive,<soc>-prci", only one value is supported
+
+  reg:
+    maxItems: 1
+    description: Describe the PRCI's register target physical address region
+
+  clocks:
+    description:
+      Should point to the hfclk device tree node and the rtcclk device tree node.
+      The RTC clock here is not a time-of-day clock, but is instead a high-stability
+      clock source for system timers and cycle counters.
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
+    //hfclk and rtcclk present under /, in PCB-specific DT data
+    hfclk: hfclk {
+      #clock-cells = <0>;
+      compatible = "fixed-clock";
+      clock-frequency = <33333333>;
+      clock-output-names = "hfclk";
+    };
+    rtcclk: rtcclk {
+      #clock-cells = <0>;
+      compatible = "fixed-clock";
+      clock-frequency = <1000000>;
+      clock-output-names = "rtcclk";
+    };
+
+    //under /soc, in SoC-specific DT data
+    prci: clock-controller@10000000 {
+      compatible = "sifive,fu540-c000-prci";
+      reg = <0x10000000 0x1000>;
+      clocks = <&hfclk>, <&rtcclk>;
+      #clock-cells = <1>;
+    };
-- 
2.7.4

