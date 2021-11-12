Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C49344ECEB
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Nov 2021 19:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhKLS6Z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Nov 2021 13:58:25 -0500
Received: from mail-db8eur05on2086.outbound.protection.outlook.com ([40.107.20.86]:5344
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235265AbhKLS6Y (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 12 Nov 2021 13:58:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lx5U85fPkRmyjn7tNMB3Aq2VLrVCuAMRuKrnAOUvCOaGZrYUwnYIO4ZrRS5FHE1y74kD5StU6ibQnzxhVgGZK5LOTRvw54kPBjlYlmIo2f0exuQ2Ou9DlFX0Kwi22qaM/eaC4SPutm+KapNqtQmpYj6lyDd0ymXKygeu1sOIennRtLuFuY9ZpvH/XZ3czkYPvS8TYu3MblX5J87Ut770CCWwO8tbd0rLwDIkJu0aXDAMzdOaZBoZKZw+pNG7azBp/JETnMl1PSWZaEYKnV0X+UhnFzxrpCeACMT5h5c988a3UHJrHvdHbK2Oane20gW9nLql1UB+C4+rrmA7Bt4bxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5K6zQeSq3sQcrKCaApSUoICBfsJi/RsiIe4H2tEgccw=;
 b=LeF7Wdz/zRuRqoUvOAhoiHeu8EI4zKCTZ4VVgUTlXjc4Nu/uNpa8WjL6q8mzSYTUIqDYUxITBMtRZMMS64JSq9Oe7yshIORb7GMGANdFfrQWRXYJAfGbcb+YHv982zCzA1s6TvibINfW640Sj3s7IkTLKGIYC94NM0pw3w5iPgburxSxXDVEZKtZ8ibow/36K+3iaRxAUuo968HRvLJhQafDU8W6i8ym8HU2vrOtKyuL4+uHE1Og4NxvPXbPuXO1GNbU4MSNfQR8tFl1J4pdJSFnSgQzlEkIRU6T+jRSpM5QagDrQ1E6uFCW0rmn0FRY62XXowGLoOBVKxke3CgOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K6zQeSq3sQcrKCaApSUoICBfsJi/RsiIe4H2tEgccw=;
 b=n0FOP9VkSd5EVu+gyThvke6ENkLG67VRL0RLsA9/EB7nV2v3kT8vK/0+sRRsMvAttxb1y4uIi27OK8ddhuUc+LrH2UJQUfivBy7iaPtM85Aa29KUIHkJj2tRjAKW8lkHsIlsoDhlxF/83qiefp7xr5+RrdmXeFOLovtL/FpjpFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB6201.eurprd03.prod.outlook.com (2603:10a6:10:13f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 12 Nov
 2021 18:55:30 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4669.015; Fri, 12 Nov 2021
 18:55:30 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 2/3] dt-bindings: pwm: Add Xilinx AXI Timer
Date:   Fri, 12 Nov 2021 13:55:03 -0500
Message-Id: <20211112185504.1921780-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112185504.1921780-1-sean.anderson@seco.com>
References: <20211112185504.1921780-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:208:2be::35) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from plantagenet.inhand.com (50.195.82.171) by BL1PR13CA0210.namprd13.prod.outlook.com (2603:10b6:208:2be::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.14 via Frontend Transport; Fri, 12 Nov 2021 18:55:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22b4fdc7-d20d-4451-4133-08d9a60dffa0
X-MS-TrafficTypeDiagnostic: DB8PR03MB6201:
X-Microsoft-Antispam-PRVS: <DB8PR03MB62019B9D41FC3FD676727D2696959@DB8PR03MB6201.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDuFUEiGvVlc7F7i/o+GZXvAN9q5AUR7CowAczw4vFoNWp3e+5MvBh78SFvN4z9mxJgRejRhs8s9CxYNL/N9jBu7/ZtKx2OgB4pAPbHwEDI+5yFYbtc4OckFFaqjpMJImpuQsNsy1iywkYVfj3ver0lf2pnHLawdi+K7Y208kaNpJTZ+2DJ5+c9ruqojUuZPKYFsZJfG8NEMum61Ej4m/Otj3ZxmYsCxXaJk1T/0nYpfDRYiv3qqoZKB67h+NKMscmjk/znfUC4SClhPBQTVKqU3kObVXZptLZiElzTstw0o/Dei/0dkG+c6TFpix6dk9F4egRNkwm/L0lCTwYudQCuWjJNvTwC7OXOkgu1AENn+yjq8Ygd5pq0dVoeTcGmeq7eweW7dg/Ee/Es08/C/rPpmZo1vMxKB6Z59+jEnzVAR47HOo9pRW6LKA1tBOTst8Lx6IB2A27bOdlWzi9tiif3nJqG7e0UVrLDSEiG5D5w3d0sK4BQZW9Np1234cBp8Gglq/cnWDw64D1EtP+Jcsfobe+knYBveH5Ms4qyanDVNuVkb3LOV6L9WXQT/nxXpdo0t0Gh+Ew57Ei2TWlQWcrUamqnMczYPyaYeaI2tnDhyOg6uLVMRl03zcjOMKc7AspuWXcI0XiJfHUthTaot/DWtIt2Lf/oHWsxAKtYKOp539Vz7I7ivuQX11Ibk1ypuqeo1To+9uQqgRyxaV5wJP6VYnQ3An3/OMgupZji4ejvi1hdlNMHOSHmiXrp70eBDR8mmrkb+pe/jHJ60s3m7/9eaJDHBUeUZncWcgx2Ga/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(66476007)(66556008)(7416002)(86362001)(186003)(1076003)(83380400001)(26005)(5660300002)(316002)(508600001)(966005)(66946007)(54906003)(52116002)(38100700002)(8676002)(4326008)(38350700002)(6506007)(956004)(2616005)(6916009)(6486002)(6666004)(36756003)(44832011)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8+0u65I0/andy67Y1zH0VcdXhqeVLYZzYZuCUMWMM5wh9Nd43eOnxYJQkuyH?=
 =?us-ascii?Q?lCJdXct7M3x4q63pUaEfxmLlWrYaDNuzfUKRLRBp+KKtIbaazTFDr7NY6J8/?=
 =?us-ascii?Q?v98DKJMjt9K3svEzGizgEq9baGK8YTwCZYjPd/eM2S4RPcmw9xZR/dPhEQE7?=
 =?us-ascii?Q?tc88UwjEquy+b6UYeSZQ4A9+bUSyhdeUB12m2AELcMGpjn3besUlBxW9vWbL?=
 =?us-ascii?Q?xDF+YjEJttBqVpDjdV6BB1Of/V1K0ZaRJAivByOv+eFLaECYhq239pcrwapA?=
 =?us-ascii?Q?E9yXmEkMyuPmdU5pvI1QUwVFnZEzJhrx+iZyekvvmrIKdvHypyPbJW7Erw4N?=
 =?us-ascii?Q?yE4am5AMI1Hav/ncVz4VidornJhSkD+YpzEDuI0zr5TzLaxBfd/iMxJGboIF?=
 =?us-ascii?Q?CfJXC86c4BznnmVl2Dm+uuH/0TYdtg+KJua9xbNHGZcywTWq9rEoa4F/+yQL?=
 =?us-ascii?Q?OmCTThBEMEtXvdagD+MVntNs67MLn3RZYeM4mBt4E9NOp/IpeQkwhpsfJ6sQ?=
 =?us-ascii?Q?JqRVPBkzZmltDqO93+S8ymafhjABTr9S17GLDauOOZ0fC0AWbckQ048+rSVS?=
 =?us-ascii?Q?75HJ2MXnnXLrBcv4g05RCRmVQ9ySaAwenPSwRWPtNKaegpBN13mA+m+YKu/Q?=
 =?us-ascii?Q?WlC2Xr5+iwtamlLzhQhdHRpwRhjPACKBtvHOr53+R7d8ZliaPczFADogQmvl?=
 =?us-ascii?Q?rUYK3tEqaiLBecR3dw4+6V5xVL8Bsle+LaKhFDOQSllCK1UA02i3uFglTukY?=
 =?us-ascii?Q?srtFEp9nsdWdTaMsLUJAXiwOB6y08E54/4NyDN+rHQvvCJPaBHaghkYp1PgT?=
 =?us-ascii?Q?7GOfJw6JFmwM6xBGNvwpSQPGkMDI/Dp47BobhQXt4TJ+uwBAup0Q2J2tdRJU?=
 =?us-ascii?Q?2TqP1dQGvxVsySurAlhsAQoJSKpXnhz3DEQ4CkGtLPHP3muki2lioRZMB4bM?=
 =?us-ascii?Q?6piya7Jdx6I7Ja3GMtYmeIi+6MHPx8buXNBI1aJg1yaIwwr0k93KJFQ3fQeW?=
 =?us-ascii?Q?47F89qZKV9QKNM9IIkS5Z/hxcFnBMX3tBst1s39nhJnJhoDj8XxcrGERLOxZ?=
 =?us-ascii?Q?4LeWxjp5r/uBUUZAjxrqxgpRBcF2+Z5fwTA8lZ0IeCzEnOwVLCFbWsYruaoz?=
 =?us-ascii?Q?zgztcRrPa/Ml0w3+A4qycwPq09UbODNKCdsSSb4JuO+W0KRG7ipm+NlBSeAs?=
 =?us-ascii?Q?skDuZkLAP2UIJBUUegGaaRvWWKZmeKe8A+ukcimIaqXQXydyEud/hHj+JvZt?=
 =?us-ascii?Q?fqNCBzW0w5GQc4BCn6bM6vA/4ent8+d9gJ1+aCCMJsF0auSyzcQDYlJAY8Oj?=
 =?us-ascii?Q?bdVmPE6wv45nL1fVwPlghDaPPnQsJIU7Uaj94YHfAG3Q8Fio8+jx4HnEc4GM?=
 =?us-ascii?Q?J0SQ1zpsP09Am9/bwkKkg6bg4RegGMBu638ekPWw2yIFSh33z78lKfGT1exI?=
 =?us-ascii?Q?Dw/I9Lywgd+1YfJSVi6WeYsfPJs0r/3UPNoZeGT9kiUq7U2PvXQ9tqd6USns?=
 =?us-ascii?Q?pvp56Lq6MMdPPIEPpCNqTKi+pEV+T4YP+4mB216NNw4Af/CHz8zVDb7YiocO?=
 =?us-ascii?Q?WK4RNyKURRlwzIMQ3bBVSZWbufqk7zGvPgbFfAlIgl0kMwdcjzrRKreVwDK0?=
 =?us-ascii?Q?uPVH4n1G7/ycRc8lzwOvme0=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b4fdc7-d20d-4451-4133-08d9a60dffa0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 18:55:30.4880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbOqa768Sx1bILv2cczeIy6cbQo6FqnK3cCAaayM782R+ebY29+U6mMpqMc+f3TeioNz2lk6PlFnvTZwpYAuBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6201
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

