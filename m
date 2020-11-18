Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A932B8385
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 19:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgKRSB0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 13:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgKRSB0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 13:01:26 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C37C0613D4;
        Wed, 18 Nov 2020 10:01:25 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so3551639wmb.5;
        Wed, 18 Nov 2020 10:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qZaelr3llq7m4oqmuYmDvVO+YgU0GZBfvCV9/hBsOQo=;
        b=iLQPC2yR0hpzPWNdhUnY2pH96eZKXDpPSa8N1V3GgmAAKkVGEm+ypAty3yGZ/RB4o6
         LSzzcxyDZxUrfDLANP6egFDg2SwJj25TCWsBl/9Zc5fa2by3qw66+5pBYzw4TniTyTR+
         PJYX6pO6oqBcmC6llABr4pcJHF3NcQAvE3dGaJohe3nZB88Qo9q0gbOUro/egVSydVuU
         5GuBeydL2R++J+TnsLoBJtkNPnMsd3jL6z8K9vnSpSug5AnBHQ8uBhV0PfoF+MwvMnLk
         JlPT3nBWu1t9d2EIhDkX+lBiHSilmXawkyg0l9ns9jO0PTJC3xVYZZW0UlzTT4zi4WwU
         VYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qZaelr3llq7m4oqmuYmDvVO+YgU0GZBfvCV9/hBsOQo=;
        b=m8voqSgEjaoJ58nqKi05BjYmKw/WH7Yq+a1lQh6dLT6j+5st5fCVOegdUWLB6NnJZH
         EdHPS/I2SSnolgJgeZBMWAKqE2lRQcR361fEn88+hR/xfYDL6NHOKAsAzrAcWBFREYWL
         1nOOvK4k5VySsflyz7PH97YOhf70HB6TY/nT4kYU1abgAJASFWBRvU0sPgJFgO+shVvc
         FNsw02rEotc6P4zjvlgbQhOEl91oKmvOQhYk6j/T2C63QLav77VGKPW5ZegxoylZ7yUR
         2Yq9QZFBeCOOvLI/e3g13c84yuHIx2eBE0AZQp66ehWVrw2cECkV1d/BF0KDJ4TTdZkY
         8BGA==
X-Gm-Message-State: AOAM531GPX1FIDFEiJuuiaOjvKNDRYf+RpuwxrGfJXdCRcN7fkBuTtiH
        dXudLQfeeCGFVm66lNGxAnk=
X-Google-Smtp-Source: ABdhPJzsxtOZRSr279P2oSEzI8HpF/Ub3a/Gw9bvIGXY3w3iQGFLwle8tBsp4jAHK2uUqSUPB4/Gtg==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr297884wmj.49.1605722484627;
        Wed, 18 Nov 2020 10:01:24 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id d13sm10495017wrb.39.2020.11.18.10.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 10:01:23 -0800 (PST)
Date:   Wed, 18 Nov 2020 19:01:22 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        lkp <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Lai, Poey Seng" <poey.seng.lai@intel.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH RFC] pwm: keembay: Fix build failure with -Os
Message-ID: <20201118180122.GD3552669@ulmo>
References: <202011160303.qi5aRChY-lkp@intel.com>
 <20201116090804.206286-1-u.kleine-koenig@pengutronix.de>
 <20201118100627.chgu3tgpt3kuazsv@pengutronix.de>
 <DM6PR11MB42509471531D8F009DB37E98FBE10@DM6PR11MB4250.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB42509471531D8F009DB37E98FBE10@DM6PR11MB4250.namprd11.prod.outlook.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2020 at 05:41:57PM +0000, Ayyathurai, Vijayakannan wrote:
