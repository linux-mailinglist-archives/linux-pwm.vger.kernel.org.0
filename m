Return-Path: <linux-pwm+bounces-2637-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C190A91C2AA
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jun 2024 17:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BBD1C219CE
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jun 2024 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554271C2320;
	Fri, 28 Jun 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D8nJ6wQN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC17154423
	for <linux-pwm@vger.kernel.org>; Fri, 28 Jun 2024 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719588677; cv=none; b=uyKx4lwP46S7CXnldqx/lX7w/EluXfZbZGRyz2Vv56Z2Iwl92Awzj3AIlcxJsgaJayUpkfuhHPV06TtuQq954ghc0m3jgI/+PWNQyXD5MUZeMPWpIaQ2qCss88KDHMfZFQ+RuDnXQhMMT4yISLftftjF5G/y28wXho61KweUIVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719588677; c=relaxed/simple;
	bh=Cw8/Dd1AmfMRWoiS5DrGRhLSAbG/EaLyt5lWf3UMIQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB70099xYWiIvCwkEsy2mfaYggNsOE0ErlZDpeErjWXN4XNQlJs+yoJUGA0VKqsY6npXIpupDicv9/jK3SviGLfJN2xncEG5MgNVnLPwzxzvCKWWl9PiBixf++sncN5Kk0cmkn2pWfSmF/hsxK5oJeX9qkrChkFSfUWqiViJKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D8nJ6wQN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a72af03ebdfso105468666b.3
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jun 2024 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719588674; x=1720193474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q5JIqp/Wf4fxg2MB78rOVzzjMmA3m9XSWkuB6lP9b+k=;
        b=D8nJ6wQNocQQiDCbnusqiDmoMBtqoPB8vKKFpbaXgur+ZvuvqpkktTdRfKUIEs/fUp
         bf7QncGSqP6x4JcsaQez7rYdOixW8uqpX/y8ng9nJdmUsi9ujNwWYdXCcnIFWylFqhkz
         9pDu5G8jMW0fXef/tfNzhc8e6FXjDQdoi4OLgQ1M/fGFHec6Sfv1uLweFr3AoL8Rnj0p
         1ajMyBJ6Of+6OkbbAmrRDzOu7Mc3E0E8vPviV80hxdTTh/kQFBQ4NkrvvMTs+XxANLus
         sqo2+5+SudKSK04ObiA2PEQKzdFw2aYZa7beVvV+s0kKiWcPSGSqboV2PQ8OZRTULUdY
         3IBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719588674; x=1720193474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5JIqp/Wf4fxg2MB78rOVzzjMmA3m9XSWkuB6lP9b+k=;
        b=CtCHyC2vD1NGnENMxt5yiDWRylRR+uEDP2W2m8Cy6naR6ZjVtaHnIfha8tz4ADHpul
         ++swXt5sv5WXF63CtuoTl8dayieSzLW2z+fu50w+J/DfWNBuL8pKiwDxxzwRgPYXxIrs
         gMmKDrPPKig2xDp6G4dkcRDv5+i0UBq+ZPc2tHTJSUGRWzl4ofopdLKZVT/vmm18wlG8
         Vbfeauam0mu7t+mdy9j2NaSGSz+R97TqHH75q2ZYCcqL+uXczb5mx/OJOYG60YN27Ehf
         OoVpKQxzW7l1ot1ADDj8sJ9N94GcPJuC61cWToTUVjSeJxftnpC5vEux7bLUpxJYAoTw
         qQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGN0DoNs7jgAHiKFOghTjYbQ8HhreR89BqUZCcDqSPScxIGh88tlm6crQWaJtqgU56jEbRyR8vNwhf7nj95qSW5kN82uWk0nvx
X-Gm-Message-State: AOJu0Ywaia1yXYxWHQDs0mhSrvy7bJARY6huEsERyzO+Lhe8RajANXWB
	ld/slVILQr/RJ6hsVSt5Oxc6L6kRhrTKeHQy1dtEwAF4ZZYM1dv6MgWU3fe8t1Q=
X-Google-Smtp-Source: AGHT+IFRuQ7YvA3YzYURlVYrBjCcKHGte4VTBj2Nk5k3QmyJ3xEe18nZQZz0a+CEYGABUKDkBB2m8Q==
X-Received: by 2002:a17:907:118c:b0:a6f:e50c:334e with SMTP id a640c23a62f3a-a7245ccdd60mr897244566b.23.1719588673865;
        Fri, 28 Jun 2024 08:31:13 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06519dsm88699466b.99.2024.06.28.08.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:31:13 -0700 (PDT)
Date: Fri, 28 Jun 2024 17:31:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	William Breathitt Gray <wbg@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-pwm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: Re: [GIT PULL] Immutable branch between MFD and Counter due for the
 v5.11 merge window
Message-ID: <wfhqh5jfjaecjr75fu5olxnnulxgtqyxpw46azlfa6vqe7ezlz@l5mwketc3f5j>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
 <20240626151343.GA2504017@google.com>
 <20240628142847.GN2532839@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vwml3ark6hcxxqsa"
Content-Disposition: inline
In-Reply-To: <20240628142847.GN2532839@google.com>


--vwml3ark6hcxxqsa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Fri, Jun 28, 2024 at 03:28:47PM +0100, Lee Jones wrote:
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfab=
d0:
>=20
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
>=20
> are available in the Git repository at:
>=20
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags=
/ib-mfd-counter-v5.11
>=20
> for you to fetch changes up to 304d02aa711369da89b4f8c01702bf1b5d1f7abc:
>=20
>   mfd: stm32-timers: Drop unused TIM_DIER_CC_IE (2024-06-26 16:09:58 +010=
0)

Thanks, merged into pwm/for-next!

Best regards
Uwe

--vwml3ark6hcxxqsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ+1z0ACgkQj4D7WH0S
/k7wMAf+IQqhOqwRtmvzgqxA3dQPTH3rCH8Y4z5wsmtBC5eqzlC6r3Hz0UjzxlUA
2tgx4l7hoq832LjoauTlmSckhKJywRAYHhcll0XyODku6sP00oYmsdidrWftQQYz
yJQ77dcmOLs2wbgqlC/mn48nMQKJBsWuxtTXZzERDBevXW1VcpKtYstg7WNZAkEX
cv5Xx7I5wAIklRc4fHTsvd8pPo25VVS/AcZ10aKnTdFQAFQkkjSCjJFthH9X9TQt
0GwSUGpxg/oU7sneXNoYb5zXVqMs7EijFr0MzcFFi3Y8OAgeRf5jn6WVF8pAbnqA
Z3gZNyEIRABVSWQewBB/0yxodqtP1A==
=Zv7T
-----END PGP SIGNATURE-----

--vwml3ark6hcxxqsa--

