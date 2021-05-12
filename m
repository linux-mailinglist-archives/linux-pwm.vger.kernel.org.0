Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0F837B525
	for <lists+linux-pwm@lfdr.de>; Wed, 12 May 2021 06:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhELExk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 May 2021 00:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhELExj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 May 2021 00:53:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B9BC061574
        for <linux-pwm@vger.kernel.org>; Tue, 11 May 2021 21:52:31 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lggrA-0000v7-TQ; Wed, 12 May 2021 06:52:24 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lggr8-0000Sr-Fo; Wed, 12 May 2021 06:52:22 +0200
Date:   Wed, 12 May 2021 06:52:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH -next] pwm: img: Fix PM reference leak in img_pwm_enable()
Message-ID: <20210512045222.2yjm6yxikznohlmn@pengutronix.de>
References: <1620791837-16138-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="imgrom7jqz4bbh57"
Content-Disposition: inline
In-Reply-To: <1620791837-16138-1-git-send-email-zou_wei@huawei.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--imgrom7jqz4bbh57
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, May 12, 2021 at 11:57:17AM +0800, Zou Wei wrote:
> pm_runtime_get_sync will increment pm usage counter even it failed.
> Forgetting to putting operation will result in reference leak here.
> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> counter balanced.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/pwm/pwm-img.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> index cc37054..11b16ec 100644
> --- a/drivers/pwm/pwm-img.c
> +++ b/drivers/pwm/pwm-img.c
> @@ -156,7 +156,7 @@ static int img_pwm_enable(struct pwm_chip *chip, stru=
ct pwm_device *pwm)
>  	struct img_pwm_chip *pwm_chip =3D to_img_pwm_chip(chip);
>  	int ret;
> =20
> -	ret =3D pm_runtime_get_sync(chip->dev);
> +	ret =3D pm_runtime_resume_and_get(chip->dev);
>  	if (ret < 0)
>  		return ret;

This patch looks right with my limited understanding of pm_runtime. A
similar issue in this driver was fixed in commit

	ca162ce98110 ("pwm: img: Call pm_runtime_put() in pm_runtime_get_sync() fa=
iled case")

where (even though the commit log talks about pm_runtime_put()) a call
to pm_runtime_put_autosuspend() was added in the error path.

I added the PM guys to Cc, maybe they can advise about the right thing
to do here. Does it make sense to use the same idiom in both
img_pwm_enable() and img_pwm_config()?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--imgrom7jqz4bbh57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCbXwEACgkQwfwUeK3K
7AlCPwgAkM9Sh0ifE0Y5Eu35Z8CC/bngNLYdoDyE+ULVT9SN/bbSKOP8eYYNEy8D
yo+SqECIwLflbocvxUkWb1s3cdFgn+zeOJ3uEtXT7NwQ6Fv0ke/nGh3iNjDAKkUI
pPhhizrOwzC3ODTpUIN6CN+MH1wlK9ArPipN/RyEeJbUVv7R5AaI7i5u7N8N3iFh
HBGw+9Ir0zIgxb2mvxobd/If4jeXHvQaubKrNcf5mRuE+0cWib5VpGz5jIsYEnyo
vozif4bqSYUHEo83z6aNz1kNFjKR/iqI+wkw16466GzpJzFHZfCDorWALMvlVBjT
uSjVEW901G1gZOhRU4LjDypcdYVLQw==
=RcVx
-----END PGP SIGNATURE-----

--imgrom7jqz4bbh57--
