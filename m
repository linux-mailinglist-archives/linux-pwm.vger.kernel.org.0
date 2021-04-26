Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3919436ACB6
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Apr 2021 09:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhDZHKl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Apr 2021 03:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhDZHKk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Apr 2021 03:10:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80C9C061574
        for <linux-pwm@vger.kernel.org>; Mon, 26 Apr 2021 00:09:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s15so64441452edd.4
        for <linux-pwm@vger.kernel.org>; Mon, 26 Apr 2021 00:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6pOuvAeWqjj/lc1Toqbn6txtZ3/dUNjytWE1wwRWz6g=;
        b=ZVii0f33wvz3tgBfUW+6qzUtShI/zgINpVGc8synBwrxSteVy6hoAWZKBX96hGC7sX
         k1Zsyykn4iIsJPrgJLOFxR1rke9cdBWbZkSaIrzn7DHONhAcp+6Xlh7HspdoCGBplggL
         mK/+MOT97PkuXgJU6sttz1W/HgDq6fF3z9fvFwSXZrfYtWlk6CovRM5vAU90QepgJTV7
         faOiqzU8QDZwDaHP2rUS7WA7xGdhl1y1Dbgbp9pElGeYug1mQPf0sQ6UWFt4Ci2IlpRE
         qyQsi6lfqSutKQUdPpcU0oWts8yND5VmhPeXn0oNHmWNLsRvWfjj0WY1u+KkFROnDUWH
         R/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6pOuvAeWqjj/lc1Toqbn6txtZ3/dUNjytWE1wwRWz6g=;
        b=pK6tSJHi/5eFBrEu33xr0C0lXnCM6O6bMGux8axl6AyfFXJQzuPx02jIv/OloX14BS
         HIRMRT6e/S8XCLsHNbQzJxOhXSY/qzQVOz7+zOILfpfGCL9jo5u3z6GikbpkeMX2B9PN
         hCOxxu56s6q2M6RtNdO8nSDmL6g0dreQ0zqzjytjSBo148dlRX53sCBFdFYfh/goFvfC
         dfw5oSaaT2A2RgNwaLQ1wijb12jbmxWsmY+EqFJeFmBAO19bRMvNuHTOH7bEnmUPL3SB
         3iY2qNn1YwB2VatdDqPHL2aBOtuTu+0aUWZNZtgCp/to6Ao2hG9YuNBWg7RYtEGULYiK
         Kj/A==
X-Gm-Message-State: AOAM5317MVAIVwGP5/1wZ5MgVBPTTMH1JCEqumDgo7MCUln6Af/OoWkc
        7/xiLbAJ8r4w2MTjRrbiiMb1nSJniNo=
X-Google-Smtp-Source: ABdhPJzu4Qdss3t4GCbFZX9icCvMds4t/nKFVmDhxB/gpjd+9LrUbXwOrjXtny8eO0cqkY5lBOtrnw==
X-Received: by 2002:a05:6402:c:: with SMTP id d12mr19324253edu.100.1619420996418;
        Mon, 26 Apr 2021 00:09:56 -0700 (PDT)
Received: from localhost (p2e5be10e.dip0.t-ipconnect.de. [46.91.225.14])
        by smtp.gmail.com with ESMTPSA id v5sm13315915edx.87.2021.04.26.00.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 00:09:55 -0700 (PDT)
Date:   Mon, 26 Apr 2021 09:10:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/4] pwm: Make of_pwm_xlate_with_flags() work with
 #pwm-cells = <2>
Message-ID: <YIZneL9KueIddbCc@orome.fritz.box>
References: <20210315111124.2475274-1-u.kleine-koenig@pengutronix.de>
 <20210315111124.2475274-2-u.kleine-koenig@pengutronix.de>
 <YHBYaCWUrEH6Lz27@orome.fritz.box>
 <20210424112957.oqblunomm64tjtm5@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UAh9bXCWpSU8KIuO"
Content-Disposition: inline
In-Reply-To: <20210424112957.oqblunomm64tjtm5@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--UAh9bXCWpSU8KIuO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 24, 2021 at 01:29:57PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Fri, Apr 09, 2021 at 03:36:40PM +0200, Thierry Reding wrote:
> > On Mon, Mar 15, 2021 at 12:11:21PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > The two functions of_pwm_simple_xlate() and of_pwm_xlate_with_flags()=
 are
