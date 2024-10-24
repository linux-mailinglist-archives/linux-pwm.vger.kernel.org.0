Return-Path: <linux-pwm+bounces-3846-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18289AF425
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 23:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D42B21780
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 21:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76E91A7AF1;
	Thu, 24 Oct 2024 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LDiu6hG2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727322B676
	for <linux-pwm@vger.kernel.org>; Thu, 24 Oct 2024 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803698; cv=none; b=lAYaTC+1vY1G10YTgSq12jI2bbf1+Laj2bS1ii5cTckpS6qVmd+VBz2IMbIzOWf/kNuGunQ+KOWSu/thgCKbhXwp8eewHSJHTotvOWpA6ak4l0LL65h78FSUnGYu6kVnUO+uUH4c/YQ9DVbiElmU3mMI53hMMUeUnqpMo+JPmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803698; c=relaxed/simple;
	bh=uv7hyJ4FTR31Ja9uZHyKgXxSqgj6zZHZZ1kWSBNG9Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfxHNSI+Vn+MNenNbAZBdhfrZxfF6vmcEPlnfUisIEyzRQsyGmo5rjWgCQ3q7zDaZeo8uh22X73xxTvMfi50E1D+G0SFQKSv3K+FqEX4XKnvWpP1+yG4QVemQzxqMngORqU1g5fdbFv/K3U9Uvfti9RN8EJlllgFNAoIXLpu81c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LDiu6hG2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43159c9f617so13686475e9.2
        for <linux-pwm@vger.kernel.org>; Thu, 24 Oct 2024 14:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729803694; x=1730408494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vVeHxFOlpm7vmwFphRpkxStlmC/W0v5aNc36nSPpWmc=;
        b=LDiu6hG2SDJaP5mUtujVbfVdOsjKy0OmgY0zMRxHOBXNGREwAyB0c54vTxmG0FLbFL
         bN4KpEjKYF1AX7I/1Ojrd6TAJQNarynbSyBTtzV5IpuB3n8k4fZ2Djk4pWG5tztdXVWp
         7J2fj3aw3Di9KwSYzkj4XFqpE++pUgxIGp/Rr9yupyaO7c1Onazz2nXxXup3hcjxB0fC
         FgMcAz7eKZ348O/uxiknR9VDd4XfI1Z51svs5aisjahgl/B+CSzhVfLw/zUd2wnFwnxH
         y+SOt3d4G0Kb2ybZGEZvW4Pk85VifCT6QUQDFuKlTvq/E/b+6b6F4Qjmjf8dJJGNJN5d
         y+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729803694; x=1730408494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVeHxFOlpm7vmwFphRpkxStlmC/W0v5aNc36nSPpWmc=;
        b=BSMAPYk4TAcN/H8O0rqPzrflflNECa/UGkHWhwIycFwYSsINVqXxzqi5ghff9k6Ki6
         oAA17KY7PSLPe3lejivJCsUhgukrGaYPevCLURhw5itUDK7HyUEjd6EpdEw0Wxre5mfL
         Q3EbwQtqqpw8HTBMKsAHnrgSk7KPBMiHw7+BK/VeOeuxWYUJyDPlXalR4T+kSdEuNinr
         hAMVpipC84T24GACCdajtyI1hEOA9KeGhXj1LvXuBDkhXs0qmmO/x2HNRgOKRgCjWyYD
         svhbECiu9MRytsZeJ/LqOogS7FQIYKweTqU9QFxahfdIAl8fSY25NaBAnfHx603e2UqL
         0iXA==
X-Forwarded-Encrypted: i=1; AJvYcCV/zNvaCjkb0+ElhOG7A6eTCPrMcbZ0ekBdvTynrdZdr49oakJ29dMy9mOxwO3Gpw84rIR6yhKghNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/8el2AaodkPQ3rHCMwXrtUi4KchoeT3rw13p2wElIIVQPwkN7
	6yuKQO74ZAV/v90lWU/0WWyt2QD/qT5ABdi45okPruGSNIe4UZGd4KsriBGRzHc=
