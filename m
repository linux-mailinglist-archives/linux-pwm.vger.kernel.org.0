Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1F945B004
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Nov 2021 00:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhKWX3K (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Nov 2021 18:29:10 -0500
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]:58279
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229646AbhKWX3K (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 23 Nov 2021 18:29:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbjWKdnGe78PJtJ5vzelqMhJ7aKuqRbdBaToBSUXwLLb1O/K2IhKXlQvcyYQbaJdMK14AazXVVnqTYFNUtpryrJutgo+2ZI+X+KmfSXihfWBvNTiKnSFJze70y87707R5fMykEyH1wvyoFwlzzObzDWMPijgDnBVO7sRjKO4/Sp1N77zEXTpK9pglBVxtsrb1S8EToE/Gl0kN8tIW1N6rvfXJo8ChE6ew/UKOWJprkF42yb4FhpJvIA4BkNm6NwSftbmZJIdKcCR30sj/n7xnHT9ykHlNcsw+qZYqoL4+tvJrKV/CrsKrrAsBZQkWTGfSc+Ff9e+LywlUvzKWexi2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5K6zQeSq3sQcrKCaApSUoICBfsJi/RsiIe4H2tEgccw=;
 b=F2lqGEG43aeU/l82HmLLM+oFVp1hlpmpy3IGh9sF3cZXLdYdopJtdTyferJsdM9eDX7nLH0eRB0iED78MVpbioW67RNO+HfV0fAiF0iu6TACN99fXG+pCFQYHEtfCSridGClDmFaBrxLR5miUycCnYedz6VfSyZNs0hKd3W6AyC0oAthyBcxvoOvNAnD5BfHIC7xAdf0KjV0MXIHXjYW5WB0cqp9zyQDHRnmZSJzDFamGWzd32Qqhxdf+G4ZUV7q/C2hut48NVm15DHSxoJPsM4rSWPr+VtSFeW1ZeODtkESNpYR1jscWPgjLhfaUQjlf9yFo11rW8kuLUXRLtCEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K6zQeSq3sQcrKCaApSUoICBfsJi/RsiIe4H2tEgccw=;
 b=AaL5fxfEbUt3Z0UOl7fxC2VmbOsHm6tOEK+3CdwcXiIswMJMrHC1Ull3hCZq1Z49ESQKuuNpKsIp3pJ2fyQEjNNhlqDthkMfjo9Eymz3gqicHUr3vZjmqD3ZFWOaX4ckR0iucRBMav9cZv38Dzq6m2ca+wB6afVXdSiJfbftvSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from AM6PR03MB4518.eurprd03.prod.outlook.com (2603:10a6:20b:8::17)
 by AM6PR03MB3942.eurprd03.prod.outlook.com (2603:10a6:20b:19::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Tue, 23 Nov
 2021 23:25:49 +0000
Received: from AM6PR03MB4518.eurprd03.prod.outlook.com
 ([fe80::64b7:6a0e:6f2a:424c]) by AM6PR03MB4518.eurprd03.prod.outlook.com
 ([fe80::64b7:6a0e:6f2a:424c%3]) with mapi id 15.20.4734.020; Tue, 23 Nov 2021
 23:25:49 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v11 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
Date:   Tue, 23 Nov 2021 18:25:35 -0500
Message-Id: <20211123232536.3909773-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0134.namprd02.prod.outlook.com
 (2603:10b6:208:35::39) To AM6PR03MB4518.eurprd03.prod.outlook.com
 (2603:10a6:20b:8::17)
MIME-Version: 1.0
Received: from plantagenet.inhand.com (50.195.82.171) by BL0PR02CA0134.namprd02.prod.outlook.com (2603:10b6:208:35::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 23:25:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8befa90d-36dc-4ffd-eeb7-08d9aed89534
X-MS-TrafficTypeDiagnostic: AM6PR03MB3942:
X-Microsoft-Antispam-PRVS: <AM6PR03MB39425EA757B15BB7554FF6CB96609@AM6PR03MB3942.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KqE4iSMuPHMo4YR7NMgi6BbyD034TNlt6W5EhhQAJXSi3heQZkT+ewlyPi/GWjip1T++ndEhN01rS6oKq840WycI38UEj4Y6jIz5qrXkJxlskK+zo2WG2YpaAHBLO+qAuWgE3NM68EbL4cZXWIzf3lNu0HBiMJprVwQ3NECQXip/eduQjY4XuthWWM/OsDg2VHncWE97JQI6as573wx3ONNKd3h98P5uTJgiGregs9/W77VXhFrBjUjpyzEkjclXmkz2HfIQx2KOzMurKh+YmdhMfD5wUt2MORNqj16n14i6tQPt2/fc3TTzbOsMJTLnigmpyX09eXy7BCGC9SdA9eT2xulsoLkVflwT8cERLuPshvoaVSY6xJe0GzAtuagxzbDoxNxY0atV4eNhTalUOdJ9bNS6pVVqMg2pyiyRYBa36qj85k/JqqOwFp8+QD8KpSeBnDW37fi4/79jV+qJeugwMIzxr8n1LZJjA2TbQj09gUHqdKufidUxn+u8/vHeLpSdsAog5wZBTnSry6Gqhl+bo90SKXRD99kQ8yo7A+5wy+sUzyjwaiTpZ+YaTeCIEP9rZ+Vz0ht0+Tg1NH+TEgM+4AczxG/77cKre25NZFIbrXwED9rIJ/Pv8Lu4prsaWOc5eqnOyV4wN5LKCext2Uu5Owxgw+82X5ZJWrXLNlp7WBigM/WeYJURNEobAivfn8cFRvYuuH6bBDg3N+4QwaTVIGhzVda6LtUb10YnhPMCcat56tnpjPXImzMU5+mFKj2Jcaezjqs9cwfIvt4t51C7JaV6rlG4LpPmLLjuLxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB4518.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(6486002)(4326008)(508600001)(966005)(316002)(6916009)(2906002)(66556008)(86362001)(8676002)(66476007)(6666004)(44832011)(5660300002)(8936002)(66946007)(54906003)(38350700002)(956004)(1076003)(83380400001)(36756003)(7416002)(26005)(6512007)(6506007)(186003)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0bdi3kVlFZRqS/jSofIrr6ubsJmcQ0b5kBMEjVUsRMKT9qKDPSU6bey3NR+N?=
 =?us-ascii?Q?DF1S9yaEfiZBxfhDPQeiag1mZbOyU8rid0cZgycMr+g33vXaQeyQ8fGAfyu4?=
 =?us-ascii?Q?EGLE+PCuPe+qFu+zbVR5nGbp3UwTtnrTBDznIiZN/su7JtFctaHZ41ILPZYi?=
 =?us-ascii?Q?nV34WSL26lUVkWsbKaVCNDYRuCMl0K/aV3M1rUyEMgOT3TAW9x9Rw7+t7NVU?=
 =?us-ascii?Q?A0VmBFPg2FB9B8TZAnh0nFAkA2VmK6WirX6EROgcrqaYe4wcEYCWCsxwjGIQ?=
 =?us-ascii?Q?pQxnCFvssyWsKAhjMS8gre9beNFXTSxZJ/6uDq0uiCmXmqJ1WEE88ZM4qBgU?=
 =?us-ascii?Q?bXUP8Pa3Q0Ab61gXAdmsLh466djTwZDMN2oydgGZWwQwkc7dOWjfgr3CPQKt?=
 =?us-ascii?Q?SS3bbIaMhFZ5sydYLlJYEb19zvvc50sYV4qJMQ1b7eAoCLHhK+JzqavmkI8x?=
 =?us-ascii?Q?Ymd/pBNFjnC5bnOk7KIPddQRglUyxaDshS0eljoIHbHNsJdGhsYYCzmsVjK6?=
 =?us-ascii?Q?Ap/dfCVG6PAI3IwWQvAZAA1D1jp9ZBAlpWvoVch4TdHvqUB3440H2e2ghyTt?=
 =?us-ascii?Q?w5/kb1/1z4YeGNE+HiqEVDCjuumO8z+YsA/wIzLQcbqIwOKkv2NI+XM7jh9I?=
 =?us-ascii?Q?RHrNiSB4Yl72CnRjKWmrkM0t3r6B/knj8plTFtkikeRvS6u61T+NkrYWpDwT?=
 =?us-ascii?Q?EMvrZIGUIEXRoQXa0ZX9Z6c8hF3ukuk8it9p4T9VMLPeGbl2JGxx6jvf1MUa?=
 =?us-ascii?Q?3f0+JE2bMWVN+5ADaMrVUUuZZreW4IXpaFlxDupDBQlZWPToQlXrE+ayUlRb?=
 =?us-ascii?Q?JV2KASmwSY6imbDvQuPsEvoONIIC4UN0Z1BFtORnORMD5xM8ngFKuQpUXm7P?=
 =?us-ascii?Q?MXA6hwAkzKhLpsjrndcVdj/RVpeuwua7LIxnU504e+jh5XMbDPQ8pfHmdMTk?=
 =?us-ascii?Q?TxUVrWScPomb8tWRf1myOZutqDvxIL2llVI9YLylxtH6yCT5u/xf6P7rFa5x?=
 =?us-ascii?Q?XR1/EJRG5oeOB8KuB3ygdtaZGcBJYfu/DjDXGGlZKC9mKnL3UGjjD9jMXMaj?=
 =?us-ascii?Q?Vf9uOCxBtES6/XRt6eq73jT/M+Ab/YRpEX2IvZkRw2MvqmGD0WnErbwRBgqB?=
 =?us-ascii?Q?NAat4BNJ6U7+ARvbsW6bZVEa+QGOyL1FauOpXUrcQiIOS8sPyMW1quhlrB96?=
 =?us-ascii?Q?84PFmnl9PSY/75NIWrdY4gyuXn1ZmDSto66PFqLKFLXwaVTsfe+a9NFoo7RS?=
 =?us-ascii?Q?1ynjvMjpfbSpQ+VA3a5+PpCKrRuUbgTxCnO5GGwscijVpu6AG+NMoJiRtXR1?=
 =?us-ascii?Q?WrLOB4zilI4DfworHodBE18wrMjBZ2nv2JnAcjtmgwHleoyADFNuKRxyNP4g?=
 =?us-ascii?Q?eMPRVK1l8Je7cwi2MVGwPGx6qZeE0jfJpbQr+estJ+Gvqc6sFDHrJnn3wXJQ?=
 =?us-ascii?Q?4GYdg1cgT3uzApBZdZtj1WHV8yh6NiR4aOl1BNFR9dLaDecll91ELsKSwZp4?=
 =?us-ascii?Q?wUoML5ETvKMmDmzcuxJA1cliSkPHlyVmq9OjM1tEK7uNqFdZYKe2r/m6J0mq?=
 =?us-ascii?Q?ZRp4qbYaav2xaPTJymX4lKSZBZ9C8A+E0cxRYpRUH3JJVwa8eX8j3IGePcpC?=
 =?us-ascii?Q?8q2ukwpb3qCHr4cVUP5Hny4=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8befa90d-36dc-4ffd-eeb7-08d9aed89534
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB4518.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 23:25:49.0238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TW/mLzku0YzZsXLYp0uHKZnhRGM/zmEWdUbLHJs1fN3xtfevTbq3sRJkEc9cxUNOgRgiWigPkwJ1KTo1kpuQLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3942
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
Reviewed-by: Rob Herring <robh@kernel.org>
---

(no changes since v8)

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

