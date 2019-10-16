Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED532D91FB
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 15:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405305AbfJPNGp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Oct 2019 09:06:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37793 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405304AbfJPNGp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 09:06:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so27971328wro.4
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 06:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O6D7RKRs1muJvVuAAMlv8jQKSxOL+YShsjnr8tdb1eQ=;
        b=fMcMK6Yf7QeDQemRdg5EbX6HHul2qsKdczlQdnKDRXnPUOW2z6yy3MklxjbkcxzVLI
         TEpSvmEGAQiH4frDl9nOAAjN5IlU/TQymHLD7j98TTR/ok4AbW/6uzsxUOw96l4j0ZzP
         xkYjeWnF/8p1B4ujCNwfVJVXTsKap3xs33oYfXmddeAopcOq5gMsgE8+IFpZc7g4qYfe
         Vvk1FxKJhHQW2FWfL0Vv8CY3tEDuq27OD+NGer0+nBgnBHwPDPR8+CHbpWHAmEtuAHvY
         PPQSK6LpFpvMznIPuR4ySfX4zHitNmd1kNUC0Uh3V2cw5aCpER42DLXe1MhIXbBS2EEe
         j9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O6D7RKRs1muJvVuAAMlv8jQKSxOL+YShsjnr8tdb1eQ=;
        b=E3NuHqXQNyLF4Xzr7RIX1w3+L/+2DwghUlezZqRLAhPO4XL4S4pDgh7Gkc7ix5WgOT
         9GDjyE8lJpAkqED8TdTwOFaetjnqwH8xcQzh2BwH7s5OOoGlGWc8e2zFCL1qc2FyDIvH
         QD05NGquBRjTxYon6gGkXONN/PR1V5TdxXVWgTqXXhzxOaB+atGZW77tlPNbymMnzmf+
         laC0OerBEGA4wgfZoWbgi5EvKNZbW7NXebEkBGeFiNffYBHsKFg06k1SEXkAF1OO+BrP
         74SGEnuPig9jQfDaMiczhF5nQfHrdU8lY6W2TwWfyElpjpzvWg6gqs0D3+VxQNgifVzL
         YpOg==
X-Gm-Message-State: APjAAAUe1pVRa3aqEqgUENPSBJEmkioir5GltqSjM/BVrwCJzhP+c4h4
        UaOv6aOpJApE4e/b2BeuwXnLiMD5
X-Google-Smtp-Source: APXvYqy/8Aw+8VhwV+pgYZRZJYqWyN7redZ84IwkPa9i2hdAzpzzVA7LlSfkSdlxvr4R6klJooLluA==
X-Received: by 2002:adf:fa92:: with SMTP id h18mr2667569wrr.220.1571231202717;
        Wed, 16 Oct 2019 06:06:42 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id l18sm28336517wrc.18.2019.10.16.06.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 06:06:41 -0700 (PDT)
Date:   Wed, 16 Oct 2019 15:06:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pwm: stm32: Remove clutter from ternary operator
Message-ID: <20191016130639.GB1772382@ulmo>
References: <20191016110601.1765415-1-thierry.reding@gmail.com>
 <20191016110601.1765415-2-thierry.reding@gmail.com>
 <20191016111131.n2rrmkjfju2sc72y@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <20191016111131.n2rrmkjfju2sc72y@pengutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 01:11:31PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Oct 16, 2019 at 01:05:59PM +0200, Thierry Reding wrote:
