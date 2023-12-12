Return-Path: <linux-pwm+bounces-532-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B8980EAC9
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 12:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4521F21E38
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E155C09D;
	Tue, 12 Dec 2023 11:48:19 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FB8C3
	for <linux-pwm@vger.kernel.org>; Tue, 12 Dec 2023 03:48:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD1FF-0006p6-5q; Tue, 12 Dec 2023 12:48:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD1FE-00FKLC-PE; Tue, 12 Dec 2023 12:48:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD1FE-001bJi-Fs; Tue, 12 Dec 2023 12:48:12 +0100
Date: Tue, 12 Dec 2023 12:48:12 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Young <sean@mess.org>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/6] pwm: Make it possible to apply PWM changes in
 atomic context
Message-ID: <20231212114812.afzgjiunzc6druov@pengutronix.de>
References: <cover.1702369869.git.sean@mess.org>
 <57f48330eb606356e86be17f85253f0e3d6ab104.1702369869.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wotwwsshk5kuseg6"
Content-Disposition: inline
In-Reply-To: <57f48330eb606356e86be17f85253f0e3d6ab104.1702369869.git.sean@mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--wotwwsshk5kuseg6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Tue, Dec 12, 2023 at 08:34:03AM +0000, Sean Young wrote:
> +/**
> + * pwm_apply_might_sleep() - atomically apply a new state to a PWM device
> + * Cannot be used in atomic context.
> + * @pwm: PWM device
> + * @state: new state to apply
> + */
> +int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state=
 *state)
> +{
> +	int err;
> +
> +	/*
> +	 * Some lowlevel driver's implementations of .apply() make use of
> +	 * mutexes, also with some drivers only returning when the new
> +	 * configuration is active calling pwm_apply_might_sleep() from atomic =
context
> +	 * is a bad idea. So make it explicit that calling this function might
> +	 * sleep.
> +	 */
> +	might_sleep();
> +
> +	if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm->chip->atomic) {
> +		/*
> +		 * Catch any drivers that have been marked as atomic but
> +		 * that will sleep anyway.
> +		 */
> +		non_block_start();
> +		err =3D pwm_apply_unchecked(pwm, state);
> +		non_block_end();
> +	} else {
> +		err =3D pwm_apply_unchecked(pwm, state);
> +	}
> +
>  	/*
>  	 * only do this after pwm->state was applied as some
>  	 * implementations of .get_state depend on this
>  	 */
> -	pwm_apply_debug(pwm, state);
> +	if (!err)
> +		pwm_apply_debug(pwm, state);

It's easier to keep that in pwm_apply_unchecked(), isn't it? Then
pwm_apply_atomic() also benefits from the checks.

I'm not so happy with the function name of pwm_apply_unchecked(), but I
don't have a good suggestion either. Probably I'd have chosen
__pam_apply(), but that's probably subjective.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wotwwsshk5kuseg6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV4SHsACgkQj4D7WH0S
/k74ygf/d/ALSfb+yMsRUGqLtZbQ7QFlbxZ7Xdahj4u3XgKiwSJwV5WlK8qFsm0T
Pd7U8STpUt+HJggcHMTOmPYd18XmSZOkX86VPlDLbVFXAGTE9jpy15ll9VLw5vFm
AqBdeFm81hYOkHvi+9oEkaw6kXhRNlLoGmpxkhWkW7RE2lx+M7I9C/KghvfSJiss
o77C2/Ak8dhPq1b0c9Nc5DsFQ02QZ7QTujr/eAbPPhmDNv188GKlA7AzTBaGdzEd
pP01de0tkFB/DDJRsD64YZ2T7UOzzv4RlQGtNVokEpxG8UYLpqhfC5SPjt02Slqz
AgOY1Y5o7nXSqD6vq9KIFUL7kezbNA==
=rd9i
-----END PGP SIGNATURE-----

--wotwwsshk5kuseg6--

