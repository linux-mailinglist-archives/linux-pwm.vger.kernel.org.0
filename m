Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A13F8116464
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2019 01:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLIAin (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 8 Dec 2019 19:38:43 -0500
Received: from mail-mw2nam12on2065.outbound.protection.outlook.com ([40.107.244.65]:11831
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbfLIAin (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 8 Dec 2019 19:38:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N621hrktsC90BHws7QSdCQbMqgMvoRhBTqkDTpJnzmIAO0YwlHsjsJGqEpUkpfs2I7NisHvVCnFjL0kqRJpQbtMbOJ3CZQcARlYhSDv9p8Jm9JAIuPTPSipXBwTOX8PGgObEUZOLLdjxNWERmYoVQepJOxcfRdVVA3Um4vvRWzDcs4ghbbmA4gvwA1C6/2nvNKSqq3Rwe/sUxI5lA9tW5SP9zAgbmecyT4/fYoFXaZT6htvYzIYe2ot9aABE81j8LYbQForgKAJEPacHL08WPKsbKsSwMYEN1XtDb3t0qTAK22plZCHrhE6Eg1eKdeg3cAQw4H81ygs/oV5bvNgi7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJu2GRi4HrHCo4OB/bnX69S3TccINdZu0YRb64+UvjE=;
 b=YZ0+Qu5Ar7Nf036El7sdUKYXSlgvUct356QN243ZPfsiEd9uijG6PMbnVgIBSkGH6mFXEH8jMmPQTIoywDZB6f9MEpPT9qksmOWsCcUpR/pX0F9KIlVfLnwwbQyXLt174OMGwCQ15ZRxmKM0+flA5AnqpQUwd+ribvml/yW4MKlFIVoA2chGt5q112QGXXN55iGJzKmNYW2CgzkI5zDQIfZsJwQFumQKlDaos8EaWAazt7GvkHqDhSRpq27LCyCSMwkKlvxEVdmPM/7oefQgc5IUZxjGl4k1VWnEcIEXwrNh6nYuy0w6S7Ypt44xb0brf8ZaiWx0Xu2UvauSacDl1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJu2GRi4HrHCo4OB/bnX69S3TccINdZu0YRb64+UvjE=;
 b=nPrLbBrmPAfSkVvYlY0OOTe5Nn4ONL4hh1E31SJD7grNx4d4bGrDMdFcQg4BJljdKjEOMQsPVtyUMAYgLFHsbu99J41VCA+UdRanMIM/J/cpGzqPdP7iBz1x5DD3yzOpWaQw3bN2EtDsJgOq6g3D0rxHn3n/wH8nRBEpfXvcedY=
Received: from BN7PR08MB5042.namprd08.prod.outlook.com (20.176.177.14) by
 BN7PR08MB4402.namprd08.prod.outlook.com (52.132.223.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Mon, 9 Dec 2019 00:38:32 +0000
Received: from BN7PR08MB5042.namprd08.prod.outlook.com
 ([fe80::48de:9418:73ef:d7c1]) by BN7PR08MB5042.namprd08.prod.outlook.com
 ([fe80::48de:9418:73ef:d7c1%6]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 00:38:32 +0000
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
Subject: [PATCH v2 1/7] dt-bindings: Add bindings for Azoteq
 IQS620A/621/622/624/625
Thread-Topic: [PATCH v2 1/7] dt-bindings: Add bindings for Azoteq
 IQS620A/621/622/624/625
Thread-Index: AQHVrij7SDxpuO5/BEuAwvUFNi/Xqg==
Date:   Mon, 9 Dec 2019 00:38:32 +0000
Message-ID: <1575851866-18919-2-git-send-email-jeff@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
In-Reply-To: <1575851866-18919-1-git-send-email-jeff@labundy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0082.namprd12.prod.outlook.com
 (2603:10b6:802:21::17) To BN7PR08MB5042.namprd08.prod.outlook.com
 (2603:10b6:408:2c::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1be61e4-8b90-4c65-3440-08d77c401e29
x-ms-traffictypediagnostic: BN7PR08MB4402:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR08MB4402B6FE816A000FBC739EDED3580@BN7PR08MB4402.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(34096005)(366004)(136003)(396003)(346002)(39830400003)(199004)(189003)(99286004)(76176011)(71200400001)(52116002)(71190400001)(54906003)(4326008)(2906002)(6512007)(38610400001)(66556008)(66476007)(6486002)(66946007)(586005)(64756008)(66446008)(110136005)(107886003)(36756003)(966005)(8936002)(102836004)(50226002)(30864003)(305945005)(2616005)(7416002)(5660300002)(6506007)(81166006)(81156014)(498600001)(26005)(86362001)(186003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR08MB4402;H:BN7PR08MB5042.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BLMNwunzV0zvB8EZ46e4KAv3Xh4EvosltCgm3OupnoTkfGpUJ8tfhjGxT2aEOiaaB3auF+SBivUGF6IRQTWWsyp6806+wbPY5Y9qAjUU7Iv+bXyXjg2bRruoifhBj/hlZJIym8vm3csKbWK5iZxKyH/pKtbJ+pvEY+sUWFdLpFmOSSJNKpDvOaIUOC/2ExFD/MnDVhRtXEs/wBj+RKQXuNu3HOIx/Y0FalKLaVWfOKoRcmqUZwJebbvfIg95YxgRsU6IkV5Rj5pf/Io0vQp4hKb1LchtIQyWhD3VRdwPJtCvZe4N4vOUXG4DEy+Bl8WVb2ea4WJl6FVOywPgxDQr8CeA6BVRtmJiJQw0GP8WTjKHiAqLYFCV220qlSqKm5SzvbRtM/kqUHlilD2lWzQxmlG2mgMOUsK8//G+KDAg6NVHssWzALOMOZlH8xBILVROvc8E6K1xcV34GfeUk6se68yAZvvGlxOgQ7fyonB3Qyo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1be61e4-8b90-4c65-3440-08d77c401e29
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 00:38:32.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gcn8wnr0UoSGz0G7Rs35QmfxqLH0UzyrE1Q9C6blsqSrIZlP7/iJqByXKB6lRYA5L3R4WbXsuwF+Vei9dK1VZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4402
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
---
Changes in v2:
  - Removed "prox" child node and moved "keys" and "pwm" child nodes to the=
ir
    own bindings
  - Replaced linux,fw-file property with more common firmware-name property
  - Converted all bindings to YAML

 .../devicetree/bindings/input/iqs62x-keys.yaml     | 126 +++++++++++++++
 Documentation/devicetree/bindings/mfd/iqs62x.yaml  | 177 +++++++++++++++++=
++++
 .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |  30 ++++
 3 files changed, 333 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/iqs62x-keys.yam=
l
 create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml

diff --git a/Documentation/devicetree/bindings/input/iqs62x-keys.yaml b/Doc=
umentation/devicetree/bindings/input/iqs62x-keys.yaml
new file mode 100644
index 0000000..e9b54e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
@@ -0,0 +1,126 @@
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
+required:
+  - compatible
+  - linux,keycodes
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - azoteq,iqs620a-keys
+          - azoteq,iqs621-keys
+          - azoteq,iqs622-keys
+then:
+  patternProperties:
+    "^hall-switch-(north|south)$":
+      type: object
+      description:
+        Represents north/south-field Hall-effect sensor touch or proximity
+        events. Note that north/south-field orientation is reversed on the
+        IQS620AXzCSR device due to its flip-chip package.
+
+      properties:
+        linux,code:
+          $ref: /schemas/types.yaml#/definitions/uint32
+          description: Numeric switch code associated with the event.
+
+        azoteq,use-prox:
+          $ref: /schemas/types.yaml#/definitions/flag
+          description:
+            If present, specifies that Hall-effect sensor reporting should
+            use the device's wide-range proximity threshold instead of its
+            close-range touch threshold (default).
+
+      required:
+        - linux,code
+
+...
diff --git a/Documentation/devicetree/bindings/mfd/iqs62x.yaml b/Documentat=
ion/devicetree/bindings/mfd/iqs62x.yaml
new file mode 100644
index 0000000..24e6004
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/iqs62x.yaml
@@ -0,0 +1,177 @@
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
index 0000000..6b7aaef
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
@@ -0,0 +1,30 @@
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
+...
--
2.7.4

