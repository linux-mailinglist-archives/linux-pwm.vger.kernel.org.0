Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB1226B3AB
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Sep 2020 01:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgIOXHQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Sep 2020 19:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbgIOOlk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 15 Sep 2020 10:41:40 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23F7922265;
        Tue, 15 Sep 2020 14:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600180327;
        bh=utJVhgwJTrunVJwtarb0ds5g2F08QaKajk/8z09HS/I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TFk0KmOgqkxPnPhwCUKPEH/u1GObeQ1s3DyU/vyGg9+rqkrmmgXCM3vQPAlVv4IwE
         N5R1qn5EJsfYcQSTp9mJ2R9ouUzUzDtnj4xZzOJjrAcbaMdhsCpd+crPPqi8zQ+DIG
         dari9jShrtKauwrggJ+jY94Hw+p1UL8pw3YCmTGQ=
Received: by mail-ot1-f47.google.com with SMTP id o8so3440225otl.4;
        Tue, 15 Sep 2020 07:32:07 -0700 (PDT)
X-Gm-Message-State: AOAM530xGpfA2Y6dQwR6fFQ9riHJ3Om6cS6iW9j3uKlJknlZofW5VRFI
        aAJlTzcW9FF34f/MA0B8/OWbAA6LzlkoYzn2Cw==
X-Google-Smtp-Source: ABdhPJxotHRWZRWMUoSLoNeE7xePoRIjifT/7QqjsQ5ljfN00watvkgScFQsGBTpsE8eUJBLvPaa5rChQkwszRGChsw=
X-Received: by 2002:a9d:411:: with SMTP id 17mr13481301otc.192.1600180326428;
 Tue, 15 Sep 2020 07:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-5-j.neuschaefer@gmx.net> <20200915005443.GA604385@bogus>
 <20200915082348.2f6fff7a@aktux>
In-Reply-To: <20200915082348.2f6fff7a@aktux>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Sep 2020 08:31:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL=gQxiU5uK-AEJtG3daOy83aS_D6G2Jo8_-dzKH70NkQ@mail.gmail.com>
Message-ID: <CAL_JsqL=gQxiU5uK-AEJtG3daOy83aS_D6G2Jo8_-dzKH70NkQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] dt-bindings: pwm: Add bindings for PWM function
 in Netronix EC
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Sep 15, 2020 at 12:24 AM Andreas Kemnade <andreas@kemnade.info> wro=
te:
>
> Hi,
>
> On Mon, 14 Sep 2020 18:54:43 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> > On Sat, Sep 05, 2020 at 03:32:24PM +0200, Jonathan Neusch=C3=A4fer wrot=
e:
> > > The Netronix embedded controller as found in Kobo Aura and Tolino Shi=
ne
> > > supports one PWM channel, which is used to control the frontlight
> > > brightness on these devices.
> > >
> > > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > > ---
> > >
> > > v2:
> > > - Add plaintext binding to patch description, for comparison
> > > - Fix pwm-cells property (should be 2, not 1)
> > > - Add dummy regulator to example, because the pwm-backlight binding r=
equires a
> > >   power supply
> > >
> > >
> > > For reference, here is the binding in text form:
> > >
> > >
> > >   PWM functionality in Netronix Embedded Controller
> > >
> > >   Required properties:
> > >   - compatible: should be "netronix,ntxec-pwm"
> > >   - #pwm-cells: should be 2.
> > >
> > >   Available PWM channels:
> > >   - 0: The PWM channel controlled by registers 0xa1-0xa7
> > >
> > >   Example:
> > >
> > >     embedded-controller@43 {
> > >             compatible =3D "netronix,ntxec";
> > >             ...
> > >
> > >             ec_pwm: pwm {
> > >                     compatible =3D "netronix,ntxec-pwm";
> > >                     #pwm-cells =3D <1>;
> > >             };
> > >     };
> > >
> > >     ...
> > >
> > >     backlight {
> > >             compatible =3D "pwm-backlight";
> > >             pwms =3D <&ec_pwm 0 50000>;
> > >     };
> > > ---
> > >  .../bindings/mfd/netronix,ntxec.yaml          | 19 +++++++++++
> > >  .../bindings/pwm/netronix,ntxec-pwm.yaml      | 33 +++++++++++++++++=
++
> > >  2 files changed, 52 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pwm/netronix,nt=
xec-pwm.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yam=
l b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> > > index 596df460f98eb..73c873dda3e70 100644
> > > --- a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> > > +++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> > > @@ -31,6 +31,9 @@ properties:
> > >      description:
> > >        The EC can signal interrupts via a GPIO line
> > >
> > > +  pwm:
> > > +    $ref: ../pwm/netronix,ntxec-pwm.yaml
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > > @@ -53,5 +56,21 @@ examples:
> > >                      interrupts =3D <11 IRQ_TYPE_EDGE_FALLING>;
> > >                      interrupt-controller;
> > >                      #interrupt-cells =3D <1>;
> > > +
> > > +                    ec_pwm: pwm {
> > > +                            compatible =3D "netronix,ntxec-pwm";
> > > +                            #pwm-cells =3D <2>;
> > > +                    };
> > >              };
> > >      };
> > > +
> > > +    backlight {
> > > +            compatible =3D "pwm-backlight";
> > > +            pwms =3D <&ec_pwm 0 50000>;
> > > +            power-supply =3D <&backlight_regulator>;
> > > +    };
> > > +
> > > +    backlight_regulator: regulator-dummy {
> > > +            compatible =3D "regulator-fixed";
> > > +            regulator-name =3D "backlight";
> > > +    };
> > > diff --git a/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm=
.yaml b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
> > > new file mode 100644
> > > index 0000000000000..0c9d2801b8de1
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
> > > @@ -0,0 +1,33 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pwm/netronix,ntxec-pwm.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: PWM functionality in Netronix embedded controller
> > > +
> > > +maintainers:
> > > +  - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > > +
> > > +description: |
> > > +  See also Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> > > +
> > > +  The Netronix EC contains PWM functionality, which is usually used =
to drive
> > > +  the backlight LED.
> > > +
> > > +  The following PWM channels are supported:
> > > +    - 0: The PWM channel controlled by registers 0xa1-0xa7
> > > +
> > > +allOf:
> > > +  - $ref: pwm.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: netronix,ntxec-pwm
> > > +
> > > +  "#pwm-cells":
> > > +    const: 2
> >
> > Just move this to the parent and make the parent a pwm provider. There'=
s
> > no need for child nodes for this or the rtc.
> >
> hmm, there are apparently devices without rtc. If there is a child node
> for the rtc, the corresponding devicetrees could disable rtc by not
> having that node.
> But maybe using the controller version is also feasible for that task.

If not probeable, then the compatible string should distinguish that.

Rob
