Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2E228D2A1
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Oct 2020 18:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbgJMQuv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Oct 2020 12:50:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:59406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387919AbgJMQuv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 13 Oct 2020 12:50:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEF98B2F2;
        Tue, 13 Oct 2020 16:50:49 +0000 (UTC)
Message-ID: <c171c837a31dea34c845478b7c7d4bdef865b5e0.camel@suse.de>
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
Date:   Tue, 13 Oct 2020 18:50:47 +0200
In-Reply-To: <20201013121758.gl6ni4b47ei2bhdf@pengutronix.de>
References: <20201009153031.986-1-nsaenzjulienne@suse.de>
         <20201009153031.986-4-nsaenzjulienne@suse.de>
         <20201012070626.fzjhp3tkmgglqnm4@pengutronix.de>
         <7899e490543723c97ffad6f42942907f8db6b9b4.camel@suse.de>
         <20201013121758.gl6ni4b47ei2bhdf@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-QQL4Z9L5K9obB4kJlsj+"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-QQL4Z9L5K9obB4kJlsj+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Tue, 2020-10-13 at 14:17 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Nicolas,
>=20
> On Tue, Oct 13, 2020 at 01:20:00PM +0200, Nicolas Saenz Julienne wrote:
> > On Mon, 2020-10-12 at 09:06 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_=
FIRMWARE)
> > >=20
> > > This is more complicated than necessary.
> > >=20
> > > 	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
> > >=20
> > > is logically equivalent.
> >=20
> > It's not exactly the same, see patch 7ed915059c300 ("gpio: raspberrypi-=
ext: fix
> > firmware dependency ") which explains why this pattern is needed.

I'll add a comment.

> Hmm, this is strange, but if Arnd doesn't know a better solution, then
> be it so. Is this idiom usual enough to not justify a comment?
>=20
> > > What happens if duty_cycle happens to be bigger than RPI_PWM_MAX_DUTY=
?
> > >=20
> > > I think the right thing to do here is:
> > >=20
> > > 	if (state->period < RPI_PWM_PERIOD_NS ||
> >=20
> > Why not using state->period !=3D RPI_PWM_PERIOD_NS here?
>=20
> From the consumer's point of view having to hit the only correct period
> is hard. So the usual convention is to provide the biggest period not
> bigger than the requested one. (The idea for the future is to provide a
> pwm_round_state() function which allows to find out the effect of
> pwm_apply_state() with the same arguments. This then allows to
> efficiently find the best setting for the consumer.)

Fair enough.

> > > Huh, why do you have to do this twice, just with different error
> > > messages? I assume you want to set RPI_PWM_DEF_DUTY_REG? What is the
> > > effect of writing this property?
> >=20
> > Obviously, I failed to change the register name.
> >=20
> > This is supposed to set the default duty cycle after resetting the boar=
d. I
> > added it so as to keep compatibility with the downstream version of thi=
s.
> >=20
> > I'll add a comment to explain this.
>=20
> fine.
>=20
> > > > +	int ret;
> > > > +
> > > > +	firmware_node =3D of_get_parent(dev->of_node);
> > > > +	if (!firmware_node) {
> > > > +		dev_err(dev, "Missing firmware node\n");
> > > > +		return -ENOENT;
> > > > +	}
> > > > +
> > > > +	firmware =3D rpi_firmware_get(firmware_node);
> > > > +	of_node_put(firmware_node);
> > > > +	if (!firmware)
> > > > +		return -EPROBE_DEFER;
> > >=20
> > > I don't see a mechanism that prevents the driver providing the firmwa=
re
> > > going away while the PWM is still in use.
> >=20
> > There isn't an explicit one. But since you depend on a symbol from the =
firmware
> > driver you won't be able to remove the kernel module before removing th=
e PMW
> > one.
>=20
> this prevents the that the module is unloaded, but not that the driver
> is unbound.

Yes, if you were to unbind the firmware device all devices that depend on i=
t
(there are a bunch of them) would access freed memory. Yet again, there is =
no
hotplug functionality, so short of being useful for development it'd be ver=
y
rare for someone to unbind it. We've been living with it as such for a long
time. Not to say that is something not to fix, but from my perspective it's
just a corner-case.

We are using 'simple-mfd' in order to probe all devices under the
firmware interface, so my first intuition would be to add support for
automatically unbinding of consumer devices in of/platform.c. See:

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b557a0fcd4ba..d24f2412d518 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -390,7 +390,13 @@ static int of_platform_bus_create(struct device_node *=
bus,
        }
=20
        dev =3D of_platform_device_create_pdata(bus, bus_id, platform_data,=
 parent);
-       if (!dev || !of_match_node(matches, bus))
+       if (!dev)
+               return 0;
+
+       if (parent && of_device_is_compatible(parent->of_node, "simple-mfd"=
))
+               device_link_add(&dev->dev, parent, DL_FLAG_AUTOREMOVE_CONSU=
MER);
+
+       if (!of_match_node(matches, bus))
                return 0;
=20
        for_each_child_of_node(bus, child) {

If this is too much for OF maintainers, we could simply create the link upo=
n
calling rpi_firmware_get().

This solves the problem of getting a kernel panic because of the use after
free, but you'll still get some warnings after unbinding from the GPIO
subsystem, for example, as we just removed a gpiochip that still has consum=
ers
up. I guess device links only go so far.

Any ideas/comments?

Regards,
Nicolas


--=-QQL4Z9L5K9obB4kJlsj+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+F2ucACgkQlfZmHno8
x/4aKQf+OCDTj2+VaoKNpvJzA4yuSworog5ZQ/I2NeExhZZbxPTs2V2Y/HGEHegl
n3ejX6yJGqpUsWoeqy5XXDVJhnPSfBTQRWjwzipuI6vUX0PLtJCW9GW5awPc1sTm
NF2NOFeM0WNPaodHNqzT6JXRbYRRx1EN3NzdfMX89NZ+cx0fQSQBzeXSlqhIWvlC
rEfGZD3hMMHr/NXzomTPgIp1Wgtq9VRcSs/gGvOzaxYqqSUKrBZf1mnMhwcM5Byb
KHUJW+hIyCRiTUHrUGItXhRZK3lRHxZDbEN46T8HmtrV6cCRaFTCU2ozTALD47Mn
CdvAxBZhwALSZ4+AfjB/JwB2C/HfOA==
=DfAb
-----END PGP SIGNATURE-----

--=-QQL4Z9L5K9obB4kJlsj+--

