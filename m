Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3E4CD8CE5
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 11:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfJPJur (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 05:50:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36677 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfJPJur (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 05:50:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so27277314wrd.3
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 02:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oFHi4Z8TLBaXSaOEuT5IQ7wdEFfH7drDr71VD+4T6pY=;
        b=TrL782UIFTfu9H3RnDAWP3GdfczO9MPrIWvhl6EeYcbfGYSk4ZLl6y3S6YJO+QoCMV
         FbElRmLNoseUX9FsbrQtvZe4zglBeRLkU2cc8VllS/S37iqOOoz4RV+idNHOWShpjrXX
         vA4q5TvsvYbgX8SDPAFYmKe8pSnQIgAVXhKSHkFqzIUwi2b9yKvnU7g91HlVyJ+DTW87
         05WN60B8MoAddqAWLtFghJkJOv1TLoZ/7TGHxkrGqTIAJhXTDtz1VocKru2olwGz/qMx
         Hf2ekZDkpq3zpbBazkIqDtARteBA6WE+6STRKkn66h1EcbFD/IFqZXGG2mbHEOTPsy4I
         BiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oFHi4Z8TLBaXSaOEuT5IQ7wdEFfH7drDr71VD+4T6pY=;
        b=ecdo+3hSIth+5uPAiTtrHYKcaNSIVtlM7hcF/x7Q7QzD5Kzf15P9oshznr5rtP8xu8
         Lg0acP8idZSTcgHKqoJuf2S0euPKdLryvXG/kHTbk6A+fN+kf2cIWHIDfj4cjCf9D+jj
         3nFcUIi7ZIR+Xb/UNJ3bL+ahUB9WXQYl0LelbPsX9PXmxT7EB2D7epgUGr2hhcPLsjoW
         Up8/0LmIW05EWXttenmiL99y7wG4mbzQ53Q2eE0r2/q3kLRJSLKFbWxkAeG7NdQv2m5S
         FrUU6gEirrad+zldkyWonxCTTrG/+ml9ObfI7b85dWTdSIsXBaeHZ+UcgkuXkb2DX+Ix
         zC1w==
X-Gm-Message-State: APjAAAXozyKNwi7ISKuXxaF8EFupVAFEtwJKnkDkbgNoz13MSlzRYInz
        cCk5KgML/9xUZzqg8pvMAAI=
X-Google-Smtp-Source: APXvYqwzkEpyWCcajar5bN/SN1KwuU1k/pbi17ihogL9+6DLr9lfFxrX0xjXqZphJuxCTLuJ3u7Xtg==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr1846506wru.108.1571219444391;
        Wed, 16 Oct 2019 02:50:44 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id w4sm21855612wrv.66.2019.10.16.02.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 02:50:42 -0700 (PDT)
Date:   Wed, 16 Oct 2019 11:50:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/3] pwm: stm32: Remove confusing bitmask
Message-ID: <20191016095042.GB1303817@ulmo>
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
 <20191016073842.1300297-3-thierry.reding@gmail.com>
 <20191016083107.fetprdj7k52hkdvy@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20191016083107.fetprdj7k52hkdvy@pengutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 10:31:07AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Oct 16, 2019 at 09:38:41AM +0200, Thierry Reding wrote:
> > Both BKP bits are set in the BDTR register and the code relies on the
> > mask used during write to make sure only one of them is written. Since
> > this isn't immediately obvious, a comment is needed to explain it. The
> > same can be achieved by making explicit what happens, so add another
> > temporary variable that contains only the one bit that is actually ORed
> > into the register and get rid of the comment.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  drivers/pwm/pwm-stm32.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> > index b12fb11b7a55..8f1f3371e1dd 100644
> > --- a/drivers/pwm/pwm-stm32.c
> > +++ b/drivers/pwm/pwm-stm32.c
> > @@ -493,26 +493,24 @@ static const struct pwm_ops stm32pwm_ops =3D {
> >  static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
> >  				    int index, int level, int filter)
> >  {
> > -	u32 bke, shift, mask, bdtr;
> > +	u32 bke, bkp, shift, mask, bdtr;
> > =20
> >  	if (index =3D=3D 0) {
> >  		bke =3D TIM_BDTR_BKE;
> > +		bkp =3D TIM_BDTR_BKP;
> >  		shift =3D TIM_BDTR_BKF_SHIFT;
> >  		mask =3D TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF;
> >  	} else {
> >  		bke =3D TIM_BDTR_BK2E;
> > +		bkp =3D TIM_BDTR_BK2P;
> >  		shift =3D TIM_BDTR_BK2F_SHIFT;
> >  		mask =3D TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
>=20
> Assuming in the else branch index is always 1, the following would be
> IMHO nicer:
>=20
> #define TIM_BDTR_BKE(i) BIT(12 + 12 * (i))
> #define TIM_BDTR_BKP(i) BIT(13 + 12 * (i))
> #define TIM_BDTR_BKF_SHIFT(i) (16 + 4 * (i))
>=20
> ..
>=20
> 	bke =3D TIM_BDTR_BKE(index);
> 	bkp =3D TIM_BDTR_BKP(index);

I had thought about that, but ultimately decided against it because
the original defines might match exactly what's in the datasheet, so
there's some value to keep the originals.

I suppose one other alternative would be to let the macros be and do the
computations in the driver instead, something like:

	bke =3D TIM_BDTR_BKE << (index * 12);
	bkp =3D TIM_BDTR_BKP << (index * 12);
	bkf =3D TIM_BDTR_BKF << (index *  4);

But yeah, I agree that having the parameters be part of the macros is
even better.

Fabrice, any objection to redefining the macros as above?

Thierry

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2m5+8ACgkQ3SOs138+
s6GSqA/+MTdWclsUcjCM3mrE8mDdl7NpUvdj/aCo5d6Q6f6Ihyy+f9RhBX27Sirk
K917UMgnm5ZXnDX2WHBJd/ntPePAzeQaFtedR8aiprk87C+8iWqgBzRxEyobNDAO
Z2fwAMqTsnHpdy+GedKAPugzsHvYuKqdrlkEuT3ka5/Yxs+kVqyVZsJVNJou6pIa
BMqxclu4q7mHWmhLCZN1Xk8Aejk/IyHi9KQr5SljOm4RLkVASZ2z740YZC4O1DCc
cqH4+sa6CrmI2nYBGrS8nYLjg3yZq6NzDLmN68VUseGpNYZXJsMe6AJ12JChOiIh
Dg9uNHyRNAEEXOzNblGif+fJnIfaTIQ7oX3pLST9c9nwGSieNsOpNf/1PMdY1+vE
H+duv5ojUZGxw54FshUpXzKbJMWKL/AxHVN/LRsPI/1rpus3uQMSCJbzKdsPaKQF
0qvm1YeRvj79QRcnt4k7i0eiUxPyy/VHsVNENad/xiX3BkluiPpSnAtKD9mh54fE
roZBEPCNmAOLg0T8h1LiL4p03TIvxqGYAv7nV2rcD4bPUfOy2A+zBOr+ZmLttfVB
zzBrsubXxkSttLbTEPYBPrC7OLIPCdDPHEjQpmWK6vT6LjSawT1z/pPVXZAGQnsK
aU0jP2YxgdkLFOMhawaEeBXHIQwphunGkkJTj1IrK9TtK3O8428=
=YbQI
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
