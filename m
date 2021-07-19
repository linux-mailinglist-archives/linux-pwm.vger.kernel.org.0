Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084923CF06F
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jul 2021 02:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhGSXWd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Jul 2021 19:22:33 -0400
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:37942
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1388944AbhGSVdJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 19 Jul 2021 17:33:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIxrlV54aPssyetTdvwJCornTf3dLV0eGOEx0qYVeNVrZbUqRcLwr0mc0kY2tfxU4IoD/AgFd8uJ5NNV+qUW3FivOzAo0+joLQBMSUfsRXCE8yjsQe+7uuC2lGP1z/JPjER82NNb7GKU80WRuuyKrFZKum2MACFIdUhxgLKRk9EaKCJQZRJvi8K25sUOJkdmQ+HXT/nu6v9d/MIds6h2S8gMMiv8Hq2blJCO2TBgbCIqtADJ0J8gMLzSafSUYfwuBRrtSjEVcipu2B1eERkxu6wEweCcM6oIRncqDs8TFzEjMdwp8QpiP3TTsH+lYdyjupO7/umwZqPEhJaVnRPGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sNmb/LY1jza75jmELJzuI/x/FZwey0G5Z+9iTI/CKg=;
 b=i84O7es3q7twqdiUf2Dz3Yk2ufR4YbuXqc3+gu98qUlEm+2A+FsQBqCT5E5Kt/EAKUH/2w/njHdbSeeyTWP+AJySVrS8HNq3ngn8YXtWeDBRR7Bh90esIGa2EeUbJCkgkCO+ZFeaPRpaXVFSE6ASsyhJ6l+8f9s9MV+gHBYs8BTp2PeYy1ojFWSiEIIyygk8tPPphA2yaAdDZT09gUVk6ZpBFRrDKpolgUeXTOWvyRbqA58xpKEARe1z9ysBmkM/kPUFa5TxWrI9TblPNIV/lOfJiegXmJNK5OG3EW86OX3IVU+gDK0U5+aTRk86Og1EQd1CTRivTD0wDworeYmg5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sNmb/LY1jza75jmELJzuI/x/FZwey0G5Z+9iTI/CKg=;
 b=HAUV3iuHd/McJMMX64cwwpIjaP2ArrF4IFsU8bKzn4s3W0+HAUgkIR7UkbkLCRE4RgwMxS1jHokNc4HbPqQNomyNPeuhccl+4NAe0WpDqroTQ7QRSk9UMYxZStFq+MbxSOnwFfnbsmdXsmGOcKtS1JRu1c26BgQnqKo+cDtFmJQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB3962.eurprd03.prod.outlook.com (2603:10a6:5:30::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Mon, 19 Jul
 2021 22:13:43 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 22:13:42 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Alvaro Gamez <alvaro.gamez@hazent.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, michal.simek@xilinx.com,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/3] dt-bindings: pwm: Add Xilinx AXI Timer
