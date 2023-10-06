Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4797BB62D
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 13:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjJFLQl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 07:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjJFLQl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 07:16:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380B4DB
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 04:16:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5334f9a56f6so3554606a12.3
        for <linux-pwm@vger.kernel.org>; Fri, 06 Oct 2023 04:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696590997; x=1697195797; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOO5w12G0HdpSCJuMPoshfh7oxf9bf87YoHNXJfDRM8=;
        b=IdBP8Yr54x+Tk0b+AyYzhXZvdw7WVwxOT80TyvhVxC8/f8H22nWTKEW0InXWBvb6YM
         XA5rGxIl6bVXpfvfHJxPQ4y00vwHj9FFtHgrTU1F2fgeLVtwAEMwkabFuBuh1YYPQNEd
         5wV/gVuU+hQiuTVE3UbCWHUad86vSQQe+ikRWpJyDd93dlaYs5hiQoqbVJ41MUEmOf+G
         iBQLItmL8Ei3PVUQONNEGSbSlxdiZMVlv06o/jGpIIa5S6+NmYJgAhr2itvwv/cFbQxF
         gLJ/Ctnh852/s3pQOWYMtV0ki+rUKBPCRcs9cTudyxfX7Pi1BNoEY3IqSL1/Z2l0gREN
         xKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696590997; x=1697195797;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOO5w12G0HdpSCJuMPoshfh7oxf9bf87YoHNXJfDRM8=;
        b=tDQ/snqljAVmrhdk5ae/2aGWDde63oiqTX64zltLLxhOuJoRVRCdyJNPXUC/ZAp0Yw
         6+PzQCEizNPY5M9lK9BgP59H7atq7Dj5iYPspuGecE/hi18S95+K5p+oPVaExdWl0ut5
         2r0w4eYXbsFyta5VKE7HzG2JYmaybB95Fr1El3wXOq1WkXkGODpM4AzVaK6tB/Qe/yv/
         hXLkI71Fk4Hp1sKrn8bVzwaR/qWt4f5TxA0gokDeIq3hvt1Hvbci16lyM6x4WycxmeiU
         yycXnt9T/ediUz52Q10/PA/NbKtkQT54WggGqcaJciVgWQLrnE3TkBjWnvntoyy5POUU
         Wnbw==
X-Gm-Message-State: AOJu0Yw5j7TQwjm8yoKmlwjAywsuDvbSKVjCYDA5Y5WumHxHls7xsgcr
        /MVjUnGCFfOsvd7NV6CH4m4=
X-Google-Smtp-Source: AGHT+IFU9ZhbR1Ap2vqsE0JlZyFrjLvwV+DzqRlEzeN9a139tYTG4L4bZQYpy4K0K93BWCjPWHzPwA==
X-Received: by 2002:aa7:d14b:0:b0:523:38eb:395d with SMTP id r11-20020aa7d14b000000b0052338eb395dmr7221003edo.9.1696590997420;
        Fri, 06 Oct 2023 04:16:37 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f18-20020a056402069200b005389ebf00a2sm2420979edy.76.2023.10.06.04.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 04:16:36 -0700 (PDT)
Date:   Fri, 6 Oct 2023 13:16:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v1 070/101] pwm: Ensure a struct pwm have the same
 lifetime as its pwm_chip
Message-ID: <ZR_sk12BgUYXvFkp@orome.fritz.box>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-71-u.kleine-koenig@pengutronix.de>
 <ZR_VhNLrXVUc2Fxr@orome.fritz.box>
 <20231006110451.eztc5sfw6knzm6xf@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="90sNhsFmNMMnDMnp"
