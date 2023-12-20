Return-Path: <linux-pwm+bounces-586-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FFF819CCC
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Dec 2023 11:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAEC42886D6
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Dec 2023 10:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544A5208A5;
	Wed, 20 Dec 2023 10:32:05 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F83208A6
	for <linux-pwm@vger.kernel.org>; Wed, 20 Dec 2023 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFtrm-0002Pj-A4; Wed, 20 Dec 2023 11:31:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFtrk-000Drv-K9; Wed, 20 Dec 2023 11:31:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFtrl-000iCd-E0; Wed, 20 Dec 2023 11:31:53 +0100
Date: Wed, 20 Dec 2023 11:31:53 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Young <sean@mess.org>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 4/6] pwm: Make it possible to apply PWM changes in
 atomic context
Message-ID: <eluxhmgxx7iwaou3t3hlqa6zvy4wpfdzcunke3kuaqtho7vjnc@cpqbb6cdsewu>
References: <cover.1703003288.git.sean@mess.org>
 <2a08b7876059f30c5c081d02978876022fa8d3ea.1703003288.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n6whed34x4el76dp"
Content-Disposition: inline
In-Reply-To: <2a08b7876059f30c5c081d02978876022fa8d3ea.1703003288.git.sean@mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--n6whed34x4el76dp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 04:30:27PM +0000, Sean Young wrote:
> Some PWM devices require sleeping, for example if the pwm device is
> connected over I2C. However, many PWM devices could be used from atomic
> context, e.g. memory mapped PWM. This is useful for, for example, the
> pwm-ir-tx driver which requires precise timing. Sleeping causes havoc
> with the generated IR signal.
>=20
> Since not all PWM devices can support atomic context, we also add a
> pwm_might_sleep() function to check if is not supported.
>=20
> Signed-off-by: Sean Young <sean@mess.org>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--n6whed34x4el76dp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWCwpgACgkQj4D7WH0S
/k6sMwgAsQlMB6EtDqYSV0EFHHcQHu8UVellCdbOyq8BbGsnDbOrbQ/q6+Xh27L0
4yZiwLJaLp7GjTimL495d4oBPkXFXGv0TTnfSF1IjU4jLwCoBDMP+Tf/LhdtkBh8
sXbAcOCYqmtsaZrq54zZSDJSVMSbL45rZHtQpETA2SUTxKXW9ko1C9+eZAeMiswa
0lnCvtujqkPFyM34n/U0F1EoMUPJomGQ/Q5wgOooh60YaF+SvYYzXi/2B4B8U/Mi
tqr+8kFbgSMgWrq5A6mAqOLgdInXQY/6JuxpolfFK8gyhdCmH1nNJLnBsxkcZO++
KIbYMF6gYo7UaMtFuFO5hQn8pJDdQw==
=MP6p
-----END PGP SIGNATURE-----

--n6whed34x4el76dp--

