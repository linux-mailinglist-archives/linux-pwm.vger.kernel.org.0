Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6E028CC63
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Oct 2020 13:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgJMLUF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Oct 2020 07:20:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:35502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgJMLUF (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 13 Oct 2020 07:20:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A789CAD63;
        Tue, 13 Oct 2020 11:20:02 +0000 (UTC)
Message-ID: <7899e490543723c97ffad6f42942907f8db6b9b4.camel@suse.de>
Subject: Re: [PATCH 3/3] pwm: Add Raspberry Pi Firmware based PWM bus
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     f.fainelli@gmail.com, linux@roeck-us.net, jdelvare@suse.com,
        wahrenst@gmx.net, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 13 Oct 2020 13:20:00 +0200
In-Reply-To: <20201012070626.fzjhp3tkmgglqnm4@pengutronix.de>
References: <20201009153031.986-1-nsaenzjulienne@suse.de>
         <20201009153031.986-4-nsaenzjulienne@suse.de>
         <20201012070626.fzjhp3tkmgglqnm4@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-OiKdwt0rO7oat8pdUQ+i"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-OiKdwt0rO7oat8pdUQ+i
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Mon, 2020-10-12 at 09:06 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Fri, Oct 09, 2020 at 05:30:30PM +0200, Nicolas Saenz Julienne wrote:
> > Adds support to control the PWM bus available in official Raspberry Pi
> > PoE HAT. Only RPi's co-processor has access to it, so commands have to
> > be sent through RPi's firmware mailbox interface.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  drivers/pwm/Kconfig           |   7 ++
> >  drivers/pwm/Makefile          |   1 +
> >  drivers/pwm/pwm-raspberrypi.c | 216 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 224 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-raspberrypi.c
> >=20
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 63be5362fd3a..a76997ca37d0 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -379,6 +379,13 @@ config PWM_PXA
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-pxa.
> > =20
> > +config PWM_RASPBERRYPI
> > +	tristate "Raspberry Pi Firwmware PWM support"
>=20
> s/Firwmware/Firmware/

Noted, Sorry for that.

>=20
> > +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRM=
WARE)
>=20
> This is more complicated than necessary.
>=20
> 	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
>=20
> is logically equivalent.

It's not exactly the same, see patch 7ed915059c300 ("gpio: raspberrypi-ext:=
 fix
firmware dependency ") which explains why this pattern is needed.

[...]

> > +static int raspberrypi_pwm_apply(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> > +			         const struct pwm_state *state)
> > +{
> > +	struct raspberrypi_pwm *pc =3D to_raspberrypi_pwm(chip);
> > +	unsigned int duty_cycle;
> > +	int ret;
> > +
>=20
> You need to check for polarity here.
>=20
> > +	if (!state->enabled)
> > +		duty_cycle =3D 0;
> > +	else
> > +		duty_cycle =3D state->duty_cycle * RPI_PWM_MAX_DUTY /
> > +			     RPI_PWM_PERIOD_NS;
> > +
> > +	if (duty_cycle =3D=3D pc->duty_cycle)
> > +		return 0;
> > +
> > +	pc->duty_cycle =3D duty_cycle;
> > +	ret =3D raspberrypi_pwm_set_property(pc->firmware, RPI_PWM_CUR_DUTY_R=
EG,
> > +					   pc->duty_cycle);
> > +	if (ret) {
> > +		dev_err(chip->dev, "Failed to set duty cycle: %d\n", ret);
> > +		return ret;
> > +	}
>=20
> What happens if duty_cycle happens to be bigger than RPI_PWM_MAX_DUTY?
>=20
> I think the right thing to do here is:
>=20
> 	if (state->period < RPI_PWM_PERIOD_NS ||

Why not using state->period !=3D RPI_PWM_PERIOD_NS here?

> 	    state->polarity !=3D PWM_POLARITY_NORMAL)
> 		return -EINVAL;
>=20
> 	if (!state->enabled)
> 		duty_cycle =3D 0
> 	else if (state->duty_cycle < RPI_PWM_PERIOD_NS)
> 		duty_cycle =3D state->duty_cycle * RPI_PWM_MAX_DUTY / RPI_PWM_PERIOD_NS=
;
> 	else
> 		duty_cycle =3D RPI_PWM_MAX_DUTY;
>=20
> 	ret =3D raspberrypi_pwm_set_property(pc->firmware, RPI_PWM_CUR_DUTY_REG,
> 					   pc->duty_cycle);
> 	if (ret)
> 		...
>=20
> 	pc->duty_cycle =3D duty_cycle;

OK, clearly better this way.

> > +
> > +	ret =3D raspberrypi_pwm_set_property(pc->firmware, RPI_PWM_CUR_DUTY_R=
EG,
> > +					   pc->duty_cycle);
> > +	if (ret) {
> > +		dev_err(chip->dev, "Failed to set default duty cycle: %d\n", ret);
> > +		return ret;
> > +	}
>=20
> Huh, why do you have to do this twice, just with different error
> messages? I assume you want to set RPI_PWM_DEF_DUTY_REG? What is the
> effect of writing this property?

Obviously, I failed to change the register name.

This is supposed to set the default duty cycle after resetting the board. I
added it so as to keep compatibility with the downstream version of this.

I'll add a comment to explain this.

[...]

> > +	pwm->args.period =3D RPI_PWM_PERIOD_NS;
> > +
> > +	return pwm;
> > +}
>=20
> I think you don't need this function. Just fix up period in .apply().

