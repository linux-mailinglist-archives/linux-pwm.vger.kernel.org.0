Return-Path: <linux-pwm+bounces-3442-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8ED98EC4A
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2024 11:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F022C283AF4
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2024 09:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28347146A71;
	Thu,  3 Oct 2024 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BjjB3SAh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903651465A1
	for <linux-pwm@vger.kernel.org>; Thu,  3 Oct 2024 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727947671; cv=none; b=Ld5SX2WLAjPDSzPkbuWNTTquxuf4WNlWqKWhs2Hm1F1vlWgAmjdeokwZX1xgrZms7Ao+XjFTatICKE+Y2RCmYe3dzdNwVbzXkxR1QZS0XiRcvkF9EXliiZwmmPblyz4aHabLE/P1eiUIxS7rmorFk/hAAKkHjbfbGByGm2694WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727947671; c=relaxed/simple;
	bh=uXkA1kXEXhP7MvBmfvAhSdLcx27NcgjN9m+rUt+dGzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0YBdPRISG/yspwjP3VFSPAiXZQ8SHnLp18WbFtCKORooAfPLx6Wwo9pJmNn8+FaEqbWx9c8HDIXP0J0/xcsuIoQTbhOkP354Rb2Yks/X9W/Yhh3jOr444A/LE1IVBMcj1h1hzGoKaNEY3wmhuAcrIJR4VnkRu6rRP62cE118Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BjjB3SAh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37ccebd7f0dso530013f8f.1
        for <linux-pwm@vger.kernel.org>; Thu, 03 Oct 2024 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727947667; x=1728552467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8evBbk/IwxxgJLl6adf7U2FK+xKf3XGZPnSLuIWsvAs=;
        b=BjjB3SAhywIBwg5O3WxWkrzYtTHxIf7YgS3Ornn3QgMO0/rvQKP+a5YEz9xciY8mCr
         vTGhznu+ya4ZYLN+JyZVX2TQvesiTSRU7PmNEWfXEy4B57rWgFrvCVsh44bKrYvVW/Ae
         H41lVdxZnA7RI4Al7NM1kh2xxSJJuWvuUDwJhARux3ZgPmy4dX5ikLAp9NueyxlIYboA
         bu7BVDsYhfzbID3Y2mF+flps70W0zWMw6LVO2nm1vbaZOhi5vSMZGx4/ycNHXnr3qPe4
         qoARx+GxLSmKuLLGr+9mcaPZeOq+C2LVxt6Uhgn3FVgCpSGD7AZTbAlgNfY27ZUZDfAW
         cGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727947667; x=1728552467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8evBbk/IwxxgJLl6adf7U2FK+xKf3XGZPnSLuIWsvAs=;
        b=QSru8x+SddnLmwPfVNjHZLuxlwocHXNCli4b6tG0V0hbhXG37EiWcl99rhWz6sJ9lk
         3pr6bG3bOw8BJ4iDW7z2/be1IfVn2RlZYrPhKLledQ3ZxYBlXMxcsITjY+UCD7aUlgns
         1UwZ+C+c1iwX4PYQzlVIaDHqZQkW85DsMkzAUKAIYDmdfM+d0NG6iXyVzDAYUdFc5rX/
         Q1hrqSX51uBgdNecN3DUecMFz0qIDWFH0EVdwcENhAmMRIbrmvT1qmPDdi+0hWO6LW+o
         RjjkfB1KQRBzASVglhha8x/UQ2emJcDXON8b9UCRPXmkCwjU7O5U8Fn89w4qqyi08DGQ
         QM2w==
X-Forwarded-Encrypted: i=1; AJvYcCVHqT0ktivZNeIrPz0KmW9+b3V1jMdCwxLN8Lh5ATIxvPBPlowWmm1/Vn3FdJsMahc4eDInqB3JUOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwYpgr6PElo4ZamsRtaYhqdtjx24P2TMndpEb4QWtIcGIovg/u
	2uyF/WsY2NodKs8zD+JZmxp9jZ9H4WNv56Xgg7Ognhjt+0fjrKZ3AMgWHZyaIL0=
X-Google-Smtp-Source: AGHT+IHekoCrEouitVYfb8Yy3HlP99xd5ZykhItjucwYVLFSB9uXwVt08HFWHlBeglYtqaJQ2Pm8Mg==
X-Received: by 2002:a5d:4a90:0:b0:37c:d344:8b42 with SMTP id ffacd0b85a97d-37cfb8b2ec0mr3807558f8f.15.1727947666441;
        Thu, 03 Oct 2024 02:27:46 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d08242d79sm847425f8f.51.2024.10.03.02.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 02:27:45 -0700 (PDT)
