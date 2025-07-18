Return-Path: <linux-pwm+bounces-6854-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ABBB0AAE6
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Jul 2025 21:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111531891503
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Jul 2025 19:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAB9202F8E;
	Fri, 18 Jul 2025 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CwHsqvg7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E86120101D
	for <linux-pwm@vger.kernel.org>; Fri, 18 Jul 2025 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752868739; cv=none; b=WXynpdKsx/TzMZqZjzqqw9Azi4o4K0eLBlgdrUiS6F9ZL33QAK4hoaXkhaOw7e7QlJ8nRKaOFQKhIYYRZVJvCX0lRKsb98wj3cfE94gUqkuI9kP2be/TkWoxwrsBNaYxfpRqKRKsSNQVBWjOvu39reeP+a3zEFPEPYZOaBSd5eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752868739; c=relaxed/simple;
	bh=ntRTCkdiLACtDDyxHl0JzZPk6ugxEpVRhEIHX4HyXsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVymgObd7gW64H7M8bmWGbUj+ZIRK4FL0TkaBiVnB4kXl+lv5VvY2h5sFd9a08VXkc/2IEIU77+2JsMaW0CnzH6zRtZk/e+6Isul8mttL47Bjz7bA7B1PkKeFKSrJ5qmxjdBbqwzJlTNWaXd9VddqmPFmGHAiMBhmTbMpXKAHeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CwHsqvg7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso3785949a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 18 Jul 2025 12:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752868735; x=1753473535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TG/A8MD9h2Qm+mGXUoB5bwhbq1t5xQPNJH1ji2Dq7cQ=;
        b=CwHsqvg7lQ9UWbSemVDKfgYOf+19arHOjavsYOERHuSiiZpLMeSnX4XLlKojMGfNfL
         tVN1p004uW+lQlFrGDD/oJg5WF8gkZFX+vDN85uei+26neQmh0g2SPp2S4+yvg8vxHCM
         oFsjVRBFedB8tOlIE401tkLm6ngwqSsLApdSrsNnKo6REbkpRvFrTfQEx163HxcrVO18
         6rasjgGhp2ze79NJjnuxMlrNbsAKakoTHr+ALzCF6ijwCFJyDUmfuTBj9nDPRUtDnu+w
         3l8tfzpONU3S/7+TaDzkZQxRDBg8qpTiomK13pJae0hwvL9r9BL7YzOyi4pqlUwUgY5v
         vDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752868735; x=1753473535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG/A8MD9h2Qm+mGXUoB5bwhbq1t5xQPNJH1ji2Dq7cQ=;
        b=wLREtfK3J/pnoJ038DH8tArBHB31Gtff7c2uPVY4bTD1vd3iGsxzZBOJUA/hhNKOy8
         ILk97XVrxnJIRQhj8N+YCnxPplf5JvwhzXyzUB4/AVfSGgMD3g1ZJIHf2Y5gpwsj7L1s
         ZSfDMVG0IiVCsOezFRp1lOjMWMHM2inORXVXYV+eRiqWlqDjmQeVioY4g4MOIZeneCl4
         PYvKov7srGivYATT1k2GLuDe/4fvSn/SmmzpaOEGbptqDBkNnKQ5eYdgsKWf5MgGLCbN
         GoIg0sP+xEoUs5DwVarIuqLPHukE2iJSW/dGO5foeptnIyKXSIRfjnjw/m9jpN8ZVriI
         CCQA==
X-Gm-Message-State: AOJu0Yyj9r6vIs2bbciSBQ8Cisi1/jRMsB/FxCTtitmRAgSvwMQW9WBL
	juDCEMMOERlLMNc7rLFxNbD5lcrak4Q0k3avdXZtgsPfZRDvBjWNo0qXcD+ZxgJBSoM=
X-Gm-Gg: ASbGncttKjWXJAk1ei47c3CgDLLZvxFZHZ/MNAqI/kA/gOkCQX5KLipAxzXu5QpkooM
	Q158MoImVHSrP8MSSV9Z8VH3MIOp5LpRhN5kNGCUWbap/xCOLnV4M7XQNBRJCj+Ca5OVd8oNcW0
	ycllwrGIU4fC0hlFAokuXXkhE7g9WtCUSvIupEUA2ILJvYU9GT8PbICcsCbNwxohvgvb+SVN1YD
	lf09OXliPYhiooGfZ7Cjcv3sVCFSe9u/IaqoJnhWfW38OCavH9IAGCtDc63h/2CgiZ9pld+w8BQ
	cEa09hOcmLXKnvXRzZx35xARBjqPpv2q48BBV7TdII1KqK6DPyEYiBf3rjOAhcFi31PrB+oZ/0z
	6RZyk1tVZrBYZmK1xwwdEmr8IHcY=
