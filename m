Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9232C12746A
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2019 05:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfLTEAw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Dec 2019 23:00:52 -0500
Received: from mail-eopbgr680056.outbound.protection.outlook.com ([40.107.68.56]:11495
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbfLTEAw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 19 Dec 2019 23:00:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMc7crj2C9M3mbtZHagm/tYLrMSCyv83XCzFW50g/UCYMu5YE9aiCPxVLKhNeZN1451lIrbyqYi/gLqKY3QD9xcW4aC9bzIcLs5VrdijsmEvwWn7BHOax1Hed+UBtlMNmePrvRUPx4zrfHEcmb7h1Hqg/euGUX7DqNqbE4SZJcW+pcnYf97qwH+hQFqX0FP9OaROC5oQzxH8dEZwQULWO80EFoCnfwyW6cdXd6RTXWumjrZmljU/EB03DH7NgtKLxsu2Ujc1FcmyuWxABbJylw4GQmipAXBkyon1sM6dUVbynD43DvrQTrlEqkoM978qx2c4eBzYpVgvZuhupEXZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aGi3ky3McHHsltAc8WTeHnk/rcNfKjMbjxKIzhl4eU=;
 b=afX7DEAx8w48rt0vi6GLS1eJEhG+tgUPNb2kLTPq4Su3vK7XT/qIAa68Gxx8LwDwSZf3xQgBssPoYWnWasi6HbKY6sX8BUkOGjHrD7rUdwdvCxdwHVd7o3pMeMmecBRvblKZr+xB2G32JXezZOvu0NDQrD3iRGSnWUigtz8gCfeCXasesuwI9rSYpAXCoo8AMpyUEQZFT2ZUqM6fLY6ljmc1HgHurPY4kHF9mQ4z0hjElFrZXCWqt1V9Vd/y5NpyO3gVDFZuI6bcJoTWGC1tTHZc17EvUburyOS25vl/7mXTMKZIL5trHfPdfZ68ALF444BMZsly1hzTeSLzppycPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aGi3ky3McHHsltAc8WTeHnk/rcNfKjMbjxKIzhl4eU=;
 b=s5ftQEinhlN9iHkdU6IBRLBMVLo1KAwDJEUU992NYkjFVA83gHJQ3W+PrhJ2qLaolLjX+A7WGu0fuaqsi+f/stSeFnDDWK3KA5uuqrqpChORtiTk4wGFFYIL98+nOrcS1LiuRrx4D3CGAHfW4OAsaLDMKz/6b8wZGik+EGEXH5Y=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB5022.namprd08.prod.outlook.com (52.135.107.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 20 Dec 2019 04:00:45 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2559.016; Fri, 20 Dec 2019
 04:00:45 +0000
Received: from labundy.com (136.49.227.119) by SN4PR0401CA0027.namprd04.prod.outlook.com (2603:10b6:803:2a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend Transport; Fri, 20 Dec 2019 04:00:44 +0000
From:   Jeff LaBundy <jeff@labundy.com>
To:     Rob Herring <robh@kernel.org>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: Add bindings for Azoteq
 IQS620A/621/622/624/625
Thread-Topic: [PATCH v2 1/7] dt-bindings: Add bindings for Azoteq
 IQS620A/621/622/624/625
Thread-Index: AQHVrij7SDxpuO5/BEuAwvUFNi/XqqfAoDMAgAHXkwA=
Date:   Fri, 20 Dec 2019 04:00:45 +0000
Message-ID: <20191220040042.GB2658@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
 <1575851866-18919-2-git-send-email-jeff@labundy.com>
 <20191218235252.GA19438@bogus>
In-Reply-To: <20191218235252.GA19438@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0027.namprd04.prod.outlook.com
 (2603:10b6:803:2a::13) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 490b8446-f4f5-412d-b6b2-08d785013064
x-ms-traffictypediagnostic: SN6PR08MB5022:
x-microsoft-antispam-prvs: <SN6PR08MB5022F7E831D63AA3EA13C784D32D0@SN6PR08MB5022.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(136003)(39830400003)(396003)(34096005)(199004)(189003)(25584004)(966005)(86362001)(54906003)(4326008)(36756003)(2906002)(52116002)(7696005)(26005)(66946007)(8886007)(508600001)(66556008)(64756008)(66446008)(66476007)(5660300002)(8676002)(16526019)(186003)(30864003)(6916009)(33656002)(81156014)(8936002)(316002)(71200400001)(2616005)(956004)(55016002)(1076003)(81166006)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB5022;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HxYqBu/J4vhtv92Jj+B9zETbdisXtY1vQYeXSYRYa8mEKpHTEfMmrwQy6kok0KA6uHmt877hY7DSIrquboGGcG05tAGsJWEqUBsHHmGfPyHkn/Hgfr6ilbiPyZnJ2qCJbTrEk2tNrajd0cI42nd9Zdyra3OzdLnyfgicxCGMOeDWtYUsI8DmzFcmjY0UmyVquo4KHsxAMdqVC7FeiFzU5bRVIhXZCptALa6ayXI1VR1AnsljiUc1S3mNre6PCu5FhPpQrl5IrE+W94MZ4QECIhpXxgOUjrYtLEmXlHb+p4yGtAHctO7pKHwxP+O5RvyUUFWlBmeagYHXUEKAWzaGcJXxRgqgEQg+8gWj1JGCwUmVmL7pS+IE0NGCY/BRqtMOYo2TapQ8KurPUkbQju8mlXTRz6xafN8tN1t3bHwA9bZZuUY2ovPGw0NRWsJiH806iTTnIOQ06FV4KF/xu3fpGOG+PjxUV+w891MXQ/97imXfn+GSmW2wwPpSgirtRXYlSXTtLnqfuofTUuByI8d3+A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9C820E91F18CF43AECB3466A7F63700@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490b8446-f4f5-412d-b6b2-08d785013064
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 04:00:45.2900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWKE+gAkQRetXI8butBos8HVWTMureIqirYYy5CJuthetpjP4HXhG+8+YETjXZDDBzqUU+XsOyJJwLhgxFDMGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5022
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

Thank you for your prompt review and your kind words. A couple of questions
and comments for you below.

On Wed, Dec 18, 2019 at 05:52:52PM -0600, Rob Herring wrote:
> On Mon, Dec 09, 2019 at 12:38:32AM +0000, Jeff LaBundy wrote:
> > This patch adds device tree bindings for the Azoteq IQS620A, IQS621,
> > IQS622, IQS624 and IQS625 multi-function sensors.
> >=20
> > A total of three bindings are presented (one MFD and two child nodes);
> > they are submitted as a single patch because the child node bindings
> > have no meaning in the absence of the MFD binding.
> >=20
> > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > ---
> > Changes in v2:
> >   - Removed "prox" child node and moved "keys" and "pwm" child nodes to=
 their
> >     own bindings
> >   - Replaced linux,fw-file property with more common firmware-name prop=
erty
> >   - Converted all bindings to YAML
>=20
> Good job for first go.
>=20
> >=20
> >  .../devicetree/bindings/input/iqs62x-keys.yaml     | 126 +++++++++++++=
++
> >  Documentation/devicetree/bindings/mfd/iqs62x.yaml  | 177 +++++++++++++=
++++++++
> >  .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |  30 ++++
> >  3 files changed, 333 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/iqs62x-keys=
.yaml
> >  create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.yaml
> >  create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-pwm.y=
aml
>=20
> A couple of minor things below. With those fixed:
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> >=20
> > diff --git a/Documentation/devicetree/bindings/input/iqs62x-keys.yaml b=
/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> > new file mode 100644
> > index 0000000..e9b54e0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> > @@ -0,0 +1,126 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/iqs62x-keys.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Azoteq IQS620A/621/622/624/625 Keys and Switches
> > +
> > +maintainers:
> > +  - Jeff LaBundy <jeff@labundy.com>
> > +
> > +description: |
> > +  The Azoteq IQS620A, IQS621, IQS622, IQS624 and IQS625 multi-function=
 sensors
> > +  feature a variety of self-capacitive, mutual-inductive and Hall-effe=
ct sens-
> > +  ing capabilities that can facilitate a variety of contactless key an=
d switch
> > +  applications.
> > +
> > +  These functions are collectively represented by a "keys" child node =
from the
> > +  parent MFD driver. See Documentation/devicetree/bindings/mfd/iqs62x.=
yaml for
> > +  further details and examples. Sensor hardware configuration (self-ca=
pacitive
> > +  vs. mutual-inductive, etc.) is selected based on the device's firmwa=
re.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - azoteq,iqs620a-keys
> > +      - azoteq,iqs621-keys
> > +      - azoteq,iqs622-keys
> > +      - azoteq,iqs624-keys
> > +      - azoteq,iqs625-keys
> > +
> > +  linux,keycodes:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > +      - minItems: 1
> > +        maxItems: 16
> > +    description: |
> > +      Specifies the numeric keycodes associated with each available to=
uch or
> > +      proximity event according to the following table. An 'x' indicat=
es the
> > +      event is supported for a given device. Specify 0 for unused even=
ts.
> > +
> > +      ----------------------------------------------------------------=
---------
> > +      | #  | Event              | IQS620A | IQS621 | IQS622 | IQS624 |=
 IQS625 |
> > +      ----------------------------------------------------------------=
---------
> > +      | 0  | CH0 Touch          |    x    |    x   |    x   |    x   |=
    x   |
> > +      |    | Antenna 1 Touch*   |    x    |        |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 1  | CH0 Proximity      |    x    |    x   |    x   |    x   |=
    x   |
> > +      |    | Antenna 1 Prox.*   |    x    |        |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 2  | CH1 Touch          |    x    |    x   |    x   |    x   |=
    x   |
> > +      |    | Ant. 1 Deep Touch* |    x    |        |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 3  | CH1 Proximity      |    x    |    x   |    x   |    x   |=
    x   |
> > +      ----------------------------------------------------------------=
---------
> > +      | 4  | CH2 Touch          |    x    |        |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 5  | CH2 Proximity      |    x    |        |        |        |=
        |
> > +      |    | Antenna 2 Prox.*   |    x    |        |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 6  | Metal (+) Touch**  |    x    |    x   |        |        |=
        |
> > +      |    | Ant. 2 Deep Touch* |    x    |        |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 7  | Metal (+) Prox.**  |    x    |    x   |        |        |=
        |
> > +      |    | Antenna 2 Touch*   |    x    |        |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 8  | Metal (-) Touch**  |    x    |    x   |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 9  | Metal (-) Prox.**  |    x    |    x   |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 10 | SAR Active***      |    x    |        |    x   |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 11 | SAR Quick Rel.***  |    x    |        |    x   |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 12 | SAR Movement***    |    x    |        |    x   |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 13 | SAR Filter Halt*** |    x    |        |    x   |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 14 | Wheel Up           |         |        |        |    x   |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 15 | Wheel Down         |         |        |        |    x   |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      *   Two-channel SAR. Replaces CH0-2 plus metal touch and proximi=
ty events
> > +          if enabled via firmware.
> > +      **  "+" and "-" refer to the polarity of a channel's delta (LTA =
- counts),
> > +          where "LTA" is defined as the channel's long-term average.
> > +      *** One-channel SAR. Replaces CH0-2 touch and proximity events i=
f enabled
> > +          via firmware.
> > +
> > +required:
> > +  - compatible
> > +  - linux,keycodes
>=20
> Add:=20
>=20
> additionalProperties: false
>=20

When I add this, the dt_binding_check step complains that the hall switch c=
hild nodes
used in the examples are unrecognized, e.g.:

iqs620a@44: keys: 'hall-switch-south' does not match any of the regexes: 'p=
inctrl-[0-9]+'

When I originally encountered this, I found that the mdio-mux child node in=
 [0] seems
to be a similar example and omits additionalProperties, which is why I orig=
inally did
that here. Do you have any advice on how to proceed?

> > +
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - azoteq,iqs620a-keys
> > +          - azoteq,iqs621-keys
> > +          - azoteq,iqs622-keys
> > +then:
> > +  patternProperties:
> > +    "^hall-switch-(north|south)$":
> > +      type: object
> > +      description:
> > +        Represents north/south-field Hall-effect sensor touch or proxi=
mity
> > +        events. Note that north/south-field orientation is reversed on=
 the
> > +        IQS620AXzCSR device due to its flip-chip package.
> > +
> > +      properties:
> > +        linux,code:
> > +          $ref: /schemas/types.yaml#/definitions/uint32
> > +          description: Numeric switch code associated with the event.
> > +
> > +        azoteq,use-prox:
> > +          $ref: /schemas/types.yaml#/definitions/flag
> > +          description:
> > +            If present, specifies that Hall-effect sensor reporting sh=
ould
> > +            use the device's wide-range proximity threshold instead of=
 its
> > +            close-range touch threshold (default).
> > +
> > +      required:
> > +        - linux,code
> > +

Do you think I should specify additionalProperties: false within these chil=
d nodes?

> > +...
> > diff --git a/Documentation/devicetree/bindings/mfd/iqs62x.yaml b/Docume=
ntation/devicetree/bindings/mfd/iqs62x.yaml
> > new file mode 100644
> > index 0000000..24e6004
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/iqs62x.yaml
> > @@ -0,0 +1,177 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/iqs62x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Azoteq IQS620A/621/622/624/625 Multi-Function Sensors
> > +
> > +maintainers:
> > +  - Jeff LaBundy <jeff@labundy.com>
> > +
> > +description: |
> > +  The Azoteq IQS620A, IQS621, IQS622, IQS624 and IQS625 multi-function=
 sensors
> > +  integrate multiple sensing technologies in a single package.
> > +
> > +  Link to data sheets: https://www.azoteq.com/
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - azoteq,iqs620a
> > +      - azoteq,iqs621
> > +      - azoteq,iqs622
> > +      - azoteq,iqs624
> > +      - azoteq,iqs625
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  firmware-name:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      Specifies the name of the calibration and configuration file sel=
ected by
> > +      the driver. If this property is omitted, the name is chosen base=
d on the
> > +      device name with ".bin" as the extension (e.g. iqs620a.bin for I=
QS620A).
> > +
> > +  keys:
> > +    $ref: ../input/iqs62x-keys.yaml
> > +
> > +  pwm:
> > +    $ref: ../pwm/iqs620a-pwm.yaml
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
>=20
> Add:=20
>=20
> additionalProperties: false
>=20

Sure thing, will do.

> > +
> > +examples:
> > +  - |
> > +    /*
> > +     * Dual capacitive buttons with additional "air button," unipolar =
lid
> > +     * switch and panel-mounted LED.
> > +     */
> > +    #include <dt-bindings/input/input.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            iqs620a@44 {
> > +                    compatible =3D "azoteq,iqs620a";
> > +                    reg =3D <0x44>;
> > +                    interrupt-parent =3D <&gpio>;
> > +                    interrupts =3D <17 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +                    keys {
> > +                            compatible =3D "azoteq,iqs620a-keys";
> > +
> > +                            linux,keycodes =3D <KEY_SELECT>,
> > +                                             <KEY_MENU>,
> > +                                             <KEY_OK>,
> > +                                             <KEY_MENU>;
> > +
> > +                            hall-switch-south {
> > +                                    linux,code =3D <SW_LID>;
> > +                                    azoteq,use-prox;
> > +                            };
> > +                    };
> > +
> > +                    iqs620a_pwm: pwm {
> > +                            compatible =3D "azoteq,iqs620a-pwm";
> > +                            #pwm-cells =3D <2>;
> > +                    };
> > +            };
> > +    };
> > +
> > +    pwmleds {
> > +            compatible =3D "pwm-leds";
> > +
> > +            panel {
> > +                    pwms =3D <&iqs620a_pwm 0 1000000>;
> > +                    max-brightness =3D <255>;
> > +            };
> > +    };
> > +
> > +  - |
> > +    /* Single inductive button with bipolar dock/tablet-mode switch. *=
/
> > +    #include <dt-bindings/input/input.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            iqs620a@44 {
> > +                    compatible =3D "azoteq,iqs620a";
> > +                    reg =3D <0x44>;
> > +                    interrupt-parent =3D <&gpio>;
> > +                    interrupts =3D <17 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +                    firmware-name =3D "iqs620a_coil.bin";
> > +
> > +                    keys {
> > +                            compatible =3D "azoteq,iqs620a-keys";
> > +
> > +                            linux,keycodes =3D <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <KEY_MUTE>;
> > +
> > +                            hall-switch-north {
> > +                                    linux,code =3D <SW_DOCK>;
> > +                            };
> > +
> > +                            hall-switch-south {
> > +                                    linux,code =3D <SW_TABLET_MODE>;
> > +                            };
> > +                    };
> > +            };
> > +    };
> > +
> > +  - |
> > +    /* Dual capacitive buttons with volume knob. */
> > +    #include <dt-bindings/input/input.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            iqs624@44 {
> > +                    compatible =3D "azoteq,iqs624";
> > +                    reg =3D <0x44>;
> > +                    interrupt-parent =3D <&gpio>;
> > +                    interrupts =3D <17 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +                    keys {
> > +                            compatible =3D "azoteq,iqs624-keys";
> > +
> > +                            linux,keycodes =3D <BTN_0>,
> > +                                             <0>,
> > +                                             <BTN_1>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <KEY_VOLUMEUP>,
> > +                                             <KEY_VOLUMEDOWN>;
> > +                    };
> > +            };
> > +    };
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml b/D=
ocumentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
> > new file mode 100644
> > index 0000000..6b7aaef
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
> > @@ -0,0 +1,30 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/iqs620a-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Azoteq IQS620A PWM Generator
> > +
> > +maintainers:
> > +  - Jeff LaBundy <jeff@labundy.com>
> > +
> > +description: |
> > +  The Azoteq IQS620A multi-function sensor generates a fixed-frequency=
 PWM
> > +  output represented by a "pwm" child node from the parent MFD driver.=
 See
> > +  Documentation/devicetree/bindings/mfd/iqs62x.yaml for further detail=
s as
> > +  well as an example.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - azoteq,iqs620a-pwm
> > +
> > +  "#pwm-cells":
> > +    const: 2
> > +
> > +required:
> > +  - compatible
> > +  - "#pwm-cells"
>=20
> Add:=20
>=20
> additionalProperties: false
>=20

Sure thing, will do.

> > +
> > +...
> > --
> > 2.7.4
> >=20

[0] Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml

Kind regards,
Jeff LaBundy
