Return-Path: <linux-pwm+bounces-4717-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5DCA1A649
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 15:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C4D188A421
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 14:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB43211712;
	Thu, 23 Jan 2025 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="avsuKqSs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433120FAB7
	for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2025 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737643932; cv=none; b=oy4rdqFI3HC/Ua12Fx5pEgBKdEwMMB2uEhhTRVRj7zAq/FU+hbQn+FtYyllTrxqHZaWQak137ruF99N2N9ff7K2h1QrMwOfyzUWss3+uMCn/8t2PT+VeTLJ/Wj1OOw7UOec0saqmawnSAAXlnEzxQgarReRG4wzKxmdxN/kSgh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737643932; c=relaxed/simple;
	bh=ePqn/vWgfspoR/wDr6Rz3z242AQ3HAozUcwW6cvj9X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+q+Vra3xfd20yWLaK52meVJ7ofaQXZFtetNp8p5V3XqT696GnwVijy/HF8szNGTxdh5uRiwse+DINoJNYroWsZyvT2dHq4jCVUGIdLoUkZyzqtOOS7NplYk88sZj6sSiy+iJ9L62yGx3HCoH9pqFfk/OaoHpoqbmtfI0c6SzL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=avsuKqSs; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-38632b8ae71so770435f8f.0
        for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2025 06:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737643928; x=1738248728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePqn/vWgfspoR/wDr6Rz3z242AQ3HAozUcwW6cvj9X4=;
        b=avsuKqSsTrl3CNd7+qyHvqbOIqOn9iyfsc9drxOWoLgutTie4Oj0gv+RjCgMlwhVlU
         6qNZhXUGQma0upGEvxD6HJKq70jjHacWVzSF7dVbFwuZkYOIRqy1myAh1BhRakL+CWFU
         6q8KNvN1d0aITek9wkFl0UgY98i4f/hnA7N3bfzGKa+drcNHLei1GGJFNqoKF+DQh/O2
         dgGfwGQmG6i8iNHwbuWYdLHOcFp3U/dmLDL7gKMQzeP2PzcprsC095DAOIz8z6arNlVy
         YxJ9IzCru6TifQh7jKXBTvjeFnj1IHGy/S9lD+4dmAo44pdYDMpaWQOEYZ/RlrOvZpJP
         hCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737643928; x=1738248728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePqn/vWgfspoR/wDr6Rz3z242AQ3HAozUcwW6cvj9X4=;
        b=JSJ4c/x6MiEKGvD62c3qA0TTqDVoiCnPuEBcBpFu1MGCH9VZyUaj6aVlYEtmKlC4Zv
         KEF4zvuIudM25UsoMZPtAFbaGYopg7+ScJcmQQHm0/VDxP7HzmcmwYvDX7Rj5um1M13D
         zYpAFHKl/PjYCc2e1SG0EtxwamNy0KZ92Sk4qPogASoDBnuDt9L2fbbP981Uz6Ol4jCE
         2iBvSP8XlOvcEPbfPUTBFI0bVmA7LKKXeae2v8eWM2RviLZ4N2kyIsm/sGPUt/mrVA3G
         6y06VB/2jx4sOria3te1ynJiE7Z31Vs69zi23Cy4kb9hlRQ7CAvPNIgewAIv7e2W6dEH
         NtLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNgDR5jg8Q9CfkWo6sdvpLCV1xHgVUkFnG4+thrVfDhJ3EqDF3I2/qCiZK8HCImxkygN6CghTZEMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp1UBO3jTwNzqejwEsT+STk/k5QgBmUvS2xZQgDPRlIE2wiItN
	6slAMdiYGSD3+Vsv7Yx6W/bSJeCk8dosrrXUejAzsRR+tVo8kft/ES1vWhUBA+M=
