Return-Path: <linux-pwm+bounces-6796-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E1FAFDFD6
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jul 2025 08:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55934E8183
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jul 2025 06:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6A526B2A9;
	Wed,  9 Jul 2025 06:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Sb4h+CtL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E30E1DF965
	for <linux-pwm@vger.kernel.org>; Wed,  9 Jul 2025 06:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752041664; cv=none; b=Yr4TdWs7uBxCAaCDmkyg+Mu9lhc7xwo9WgH9YJN1dqYRxOd6IGgYQ20Dy4YT6tbYZmBttCsKw4i3FR1FqAiFhLeViA5RXr/SYhGVsKp4xzCPxRYvsC5dGF7cRcc2xx40Yl5tc0qSb322WE8Siqs2/p6NTansOszUI5DRmkF6nKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752041664; c=relaxed/simple;
	bh=8mGZIBbncaz9lTrdvh0RUvHjL6vzTe4jCIcBt1fy6Yk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWxJdIFJ1uTs6ukqjcWBag34pT1HJtasRPZmB4R8fp/hdCwUZoVluWonWf56FCDXo3bo+LUEYl757y+NRwYGIQ9KDE9AbgKPyPLoMHzYtwwrY+fuCph1J6wGHvXwcwRT9JBFeRnNn/QTbrGrcGERw8MUs97rRvGuVEBFR5+D+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Sb4h+CtL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0b6532345so115196066b.1
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 23:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752041659; x=1752646459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X0d9wopNoxIL1zT2dehNcsBc3M/PDNolMwR+XGf9tY8=;
        b=Sb4h+CtLG1Eoxes5RrEjQAz8gO0ur0jILcgzWG6z8TaAHFLJ6UkvAqQlw8Ql3jw5mr
         +FN8J6hfQpC/6UJuuJIXLIkEHi3Gf817PCZZrqNIbYAgnLOLYL6+D1JUYAjuzwZwK5i3
         TcT462gqD2yNdcs+SmBnOWB1DI160HBsekL3z0M8u7NQHj3kWkoz1wC791vzQH6udRbU
         2r02Pv1tcHhFb3TSyIYjOd6cE5Zw0fRZa7bTTVuUdaoEOtZlqUS1QjBqbPvMdHrrTig/
         KTJ/TUvPQiTV5iSlhgqq7VFHxPX1YqleOtpofhYZjOAYkbPow+bDPfyaf9/SXPrYRMRD
         VieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752041659; x=1752646459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0d9wopNoxIL1zT2dehNcsBc3M/PDNolMwR+XGf9tY8=;
        b=gk3i+CHZESXJOtJsk+30KdApTlUnJeqtq2Ljp+QBFbvE76iRsqEPdlFZR5e0QIw0p8
         QbdscILzA9L0xJ8Ywc+50um60s6J2jeflLKrJDrl0w2OZ1mRo0MiStuXUw5xA6MiVaj/
         eLMiyhMskGxtPcghTqeF+/rXdwk+LxM0thTlvxNOAdggEciiyUfAT5kRC1Us4W9xGoJ9
         N4+yAjzz+OcqzGI8OeEAZBkqw40+hMExmY5e087phYEa/M6l0o4RUDdoVXjB4G9cG9q0
         1ogTX9ybaV3xyeIzgeyP5qWrsudvflZO5xYc4GTWws0LN9DfH0LAjWWf/vv3LNk5c1it
         Dpnw==
X-Gm-Message-State: AOJu0YywWyyUNXQ1G0AHGA6h3NJjaoUijKB+f1GSL6yd0c7iccAMvI3+
	yxVcMf/WkFdNl3Fr6dVBZkASpdDJi33rUrwKJBSA70ril+1008cNy1Hv9KzyjfRHKPwe5oWqVFp
	o4uag
