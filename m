Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25833CCCE8
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2019 23:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbfJEVzg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Oct 2019 17:55:36 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:53690 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJEVzg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Oct 2019 17:55:36 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 2333E7E1101; Sat,  5 Oct 2019 23:55:34 +0200 (CEST)
Date:   Sat, 5 Oct 2019 23:55:26 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     linux-pwm@vger.kernel.org
Subject: Re: pwm: Let pwm_get_state() return the last implemented state
 (01ccf903edd65f6421612321648fa5a7f4b7cb10)
Message-ID: <20191005215526.GA11705@taurus.defre.kleine-koenig.org>
References: <CANBLGcyvpxWDxjpBrKDTySgUXGYFdn66O6_2jv-W5+RYd=n3pg@mail.gmail.com>
 <d959e6d0-c727-5c1d-b554-9306eba7f9ca@kleine-koenig.org>
 <CANBLGcx9jf+QDzrwgRdpn3L9__zPgEuCE=i3Qx1PEvs5JuEDgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <CANBLGcx9jf+QDzrwgRdpn3L9__zPgEuCE=i3Qx1PEvs5JuEDgA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Emil,

On Sat, Oct 05, 2019 at 11:26:35PM +0200, Emil Renner Berthing wrote:
> On Sat, 5 Oct 2019 at 21:53, Uwe Kleine-K=F6nig <uwe@kleine-koenig.org> w=
rote:
> > On 10/5/19 9:37 PM, Emil Renner Berthing wrote:
> > > My Chromebook Plus (rk3399-gru-kevin) doesn't display anything when
> > > running 5.4-rc1 unless I revert this patch. It controls the backlight
> > > through the cros-ec-pwm, so I'm guessing cros_ec_pwm_get_state doesn't
> > > behave in way compatible with the backlight :/
> >
> > Can you interact with the machine even without backlight? If so adding
> > some printk to the cros-ec-pwm driver would be great.
> >
> > I suggest to print period, duty_cycle and enabled at the start of
> > cros_ec_pwm_apply() and at the end of cros_ec_pwm_get_state().
> >
> > If you'd then report your results with and without
> > 01ccf903edd65f6421612321648fa5a7f4b7cb10 reverted to the pwm-list
> > (linux-pwm@vger.kernel.org) in Cc: that would be great.
>=20
> Sure. It seems cros_ec_pwm_get_state sets duty_cycle =3D 0. Here are the
> relevant differences between a kernel with and without the revert:
> http://ix.io/1XIU/diff
>=20
> If you want to reproduce the debug patch is here:
> http://ix.io/1XIW/diff

Hmm, this provides less information than my suggestion. Anyhow, I think
the problem is related to the fact that after:

	pwm_apply_state(pwm, { .period =3D 65535, .duty_cycle =3D 12075, .enabled =
=3D false })

pwm_get_state reports .duty_cycle =3D 0 (which IMHO is fine, not sure
Thierry agrees though). But I fail to see the details. The consumer is
drivers/video/backlight/pwm_bl.c, isn't it?

Does the following debug patch help?:

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 449ba161877d..9b9289d533de 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -478,7 +478,7 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_=
state *state)
 		 * .apply might have to round some values in *state, if possible
 		 * read the actually implemented value back.
 		 */
-		if (chip->ops->get_state)
+		if (state.enabled && chip->ops->get_state)
 			chip->ops->get_state(chip, pwm, &pwm->state);
 		else
 			pwm->state =3D *state;

If not I think this means that your pwm's .get_state() is broken.

It would be helpful to see which parameters were actually applied by the
consumer and what the .get_state callback does with them. So can you
please adapt your patch to print at the start of cros_ec_pwm_apply() and
at the end of cros_ec_pwm_get_state()?

Best regards
Uwe

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl2ZEUsACgkQwfwUeK3K
7AmGeAf+ON1b+CfjK2MY0QYWQWQBsielZvuTHGFygWXEHfhwOWJUOMStvpDLjLsp
TE44Y4t9hY+PquI1FA4JFYv8LdXakmIiiX2ssUdLA5DubwpNJ5zkYblxvjt3aQAq
NsWmD+Dkbsr0TqTkU+N+2DzQPTOJZrSZj7r3GDc5qGTqAjQkvbvw69TjSAx1UIUw
Vi/bx0Sp0rJFGY05s9CbD25fZdgQq9SKlkUcXK8aIM3Q+LNA4+ny80umGvuROInL
t3AaAr57Psq5ZZvju4IUeq0foooTSFYlJ9lPAmgboAtxVz06lbhhN6OtzSotmpf0
znbSAQhbhiWLstsTX10Y/7FFYXjAjA==
=6Rm1
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