Content-Disposition: inline
In-Reply-To: <20231006110451.eztc5sfw6knzm6xf@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--90sNhsFmNMMnDMnp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 01:04:51PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Oct 06, 2023 at 11:38:12AM +0200, Thierry Reding wrote:
> > On Tue, Aug 08, 2023 at 07:19:00PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > It's required to not free the memory underlying a requested PWM
> > > while a consumer still has a reference to it. While currently a pwm_c=
hip
> > > doesn't life long enough in all cases, linking the struct pwm to the
> > > pwm_chip results in the right lifetime as soon as the pwmchip is livi=
ng
> > > long enough. This happens with the following commits.
> > >=20
> > > Note this is a breaking change for all pwm drivers that don't use
> > > pwmchip_alloc().
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/pwm/core.c  | 24 +++++++++---------------
> > >  include/linux/pwm.h |  2 +-
> > >  2 files changed, 10 insertions(+), 16 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > index cfcddf62ab01..3b8d41fdda1b 100644
> > > --- a/drivers/pwm/core.c
> > > +++ b/drivers/pwm/core.c
> > > @@ -198,7 +198,7 @@ static bool pwm_ops_check(const struct pwm_chip *=
chip)
> > > =20
> > >  void *pwmchip_priv(struct pwm_chip *chip)
> > >  {
> > > -	return &chip[1];
> > > +	return &chip->pwms[chip->npwm];
> >=20
> > I already disliked &chip[1] and this isn't making things any better. I
> > fully realize that this is going to give us the right address, but it
> > just looks wrong. Can we not do something like:
> >=20
> > 	return (void *)chip + sizeof(*chip);
>=20
> In practise this works, but I'm not 100% confident that the compiler
> might not add padding that breaks this. I don't particularly like this
> function either and will think a bit more about it for v2.

I'm not at all a fan of this whole pwmchip_alloc() business and I would
prefer if we could somehow just keep embedding this into the driver-
specific structures and take care of the lifetime management with less
intrusion.

However, I don't see how that could easily be done. It would be slightly
easier if we didn't use the flexible array, I suppose.

>=20
> > instead? That would make it more explict that we're trying to get at the
> > extra data that was allocated. It also makes things a bit more robust
> > and doesn't explode when somebody decides to add fields after "pwms".
>=20
> Things will explode if the flexible array member isn't at the end of
> struct pwm_chip no matter how you implement pwmchip_priv.

Perhaps one more reason to avoid the flexible array member. It's not
that big a deal, but I'm all for keeping things simple, and that whole
business of computing the allocation size and then making sure we point
at the right offsets just doesn't seem like the optimal way to do
things, even though I'm well aware that it's common practice elsewhere.

Thierry

--90sNhsFmNMMnDMnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUf7JMACgkQ3SOs138+
s6GnVA/+Pwbi4wKgBjEwzlZ9d+EBt1yHFCFtCS/g5PWcNrOj1KYhDzjk7fHj5mKj
Kgw29ehSF0E3ESxGvO2WFjlCn8mHjuJVxbCBpUl9+qKc0j42thfph0VS2zQG5otQ
ZjrsiCo9Qqd0Wg5e5s4c0tUcFqsBIHK/YYhAf/RfnfrsEXTC7eKBXDB2CPpgE3wy
yG/i01VPuoGxYulGyEOM0T8p0RfgWBPFG+mwB2xzCtdeln1P5q8LBN7VWW/vN2da
wwvnBk7DAwRbwLQtmfgivU92i+j4Xn6p9SGGlXJapFtG94itgzV4mb1Ca1RSsiQ1
8HadLru8e7hmsyjAccYC1VHT1DrBbvVDfW8AEY3egI8U5FlwRkDgZvCnrBSg57xo
fMmx8ZSjnPPf2mIdZ48Zkv3KYrxRTejwSJPtRiL2WollHFq+GHwT0LhTeQV7kQg+
GhcaPjVXaJ9v4C/A3H4P26CnWvV8QJUfM7SOQu/yMx9wO6gO/x7KTNZccqz5x/gy
0lOEZreLXIStbwfykARXAdzIqBuqNtkE6+lZC0fYBTYa+FUk/cTuOzCHObzIrdPN
ecCmeo8OuVi70O0/P2JSv2vwLAjP11x1a6kEvM0Kxpwdj2Tg/nzllqGTCMhvqMyd
Afyiq8cqLRJNeuqiGQ+EoO4oBorb1FMxwuiZ9ut99jrtM49HsRo=
=v1YW
-----END PGP SIGNATURE-----

--90sNhsFmNMMnDMnp--
