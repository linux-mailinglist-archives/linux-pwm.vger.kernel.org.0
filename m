Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4819372FF0
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 20:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhEDSuj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 14:50:39 -0400
Received: from mail-vi1eur05on2065.outbound.protection.outlook.com ([40.107.21.65]:14560
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231715AbhEDSui (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 4 May 2021 14:50:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jf5RZw31Vm6M9Ani+28XUP5AaqWn4Pl/p/lX0Xx0iamCwsxn1cxRijxQwQT/zxxKdpqviukl77bBd1Su0Am30WNG9em2/vSG1pQlK3cNoFvh17zTJs5yLWfn3gm+ccciAqSYkCmqR2EeGpt9TOVvcAgQCNQp+YYxi0WK356+98joXhbhE6lfeQGGGdayfS2c6TaGEXzgFe9cCKA1jFeZce/Y/uet/OmIM9tnor1kVb50p6nGKH4pQ1EwuQK9JccfmOFIh5OgrJZ0rF781Dmgmte39z5kD2rD5AzNiUK77N7LU+0oAr+O97KLCBXCdGJYZ6Ffu2QlsNW2UWlgy4uzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OuNDm/M8pFW5GR8Cd1cF1ndTH7+81ik8rRZxwO2a4o=;
 b=n7catU4JNoIUBNbMJVdMleTnE4GFlGkvcicy0yKBMM4mtPujv6UKRjaL6CWa1MTUUWPB483TL/BDBup7LbQOtgvV8ExabY6ADU1DrWmzznGT3Pu+uuc8My6dZniNVprpK/Kil6A75juPo0Feq3EqxM2gO8ItbJXeSXFJOIE+IQsKxq8m0C5ZUdyvHUy3GfcuErhO6+YEDmetgDoZzHftFWf5HEYBFZCmRSQvVULTQXVGxNAr4nrgdPpkJGuiEP2+JhcI2Mtb8xs+vF4YS/xKKWi1zNiBwAjPGh7IVP5kJ+NtvhBMkeQqQX7kbX7jvIRjLQ/z9C70dkBbozAEaxuzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OuNDm/M8pFW5GR8Cd1cF1ndTH7+81ik8rRZxwO2a4o=;
 b=xkT3xl2iCkqo4zbi/1sV4WM6mRTbpe4XKALC/KohDbcJPLAOiMCZrMa29cCtrmBdpsoldKPYPDyhBI8v1GOzZJqr6Cy2Z+an0KiUw65RH2tFiwRddKTIiq0e99vg33mwv+TeKRKnF7eDMve8qe6nwMN9/nQmQNqItEkguMQ53n4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB9PR03MB7276.eurprd03.prod.outlook.com (2603:10a6:10:1fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 4 May
 2021 18:49:39 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 18:49:39 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
Date:   Tue,  4 May 2021 14:49:24 -0400
Message-Id: <20210504184925.3399934-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:208:d4::28) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR04CA0015.namprd04.prod.outlook.com (2603:10b6:208:d4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Tue, 4 May 2021 18:49:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f2edbc-e887-4983-e3c5-08d90f2d5f17
X-MS-TrafficTypeDiagnostic: DB9PR03MB7276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB9PR03MB727637D3B1F4A314AA9E8B33965A9@DB9PR03MB7276.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmWPNSLYBXbgR9Jao1RJcx5pQA/6IW+cm9qcqrF13KlP3e+W1NP6eQHIniG4xfR1w/77NsOwlVjexALBsTooZchmcPtNgsbgygDZ8ikmeOH0ovpjMkL0J5h38Xv9jKdqxFtoTRHpPb1xYCpspaodXfhWasvRV4qxEh5nK0YU/JvvR7kVSqqC+UbfBksnnEx7TornuBsRI19JVZ/JIwo6F7xDeBEYNXgK7NBK/iJF62Jyt9X0Gi/q1DOJKv6Lyh6qYcvx6p9X6B39R51j40Np9mY7DW/B/i5JmyBEQ+/YqIf32qZeSkkcwjVvxYIIYzgT5A+LGvr8PTW2os2M2+a/je0zAqu4LZcjZmh7tfR1z7HB3AKvM9eZa0UmUvkHKdDjkeriQ+F+HdRBDOTzF1x5YqZKBVYfP9WFqfyiTb59QDXYha4MK+Dc1UxTikCBOWVEdyNZpSV2GJMx81pOl8QlwBGOElPz05bc2ZHQ/UH//Mn71SgDV5QzWsVO997zdrYoepKau+4NPoGCHF7fgGOKtpZLwEdgsj3eJohtdQnOI+0cUxLQLB4bllxZ5ipRFWS4nKfi1Vyt2NYyKwct+NZAL1mLhc1LKEBkJ5wHX45YpqpRDET/ZWnX9PvvyORfhzcoeb3wE5+V0YvlcdFhnjN8JRydfeU2KFXOUgvTLrEX/jazmnC6pGCVgl3wOlTgKEK1idRsdZDAp+B6y63SpNETin6CzTLpjqYbleRuQ4/gjNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(39830400003)(376002)(38350700002)(38100700002)(66946007)(66556008)(2906002)(5660300002)(66476007)(44832011)(26005)(52116002)(478600001)(6486002)(6506007)(8936002)(16526019)(6666004)(966005)(186003)(2616005)(83380400001)(8676002)(86362001)(4326008)(956004)(36756003)(6512007)(1076003)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9NlCeI1Sw5juLUeSzUwG7nGOXauWnoMErJYDnF9MbfRmOgiDCpBdw8oBkZgy?=
 =?us-ascii?Q?1fBOotnVlmNqb1j8IG9lTnywHsSD4bltuu7n+97NhDgkbHDbjucm1IgKJuzB?=
 =?us-ascii?Q?6VatuEVHVpgGEz/4I/YwBXa68TXeTA9+RxokHB+PSNlqImGcNMBuT5i9ZCHb?=
 =?us-ascii?Q?kctmjpRXmEj3pdmNMxMoyEP+RD4CgqDIQCPwwiJx5D1fc+5D4zr3xCfU3HRi?=
 =?us-ascii?Q?wfQC+Fedt1idiWH4kHWZ7J0DiayO2656q/IOxn4NqNrc3seT+PoU9B7/Vb7z?=
 =?us-ascii?Q?2Sazl+2+hc7bzH3l4/KkxHbfWN35ALA+iBSY/AgsaXVlc2/wi2cmO4aQVQBg?=
 =?us-ascii?Q?WiQQLLLMPBuauSI5LmFoFZIdUOCYpdEloMT6AlFrjyw+lP76TC3rdJ9fL4xY?=
 =?us-ascii?Q?QpvAEmTeE9UNEx+pwiH6EGEPSP8Tv7uSmevWvknOrS92e9zDThQ847QMYhFU?=
 =?us-ascii?Q?G7LoC1KtMHlDuq2XLH1sKWCaoSasDJc851U5Wl9r9qQVgJsTase///RCOVPr?=
 =?us-ascii?Q?Pl73+RIhvGuwkGXN7h0ovSTXsQ/L14gC5JESdfV79JAU0fOLAUiTRu6PK5Ug?=
 =?us-ascii?Q?rry22i0j9aQdxZVAzU6gcO1TF6uDZJFgh88XAPvmIF1a+yPqQvTq7jMfjeAR?=
 =?us-ascii?Q?J0EhkXADaWnj5oWEh9kG+SUplXn9WFvzErxIPlXyuJvXv/IUwpHLTLVWolmT?=
 =?us-ascii?Q?2Hh0bxOXh31qc84iqg6v+DuvUGW2sdw4uFDwCPS6xt367grUJUTOu7dvVL7D?=
 =?us-ascii?Q?RX6QFTSYWbW8Qt06zc0KEy3C4+H8uqdFs68wAApxkChkk4l1E7N3fU3u/roW?=
 =?us-ascii?Q?1L4M+KU6h2a5IrSyct7BY+YPcZzSBwGwxM4i17rb4BByJfVIDbLCrGUWsQ9f?=
 =?us-ascii?Q?VaxrqKl4hDRzdu8fe3tfXR3ZV39roc05KqWM/bBkp9i3KG/DBz3vuub4aec+?=
 =?us-ascii?Q?q0QlI/qJeEQciukIjF3aNi2gcHqkfWxVPBNZQYp0HbsyEwlpsOmcc7Yza+1d?=
 =?us-ascii?Q?LtVPEVXTA1givz2MzpPCWfd1HLNfEDLyhXwrydtT9WZ39gMUpysf4L+vK+RX?=
 =?us-ascii?Q?jpEDDesFzInxmbOOI24ynvfjXz74ePki9nqIcfnZZFvWYpJI1TE5TYxKWHnX?=
 =?us-ascii?Q?bZOek5gzR0ATjRrIK+QkfsvJThBb6xx7205ehHUA3nxOWUQHjKGtPO9r12yf?=
 =?us-ascii?Q?kBilyaLaVsSW9mV6Cz7hwEw9/B8i8NTy8OmS3JDwPlTW/mFknqine3WFVtUE?=
 =?us-ascii?Q?R00VXF57pF5WgR2jgFJsY1/muQpU5iTO+tbZV/N3HoPltxbfdb5INxM5Ys/a?=
 =?us-ascii?Q?hisHKnvBiB4sNKdyHsv9YglT?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f2edbc-e887-4983-e3c5-08d90f2d5f17
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 18:49:39.4371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDXyyz/bTlImyu/a9qwwa2lyLn1PeMraZ6YRld5EAJloqHulvuTqYmiJObYT/LHBL3qY0sJ40n/q9C3+2QWj/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7276
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
a "soft" block, so it has many parameters which would not be
configurable in most hardware. This binding is usually automatically
generated by Xilinx's tools, so the names and values of properties
must be kept as they are.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v2:
- Use 32-bit addresses for example binding

 .../bindings/pwm/xlnx,axi-timer.yaml          | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml

diff --git a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
new file mode 100644
index 000000000000..bd014134c322
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/xlnx,axi-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx LogiCORE IP AXI Timer Device Tree Binding
+
+maintainers:
+  - Sean Anderson <sean.anderson@seco.com>
+
+properties:
+  compatible:
+    items:
+      - const: xlnx,axi-timer-2.0
+      - const: xlnx,xps-timer-1.00.a
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: s_axi_aclk
+
+  reg:
+    maxItems: 1
+
+  xlnx,count-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 8
+    maximum: 32
+    description:
+      The width of the counters, in bits.
+
+  xlnx,gen0-assert:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    description:
+      The polarity of the generateout0 signal. 0 for active-low, 1 for active-high.
+
+  xlnx,gen1-assert:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    description:
+      The polarity of the generateout1 signal. 0 for active-low, 1 for active-high.
+
+  xlnx,one-timer-only:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    description:
+      Whether only one timer is present in this block.
+
+  xlnx,trig0-assert:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    description:
+      The polarity of the capturetrig0 signal. 0 for active-low, 1 for active-high.
+
+  xlnx,trig1-assert:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    description:
+      The polarity of the capturetrig1 signal. 0 for active-low, 1 for active-high.
+
+required:
+  - compatible
+  - clocks
+  - reg
+  - xlnx,count-width
+  - xlnx,gen0-assert
+  - xlnx,gen1-assert
+  - xlnx,one-timer-only
+  - xlnx,trig0-assert
+  - xlnx,trig1-assert
+
+additionalProperties: true
+
+examples:
+  - |
+    axi_timer_0: timer@800e0000 {
+        clock-frequency = <99999001>;
+        clock-names = "s_axi_aclk";
+        clocks = <&zynqmp_clk 71>;
+        compatible = "xlnx,axi-timer-2.0", "xlnx,xps-timer-1.00.a";
+        reg = <0x800e0000 0x10000>;
+        xlnx,count-width = <0x20>;
+        xlnx,gen0-assert = <0x1>;
+        xlnx,gen1-assert = <0x1>;
+        xlnx,one-timer-only = <0x0>;
+        xlnx,trig0-assert = <0x1>;
+        xlnx,trig1-assert = <0x1>;
+    };
-- 
2.25.1

