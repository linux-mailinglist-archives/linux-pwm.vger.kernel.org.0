Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5553612E08F
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jan 2020 22:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgAAVcs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Jan 2020 16:32:48 -0500
Received: from mail-eopbgr770088.outbound.protection.outlook.com ([40.107.77.88]:20804
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbgAAVcs (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 1 Jan 2020 16:32:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ekk/GAKu5lihzWk2Wai1Hn8bNc24q8WNKlw+DE3h0gooGNdvChG9AL1Qtk1imZ+CmjTmfHXBlrTlJHjCh2KDGzcrcR+rq44LtKz/03IyFvFs00x7JL7CpZwkXakj7w+d3iKwb4qCYSAmHlWD3nM9LhUOEEeaZki/DVrYhZox1rlUjcJXJy7q6ihXA1kmwMoh5pRzdfbzZzS+Af8NjuwyAMb/XkXSFF8HanFGlyEkotzW04B6PPlWTNXgY+BCjmbiNBCPLu/kNNaeCkW33W4NgXLYEBweZcWX9ZnfxFr2RUoUQgRKv2YNQtIwTJzuiC/PCNJzrZRl0Ikfj2zqom/5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5mKFqO+svw3Vye0B9o2M3vvhXm6Um4Hi+DykCNklbk=;
 b=W+6ZCFrkYMnkiT8aAx095fDetAIoHwd6//3daupSDotgBwEMvHRWtaXwvIbxjU/t0k1KYK6C5cD2/f4j3sZAR5/2JC/IqiM2S2him9qBFQL9gXaWEYf5G+7hoVKatDHF/uTQEZt/iFbJKY280Olzj8yKJzbPHQv/2zdAAvaKPKy/HoEkMbhpJizw6VdcRkfY4qTDBu9LEKDbYosaDXxLklmaUbEkpLU1J5qSH7gxXTq8QJ1MqvK49WwsfLvXyxBae2ULOZlyDr3dsvuLhz5Ke9kmJZ9EDjJTRuV4H4IdqJr+AlKzPT89Ki5yDHJMuxsdccPvN/wqgujZclsnfYjslA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5mKFqO+svw3Vye0B9o2M3vvhXm6Um4Hi+DykCNklbk=;
 b=JQqkZC+hVdmF/pjvyp/Q3sF7YTFr9OP0mYH6r0NKcP+hEEgpD67SszNS6lSo3JgaQlwEIQQrsYNz47TsT4D+UDAoNo3xQOi9BvcTjSbothakrk3er69T9SKBJI84XsGEEDyaYuHr3WjS+Zk7hFmuEdwgOPkd/Y+VOKCo8InYPkI=
Received: from SN6PR08MB5053.namprd08.prod.outlook.com (52.135.107.153) by
 SN6PR08MB4062.namprd08.prod.outlook.com (52.135.64.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Wed, 1 Jan 2020 21:32:39 +0000
Received: from SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139]) by SN6PR08MB5053.namprd08.prod.outlook.com
 ([fe80::7c80:2b62:5d9a:2139%4]) with mapi id 15.20.2581.007; Wed, 1 Jan 2020
 21:32:38 +0000
Received: from labundy.com (136.49.227.119) by SN4PR0501CA0150.namprd05.prod.outlook.com (2603:10b6:803:2c::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.7 via Frontend Transport; Wed, 1 Jan 2020 21:32:37 +0000
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
Thread-Index: AQHVrij7SDxpuO5/BEuAwvUFNi/XqqfAoDMAgAHXkwCAB3WsgIAMjCoA
Date:   Wed, 1 Jan 2020 21:32:38 +0000
Message-ID: <20200101213228.GA14339@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
 <1575851866-18919-2-git-send-email-jeff@labundy.com>
 <20191218235252.GA19438@bogus> <20191220040042.GB2658@labundy.com>
 <CAL_Jsq+eXQKSExm+HU+3iY=zryj-KgfNbJ7sGd=OWQbQ3sn-yg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+eXQKSExm+HU+3iY=zryj-KgfNbJ7sGd=OWQbQ3sn-yg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0150.namprd05.prod.outlook.com
 (2603:10b6:803:2c::28) To SN6PR08MB5053.namprd08.prod.outlook.com
 (2603:10b6:805:78::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jeff@labundy.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [136.49.227.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8302e0b9-f9a5-4741-701a-08d78f021fd5
x-ms-traffictypediagnostic: SN6PR08MB4062:
x-microsoft-antispam-prvs: <SN6PR08MB40623A178DD95A1338A6C9C7D3210@SN6PR08MB4062.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02698DF457
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39830400003)(376002)(34096005)(136003)(199004)(189003)(66946007)(316002)(54906003)(52116002)(66556008)(6916009)(8886007)(71200400001)(55016002)(64756008)(66446008)(7696005)(966005)(7416002)(508600001)(86362001)(53546011)(8936002)(2906002)(5660300002)(36756003)(81166006)(81156014)(8676002)(1076003)(26005)(4326008)(2616005)(16526019)(186003)(956004)(33656002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR08MB4062;H:SN6PR08MB5053.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: labundy.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jZ/Yydw3+43mZDbmFV8cyppYuG+9f8wgumMxj0pkx4dC3YEWDkpQXlw1bN0/U44TEGjXJekDCaIFWFGVwvKnk3Ee6q8l8GjIUM+wlREByb4m7wb4ehkU9ogirnp7ftZmeTae7Jh8PW1P/J7uTkxkSuRHejWqkL6BB9MN+geNu3hUzmbKDYJBPcyc2VQRKTcODbTPKOlBKamH55HfRaSGWb5K1Fpp4NMZVRoXAEdDGU1bzf4N+zpCNJOMWTlIoGa7udRcNXjhBa+xLmiN7pV2568tLCyS7FgRwEo6H3I7EIL+Iuo1iR4DXRIkvU+bgELrNX22jolNqlpNZcjwGuOQhrULGI5NSPFaZTxyIZJDS9TMKqBfTPJQLQZie4Uvj6/gERjb/B+Q/qAHsp3j1jNarMxTRh8/YCxmmDwSEY9BjnHKwYP+7ip8b1446kYHcR8KQxAjjjo7CMXStFU3H2TmRyvdREG8yWwW258VDVKPyTI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A89DA2269B1C349B527022C2F02D6BB@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8302e0b9-f9a5-4741-701a-08d78f021fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2020 21:32:38.6090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 33gNM4JBxxZ/Dj2N8GaDywJ2zJ/voDaHR2OvU3Kslw6ty0fPjWXTE9q0PZJww3MkRABFJI8rEpdMp0LWl3cykQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4062
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

On Tue, Dec 24, 2019 at 02:55:41PM -0700, Rob Herring wrote:
> On Thu, Dec 19, 2019 at 9:00 PM Jeff LaBundy <jeff@labundy.com> wrote:
> >
> > Hi Rob,
> >
> > Thank you for your prompt review and your kind words. A couple of quest=
ions
> > and comments for you below.
> >
> > On Wed, Dec 18, 2019 at 05:52:52PM -0600, Rob Herring wrote:
> > > On Mon, Dec 09, 2019 at 12:38:32AM +0000, Jeff LaBundy wrote:
> > > > This patch adds device tree bindings for the Azoteq IQS620A, IQS621=
,
> > > > IQS622, IQS624 and IQS625 multi-function sensors.
> > > >
> > > > A total of three bindings are presented (one MFD and two child node=
s);
> > > > they are submitted as a single patch because the child node binding=
s
> > > > have no meaning in the absence of the MFD binding.
> > > >
> > > > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > > > ---
> > > > Changes in v2:
> > > >   - Removed "prox" child node and moved "keys" and "pwm" child node=
s to their
> > > >     own bindings
> > > >   - Replaced linux,fw-file property with more common firmware-name =
property
> > > >   - Converted all bindings to YAML
> > >
> > > Good job for first go.
> > >
> > > >
> > > >  .../devicetree/bindings/input/iqs62x-keys.yaml     | 126 +++++++++=
++++++
> > > >  Documentation/devicetree/bindings/mfd/iqs62x.yaml  | 177 +++++++++=
++++++++++++
> > > >  .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |  30 ++++
> > > >  3 files changed, 333 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/input/iqs62x-=
keys.yaml
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.ya=
ml
> > > >  create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-p=
wm.yaml
> > >
> > > A couple of minor things below. With those fixed:
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > >
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/input/iqs62x-keys.ya=
ml b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> > > > new file mode 100644
> > > > index 0000000..e9b54e0
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> > > > @@ -0,0 +1,126 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/input/iqs62x-keys.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Azoteq IQS620A/621/622/624/625 Keys and Switches
> > > > +
> > > > +maintainers:
> > > > +  - Jeff LaBundy <jeff@labundy.com>
> > > > +
> > > > +description: |
> > > > +  The Azoteq IQS620A, IQS621, IQS622, IQS624 and IQS625 multi-func=
tion sensors
> > > > +  feature a variety of self-capacitive, mutual-inductive and Hall-=
effect sens-
> > > > +  ing capabilities that can facilitate a variety of contactless ke=
y and switch
> > > > +  applications.
> > > > +
> > > > +  These functions are collectively represented by a "keys" child n=
ode from the
> > > > +  parent MFD driver. See Documentation/devicetree/bindings/mfd/iqs=
62x.yaml for
> > > > +  further details and examples. Sensor hardware configuration (sel=
f-capacitive
> > > > +  vs. mutual-inductive, etc.) is selected based on the device's fi=
rmware.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - azoteq,iqs620a-keys
> > > > +      - azoteq,iqs621-keys
> > > > +      - azoteq,iqs622-keys
> > > > +      - azoteq,iqs624-keys
> > > > +      - azoteq,iqs625-keys
> > > > +
> > > > +  linux,keycodes:
> > > > +    allOf:
> > > > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > +      - minItems: 1
> > > > +        maxItems: 16
> > > > +    description: |
> > > > +      Specifies the numeric keycodes associated with each availabl=
e touch or
> > > > +      proximity event according to the following table. An 'x' ind=
icates the
> > > > +      event is supported for a given device. Specify 0 for unused =
events.
> > > > +
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | #  | Event              | IQS620A | IQS621 | IQS622 | IQS6=
24 | IQS625 |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 0  | CH0 Touch          |    x    |    x   |    x   |    x=
   |    x   |
> > > > +      |    | Antenna 1 Touch*   |    x    |        |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 1  | CH0 Proximity      |    x    |    x   |    x   |    x=
   |    x   |
> > > > +      |    | Antenna 1 Prox.*   |    x    |        |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 2  | CH1 Touch          |    x    |    x   |    x   |    x=
   |    x   |
> > > > +      |    | Ant. 1 Deep Touch* |    x    |        |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 3  | CH1 Proximity      |    x    |    x   |    x   |    x=
   |    x   |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 4  | CH2 Touch          |    x    |        |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 5  | CH2 Proximity      |    x    |        |        |     =
   |        |
> > > > +      |    | Antenna 2 Prox.*   |    x    |        |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 6  | Metal (+) Touch**  |    x    |    x   |        |     =
   |        |
> > > > +      |    | Ant. 2 Deep Touch* |    x    |        |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 7  | Metal (+) Prox.**  |    x    |    x   |        |     =
   |        |
> > > > +      |    | Antenna 2 Touch*   |    x    |        |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 8  | Metal (-) Touch**  |    x    |    x   |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 9  | Metal (-) Prox.**  |    x    |    x   |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 10 | SAR Active***      |    x    |        |    x   |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 11 | SAR Quick Rel.***  |    x    |        |    x   |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 12 | SAR Movement***    |    x    |        |    x   |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 13 | SAR Filter Halt*** |    x    |        |    x   |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 14 | Wheel Up           |         |        |        |    x=
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 15 | Wheel Down         |         |        |        |    x=
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      *   Two-channel SAR. Replaces CH0-2 plus metal touch and pro=
ximity events
> > > > +          if enabled via firmware.
> > > > +      **  "+" and "-" refer to the polarity of a channel's delta (=
LTA - counts),
> > > > +          where "LTA" is defined as the channel's long-term averag=
e.
> > > > +      *** One-channel SAR. Replaces CH0-2 touch and proximity even=
ts if enabled
> > > > +          via firmware.
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - linux,keycodes
> > >
> > > Add:
> > >
> > > additionalProperties: false
> > >
> >
> > When I add this, the dt_binding_check step complains that the hall swit=
ch child nodes
> > used in the examples are unrecognized, e.g.:
> >
> > iqs620a@44: keys: 'hall-switch-south' does not match any of the regexes=
: 'pinctrl-[0-9]+'
> >
> > When I originally encountered this, I found that the mdio-mux child nod=
e in [0] seems
> > to be a similar example and omits additionalProperties, which is why I =
originally did
> > that here. Do you have any advice on how to proceed?
>=20
> That's because the properties are under an if/then. Your options are
> split the schema into 2 files to eliminate the if/then or just define
> "^hall-switch-(north|south)$" with just 'true' outside the if/then. A
> variation on the 2nd option is invert the if/then and make the schema
> false. Then the 'main' schema defines the full superset of properties
> and the if/then just filters out ones that don't apply in some cases.
>=20

Thank you for this detailed explanation; it all makes sense now. For v3
I've opted for the variant of option (2) because it allows for a single
binding as I originally intended, and prompts dt_binding_check to throw
an error if a dts author mistakenly defines the hall-switch-north/south
nodes within either of the two devices that don't support that feature.
I also find it simpler and more intuitive.

> >
> > > > +
> > > > +if:
> > > > +  properties:
> > > > +    compatible:
> > > > +      contains:
> > > > +        enum:
> > > > +          - azoteq,iqs620a-keys
> > > > +          - azoteq,iqs621-keys
> > > > +          - azoteq,iqs622-keys
> > > > +then:
> > > > +  patternProperties:
> > > > +    "^hall-switch-(north|south)$":
> > > > +      type: object
> > > > +      description:
> > > > +        Represents north/south-field Hall-effect sensor touch or p=
roximity
> > > > +        events. Note that north/south-field orientation is reverse=
d on the
> > > > +        IQS620AXzCSR device due to its flip-chip package.
> > > > +
> > > > +      properties:
> > > > +        linux,code:
> > > > +          $ref: /schemas/types.yaml#/definitions/uint32
> > > > +          description: Numeric switch code associated with the eve=
nt.
> > > > +
> > > > +        azoteq,use-prox:
> > > > +          $ref: /schemas/types.yaml#/definitions/flag
> > > > +          description:
> > > > +            If present, specifies that Hall-effect sensor reportin=
g should
> > > > +            use the device's wide-range proximity threshold instea=
d of its
> > > > +            close-range touch threshold (default).
> > > > +
> > > > +      required:
> > > > +        - linux,code
> > > > +
> >
> > Do you think I should specify additionalProperties: false within these =
child nodes?
>=20
> Yes.

Sure thing, will do.

FYI, since these additional changes are quite small and I believe I've
implemented them exactly as you've suggested, I plan on retaining your
Reviewed-by for v3 which I'll be sending out soon. However if you find
that I have misinterpreted anything, please let me know and I will fix
it promptly.

Wishing you a Happy New Year,
Jeff LaBundy
