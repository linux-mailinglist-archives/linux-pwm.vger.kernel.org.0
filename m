Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515AD439E22
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Oct 2021 20:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhJYSIw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 14:08:52 -0400
Received: from mail-eopbgr30075.outbound.protection.outlook.com ([40.107.3.75]:3140
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234157AbhJYSIt (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 25 Oct 2021 14:08:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kax4IbwjuTx9+1ikEXYwL8DF9QaigN8IwYBamCT4zg8WAIo1kFFHI9bkNn1fruGjzqsQsb4jKlh+E6MYS2qSSajAyymjWx8BE/pBIJ4qzjU/qTA1g6LLTUnlZvaNgMRnr3A1hNSsMX74G9UcNBmxtMycD7JglQQn0c3BLMa2xPNRqbW+fGvOI4/G6n9qC7UGFz2PiyjsknZfyOmBGz8QWDqlFnwAkRcvBqbUxsTnolEGtjW8vAyNsM4avU5t2IAXIOOk6WYaaiWffkCN+k7CoQ2rmdbvd9wT2Wd4ght2dtEAOxQ2vqKR4tW4MO75Hh+KaVOn9hqc1qIDkmtN1cnLGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5K6zQeSq3sQcrKCaApSUoICBfsJi/RsiIe4H2tEgccw=;
 b=h7gltaICtLVq+vgX+41/ZXhYSjqFW7l5ZPaqshYVPoth0nzoKZhshWZqJc5ZEjy0SETHzQC12OEnLErMQQ3AtHWlwmgUjkNuwax05S7B0A9PZEJ7GdSg8vksSr5ShCObTM7Yt1vGmRsWg9O4gsBht/FMJraMrMwvZlvWGAuRy5RUuA+Gd1zCf6CBJ0iOG4U7ikHr8KStOmuh0IOer6GCT3Em1w1hWK3uMPumN5ixVWQJCsDxWy2csEr1THBpy7JnvOxwkUcjALma1KJoBmRbGAhj2t4U3P6I0Fo5Opt/3cBgNphCL/MoZdCONG/S0JDyFQk+bvtHQLmMyu0aEh6Dmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K6zQeSq3sQcrKCaApSUoICBfsJi/RsiIe4H2tEgccw=;
 b=HBbTadaXGtvysgCnF4qWzYd8exqQdZ+7fwSVe/dxJk/zShslJLotzzk/8vmoQ4HvWRPbgexm2T2AcSWiq8N8UXo5E6rPqaS7YT2740Axm2S2i7kGG3oq9xhazvsNB4KYWrmhX36P65ns7AsrCOBxcSkPb1VKARAY05wO9Hbqgck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR0302MB2823.eurprd03.prod.outlook.com (2603:10a6:4:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 18:06:20 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 18:06:20 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 2/3] dt-bindings: pwm: Add Xilinx AXI Timer
Date:   Mon, 25 Oct 2021 14:06:04 -0400
Message-Id: <20211025180605.252476-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025180605.252476-1-sean.anderson@seco.com>
References: <20211025180605.252476-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:208:32d::11) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from plantagenet.inhand.com (50.195.82.171) by BLAPR03CA0036.namprd03.prod.outlook.com (2603:10b6:208:32d::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 18:06:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fa8ba43-5d49-4476-ba71-08d997e22593
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2823:
X-Microsoft-Antispam-PRVS: <DB6PR0302MB28236D4887B3547F98E63ECE96839@DB6PR0302MB2823.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jajTX74m5loCPjPI8eScWFDOd74Se/oZX2j/CBu9AYDUqToYV7ZYXd/P8g8NhboutHlbESErhZwm7VQFpUXvAE5Dwog39FGIyaonANKEU0y5u9Z4+5GH616F2gWk0AgmTteI0wAPVMydvCZ+Xw4HnOKB3H8+Fx3OV//mrUNziGL5384tjopLonIK2NyWl0u8DGDa6NpeT6rip+E2xbM8e6sEDCMZ34948TLhEdql7LEtOw/SoM8arQPgoUNHc/ZeGiMSlvqd/SWDiHOyyOU9BQwAcKp5V0L72jPnlz9/g26aCTP4BWMvWt0dSZoaN3dfJvfNZhdjCif/o0hti5T5oas0r3N6AFNDkZoPJJeHlzM3sNPHylk+3uv0/kSnp+u06GLQbTuCf+TBfJ1LGXwt0K2NDiTGgzMGowjTQz+X6cDxyJLJUoBsjNDecOaKmAi/unJGQuRZl5FnCsjMBm2qrBHvm6j6OkEnptmuB0sM1RrKttI4PVFqgwXcpM/BQMaZrxKiM9W01zWnFzVEeGOOsVFo9XmaVKGLEJKWFrSMIlz7/IO4BuG+A9lYXZxUddwjwQpuQvsU2BZRKGANF3LMPrFSpq7EV3SnJ8r3E6QoEQMHwODw56v4gscJb/AUUpRJXHi6FFl4wno5WmoZ8yqvTemrYS7w4B9IBW06wr7oU5ht8Vsxy0pCh41TS7stjecqKGDEtzbIxyjuFU7cowHV1sboq6RQJ+bl+cveLdsTeVCpEt1hPTmu9oLQNUV5SXWnWc0fFgb/ASLYzBuVE+Ui7mjEB49jLabAio1hhtlhvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6486002)(6666004)(54906003)(7416002)(2616005)(44832011)(956004)(5660300002)(83380400001)(508600001)(2906002)(6916009)(6506007)(316002)(1076003)(36756003)(66476007)(8936002)(66556008)(38350700002)(186003)(38100700002)(6512007)(66946007)(86362001)(52116002)(966005)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GxEhVOcNjdVz41sZhaMMXwyz4ng+hc8x/pnEaWzCgyXR+ryJ3xw91RxMHjEy?=
 =?us-ascii?Q?ZXNA81PQzIJRIRUhMkeotD4ecNWvRqF073mCD5QfR6imLHroLPtYhdW8ZBAM?=
 =?us-ascii?Q?cz2exj36FrGK2U+RjOfnr4S8O4+fgw7h4zHi5DWtGNAyZnn/39oS68sCkAnj?=
 =?us-ascii?Q?B9lktkZ5z9mlV9JDjZRy+ynzigiw445CT0XjxzLVZvZSGoRtif89+Q0LyYjb?=
 =?us-ascii?Q?exi6SBuDwmYpMGi4V2fDDH+9ePehue6lMgrf12SjoUSHJCAtoh6s5WbR57au?=
 =?us-ascii?Q?bgulKr2TS1Umgiv6yXId6azegwdV8DpZVHxV//obe1rzB3AO854Ik7T+gCJQ?=
 =?us-ascii?Q?8Ij0Mfa0g4es97tiZr6XKQjZFGmcMvA603ea0rB3l0ZXiClzPkOjnhzM1g2S?=
 =?us-ascii?Q?LFX/TJ+zRa9GGN5av38M4vSUTQFHpCNIWp1oZWz24ZakxVqtTyrfoVaCbzHn?=
 =?us-ascii?Q?BnsbxFmG3dK27kPIPH4GsMVhq4/JQqpcgSnxjduEm3lb5a64f8met4igtLbz?=
 =?us-ascii?Q?wT/fj9EJzPPO7GUapbAcBpHkQTh1JG/2QI4qsx4q8t4l0DwLrOSTrmRsLJ5n?=
 =?us-ascii?Q?UV85pjGdi4g8oDNivlVXjetkIeFojoppUvrCvTv/ABfQN4tIcL8HIuDov/Sz?=
 =?us-ascii?Q?wtwjJfebRHdj68O/P05MLS5l9GKwtWU8P8d22/eZVzSmLOQfQVmTP3fTeQpF?=
 =?us-ascii?Q?BhqVpn3ZrrAE9oqdQC0KF/CKB4kVEwvyC+8887xBnclYQ7q9k/cEsfTlhrCx?=
 =?us-ascii?Q?p6ET6aVhctne4ODJ4jrrFOHGHsZtCjdvcmsWOQ8brhYOm1oTxeixuEYTFuvR?=
 =?us-ascii?Q?zFs+mIxrUS7kjo+ERuhlp3ZDcPR+rLM49ANlS4qQQFaX2xHruyjDghMTuqC3?=
 =?us-ascii?Q?aT7jNiMgcgCjtLZbxPjT9C+KVs5gTAWsAIFMymxaKS7xe1hV36Fqr9HuQ8JM?=
 =?us-ascii?Q?eQripkI1dlm5DH9ahO4zOXwnLooN/qUtKvbvcqXakw1g0wQWcEkRTiZGTIBq?=
 =?us-ascii?Q?48UzMnIUGDclu0TtEeHoddWxANHv9ycIoT0Z+NV0DoHKqA7gVhYHnZzdfi7m?=
 =?us-ascii?Q?RS/fcXIugdZe0jFRoLykoRY8XBBf5LwCdXc5jJm5CeFmJYtjOgRWTQ9O3AW9?=
 =?us-ascii?Q?ngip+QBuewudPKI+4t/SjrLoFADW0M3YM4R+S+lHLRtbhieXhrJcS0DJ4M3T?=
 =?us-ascii?Q?RQEEOLUTKWREoD2YKk7QpGH7jozd6NBqBqPm/nSLl++J8524tnaU8R3eam91?=
 =?us-ascii?Q?+nG+QJWKKbwcLUkZuyaiQIE5MB/dQh5Ah+1AV1grO4pgS8rY9ch+PFqEQrQr?=
 =?us-ascii?Q?ljrm9CtQVg4j3MPLaKh/9ENm5fL600SPdE/21uwZxEITLk/B4+fuK7IvNe1p?=
 =?us-ascii?Q?ExxiP2fE4lkm3MpMyy0Op8V8h5XrTbL8sPizcyuRh+/L7g4AtKPwZD9THKRI?=
 =?us-ascii?Q?SMPQumzT3it1F0gCQIVAX5PBKhjL/iTaiQ3Ara6PhTOnkHbCwaZ2I9p//8kZ?=
 =?us-ascii?Q?Fd0FZo/+JCRQcp5iNj2ggLgWhm0G6eBirtw+1sOiE/qg4TSrNJAGn/u4DCbf?=
 =?us-ascii?Q?a3rVKYuz5ZB8430hD3ETx6+sg/OhI45x6REn61HbjzdvjRFqiofANoo5HVut?=
 =?us-ascii?Q?jMScAKXPtK8uqUZnBskBAPM=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa8ba43-5d49-4476-ba71-08d997e22593
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 18:06:19.9386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMDrej3ZfDdeL+dhHL3Nq25ikLCOEiGqGPtJ47Y0YrizU8Yj2d9/mux/lliZebKDKwO1ZKc7iggEuwfqCHqQlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2823
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

