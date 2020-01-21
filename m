Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7667143E93
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2020 14:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgAUNuQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 21 Jan 2020 08:50:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36635 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbgAUNuP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Jan 2020 08:50:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so3294520wru.3
        for <linux-pwm@vger.kernel.org>; Tue, 21 Jan 2020 05:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iS+nx/bltAs8KhRZXRbmoncNXx6LIS7dz9GtjKxYL1c=;
        b=UEQ55PfrE2HFYsww5wa3MuGlLiOFxwfDHqvcnwQ7HQDp1Ootz9/kGfU4FijhfGRycW
         0C3tS9GeDqQKvpTqQygEBF8Xp1vNOb41aKEznRbPB5YIWhT9A/iVbbzO1q+GMQxY3OyK
         sXnPEDnLlg9QtFqLsU/fjw+svslS0toq9mTEzfPE/HbG7iD6EuuPn2tUWe7hCd20s4I/
         v/RQg4znC9GHKg5mkqSZZT6F24FsynXx26caZIeDXc9+XTX4VGI1Y7FiNsQo6rB9xOkJ
         m4IZHhnoknEwOeMZepZ0oEq2DZ7UdYQ96cMwjCsN16TnlimCMZfLiY/9t0R+3kiXcXY0
         7XxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iS+nx/bltAs8KhRZXRbmoncNXx6LIS7dz9GtjKxYL1c=;
        b=nuo9TW9Mmvu7trWZUdvH7BQX2myoHs3b5akbOG0rQu8MECxbixVtFMl2iQov1ZsB2A
         d6A54xJ0EDsuong+HWjEwwO93xwxHhtNgCR9L2leqtE4hOuBgQqvqKrgfQLSPiJ67kkY
         UDL0Gmt4arIv+avkiewiVX1oPIIW1FvH+XvuwXQwSG480oQtzHnHUjUoUITYYbeVMk2T
         ctDiYuZj1zYWi1bIc4jHMchpCC2/lGiZ3ZsofaXrSJ3bXHJdaGN/8svYWmKoJKJr1j7k
         FKi6pDB1OsMwPW1Zm4Kx/fmFNiGPKAFuiw7vqSRCSs3djLWOS30vjBghmJoR0BQa/xBG
         DWAA==
X-Gm-Message-State: APjAAAUi/Mcdj/46vAG5Jo881jUyq1dfjaHrkuTcPNUExDINkXypc6kI
        MbA+wa45EyWQvRMfbvZCqMM=
X-Google-Smtp-Source: APXvYqw1xeSW1sN6vF34b8T/m0IRifPesqrhPNT9RwClt3KTsYQqNQ9UKi8kowKrpC1MH/6mNHD/ow==
X-Received: by 2002:adf:ee52:: with SMTP id w18mr5383909wro.416.1579614614005;
        Tue, 21 Jan 2020 05:50:14 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id v62sm4239411wmg.3.2020.01.21.05.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 05:50:12 -0800 (PST)
Date:   Tue, 21 Jan 2020 14:50:11 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: sun4i: Initialize variables before use
Message-ID: <20200121135011.GD899558@ulmo>
References: <20200120143206.710666-1-thierry.reding@gmail.com>
 <20200120200917.gvua5h2egoznwd4h@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
In-Reply-To: <20200120200917.gvua5h2egoznwd4h@pengutronix.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2020 at 09:09:17PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Mon, Jan 20, 2020 at 03:32:06PM +0100, Thierry Reding wrote:
> > GCC can't always determine that the duty, period and prescaler values
> > are initialized when returning from sun4i_pwm_calculate(), so help out a
> > little by initializing them to 0.
>=20
> Is it worth mentioning the gcc version you're using?

I could, but what good is that going to be? I don't think this is
something that's limited to one specific version but I don't know
exactly which ones are impacted. Stating just one specific version
isn't all that useful in that case.

> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 0decc7cde133..3e3efa6c768f 100644
>=20
> I don't find this object (0decc7cde133) in my tree or next. Which
> version is this?

I made this on top of my local pwm/for-next when I was build-testing,
which I usually do before pushing, so it's not surprising that you
don't have this in your tree.

>=20
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -234,9 +234,9 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> >  {
> >  	struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);
> >  	struct pwm_state cstate;
> > -	u32 ctrl, duty, period, val;
> > +	u32 ctrl, duty =3D 0, period =3D 0, val;
>=20
> +     u32 ctrl, uninitialized_var(duty), uninitialized_var(period), val;
>=20
> should fix the warnings, too, and additionally explicitly documents that
> it's just the compiler that doesn't see there is no problem.

I haven't convinced myself fully yet that there really isn't a problem.
I'm fairly sure it's safe, but always initializing to 0 doesn't hurt.

Thierry

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4nAZMACgkQ3SOs138+
s6H3Bw/49RCcZD3f0ZDWVrUZyrmLDiWED3GsTfYIzf4irmwId1RNFuHk7vPxpDn8
E/+YGRT5Au9EjygTqP9pkz4AD8cDC5fUPpaTy71JwTFpjEGRHXLHCGr/HxYmJaUL
LqaU1wJSCKGlCot+4UDGEw2NMhBmvoOadDVOidXPRKH9EsPV9e8hE5wmvSr2dB9C
mT4WWdUe8ACKSSDFA15yHJlTHhBfS2Dp/QHY0B/xkslwCXT+rfuG1ktYKxFgiVxC
QPtzoAdaC/CMtyiFW6N/ZgtyFubGeZOC4BIotABLxNiCmCdlWBI8xKIOQ4wcNhC1
FgbLI5WVjqZWtKHGySsw3LD59FLt8z0FajjlRI0gJeO46SEFSgIbRCJVuNuLa6mo
auvHkADAjqYpLl/zzFlMHaKCsu8kj5+8SS3gJhzfEc+kRVtfbA0CdtnhB3fBQd1E
Uka+IcgZSnmmWZp1MCTQgO1LtRvX41P6yFUDp6Iq7dnwY4FGW9zcmZqAfYxZZ5h1
Ho5SK5/nQjPcpTxhmCJYsjud0Ok8sf6PUADy18DHn/XBJpEr34o78iuuAuSII6qG
jSDhx86VVzUDHeQb/sGTdgb/G7+Sey/n0MVDXh7HZftal8HR+KXeaH9g5UVJNXDJ
e0HX7E3p9cG2dqgjX2a9bTvnhmOdijOc2u/DksDzNtB1Phae0Q==
=X87r
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
