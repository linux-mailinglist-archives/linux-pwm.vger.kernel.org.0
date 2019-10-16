Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 591E4D89F9
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 09:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbfJPHkd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 03:40:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37611 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbfJPHkd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 03:40:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so26751793wro.4;
        Wed, 16 Oct 2019 00:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JmhrilHMGIrlbgH7TsADzSCXrEOuSYjY9R2YMORFMhw=;
        b=DedVAcE//eHZUpQqzyFosTstcGtkMOYBK9KXfYtHpsx1IF9yDTUZMRoBGcGRFXTv8j
         F439knPuq3UjRfS2lFkWTLX7k0k3Y/VqMSnO6rxXo4k1K/KQIYHK/zCr/iWWMozndM+N
         vVg6fdzUmhdZzXPkc3SfOeC3hOk1wCQOYgUnN/TwOjF/ttvE5YpbL12z/O+/2C+0LRk6
         7Mx2slQrcqf9SSML7YqIu6D1XjAkiHGFRpHsc9zGXZz/xNMa+UHmg5F2NNu7IJ+WZoPq
         Xo8zW1PkizDUKprdS0lCgsqOsRBQSaio8EdPJF4Jp1RH6fu9Xw0Fm4hVLmygoB+itfg6
         DlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JmhrilHMGIrlbgH7TsADzSCXrEOuSYjY9R2YMORFMhw=;
        b=ONcHmEPB7niHFMdQyK30pDUyrvhxYpSVe7j5mueYfcLx830ehavBK5U9TY159wJdVS
         xUrufoHztE1QlSX/nU4PrRuZp50tKw1ZCgM8ROdAY8z+BU+VyugwOwILf0J1XJSFH/eU
         re9XVupghLaNraNmYwYPZAZHGVHusFCWFZqhVFuqGZDirtFljESJUniqPjNOSw0xsr6l
         9j/mGBQuhcxwPcB2lB99Pak12C0Om6U0Dwaxd2kF9jsAlKXZlr3ZvAarSVz6hpitYa92
         EQLb/GjPrTtBgEhGV1A3PYMC53l8JoO/xwyahWjMm3rGUskthb9cgRjAKqUIee8VN0lo
         GfDw==
X-Gm-Message-State: APjAAAVGaZKUHAYhIFBFanOkcJNBOw/jsZeBg/IumuHGlTGs9RiR5YPv
        RBSx3v5+NEETIrdYGPQou4w=
X-Google-Smtp-Source: APXvYqxDg8VFFxIqZv75E623mHWKCFpnao4V4hTS3MpjQ9QuY68mi7rEHEUbMcKnIrdgPDl7hiALjw==
X-Received: by 2002:adf:f343:: with SMTP id e3mr299765wrp.315.1571211631185;
        Wed, 16 Oct 2019 00:40:31 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id q10sm42905776wrd.39.2019.10.16.00.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:40:29 -0700 (PDT)
Date:   Wed, 16 Oct 2019 09:40:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     megous@megous.com
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: sun4i: Fix incorrect calculation of
 duty_cycle/period
Message-ID: <20191016074028.GD1296874@ulmo>
References: <20191014135303.2944058-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <20191014135303.2944058-1-megous@megous.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2019 at 03:53:03PM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>=20
> Since 5.4-rc1, pwm_apply_state calls ->get_state after ->apply
> if available, and this revealed an issue with integer precision
> when calculating duty_cycle and period for the currently set
> state in ->get_state callback.
>=20
> This issue manifested in broken backlight on several Allwinner
> based devices.
>=20
> Previously this worked, because ->apply updated the passed state
> directly.
>=20
> Fixes: deb9c462f4e53 ("pwm: sun4i: Don't update the state for the caller =
of pwm_apply_state")
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 6f5840a1a82d..05273725a9ff 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -137,10 +137,10 @@ static void sun4i_pwm_get_state(struct pwm_chip *ch=
ip,
> =20
>  	val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CH_PRD(pwm->hwpwm));
> =20
> -	tmp =3D prescaler * NSEC_PER_SEC * PWM_REG_DTY(val);
> +	tmp =3D (u64)prescaler * NSEC_PER_SEC * PWM_REG_DTY(val);
>  	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
> =20
> -	tmp =3D prescaler * NSEC_PER_SEC * PWM_REG_PRD(val);
> +	tmp =3D (u64)prescaler * NSEC_PER_SEC * PWM_REG_PRD(val);
>  	state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
>  }
> =20
> --=20
> 2.23.0
>=20

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2myWoACgkQ3SOs138+
s6HjJQ//cOaa+rQbHDiozVxUr5QyYpNUKhyDd8gH07OijRllOYlt+NRxTwhjh47l
MEYxoNRg9rBZZxqA/G7qbnGCL1iDBNAP0cWSBlHpIalVi9GVIEuIfTzI0SPeoSws
EDIr7PI6Dhv2xO3IHjkrkNCUNwQgSVdmx5gxRyKRyzmuYdCHDAV9dP9ElSK7up/9
sMNEQdl/Jh1FizoXJP397H4rWTXhhHdlboh0uZ95/LIFZtIF2vBV0QXwt8Y9H9+a
Vdu8DTpAwdDvKbBFga6fnrI7lfNkw8tco0j4xMeK3Nva+aBBCfb28uF8hNazLQ29
k/b94765M6z3Lk4CbxCKJSlRHZSuhCsBb8Fd1kSrt3/eqZhlU3yWcOWVmCwxSvkj
RCwZnPah5NtvS1DtgTawURbayZ5/Q7zJIXg218OEh0TyWabeTCckbb1HLYcDAox9
46m3GK1C64yFUHn7X21lwN9yzd9p7V06YJ+j55TIxjwDuGHffVlTNELmZmRqXop3
MVUjsx3KhAc/O93GTAUAKh0LDsqbgu7Iu3trGK2i9zyzmAsAj0Cb0BjqV9kDLlyK
JeKTFZH4Rqg8vXuN9Jh4g5DxYmyupcgFBsITECvHD8SZoukUkW9Of80lBe+NPCyV
dkrit/vckMiUWbG3fSvGDGNSoxZlC1PKZHEK3tuqZk1/UP5UQqU=
=DSZ5
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