X-Gm-Gg: ASbGncu1EB11ZNZF47dbo+ulVEuY9tVYXHxxVQxp4ePY8/eH25qAtjTVJMmZXxK8+0P
	uS7ruP01C5FsPqhEDLcSPPoRCrVUQlppVlj9kJo0c8ItfvVoY+D1WGZyzjg3VA7Vb92Wk1xQonL
	HKccnxA+NyU8NnOzj5hg0oqVXKdmpg0glfVMrPmWhpQHwyEOfCxNw6bM/YXkPTo2PnAJknCgELP
	6M8jehf2vgfj8Yc4e6l5El+PuFgFxhf/4GyfQSbWtKc1h8KG0hQegVpPrYgPLeTLb707sptoIP3
	ukLayjif4aKb/M557sTRQznbKtI3pEUbAoctWaQ+3qHdM8UcWhATRubeqRTz9sMcRSQ=
X-Google-Smtp-Source: AGHT+IG1eKVrtsewlMntycc+9L8VUcv/RwqpWfADWtwf6IQaa0Pwi2ksu7/ZZwPzi6RjGv/aVFuOuQ==
X-Received: by 2002:a17:907:602a:b0:ae3:c017:ec5a with SMTP id a640c23a62f3a-ae6b26f518dmr507371966b.16.1752041658440;
        Tue, 08 Jul 2025 23:14:18 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60fcb8c63f9sm8170441a12.72.2025.07.08.23.14.17
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 23:14:17 -0700 (PDT)
Date: Wed, 9 Jul 2025 08:14:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH libpwm 2/4] sysfs: Fix polarity handling
Message-ID: <tcoklwryj4nufffylojzrdwbzpu2fcinecreomcidp5px2jecs@pr42yvapreub>
References: <cover.1751995302.git.u.kleine-koenig@baylibre.com>
 <149cd2e217dfb90210cc6fff332ec776371b0387.1751995302.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mnvwozi3ibmjivy2"
Content-Disposition: inline
In-Reply-To: <149cd2e217dfb90210cc6fff332ec776371b0387.1751995302.git.u.kleine-koenig@baylibre.com>


--mnvwozi3ibmjivy2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH libpwm 2/4] sysfs: Fix polarity handling
MIME-Version: 1.0

On Tue, Jul 08, 2025 at 07:24:14PM +0200, Uwe Kleine-K=F6nig wrote:
> Depending on polarity the sysfs duty_cycle either defines the active or t=
he
> inactive time of the PWM output. This has three effects that both were not
> considered before in the sysfs backend:
>=20
>  - If polarity changes this affects the waveform's duty_length;
>  - if duty_length_ns changes and polarity is inverted this affects
>    duty_offset; and
>  - for inverted polarity the written duty_cycle value must be
>    period_length_ns - duty_length_ns.
>=20
> To simplify handling the first two items, rework the cache representation
> to use the parameters of the sysfs representation.
>=20
> For the second introduce a helper variable.

Reminder to myself: The issue was initially about two effects and the
message still talks about "both". Also "second" should be "third".

Just for that I won't send a v2 and just fixup while applying if no
further review requires an iteration.

Best regards
Uwe

--mnvwozi3ibmjivy2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhuCLUACgkQj4D7WH0S
/k6yiAf9HPLK2gLjQm1jV5oVLNR7ObuzbbJuRjXTd4QW8FI9TrYwHNaWvbbGP7D1
uK0KU0M+/52k+eGLwXpKxCX/d56mWIrCtZjeWnFo8K0OhoDdtwXdtXdrRuauLjYy
utak0qBlXXClkT61XxJ7c3ze8e+M29VXXEaQwPyJkcQrnDsq7Hq3u+HLnlSWgWp/
24OQXcWGSd/A7elmEL4Ht2wZz/psOT3Mtvo3I7/UQ/eEPr/I9ReP8SFL9yRdZGbY
da3466ltzZ3TnPeQDAMPQG96FY9h8j2wMrjfxe8voSW1ZWs1GDWorXJcgV337ZGt
ulkWx2qaynLn20NGOJVVXA3TFey8HA==
=xvPc
-----END PGP SIGNATURE-----

--mnvwozi3ibmjivy2--