Date: Thu, 3 Oct 2024 11:27:43 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Mehdi Djait <mehdi.djait@bootlin.com>, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v8 0/2] Add driver for Sharp Memory LCD
Message-ID: <q53inyaxyvfib7okxzazepxzarqmq4rubbasumvvx2woioyp42@fbtn4poujsyh>
References: <20241002033807.682177-1-lanzano.alex@gmail.com>
 <t4lefcykpoe5i36wb4x5u23sseh6drnphtivuqc3mjviat2vvc@7hg4jyhxvpye>
 <ees3m2qmazah2547ys62zvbrvo4dsgki2z2jwulwz4dfjtm4hk@kpmlapv6occv>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s5o77kb33dofvcnw"
Content-Disposition: inline
In-Reply-To: <ees3m2qmazah2547ys62zvbrvo4dsgki2z2jwulwz4dfjtm4hk@kpmlapv6occv>


--s5o77kb33dofvcnw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alex,

On Wed, Oct 02, 2024 at 10:33:13PM -0400, Alex Lanzano wrote:
> On Wed, Oct 02, 2024 at 09:56:38AM GMT, Uwe Kleine-K=F6nig wrote:
> > On Tue, Oct 01, 2024 at 11:37:35PM -0400, Alex Lanzano wrote:
> > > Changes in v8:
> > > - Addressed review comments from Uwe
> > >     - Replace pwm_get_state with pwm_init_state
> > >     - Use pwm_set_relative_duty_cycle instead of manually setting per=
iod and duty cycle
> >=20
> > You didn't explicitly mention that it's fine if the PWM doesn't emit the
> > inactive state when you call pwm_disable(). You're code should continue
> > to work if you drop all calls to pwm_disable().
> >=20
> > Ideally you mention that in a code comment to make others reading your
> > code understand that.
>=20
> Sorry about that! The intent of the code is to stop the pwm from outputing
> when the display is disabled since the signal is no longer needed. If
> it's best to emit the inactive state rather than calling pwm_disable()
> I'm fine with making that change.

Calling pwm_disable() is best iff you don't care about the output any
more. If however you rely on it to emit the inactive level,
pwm_disable() is wrong. I don't know enough about your display to judge
=66rom here.

The code to disable the display looks (simplified) as follows:

	if (smd->enable_gpio)
		gpiod_set_value(smd->enable_gpio, 0);

	pwm_disable(smd->pwm_vcom_signal);

so maybe the logic you need is:

	if (smd->enable_gpio) {
		gpiod_set_value(smd->enable_gpio, 0);

		/*
		 * In the presence of a GPIO to disable the display the
		 * behaviour of the PWM doesn't matter and we can
		 * just disable it.
		 */
		pwm_disable(smd->pwm_vcom_signal);
	} else {
		struct pwm_state state;

		/*
		 * However without a GPIO driving the display's output
		 * enable pin the PWM must emit the inactive level,
		 * which isn't guaranteed when calling pwm_disable(), so
		 * configure it for duty_cycle =3D 0.
		 */
		 pwm_init_state(smd->pwm_vcom_signal, &state);
		 state.duty_cycle =3D 0;
		 state.enabled =3D true;
		 pwm_apply_might_sleep(smd->pwm_vcom_signal, &state);
	}

?

Best regards
Uwe

--s5o77kb33dofvcnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb+Y40ACgkQj4D7WH0S
/k6Jjwf/VkhVbrj5zZduvEjBR6Ryq5075XnahyFTpoqckqRcE+V8H/OzEfaT7fsA
VAT9CFZPEfJ02N0jj2m4V82vzDlwk8m9Tiw0b8m5eFB3NeJLpKUh4Fi4Np3Lp5AK
jIiCwhOEUY6Iw1bWsW2qj66Cism13MQ0tUlq43y7lxHNI/RzrysnZxYFX0FGCfkg
PDQp7WW3JWJF3uH4yr1Mycw1gSzd0ECUG0/VG4rwiqc+jr7H2FYU3tcnVZgNPsD4
Na680Wj75PWN6l5SYDEj04196IvNGz2psPJqxpaWwrtHquBLYQ/MvNXJ3XX21PnV
k4ppnw4FCPFAuN7nTlta4MWjKi66gA==
=YxME
-----END PGP SIGNATURE-----

--s5o77kb33dofvcnw--

