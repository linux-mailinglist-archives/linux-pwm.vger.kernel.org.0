Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68EEFE0D4
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Apr 2019 12:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfD2KtH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Apr 2019 06:49:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38589 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfD2KtG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Apr 2019 06:49:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id k16so15309242wrn.5
        for <linux-pwm@vger.kernel.org>; Mon, 29 Apr 2019 03:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ab8x1YnM54+y+Aa2g0Be9wlpmHQlHD69wEtYVBahmeA=;
        b=Y0RMtvJIDqmMnG16/S1DZde1PQRLHXVa7GnM1tyJI4TnF4HDEXjY+pN36GdFzweO6o
         hcdFqyJvlXu/WB4CE05tZF4KDnh67iHXN7t1QrgVrtfoVtaLlI76e+EpjxXPwnZxyNTY
         OAlDE24660Bo0WxX9L39HcdF9xtcMsk4+lDRuI8iH1HsyjgQNiN1FEPfk7V83gezeQwE
         dOt8bXXK35ryslhlc/W9v3uXDUGYIfIegE+N/cME1bYsUONzSNZFMumRwEV3WkQzmi+V
         VIYvcPNrzOkw03ccZbE3iWESeAgOqUveG4vdnDCaE5nEWa8KE5PdBbR+ZyPe19xI+yaW
         ikAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ab8x1YnM54+y+Aa2g0Be9wlpmHQlHD69wEtYVBahmeA=;
        b=cvMhyvKXigayKt/R40EtNBViTtsYyRv4BhNg4dBIA+TzS51BLBk/H6KgQbtXqylpnl
         QBtvf2gOX5xi2onwRmZoJsCY8ZFRI35Oc6Dyws3eYqKYJRlnpLZdTeuE7xW0yr9yU7Rq
         yCH2EWxTzcztRXxt0i5dWRcJ41eNnuaeiuiPExGRTbYnJz8jG5SXRkuH6sc9zEQg8FgK
         IgM4CBIU9qsOFwilz9Oht7nEYoD2D9VIlSlplXCm5mCrNMEcS29WyRIYRwox94s+ki1Q
         eJ2+z7CCfkI1ti8o77bxy4unZC6hhf7QInyUJcxeu+oQG5wAalwDCVtBgYZMXZm4VXU9
         eVAg==
X-Gm-Message-State: APjAAAX0UZoKCfn5l+VvO1EHtclpV7/wJDKoAExWcwEykbC+UqvKa+mk
        W654Ug8WdtvlGW9rZ0EIF/0=
X-Google-Smtp-Source: APXvYqynw74udRbNS1ZzaJsqtxE5PgBHwgUlvZUJWMjt6U3uNEjc6QMhFH5lxBiHlmeATy2UaNFpsw==
X-Received: by 2002:a05:6000:145:: with SMTP id r5mr2774965wrx.19.1556534944439;
        Mon, 29 Apr 2019 03:49:04 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id r6sm25313794wmc.11.2019.04.29.03.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 03:49:03 -0700 (PDT)
Date:   Mon, 29 Apr 2019 12:49:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Message-ID: <20190429104902.GA7747@ulmo>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
 <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 03:45:47PM -0700, Doug Anderson wrote:
> Hi,
>=20
> On Sat, Mar 30, 2019 at 2:17 AM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > Hi,
> >
> > [adding two chromeos people, because veyron and gru are quite
> > heavy users of the rockchip pwm for both backlight and regulators]
> >
> > Doug, Brian: patchwork patch is here:
> > https://patchwork.kernel.org/patch/10851001/
> >
> > Am Dienstag, 12. M=C3=A4rz 2019, 22:46:03 CET schrieb Uwe Kleine-K=C3=
=B6nig:
> > > The pwm-rockchip driver is one of only two PWM drivers which updates =
the
> > > state for the caller of pwm_apply_state(). This might have surprising
> > > results if the caller reuses the values expecting them to still
> > > represent the same state.
>=20
> It may or may not be surprising, but it is well documented.  Specifically:
>=20
>  * pwm_apply_state() - atomically apply a new state to a PWM device
>  * @pwm: PWM device
>  * @state: new state to apply. This can be adjusted by the PWM driver
>  *    if the requested config is not achievable, for example,
>  *    ->duty_cycle and ->period might be approximated.
>=20
> I don't think your series updates that documentation, right?