X-Google-Smtp-Source: AGHT+IGZLmz3m5l0IF0Yg7TQTgu7wIO/R+HbeCFkO6tY9HA7GXMvUK7u4rtRvY6OYiVsxWmV3DbWYw==
X-Received: by 2002:a17:907:1c15:b0:ae0:685b:5e9f with SMTP id a640c23a62f3a-ae9cdd82e9fmr1255906666b.3.1752868734219;
        Fri, 18 Jul 2025 12:58:54 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aec6ca3005bsm172320166b.88.2025.07.18.12.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 12:58:52 -0700 (PDT)
Date: Fri, 18 Jul 2025 21:58:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Clemens Gruber <clemens.gruber@pqgruber.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2] pwm: Provide a gpio device for waveform drivers
Message-ID: <sjhu4c7yjwbkl4c56okpwpjtufdi245ok2j3nsssrqfsrpybpy@nsjr3wrydhnz>
References: <20250717151117.1828585-2-u.kleine-koenig@baylibre.com>
 <CAMRc=MdVLxBcH7EbVC_ce_V74W1+pLTX0js5__db1puVwwXAnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fomhupbbsnhnwfob"
Content-Disposition: inline
In-Reply-To: <CAMRc=MdVLxBcH7EbVC_ce_V74W1+pLTX0js5__db1puVwwXAnw@mail.gmail.com>


--fomhupbbsnhnwfob
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: Provide a gpio device for waveform drivers
MIME-Version: 1.0

Hello Bartosz,

On Fri, Jul 18, 2025 at 10:24:35AM +0200, Bartosz Golaszewski wrote:
> On Thu, Jul 17, 2025 at 5:11=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > @@ -2449,9 +2494,33 @@ int __pwmchip_add(struct pwm_chip *chip, struct =
module *owner)
> >         if (ret)
> >                 goto err_device_add;
> >
> > +       if (IS_ENABLED(CONFIG_PWM_PROVIDE_GPIO) && chip->ops->write_wav=
eform) {
> > +               struct device *parent =3D pwmchip_parent(chip);
> > +
> > +               chip->gpio =3D (typeof(chip->gpio)){
> > +                       .label =3D dev_name(parent),
> > +                       .parent =3D parent,
> > +                       .request =3D pwm_gpio_request,
> > +                       .free =3D pwm_gpio_free,
> > +                       .get_direction =3D pwm_gpio_get_direction,
> > +                       .set_rv =3D pwm_gpio_set,
> > +                       .base =3D -1,
> > +                       .ngpio =3D chip->npwm,
> > +                       .can_sleep =3D true,
> > +               };
>=20
> I would have probably just assigned each field separately and avoid
> the cast but it's your code so I don't have a strong opinion.

This is not a cast but an initializer. The nice side effect is that all
unmentioned struct members are default initialized, so there is no need
for an explicit memset(..., 0, ...);.
=20
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Thanks
Uwe

--fomhupbbsnhnwfob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmh6p3cACgkQj4D7WH0S
/k7i6ggAsasseJwqk2bwjYrRTCy8aRkoGSy4ivEt5VlVtAzWnju2kTQ+ZHsX0EdK
4ZpUKvlY2BUEW+t05narXQp8U2cLNUbkH0lQRRgidu2zWuZw8+mPuaEnhGN1hPqo
diGMmomibe+2D25y7AX836MzltfVA0zHXYERqNWdK8iWKC3cMv5TrvABgrd4uOp3
P33BFHOSdJwPD7r7KO5AnMS+cRZnZ4F0u6tgEJJd8i5OyI4HtUol4kyYmJuBgtKQ
8l25SCvdTuCOfwiZwp/qnJEaA1DuhJpWLxIBOXaEXTqiyepvJr6CjW4Q0lP07Scf
w4+PzI7x6Rp77U/xlJ4aA/G4qkaYqw==
=LWCr
-----END PGP SIGNATURE-----

--fomhupbbsnhnwfob--

