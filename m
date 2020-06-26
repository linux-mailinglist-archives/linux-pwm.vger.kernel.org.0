Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365D020AC35
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2020 08:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgFZGTK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 26 Jun 2020 02:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgFZGTK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 26 Jun 2020 02:19:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F243C08C5DB
        for <linux-pwm@vger.kernel.org>; Thu, 25 Jun 2020 23:19:10 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1johhR-0001r4-L1; Fri, 26 Jun 2020 08:18:57 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1johhN-00015J-AA; Fri, 26 Jun 2020 08:18:53 +0200
Date:   Fri, 26 Jun 2020 08:18:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Roy Im <roy.im.opensource@diasemi.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v14 3/3] Input: new da7280 haptic driver
Message-ID: <20200626061853.hyb7dwta6ths2qo2@taurus.defre.kleine-koenig.org>
References: <cover.1593017969.git.Roy.Im@diasemi.com>
 <8b05f5bd46eac415c628e965f59b2b57aff86bbe.1593017969.git.Roy.Im@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l5lbv7flvyngebwk"
Content-Disposition: inline
In-Reply-To: <8b05f5bd46eac415c628e965f59b2b57aff86bbe.1593017969.git.Roy.Im@diasemi.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--l5lbv7flvyngebwk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

=66rom the PWM POV I'm happy now. Just a few minor comments that I noticed
while checking the PWM details.

On Thu, Jun 25, 2020 at 01:59:29AM +0900, Roy Im wrote:
> +		val =3D haptics->ps_seq_id << DA7280_PS_SEQ_ID_SHIFT |
> +			haptics->ps_seq_loop << DA7280_PS_SEQ_LOOP_SHIFT;

If you write this as:

	val =3D FIELD_PREP(DA7280_PS_SEQ_ID_MASK, haptics->ps_seq_id) |
		FIELD_PREP(DA7280_PS_SEQ_LOOP_MASK, haptics->ps_seq_loop);

you get some additional checks for free and can drop all defines for ..._SH=
IFT .

> +static u8 da7280_haptic_of_gpi_pol_str(struct device *dev,
> +				       const char *str)
> +{
> +	if (!strcmp(str, "Rising-edge"))
> +		return 0;
> +	else if (!strcmp(str, "Falling-edge"))
> +		return 1;
> +	else if (!strcmp(str, "Both-edge"))
> +		return 2;
> +
> +	dev_warn(dev, "Invalid string - set to default\n");

Maybe mention "Rising-edge" being the default?

> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--l5lbv7flvyngebwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl71k0oACgkQwfwUeK3K
7AkjFwgAldH3KRBxt3eudCHkipnw7VuyQf7SQOeIBpqehW+F0UEblbR8l96xgv/G
8wzR4sL28wQuPpDxs7zvvqaN3H6JakX+BIL/9yIAtBh1LCGca01s8peLC9EhuYac
zFtc97/+fEmhjqjMmeyThz8s+uy3C7mO3rjaQODNsW9ZhD8XmmFuvwyI4//0uF55
uVEn36SrwI7Osmy16vKWluKpuk+d1b8otenjJq9uLJW6ACSQrCv+YTZzrmVBqTyY
OCPVLOXtYhSUlQLNkwa95ENVA4h/ZzRG5qs139nfo9H3aqDaz62dJ5iYbdrdri0U
0B/l+NTYigDURR4k4KErR4u3aQfMVw==
=zSqA
-----END PGP SIGNATURE-----

--l5lbv7flvyngebwk--
