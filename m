Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C3B1ECFE4
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2020 14:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgFCMhY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 Jun 2020 08:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCMhY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Jun 2020 08:37:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E40C08C5C0
        for <linux-pwm@vger.kernel.org>; Wed,  3 Jun 2020 05:37:23 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jgSdz-0006Sf-GZ; Wed, 03 Jun 2020 14:37:19 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jgSdy-0003Sh-Sp; Wed, 03 Jun 2020 14:37:18 +0200
Date:   Wed, 3 Jun 2020 14:37:18 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Lee Jones as reviewer for the PWM
 subsystem
Message-ID: <20200603123718.6fwsbpnkbjlpq2bz@taurus.defre.kleine-koenig.org>
References: <20200602123241.3363904-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dd6x2d6hmbajhoiw"
Content-Disposition: inline
In-Reply-To: <20200602123241.3363904-1-thierry.reding@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--dd6x2d6hmbajhoiw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2020 at 02:32:41PM +0200, Thierry Reding wrote:
> Lee has kindly offered his help in sharing the patch review workload for
> the PWM subsystem. If this works out well between Lee, Uwe and myself it
> may be a good idea to maintain the subsystem as a group.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db31497..b8889bed5d1e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13736,6 +13736,7 @@ F:	drivers/media/rc/pwm-ir-tx.c
>  PWM SUBSYSTEM
>  M:	Thierry Reding <thierry.reding@gmail.com>
>  R:	Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> +M:	Lee Jones <lee.jones@linaro.org>

I'm bit surprised that Lee got M: which I have a R:. The commit log
talks about reviewer not maintainer.

While I'm not sure that there is a practical difference it makes me a
bit sad.

Best regards
Uwe

--dd6x2d6hmbajhoiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7XmXsACgkQwfwUeK3K
7Am/Jgf/SVQaIi1ThR0VQ4yb76HNl570Bu4I9ZacE/SJEaNIQziVK/Q41pbrnBCm
aQrzTR7+ZBj+G+exXfSt2Q5zvKkZHbreafiZdvXMO+Gy+Bylq6F23lwLt+1Q1XaP
KqjCnEo/swsvJxapgiM2mR60dBnH/YfQeDElBJH233mxy6ytEbFLprOLScniXj5E
cPFtn/Lfk8P1UhO5EzAto1D6XFs05gvLIazXBt0hN6uRX25fA/BqrE0zCnUdiGLX
6dKjNjlT4cpNRogWtIysvLh5hB6pJy4/wSgQVip+pZ8aiyJErK4Tv8vy7RBovEyH
S5GIZA3YKr72mtdqV8A9cwSDLVBO0Q==
=Kcfa
-----END PGP SIGNATURE-----

--dd6x2d6hmbajhoiw--
