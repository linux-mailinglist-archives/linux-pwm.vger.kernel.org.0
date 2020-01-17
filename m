Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 589AC1401F4
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2020 03:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388973AbgAQCf2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Jan 2020 21:35:28 -0500
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:11154
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729113AbgAQCf1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 16 Jan 2020 21:35:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COhN77LKqUtQkmT6+15kd9R0Amse4UXDun6u8++1OkXeejTY5vMfRl9kxjEy5BQHDwkvohhNUx2VgvmpKrTEnKbZ6gpSsEWZNAi+ntK8wxhzDe7y0eajDHL6hN/HmUakVsahAfCfgbgkcO12sc21fAFXbrk22RY0SDG54Q8DcoWNG82nVsgc50NqGOutwj8SPjwFlnOHqAiFu5y9bych3pJiaySZzlAkGGmw3QNuboZhdada7cGUrBgBcUJ4ho4jUGTC4xtrjFy+Gl4DBYGzsDI+C0FBG/Miywiv7KF6oG1v9NaqvevWJrBWZiaCJB5yjx006zPZSwfS3pCywTDRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MhdkyNSkbfourqU82chJm/iDvT486HEEhLdTi18dnY=;
 b=m/M8nuOFin1VfXeFgUXBQUq2HBPlpZu51XV+1NSCx37sWtPFTfVWMeH0rfJ9N4kopX6WnFZ8KmR7yKUU4UbaATbkmT3gFBjSUR50A3Tjn1zskakeyC6MoavJ86ADzQLc1w1SPoBZPyIKuNc59OMQ73w8UoOvtUSiqNl9Apl5cO49aTypLcBxFFix49ncim7o96+6bDfWn4Bfed7MT17ysiqpAds995OFR+7osTKeUWTV7zkKVUQuxkPbj4tAwv/ExFt7YH7i7YTYMOfciu0hpWe49/o4sCEoiXTVaNBT+7b12/IS2KKRXXzhJUi82qMi7rK2+eTtIdwabyMuYcGaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MhdkyNSkbfourqU82chJm/iDvT486HEEhLdTi18dnY=;
 b=lzhueQegxTpxnW4/cvVJONI4jynH70qQ5QSdMIzOrrgn0NsGFKUhiXtVY2FWgWLntukK9cRRVEmRXUDMyNx1tanlBl4E6kIfol9GGaxpQl/FmSloC7SLPxq/KiqY5rgN4nm4PtHe160t5ByJxqGZO00KrlPEBdBK7T9utcLqGbk=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB6029.namprd08.prod.outlook.com (20.178.6.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Fri, 17 Jan 2020 02:35:25 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 02:35:25 +0000
Received: from localhost.localdomain (136.49.227.119) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.6 via Frontend Transport; Fri, 17 Jan 2020 02:35:17 +0000
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
Subject: [PATCH v4 1/7] dt-bindings: Add bindings for Azoteq
 IQS620A/621/622/624/625
Thread-Topic: [PATCH v4 1/7] dt-bindings: Add bindings for Azoteq
 IQS620A/621/622/624/625
Thread-Index: AQHVzN7FRaEUM9fuoUya23+TVDktwg==
Date:   Fri, 17 Jan 2020 02:35:25 +0000
Message-ID: <1579228475-6681-2-git-send-email-jeff@labundy.com>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
In-Reply-To: <1579228475-6681-1-git-send-email-jeff@labundy.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66dbcd8b-f5c9-412d-113e-08d79af5e7cf
x-ms-traffictypediagnostic: SN6PR08MB6029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR08MB6029DF3020CE901F44ACE621D3310@SN6PR08MB6029.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39830400003)(396003)(376002)(34096005)(366004)(189003)(199004)(36756003)(66556008)(107886003)(66946007)(4326008)(64756008)(66476007)(956004)(54906003)(52116002)(6666004)(110136005)(66446008)(2616005)(30864003)(966005)(6506007)(69590400006)(86362001)(26005)(316002)(16526019)(186003)(81166006)(2906002)(6486002)(8676002)(81156014)(508600001)(5660300002)(71200400001)(7416002)(8936002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB6029;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ogLD5BdV5MSDO82rsxk3AjrxS4NDeNzJDSYAG3gJK14qZlsGQqPrlB2Dt+ComoUzTNytR3H9JPQ0ao/aAYTxiEzY6et8UjmXOoGXCG/ohL48rPFzlu1ehdb9o7vskv+qnNCGYFvJu97oXMm/GM1E9KLeFKpAhDkBq1uO73C84RftSbdJmImQQaCjjCg7gkVPbyzkiuKfVe7PpQbA7DnM8QzBHLgkwu33bTyoCXNmZ0BLMCnniswe3uiEfPB2G/KWcdCuk96RWoGSAxiWi9pWImkkbRlx0gLzuvd98R0l9xqGyr9TAtOKzmDfpAAo0A9I1KAoJFspgBCcXfj88V6A7W3ejqhgi3rcDx95gTgvbJuq6fc07ZVFx7L/nP/KOC2O2jk+1QkmkQSb4MFbInSfDUOtav8aJOCVNTMQsFQOwSGvHGLSZMoiq84FAFv0IzfcGiwmnyTtfYyETzJ5BCyS7OsPDFD5KEarUuJ0oRUMjhrK9twloVpDioKPRfCLWHeXmKuTg8xpDDG54T/ePeznUJgPwEz0azhs7EFj0FxhiRjVRNz7nLR2iIJ8xyww1pwG2TSoWp1OsUVGDvlgHAU0hg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66dbcd8b-f5c9-412d-113e-08d79af5e7cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 02:35:25.1232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: untYUKukNMQ5CL89ZnqeWEKJI0D6ut+LNgFAHVmq9LDrAsQ9pf5PRhmCd3bsO04nhHzhQalQYvmt2Ndmrix9Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB6029
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
Changes in v4:
  - None

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

