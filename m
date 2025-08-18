Return-Path: <linux-pwm+bounces-7083-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BBFB29C66
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Aug 2025 10:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3671744E8
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Aug 2025 08:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078A2F9C53;
	Mon, 18 Aug 2025 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2Wp4L/Yu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5122C15A3
	for <linux-pwm@vger.kernel.org>; Mon, 18 Aug 2025 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506190; cv=none; b=N8D4g2wkdEIHLVqRdxGvgUHT/zSjV5wMDBz+cC+d6RaxEYLQJj2i2QaqnPicEaB+xsEhxTNvroVevfA0Ytpz65nLzHkh6TNJgahZ/hsfva3k40S1W3Eninr9ilWyTfDZvOrkM05x/eIXK35EePr4hoZbcdJWquwgiXL10vIkH7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506190; c=relaxed/simple;
	bh=UvyQ1ii45k76lBQYuglYZfEw8Hf0AGtC8Z2caMa8MMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJyM5AOoeOyLIRmaP4Fh0sPJq98ikj39r4jBDdfGL2mPdO2fxhYDVkjIU+jb23BufPql7HxkNI5bk9rmS9q/U6i8KHWF1lFWTqY6XxKwUhvE3f84WhgFDtRoap6FRYI6N0RP/2vZR5yZDJ+LKuUwqkiepadymAMkMttbqvIi6sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2Wp4L/Yu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9e41101d4so2042257f8f.2
        for <linux-pwm@vger.kernel.org>; Mon, 18 Aug 2025 01:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755506186; x=1756110986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T/fuzU1CTZGxzc/q4P90tyALZYXOtiuEX4kwF+NT7w4=;
        b=2Wp4L/YuPQPpjJ/JCaFX1mQ+/K/+0HyhwMXBznl6NiOnQY+9HcpWhbf4ccD6UEv8ku
         u9aKVsFjyA9dF/MBiaXzr3NT2W9CxIjrMYxtSltrETghm0L8TgoyKHqdItGUu59QP7qI
         AdFiKiUK7a7AO9A3naOosDrdwUrEl61GngXeM9OR3SrXgopXNsJvZv1nUnXwKU2rwOyc
         b78mZNJaRgTvMvBSASdLRlQw93TRJ8y49n7oCxxVR/yD4G6idsSifqGe/wEkUz4VWUVP
         0JCsUHDtvKmEaITmoGMTPuIOwPBDBfFy7nzTOY2SFaZlXaDC1WpsucryV78Pfn1192ed
         H3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506186; x=1756110986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/fuzU1CTZGxzc/q4P90tyALZYXOtiuEX4kwF+NT7w4=;
        b=F4DP0jHkeIkx7M7xbxqsv7gvvwe4Zou10VlwavQ44HABErvZz0t6qvU+nvhhPxdmzd
         iUpU1x337Ao+GrKmAvM3/Dzm222Iks8G5xEVVyMRT4d8vKpuK+DZS4qfMYUTWOIDl9Rz
         unta6Hp9fPdQ8pjhLquBZJe8MX4WW0yT7fDI5AaLos30xDVzT5Ujj/ngHxLp8/qT/CjY
         yytNYs+LPxfKh1R73zi0m7FPaRbdMpIQ/eoheI58BUYDQLJl/YrbzzyGIb5Vj4t+r3G+
         pwaruGCk6xZghKz/9On1GY7RXnSz5nQwO/TjVosHkpWbodzkEzYtPBVvGEFZ+5E8NxLx
         cjzw==
X-Gm-Message-State: AOJu0Yw36MJzTDFtjVZRqX787AS9KWBdVlB1xJFLNQcdedbbn7fkYuRW
	imiO/a5pwJuNAsiuqmQZ3llJgqpWKm0VcqRQXqRjktpBVVu3yF0i0BlnlzKO1KhgRt57xJyYxZO
	js6W9