> Hi Thierry,
>=20
> > From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Subject: Re: [PATCH RFC] pwm: keembay: Fix build failure with -Os
> >=20
> > [Cc: +=3D linux-pwm which I forgot for the initial submission]
> >=20
> > Hello,
> >=20
> > On Mon, Nov 16, 2020 at 10:08:04AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > The driver used this construct:
> > >
> > > 	#define KMB_PWM_LEADIN_MASK             GENMASK(30, 0)
> > >
> > > 	static inline void keembay_pwm_update_bits(struct keembay_pwm
> > *priv, u32 mask,
> > > 						   u32 val, u32 offset)
> > > 	{
> > > 		u32 buff =3D readl(priv->base + offset);
> > >
> > > 		buff =3D u32_replace_bits(buff, val, mask);
> > > 		writel(buff, priv->base + offset);
> > > 	}
> > >
> > > 	...
> > > 	keembay_pwm_update_bits(priv, KMB_PWM_LEADIN_MASK, 0,
> > > 					KMB_PWM_LEADIN_OFFSET(pwm-
> > >hwpwm));
> > >
> > > With CONFIG_CC_OPTIMIZE_FOR_SIZE the compiler (here: gcc 10.2.0) this
> > > triggers:
> > >
> > > 	In file included from /home/uwe/gsrc/linux/drivers/pwm/pwm-
> > keembay.c:16:
> > > 	In function =E2=80=98field_multiplier=E2=80=99,
> > > 	    inlined from =E2=80=98keembay_pwm_update_bits=E2=80=99 at
> > /home/uwe/gsrc/linux/include/linux/bitfield.h:124:17:
> > > 	/home/uwe/gsrc/linux/include/linux/bitfield.h:119:3: error: call to
> > =E2=80=98__bad_mask=E2=80=99 declared with attribute error: bad bitfiel=
d mask
> > > 	  119 |   __bad_mask();
> > > 	      |   ^~~~~~~~~~~~
> > > 	In function =E2=80=98field_multiplier=E2=80=99,
> > > 	    inlined from =E2=80=98keembay_pwm_update_bits=E2=80=99 at
> > /home/uwe/gsrc/linux/include/linux/bitfield.h:154:1:
> > > 	/home/uwe/gsrc/linux/include/linux/bitfield.h:119:3: error: call to
> > =E2=80=98__bad_mask=E2=80=99 declared with attribute error: bad bitfiel=
d mask
> > > 	  119 |   __bad_mask();
> > > 	      |   ^~~~~~~~~~~~
> > >
> > > The compiler doesn't seem to be able to notice that with field being
> > > 0x3ffffff the expression
> > >
> > > 	if ((field | (field - 1)) & ((field | (field - 1)) + 1))
> > > 		__bad_mask();
> > >
> > > can be optimized away.
> > >
> > > So use __always_inline and document the problem in a comment to fix
> > > this.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Hello,
> > >
> > > I'm not sure this is the right fix. Maybe the bitfield stuff can be
> > > changed somehow to make this problem go away, too?
> >=20
> > Note, this patch
> >=20
> > Fixes: cdbea243f419 ("pwm: Add PWM driver for Intel Keem Bay")
> >=20
> > so this isn't critical for v5.10.
> >=20
> > @thierry: If this is ok for you and Vijayakannan, you can squash this
> > into the original commit.
> >=20
>=20
> I am ok with Uwe approach.
> I have compiled the change and tested in Keembay board as well.

I'll take that as a Tested-by. Next time, if you go through the trouble
of testing a patch, make sure to reply with a:

Tested-by: Your Name <your@email.com>

So that patchwork can pick that up and credit you for it.

Thierry

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+1YXEACgkQ3SOs138+
s6FBEw/3awBAvUnh+nksrSY9JFy+t9mv49y7wgG5OByXye8slDSPF1UbZbQeje51
t0hG8kkiYZM/f7IeTagJq9FNLswpb/2O9MX8hTNNz9dE0NHczjLqyghb8V6IKUUE
DC0YYtzI59MdsWmFmgR/lb5BLNwRQf5QoIjDjwUAvfbPHt2JW1hU07m+L8+wcRCf
Taq7AER4cCslaobp1U90LUCzwtTvinphEd47+mu2iGvblbJnR2p1Z1FyamDIqAq3
17MpkjJOJijjdk0eQG6IjalVwTjvruOIDruinpT45PGhtjAIQEa4nQKLY/L75HqT
02YUv4vzy+XpyOsrvxurOP2Rpjav52djBPON45f8EAVTJAOeOEQ+GD28r9Dp1cid
74z15Dz34AtLCetycFF3aXI9tKZFz8hZjDoIqiescfa+YhnkiXUxDeVf1AcYM4PL
cuqkbmMW2eq3jYLbrxbMNNjvPYHbomq/0CjRViX8tZ5j0ooDSkj+38KEu83Kaf0R
OKK8mQiPA50AB8M6nIagN0+nhCcJau1uPKaBPM2cXGQ14wXPTTKcjXIdb2SINYsH
XcicIi3Z05puIeIV5E/8D6UQrvuzQi5qnIjfvvO4sWMvxW0lFm1ILgm6R1EbBdRb
NVGC1eRYCHG2OG6eYeV/xrCilFePCB8S8kCN1VRrilLZ0SyZMA==
=XsP/
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--
