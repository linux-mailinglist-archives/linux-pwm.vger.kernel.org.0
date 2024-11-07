Return-Path: <linux-pwm+bounces-4041-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA559C003B
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Nov 2024 09:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA37D1F23253
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Nov 2024 08:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095781DB377;
	Thu,  7 Nov 2024 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KRkkPbiI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE9F1DB37A
	for <linux-pwm@vger.kernel.org>; Thu,  7 Nov 2024 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968901; cv=none; b=PGlyufD0cC/Q0qvcoDIlZfIIBY45IGmdt+2Y9vKc/MpyrbQAOi0nu6wwy88nz8IcJblokHPaJXMnOsWB0sL0s1gwJxZsfoE6Ib0k+8Hm3Ul+sh2jZKGobnCWzfThBvPeh1/X2cpKj4c/AgUj860dCMMNd8g3/3CcOpyU4/5XpMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968901; c=relaxed/simple;
	bh=CB7srYCUAEX40VSb4I7Eiz7faqBurvgNAZpZuQNrTXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QO759YxS4ijMDgHdSounCB0g7qcv8sidqLh3EF3OBcu2yVBCSWyIqOGOcVkWCLFy+WZW+R4ywrcktOBns8f/auBgLroS3LFdGSpXXlxvm6O9s22Trvhxa5402VP/IrVZj2OOfCmZ4sBgzW1wDNsg4FWzRqBjO795Nv1Ea9KuTf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KRkkPbiI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso86037766b.3
        for <linux-pwm@vger.kernel.org>; Thu, 07 Nov 2024 00:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730968896; x=1731573696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCBwFpuOJkUFhUsOyTcZgxDubddLr0CvKoCO+bs50mg=;
        b=KRkkPbiIGdyLklAksS3GhkOMnLihmdjM5SZ14qfQRI+DKDUEBLJ8T32ZVx05OeDss4
         Yl0tAeBymohq26loXv3Su947NuByLwTt6I6fuPta9yGD3LJbbxmw7IF2HKF+aBVlPDOH
         7QknMTTcdbcuLBf6dt6f2DLqPjqtda4aNCTavbgidcqfHTkPbXIhLuzy+I+/vtTCn3f9
         qi9VJ9xVMEMDzwzQ7jN7iFvWy/w6wJgR2oRYGnTkeHOCauOIwoCRmQO01YLYrG2gXnug
         9q5IJer3i9GDVxk8glN+mUgZWHDGjtpahmxhVf3KxC+aEGgyFkIRVOd90lrsuLqqbctd
         HuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730968896; x=1731573696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCBwFpuOJkUFhUsOyTcZgxDubddLr0CvKoCO+bs50mg=;
        b=Ljy6dKNv3S7mzMykYhPmqYRe6EBcOtK/4Vme1BeZyZ+OpGq3KaVgkfnngrzwLGcv9U
         AMTjQ8lGn+CtPPDFka7aNj59+Ix+utB+PSbPz1mckdPC6KjPAuBjaMY/oHAFNRXOkYJu
         dE/wnd0u8JH93HuKgA5BoAhV3YfRxJiXd7AJTGu1a/0R+9qD0L0VeQscP1z9drU5FKQ3
         5GrGiUFsR9CC5q3v9t6HGEubAeQaECT89jCSRFH5a7aUTr1uNWU6jtCKMhB3mQ6vq0FY
         9axxoG0DnXiCkw6I0CnxvXbdd5WCy/slLmt2vw1Ypd21oOUiHhZjiPBm/D7xcJFe0lrB
         i3dg==
X-Forwarded-Encrypted: i=1; AJvYcCXoXxWtIcKZa5w7ohnd9ECEFQt22esbIs24xZrD2bDk0siW+TG2VWSXf9NYUVoBsU60rxDY6Am8zrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOhBxP8oD0/RiYldZLT3O7OZBXDQ3GVeZfVNmlBS3DBHM1GpOs
	+0M7y2IyGMT9jLAWpRtP9ajatZtxa5xmfjIIZvn7oQh3popQlGzcULdh2G88a9A=
