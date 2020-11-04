Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B2D2A6E60
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Nov 2020 20:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgKDTzZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 14:55:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:33184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbgKDTzY (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 4 Nov 2020 14:55:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15DE6AC53;
        Wed,  4 Nov 2020 19:55:22 +0000 (UTC)
Message-ID: <4debc77f5c72e1f4eff36a700231493bf9fbf404.camel@suse.de>
Subject: Re: [PATCH v3 09/11] dt-bindings: pwm: Add binding for RPi firmware
 PWM bus
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>,
        Ray Jui <rjui@broadcom.com>, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        dmitry.torokhov@gmail.com, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        bgolaszewski@baylibre.com, sboyd@kernel.org,
        linux-gpio@vger.kernel.org, Scott Branden <sbranden@broadcom.com>,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        andy.shevchenko@gmail.com
Date:   Wed, 04 Nov 2020 20:55:19 +0100
In-Reply-To: <20201104190612.GA3959462@bogus>
References: <20201104103938.1286-1-nsaenzjulienne@suse.de>
         <20201104103938.1286-10-nsaenzjulienne@suse.de>
         <20201104190612.GA3959462@bogus>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-cU9/G+WYZ+w+iySzg6LF"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-cU9/G+WYZ+w+iySzg6LF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-04 at 13:06 -0600, Rob Herring wrote:
> On Wed, 04 Nov 2020 11:39:35 +0100, Nicolas Saenz Julienne wrote:
> > The PWM bus controlling the fan in RPi's official PoE hat can only be
> > controlled by the board's co-processor.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >=20
> > ---
> >=20
> > Changes since v1:
> >  - Update bindings to use 2 #pwm-cells
> >=20
> >  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 20 +++++++++++++++++++
> >  .../pwm/raspberrypi,firmware-pwm.h            | 13 ++++++++++++
> >  2 files changed, 33 insertions(+)
> >  create mode 100644 include/dt-bindings/pwm/raspberrypi,firmware-pwm.h
> >=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/=
bcm/raspberrypi,bcm2835-firmware.example.dt.yaml: firmware: pwm:#pwm-cells:=
0:0: 2 was expected

Yes I forgot to update the example...

Regards,
Nicolas


--=-cU9/G+WYZ+w+iySzg6LF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+jBycACgkQlfZmHno8
x/4lqwf+LNqmKYmR+D64RymsZ5v7t1WD9DkM2AcOluMdjU13iiD8I+U2KdCc2R8Y
KhH9mNARA0Kd5JtfEzifsT4G3OqWIac7V/abpwHwrS7ilQjx2gLCACaBO87JwzK0
R5uOO0FWqaEoLK5GknPO2HGn8ez34EPHU3cu4SXBBFqEnaEbEMr9cEl0ou+vdrYS
3JnsvkWGZO7LY9vh05c9I/L2pyFg1JieOLU46BYJxAPvlqeILLwWvJ0oq4iiFM7I
ZFjf/7VhrNk92HLeRMTgPt6/LuVsvnDBJXzAEknYiZt4Taa99Y11MxauWIIqAsk+
LBfmYrGtxl88K4eRkxCDzH4wnYm/qQ==
=Ei+W
-----END PGP SIGNATURE-----

--=-cU9/G+WYZ+w+iySzg6LF--