X-Gm-Gg: ASbGnctQuNfLPkNfzIf3DbEoIuv0gv475rfBNBzAfz73NUK826zffW+fyDTzULBLueF
	xxF0JWUFhj5YTTh2g2fDAzkxIbKQ4QaFfUsN0bPyNfQr/KRL7MPHFnCMJ2TYXIDyJDCmn4+x0t1
	dPAgVGaTnKVzlnkoXpuo3C/p+AwkxXgCSuHBm4Wl9Pngz9ZY9avyncD/SYVdUwryFfz/5sLTQHb
	q4/pUeya4mt8RsiJbXudlqIxc863DnYEA6uIkc0NEuXvhFmEY4Ggzo7P47812O0ThxN2uUgLqqS
	hU+t7nmsWwOp6KMM13KaZ/ffvBAgaLqEZOsEvbXbPkIZW6A=
X-Google-Smtp-Source: AGHT+IFQqQFuSvvLQovWoq7l7qVc46JD3mJZP7FB9H76VfbS6zWrfPAG5QiWQlKCEuU308j8Ay4Ghg==
X-Received: by 2002:a5d:6dc5:0:b0:385:df5d:622c with SMTP id ffacd0b85a97d-38bf57a49a9mr15490857f8f.30.1737643927939;
        Thu, 23 Jan 2025 06:52:07 -0800 (PST)
Received: from localhost (p200300f65f018b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f01:8b04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275501sm19868153f8f.65.2025.01.23.06.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 06:52:07 -0800 (PST)
Date: Thu, 23 Jan 2025 15:52:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pinctrl: intel: Import namespace for pwm_lpss
 function
Message-ID: <gw223bv34jyszlssyegvz2znb7q4zzh3lax2qgmvcx6m5lvy6l@gpuvyyhvsgf7>
References: <20250123101110.339337-4-u.kleine-koenig@baylibre.com>
 <20250123101110.339337-5-u.kleine-koenig@baylibre.com>
 <CAHp75VekFNu8Jzfit5euj2pKeesGHs3DQS4hJdT==RM7MONb4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hvlslgkc3i6hkyqs"
Content-Disposition: inline
In-Reply-To: <CAHp75VekFNu8Jzfit5euj2pKeesGHs3DQS4hJdT==RM7MONb4g@mail.gmail.com>


--hvlslgkc3i6hkyqs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] pinctrl: intel: Import namespace for pwm_lpss
 function
MIME-Version: 1.0

Hello Andy,

On Thu, Jan 23, 2025 at 01:45:17PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 23, 2025 at 12:11=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > The intel pinctrl driver can provide a PWM device and for that needs to
> > call the function devm_pwm_lpss_probe(). That function is provided by
> > the pwm-lpss driver which intends to export it in the "PWM_LPSS"
> > namespace. To prepare fixing the pwm-lpss driver to indeed use the
> > "PWM_LPSS" namespace, import that namespace when used.
>=20
> ...
>=20
> > +#if IS_REACHABLE(CONFIG_PWM_LPSS)
>=20
> > +#endif
>=20
> Why?

Because devm_pwm_lpss_probe() is only used #if
IS_REACHABLE(CONFIG_PWM_LPSS). Without the #if but with
https://lore.kernel.org/all/20250123110951.370759-2-u.kleine-koenig@baylibr=
e.com/
this results in a warning (with W=3D1) :-)

Best regards
Uwe

--hvlslgkc3i6hkyqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeSV4sACgkQj4D7WH0S
/k4x9gf+NnL8LfFHYku17Uep22q+3Me5sNMn5sNQ4ZwHRoLfkF8sw9gYzDqpWQbM
9wP/TnjL18DlYCsyyGL9azM19zT439A9xYtCviXUYhWdm42cpXs/QqzWYh04u7+/
xuYyHkOFazWIpExIBayZ7f8LvMLyE5n1cqsnXKwHqqgOlrYM88EHbD5RI8tRoHDM
dBi/yUiqvNEOvNorKrPQb8PxTC1ZcuvSgLnl/y32Dxlg7IkKJ4amw4qLKj35O4hr
9nEre2uGzo/hyEiQY62i6boLx8U4FgoRYoI7TBADXwlnVSblgc6+0+S18GSpwh6V
P6cB0XzjXYOGJvjjWwvTlKImxS7f0w==
=+gxQ
-----END PGP SIGNATURE-----

--hvlslgkc3i6hkyqs--