X-Google-Smtp-Source: AGHT+IECtbyHGknyaysdu7uNuPBdqFJ/lC8OST23yihlsX4TuSJya+GcgvzFJKIKUAa2ZP1s0r51nw==
X-Received: by 2002:a17:907:1c02:b0:a99:a9b6:2eb6 with SMTP id a640c23a62f3a-a9e652c179emr2216146166b.0.1730968896486;
        Thu, 07 Nov 2024 00:41:36 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a46119sm60879066b.46.2024.11.07.00.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 00:41:35 -0800 (PST)
Date: Thu, 7 Nov 2024 09:41:34 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: George Stark <gnstark@salutedevices.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@salutedevices.com
Subject: Re: [PATCH v2 2/4] pwm: meson: Support constant and polarity bits
Message-ID: <l5xvdndysdvtil472it6ylthcfam5jp7lh3son45mezq7dh2yk@3yj557k2o5k5>
References: <20241016152553.2321992-1-gnstark@salutedevices.com>
 <20241016152553.2321992-3-gnstark@salutedevices.com>
 <w3igi2jmva6mfa7anlieyp3iiwfzhsvi3t37wwcqqtzdy42fqn@btmdsfsmpw7r>
 <f08513c8-56d6-4551-8ac6-84641c134552@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ur3dmr5dbhirxpm"
Content-Disposition: inline
In-Reply-To: <f08513c8-56d6-4551-8ac6-84641c134552@salutedevices.com>


--7ur3dmr5dbhirxpm
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/4] pwm: meson: Support constant and polarity bits
MIME-Version: 1.0

On Wed, Nov 06, 2024 at 04:54:41PM +0300, George Stark wrote:
> On 11/4/24 12:32, Uwe Kleine-K=F6nig wrote:
> > > @@ -68,6 +72,8 @@ static struct meson_pwm_channel_data {
> > >   	u8		clk_div_shift;
> > >   	u8		clk_en_shift;
> > >   	u32		pwm_en_mask;
> > > +	u32		const_en_mask;
> > > +	u32		inv_en_mask;
> > >   } meson_pwm_per_channel_data[MESON_NUM_PWMS] =3D {
> > >   	{
> > >   		.reg_offset	=3D REG_PWM_A,
> > > @@ -75,6 +81,8 @@ static struct meson_pwm_channel_data {
> > >   		.clk_div_shift	=3D MISC_A_CLK_DIV_SHIFT,
> > >   		.clk_en_shift	=3D MISC_A_CLK_EN_SHIFT,
> > >   		.pwm_en_mask	=3D MISC_A_EN,
> > > +		.const_en_mask	=3D MISC_A_CONSTANT_EN,
> > > +		.inv_en_mask	=3D MISC_A_INVERT_EN,
> > >   	},
> > >   	{
> > >   		.reg_offset	=3D REG_PWM_B,
> > > @@ -82,6 +90,8 @@ static struct meson_pwm_channel_data {
> > >   		.clk_div_shift	=3D MISC_B_CLK_DIV_SHIFT,
> > >   		.clk_en_shift	=3D MISC_B_CLK_EN_SHIFT,
> > >   		.pwm_en_mask	=3D MISC_B_EN,
> > > +		.const_en_mask	=3D MISC_B_CONSTANT_EN,
> > > +		.inv_en_mask	=3D MISC_B_INVERT_EN,
> > >   	}
> > >   };
> >=20
> > So the generic register description describes the const and invert bits,
> > but it doesn't apply to all IPs. Thinking about that, I wonder why this
> > struct exists at all. I would have done this as follows:
> >=20
> > 	#define MESON_PWM_REG_PWM(chan)		(0 + 4 * (chan))
> >=20
> > 	#define MESON_PWM_REG_MISC		(8)
> > 	#define MESON_PWM_REG_MISC_EN(chan)		BIT(chan)
> > 	#define MESON_PWM_REG_MISC_CLK_SEL(chan)	GENMASK(5 + 2 * (chan), 4 + 2=
 * (chan))
> > 	....
> >=20
> > and then use these constants directly (with pwm->hwpwm as parameter if
> > needed) in the code. I would expect this to result in more efficient and
> > smaller code.
>=20
> I've been looking into this driver for more than a year and got used to
> it so much so never thought about changing the foundations :) Although it=
's
> an interesting thought.
>=20
> 1. I took meson_pwm_enable() without
> const patches and reimplemented it using only defines (e.g. w/o local
> var channel_data) and objdumped current and new versions. New version
> turned out to be one instruction longer (arm64, gcc, default -O2). So tot=
al
> difference in executable code may be not that significant although
> we can win in C-code line count.

