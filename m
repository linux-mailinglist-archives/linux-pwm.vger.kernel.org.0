Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FECFD8C89
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 11:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfJPJat (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 05:30:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39274 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfJPJat (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 05:30:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so27195160wrj.6
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 02:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LMfc2Vb+uMSGpLu7qXwu/pJ1Z07gNK6OG/+iY+9sNHc=;
        b=XWjnT5I5MO6x5RZTZ6e7KlcUJHi1f7vVsGOYTLrmx84bMzIXIwJLFOaqxQtAX7sc89
         Y6rjB/RDXcrx4/Yk/x9Y5Cj2LhZPTujihw0/DMf4zF3rfydvwCFETFq81KwtXCqDKSDZ
         Ta6ijut5affSbVzkG9bW0KWZOIlnWioPRWWAicB0cqzZOEkg8Us3skRWe+wpYiGFUm/2
         EF0g2TPpMo7AQy1maKbTVFhSqjISdPsNea6tACxcAsvOSPAfzXyH1C+GVxzk0XMntJEg
         0lzq1NYNc+WzTLVZhPzuZAV6MF6EzmAuZ1EDuLyC9Jxnis9MP+oyvBdJpa/dAhIyiH4m
         dcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LMfc2Vb+uMSGpLu7qXwu/pJ1Z07gNK6OG/+iY+9sNHc=;
        b=RdYVjQDLa7494Q4C1kHL0Pkrz6In5nkmpmcplohIScvFAvfr+o0kHANuzeQu9C9r+0
         BwnYMIudohH2sGw8wsIkUdj39MXyaQECu/jECKLM7Cv5DE8VxDulXpgMtGiR9eUsQjty
         7nlhooZE/3zomLQoMf8bh+UOqicm5sLS7B4wZ4TETZR106COUBJfZTd9hY2YIBbtEG1T
         FZLu0vfV+XcepV4HZCnY/aHKUXPz0jn7OigpTxMmO+x0ky/FRqyNmsz9Bg2tkUFeJ9qF
         xPBcLKjLIXr84P3CSAmJ67vtA+PAJx7acMh8e1FWOB1ZX/k+vvNScLBNlu+9LADw8ViF
         jGYA==
X-Gm-Message-State: APjAAAVQ75XlvCKOfnCVryloe7d6ceoVcKzdmOM4uONBuYCukVqg/s9k
        RO2HuNWnxaWUGxeDXDgOBEk=
X-Google-Smtp-Source: APXvYqwYS+sfNmSzFlERUNTr0urKmb0tHy9PLa8Jx+Jo4dg5VqhrgI4PsflkB9FSnDYNg4GbtRoStw==
X-Received: by 2002:adf:fa88:: with SMTP id h8mr1781445wrr.89.1571218246993;
        Wed, 16 Oct 2019 02:30:46 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id z1sm6568331wrn.57.2019.10.16.02.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 02:30:45 -0700 (PDT)
Date:   Wed, 16 Oct 2019 11:30:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/3] pwm: stm32: Remove clutter from ternary operator
Message-ID: <20191016093044.GA1303817@ulmo>
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
 <20191016073842.1300297-2-thierry.reding@gmail.com>
 <20191016082612.fwpig3pup6bor5cn@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20191016082612.fwpig3pup6bor5cn@pengutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 10:26:12AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Oct 16, 2019 at 09:38:40AM +0200, Thierry Reding wrote:
> > Remove usage of the ternary operator to assign values for register
> > fields. This removes clutter and improves readability.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  drivers/pwm/pwm-stm32.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> > index 9430b4cd383f..b12fb11b7a55 100644
> > --- a/drivers/pwm/pwm-stm32.c
> > +++ b/drivers/pwm/pwm-stm32.c
> > @@ -493,11 +493,19 @@ static const struct pwm_ops stm32pwm_ops =3D {
> >  static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
> >  				    int index, int level, int filter)
> >  {
> > -	u32 bke =3D (index =3D=3D 0) ? TIM_BDTR_BKE : TIM_BDTR_BK2E;
> > -	int shift =3D (index =3D=3D 0) ? TIM_BDTR_BKF_SHIFT : TIM_BDTR_BK2F_S=
HIFT;
> > -	u32 mask =3D (index =3D=3D 0) ? TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDT=
R_BKF
> > -				: TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
> > -	u32 bdtr =3D bke;
> > +	u32 bke, shift, mask, bdtr;
> > +
> > +	if (index =3D=3D 0) {
> > +		bke =3D TIM_BDTR_BKE;
> > +		shift =3D TIM_BDTR_BKF_SHIFT;
> > +		mask =3D TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF;
> > +	} else {
> > +		bke =3D TIM_BDTR_BK2E;
> > +		shift =3D TIM_BDTR_BK2F_SHIFT;
> > +		mask =3D TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
> > +	}
> > +
> > +	bdtr =3D bke;
>=20
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> Is index always in {0, 1}? Maybe a comment or a check about that would
> be helpful. (-> separate patch I think).

The bindings say that index can only be 0 or 1. I guess strictly it
might actually depend on the number of break inputs, but given these
register definitions, there's only ever two.

But yeah, it might be a good idea to sanitize the values upon probe.
I'll add another patch to do that.

Thierry

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2m40IACgkQ3SOs138+
s6E+VxAAoevpPIDLcmfiVv1/WqzfYJ3oThy/mxnj5wJn42nO6Eww3YzDYOnKRpgJ
MtiNT4DYfnhZPBc9QowMW5hTv1TRIE6yiqlcGTv8MlOAjQtVf17EqClpEm8uefLq
vXZDW8u8xgXZ2hxTjVAiv6UakwiIwdlQqarw52peLP3ohCSzahi2VwZ5pR9iZnev
E49lnjsdz265BnMi9/WVEnbKpJwmYj5uxjJhcHsYhhoVKWpRqDFt85Rwk+DqiPib
01FZT7WCDsryP5CWgBjlX1nIhWpWcz3ujqZM2cYmQ3wj82Mclu7LBa+ruQ7MZEBU
OLmo4R1QsZzH5aK+5qdYPD187LJPUCNH/OzL7Vav+Q5u/xt5c8svwq1NFSLu2vvK
XEIw+966q28q7H7NqlXCt4vqq/Wdvn4bhlGY7IhGi2uFP/cKGQNChUuPyY7Li7uG
Y+2Svu6qwx0cHatKqzFgSNM+pfix2ditR1kv3CxnX2Z59jgKu+9K1TfYTnBXMXRl
VnaaTJdDtzUjEAe/58FGLyx0JUuHkKVJ6cpcS1QBXBZs5lRL/LM4l/VO8GbXXv31
eNCNCcXuUkxXsPSK2n79VCmZsERlxdRg/V7NuKtot9+3epaiWSIznve/t96W+fci
5rCkVHBNXPvIeZ8oiKqkhM3KKkkoEPZs9Zm9WRQRS1q9zO4w3+M=
=+xhd
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
