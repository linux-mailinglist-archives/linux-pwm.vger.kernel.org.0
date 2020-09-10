Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123F9264487
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Sep 2020 12:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbgIJKrj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Sep 2020 06:47:39 -0400
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com ([40.107.236.59]:50081
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730349AbgIJKpa (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 10 Sep 2020 06:45:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5kPT2MoEfqw+CLLdyffSygM4w8CtBx/6lhHbFeqMxUTcu+eCL4TuEAJFXEowqDlLJEmAcrcnPQWwqQ71rVkTNKL8FolKWmKaWQv/NY6w+sXg8B3CWaLWrbEzHYiqWLRJD2ZPliund16/gpRRPWYW/+iiJ61ilN1hTBrtghR1j7MgYZKJhv5DSJlTBqWw5xCQmCMzDoVgzRHsudSfHZ91JvBEwTei7TtjWA+JVk019WDCygc4q0xh9xn2tJhqdoRBzQ7a1gx25wQJi6SXdS6BhJoKkJH7MTyqwR/bX4AR88Jbg3CN8rR4iXvhvplsVgDsHWepDrPtgcwT85DQ+gwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDCNfmA2VpqnqjSQXmP74QoaUphwEGVSFL9m2GB7xF0=;
 b=EmAVWC9UqohJDTbKCuL40+6O1j6gOogCFFa1ryT8XOtI/KCq+Ujfu7xLIU4bS/rqOHKE5GHcjK65YR/x9MAculzxhPqSgNVREHeaQPkZxRD9SFiSdiuVeXAR2cA9kU4iabrG0a6XdbL6QzULAkHj4dPT4i7V0ef0FLZK5F0AHNnOMp3kFdIyFXkADGmn+VT1mjrKwTDFwpFW5+8m8+nLDcmAZUYgRdBGO9nRU6xpz+lnS2aa8GWk8T46B+ni0hEHK1v/9Puq4suDYgFRzW2JlQLCDnyiomI4xyKq6KkpiKNNagHOxMlz4jNp5c6Y4qiFJ90taDZhEebnuApqrJkMnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDCNfmA2VpqnqjSQXmP74QoaUphwEGVSFL9m2GB7xF0=;
 b=CY1LskH9AxVcNelSCZLw34SfGKN/U/+ljmgNNq9obKqWtubAzMMfFPll6Zh913LPyiwFgDZ2lISsrC/F20m6KdUAmqe9+ibkkIjprG+qd0wQDf0VaToy4B0vxV4Jx5LHPm38W9U1qwm0S2n5q+yuyRFOH5yMJ1AFdf8KFLWB2Gc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM6PR13MB4330.namprd13.prod.outlook.com (2603:10b6:5:163::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5; Thu, 10 Sep
 2020 10:44:46 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876%7]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 10:44:46 +0000
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
Subject: [PATCH v1 3/3] dt-bindings: riscv: convert pwm bindings to json-schema
Date:   Thu, 10 Sep 2020 16:14:04 +0530
Message-Id: <1599734644-4791-4-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599734644-4791-1-git-send-email-sagar.kadam@sifive.com>
References: <1599734644-4791-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::27) To DM6PR13MB3451.namprd13.prod.outlook.com
 (2603:10b6:5:1c3::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by BMXPR01CA0087.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:54::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.19 via Frontend Transport; Thu, 10 Sep 2020 10:44:41 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [159.117.144.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 152f3faf-a43f-43a4-59ec-08d85576890f
X-MS-TrafficTypeDiagnostic: DM6PR13MB4330:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR13MB4330597D39EA193D4E98743697270@DM6PR13MB4330.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xTg06r18EcHvaSl2GS1ZKR0ut+Q8cFjcCcoaeW/uGfpMRxT9ZVHHXFw7sF/h3ALK+4XT86eFDz7t5inwb6YM0JV8STwRPBrNk8uTPm3+P8qp0mPCXLOc/iTc/Z2VFKzVIHM2g5USdWnOcrD6onCyElhfzG/vB6RYgPPqv5fcxWafcMCaDR3gCpXdrPuQrWKyo4lo7sUHkIy+7k5IJ8cnaSJ4S7+kON22kWEjzuaukhL0hj+1Do1otYOjE8NdPGVMpeJABq9JbN4ZaP3nIgvjAavp3L3Iv3Kx+28HpJr4xund7YW6vNGvhK9Uf2YD0oqvW5mnjuw20jssmnyYkFqQTsWekXOPR5hil0W6f2bNYuhOiX33k/S0CVIoteIWsa6ui186KFES5w+1Y7JBWu2Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(39850400004)(346002)(66946007)(83380400001)(6486002)(6506007)(83170400001)(6512007)(52116002)(316002)(66556008)(66476007)(42882007)(5660300002)(36756003)(107886003)(8676002)(26005)(6666004)(44832011)(2906002)(7416002)(4326008)(16526019)(966005)(8936002)(478600001)(2616005)(956004)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: i/qrLlDPQDrLz/F1WDR1fk6ujykA/4vESuKqv/TL4yDDRvd45MZPjQD6kGCIONxlRmfzsRuqWG421sxK5gXRSq2FWdQikHzA5f9T1qaKYJ4iDr3fa8ypSa+HfW2jx8Wo1E4S6is8tSXRYGdwqbCm1pdifOD97WH2nO1Hv9R8Eypca0iIJ0avsi/kCX4lX7MKDkL9s08OqdCej/1hBzjNfumzFEj6EfYR53Qsp6ryf+1fziDi2+zd9yU1J9RGNdKp0gI5ANrLLgqfMci4hOV7Igy4KfR35rDCBBKdVaZcUaZz9FjJgmi/hKv7zBgWTthAdWEMbk6R4U0PAK9pqazPXZeQhIGB5LZzorHLUb1Lqc+ry2yISiTWS6vxBjHliZDZpXc1TjGM1zTiFUQnxILSVBj9XhSXuGcxEgEkjykgCpQQg7vlM21GVXrGYN8cl1dxFC0HqoujpfSjTifmKNT7sfpBo/Ockw4igMlYpOqdhSgGfsJMbe/Izp5O3JezRqpzUglgxDNXaVBS21rsNx2H8Yxm/72hull6f6aVgnIRS1HN8J8uRhNgKR6foWwQg3bbqRTVLP3IrYCffi0tGqskmHdbNJTxQv58I1Otlyr2xOlDktkb6NRLYoQ1JclRy62XU3wMtzqJzZPsuPDmucAFSA==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152f3faf-a43f-43a4-59ec-08d85576890f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 10:44:46.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cz5Ap5IhNvqdhl8Cfr4iXjWoT0LEo8Ygp19D1ryqoqQqvO28VXQ2fXCVlkMzpoNDhcpBJCk7dAYsQ9qOrOjkmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4330
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert device tree bindings for SiFive's PWM controller to YAML
format.

Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
---
 .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 ----------
 .../devicetree/bindings/pwm/pwm-sifive.yaml        | 72 ++++++++++++++++++++++
 2 files changed, 72 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
deleted file mode 100644
index 3d1dd7b0..0000000
--- a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-SiFive PWM controller
-
-Unlike most other PWM controllers, the SiFive PWM controller currently only
-supports one period for all channels in the PWM. All PWMs need to run at
-the same period. The period also has significant restrictions on the values
-it can achieve, which the driver rounds to the nearest achievable period.
-PWM RTL that corresponds to the IP block version numbers can be found
-here:
-
-https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
-
-Required properties:
-- compatible: Should be "sifive,<chip>-pwm" and "sifive,pwm<version>".
-  Supported compatible strings are: "sifive,fu540-c000-pwm" for the SiFive
-  PWM v0 as integrated onto the SiFive FU540 chip, and "sifive,pwm0" for the
-  SiFive PWM v0 IP block with no chip integration tweaks.
-  Please refer to sifive-blocks-ip-versioning.txt for details.
-- reg: physical base address and length of the controller's registers
-- clocks: Should contain a clock identifier for the PWM's parent clock.
-- #pwm-cells: Should be 3. See pwm.yaml in this directory
-  for a description of the cell format.
-- interrupts: one interrupt per PWM channel
-
-Examples:
-
-pwm:  pwm@10020000 {
-	compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
-	reg = <0x0 0x10020000 0x0 0x1000>;
-	clocks = <&tlclk>;
-	interrupt-parent = <&plic>;
-	interrupts = <42 43 44 45>;
-	#pwm-cells = <3>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
new file mode 100644
index 0000000..415d053
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 SiFive, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-sifive.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive PWM controller
+
+maintainers:
+  - Yash Shah <yash.shah@sifive.com>
+  - Sagar Kadam <sagar.kadam@sifive.com>
+  - Paul Walmsley <paul.walmsley@sifive.com>
+
+description:
+  Unlike most other PWM controllers, the SiFive PWM controller currently
+  only supports one period for all channels in the PWM. All PWMs need to
+  run at the same period. The period also has significant restrictions on
+  the values it can achieve, which the driver rounds to the nearest
+  achievable period. PWM RTL that corresponds to the IP block version
+  numbers can be found here -
+
+  https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
+
+properties:
+  compatible:
+    items:
+      - const: sifive,fu540-c000-pwm
+      - const: sifive,pwm0
+    description:
+      Should be "sifive,<chip>-pwm" and "sifive,pwm<version>". Supported
+      compatible strings are "sifive,fu540-c000-pwm" for the SiFive PWM v0
+      as integrated onto the SiFive FU540 chip, and "sifive,pwm0" for the
+      SiFive PWM v0 IP block with no chip integration tweaks.
+      Please refer to sifive-blocks-ip-versioning.txt for details.
+
+  reg:
+    maxItems: 1
+    description: Physical base address and length of the controller's registers
+
+  clocks:
+    description: Should contain a clock identifier for the PWM's parent clock.
+
+  "#pwm-cells":
+    const: 3
+    description:
+      Should be 3. See pwm.yaml in this directory for a description of the
+      cell format.
+
+  interrupts:
+    maxItems: 1
+    description: One interrupt per PWM channel.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#pwm-cells"
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm:  pwm@10020000 {
+      compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
+      reg = <0x10020000 0x1000>;
+      clocks = <&tlclk>;
+      interrupt-parent = <&plic>;
+      interrupts = <42 43 44 45>;
+      #pwm-cells = <3>;
+    };
-- 
2.7.4