Oh, I indeed would have expected a slight advantage size-wise. Maybe the
compiler already optimizes out the meson_pwm_per_channel_data variable.

> 2. Things like
> #define MISC_B_EN		BIT(1)
> #define MISC_A_EN		BIT(0)
> is more straightforward and can be matched to the datasheet easier
> comparing to (a + b * (chan)) things.

In my (subjective) view that comparison isn't hard with the
parametrised definition.

> So I'm not sure either.
>=20
> > > @@ -227,6 +252,15 @@ static void meson_pwm_enable(struct pwm_chip *ch=
ip, struct pwm_device *pwm)
> > >   	value =3D readl(meson->base + REG_MISC_AB);
> > >   	value |=3D channel_data->pwm_en_mask;
> > > +
> > > +	if (meson->data->has_constant)
> > > +		meson_pwm_assign_bit(&value, channel_data->const_en_mask,
> > > +				     channel->constant);
> >=20
> > Personally I'd prefer:
> >=20
> > 	value &=3D ~MESON_PWM_REG_MISC_CONST_EN(pwm->hwpwm);
> > 	if (meson->data->has_constant && channel->constant)
> > 		value |=3D MESON_PWM_REG_MISC_CONST_EN(pwm->hwpwm);
> >=20
> > even though your variant only mentions the mask once. While it has this
> > repetition, it's clear what happens without having to know what
> > meson_pwm_assign_bit() does. Maybe that's subjective?
>=20
> Actually I also don't like meson_pwm_assign_bit() too match and I'm
> surprised there's no something like this in the kernel already.
> I again objdumped versions meson_pwm_assign_bit() vs double mask repetiti=
on.
> Unconditional bit clearing takes only a single instruction:
>=20
> // value &=3D ~channel_data->const_en_mask;
> 9ac:	0a250040 	bic	w0, w2, w5
>=20
> So in the current series I could drop meson_pwm_assign_bit() and use:
>=20
> value &=3D ~channel_data->const_en_mask;
> if (meson->data->has_constant && channel->constant)
> 	value |=3D channel_data->const_en_mask;
>=20
> If it's decided now or later to drop meson_pwm_channel_data then
> w\o meson_pwm_assign_bit() future patch will be line-to-line change.
>=20
> What you think?

Sounds sensible.

Best regards
Uwe

--7ur3dmr5dbhirxpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcsfTwACgkQj4D7WH0S
/k7W2ggAiWbFklqZfRb0lCzJW9msXnzW0j2vYPkmdTdU4UXb+bz4Nc/vo6AbIG4V
zgaSDWYTwULDPzgKvkP403SAaZeB6Jg875zyty8nLVyCuydPE9LM7fc598PPzfUf
8VgBR7p3x7iq/Zlnpb5btp2o3nCwniHPCc2wsjooAYy6j50dCK1UVvtlbJL8zzN4
vgc98VppmOeutOa8/2ZhcXhczb5pgJfCviPGyyXlwoaeHB7WV358AkaOcvcMpDbN
1TKOPew6x4fiRd56KOzN0C/M1Fpb3DSPhf21z3kdo/9LKPnap/sZ1Au22xOHTawD
+8ZSV6hZqzueMQJQY307eFT+otZ9hg==
=7j4z
-----END PGP SIGNATURE-----

--7ur3dmr5dbhirxpm--