> > Remove usage of the ternary operator to assign values for register
> > fields. Instead, parameterize the register and field offset macros
> > and pass the index to them.
> >=20
> > This removes clutter and improves readability.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  drivers/pwm/pwm-stm32.c          | 21 +++++++++------------
> >  include/linux/mfd/stm32-timers.h | 12 ++++--------
> >  2 files changed, 13 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> > index 9430b4cd383f..a5b323432d8c 100644
> > --- a/drivers/pwm/pwm-stm32.c
> > +++ b/drivers/pwm/pwm-stm32.c
> > @@ -493,20 +493,17 @@ static const struct pwm_ops stm32pwm_ops =3D {
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
> > +	u32 shift =3D TIM_BDTR_BKF_SHIFT(index);
> > +	u32 bke =3D TIM_BDTR_BKE(index);
> > +	u32 bkp =3D TIM_BDTR_BKP(index);
> > +	u32 bkf =3D TIM_BDTR_BKF(index);
> > +	u32 mask =3D bkf | bkp | bke;
> > +	u32 bdtr;
>=20
> It's not clear that
>=20
> 	(index =3D=3D 0) ? TIM_BDTR_BKE : TIM_BDTR_BK2E
>=20
> is the same as
>=20
> 	TIM_BDTR_BKE(index)
>=20
> unless we know that index is 0 or 1. A word about that in the commit log
> would be great, maybe even ...
>=20
> > =20
> > -	/*
> > -	 * The both bits could be set since only one will be wrote
> > -	 * due to mask value.
> > -	 */
> > -	if (level)
> > -		bdtr |=3D TIM_BDTR_BKP | TIM_BDTR_BK2P;
> > +	bdtr =3D (filter & TIM_BDTR_BKF_MASK) << shift | bke;
> > =20
> > -	bdtr |=3D (filter & TIM_BDTR_BKF_MASK) << shift;
> > +	if (level)
> > +		bdtr |=3D bkp;
> > =20
> >  	regmap_update_bits(priv->regmap, TIM_BDTR, mask, bdtr);
> > =20
> > diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32=
-timers.h
> > index 067d14655c28..f8db83aedb2b 100644
> > --- a/include/linux/mfd/stm32-timers.h
> > +++ b/include/linux/mfd/stm32-timers.h
> > @@ -70,14 +70,11 @@
> >  #define TIM_CCER_CC4E	BIT(12)	/* Capt/Comp 4  out Ena    */
> >  #define TIM_CCER_CC4P	BIT(13)	/* Capt/Comp 4  Polarity   */
> >  #define TIM_CCER_CCXE	(BIT(0) | BIT(4) | BIT(8) | BIT(12))
> > -#define TIM_BDTR_BKE	BIT(12) /* Break input enable	   */
> > -#define TIM_BDTR_BKP	BIT(13) /* Break input polarity	   */
> > +#define TIM_BDTR_BKE(x)	BIT(12 + (x) * 12) /* Break input enable */
> > +#define TIM_BDTR_BKP(x)	BIT(13 + (x) * 12) /* Break input polarity */
> >  #define TIM_BDTR_AOE	BIT(14)	/* Automatic Output Enable */
> >  #define TIM_BDTR_MOE	BIT(15)	/* Main Output Enable      */
> > -#define TIM_BDTR_BKF	(BIT(16) | BIT(17) | BIT(18) | BIT(19))
> > -#define TIM_BDTR_BK2F	(BIT(20) | BIT(21) | BIT(22) | BIT(23))
> > -#define TIM_BDTR_BK2E	BIT(24) /* Break 2 input enable	   */
> > -#define TIM_BDTR_BK2P	BIT(25) /* Break 2 input polarity  */
> > +#define TIM_BDTR_BKF(x)	(0xf << (16 + (x) * 4))
> >  #define TIM_DCR_DBA	GENMASK(4, 0)	/* DMA base addr */
> >  #define TIM_DCR_DBL	GENMASK(12, 8)	/* DMA burst len */
> > =20
> > @@ -87,8 +84,7 @@
> >  #define TIM_CR2_MMS2_SHIFT	20
> >  #define TIM_SMCR_TS_SHIFT	4
> >  #define TIM_BDTR_BKF_MASK	0xF
> > -#define TIM_BDTR_BKF_SHIFT	16
> > -#define TIM_BDTR_BK2F_SHIFT	20
> > +#define TIM_BDTR_BKF_SHIFT(x)	(16 + (x) * 4)
>=20
> ... define the macros as:
>=20
> 	#define TIM_BDTR_BKF_SHIFT(x)        (BUF_ON(index !=3D 0 && index !=3D =
1), 16 + (x) * 4)
>=20
> ?

Given the changes in patch 3/3 that can no longer happen.

Thierry

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2nFd0ACgkQ3SOs138+
s6GsjxAAtEPV5FbSOH75Jz29dWzCYp9C2NMj0YtR07v9wgBNlzcxbA6k2zY1R/KD
TNSIMjBWLTn6GfyERQuD0Ajuh0eYOW5utrhX7DhLQCCLqJs7JxRdHRcXz8AFIT0C
kVLpwRR0XuSYlQxMbXlGDe1akV+SbUh9cEL8dtPXJ5zdP58Yd1fIAC0Dj+RxmeUs
jdpDxlPjarISZhM+YIybRikOljTed6fscJP1HZ+Z82Z/6MzimBRQ32ckic43c/5E
s9Fgv1VpMdNQzRTkbX+a56auxuSHZX9tY+YBqvb3MPKvnBl/5I/WZ3fsK1wFv7OL
UNeYvbvuahk8OX3odZxMD2vc6tu1+Wrioi3Nkhw0XgWQGHbJPpl8mCe2WNyB153Z
/GdrsQ6UImJVWlrRt2lAQrfAIQ7qRiE/Igtt9IoW/x24+4HwEsNyMWXQL+XErPP6
ybsPGkPrFyyvtO/56vmdMC+d4KvaMapb5AOUzBhuS2MTtBvQLigGIwJ5LnQKc+ml
+vRKV3Ob4krw8A7jmDhsvL9RWl/lh6jTV+uuFLF2MTMUgRJCxerB62w79ObKlcBR
kQX5bi0QfWxobt3gbuU+YylVBJVTQHXwASuQO9hMQikr83NVjVxZ7esxEox4wSUA
9kP1xzo7Dzn/9b1LQbPoZWEGZsLraMZbYkle1C/I9DLAKN3xbSQ=
=v6yo
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
