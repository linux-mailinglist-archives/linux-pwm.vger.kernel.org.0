Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D48042FB92
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Oct 2021 21:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbhJOTDA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Oct 2021 15:03:00 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:43077
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238216AbhJOTC7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 15 Oct 2021 15:02:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAGQ3oDqb94LyxFxHNJF+wfOYJxePMSknGWoCDmvq6SCyKIM6j1bMhILS1srbcxLlXsLZ0LB7glCtyBTqgKZEsUmOw50Q+Fr4symBsWWh7pcNjiQh6cCBvPmp0qsURtknteV+E80K7Xt6d0dj3SnCRyGD9H6KoDB2NtW1ZRg3dyAJMOlH/hsQwGnuE2GjUKgOQywOV8DJcIptyZvT+RAkhNHLMhtiQwnkLg92MjCTsyAIPos7evdkkQAYEwTBx+8JLWw3VPjlz9BNS3x/nehJCt3wbHyQMdrDMhY1eNI3H1U5fJGNGhSBlPRUWyZY/Z3oxnBc5bJl3tRiqqGJtABYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bDddFOCGEZpmSDvv4+Zcm9PpbngTevxWi1q2WxlNO8=;
 b=XW4Uv4GZ0ETdPxUMcd8DysVhHfewRawCfq+aFdsc81oBMQ2aqxkHvLfvPDBgBajZvVwo5B9Aj1PE2YOUiZKHBENZMwUiAEDUt2Rjuf97ucuA19wi1zMmblFFVoWxOTBTvyqenBY7yc0ds4PgNDiC/9rVO41c1keDPxi51EiGxhUiCmGWbcIuWJGY8bn/YmKg72ixZ6atuas4kZNRcAGD6CUkbYh0ZWOkrjG4sKPo/+0ziJ3Fd/FmxZTYbdQNtVTgHEoYD2Eo+vCsvQusiHC+u3qKcfFnONuwiXQsPXOLBj9aVm21poEp+GJlO7EDIrEVTBZ+FQ7bDLWyDDavMiuTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bDddFOCGEZpmSDvv4+Zcm9PpbngTevxWi1q2WxlNO8=;
 b=M8Mex4KYCJ/UXxzHM9ytkEx3SbSYBEmLyLNXJOBrOMJVssTnGhJ0gOi9sMbi/hg1Z5/NGXXSZJswrhB+7L0p9Dnq4e49UsgEscf/halxhXK8bnd1l/XG/Xa+r63kGkHGYxAP/mYVelO4iimkxCjNJkieiSM8IJCAmp6EzDL+R5A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB6905.eurprd03.prod.outlook.com (2603:10a6:10:205::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 19:00:50 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 19:00:50 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 2/3] dt-bindings: pwm: Add Xilinx AXI Timer
