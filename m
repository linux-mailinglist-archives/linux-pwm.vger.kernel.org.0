Return-Path: <linux-pwm+bounces-2444-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D42D907DA3
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jun 2024 22:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD848B23BD2
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jun 2024 20:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A91B13B5AC;
	Thu, 13 Jun 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BxZtckS7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8B7763E7
	for <linux-pwm@vger.kernel.org>; Thu, 13 Jun 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718311596; cv=none; b=T18/JweXkL10inr0qsM4MJBHuD5C7ECXkUec4CuubMUWGUx85sRmfWW7AFT6X7L1KEF068hd5awgqngPPw/gPOjT7Ae1NDlSrG4pBBgCZxfAnOfIGWjik5ASTcb7IvC/jcZkLslDIxFfA4mKO/h7ux2SSOSsrtGWF/990Q8YJxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718311596; c=relaxed/simple;
	bh=CnHZb9z25XNpR7nxuaGQfAj2reg5e5IRMmuc2RvoCGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5XZ19BAc6fXl4IbjHSKk46jfvl+6hBF/bemTs7/q1UB1cWZ0G+tlJICsTf70GRNMfbc311g/QKW3rlR1X0zM+0TZsP9WNAhe/d6WdhrUIhZsajgdy+0BzvbUdonD82GGNgG9OL9xAXyxU9TyyAK6yl+KhGwQIOxb4IgAUoPeb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BxZtckS7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57c714a1e24so1574006a12.2
        for <linux-pwm@vger.kernel.org>; Thu, 13 Jun 2024 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718311592; x=1718916392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N5+He79jybhHTCYOhSX8BgQBoEHtDE3sqg7uCiPqItM=;
        b=BxZtckS75VxW0r54FGyng3f1WF/gyGjXrvLUAwjbE/yWooVn+6jjGY0OEPEhpJSNhZ
         aO58ICN1SUi/U/TJiVT4L6Gv6ur9FAbQ9tYTRmRIn8fwcTyNPeQ5MXDUI3S6kOFqpJx7
         FmE/DNso4IYf5lA9gzgaf6PB8sLD+tTUhNLRo2/uQbFAT7s1kLE0Z27nJ2ctCp67uOkU
         TXugI4mjzg3Mm+dvc241j2J8xDStZ1hZ1L93rn1Yt0NSm+NbjKsxa4ZXHxhpA5kU7hP3
         Brj07GUwzvk2VRWp/R6/kTq+Ksu200pDAZ50+wonggcdRa/PwC0+TBcITT3uorg/oh6a
         CKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718311592; x=1718916392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5+He79jybhHTCYOhSX8BgQBoEHtDE3sqg7uCiPqItM=;
        b=VZ2FUNAzF4LD8jyEOfrQiXWQ/omb9I1U33BtupIvmOjdtBQsij1vE5LxlsSy2t4qto
         a3pHovwOzgy6Avp6Sl2g8mMU3zRe0uuIeFk7d4jknNchBaGlXW2Kn2fgCU2Vw9LJiMl7
         XluXzRBP9aYpoaT1O6NJ+qBgD/oBKAaNI9OjZKMiBgg+hb0CI+FiwZPNq+UOi1rIH0qn
         LIvzOGtF/Cn0lpw3zEcaAEdWR7qZieqTTai/j/1tHV4kFibdWUk5UKjWvRQAmDZNFE71
         QxVHQ4LLubt4s2e5ATa+y8RDbQWtuTwNN1IvJXYbf+Kx88mbC1EW82Ir2+KCSgXp5JGx
         QxaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxECZlJz6C3wk+tmJ/Mi5G/cx8trA6qHBSSaNRYa5NDwCuNOuAXPWGvNksBtLbpHUGDPvTtgJOXuutkx9moOHpAh8BzGTOBnDy
X-Gm-Message-State: AOJu0YwRfn4iiPFwQ/ciRoku8tbLMelpG54P+NklZh+lTkMDu0R6ouHA
	ODsgpd66uHJQe1LGL+3GBmLCoHmYBdOE8wmakDLoM6sA1+eo0G4Mmjd5A6SmHwM=
X-Google-Smtp-Source: AGHT+IFtpOzE8kKqoKpYLmM4FbNCxftMEW9YZ0CGmabwa7MvW6sl7qRnrlLjm9/uGQPw+uKoNnSNBg==
X-Received: by 2002:a50:a45c:0:b0:57c:b83a:fef5 with SMTP id 4fb4d7f45d1cf-57cbd8b9be3mr598711a12.34.1718311592344;
        Thu, 13 Jun 2024 13:46:32 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:78cd:4cb6:e3af:4473])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e702sm1342351a12.70.2024.06.13.13.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:46:31 -0700 (PDT)
Date: Thu, 13 Jun 2024 22:46:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: 
	Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, kelvin.zhang@amlogic.com, linux-pwm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Junyi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v8 1/2] pwm: meson: Add support for Amlogic S4 PWM
Message-ID: <tnwdnwiruoty5yd42bmkupgg6hjxib5lblhqcyouoyx5y3zvnq@2d7cnrei24m4>
References: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
 <20240613-s4-pwm-v8-1-b5bd0a768282@amlogic.com>
 <1jfrtgj0so.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="atnwtc63iuembv37"
Content-Disposition: inline
In-Reply-To: <1jfrtgj0so.fsf@starbuckisacylon.baylibre.com>


--atnwtc63iuembv37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jun 13, 2024 at 05:54:31PM +0200, Jerome Brunet wrote:
> > +	for (i =3D 0; i < MESON_NUM_PWMS; i++) {
> > +		meson->channels[i].clk =3D of_clk_get(np, i);
> > +		if (IS_ERR(meson->channels[i].clk))
> > +			return dev_err_probe(dev,
> > +					     PTR_ERR(meson->channels[i].clk),
> > +					     "Failed to get clk\n");
>=20
> here it is ok but ..
>=20
> > +
> > +		ret =3D devm_add_action_or_reset(dev, meson_pwm_s4_put_clk,
> > +					       meson->channels[i].clk);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "Failed to add clk_put action\n");
>=20
> ... here, devm_add_action_or_reset cannot defer, so dev_err_probe is not =
useful.
> dev_err() if you must print something. Just "return ret;" would be fine
> by me

I don't agree. dev_err_probe() has several purposes. Only one of them is
handling -EPROBE_DEFER. See also commit
532888a59505da2a3fbb4abac6adad381cedb374.

So yes, please use dev_err_probe() also to handle
devm_add_action_or_reset().

Best regards
Uwe

--atnwtc63iuembv37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZrWqIACgkQj4D7WH0S
/k7GIggAqVAdsuyCU4qUCiRosJKIKXIHaUcrhQLdIciPH7mkNTw3UOw9RTgdygIt
RRtsP2rXk6hKJtbI/SA234syDPp/2zlmkDOk475vviRgmnxGpQiw1/C9/emfGYX4
bOHhBHkSQvxKjGIWhuFSHo3dy2h0iAYYZFZSiNfvrydjAOA3ERRtgJf/hZUS8zpt
ogHtoO6hD545xuoG8gLPIMest9lvd/W0PdyyQnqyx5+X4V6QyBBAmjuKnSMMpr0W
5NtJr0vvFaiH+NAvi38WFBUzF5KkQyUF/Qi2PQf7r1wzIULlWdC7CiDFcLDA5+l5
aEYn8Zg3ghfFXda0jlvgTNItV0D8sA==
=7F+E
-----END PGP SIGNATURE-----

--atnwtc63iuembv37--

