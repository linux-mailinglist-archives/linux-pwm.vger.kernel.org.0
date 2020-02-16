Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88BC716073A
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2020 00:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgBPXcn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 16 Feb 2020 18:32:43 -0500
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com ([40.107.243.59]:23617
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727772AbgBPXcl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 16 Feb 2020 18:32:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZLa+bLg2ZMBgtgHpQCFQmlMiMNgt+Ex0+ZMN7bB2ly1C3f3rs6zYBPec4VGhceOGf2KUxYRz2c4SQ7+54pDzj11jzeWaiIhtYKF0utL/cKabUe0Ixu365rj7e9WEsfpDhOFI2Sj5/3Cu6Li/nZq4k2rcGxSHBWckU0KfBMaER13T9R0tHGGq3hUe5DVsXGlOD7fGsA1GM/+M6wS4LOeIt/ITLBEFD2I6jhEJxwbzKpd5XhR+jSIpg0IPJ2EOacP2xlNbmHbtRd5hTzGuPV+QLVLtSxEAhNb10MffhfN8+8DBlAGcureiG1Ro3lw6MoOIZZ0MVPC/QcE13ak4wi7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mSzQIvlOX0HEucYtfZCom9OhFCJPDdav7rj7VFWXqE=;
 b=BEOzX+D7E+3eoblVtpA99rRCsE5BbhMQoSYFQ+ohhMbRnLGw+X2CjmMhWdFsbJr9vzAbjLMjII2+xe+WMvFIWt7w4Qmi+58N6b2bHTMW8T8TL9QqAaxzJVUZqYESVX79cRyT2RhaCLcA7EDN2/wv1BdzGk5peimNQiZwSqcZMOxKBZ0HGovOLo/wsxWnq+0ENHfF5qKKuw5ZxFDWiV20VZuqIHTf+g1EVTEZfj4VWLwLNxCm8f8d1NvrbTJOErUqCTwTShGapHLI/cSO1nUAl/W2wyUJJ7TVg23zioLJ7yWm9eOda58Geg0KbOPsiqxvjpKax9cFwaZaJXicxyF/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mSzQIvlOX0HEucYtfZCom9OhFCJPDdav7rj7VFWXqE=;
 b=qjq4butPx0stmheG0Tdjfi+DQvEJ8MwpsH9Nnlw42DSf2/RSGzPfovQPGQiB+fgwFUaHAkydnizP3Socod8BIiNMJIdMAUP8hBajcnyYn7s/KE2jsl6qoePVxScnuKozFbeN/kYRuc3myYMfkqkkGUeSYdBbAMRRIerFB9/8iOY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB5406.namprd08.prod.outlook.com (52.135.117.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Sun, 16 Feb 2020 23:32:38 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::2cd0:e164:fe88:3945]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::2cd0:e164:fe88:3945%4]) with mapi id 15.20.2729.025; Sun, 16 Feb 2020
 23:32:38 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v5 1/7] dt-bindings: Add bindings for Azoteq IQS620A/621/622/624/625
Date:   Sun, 16 Feb 2020 17:32:05 -0600
Message-Id: <1581895931-6056-2-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581895931-6056-1-git-send-email-jeff@labundy.com>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0142.namprd05.prod.outlook.com
 (2603:10b6:803:2c::20) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
