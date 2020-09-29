Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A2B27D2D3
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Sep 2020 17:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgI2Pdh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Sep 2020 11:33:37 -0400
Received: from mail-bn7nam10on2048.outbound.protection.outlook.com ([40.107.92.48]:42593
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbgI2Pdg (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 29 Sep 2020 11:33:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YH63rmnadopM55OpHgJObL+ytpI1jeY+4fue6kEh3yboeQh3hKdEWlfacNCoNdqI5t9Z5VIAnpFcXrBAnf/C4tPAXBgeMRC6mKqZAgAfraTaXTL4Fz5+CjG/hVnz8Zh4sH8Y+7sBEsvzIew90wiJAONrBt4gDahuqO5esef2oXLylfZPPm1UNMxtyckJqp1r0PHEw4Qmf/Yx+69r/L8TQpaEHDsmcC+oGfr+rGvkmhECrggblb6hbRvDJovHMcIMNVMGMxO3e4VnycSMsDPbjf5gtLic6CxtLaG3aw8UUvBa7ERNx+dbI1g08hqsj3Zs8M4MaqirSdFIX9iniWppKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoIZsdP7InlTxi+nyYDYZW7kYZb9x0R1JD9jtVYi70s=;
 b=kf2pXsNu9vqzj9Y0VXfrTkPnwSg0Vhlhx/3AbOc4kIQg3V4lDdHjrFzVjQMQyKvc5vn4S5os1d6RM1a3Xt/4XkRzepVt74msxhgyRW+VOXtw6aWOVktjU5Kpiy59HZlbWo+b99LuDsk2xp+y7xPyBJ9NSLucZBYJsSvtRTFiKbjscEqYcqVX71CrKFD+UmeEPvBVjYDHSe5Z8ZW6XpRvbLAJ5rkDJn42d/XeHf3AH/9owju1KvRc/G+YiZUX4wWXk3/J2ltMI7CBHjXXtoS2nrNvDT4tDZQ8zK6COsAhq0TvjC8XeScNsD+VAl5kl38JqBb150cF8gpc0BdGaC7EGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoIZsdP7InlTxi+nyYDYZW7kYZb9x0R1JD9jtVYi70s=;
 b=AftxkgviHoYOVMA1dcVnRwL5iPFx2qJHlaq0ZMG5fVBCEVdJyHse4E4d2k8uYZpeZy3VeHCRF0I+g8WU8+BE+gU1XDdCYpcVWrq2APYBU1eXxhDFPkYR84qV1b5T4VOfpIYZU6drdIpf/9emN/Vd4/wFGz9+c061Wt63RByVXsw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM6PR13MB2412.namprd13.prod.outlook.com (2603:10b6:5:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.14; Tue, 29 Sep
 2020 15:33:33 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 15:33:33 +0000
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
Subject: [PATCH v2 2/3] dt-bindings: riscv: convert plic bindings to json-schema
Date:   Tue, 29 Sep 2020 21:02:10 +0530
Message-Id: <1601393531-2402-3-git-send-email-sagar.kadam@sifive.com>
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
Received: from osubuntu003.open-silicon.com (159.117.144.156) by SG2PR02CA0101.apcprd02.prod.outlook.com (2603:1096:4:92::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 15:33:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4cde846-e206-4cf6-0533-08d8648d062f
X-MS-TrafficTypeDiagnostic: DM6PR13MB2412:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR13MB24120EE25A14229A497680DC97320@DM6PR13MB2412.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N8ZkMeF0IGEJqmgYlEjYddVFdJoAHat3FyVL/BGJWBuWkIoFqJVy8kDiMMRq27q9FLXEs0haQmTbgftpvdY5QvwDX5Myy3uqq0Lqpc5R2IRgD1A+rAonLI7C1mFOgUGUg1KVoTc6mu0Ky35MBXXwxYfFZ+5Gdd4hnmVMc05Kv/enArgdUp5fmG5e8giMsHbMtvUxI714GU7EbPqHngJDO5V7WULodxN8jXMX7XsIUPkpG/l/TM7/DmPqafdHf31nvpRHSMhkJEEedMmRLL8WnBijJOP1PfeOkdmiUAgbrlDXsjpwnyNgI33IlqEJbZhGIxEvyqI+6lH0S70ok2PkNnpTSgGcl44NEDAVN1F3t9stsSXuP1693WGrqJFy0Wkwgm8psOpnU+E2gELBl2iEPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(376002)(39850400004)(6512007)(966005)(44832011)(83380400001)(4326008)(66946007)(7416002)(52116002)(8676002)(83080400001)(2906002)(5660300002)(107886003)(6506007)(66476007)(66556008)(83170400001)(6666004)(36756003)(8936002)(2616005)(478600001)(6486002)(956004)(316002)(186003)(16526019)(26005)(42882007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ybG+ME/Jx1lvmG+xSxGUNyUFfJLzUf0bu2mFJ8GfPdm+T1BhlTA1TJkAI+vpItkVBGj3qvHpv7qImJuxnlTgxLjEeCh9T8fVqnB+IfK66aylyBuXD7wpLtDvjFaLmTq1FQ49cWzuNkSvUGrkTVb559dH/GXHGEOLJhkiF9zyJDNUqPEdjjolJKoYT9AYFYGBHoXDKsLh0sX8pAl5WVP07nHOMQVsAD7Ge+6Ri2YZ+JbvtEnzFl47z5NQktr07KDdjYVZ9wiUiaAVZsMF1DoLhbvfakavm4Tvm9vWWl79Qt8d4w27uyDA3yB9Mo5fQrLnVQ0dVGb+StgGidAG2gceixsocMnbNdEpIdObpjCWuGvaZcXRwPXBJ+0aa24I1wEQxnjcR5wXWWOoyXynsEWHZMuRIoOhnYJ0qfbY482CNcPe7iavc3sxdZwvkqJe10k9bRGMw/O4vL6z1MeqHwKpBZIC7k6paplybA/ePzx0/oNnZNWXofOuR/u6B6mi0rRUYvWFw4MTPTMkSTJpbTyn+IKCs1mZtrdAYs2bLlMd04uHMm+IYQsN/wIwbTqe2dhacgOfxfUVJkqWfHNSqpuMd5KTqAay1Utyyziglp7Xqpxei6Q/CKC9AVUzfscVjbmICXwtY1ACmFln7zwACvjL3w==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4cde846-e206-4cf6-0533-08d8648d062f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 15:33:33.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWYzfbzJzvgHYqOE1yl/+UP7d6uaA3zDXnboOMyCCFMPewGI8/TB40KMwH2uOs4W9zIH3XvRON3OCFjZBYbx2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2412
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert device tree bindings for SiFive's PLIC to YAML format

Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
---
 .../interrupt-controller/sifive,plic-1.0.0.txt     | 58 -------------
 .../interrupt-controller/sifive,plic-1.0.0.yaml    | 97 ++++++++++++++++++++++
 2 files changed, 97 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.txt b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.txt
deleted file mode 100644
index 6adf7a6..0000000
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-SiFive Platform-Level Interrupt Controller (PLIC)
--------------------------------------------------
-
-SiFive SOCs include an implementation of the Platform-Level Interrupt Controller
-(PLIC) high-level specification in the RISC-V Privileged Architecture
-specification.  The PLIC connects all external interrupts in the system to all
-hart contexts in the system, via the external interrupt source in each hart.
-
-A hart context is a privilege mode in a hardware execution thread.  For example,
-in an 4 core system with 2-way SMT, you have 8 harts and probably at least two
-privilege modes per hart; machine mode and supervisor mode.
-
-Each interrupt can be enabled on per-context basis.  Any context can claim
-a pending enabled interrupt and then release it once it has been handled.
-
-Each interrupt has a configurable priority.  Higher priority interrupts are
-serviced first.  Each context can specify a priority threshold. Interrupts
-with priority below this threshold will not cause the PLIC to raise its
-interrupt line leading to the context.
-
-While the PLIC supports both edge-triggered and level-triggered interrupts,
-interrupt handlers are oblivious to this distinction and therefore it is not
-specified in the PLIC device-tree binding.
-
-While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
-"sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
-contains a specific memory layout, which is documented in chapter 8 of the
-SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
-
-Required properties:
-- compatible : "sifive,plic-1.0.0" and a string identifying the actual
-  detailed implementation in case that specific bugs need to be worked around.
-- #address-cells : should be <0> or more.
-- #interrupt-cells : should be <1> or more.
-- interrupt-controller : Identifies the node as an interrupt controller.
-- reg : Should contain 1 register range (address and length).
-- interrupts-extended : Specifies which contexts are connected to the PLIC,
-  with "-1" specifying that a context is not present.  Each node pointed
-  to should be a riscv,cpu-intc node, which has a riscv node as parent.
-- riscv,ndev: Specifies how many external interrupts are supported by
-  this controller.
-
-Example:
-
-	plic: interrupt-controller@c000000 {
-		#address-cells = <0>;
-		#interrupt-cells = <1>;
-		compatible = "sifive,plic-1.0.0", "sifive,fu540-c000-plic";
-		interrupt-controller;
-		interrupts-extended = <
-			&cpu0-intc 11
-			&cpu1-intc 11 &cpu1-intc 9
-			&cpu2-intc 11 &cpu2-intc 9
-			&cpu3-intc 11 &cpu3-intc 9
-			&cpu4-intc 11 &cpu4-intc 9>;
-		reg = <0xc000000 0x4000000>;
-		riscv,ndev = <10>;
-	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
new file mode 100644
index 0000000..b9a61c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright (C) 2020 SiFive, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/sifive,plic-1.0.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive Platform-Level Interrupt Controller (PLIC)
+
+description:
+  SiFive SOCs include an implementation of the Platform-Level Interrupt Controller
+  (PLIC) high-level specification in the RISC-V Privileged Architecture
+  specification. The PLIC connects all external interrupts in the system to all
+  hart contexts in the system, via the external interrupt source in each hart.
+
+  A hart context is a privilege mode in a hardware execution thread. For example,
+  in an 4 core system with 2-way SMT, you have 8 harts and probably at least two
+  privilege modes per hart; machine mode and supervisor mode.
+
+  Each interrupt can be enabled on per-context basis. Any context can claim
+  a pending enabled interrupt and then release it once it has been handled.
+
+  Each interrupt has a configurable priority. Higher priority interrupts are
+  serviced first.  Each context can specify a priority threshold. Interrupts
+  with priority below this threshold will not cause the PLIC to raise its
+  interrupt line leading to the context.
+
+  While the PLIC supports both edge-triggered and level-triggered interrupts,
+  interrupt handlers are oblivious to this distinction and therefore it is not
+  specified in the PLIC device-tree binding.
+
+  While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
+  "sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
+  contains a specific memory layout, which is documented in chapter 8 of the
+  SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
+
+maintainers:
+  - Sagar Kadam <sagar.kadam@sifive.com>
+  - Paul Walmsley  <paul.walmsley@sifive.com>
+  - Palmer Dabbelt <palmer@dabbelt.com>
+
+properties:
+  compatible:
+    items:
+      - const: sifive,fu540-c000-plic
+      - const: sifive,plic-1.0.0
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 0
+
+  '#interrupt-cells':
+    const: 1
+
+  interrupt-controller: true
+
+  interrupts-extended:
+    minItems: 1
+    description:
+      Specifies which contexts are connected to the PLIC, with "-1" specifying
+      that a context is not present. Each node pointed to should be a
+      riscv,cpu-intc node, which has a riscv node as parent.
+
+  riscv,ndev:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description:
+      Specifies how many external interrupts are supported by this controller.
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#interrupt-cells'
+  - interrupt-controller
+  - reg
+  - interrupts-extended
+  - riscv,ndev
+
+additionalProperties: false
+
+examples:
+  - |
+    plic: interrupt-controller@c000000 {
+      #address-cells = <0>;
+      #interrupt-cells = <1>;
+      compatible = "sifive,fu540-c000-plic", "sifive,plic-1.0.0";
+      interrupt-controller;
+      interrupts-extended = <
+        &cpu0_intc 11
+        &cpu1_intc 11 &cpu1_intc 9
+        &cpu2_intc 11 &cpu2_intc 9
+        &cpu3_intc 11 &cpu3_intc 9
+        &cpu4_intc 11 &cpu4_intc 9>;
+      reg = <0xc000000 0x4000000>;
+      riscv,ndev = <10>;
+    };
-- 
2.7.4