Date:   Mon, 19 Jul 2021 18:13:20 -0400
Message-Id: <20210719221322.3723009-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:208:32e::17) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by BLAPR03CA0132.namprd03.prod.outlook.com (2603:10b6:208:32e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 22:13:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a16fb50-aa01-4bfe-e195-08d94b02781e
X-MS-TrafficTypeDiagnostic: DB7PR03MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR03MB3962EF4D64B9A06CDE14E83796E19@DB7PR03MB3962.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydmF7oWuhdHVS+/6zaaaPk/xZ1Y7zUibMOIt8MlM+Kn5Caex6CUzeyduUkjCS87K9zlVTX5fedaOzLDFncitEFtR2qiS+0zky7rIJHuNL+qU/tVu3aDqxUAuViP4G615TB8xdLQ7RBxMG/F+7GrMkvHO9wz0K/URgCy2B+SkMDcI6pmuIEikazcsn/PmskzPKBDw5T2qwJMmRk6uoTyTFKEPbEQeneKCd2iuaI7h3EOHLvum1+Pw/qF1VcoVq/NuLKG0xX39KEDuG/yxXw1aU6rz3xn7jJ3TVYg3sx92j4AfySvXENep+oSFvIwfrrC151FfVOYX3aVP/IaFxkuQdNFCNEiCDLLqbwIV2h0QvRY8Tqi79CmkhpUUzdS1bZEcyt2A+f9t2dPVoBwmwmvTutGjSWFZoie0ZkU32RbL5DwfUKPmT5exLheyT0l86HUrco68aFxCsYRtcOCrbMlETUuL3QOSqeZrrjpRqs5Deb9RweAi3aHIlD2A4k+NFUAWsou9WzVZQQ29pbMdsipxc9v692ITchNPQ1G2eMwT96aIT4Nj4gDER+PyeJw4NlNaRANGkrOg5nXYrUh/HoO4Pdu3Bx4I5abiLpj2nTRMGIMRbK7K0P+JBHLWzFrwXeXj/Hr6IWGqCxoTl7oAaNBsCbKdl3JoCQ8fmb4AAIoLDq9Ykb69rKEjMqY0zHIkbxRC+xhgFSDYQY5IOtc6IegrMKlvLMieG7IgrXprtYAeDqGciyC7/XRt6WU1KO1oIowEG1sZay07yKAx3yowg3hfuk0C63cvfGkgVFlYOWIXxYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(6916009)(6666004)(38100700002)(38350700002)(83380400001)(52116002)(316002)(44832011)(2616005)(36756003)(956004)(4326008)(54906003)(186003)(6506007)(66946007)(6512007)(66556008)(5660300002)(8676002)(26005)(508600001)(966005)(86362001)(6486002)(7416002)(2906002)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vhlml4TdQ5uZS+ajMp+QGB5+WiggL9isVEC19zqpn5ZPsw64fKI2gyIMgB2m?=
 =?us-ascii?Q?e8uhuce9r0ZJxvUpKb6SKSNKa57ikbhgsh9KY4iNrJhaDjF8BbWJnlGVioz4?=
 =?us-ascii?Q?4oMU6qqfdOY31+3eYm2kNhz4McOlvZngyyHoKML30sWExe0nHv+MmWYxaeSG?=
 =?us-ascii?Q?P1dG06TuF7etnFAJ5PxoyiKDZJnqtqqkk7g5sWVap49NQoG3jO7VCxzasjW5?=
 =?us-ascii?Q?QL40KCdsiSPwAt5azvuZ99RDnzk0ug8KWzemhtt3jYaF+AiJTGCOkFj4hntD?=
 =?us-ascii?Q?4PQeFcsJD871/DBGh0uhVJaxdhpuSxQ5TEXQnV8Mz7+qbsffc4KtQT2DpO9i?=
 =?us-ascii?Q?lAWUD4RwgIu0b2FBm+6ygzD/5RXCDcX30vcCynolvvGt6EaIqQNbq5/nrXLK?=
 =?us-ascii?Q?Y3U3Ytsir5VptgQV9H4APNBebleM0ycbD1XibN45qcXkCdQE/mfuxoYaNBC2?=
 =?us-ascii?Q?gaGsShGuRLKi9GpVdUH+4x3enkR1z2gZy4/B6aIqAWBuqjhoSkZ39fOm+mhQ?=
 =?us-ascii?Q?CJB36qtwTEF85F6EMq6y4kdWxhodT/P0CV5jJfRfApRuiKO6+yMfYIdTIm6W?=
 =?us-ascii?Q?/tBEiLPmstVZTKMhNKiMLrkzqw43sVJYQfVLagFHCUNyptvSDK+FEVY5O24+?=
 =?us-ascii?Q?EOR9pC0oGVpU0Xj5/92Q7vFKrexTD+7GlZF4RbzDU1bgvuJegfbmjyp07FoY?=
 =?us-ascii?Q?R2snuxgttoEl6Si6YYRH/vDgChGgQHvnIPOeYl6R8u+dU0x4fSMa52z2Z/ik?=
 =?us-ascii?Q?dXUSNx6FCbErS29jfar7HR1wesQfAg1MBR6WYfNz0Hz3jh4iH8oVY9TVWNBR?=
 =?us-ascii?Q?b1585fEJylQYTomyUJ1r35dWGJS0a+BJCjVVdMAkUerdJF3C83My+WgxQkEx?=
 =?us-ascii?Q?a5xysJsXGaUUFeCJYvpMhHLXqiI5XfPXtbXfoVTvzsLJiiAJrstnX4bxNMrB?=
 =?us-ascii?Q?zWDfUnAYimmMd8o917u0LLVDU9PmL7pijPakV1/5fI17/2DuLBQl+sCdxmh4?=
 =?us-ascii?Q?SYFamNrOVfK9fmo1VwYpdp/FwuV9+drXaAQArIr4TrL91o7xv7vSkA2EnAfM?=
 =?us-ascii?Q?WHM44dKJ+wm+VVRBcNCqpw+7gFrjbNR9MXqNcDwDABtzI4WOBY/V/7USV25E?=
 =?us-ascii?Q?h+zk8SWO87ot/ADHq1v+V6atAU7MvHOYIFkw9sJqaHpRAx2M0W/l6f+SNYi2?=
 =?us-ascii?Q?LTsnDIY1fft9WaQd3xyh4Q6SjSPkvSL4hIyd56cEK+lqLB2YuGTUShS+OrWo?=
 =?us-ascii?Q?w8dZ75DejBpBm0ZA6I4ncv13iePIYTXnNUIVTTTh7kunomBSmrk/ptr5aV2m?=
 =?us-ascii?Q?Vu7zqffSuPxQcb7710VO7VTm?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a16fb50-aa01-4bfe-e195-08d94b02781e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 22:13:42.8102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EzpjYQHxZNoZYQmP8Q5LUBgvObh73bkY9yKHEZJPDT87PakQYa9IKjQDRmMsXptX6RdGfprHp1rUWr64H6gXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3962
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

 .../bindings/timer/xlnx,xps-timer.yaml        | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
new file mode 100644
index 000000000000..e5439653dc03
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
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
+    minimum: 8
+    maximum: 32
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