MIME-Version: 1.0
Received: from localhost.localdomain (136.49.227.119) by SN4PR0501CA0142.namprd05.prod.outlook.com (2603:10b6:803:2c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2750.9 via Frontend Transport; Sun, 16 Feb 2020 23:32:38 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [136.49.227.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bdfcfdd-4966-4fad-9ec9-08d7b3388293
X-MS-TrafficTypeDiagnostic: SN6PR08MB5406:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR08MB5406DF7D98B3291B7F9FCC66D3170@SN6PR08MB5406.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03152A99FF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(39830400003)(396003)(376002)(199004)(189003)(8676002)(107886003)(8936002)(4326008)(7416002)(69590400006)(956004)(66556008)(2616005)(81156014)(81166006)(16526019)(26005)(5660300002)(6506007)(186003)(66946007)(6666004)(66476007)(316002)(6486002)(36756003)(52116002)(508600001)(966005)(6512007)(2906002)(86362001)(30864003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB5406;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9zh8SIIRwNEO6J8nCQL9CZ0eDZIS6FTXGf9OipE0Pwai0greq2hy2TLYHwvsvvr0o8DxBR2c7c80G3J7NUjKqQi9wDpCauTktbcuxfCrWrYAAzkQzlSpQ1S9GIRsfexZq+JlRD0b1Jw2Xl1oJdTiwADgXwqRh/YUCpSux6sldKW+B3+wNxkSQKYEr64RLF6b3/cknEv9liAX0AmH+RJU7lL9tmaOXAbLUsNCHTUuLpMpDV+dPQWnBs2DKlr/P5EweD2zdk+3lkJCEcV6p4+3CQgr1Z+hnCUYlAst85q5jVLJOHQDEtQuzC8dnYdTadxFCqjK/suoCXLtkPdJnJgNcmv7jAkGjuN7Zs++bIWXnsZecW8fi9CQWORyraRJib1Xto+zO0viv4diVg+OzC9FFqGLApFe/WpIfKla+DUpmxIIWp1e3P56C5JL1a4DjP6JXA0p0s6Z1YqicU0gX6acYeVt5l+Ka84yGLl4mTVvuGCa+cUxGv7s7soawT0NNMsCTMopTk3dhJwpvIoib7xvpRGHgI39PxpDLpx3UXjnodm2oDdDLIz19KPqwyrmY10mM71w/ffPsH5kLaCBVbWWauj4UXHgFpR9f5FF7gRNA4=
X-MS-Exchange-AntiSpam-MessageData: pJst6+hTKvyYy+DD1d67gd4pZspMlj0866zfNcbAfGrFf6G0MBgqiWsgkKDqo158bZE2XQqfT+iq0UugX9uB5N6KWuxVaRy0KNs5Tu2qtvw9ZXdHWNntDnaJGLHbz+qqjQImI9+Ym9Gw7usfQ0Js2A==
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdfcfdd-4966-4fad-9ec9-08d7b3388293
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2020 23:32:38.9286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ij97Psw/SYMqHtqJVMngdXSOa4zwE6DWLBGsJFEs6fzndXCFv3fYPxB51fA/otRSaBARxT/xpDGPAiatF2E+uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5406
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds device tree bindings for the Azoteq IQS620A, IQS621,
IQS622, IQS624 and IQS625 multi-function sensors.

A total of three bindings are presented (one MFD and two child nodes);
they are submitted as a single patch because the child node bindings
have no meaning in the absence of the MFD binding.

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v5:
  - Corrected spelling of "data sheets" to "datasheets"
  - Replaced words "additional air button" with "proximity-activated function"
    in comment above first example

Changes in v4:
  - None

Changes in v3:
  - Specified 'additionalProperties: false' within the parent MFD node and all
    child nodes ("keys", "hall-switch-north/south" and "pwm")
  - Defined the "hall-switch-north/south" child nodes unconditionally and then
    inverted the subsequent if/then to filter them from devices for which that
    functionality is unavailable
  - Added Reviewed-by trailer

Changes in v2:
  - Removed "prox" child node and moved "keys" and "pwm" child nodes to their
    own bindings
  - Replaced linux,fw-file property with more common firmware-name property
  - Converted all bindings to YAML

 .../devicetree/bindings/input/iqs62x-keys.yaml     | 132 +++++++++++++++
 Documentation/devicetree/bindings/mfd/iqs62x.yaml  | 179 +++++++++++++++++++++
 .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |  32 ++++
 3 files changed, 343 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/iqs62x-keys.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml

diff --git a/Documentation/devicetree/bindings/input/iqs62x-keys.yaml b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
new file mode 100644
index 0000000..5625c22
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/iqs62x-keys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Azoteq IQS620A/621/622/624/625 Keys and Switches
+
+maintainers:
+  - Jeff LaBundy <jeff@labundy.com>
+
+description: |
+  The Azoteq IQS620A, IQS621, IQS622, IQS624 and IQS625 multi-function sensors
+  feature a variety of self-capacitive, mutual-inductive and Hall-effect sens-
+  ing capabilities that can facilitate a variety of contactless key and switch
+  applications.
+
+  These functions are collectively represented by a "keys" child node from the
+  parent MFD driver. See Documentation/devicetree/bindings/mfd/iqs62x.yaml for
+  further details and examples. Sensor hardware configuration (self-capacitive
+  vs. mutual-inductive, etc.) is selected based on the device's firmware.
+
+properties:
+  compatible:
+    enum:
+      - azoteq,iqs620a-keys
+      - azoteq,iqs621-keys
+      - azoteq,iqs622-keys
+      - azoteq,iqs624-keys
+      - azoteq,iqs625-keys
+
+  linux,keycodes:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - minItems: 1
+        maxItems: 16
+    description: |
+      Specifies the numeric keycodes associated with each available touch or
+      proximity event according to the following table. An 'x' indicates the
+      event is supported for a given device. Specify 0 for unused events.
+
+      -------------------------------------------------------------------------
+      | #  | Event              | IQS620A | IQS621 | IQS622 | IQS624 | IQS625 |
+      -------------------------------------------------------------------------
+      | 0  | CH0 Touch          |    x    |    x   |    x   |    x   |    x   |
+      |    | Antenna 1 Touch*   |    x    |        |        |        |        |
+      -------------------------------------------------------------------------
+      | 1  | CH0 Proximity      |    x    |    x   |    x   |    x   |    x   |
+      |    | Antenna 1 Prox.*   |    x    |        |        |        |        |
+      -------------------------------------------------------------------------
+      | 2  | CH1 Touch          |    x    |    x   |    x   |    x   |    x   |
+      |    | Ant. 1 Deep Touch* |    x    |        |        |        |        |
+      -------------------------------------------------------------------------
+      | 3  | CH1 Proximity      |    x    |    x   |    x   |    x   |    x   |
+      -------------------------------------------------------------------------
+      | 4  | CH2 Touch          |    x    |        |        |        |        |
+      -------------------------------------------------------------------------
+      | 5  | CH2 Proximity      |    x    |        |        |        |        |
+      |    | Antenna 2 Prox.*   |    x    |        |        |        |        |
+      -------------------------------------------------------------------------
+      | 6  | Metal (+) Touch**  |    x    |    x   |        |        |        |
+      |    | Ant. 2 Deep Touch* |    x    |        |        |        |        |
+      -------------------------------------------------------------------------
+      | 7  | Metal (+) Prox.**  |    x    |    x   |        |        |        |
+      |    | Antenna 2 Touch*   |    x    |        |        |        |        |
+      -------------------------------------------------------------------------
+      | 8  | Metal (-) Touch**  |    x    |    x   |        |        |        |
+      -------------------------------------------------------------------------
+      | 9  | Metal (-) Prox.**  |    x    |    x   |        |        |        |
+      -------------------------------------------------------------------------
+      | 10 | SAR Active***      |    x    |        |    x   |        |        |
+      -------------------------------------------------------------------------
+      | 11 | SAR Quick Rel.***  |    x    |        |    x   |        |        |
+      -------------------------------------------------------------------------
+      | 12 | SAR Movement***    |    x    |        |    x   |        |        |
+      -------------------------------------------------------------------------
+      | 13 | SAR Filter Halt*** |    x    |        |    x   |        |        |
+      -------------------------------------------------------------------------
+      | 14 | Wheel Up           |         |        |        |    x   |        |
+      -------------------------------------------------------------------------
+      | 15 | Wheel Down         |         |        |        |    x   |        |
+      -------------------------------------------------------------------------
+      *   Two-channel SAR. Replaces CH0-2 plus metal touch and proximity events
+          if enabled via firmware.
+      **  "+" and "-" refer to the polarity of a channel's delta (LTA - counts),
+          where "LTA" is defined as the channel's long-term average.
+      *** One-channel SAR. Replaces CH0-2 touch and proximity events if enabled
+          via firmware.
+
+patternProperties:
+  "^hall-switch-(north|south)$":
+    type: object
+    description:
+      Represents north/south-field Hall-effect sensor touch or proximity
+      events. Note that north/south-field orientation is reversed on the
+      IQS620AXzCSR device due to its flip-chip package.
+
+    properties:
+      linux,code:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Numeric switch code associated with the event.
+
+      azoteq,use-prox:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          If present, specifies that Hall-effect sensor reporting should
+          use the device's wide-range proximity threshold instead of its
+          close-range touch threshold (default).
+
+    required:
+      - linux,code
+
+    additionalProperties: false
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - azoteq,iqs624-keys
+          - azoteq,iqs625-keys
+then:
+  patternProperties:
+    "^hall-switch-(north|south)$": false
+
+required:
+  - compatible
+  - linux,keycodes
+
+additionalProperties: false
+
+...
diff --git a/Documentation/devicetree/bindings/mfd/iqs62x.yaml b/Documentation/devicetree/bindings/mfd/iqs62x.yaml
new file mode 100644
index 0000000..541b06d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/iqs62x.yaml
@@ -0,0 +1,179 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/iqs62x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Azoteq IQS620A/621/622/624/625 Multi-Function Sensors
+
+maintainers:
+  - Jeff LaBundy <jeff@labundy.com>
+
+description: |
+  The Azoteq IQS620A, IQS621, IQS622, IQS624 and IQS625 multi-function sensors
+  integrate multiple sensing technologies in a single package.
+
+  Link to datasheets: https://www.azoteq.com/
+
+properties:
+  compatible:
+    enum:
+      - azoteq,iqs620a
+      - azoteq,iqs621
+      - azoteq,iqs622
+      - azoteq,iqs624
+      - azoteq,iqs625
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Specifies the name of the calibration and configuration file selected by
+      the driver. If this property is omitted, the name is chosen based on the
+      device name with ".bin" as the extension (e.g. iqs620a.bin for IQS620A).
+
+  keys:
+    $ref: ../input/iqs62x-keys.yaml
+
+  pwm:
+    $ref: ../pwm/iqs620a-pwm.yaml
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    /*
+     * Dual capacitive buttons with proximity-activated function, unipolar lid
+     * switch and panel-mounted LED.
+     */
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            iqs620a@44 {
+                    compatible = "azoteq,iqs620a";
+                    reg = <0x44>;
+                    interrupt-parent = <&gpio>;
+                    interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+
+                    keys {
+                            compatible = "azoteq,iqs620a-keys";
+
+                            linux,keycodes = <KEY_SELECT>,
+                                             <KEY_MENU>,
+                                             <KEY_OK>,
+                                             <KEY_MENU>;
+
+                            hall-switch-south {
+                                    linux,code = <SW_LID>;
+                                    azoteq,use-prox;
+                            };
+                    };
+
+                    iqs620a_pwm: pwm {
+                            compatible = "azoteq,iqs620a-pwm";
+                            #pwm-cells = <2>;
+                    };
+            };
+    };
+
+    pwmleds {
+            compatible = "pwm-leds";
+
+            panel {
+                    pwms = <&iqs620a_pwm 0 1000000>;
+                    max-brightness = <255>;
+            };
+    };
+
+  - |
+    /* Single inductive button with bipolar dock/tablet-mode switch. */
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            iqs620a@44 {
+                    compatible = "azoteq,iqs620a";
+                    reg = <0x44>;
+                    interrupt-parent = <&gpio>;
+                    interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+
+                    firmware-name = "iqs620a_coil.bin";
+
+                    keys {
+                            compatible = "azoteq,iqs620a-keys";
+
+                            linux,keycodes = <0>,
+                                             <0>,
+                                             <0>,
+                                             <0>,
+                                             <0>,
+                                             <0>,
+                                             <KEY_MUTE>;
+
+                            hall-switch-north {
+                                    linux,code = <SW_DOCK>;
+                            };
+
+                            hall-switch-south {
+                                    linux,code = <SW_TABLET_MODE>;
+                            };
+                    };
+            };
+    };
+
+  - |
+    /* Dual capacitive buttons with volume knob. */
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            iqs624@44 {
+                    compatible = "azoteq,iqs624";
+                    reg = <0x44>;
+                    interrupt-parent = <&gpio>;
+                    interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+
+                    keys {
+                            compatible = "azoteq,iqs624-keys";
+
+                            linux,keycodes = <BTN_0>,
+                                             <0>,
+                                             <BTN_1>,
+                                             <0>,
+                                             <0>,
+                                             <0>,
+                                             <0>,
+                                             <0>,
+                                             <0>,
+                                             <0>,
+                                             <0>,
+                                             <0>,
+                                             <0>,
+                                             <0>,
+                                             <KEY_VOLUMEUP>,
+                                             <KEY_VOLUMEDOWN>;
+                    };
+            };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml b/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
new file mode 100644
index 0000000..1d7c27b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/iqs620a-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Azoteq IQS620A PWM Generator
+
+maintainers:
+  - Jeff LaBundy <jeff@labundy.com>
+
+description: |
+  The Azoteq IQS620A multi-function sensor generates a fixed-frequency PWM
+  output represented by a "pwm" child node from the parent MFD driver. See
+  Documentation/devicetree/bindings/mfd/iqs62x.yaml for further details as
+  well as an example.
+
+properties:
+  compatible:
+    enum:
+      - azoteq,iqs620a-pwm
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - "#pwm-cells"
+
+additionalProperties: false
+
+...
--
2.7.4

