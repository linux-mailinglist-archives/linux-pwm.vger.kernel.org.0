Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E42202C28
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jun 2020 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgFUTXH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 21 Jun 2020 15:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgFUTXG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 21 Jun 2020 15:23:06 -0400
X-Greylist: delayed 2470 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 21 Jun 2020 12:23:06 PDT
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9B3C061794;
        Sun, 21 Jun 2020 12:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ns6TK6QQGIUXKq5NhpLUGhsR1TGNDvMg6IvOys7w/qs=; b=h/Fo7f0pwt72AbNBRZXzFo+jTh
        FSWOCnRYQgyo+QUPZmQKMQbVgVyczZHFrTrcWq9rb/MdRwp/TB31GiT0TGfbvCd0bIIRWgmzZbDpw
        0Mddw5tuVugxKoBKx64zPt3dp59a77yYJsB7Cfmo2EZmu3jZaVPjq9yQMdSEAM/Bbvc0=;
Received: from p200300ccff4ba5001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff4b:a500:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jn4uD-0002ay-Fk; Sun, 21 Jun 2020 20:41:25 +0200
Date:   Sun, 21 Jun 2020 20:41:23 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        Josua Mayer <josua.mayer@jm0.eu>
Subject: Re: [RFC PATCH 05/10] dt-bindings: pwm: Add bindings for PWM
 function in Netronix EC
Message-ID: <20200621204123.6c761d98@aktux>
In-Reply-To: <20200620224222.1312520-4-j.neuschaefer@gmx.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
        <20200620224222.1312520-4-j.neuschaefer@gmx.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 21 Jun 2020 00:42:16 +0200
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> The Netronix embedded controller as found in Kobo Aura and Tolino Shine
> supports one PWM channel, which is used to control the frontlight
> brightness on these devices.
>=20
> Known problems:
> - `make dt_binding_check` shows the following warnings:
>   Documentation/devicetree/bindings/mfd/netronix,ntxec.example.dts:49.17-=
42:
>   Warning (pwms_property): /example-0/backlight:pwms: cell 2 is not a
>   phandle reference
>   Documentation/devicetree/bindings/mfd/netronix,ntxec.example.dts:49.17-=
42:
>   Warning (pwms_property): /example-0/backlight:pwms: Could not get
>   phandle node for (cell 2)
>=20
In the tolino sources in ./drivers/misc/ntx-misc.c I find this line

        if(4=3D=3DgptHWCFG->m_val.bFL_PWM) {

No idea what it does but I would expect to have a kind of translation to
a dt property?

> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  .../bindings/mfd/netronix,ntxec.yaml          | 13 ++++++++
>  .../bindings/pwm/netronix,ntxec-pwm.yaml      | 33 +++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/netronix,ntxec-=
pwm.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml b/=
Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> index 596df460f98eb..6562c41c5a9a9 100644
> --- a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> @@ -31,6 +31,9 @@ properties:
>      description:
>        The EC can signal interrupts via a GPIO line
>=20
> +  pwm:
> +    $ref: ../pwm/netronix,ntxec-pwm.yaml
> +
>  required:
>    - compatible
>    - reg
> @@ -53,5 +56,15 @@ examples:
>                      interrupts =3D <11 IRQ_TYPE_EDGE_FALLING>;
>                      interrupt-controller;
>                      #interrupt-cells =3D <1>;
> +
> +                    ec_pwm: pwm {
> +                            compatible =3D "netronix,ntxec-pwm";
> +                            #pwm-cells =3D <1>;
shouldn't that be 2?
> +                    };
>              };
>      };
> +
> +    backlight {
> +            compatible =3D "pwm-backlight";
> +            pwms =3D <&ec_pwm 0 50000>;
since you have 2 values after the &ec_pwm=20

> +    };
> diff --git a/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yam=
l b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
> new file mode 100644
> index 0000000000000..1dc1b1aba081c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/netronix,ntxec-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PWM functionality in Netronix embedded controller
> +
> +maintainers:
> +  - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> +
> +description: |
> +  See also Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> +
> +  The Netronix EC contains PWM functionality, which is usually used to d=
rive
> +  the backlight LED.
> +
> +  The following PWM channels are supported:
> +    - 0: The PWM channel controlled by registers 0xa1-0xa7
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: netronix,ntxec-pwm
> +
> +  "#pwm-cells":
> +    const: 1

shouln't that be 2?
> +
> +required:
> +  - compatible
> +  - "#pwm-cells"
> --
> 2.27.0
>=20
>=20

Regards,
Andreas
