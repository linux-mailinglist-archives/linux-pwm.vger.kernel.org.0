Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB6FA130B01
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jan 2020 01:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgAFAsF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 5 Jan 2020 19:48:05 -0500
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:37536
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbgAFAsF (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 5 Jan 2020 19:48:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SICotShTzgOVVz1o2DNePI4mJF/X0Z9+xUDikkCoXrf28Estqdm01/2eIJL3H9ny4HFgFg9rTBgDRsVgnuTCGuJLf0ZhdXY0SZbeLrKRgF/cna01d7UKEYB70bqqlWvXLiDxRjTDgiUS8W2ibwqWPBv0P7wiq8wWBVwo6VzsUyYx7quN0tHwS1w2tl61iFXhdpqdc304Z9UkhJLdOxFaFGWnmgv/7HcNnKH3x0RpqOoumHoOeACNROgV3L5b9+hSUO3Wq13aKBl2gqB+DdYSu3veFqFt67bGj1i6PtFxktrjaq+7vYjdu/QTJElE6JLxTj1ZBMU0e4zcaYWCvoiG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zQC0VT4l86d5QngFn0BjHs17Cgbwru8u0K68dAOLnM=;
 b=DOgEB5f9uhdavQKAQxFTRUCKCwKZe3z5ovzsz3z0x17nzjcQkTLtCzA+or4oWq6SPXzzRi4Y8527SVbNsipPatHwWHxbACylllIYxKJ8RFLe3D7yh+3SGH0sil6G46k1e4V7Mm0eC4xzEzuwL6GuOvur6AzYLhWejocg+HP/4Uv+w6i3fMPwfD2wEz5ji2+XPtSGzRdcCRDXpQfCCqzVZ9s6H5U3jMggnWxllUO3HQrYvw81ckKnTl3HSTNPoawInIWGxS/3tvKmVGCT5Z3CJ14eGOBJspFczKkoOr15icoh8etR1NMNWRLkfpU1cUSwUPcih6+PHvRE5NdkVHxQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zQC0VT4l86d5QngFn0BjHs17Cgbwru8u0K68dAOLnM=;
 b=pQhm2jnZdYuXyBwcG4u2VCC03LYqEAYff3FbyTKFgd49w4Ta8X3Iq8BECl0HR/Ph9im/fxXEy9jcWnrH7TiJlZeQUZNQg5khp/iarX16AWqPjmJG4fcJDnqrkGSh5tByNiit7yQXjKHUoqCG0doNOAdoeOERl8Ou/FbIc1mRIcs=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB4175.namprd08.prod.outlook.com (52.135.69.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 00:48:00 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 00:48:00 +0000
Received: from localhost.localdomain (136.49.227.119) by SN4PR0701CA0020.namprd07.prod.outlook.com (2603:10b6:803:28::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2602.13 via Frontend Transport; Mon, 6 Jan 2020 00:47:59 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH v3 1/7] dt-bindings: Add bindings for Azoteq
 IQS620A/621/622/624/625
Thread-Topic: [PATCH v3 1/7] dt-bindings: Add bindings for Azoteq
 IQS620A/621/622/624/625
Thread-Index: AQHVxCrx9mZdEz3euEisil4Ehb2Abw==
Date:   Mon, 6 Jan 2020 00:48:00 +0000
Message-ID: <1578271620-2159-2-git-send-email-jeff@labundy.com>
References: <1578271620-2159-1-git-send-email-jeff@labundy.com>
In-Reply-To: <1578271620-2159-1-git-send-email-jeff@labundy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0701CA0020.namprd07.prod.outlook.com
 (2603:10b6:803:28::30) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1f9e005-d2c1-4c74-8dcc-08d792421416
x-ms-traffictypediagnostic: SN6PR08MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR08MB417531FEF559DE007B475136D33C0@SN6PR08MB4175.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39830400003)(136003)(376002)(346002)(34096005)(199004)(189003)(36756003)(107886003)(2616005)(956004)(316002)(69590400006)(5660300002)(86362001)(6486002)(508600001)(2906002)(4326008)(966005)(6506007)(81166006)(110136005)(6512007)(54906003)(16526019)(26005)(8676002)(186003)(7416002)(8936002)(66476007)(71200400001)(6666004)(52116002)(66946007)(30864003)(66446008)(66556008)(64756008)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4175;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /g0AGbqWGWuFCKWonsHKDCEOdVda28NEHO6PwEmiyy8DZkmI/8EjGlY12EZdE5CMMpF8HJRFLIRpArlM3quElePGVR46Woo9aRqTCOyNqG5T2Yn0WNIYjRUqQUXf1WPSHuaKU8eUbDG0uoDXTcEpssH9wc1t/xeIGGYtQ35TIw/1TfIqswi9A/aezB2XyL0guy2TpBC/awDFAW0jSC33JgwZh2jR5B68pilNimiyh+Ai+v1/IMPYAN9s0rXHJBDSB5Uq75wOIaKMH/XvdUC+nlm9XsqW4yvjB8+Tgm2lGZUrPZVO5DQmo7b1zomrFjKATOPL6GN9NSPpq9/HyMhz5hWT1znVgFsq4prVE77wSuuUS56vdnpLxhOPCZx5GZKN4BOM68xi1Awi2kwY13BebdAW9k233EgDXf/eJMDhdk/CSMmBIAONCtH+GXqjIrNjPIH0siLhmDfv1KepFpqX3wLVbHLU2ViZQWEf8wc6Ym6rxMfAsJXSFR1FQPckg0PcngEJEGBOFSajuioHLXfZ8hwtO3mMzWuuK6zprIALXJM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f9e005-d2c1-4c74-8dcc-08d792421416
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 00:48:00.1002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Atw29+0CB5RoKPy+FTTwkzIOfpUVTnY0NLjrOmlpXtw/tHhZ3tGCmyeVjQd9WE3/0AI2wLjVS4D7HyODlwnJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4175
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
Changes in v3:
  - Specified 'additionalProperties: false' within the parent MFD node and =
all
    child nodes ("keys", "hall-switch-north/south" and "pwm")
  - Defined the "hall-switch-north/south" child nodes unconditionally and t=
hen
    inverted the subsequent if/then to filter them from devices for which t=
hat
    functionality is unavailable
  - Added Reviewed-by trailer

Changes in v2:
  - Removed "prox" child node and moved "keys" and "pwm" child nodes to the=
ir
    own bindings
  - Replaced linux,fw-file property with more common firmware-name property
  - Converted all bindings to YAML

 .../devicetree/bindings/input/iqs62x-keys.yaml     | 132 +++++++++++++++
 Documentation/devicetree/bindings/mfd/iqs62x.yaml  | 179 +++++++++++++++++=
++++
 .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |  32 ++++
 3 files changed, 343 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/iqs62x-keys.yam=
l
 create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml

diff --git a/Documentation/devicetree/bindings/input/iqs62x-keys.yaml b/Doc=
umentation/devicetree/bindings/input/iqs62x-keys.yaml
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
+  The Azoteq IQS620A, IQS621, IQS622, IQS624 and IQS625 multi-function sen=
sors
+  feature a variety of self-capacitive, mutual-inductive and Hall-effect s=
ens-
+  ing capabilities that can facilitate a variety of contactless key and sw=
itch
+  applications.
+
+  These functions are collectively represented by a "keys" child node from=
 the
+  parent MFD driver. See Documentation/devicetree/bindings/mfd/iqs62x.yaml=
 for
+  further details and examples. Sensor hardware configuration (self-capaci=
tive
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
+      Specifies the numeric keycodes associated with each available touch =
or
+      proximity event according to the following table. An 'x' indicates t=
he
+      event is supported for a given device. Specify 0 for unused events.
+
+      --------------------------------------------------------------------=
-----
+      | #  | Event              | IQS620A | IQS621 | IQS622 | IQS624 | IQS=
625 |
+      --------------------------------------------------------------------=
-----
+      | 0  | CH0 Touch          |    x    |    x   |    x   |    x   |    =
x   |
+      |    | Antenna 1 Touch*   |    x    |        |        |        |    =
    |
+      --------------------------------------------------------------------=
-----
+      | 1  | CH0 Proximity      |    x    |    x   |    x   |    x   |    =
x   |
+      |    | Antenna 1 Prox.*   |    x    |        |        |        |    =
    |
+      --------------------------------------------------------------------=
-----
+      | 2  | CH1 Touch          |    x    |    x   |    x   |    x   |    =
x   |
+      |    | Ant. 1 Deep Touch* |    x    |        |        |        |    =
    |
+      --------------------------------------------------------------------=
-----
+      | 3  | CH1 Proximity      |    x    |    x   |    x   |    x   |    =
x   |
+      --------------------------------------------------------------------=
-----
+      | 4  | CH2 Touch          |    x    |        |        |        |    =
    |
+      --------------------------------------------------------------------=
-----
+      | 5  | CH2 Proximity      |    x    |        |        |        |    =
    |
+      |    | Antenna 2 Prox.*   |    x    |        |        |        |    =
    |
+      --------------------------------------------------------------------=
-----
+      | 6  | Metal (+) Touch**  |    x    |    x   |        |        |    =
    |
+      |    | Ant. 2 Deep Touch* |    x    |        |        |        |    =
    |
+      --------------------------------------------------------------------=
-----
+      | 7  | Metal (+) Prox.**  |    x    |    x   |        |        |    =
    |
+      |    | Antenna 2 Touch*   |    x    |        |        |        |    =
    |
+      --------------------------------------------------------------------=
-----
+      | 8  | Metal (-) Touch**  |    x    |    x   |        |        |    =
    |
+      --------------------------------------------------------------------=
-----
+      | 9  | Metal (-) Prox.**  |    x    |    x   |        |        |    =
    |
+      --------------------------------------------------------------------=
-----
+      | 10 | SAR Active***      |    x    |        |    x   |        |    =
    |
+      --------------------------------------------------------------------=
-----
+      | 11 | SAR Quick Rel.***  |    x    |        |    x   |        |    =
    |
+      --------------------------------------------------------------------=
-----
+      | 12 | SAR Movement***    |    x    |        |    x   |        |    =
    |
+      --------------------------------------------------------------------=
-----
+      | 13 | SAR Filter Halt*** |    x    |        |    x   |        |    =
    |
+      --------------------------------------------------------------------=
-----
+      | 14 | Wheel Up           |         |        |        |    x   |    =
    |
+      --------------------------------------------------------------------=
-----
+      | 15 | Wheel Down         |         |        |        |    x   |    =
    |
+      --------------------------------------------------------------------=
-----
+      *   Two-channel SAR. Replaces CH0-2 plus metal touch and proximity e=
vents
+          if enabled via firmware.
+      **  "+" and "-" refer to the polarity of a channel's delta (LTA - co=
unts),
+          where "LTA" is defined as the channel's long-term average.
+      *** One-channel SAR. Replaces CH0-2 touch and proximity events if en=
abled
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
diff --git a/Documentation/devicetree/bindings/mfd/iqs62x.yaml b/Documentat=
ion/devicetree/bindings/mfd/iqs62x.yaml
new file mode 100644
index 0000000..46b7272
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
+  The Azoteq IQS620A, IQS621, IQS622, IQS624 and IQS625 multi-function sen=
sors
+  integrate multiple sensing technologies in a single package.
+
+  Link to data sheets: https://www.azoteq.com/
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
+      Specifies the name of the calibration and configuration file selecte=
d by
+      the driver. If this property is omitted, the name is chosen based on=
 the
+      device name with ".bin" as the extension (e.g. iqs620a.bin for IQS62=
0A).
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
+     * Dual capacitive buttons with additional "air button," unipolar lid
+     * switch and panel-mounted LED.
+     */
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            iqs620a@44 {
+                    compatible =3D "azoteq,iqs620a";
+                    reg =3D <0x44>;
+                    interrupt-parent =3D <&gpio>;
+                    interrupts =3D <17 IRQ_TYPE_LEVEL_LOW>;
+
+                    keys {
+                            compatible =3D "azoteq,iqs620a-keys";
+
+                            linux,keycodes =3D <KEY_SELECT>,
+                                             <KEY_MENU>,
+                                             <KEY_OK>,
+                                             <KEY_MENU>;
+
+                            hall-switch-south {
+                                    linux,code =3D <SW_LID>;
+                                    azoteq,use-prox;
+                            };
+                    };
+
+                    iqs620a_pwm: pwm {
+                            compatible =3D "azoteq,iqs620a-pwm";
+                            #pwm-cells =3D <2>;
+                    };
+            };
+    };
+
+    pwmleds {
+            compatible =3D "pwm-leds";
+
+            panel {
+                    pwms =3D <&iqs620a_pwm 0 1000000>;
+                    max-brightness =3D <255>;
+            };
+    };
+
+  - |
+    /* Single inductive button with bipolar dock/tablet-mode switch. */
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            iqs620a@44 {
+                    compatible =3D "azoteq,iqs620a";
+                    reg =3D <0x44>;
+                    interrupt-parent =3D <&gpio>;
+                    interrupts =3D <17 IRQ_TYPE_LEVEL_LOW>;
+
+                    firmware-name =3D "iqs620a_coil.bin";
+
+                    keys {
+                            compatible =3D "azoteq,iqs620a-keys";
+
+                            linux,keycodes =3D <0>,
+                                             <0>,
+                                             <0>,
+                                             <0>,
+                                             <0>,
+                                             <0>,
+                                             <KEY_MUTE>;
+
+                            hall-switch-north {
+                                    linux,code =3D <SW_DOCK>;
+                            };
+
+                            hall-switch-south {
+                                    linux,code =3D <SW_TABLET_MODE>;
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
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            iqs624@44 {
+                    compatible =3D "azoteq,iqs624";
+                    reg =3D <0x44>;
+                    interrupt-parent =3D <&gpio>;
+                    interrupts =3D <17 IRQ_TYPE_LEVEL_LOW>;
+
+                    keys {
+                            compatible =3D "azoteq,iqs624-keys";
+
+                            linux,keycodes =3D <BTN_0>,
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
diff --git a/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml b/Docum=
entation/devicetree/bindings/pwm/iqs620a-pwm.yaml
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

