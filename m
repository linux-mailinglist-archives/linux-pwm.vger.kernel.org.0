Return-Path: <linux-pwm+bounces-2711-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB109286C0
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jul 2024 12:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CD21C22B2E
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jul 2024 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51CC148832;
	Fri,  5 Jul 2024 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZHAYlIox"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940251487E1
	for <linux-pwm@vger.kernel.org>; Fri,  5 Jul 2024 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175187; cv=none; b=Y4Ewrrrsyniprx5TQDI9n1Aleptumk0Vu8G4IMoPlZ7g9PQ+Vi3AiVqJqagVDZ26xrkIMZDa1zCNPIgPyNVR33854Xxc7DEqLrsS1RIlE3M3xPt6NhElKKBqF5q6JfNrS3ozq3tyyomJeG4ycdxhO5wFr6ZfHfvK+NDCmXA3T6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175187; c=relaxed/simple;
	bh=BUmE3qER9ieyD2/NrG82vKREHf6CuM644mPR05VblOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hU1cuwzxVf55ocMI1cniSImpYE0Kd6lWibeIlU3tCU1/je5BshpAmGUFEnPqOwNvv/nX8Y+ABWJBriLAV+zmCod8efENeHdJYIg0/ZWC7XtLOa6ACxDNZD9ftUV/VyTfSlfPfnKO+DrbYP3nFcxmbdflG/SWCvtLJf2XxPS3jOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZHAYlIox; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso1402124a12.3
        for <linux-pwm@vger.kernel.org>; Fri, 05 Jul 2024 03:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720175184; x=1720779984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BUmE3qER9ieyD2/NrG82vKREHf6CuM644mPR05VblOc=;
        b=ZHAYlIoxZLFPO/iXn4WSJin98oVcK//dtsQY+iwUgkq9uhdv/XzUeeXDwi8bu9AeQs
         BOfflcuS61mb0i6tPqBmWRP0k+kgJeI8datPSyE/zyejL1o73XUa9Dgc8bmRcPa9ee80
         QOQVPT/mKGMkWz5+PkT+SeuOfckiT60OVIi3IuM43D71iC8HDT0pB8uouwDYzZY4u/kW
         FhVR7mPdwkwEPraPKlF9YJ0XRHem26LyLqR9WRy4eHLCw8nFraNAZy9rSQQBySlpVcyl
         G6vApY3ctlrtNtum+zvihf8nnyP+nNFOgrrEtS+juGAkVJrOo+WYAxdCrgsluR0sLWSC
         xB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720175184; x=1720779984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUmE3qER9ieyD2/NrG82vKREHf6CuM644mPR05VblOc=;
        b=uem2uFDPfn/RJ7SSTfCc+91WtDII5/fQLx/JFd6LuoCuiEtFcbbiroWnyYeNa7ADod
         lpKkZHmVQRK1wMUvEMMLoyln28o1aSANGTVg6yhjjDEifxG2RvzQXoV8H4qbhsEIhXiC
         0PqUrJc39R9q+u1kC8wmrcogEyyR5WwDTNbeoyXgDYDUnxFNuf5j9+033Hca+XRxKbR2
         LR3hWcs59sckiroeIMEgbv/C2J3zftj56iqejWI3QySXnEvhHhq5Tyf4HhO2xwjCl+gh
         nI40lDpSNev/iKuhMOrSNssczyvtcp6rW0vLkXZDcg6FYnVhjHrj4r55dyQ2TzqzK9zP
         jj5w==
X-Gm-Message-State: AOJu0YysLLLXd3agN8xXzc6+oSpPHz0kLRZ3tt4/O9HyruOd8s5Ru05d
	2GWmLS3UKv1efA0ooE6DQ/3TC6YUn812z3nzKQ/KGai8bC/ZIc18ZGrAphOMhyMaAn/DiS4c53K
	t
X-Google-Smtp-Source: AGHT+IE1rSn2X87qkqdJmwZGsXpatgj+zUD7FMouIiZKXjQib+9BvbIpc6TZOqy3RHvp9AY7UVImmg==
X-Received: by 2002:a17:906:ae97:b0:a77:b516:3026 with SMTP id a640c23a62f3a-a77ba44c954mr262337166b.3.1720175183877;
        Fri, 05 Jul 2024 03:26:23 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0b35a5sm667175866b.201.2024.07.05.03.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:26:23 -0700 (PDT)
Date: Fri, 5 Jul 2024 12:26:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Thorsten Scherer <t.scherer@eckelmann.de>
Subject: Re: [PATCH] pwm: Allow pwm state transitions from an invalid state
Message-ID: <iy4nsk4o45exoszyym4jfb67svv4rxre5eicummbqt2v4fucos@sqgkqdajgahk>
References: <20240628103519.105020-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ia3wlhnar7ys7dq"
Content-Disposition: inline
In-Reply-To: <20240628103519.105020-2-u.kleine-koenig@baylibre.com>


--3ia3wlhnar7ys7dq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jun 28, 2024 at 12:35:19PM +0200, Uwe Kleine-K=F6nig wrote:
> While driving a PWM via the sysfs API it's hard to determine the right
> order of writes to the pseudo files "period" and "duty_cycle":
>=20
> If you want to go from duty_cycle/period =3D 50/100 to 150/300 you have to
> write period first (because 150/100 is invalid). If however you start at
> 400/500 the duty_cycle must be configured first. The rule that works is:
> If you increase period write period first, otherwise write duty_cycle
> first. A complication however is that it's usually sensible to configure
> the polarity before both period and duty_cycle. This can only be done if
> the current state's duty_cycle and period configuration isn't bogus
> though. It is still worse (but I think only theoretic) if you have a PWM
> that only supports inverted polarity and you start with period =3D 0 and
> polarity =3D normal. Then you can change neither period (because polarity
> =3D normal is refused) nor polarity (because there is still period =3D 0).
>=20
> To simplify the corner cases for userspace, let invalid target states
> pass if the current state is invalid already.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to pwm/for-next.

Thanks
Uwe

--3ia3wlhnar7ys7dq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaHykYACgkQj4D7WH0S
/k7tmQf6AsfYpGqkQ1U14HlOiU8hHae5JDl7t7o7RAyOA64b7I7sML4WenWj5ndO
EGqhf1u9ioTpjHCOxXqbMk3SXC13tNsqpK2PLPOEEFJg0tcsJgk4Oivy96zAYV3g
m1c4x8mSv5XCEsHCFGKa789ZTZ0M/E7olFjvrh5qr1tF9+MF5Cx9KCdfmSKPqJnq
OjGmbMtMNRn13P34KiE3D/tF94Na9obk9QxZT+cCdgNccAyRV7zk5a9DMOBZMUmA
gRcCDGhXNxhurtIiPzlpVl/JBLLPZwU9WvHRbg+iVO1gNiYXO3OBfLtczvZGXmUm
uZmK4e6xn3C3BGXNLrW/Y2sLKflu+Q==
=VN9j
-----END PGP SIGNATURE-----

--3ia3wlhnar7ys7dq--