The documentation is arguably ambiguous here, but I don't think this was
meant as you intepret here. I think the original intent was to give the
drivers some leeway in how they apply a state. So a driver could for
example adjust duty_cycle or period if it doesn't support exactly the
combination requested. However, I don't think it was meant as a
suggestion that it would report that back to the caller.

This obviously implies that ->apply() is deterministic, so given a state
it would program the same register values, irrespective of when, or how
many times that state is applied.

> > > Also note that this feedback was incomplete as
> > > the matching struct pwm_device::state wasn't updated and so
> > > pwm_get_state still returned the originally requested state.
>=20
> The framework handles that.  Take a look at pwm_apply_state()?  It does:
>=20
> ---
>=20
> err =3D pwm->chip->ops->apply(pwm->chip, pwm, state);
> if (err)
>     return err;
>=20
> pwm->state =3D *state;
>=20
> ---
>=20
> So I think it wasn't incomplete unless I misunderstood?
>=20
>=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> >
> > I've tested this on both veyron and gru with backlight and pwm regulator
> > and at least both still come up, so
> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> >
> > But hopefully Doug or Brian could also provide another test-point.
>=20
> I'd definitely be concerned by this change.  Specifically for the PWM
> regulator little details about exactly what duty cycle / period you
> got could be pretty important.
>=20
> I guess the problem here is that pwm_get_state() doesn't actually call
> into the PWM drivers, it just returns the last state that was applied.
> How does one get the state?  I guess you could change get_state() to
> actually call into the PWM driver's get_state if it exists?  ...but
> your patch set doesn't change that behavior...
>=20
> For instance, look at pwm_regulator_set_voltage().  The first line
> there is  pwm_init_state().  That calls into pwm_get_state() which
> just grabs the cached state.  If the last call to pwm_apply_state()
> didn't update that then it seems like it'd be bad.

The whole point of this atomic API is that the cached state would always
match the hardware state. Given what I said above that doesn't
necessarily mean that the cached state exactly matches the values that
were written to hardware.

But it does mean that the following is idempotent:

	pwm_get_state(pwm, &state);
	pwm_apply_state(pwm, &state);

Thierry

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzG1pkACgkQ3SOs138+
s6HnJg//Z/zYy3o/pl5f9e9zd0C077CFTp3GxG4oEd2nGUq03avn1tVHcjI55vH5
9iiOpnBHY+1d5y02FyBbGLB+NozT9WZZuNOss588970p8MTGKbSDbsPy3rS7D37/
wrqiYCJ66/cwM0nuUZjPwJ8MPcvBf7ZMy9hLT8BbLkQUuLNiB/DYvloQ2szrfiNi
EKqrGqJGyP2MhUmghedV2FOYSU2nIhjttcT9boTG0N9iezerudTle7yj41qjSnth
+KC/d+Iv8hijy7imo9vXrcK3KYIFuJKSiRU4/G2ompKrfwf4JrMBQ5atvKaJMRbU
Rkif15K2UuyP8NmFj9/JXorwWY6z2KpmW97YUUpliEbnhPf1p8gQ3oKfXpLhTeDB
v+0DmLwFtayerbvLNunUURJJ0jz/pWydm4UvnOyW5xn469MbWP1kri2+RVh8HTCb
+SBnYkAyDLgTiuqNcUzTrprLxlny71VdWkrPMkZZ3spAc9MTJ/uLez3P1GVBaZm6
UzBQ9QHzgOD2kZvfxDMqF6bym2wczRIVgm1qv1CbyO2AF1XjdyxYRAixyuhn932K
nm8bUUHOlRXBKOpn3kE630pXjbaRhT9SvZj9eHTUxktMdhBwLljl4keLZGtM51eS
PzX81VFgjbk7R+aCuN5qYTbw11tHM1aoXTkvR2OhWwQiixPF6Ck=
=iul9
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