> > > quite similar. of_pwm_simple_xlate() only supports two pwm-cells while
> > > of_pwm_xlate_with_flags() only support >=3D 3 pwm-cells. The latter c=
an
> > > easily be modified to behave identically to of_pwm_simple_xlate for t=
wo
> > > pwm-cells. This is implemented here and allows to drop
> > > of_pwm_simple_xlate() in the next commit.
> > >=20
> > > There is a small detail that is different now between of_pwm_simple_x=
late()
> > > and of_pwm_xlate_with_flags() with pwm-cells =3D <2>: pwm->args.polar=
ity is
> > > unconditionally initialized to PWM_POLARITY_NORMAL in the latter. I d=
idn't
> > > find a case where this matters and doing that explicitly is the more
> > > robust approach.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/pwm/core.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > index b1adf3bb8508..39b0ad506bdd 100644
> > > --- a/drivers/pwm/core.c
> > > +++ b/drivers/pwm/core.c
> > > @@ -126,8 +126,7 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, cons=
t struct of_phandle_args *args)
> > >  {
> > >  	struct pwm_device *pwm;
> > > =20
> > > -	/* check, whether the driver supports a third cell for flags */
> > > -	if (pc->of_pwm_n_cells < 3)
> > > +	if (pc->of_pwm_n_cells < 2)
> > >  		return ERR_PTR(-EINVAL);
> > > =20
> > >  	/* flags in the third cell are optional */
> > > @@ -144,7 +143,8 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, cons=
t struct of_phandle_args *args)
> > >  	pwm->args.period =3D args->args[1];
> > >  	pwm->args.polarity =3D PWM_POLARITY_NORMAL;
> > > =20
> > > -	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
> > > +	if (pc->of_pwm_n_cells >=3D 3 && args->args_count > 2 &&
> > > +	    args->args[2] & PWM_POLARITY_INVERTED)
> >=20
> > This might more clearly look like a superset of of_pwm_xlate_simple() if
> > you split up the conditional this way:
> >=20
> > 	if (pc->of_pwm_n_cells >=3D 3) {
> > 		if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
> > 			...
> > 	}
>=20
> I'm not convinced here. Being (more) obviously a superset of
> of_pwm_xlate_simple has very limited impact, as of_pwm_xlate_simple is
> going away.

That's precisely the point here. Since you are replacing the existing
of_pwm_xlate_simple() with this one, it's useful to make it as clear as
possible that this is, in fact, a superset.

> Also I expect that a construct like that will attract monkey
> patchers that will change the construct back to what I initially
> suggested. (I'm surprised that there isn't a coccinelle recipe to
> simplify such a construct, but maybe I just failed to find it.)

I don't mind rejecting non-sense patches that some script suggested. If
there's indeed some script or coccinelle recipe that would suggest
merging the conditions in this case, then I would argue that it's broken
and should be fixed or removed.

Thierry

--UAh9bXCWpSU8KIuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCGZ3UACgkQ3SOs138+
s6F17g/+PAU7BcjrS/PKsd5TcNEElS4LQ1+CWfUFdOO8viRO0+Lgd85wZEIcdyJ8
acUDyyToOkR9aK046Qlzml+Nmt6sKd2au+9yufsQ3FNiPacjT+cmUYc0HPT0csQq
AXEo0LZwjvs4NmOBPTwi0cKq+Euq+KTDC3clKh8RCRWtWOcf5JBh+WWESx87TLAE
GismqrZgTc1G9q+ybuWrl8XS4qxxmaP/sZGtU1odWujbWO8dn5mxYRxY3FCKQUzG
ovZ10ujOLCZ33ykItGwhS/6PCGP2yhLkMPD3+pJTuqeTLNPF3MNm7i2HxSssDWEm
HFNPJ/9pgiz3/D3K1eDGWUBeyNO1KaaoIF8vuOKUAeZJ4mXXQTxsT4n+tAC2blPf
zmWgpQbJ+n8tsgPJpwgiPI2re9HmGCo4ASqhPsjwyXpjXh1eAkPQ+6dVncE3wMIO
hqx/5osBmg1168moryXUQMm5gvJlwxL69F5sjQbe/M/K/l+OjoGuG3GFVSunXzMe
RI2TBhQgvtv9wxCE/Y1nevmm2dzV3LKD6MrojI/EupPjA7w/mpM2ux8VAMlpSz4S
wF5XeGd95jjit7jIY6OEeHlW8s4HVBHwfua8OY169NUOc0Zeoaoo0grpDNNGOS12
q0EzaHYZdqHcDm1eE/2z8W1zBrBHxDBNKswZh19cYxFIIhbuJjE=
=mXpC
-----END PGP SIGNATURE-----

--UAh9bXCWpSU8KIuO--
