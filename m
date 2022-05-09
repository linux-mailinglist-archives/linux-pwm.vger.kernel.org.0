Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCC051FAAE
	for <lists+linux-pwm@lfdr.de>; Mon,  9 May 2022 13:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiEILDx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 May 2022 07:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiEILDh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 May 2022 07:03:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABA622240E
        for <linux-pwm@vger.kernel.org>; Mon,  9 May 2022 03:59:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1no16q-0004P6-99; Mon, 09 May 2022 12:59:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1no16p-001H8U-TL; Mon, 09 May 2022 12:59:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1no16n-008ZH5-C6; Mon, 09 May 2022 12:59:21 +0200
Date:   Mon, 9 May 2022 12:59:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: (EXT) Re: (EXT) Re: (EXT) Re: [PATCH v2 1/1] hwmon: pwm-fan:
 dynamically switch regulator
Message-ID: <20220509105921.wzxlapayqidnjmfl@pengutronix.de>
References: <20220504124551.1083383-1-alexander.stein@ew.tq-group.com>
 <20220506142913.vbddyvkmhuvfd5o5@pengutronix.de>
 <20220506183124.GA2997799@roeck-us.net>
 <2184650.iZASKD2KPV@steina-w>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="abezsxsgpdmdcqve"
Content-Disposition: inline
In-Reply-To: <2184650.iZASKD2KPV@steina-w>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--abezsxsgpdmdcqve
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alexander, hello Guenter,

On Mon, May 09, 2022 at 09:39:15AM +0200, Alexander Stein wrote:
> Am Freitag, 6. Mai 2022, 20:31:24 CEST schrieb Guenter Roeck:
> > On Fri, May 06, 2022 at 04:29:13PM +0200, Uwe Kleine-K=F6nig wrote:
> > > [Dropped Bartlomiej Zolnierkiewicz from Cc:; my mailer daemon claims =
the
> > > email address doens't exist.]
> > >=20
> > > Hello Guenter,
> > >=20
> > > On Fri, May 06, 2022 at 07:12:44AM -0700, Guenter Roeck wrote:
> > > > On Fri, May 06, 2022 at 02:23:11PM +0200, Alexander Stein wrote:
> > > > > Am Freitag, 6. Mai 2022, 12:23:01 CEST schrieb Uwe Kleine-K=F6nig:
> > > > > > See
> > > > > > https://lore.kernel.org/linux-pwm/20180806155129.cjcc7okmwtaujf=
43@pe
> > > > > > ngutronix.de/ for one of the previous discussions.
> > > > >=20
> > > > > Thanks for the link. I took a look into it. I'm on your side here,
> > > > > IMHO
> > > > > pwm_disable() implies that the PWM perphery is disabled, includin=
g any
> > > > > clocks or powerdomain. This is what pwm-imx27 actually does. This
> > > > > might lead to a, probably platform dependent, (undefined?) state =
of
> > > > > the PWM output pin. This implies it is not possible to disable the
> > > > > PWM periphery for inverted signals, if the disabled state is not =
the
> > > > > inactive level. You know all about it already.
> > > > > Then again from pwm-fan side I want be able to disable the FAN,
> > > > > turning of
> > > > > regulator and PWM, so powersaving is possible. That's what this p=
atch
> > > > > is
> > > > > about. This is similar also what pwm_bl is doing.
> > > > > Independent of the exact semantics, it makes sense to disable the
> > > > > regulator in pwm-fan as well when the fan shall be disabled.
> > > >=20
> > > > There are fans which never stop if pwm=3D=3D0, such as some CPU fan=
s. I
> > > > don't
> > >=20
> > > I assume with pwm=3D=3D0 you actually mean duty_cycle =3D=3D 0?
> >=20
> > Correct. The "pwm" attribute sets the duty cycle.
> >=20
> > > > think it is a good idea to force those off by turning off their pow=
er.
> > > > The
> > > > problem in the driver is that it treats pwm=3D=3D0 as "disable pwm"=
, not as
> > > > "set pwm output to 0", Part of the probem may be that the ABI doesn=
't
> > > > have
> > > > a good representation for "disable pwm output", which is what is re=
ally
> > > > wanted/needed here.
> > >=20
> > > Disable pwm output =3D=3D set pwm output to High-Z? Not all PWMs are =
able to
> > > provide that.
> >=20
> > It is up to us to define whate it means exactly. If you are ok that "set
> > duty cycle to 0" reflects "set duty cycle to 0, disable pwm, and turn o=
ff
> > regulator", I would hope that you are ok with using the _enable attribu=
te
> > to do the same and leaving pwm=3D=3D0 to do what it is supposed to do, =
ie to
> > keep pwm control enabled and set the duty cycle to 0.
>=20
> Just to make sure to be on the same side and summarize a bit. What you me=
an is=20
> to add a new sysfs attribute to pwm-fan driver which controls what pwm_du=
ty=3D=3D0=20
> implies. I would suggest to name is 'keep_pwm_enabled' (but I am open for=
=20
> other suggestions) with the following meaning:
> 1 - pwm_duty=3D=3D0 just means that. Set PWM duty to 0 and keep PWM (and =
fan=20
> regulator) enabled.
>=20
> 0 - pwm_duty=3D=3D0 means that the PWM duty is set to 0, PWM is disabled =
and any=20
> PWM fan regulator is disabled as well.

I'm not convinced. A property that is called "keep_pwm_enabled"
shouldn't have any effect on the regulator. Maybe we need two
properties, one for the PWM and one for the regulator?

> With this it is up to the administrator to provide the correct setting fo=
r=20
> this attribute as it highly depends on the actual hardware and/or usage.

I wonder if that is a devicetree (or firmware) property instead of
a sysfs knob.

A related problem is that there is no official definition for the PWM
framework what a consumer can expect from a disabled PWM, and some have
adopted the expectation "constant inactive output" as this is what
several lowlevel implementations provide.

The two obvious candidates for such an expectation are:

 a) emit the inactive level
 b) no guarantees about the output

