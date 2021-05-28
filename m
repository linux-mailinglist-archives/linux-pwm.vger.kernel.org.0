Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4A5394870
	for <lists+linux-pwm@lfdr.de>; Fri, 28 May 2021 23:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhE1VrN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 May 2021 17:47:13 -0400
Received: from mail-am6eur05on2052.outbound.protection.outlook.com ([40.107.22.52]:53252
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229481AbhE1VrN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 28 May 2021 17:47:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBwaPeSSA2u5Fee/k5kOcRDuF5nLZBeOP+9P4T82qxBRpxGD1cANw/bxHJy+BK0K4LVgHwiL/cH6cpW4uZpphAMEn+3+ZuIvz1zrNPfuI2vjoyFratGpr9cVzEjJwmFQOuz824V4PqKebaUpp6TRe7uAmuVvxfZt723WLqrE/jS82halZneC3HrhO7+PaRNsTZbkig5gp2o+ZCZ+08Mb1+TXDLhAKcFSG2efsIhejDG+WOh68lR6OoGrw1mFi3nGUa7O/7/3PNevIFWYYUMefGKNwjL69vDykHIFRIRsHz5SUdXAelHGBNkYr0kslwN7DU+Fpsrk5EXpoD7Y7+2bWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW7Jgjh3A26R5xhKACQ5t4ltivyXDaZIA8yLk5QjEjk=;
 b=YFvnWkXEiTUEIbbMvPQnmY8i/gqyU6PpKW/Wns+X0EzP9agYDE685FNMr26csjyN1oE75rG1Q6/uQEEl+9tqgp8+cIoO9jTaHDzimZToNO+lmhQbAYNLlDwHCBalF9W4rmtgW9zOFFkmODZs+/PLYXxVzOBvCeo/BHVaVUTAElKqqUVq+PvKdNA0Qo7onlkvRagrg6BNTskC99kPIn00CJ8EPJt6BZc6GPAeFqqdVACxVSRQdM8cYEdrDMUlN4BjpDLJoODndOZ+PoVeIq95HxLqet7XlF21G9i0AZp0wW2Y7dMeXbHWT4YtiR9R1+E/Gr2o904JsvlaWQ98UTINqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW7Jgjh3A26R5xhKACQ5t4ltivyXDaZIA8yLk5QjEjk=;
 b=wvztMXhbtOQGBAwYgMQhWX3Xo5bqqO98Ld70nhAj6Kj+V3oGFVrgcHTUqCjX3lvRViVuQv3bHUhsYDbv6YZw/HNsYQq35V/rW1y/xen/PWmJ6+0V7hIgkMow8GeSOsYosleLEkl/eDlqo0cUtvFPJ40LRma43JmKhtxpzfsMvZ4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB6700.eurprd03.prod.outlook.com (2603:10a6:10:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 21:45:35 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 21:45:35 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-arm-kernel@lists.infradead.org,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: pwm: Add Xilinx AXI Timer
Date:   Fri, 28 May 2021 17:45:20 -0400
Message-Id: <20210528214522.617435-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BLAPR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:208:32e::11) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by BLAPR03CA0126.namprd03.prod.outlook.com (2603:10b6:208:32e::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22 via Frontend Transport; Fri, 28 May 2021 21:45:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63ad04c7-2221-4b8a-abe2-08d92221eca3
X-MS-TrafficTypeDiagnostic: DBBPR03MB6700:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB6700F32F4471A4E9E3BE817296229@DBBPR03MB6700.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1eUvcmQrNEo4UqO7KWpfpDXtH6iMMzPqkUHGeiAA7dav5qlwXuw2Ytpny++77XMfX/m18nsXeoeDpojF5x/mmE8Rebjz1fdqsXFdD+sdCdQ+e55zRzMYOQtJ1q6AnhFMZ3+y4QPlliI/m5wzZy9vOeGHQvnI/jXxPNvaA4eIcgfjnhdeIETkqV/LnzYg8dUKh/NSmjlFTZgGnNMCr9Pl+Qdv0a9yvUPlJBeHQj6vDi+Wk5KaT1t9xlmrlH1+9zgLsR6QQZD4Soy3URmcZAtq0j/1aV0rBC1Flwpui6CX/mQhwARjBoJrSby7K9sHqzX7d1SAB6Bsj1Q0/c2kFH3VBQRiLTGWTv9e4/BevFImnoSe685r/epJljJFNiiWY0oNEem2gC+8jjAqljvF8Kf5VuyCWEoSnqgq8wCBAolTJF0a54JUwYQl6KtF8+Qocg5KB6UcBtPHf4CaMyyM+/K1sycTKXWLAWVfD4XTCcO/3jKNfeLIXqp8Pgez0dfECHBsk+q3agNtHDLCzUsa3UPoqwgqzZDq3ufvM/bYYywoaJEvFQFOuUAwqCgpaR2k3+qj/6OrBq2gJrTsp/HB1O0PQIoPpjC3aWqkHl7gclyM9qf20PWgKKw0Qm+N6ukl0tUb3F4j8oitl9fp6axEowbn8E36FMRCc7vE6yxHUYdwRUKVvQcd4qiOj9AKn9a7gZ71zIr9fTKpCD4Dxym6K8ctqzj5FFqKt2hePRHhQt7mOhp9KVTvtS5YUHOQNUc1/pGkUQFCNB14rNG+IIJti7qQzimUq50rLVqwgUMyr60xM1zfTaPlZhgpx4G1Yl3DvvN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39840400004)(346002)(366004)(478600001)(8676002)(6666004)(956004)(83380400001)(26005)(86362001)(966005)(16526019)(2906002)(8936002)(316002)(38100700002)(6506007)(54906003)(186003)(52116002)(36756003)(6486002)(44832011)(5660300002)(4326008)(6512007)(1076003)(66556008)(66476007)(38350700002)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?v+APSWPgZLbVcFVfbLMX0xQNG/gB8pWFNVOq06sds5A89IOQpTIz/P7nEIy1?=
 =?us-ascii?Q?i5v40UpJJ86YJofsEVBXPVEj8Li6cJuuWlXmcxq7u0T9FBIeZnxXBtGdzfUC?=
 =?us-ascii?Q?MfAGNY8BdAkF2j8iapr8pZ792RwBTYT33QDnqx0w39u5r1sqfXrF6c+rvIKW?=
 =?us-ascii?Q?TzB7e8jbLffhEDREhExnWjWGbCYgGP761vnMJJ6YlDnnz5QHwfHcAFN/nTx+?=
 =?us-ascii?Q?IhmU5NZPuQYiJjsVdT1ysCr7RuDLBUvo3tx1lLNvhzhCK/3TSpBONEmkdyUM?=
 =?us-ascii?Q?OCSL/fGXTdSUkI/Kow/HR60xOxIAhg3jXj5ezJzrAd27UJJxwq1TH17S0o/9?=
 =?us-ascii?Q?2XteYsP2ljVbzXwdFMtkLrYAxC6RGGVgTjmL/qtL+fdKOsUckTTy9EvinZ6+?=
 =?us-ascii?Q?fIivvF03Bx7UCGdO+wzoWiLUEOfjwkCWOm6EomLc8NKGSBFZlfeEcQuMP95V?=
 =?us-ascii?Q?VihWIk0cLYkOslSW3RdwvTn03JGMPKPKJebHiQeDno7jpI9rAWx9OfFNLQlO?=
 =?us-ascii?Q?PslxAR8Ux/jsqRqjGeOEJCFgUCEtBqU3WhDvht8gi+NEkOJxW5CvaUTU/5FH?=
 =?us-ascii?Q?4BnZ7Ec0gLjm/CThIHlfRpwo6WiR55r7z1+VfNULZpGReVNRQOIUvodU/M8w?=
 =?us-ascii?Q?YIBcE0Bg+KBMCgG2RPTcP1zHeXiWHFdUDIFpwYOw1DlvENrl2d+oZs+rXxxU?=
 =?us-ascii?Q?9eimhasuX78W3gtp8naRQAPlvneERvtMl22r+H229oosJDcnUlNLiO5E/sgW?=
 =?us-ascii?Q?sGDxeeHgiK91A8SjVJfLOU/cBiPgYz6FMSFVybY/3bymoM6563f37blojmm/?=
 =?us-ascii?Q?5ILLduhvmMLRbGfhezVW6QszD4Sww9RT7fCqhXnP35K+3+4poU1fR6dzISbJ?=
 =?us-ascii?Q?Qh3RuRyb29xDAyQgi1dbgSvyU52ARw2pnITx/owWghpYBLigebHfjq5VH77x?=
 =?us-ascii?Q?OpeWhPU6KD7qKyV5uvnvBgmqCvY6BevzJa3YCFd6vlcZDTXQmud1sJXpVOYf?=
 =?us-ascii?Q?xXSXTRXvRmdg2KZDgTUGVNWaaPXhseGX+OfH948s3/y7UYtBflrzJTrqdEV3?=
 =?us-ascii?Q?/FrEqjI67XI1/ADDpiXIMeAKVWap+RGAsTKh6l6wvDR1Gy97ogi6waNb6uOB?=
 =?us-ascii?Q?QVG8yg0LCKclUNMDwo5NW4amqp3+XcGAV4bHqQW4wnCAjgJILsXJsu64nNZL?=
 =?us-ascii?Q?FTj/0O0TtmUWRF3RvRsEDIvUt9J326/+hyPJElgEztXKHquuV1ZxwDXyQATZ?=
 =?us-ascii?Q?F/eMLMBYnOooi0xnbauWAV9qzsMB6JvRauHgd/tJiU6jd8HmJC9f9ekYUMlK?=
 =?us-ascii?Q?3dM5RY+oSS3TGQVHuFWiXLeC?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ad04c7-2221-4b8a-abe2-08d92221eca3
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 21:45:35.1169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaOFdVU28cjGhT7qKKL9g+1zcBtFKQ7xgTUQJN+3dy0/VeSd7O7rrEPjRJSi5gX9tCGeh6DqefoWRA642vr63Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6700
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

 .../bindings/pwm/xlnx,axi-timer.yaml          | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml

diff --git a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
new file mode 100644
index 000000000000..48a280f96e63
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
@@ -0,0 +1,85 @@
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
+         - const: xlnx,axi-timer-2.0
+         - const: xlnx,xps-timer-1.00.a
+      - items:
+         - const: xlnx,xps-timer-1.00.a
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
+    axi_timer_0: timer@800e0000 {
+        #pwm-cells = <0>;
+        clock-names = "s_axi_aclk";
+        clocks = <&zynqmp_clk 71>;
+        compatible = "xlnx,axi-timer-2.0", "xlnx,xps-timer-1.00.a";
+        reg = <0x800e0000 0x10000>;
+        xlnx,count-width = <0x20>;
+        xlnx,one-timer-only = <0x0>;
+    };
-- 
2.25.1

