Return-Path: <linux-pwm+bounces-170-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8482F7F5CFB
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 11:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F08428198E
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D24224FB;
	Thu, 23 Nov 2023 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9DAD4E
	for <linux-pwm@vger.kernel.org>; Thu, 23 Nov 2023 02:54:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r67Lg-0005tS-D0; Thu, 23 Nov 2023 11:54:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r67Lf-00B1G5-A9; Thu, 23 Nov 2023 11:54:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r67Lf-006a4L-0i; Thu, 23 Nov 2023 11:54:19 +0100
Date: Thu, 23 Nov 2023 11:54:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Kees Cook <keescook@chromium.org>, linux-pwm@vger.kernel.org,
	Luca Weiss <luca@z3ntu.xyz>,
	Conor Dooley <conor.dooley@microchip.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Pavel Machek <pavel@ucw.cz>, kernel@pengutronix.de,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 102/108] leds: qcom-lpg: Make use of
 devm_pwmchip_alloc() function
Message-ID: <20231123105418.lbfv3ekqcfauaghb@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-103-u.kleine-koenig@pengutronix.de>
 <20231122115621.GK173820@google.com>
 <20231122175413.5yxsdveausehkbgm@pengutronix.de>
 <20231123102111.GB1184245@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p3uw5y4nbds3tzq2"
Content-Disposition: inline
In-Reply-To: <20231123102111.GB1184245@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--p3uw5y4nbds3tzq2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lee,

On Thu, Nov 23, 2023 at 10:21:11AM +0000, Lee Jones wrote:
> On Wed, 22 Nov 2023, Uwe Kleine-K=F6nig wrote:
> > Would you like it better then?
>=20
> It's definitely nicer to read and more in-line with the style I expect,
> but the additional wrapper/abstraction layer is still bothersome.

I guess that's subjective because I think having a separate pwm private
data struct is nice. I don't see an immediate advantage for the
leds-qcom-lpg driver, but the ti-sn65dsi86 driver could move some
members of the parent driver to the pwm specific struct.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--p3uw5y4nbds3tzq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVfL1oACgkQj4D7WH0S
/k7UIwf/dVRPC/5UHRtiCnEXPkxbaOWjp7WB+ob2Aoq2H3CFubhrKyaCqe4MWdBn
oS+vGQyjSjGg+yDhsreDmBVCP/kiNn7FnIsSGDAdSjKQbtq6o2GU6nRcUaGrUAes
lxW6LKinsPb4YvyGUB3M5mgVdXjp3A01yVwTIura04FvW4YsvlFaXq7e5EtFL/J3
TU5VuZLaAcy7yg0R9LEGu+k+8usfsXYEV007FewMm/RudztnuXTljI1/Ub/zyIY/
RiM600NH9USRYI3oDCphBSbfWP/WgPSyDmNC6g93NH1yGiSv3VOVGyMq9BEKGCTe
63yhVn5Npvw1LgGLztkFXHSxAeLx7w==
=SdzC
-----END PGP SIGNATURE-----

--p3uw5y4nbds3tzq2--

