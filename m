Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF750454AEB
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Nov 2021 17:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhKQQ2h (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Nov 2021 11:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbhKQQ2h (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Nov 2021 11:28:37 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A74AC061570
        for <linux-pwm@vger.kernel.org>; Wed, 17 Nov 2021 08:25:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso2607311wmf.0
        for <linux-pwm@vger.kernel.org>; Wed, 17 Nov 2021 08:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CEeit3L3Kh1t5Es54Y0pNk6ANTRLcmXL1yPc2tbf8OM=;
        b=i2XxErj6w8NxHl9oa2JJVTQZ6b+EzZto1RvSNYRBEk0t2L/JbEANPLZhoQwqvy6Ts6
         8JzBT5jqIflRxXwGiHFg9wB9KqyxdK2xaQ2RyfzIANFlSx+c3h3dZkgpADMvEAderrDm
         r4dl8zCMtq+Rx+zTjgRr7iBdWxZw6BO+5OUhzozkFOGpcDp4+dNz2o5z1bnbdWv/Mauj
         YKnYo5yyD4vTX0+NiI9usZ3eGu2sW3xgLsQwQOxY4GEslYlbdGfXtQN1yNYK+QnILuPi
         jHPXpGQzhVdBAWkSh45gbvS64JPFOWcQv66OoC7t1HedTZOr9zVTcsHeuHCvv2VYFwz2
         i1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CEeit3L3Kh1t5Es54Y0pNk6ANTRLcmXL1yPc2tbf8OM=;
        b=jpJkoPzi41V+/4y/v2xsBEuBn67Oa/Tk+dNywgMQx2JT/W7gSobdXs0tuuLHW03JOO
         uH6Gt28LbgLg863S88zUb7kZeYWFBEk0dah1yCoIxlaR1SbKoZI0U4OvOgaD5RK2sVGR
         BIWlB8n4nFP4qdyqzqy+PuCTZez1Q86qXjnxp/VJInjtkftw3GtOJN12lGk9ZyddWNHf
         q5ApzuwEmAtnHVPoHXabbSZuKkneYysi86cF8FMv5sxZ/yMnVoYp33J3CvfD5HNMVn9F
         2dsl7tjs64VsQXnOWYxOAYwWwy+ucnsHHmfIllp2okWF/Gje3Rs6WX0t394JsEvyD4V1
         UuHA==
X-Gm-Message-State: AOAM531DZmVPLz0kVqJdkOeYUsIfOFzGDeIS896PlVOEksHoEYRLGaPa
        9toULAmBhMTPu5kPzRUv6pw=
X-Google-Smtp-Source: ABdhPJyiiqKgDMsRPSWBvmnWnE6ej9f6LJlAC4tHjM2ky4KU9FdXfR8GOTSaoXo62BcYQy831hk9SA==
X-Received: by 2002:a1c:6a04:: with SMTP id f4mr1092423wmc.56.1637166336950;
        Wed, 17 Nov 2021 08:25:36 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id h2sm328817wrz.23.2021.11.17.08.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 08:25:36 -0800 (PST)
Date:   Wed, 17 Nov 2021 17:25:33 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Zou Wei <zou_wei@huawei.com>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] pwm: img: Use only a single idiom to get a pm_runtime
 reference
Message-ID: <YZUs/XFioeZo9aLn@orome.fritz.box>
References: <20211112190015.1141825-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wGrU6EFoKvEv0X25"
Content-Disposition: inline
In-Reply-To: <20211112190015.1141825-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wGrU6EFoKvEv0X25
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 12, 2021 at 08:00:15PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Currently there are two very similar approaches in use by this driver:
> img_pwm_config() uses pm_runtime_get_sync() and calls
> pm_runtime_put_autosuspend() in the error path; img_pwm_enable() calls
> pm_runtime_resume_and_get() which already puts the reference in its own
> error path.
>=20
> Align pm_runtime usage and use the same idiom in both locations.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> I asked to use the same idiom in both locations in a review feedback for
> the patch that became fde25294dfd8 ("pwm: img: Fix PM reference leak in
> img_pwm_enable()"). The patch was however picked up without addressing
> this. See
> https://lore.kernel.org/linux-pwm/20210512045222.2yjm6yxikznohlmn@pengutr=
onix.de
> for the details.
>=20
> So here is a follow-up that aligns the two functions.
>=20
> Best regards
> Uwe
>=20
>  drivers/pwm/pwm-img.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Yeah, I must've missed that comment. Applied this now, thanks.

Thierry

--wGrU6EFoKvEv0X25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGVLP0ACgkQ3SOs138+
s6EZsBAAomaxo4R1t0FbVXhHS0mh9HLy0zv4iEnnsLQepjrA15HLOhFgKtr5N/g5
w8w1DtSHJSJSzGZ5dkQV6tFvWmxrNv/Lw4gL6dIEWgu0KA7466YWNJmiAV3eUL2E
3KsKTVA8VYVJ4e2I4IH2viuboUCyf27lKZ83LiVfRF1wxk1CAOuQ8PlUgrQTc28f
6+31mXyMjbCCBRkNJ7ot7oM+IKuOgGGmI4uTnbWLuUkUZIAndRPlU88ijWGV1+Cl
USpmM0P5bnBCcAn5FFdGlLzGsrKIkFXfbizy8jKEfiZ/jGYvEWlb6RhJdIm4NxHt
u/E5uh8LgAz1a/wFojBkO6S3iTMOJU1CP0tWiS7ku+pgtMHBcRVarauoQNjZgVQL
pTnJBLz2T7vEFIL43mZfAuK6CwIapPuF33rRhV3AM9aESHaoVFok1wp4INuVtf0m
XKSsu4ib9Qjdv9I7Fcmse9lp3JOhF8RXIzcmnkdpyoHxU8D6JLOhf9OxOhDKjms9
PecJRwXxVYp7/EVLQJgkioBlCUgKU3bLldVFuxD9ds+gIlacx5v6ZVcTnzbekwAd
ASg1dtpTHpnytr+3J49SaxW1oz3jRMN/G5XIv3GtrmzBXClXYOEnBsWVAkvq0Pln
r+Kbfukae+AnNSFq/k81h3mefTv4NjDuy22RtA4HwB5edWx0qD8=
=ZSJY
-----END PGP SIGNATURE-----

--wGrU6EFoKvEv0X25--