Date:   Fri, 15 Oct 2021 15:00:24 -0400
Message-Id: <20211015190025.409426-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015190025.409426-1-sean.anderson@seco.com>
References: <20211015190025.409426-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::11) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from plantagenet.inhand.com (50.195.82.171) by BL1PR13CA0096.namprd13.prod.outlook.com (2603:10b6:208:2b9::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.8 via Frontend Transport; Fri, 15 Oct 2021 19:00:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 682fd9fd-75e9-4047-18f8-08d9900e1ac0
X-MS-TrafficTypeDiagnostic: DBBPR03MB6905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB69050EEE24B40065E00C95BA96B99@DBBPR03MB6905.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dd9r+YnPKZfM2rphXUgw/jt2YWGOISMoyBNVoEikcI/HTuqH9GOc01ylMisonogzO93p5BxE9ptrWjrqmLMIzil5Sd8Cor0lW+om57fA2uocYiwoLsCgB1zambACzAZZ0uQkEyejum/k7wVcSeHKWmrxo/rZoVtWOpSQpRxVtNNc22oDDPnO7+s+YFfrXMizycpTm5JASTJxfzIg6jOEmKzLhMHVErqA3zKckpP5OFycKQrkvYFm9bQenu23NoDbb7JmZW597BJ0XynyY9YwjXUJJ6ddasu3K5JS5dLei5TWU0rH4L8NZ3Uh4AbvF5OatTAoMMO4CTq2L/VN4h7gJvla72PbTEVbJpP8rNL3aTLLAuq/WLA9olMCKUZe6ySwHdKCd5JqlJXZS1OetxuMTzb7dDakCztyygWLL/qOyv2B0j04mRmRN9LVYGE7cOIBos0Fh/PwmliiiRnFqxFCXHynX6BnFxnzNBgc7xw1XoWmNnXOxIAS0JnJiUg3RwLmcgC9zyThkbHedYoZya5pC+JHeD6IdPXtG+iI9LMcp1TbxvbKMkB1Qp/vmaEGE5DY8ArfU4bEd5A7SyVVp4XnlAsDSHdFH+dCWG/4Ui/pwQu6tbkC3SLBWYMRhp/ND6IRsvrn1xeL9d75fcjRONwRrs0Npx9VjSxe3JsVahuRRUP08P4Pp+Wi4L0aqNf3GgmpIeRtjMhPSiN2aPIsJbBYDV4K1szjzkyyFEHU13tI3BkK/2YM/pha6dOq9YPIST5pL5HlLIolqNBaBuLCbfFkYPcfvGeGJhayyortWYR3AxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(6916009)(6506007)(54906003)(508600001)(966005)(1076003)(6666004)(316002)(26005)(44832011)(4326008)(2616005)(66946007)(83380400001)(7416002)(86362001)(8936002)(52116002)(6512007)(186003)(8676002)(66476007)(66556008)(2906002)(38100700002)(38350700002)(6486002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f0M73Gn2+Z9PdQv8pEQrKk9VxlrD5vpPTAkNk9ic6uyxLPcWQmfL/6nMWCVi?=
 =?us-ascii?Q?2zHeb1lwRxMkQ/SByVf6jkOXiNisNkQS7kCI8tMQtL8qNTgEP62EjDDZNg+S?=
 =?us-ascii?Q?H9Ef+TLuJkuxyYSD14iQTn1QKdd2zA84Yr/+lABt94TF2CBPF/2brAzccipL?=
 =?us-ascii?Q?GLVAABQvaA4RHBbYEaA8Rfrb8ekG8mhuRuw2lN5fFajXbganSTzywMMV0YUF?=
 =?us-ascii?Q?sbvGYELyIzBR4uOpHi5v8d+99yqViHnPdkP7WCVdB4qFUfsaT89WhyDMSSE+?=
 =?us-ascii?Q?D1CqsqdhI9khDCwvMbpQiyRN2Cb9ppYoDbTNREe7PjuRD56WJl+G5mXKHP2K?=
 =?us-ascii?Q?lJtvs2iXlLkpjeauNZApZBE3Qv7tJSLG2UhUouP77MtP/7Vm8V3j3ZyYo1j4?=
 =?us-ascii?Q?ZqxCIgCKvk1rq0yd96UWN8YvWCjgcU/UxA+Pt6AcnneM+UVVA9smBGW6AElr?=
 =?us-ascii?Q?/IAuswYjfj+DIGx9ggCHVaWTR4DtxqxJtL4nkn4UbMIRsCqYiqeN9RwoYYkR?=
 =?us-ascii?Q?/wHNtDDwecL1rfF64A0fzeZkVYytTAHuOBPRdc4+2bS1E84zDmb5fXCh3MEd?=
 =?us-ascii?Q?/J0Y6qsyU78JlOQgVl28LHozwvAs12zFn1iYz1x/X4Sppo3Q6N25WHAk4UqE?=
 =?us-ascii?Q?JXYa35eQPF/3MwtxkhI8Gn9HEIlp5vy49Zdmj0CsFI8I7lSK5wZLVHcnr4NX?=
 =?us-ascii?Q?fgZGEjC5BSwJnFQc60vfYNdpU5nJKXYdeK3s6b30idEdmxcXASZp6ii/Iti/?=
 =?us-ascii?Q?emR4QvlNLNBEL+B4lmi2xSOzOzOGFoJbRBhjFd3qg+49RwgUc8lOxZ5l7FKl?=
 =?us-ascii?Q?z/t+1c7eCj0S4AMw3merxqcVCYW2SfMDgaM0VnVqJ4iugHhubbq6ZnKkDuOA?=
 =?us-ascii?Q?nEIBCe+AIhSvIAPFuEsz8YXUqZ9Q3yeSMOyI8J4YoshCZHLGr3UDmY+DjYX0?=
 =?us-ascii?Q?dj/f2gK1WEjdv5Lf7HndrcD/T8B0F1KNFOq9zF7pyAJhkzBf69NeIyHQJ8WP?=
 =?us-ascii?Q?6xOsGokRwB+/3XHa3St0/uGC3fqDN6sls0N6iY6dHT3BasR/ZeS+Pe5j96Fd?=
 =?us-ascii?Q?m0AG/wnaiWsZzcR/bzsnsRQ5KssS2CTpuyX2ShJ8JedgbO+tRGaX+CE1Sxao?=
 =?us-ascii?Q?15W/VUv8niIi56bOOxhq78GczEq8Us3bWGpkKiaFhxAYwkYsSUkSD4mfwgeE?=
 =?us-ascii?Q?xxHqm1Z9vIJ+turxhJLG6dQXsgThDCi4VpjWsm+YzWLcH6C6SVaP5WxXzoqF?=
 =?us-ascii?Q?xg9bKeWoGaUmncKK1j22a0loG5fbklOoaArudlrdz4etit0bYyD+iRWTBxxP?=
 =?us-ascii?Q?vTBiPYhmkQEMgf9xMHifgXM9?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682fd9fd-75e9-4047-18f8-08d9900e1ac0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 19:00:50.3873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V67NqNtJaHpzk8hgz7O+35OwxYZgI3zymfxXjUtD795Vcl6ko0G2Hve1pvwNf/3YXsD1Tb5XL0JDnNE1SPvKmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6905
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

Changes in v8:
- Set additionalProperties: false

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

 .../bindings/timer/xlnx,xps-timer.yaml        | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
new file mode 100644
index 000000000000..dd168d41d2e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
@@ -0,0 +1,92 @@
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
+additionalProperties: false
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

