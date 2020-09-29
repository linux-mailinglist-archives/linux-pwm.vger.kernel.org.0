Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581C127D2D4
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Sep 2020 17:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgI2Pdo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Sep 2020 11:33:44 -0400
Received: from mail-bn7nam10on2048.outbound.protection.outlook.com ([40.107.92.48]:5633
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbgI2Pdo (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 29 Sep 2020 11:33:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjpv92j2oo3ZdGNqg/LcfOJsCjgvs8e5JM5Jyow7/aUyt1SJRNo5buR5DeisX8QAcb3D1twXwfUA7TXXN1RTw5mu4+8iF1tnPGWv09pfh29FkEKPUXpGAJYZms1A3qkRdkgaN8skMLiryi2llsGxBXEn069IiURCsNomQNn5TSyACkOkB46EU1CMGrQoFU9A23vIBwaf7g2J/De2NSNHSsY97HVG9NUxFGtpIWNlPSdygw+H9j9Z83qUtpcKezhE1d98C1g3K8UehNW2KQ0YmaewMZPA9Nbnq+Rk3DCCZ9eZTTrDkZxgT7gmthyQqERTtv5tY4OSkwaRo7tkvBAIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3Ulm3ee2XLjQQ6jk3sWu1TMLDoYUWn2nb7NWclCEnU=;
 b=aD76apwZAa2eWLq3i5rnPefnHfNJ4fpBeIgBrQyDnD8MDokJDv3zYL6lf9Zar25eXQQvf5SS69aoHh7N5LqPq8U7wCxW2NFsmcLtoxF31+8uavxAbKUD3DHHhveqr13xn2S2HDEzOrXNWGvU/peLLXkbPMxRlgDy7gELrRKg0bWhqQDv7tcjgNaay49P0DqBXYwxLjF5rHbXqsGqhvj1sUTFAT7+V9l5OK5GrSQKdHb5enHnJmx1rReXW+rjSRN5WUFyJZo/mM4+KBxxGVwdkQnLc6inbni2JPAoK+Ha6IUG0P0Lsspp8FghpGHqXNHdAA+6FzZFtVY6uI0Sj8/zdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3Ulm3ee2XLjQQ6jk3sWu1TMLDoYUWn2nb7NWclCEnU=;
 b=JcvSrAfsqK0otYPTY1hjikjfQbOPRP4lOvRm4T3NIurJc/WjY39SIxPFhrzo6fclW1XTidhoLOPe0BfvqlXJ/1sCcoEFVo/4XNDZ/sH5b7BdPPMAV6foM1kcym84UIbEfmg/nOZaUbxFNm3PRfgEVD+GNMoke8HoU5oEtkWB2wE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM6PR13MB2412.namprd13.prod.outlook.com (2603:10b6:5:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.14; Tue, 29 Sep
 2020 15:33:41 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 15:33:41 +0000
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
Subject: [PATCH v2 3/3] dt-bindings: riscv: convert pwm bindings to json-schema
Date:   Tue, 29 Sep 2020 21:02:11 +0530
Message-Id: <1601393531-2402-4-git-send-email-sagar.kadam@sifive.com>
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
Received: from osubuntu003.open-silicon.com (159.117.144.156) by SG2PR02CA0101.apcprd02.prod.outlook.com (2603:1096:4:92::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 15:33:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39f21467-2767-4cf2-259f-08d8648d0aaf
X-MS-TrafficTypeDiagnostic: DM6PR13MB2412:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR13MB2412E18C4139CFCB54A0DE3D97320@DM6PR13MB2412.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xyKLjQnNOW1/MqAb8gRuzDsxVBaNrV6Qlm3IFTcJ/Yo5fTJLLv4S8xYZO/wsy/cg4VBZ+l7+Qma8mFpimBScUqnQkxregIO1+4TGD8d9iaHTq8PKsFQFhunx3EirTEAc/oR9Yjwba19ZyKlHiIa8k2XsFjgalSzP6lS28nddbcHF1e5dpBwobU10Vnv0BWe3pOOnzR4Vib5JZ9azAhsBdnsqMfwWF1L0TheZ5yChop4vv0G2MNNG268KleScnLFfU38prJQrsU6A0YyQEz35DJb2S2f07elKF45UBUcv3IK8l78y09UPIA2ZveWvdHeicqIX2ApdVEfObVu3UIWLolo3Giyg5Egu1SiadfFTqcVQGQWS8cz1CjFXgmDhTuqMsCCK3sA3Gn6SiVG8VxBVhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(376002)(39850400004)(6512007)(966005)(44832011)(83380400001)(4326008)(66946007)(7416002)(52116002)(8676002)(83080400001)(2906002)(5660300002)(107886003)(6506007)(66476007)(66556008)(83170400001)(6666004)(36756003)(8936002)(2616005)(478600001)(6486002)(956004)(316002)(186003)(16526019)(26005)(42882007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZsBFYqPpdmZxxdGC2lnOVLn6r/VS4QRy/wcw/c8D1WLrG56onY0AWMk4swRRldhV4zcUXoKLFZaSYTMeOfbr+iMxdYPBECX7jTi6ZeRVVdUSOXsyumtLJaMFPWGw0JC3BARXKY6RwNTfvLnVzsmd3TSnatIKYUZRDnj7o0koUfIOQCTdDYdSwLYfIf1ND2baLOTiWKzWgtgLeSz8VA67CPCH4F2PhV8+wYyilii/iiH+XLxs9D28uyc61QDhRzv9Bzlr5zdnUjww8422cnApxF3nRxFq6HJMdaXfJa4G0k3B2XSku4BqCz1KzAl9L31qsw7BeLPasEKNXhs9qYgr/jyJX3Vd8fLT52C7DTk0UPeiZ8Q81YXSR88jrISz5w1ZKZIxwds+999pVDKcsCL3o3K24XfZXcAbL7wx5KfptxGjsq5UTzWc/He3jg/2UVi62QoLEIVlPE8DGHIFWiG8Y81kx8e5pDlwEu6yZbxliQiu/qLlI+UCJUKh47KITgbdCnBsRzlpLJ3evd40ZnqHc2QTvlEQ9jghVAZvDMDSorvSGQ9CP8YQFQz8nzmkZXk1NVSnz++C+ywAr1QyDj0HRooAaKrAzUzx7g5JPWkSOYZANu83a/LqtzIZF5gmkL8Zk7+cjrVtY3egaP9ipC39TA==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f21467-2767-4cf2-259f-08d8648d0aaf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 15:33:40.8300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snonmJ+CmwWVMKYBqLN3NUxQWzQ1WxZ31NpJQ98DByYbJEHhp2KEDNm40AY3YkF1ML4UxVUnCkY+6jiZ6q03SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2412
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert device tree bindings for SiFive's PWM controller to YAML
format.

Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
---
 .../devicetree/bindings/pwm/pwm-sifive.txt         | 33 -----------
 .../devicetree/bindings/pwm/pwm-sifive.yaml        | 69 ++++++++++++++++++++++
 2 files changed, 69 insertions(+), 33 deletions(-)
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
index 0000000..5ac2527
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
@@ -0,0 +1,69 @@
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
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  interrupts:
+    maxItems: 4
+    description:
+      Each PWM instance in FU540-C000 has 4 comparators. One interrupt per comparator.
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
+      interrupts = <42>, <43>, <44>, <45>;
+      #pwm-cells = <3>;
+    };
-- 
2.7.4

