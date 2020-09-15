Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB02269EEE
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Sep 2020 08:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgIOG4J (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Sep 2020 02:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgIOG4D (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Sep 2020 02:56:03 -0400
X-Greylist: delayed 1901 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Sep 2020 23:55:59 PDT
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464CCC06174A;
        Mon, 14 Sep 2020 23:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QHbkyesd8bkWd5SRIkxU2MuBCURyk8IvmzYZixbpLow=; b=IcLYXYdLwXMuWNI5YNV+beexWG
        VqKS5TR08XAcjscu1cr636dh1OtKXDLvJUekejY5Pe7iRra7sRFCN+MGjhi9L9kIITwbsU0GE/dsS
        2lrKX43k35Tg5+myx3sKwZ5AuK/zsHpwfTcHmsogpeaPkXmV989SyD5YnzEbbS/TQG9M=;
Received: from p200300ccff0cb3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:b300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kI4Na-0003Xe-8h; Tue, 15 Sep 2020 08:23:50 +0200
Date:   Tue, 15 Sep 2020 08:23:48 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
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
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH v2 04/10] dt-bindings: pwm: Add bindings for PWM
 function in Netronix EC
Message-ID: <20200915082348.2f6fff7a@aktux>
In-Reply-To: <20200915005443.GA604385@bogus>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-5-j.neuschaefer@gmx.net>
 <20200915005443.GA604385@bogus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Mon, 14 Sep 2020 18:54:43 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Sep 05, 2020 at 03:32:24PM +0200, Jonathan Neusch=C3=A4fer wrote:
> > The Netronix embedded controller as found in Kobo Aura and Tolino Shine
> > supports one PWM channel, which is used to control the frontlight
> > brightness on these devices.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >=20
> > v2:
> > - Add plaintext binding to patch description, for comparison
> > - Fix pwm-cells property (should be 2, not 1)
> > - Add dummy regulator to example, because the pwm-backlight binding req=
uires a
> >   power supply
> >=20
> >=20
> > For reference, here is the binding in text form:
> >=20
> >=20
> >   PWM functionality in Netronix Embedded Controller
> >=20
> >   Required properties:
> >   - compatible: should be "netronix,ntxec-pwm"
> >   - #pwm-cells: should be 2.
> >=20
> >   Available PWM channels:
> >   - 0: The PWM channel controlled by registers 0xa1-0xa7
> >=20
> >   Example:
> >=20
> >   	embedded-controller@43 {
> >   		compatible =3D "netronix,ntxec";
> >   		...
> >=20
> >   		ec_pwm: pwm {
> >   			compatible =3D "netronix,ntxec-pwm";
> >   			#pwm-cells =3D <1>;
> >   		};
> >   	};
> >=20
> >   	...
> >=20
> >   	backlight {
> >   		compatible =3D "pwm-backlight";
> >   		pwms =3D <&ec_pwm 0 50000>;
> >   	};
> > ---
> >  .../bindings/mfd/netronix,ntxec.yaml          | 19 +++++++++++
> >  .../bindings/pwm/netronix,ntxec-pwm.yaml      | 33 +++++++++++++++++++
> >  2 files changed, 52 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/netronix,ntxe=
c-pwm.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml =
b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> > index 596df460f98eb..73c873dda3e70 100644
> > --- a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> > @@ -31,6 +31,9 @@ properties:
> >      description:
> >        The EC can signal interrupts via a GPIO line
> >=20
> > +  pwm:
> > +    $ref: ../pwm/netronix,ntxec-pwm.yaml
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -53,5 +56,21 @@ examples:
> >                      interrupts =3D <11 IRQ_TYPE_EDGE_FALLING>;
> >                      interrupt-controller;
> >                      #interrupt-cells =3D <1>;
> > +
> > +                    ec_pwm: pwm {
> > +                            compatible =3D "netronix,ntxec-pwm";
> > +                            #pwm-cells =3D <2>;
> > +                    };
> >              };
> >      };
> > +
> > +    backlight {
> > +            compatible =3D "pwm-backlight";
> > +            pwms =3D <&ec_pwm 0 50000>;
> > +            power-supply =3D <&backlight_regulator>;
> > +    };
> > +
> > +    backlight_regulator: regulator-dummy {
> > +            compatible =3D "regulator-fixed";
> > +            regulator-name =3D "backlight";
> > +    };
> > diff --git a/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.y=
aml b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
> > new file mode 100644
> > index 0000000000000..0c9d2801b8de1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
> > @@ -0,0 +1,33 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/netronix,ntxec-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: PWM functionality in Netronix embedded controller
> > +
> > +maintainers:
> > +  - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > +
> > +description: |
> > +  See also Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> > +
> > +  The Netronix EC contains PWM functionality, which is usually used to=
 drive
> > +  the backlight LED.
> > +
> > +  The following PWM channels are supported:
> > +    - 0: The PWM channel controlled by registers 0xa1-0xa7
> > +
> > +allOf:
> > +  - $ref: pwm.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: netronix,ntxec-pwm
> > +
> > +  "#pwm-cells":
> > +    const: 2 =20
>=20
> Just move this to the parent and make the parent a pwm provider. There's=
=20
> no need for child nodes for this or the rtc.
>=20
hmm, there are apparently devices without rtc. If there is a child node
for the rtc, the corresponding devicetrees could disable rtc by not
having that node.
But maybe using the controller version is also feasible for that task.

Regards,
Andreas