I think there should be an explicit definition and which of them is
picked has an influence on the decision how to properly model a PWM fan.
(If you say now the design of a device tree model shouldn't depend on
what the Linux PWM framework considers as right behaviour for a disabled
PWM, you're right. But you have to have some concept of "disabled PWM"
and the thoughts to pick one definition or the other are the same, so
it's sensible to come to the same conclusion for both formally different
questions.)

I'm convinced that b) is the sane way to pick. The reasons are:

 - Some hardware cannot be disabled while emitting a constant 0 or 1.
 - There is already a way for consumers to express: I want a constant
   inactive output. (i.e. .duty_cycle =3D 0, .enabled =3D 1, .period =3D $b=
ig)

When adopting b) there is some expressiveness missing though and that
has to do with transitions to new configurations. If a PWM runs at 100%
relative duty cycle (i.e. .duty_cycle =3D=3D .period) and the consumer then
calls

	pwm_apply(mypwm, {.duty_cycle =3D 0, .period =3D 5000, .enabled =3D true })

and some time later

	pwm_apply(mypwm, {.duty_cycle =3D 5000, .period =3D 5000, .enabled =3D tru=
e })

they might expect that the PWM is low for a duration that is a multiple
of 5ms. However I think that doesn't have a practical relevance and
quite a few PWM hardware implementations cannot complete a period on a
configuration change anyhow. So I believe it's safe to disable a PWM
after

	pwm_apply(mypwm, {.duty_cycle =3D 0, .period =3D 5000, .enabled =3D true })

*iff* it provides a constant inactive output. To fix that, we'd have to
distinguish between "sync" and "async" configuration updates. However I
see no need to do that now, as it doesn't solve a real life problem.

When adopting a) however a PWM that doesn't maintain an inactive output
when disabled, must not be disabled in such a case (so we'd actually
need to do

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -280,7 +280,13 @@ static int pwm_imx27_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
 		cr |=3D FIELD_PREP(MX3_PWMCR_POUTC,
 				MX3_PWMCR_POUTC_INVERTED);
=20
-	if (state->enabled)
+	/*
+	 * When the EN bit is not set, the hardware emits a constant low output.
+	 * There is no formal definition about the right behaviour, but some
+	 * consumers expect an inactive output from a disabled PWM. So only
+	 * clear EN if normal polarity is configured.
+	 */
+	if (state->enabled || state->polarity =3D=3D PWM_POLARITY_INVERSED)
 		cr |=3D MX3_PWMCR_EN;
=20
 	writel(cr, imx->mmio_base + MX3_PWMCR);

for the imx27 case[1]). So the downside of adopting a) is that there is
no way for the lowlevel driver to know that it can safely disable the
hardware and so safe some power.

Best regards
Uwe

[1] or something more complicated. I remember a patch that switched the
    pinmuxing to GPIO that emitted a constant low output which I
    consider not being worth the power savings (if there are any).

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--abezsxsgpdmdcqve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJ49AYACgkQwfwUeK3K
7AnvMQf6AmIa5k9ADG9Nde5DVjompiQ7ozL8xAsF+76M717xxeWBW0xq4/8HdLli
OYcHBg2ZXk9yrRzPAcz0cwcjrH5jih/TWZPZ21ssf7eLXC3zrJnx8MQaUcvKsOLK
5ptdePJdLgNLHGrVSEtOlEoyYLYSrPXEqu4620jQaOrWxot77jDcgvDR8Xm65rUy
jxMnFV5uT3uCkXx2o0wHbAMEN7lSI5rUSh6QGuHXoGYgEXFRglz49BzRHQFrc1Hy
7EF56F2vWCJCbtoS16kxf8b0SXDCurbfBpvPmfn8Gkw1p9mBuAtr2UOGQ0swBnRU
DNUHdVGW+WqO9SKzD5hCjtQhH5GtWw==
=8KF+
-----END PGP SIGNATURE-----

--abezsxsgpdmdcqve--
