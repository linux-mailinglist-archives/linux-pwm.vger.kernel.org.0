Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C59337AF1E
	for <lists+linux-pwm@lfdr.de>; Tue, 11 May 2021 21:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhEKTOG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 May 2021 15:14:06 -0400
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]:54405
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231439AbhEKTOF (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 11 May 2021 15:14:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+kksR3RPr/02/Xu0J2WyYM12KWDM2WFnka6h3v2ZoU3LhpJuq111gm9JLw0J1dGVZL9FZ1o33PyCmJbDVHIXiGs61HjgdDMkKEUqGjiWpNMjmmqrabd5Likh7jaQt5h8dFzF9Potb2ErgjG7tnvFnRgp81BjKyWJ59ZJ68At1N6iKTqmeWbsle2xO7f1ihLUhtrms6JI65n/wMqa+EvFmdcagSwW60smLwVU+kddn5ORnWF6Wfwnc0CBUsr1wcCHFgZC8aZFjq3lPt8Tlm4R/uC0O913n1nX5Cm7ujmfkAfuLFyv7pyIjvhE7jHFPDP2Ta6f65U9YGqCwqtbaIkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3839q7kLFvkDBooP2/dkkavEo/Ed8ON4st0r9yHnCM=;
 b=ePtmV2RNa+nL65s0okJNU7JqBKBbcl52GutdeStySBOi+H7eh+hF4/Kc2jUF3pA5B7ysSGP2fs75Tbvpr0ua2trIb5/N8OjxkWWIF8qUs5tgeasuc7bO+Vfpwz9oOTAESRRF0Cnm8mUGaRGJ9rsVlngiUZDG0xF+W0eSPopolxDWD5eR12YwmtRcAXLtu3G8onDLQKvlsMVkUXgadxAPnpB2AchHY5ylU6RyOoYi6geoB78nO399hrcdcGswsA8+Bhdeo57UH1uK2OB7da47Ge9AR8QlqOnhecnIJ2ofXxakJPzUaIcIw7ay7Mr1VHeauv8wcK6eQUdFod0QCOEdTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3839q7kLFvkDBooP2/dkkavEo/Ed8ON4st0r9yHnCM=;
 b=mWo+xcjCDZ9VE8XJ/N7wTjd61KWgsPJZlbrRdb7dbZu8ITAOt1c6SjG8FEv6SdRqVzMtW8JVq10YjL/vy5mPMLArVD45TEFKVnOHgQyxHesC3yI2gTWzXEUz8+YQQb8hbZFYbMIrQhE/mf015pAcPjWvSTm5O91fOln2ZMYqLaA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4154.eurprd03.prod.outlook.com (2603:10a6:10:20::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 11 May
 2021 19:12:55 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 19:12:55 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
Date:   Tue, 11 May 2021 15:12:37 -0400
Message-Id: <20210511191239.774570-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL0PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:208:91::35) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by BL0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:208:91::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.12 via Frontend Transport; Tue, 11 May 2021 19:12:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a439247-cf7f-49fa-0cc6-08d914b0c81e
X-MS-TrafficTypeDiagnostic: DB7PR03MB4154:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR03MB41544A391239D1BC712469C396539@DB7PR03MB4154.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIOAWbpDqy80dnPIpG9QSTATWUilKB5buYx+lyTMreDs1tF98wm/gTGRJk1r2sept89iiH6lkzg4NzcXnzfVj6eYftKaYhyIJG+VKqKBx2NaGh6nECiKITIWjOxCi3Omk3AD4vcaC6QSe5NdXeDYznAvOkBJYm+Ej5NSShyqIXokmnZR1YtJ4ZcMH2bTad+oMCtURdamhFIpAMgpNqCdUDk7odrEy0pUNKWUQ0uN1KEv4rMkoxE2E+1Q8d72mFyvV3BM+ZQczWtsjZYa4sphbGSbmhn7zeRNnjzyOUnzGszL5I7Eg9tsDXe7fSFk9dTmNQ9M4EndXFvrtxcdxyg4DhEctsmQmaHVN+33EkA6ETx2G3NVwIlzUwGamfKwnU9snaWz6jxzwFu/eAYlVdDDYM+33bvhir/ZNMaHGd9mNVVbbAyVmx1vnEoa/qqslHuw8OIiKp6yjqTrIZQb4uapn4iRAOrkBraeUos6XAKsy7UcH53a7zrcnd+ZUwXuLTtIYMvX+a4WrsIfiu9L3N4kvhjtA9+apocsQwngV4i8jwy1oWqJv4EUzUXQ+mRbcbWzo/lvP7bVM26vAOwxdJRArXooghhzPIaJYQuh0fd9NsJIxc31DIpsh8TpSH8METE/Elz6fnkjW57S7GD3dBEZDnoe4EYhg1O719bRUEC4hzAcikZsaud03d/ExHLd/d1c42f5rJ2tA+oAaHeItaDwNxY8zp4TMGDqGmZ8//DN5qU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(346002)(39830400003)(8676002)(54906003)(2906002)(38100700002)(36756003)(44832011)(2616005)(316002)(1076003)(478600001)(52116002)(16526019)(6506007)(956004)(186003)(26005)(83380400001)(8936002)(6486002)(86362001)(5660300002)(4326008)(966005)(66556008)(66476007)(66946007)(38350700002)(6512007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MkIF71ZglooY9finhkpQqFR+HZBLW19mb/hH0JCZxfq5LMKbVHnbkkx+ghRS?=
 =?us-ascii?Q?mqmfzqPMsIZX8rRBxLJJB0V1uVeu49ZUxGoMnEeuUcEMVL4fMnL2X/ustCrT?=
 =?us-ascii?Q?DoDqVJ6zvy5MESPN7fj6/EabfBH/T+9DMCE2eH7Qteqd72DaU6bs0jHDz7xt?=
 =?us-ascii?Q?uQFk3LocRPiuG/vWoLPDTdkfmmRVRrVb+qg5c8e3kcdGs6Fu/h3OGmLwTQkX?=
 =?us-ascii?Q?gTykDDR/cMKvTZ2Ygi7Skk9JvFvs8/+cgcdngKuQPuZPa3QkMYtzYmyzUVJ4?=
 =?us-ascii?Q?dXA2Ni061hsS1A4JEIaEH493PoBTl5Mx94SeIjbCPzvebAJ+si160Q5lGig2?=
 =?us-ascii?Q?WYQ3P0+vhFBvk/eNVOTBmp9rjk8MXMRCQClP76kJh+FuEpmzI65MoolFSQ4E?=
 =?us-ascii?Q?UducGiT9cfUqDsFnXC5go8SAdntPBhYgpgLe46eL42WIUpCVacV3m8iLyBhw?=
 =?us-ascii?Q?t4sjX1J8LhER8LigIynTBqF3cLvM7VXGP3bNv1JF5JV37rgpHaArlpmoi6aY?=
 =?us-ascii?Q?Uf920shLcIoxM9S74y3COK5BNLi7MLneOBjyoVncnFLUk8cclgaZeh+wqqR+?=
 =?us-ascii?Q?CRgzYmqeoXwxJVIM1EY1rATknvdDMZnknvkiRlEWw89UZgRbyt6+ID0yEfT+?=
 =?us-ascii?Q?VZul2UtplgVGi+dxgaHIBdsKoChYnhtbr6D3sXlVGDALAB+2HAvR1jaKVlE1?=
 =?us-ascii?Q?K/G3ZfIV2fmcRTfjA33D4g32e09a4tuHeM1OZdK4ZrP7wDX1iXdB7xRA7wNX?=
 =?us-ascii?Q?0Xqqg5FdCWtDOI5M1X4Rhof/kGUrZ6bT551qnaZqTx2zHmkvUtCWYQWpSrOH?=
 =?us-ascii?Q?EkJSWYW497SdvMJQr7ca1SkFFTgC6E5zYzSt0jfIhYooDWn+79LEnk0PXCNs?=
 =?us-ascii?Q?i3H+c1+tcnfAI7CAPLUMze+Kk00/524eWDq+/Op6eK9Yd2wBOOO+0szj1DMK?=
 =?us-ascii?Q?rxUX7vSf3h4t6BsdON7J5+/knDA2sZkQaaPgsv9B/gAlEHbb9g4yUPInXFap?=
 =?us-ascii?Q?mG8tVabLYkr1ruuM94kzrcHOvlGpdn9Ue+DZ5rGG4gS9HrZave6GbTxFCioS?=
 =?us-ascii?Q?bGfO0K14bzcPkaarad/P/tjzPreDMAP1Qc9Ajs/oajJk09tnnXyTRM4Sby3U?=
 =?us-ascii?Q?RxNdl9AxOLIxmnE9iAk7ZtjNw5ipQot/wL3uCOGPqdI/thcBDTbFbYmULBWz?=
 =?us-ascii?Q?hImCqE80GG3Kdo7KRRiVYRq5+ZT2Pj/M1bpcOIs3aq9LcUZrkCkoxpAzGuMX?=
 =?us-ascii?Q?nL7N24tjS76nENIV84evgNjUIICh8AUEQ1K13o4EqMtKJrwAVsLvG4ZPz2LK?=
 =?us-ascii?Q?QlBPe3vsjVjy3T3Ji1pMuf17?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a439247-cf7f-49fa-0cc6-08d914b0c81e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 19:12:55.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/fSIrYHIqHfXwfUzIJsZCOfqNOqSDyZM2NMcny/K2CBn/jpJpczl++X0fGyAR3qIBvH7KMsiCm46Y9kvCB/XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4154
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
a "soft" block, so it has many parameters which would not be
configurable in most hardware. This binding is usually automatically
generated by Xilinx's tools, so the names and values of some properties
must be kept as they are. Replacement properties have been provided for
new device trees.

Because we need to init timer devices so early in boot, the easiest way
to configure things is to use a device tree property. For the moment
this is 'xlnx,pwm', but this could be extended/renamed/etc. in the
future if these is a need for a generic property.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---
How should the clocking situation be documented? For the moment I have
just left clock as optional, but should clock-frequency be documented?

Changes in v3:
- Mark all boolean-as-int properties as deprecated
- Add xlnx,pwm and xlnx,gen?-active-low properties.
- Make newer replacement properties mutually-exclusive with what they
  replace
- Add an example with non-deprecated properties only.

Changes in v2:
- Use 32-bit addresses for example binding

 .../bindings/pwm/xlnx,axi-timer.yaml          | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml

diff --git a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
new file mode 100644
index 000000000000..a5e90658e31a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
@@ -0,0 +1,142 @@
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
+    oneOf:
+      - items:
+        - const: xlnx,axi-timer-2.0
+        - const: xlnx,xps-timer-1.00.a
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
+      The width of the counter(s), in bits.
+
+  xlnx,gen0-assert:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    default: 1
+    deprecated: true
+    description:
+      The polarity of the generateout0 signal. 0 for active-low, 1 for active-high.
+
+  xlnx,gen0-active-low:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The generate0 signal is active-low.
+
+  xlnx,gen1-assert:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    default: 1
+    deprecated: true
+    description:
+      The polarity of the generateout1 signal. 0 for active-low, 1 for active-high.
+
+  xlnx,gen1-active-low:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The generate1 signal is active-low.
+
+  xlnx,one-timer-only:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    deprecated: true
+    description:
+      Whether only one timer is present in this block.
+
+  xlnx,single-timer:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Only one timer is present in this block.
+
+  xlnx,pwm:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      This timer should be configured as a PWM.
+
+required:
+  - compatible
+  - reg
+  - xlnx,count-width
+
+allOf:
+  - if:
+      required:
+        - clocks
+    then:
+      required:
+        - clock-names
+
+  - if:
+      required:
+        - xlnx,gen0-active-low
+    then:
+      not:
+        required:
+          - xlnx,gen0-assert
+
+  - if:
+      required:
+        - xlnx,gen0-active-low
+    then:
+      not:
+        required:
+          - xlnx,gen0-assert
+
+  - if:
+      required:
+        - xlnx,one-timer-only
+    then:
+      not:
+        required:
+          - xlnx,single-timer
+
+additionalProperties: true
+
+examples:
+  - |
+    axi_timer_0: timer@800e0000 {
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
+
+  - |
+    axi_timer_0: timer@800e0000 {
+        clock-names = "s_axi_aclk";
+        clocks = <&zynqmp_clk 71>;
+        compatible = "xlnx,axi-timer-2.0", "xlnx,xps-timer-1.00.a";
+        reg = <0x800e0000 0x10000>;
+        xlnx,count-width = <0x20>;
+        xlnx,gen0-active-low;
+        xlnx,single-timer;
+    };
-- 
2.25.1