X-Google-Smtp-Source: AGHT+IHGL2Dd1tCBiG6JOVa+iPPOY+Ojg8AJron0OjLTDMAI3qhPj8i7GxizFBH7+p2Vte+JfMZqgQ==
X-Received: by 2002:adf:f80f:0:b0:37d:4956:b0c2 with SMTP id ffacd0b85a97d-380458f2712mr2168793f8f.58.1729803694102;
        Thu, 24 Oct 2024 14:01:34 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:b203:5494:7e5a:8c7b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b7dsm12123329f8f.24.2024.10.24.14.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 14:01:33 -0700 (PDT)
Date: Thu, 24 Oct 2024 23:01:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Erik Schumacher <erik.schumacher@iris-sensing.com>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v2] pwm: imx-tpm: Use correct MODULO value for EPWM mode
Message-ID: <wqjwdjqsjn5yngbkdpbinwtonxdpugy6n6nide7fcodhpto4hh@7yxigtrvvu2n>
References: <91bfd0c1726d2e6d10c96a3f2e141a7315b08467.camel@iris-sensing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vghwwyw4ni4jtc4u"
Content-Disposition: inline
In-Reply-To: <91bfd0c1726d2e6d10c96a3f2e141a7315b08467.camel@iris-sensing.com>


--vghwwyw4ni4jtc4u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: imx-tpm: Use correct MODULO value for EPWM mode
MIME-Version: 1.0

Hello,

[dropping anson.huang@nxp.com from Cc]

On Thu, Oct 24, 2024 at 06:41:07AM +0000, Erik Schumacher wrote:
> The modulo register defines the period of the edge-aligned PWM mode
> (which is the only mode implemented). The reference manual states:
> "The EPWM period is determined by (MOD + 0001h) ..." So the value that
> is written to the MOD register must therefore be one less than the
> calculated period length.
> A correct MODULO value is particularly relevant if the PWM has to output
> a high frequency due to a low period value.
>=20
> Fixes: 738a1cfec2ed ("pwm: Add i.MX TPM PWM driver support")
> Cc: stable@vger.kernel.org
>=20
> Signed-off-by: Erik Schumacher <erik.schumacher@iris-sensing.com>

No empty line between these trailer lines please.

> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> index 96ea343856f0..a05b66ffe208 100644
> --- a/drivers/pwm/pwm-imx-tpm.c
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -106,7 +106,7 @@ static int pwm_imx_tpm_round_state(struct pwm_chip *c=
hip,
>  	p->prescale =3D prescale;
> =20
>  	period_count =3D (clock_unit + ((1 << prescale) >> 1)) >> prescale;
> -	p->mod =3D period_count;
> +	p->mod =3D period_count - 1;

This looks bogus if period_count is 0.

Best regards
Uwe

--vghwwyw4ni4jtc4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcatakACgkQj4D7WH0S
/k4v5AgAoynsE1256Znci8l+VfnrzUQeRlgpkK0Dq4OS63K/RlHB1OdCuHwilJ3l
bblW1Og6wzb8hW/yic+otowhI+bH5gN7w4g+c2r/ktINgpKRQjAgg6vr0QGcfjj2
bHVxUoHZDyzwyfWT7bcDQcjp/Zm52nvCCdqe2e0247fKvFeXIMLOM2965MqHrpH5
BP23T5KLr52w1wz9OatP3YMG6blO9o2V+5qnzDo7qzs8c5vWRpwQWoS8OzEzJplQ
B1ldjt5+0A2exi6m0WjnNjt3YcYLbvCgrEt6TGuaYCHRoq23t+gDfofAQcpx/BLi
iY7/d+uS99AvcDUkbIQHNxk0M8i9Eg==
=HA4T
-----END PGP SIGNATURE-----

--vghwwyw4ni4jtc4u--

