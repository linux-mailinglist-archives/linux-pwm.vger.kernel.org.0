Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2FD205501
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2020 16:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbgFWOlX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Jun 2020 10:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbgFWOlV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Jun 2020 10:41:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EFCC061573
        for <linux-pwm@vger.kernel.org>; Tue, 23 Jun 2020 07:41:20 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jnk6m-00043q-NL; Tue, 23 Jun 2020 16:41:08 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jnk6j-0000GH-Mh; Tue, 23 Jun 2020 16:41:05 +0200
Date:   Tue, 23 Jun 2020 16:41:05 +0200
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
Subject: Re: [RESEND PATCH V13 3/3] Input: new da7280 haptic driver
Message-ID: <20200623144105.mxhcrtezbghjb2vb@taurus.defre.kleine-koenig.org>
References: <cover.1592221223.git.Roy.Im@diasemi.com>
 <135761fd309eb9424faeb631b6e6c66147b57666.1592221223.git.Roy.Im@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sap42vwa5imj2ksw"
Content-Disposition: inline
In-Reply-To: <135761fd309eb9424faeb631b6e6c66147b57666.1592221223.git.Roy.Im@diasemi.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sap42vwa5imj2ksw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jun 15, 2020 at 08:40:23PM +0900, Roy Im wrote:
> Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with
> multiple mode and integrated waveform memory and wideband support.
> It communicates via an I2C bus to the device.
>=20
> Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

Just some picky comments below.

> +	error =3D pwm_apply_state(haptics->pwm_dev, &state);
> +	if (error)
> +		dev_err(haptics->dev,
> +			"failed to apply pwm state: %pE\n",
> +			ERR_PTR(error));

You can save some horizontal space here by dropping the \n after the
first comma. (There are a few more occurences.)

> +	return error;
> +}
> +[...]
> +
> +		/* Sync up PWM state and ensure it is off. */
> +		pwm_init_state(haptics->pwm_dev, &state);
> +		state.enabled =3D false;
> +		error =3D pwm_apply_state(haptics->pwm_dev, &state);
> +		if (error) {
> +			dev_err(dev,
> +				"failed to apply initial PWM state: %pE\n",
> +				ERR_PTR(error));
> +			return error;
> +		}
> +
> +		/* Check PWM Period, it must be in 10k ~ 250kHz */

The unit of a PWM period is in (nano)seconds, to it cannot be in the
range [10kHz, 250kHz]. (Is this too picky?)

> +		period2freq =3D 1000000 / state.period;
> +		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
> +		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
> +			dev_err(dev, "Not supported PWM frequency(%d)\n",
> +				period2freq);

Doesn't the compiler warn here about period2freq being unsigned and %d
being for signed int values?

For my (non-native) English ear s/Not supported/Unsupported/ sounds
better. Also my eyes would be pleases by a space before the opening
brace.

> +			return -EINVAL;
> +		}
> +	}
> +
> +
> +[...]
> +static struct i2c_driver da7280_driver =3D {
> +	.driver	=3D {
> +		.name		=3D "da7280",
> +		.of_match_table	=3D of_match_ptr(da7280_of_match),
> +		.pm		=3D &da7280_pm_ops,

I don't like alignment of =3D, but I'm aware this is a subjective thing.
(The reason for me is that adding a new member that is longer than the
already existing requires touching all lines. So I stick to a single
space before a =3D.)

> +	},
> +	.probe	  =3D da7280_probe,
> +	.id_table =3D da7280_i2c_id,
> +};
> +module_i2c_driver(da7280_driver);
> +
> +MODULE_DESCRIPTION("DA7280 haptics driver");
> +MODULE_AUTHOR("Roy Im <Roy.Im.Opensource@diasemi.com>");
> +MODULE_LICENSE("GPL");
> --=20
> end-of-patch for RESEND PATCH V13

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sap42vwa5imj2ksw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7yFH4ACgkQwfwUeK3K
7AkzyQgAinqodG7O9W0MXAaThAuQIllst+boEpiHowQfbTKPWIfhEtcsGoBNoQvb
hySvg0WAH6jI6LNsfnM2uIabLaPjC9mVIFyG0YU2g4ulASEOrOSqZrxCGEJxZPEi
57o7NJCw7RaXvH/QGP0zg/+NP0o/kWZlr6GFP/ZPBi5/Xa7Nonqws+DRNjPzdN9v
pKhKf6QJhNTQuVCn6an+Uo9kl4F28kvx4DLDfW3ljZC+g+1PH/4uZi9iNy83V8Uo
XlY6hqJ3b70fotLm2Oo7chj3dPAeerkxx5mezIQpgidqqct2PcPzfUbPx+xPBm59
tZsRyjSeuO9u/M3kgOBYaKTPWQb8oQ==
=j9ju
-----END PGP SIGNATURE-----

--sap42vwa5imj2ksw--