As commented in the dt binding patch, I'll do that.

> > +static int raspberrypi_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *firmware_node;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct rpi_firmware *firmware;
> > +	struct raspberrypi_pwm *pc;
>=20
> What does "pc" stand for? I'd have used "rpipwm" or something similar.

It was cargo culted from other pwm drivers, I saw it being used on more tha=
n
one and figured it was the preferred way of naming things. I'll change it.
>=20
> > +	int ret;
> > +
> > +	firmware_node =3D of_get_parent(dev->of_node);
> > +	if (!firmware_node) {
> > +		dev_err(dev, "Missing firmware node\n");
> > +		return -ENOENT;
> > +	}
> > +
> > +	firmware =3D rpi_firmware_get(firmware_node);
> > +	of_node_put(firmware_node);
> > +	if (!firmware)
> > +		return -EPROBE_DEFER;
>=20
> I don't see a mechanism that prevents the driver providing the firmware
> going away while the PWM is still in use.

There isn't an explicit one. But since you depend on a symbol from the firm=
ware
driver you won't be able to remove the kernel module before removing the PM=
W
one.

> > +	pc =3D devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> > +	if (!pc)
> > +		return -ENOMEM;
> > [...]
> > +
> > +static struct platform_driver raspberrypi_pwm_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "raspberrypi-pwm",
> > +		.of_match_table =3D raspberrypi_pwm_of_match,
> > +	},
> > +	.probe =3D raspberrypi_pwm_probe,
> > +	.remove =3D raspberrypi_pwm_remove,
> > +};
> > +module_platform_driver(raspberrypi_pwm_driver);
> > +
> > +MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de>");
> > +MODULE_DESCRIPTION("Raspberry Pi Firwmare Based PWM Bus Driver");
> > +MODULE_LICENSE("GPL v2");
> > +
>=20
> Please drop the empty line at the end of file.

Overall I took note of your comments and I'll make the changes. Thanks for =
the
review.

Regards,
Nicolas


--=-OiKdwt0rO7oat8pdUQ+i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+FjWAACgkQlfZmHno8
x/7K5wf+LfTt5gyeBLCbVfp1YC5NRRzKVCfKysmTlFuVKXFnBzTvzeNI14fs5CJJ
ImJ1cxZe+mDe4wPfhCn47GCMRODKq+ZUbv4CfZiX741bD6uoLvGDji8aOBPAFyuG
eRlPQnuqvcp608Cw1SR7V+iiu/qhRRmJp0t+rqaqhB2xafRNVqC834YJk06IqWxh
csHePogj4uusMUiUdIlMdqiTqZOSb3FH8ooz6cmDdI3j8wegdLu49M/yF3NyupZD
9uA0mG13jPpa9DgJo3got8fxHCB+jgEMk15hgW8y3Dby33jG2QGa30mVT0EPShk3
B6Lpzej5ewWX3d0XPvqPGeAyTo64iQ==
=aBTt
-----END PGP SIGNATURE-----

--=-OiKdwt0rO7oat8pdUQ+i--