X-Gm-Gg: ASbGncsqqduzSajTAMJ2Iv9cWCqisl+k56UsHyRvqOVC8uF/CrEXS5bGFC32Ce39ttP
	ek3r7UuXfO4nP8eNZ6F2/0I/OgEvgU9lVmh7ONbCh1wlhmsPseIVldg1vWN8C7uRFSip9vRkQdD
	d4NUv22tZ4lLXckPJkmFtylfwMaqt3C+SfADz6kgy+SVoNW65pnSv5Aphnd//Dqk8swWQwk0Jve
	PdiIwC9rdUyFKFJiyworCLGPt8jaLSB6iR0qPBV0jMcJCSPcRaPs8eWO/CxttPyY40jgk0FE/nz
	hzSPFyBQjJ9JoqR7izza3mv9PPpyjT2ra4ft+nqRcvwfHH368qElt4laBwnOF9P5NQHnVM2kFk8
	uH90P6E6vxIq5XHGtSOQen+2vDEACgDQ6/MrNSTVl7ioGkyOU+gNgFtMc5l9DHT+k
X-Google-Smtp-Source: AGHT+IEbLnDMKnwvqWfBZ1E5khya82qmf9ZPJV8Fnpd7QImeAaD2olfsndaI2Uyb+53tMbAQ4id+AQ==
X-Received: by 2002:a5d:5f4d:0:b0:3b7:9d99:c0cc with SMTP id ffacd0b85a97d-3bb69699cbdmr9494395f8f.51.1755506185805;
        Mon, 18 Aug 2025 01:36:25 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3bb676c99dbsm12357861f8f.36.2025.08.18.01.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:36:25 -0700 (PDT)
Date: Mon, 18 Aug 2025 10:36:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Jander <david@protonic.nl>, 
	Clemens Gruber <clemens.gruber@pqgruber.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] pwm: pca9586: Convert to waveform API
Message-ID: <iv5dubjuahdfrvzye2cfa5iiiwydatm7thl2l6x5laro6ej5tq@5rowhjnq5tof>
References: <cover.1753784092.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wkgo3na3oonkqra7"
Content-Disposition: inline
In-Reply-To: <cover.1753784092.git.u.kleine-koenig@baylibre.com>


--wkgo3na3oonkqra7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/5] pwm: pca9586: Convert to waveform API
MIME-Version: 1.0

Hello,

On Tue, Jul 29, 2025 at 12:35:59PM +0200, Uwe Kleine-K=F6nig wrote:
> this series eventually converts the pca9685 driver to the new waveform
> callbacks. It starts with a few minor fixes and cleanups before the
> actual conversion.
>=20
> Note that this driver was the only one that supported the usage_power
> flag and when it was set increased the duty_offset. Now duty_offset is
> under control of the consumer, so no functionallity is lost.
>=20
> Patch #4 drops GPIO support. Though the internal details differ a bit,
> this is superseded by patch
> https://lore.kernel.org/linux-pwm/20250717151117.1828585-2-u.kleine-koeni=
g@baylibre.com
> which provides generic GPIO support for waveform PWM chips.

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

with a minor conflcit due to commit d9d87d90cc0b ("treewide: rename
GPIO set callbacks back to their original names").

Best regards
Uwe

--wkgo3na3oonkqra7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmii5gUACgkQj4D7WH0S
/k6HeAf9ESmBPXIUKGBXsGsIYSI7QvaHRcQlyjzvJWQZmh3eX304rzS8Wkdb4nGu
+bWFT5DEUXJ4V3MtFx9DDUdxupPCvibdi2Kcrzbqp1nnEU6YFJ4CjUp3fUpjW8mN
HQITCnMmY7IjHMwl73UIKzxZrh2qwgE18ed3TyEthIDocVhFZm/m9qhpc+/wgxZS
zmmeT7SHVsx/B3J2UF0/xHZPssNVXSQmDdVos/cwSC5ZeT8Lrab6lYtjcceDt8I9
bivcsMmrQByI5+SYzmqFbdqZpWlD/vk53degVc6FV0KyfRfQVABpQchrUyFGyb14
o+qy4I6CSX5g6VfkGNeOrEaHX5uzHQ==
=Y24E
-----END PGP SIGNATURE-----

--wkgo3na3oonkqra7--

