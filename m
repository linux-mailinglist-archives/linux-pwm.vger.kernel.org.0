Return-Path: <linux-pwm+bounces-2577-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F28B9113DB
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jun 2024 22:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D451F22B53
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jun 2024 20:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7094579B87;
	Thu, 20 Jun 2024 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q1Em+ovT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20BC768F0
	for <linux-pwm@vger.kernel.org>; Thu, 20 Jun 2024 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916983; cv=none; b=cKwn03TLMICyH5sjCUGc9UfT3z5idjke/RAVnG00NkfG5rDfp3ju3Dmm0exlzHiIpH4h/i7i+coJ9OVBiu+z8lA1P/gdX0x59imHNjj3lClQ9J1XUxUDiwKwnRxHobT1Zkf3VZYdT+ch1HCXQ8+FFvLyZtUu8110fQMJbD8EfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916983; c=relaxed/simple;
	bh=7bmaecOL5bwpzLgvqJZsDJE8Wz4/YnnOp7I+iv3R9q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtiUoIVoT4Ihf4Pn/jtpWyskD6dEnB2rNkYjmy3Yjux1tDjHRB/iSs92kSQ9Q/3RxFnTR3qho+yomBdhX7dwu+zIHnMRKuAqdjaKsXdaP9io9IDwC2C5iC0uI5lKPd3ObuZ8XfdWERROzwY6HXqrTADibSKwGvVP9sRsivaNvjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q1Em+ovT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42198492353so12768435e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 20 Jun 2024 13:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718916979; x=1719521779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tParEw4TnP3wUXcwkDyOi4Scz2rhjwIoECr/A9aobTg=;
        b=Q1Em+ovTDiXpq6buKyKfqbO0VSOc8H2KH7eGw8WeB780V5f28n/Wt4aUrKkPRhiOmK
         675w61ZBV25U3oZmwIuI8YeIugAYfeQXykUJOzh9RchXlLgca0d3xS+CVvxzEvpVFer6
         SX27eKy7/mLsQRaBuRp84a6rrv1w/cEptyY+9sFnHPzNoB5Wj26u6Jax7cYt+74dsxlz
         zx4x0a6BNL+rOCjf4oY5wBLd/NWFNlmXAkwU4dVx2uNlEWnvn/U3vMv5D8b892CKlm8X
         prP5Agk8VCaBm9AKRzKg+LESKPCTb+y9c+E59T0x8IXirYBAlUhHGzPIVVQCcpqi6BYh
         nzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718916979; x=1719521779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tParEw4TnP3wUXcwkDyOi4Scz2rhjwIoECr/A9aobTg=;
        b=MMZS1cIXEIRalSTsvPx18mgQ/wRmMuVjOGgWpgtda0UBydSYdpRXwTPSRWbqswnWoG
         Bv8DyAmLSC7vEaTY93+sSNuX5R4Jn6v3ejmMMdAgGSjxxjb0iqNwtd5UrvBtUqPrlz6L
         eKRUuxBF+9s4801r0s3LmG0ATos/ve8SomlqV0T3fHDBJMtH+HCzKZwbQUOKgJqnbP9m
         qgtUkZ3osLATUJRh+g0kjn3ssln5/BgdN2XEW5oQtE/dBTx/agpvp9uXs+LQi4Pcveqk
         pQI0ZlKqfFoD5yuMLZWyCu9afiwgMHLlxvH0gI0EglupuNXsGH5LhoZc3LwvKUHxMpZs
         Y/fA==
X-Forwarded-Encrypted: i=1; AJvYcCUyAAGB7OSPc6tgdzN5akF/Bb392REdNBXPD6JUN1dbPcscs7a7fDiewvAYBp3NbxBhn60uM8cP4onH/w7jeP9JNdMVu4BpqmJK
X-Gm-Message-State: AOJu0YwPi8GguJr1c2MKHEgrM9J+Eag6telAtQVIX8OWB3p3/rlJD0Nk
	fI+7ad4BsYGgeThY9c5o1hgTKKlTrTyr/hHhEIbTTLK6Iv/C8ZJflqZE9/i4zaw=
X-Google-Smtp-Source: AGHT+IF8t8LppDcAmDZ+UAbN2U2Xv9mXuQyfexbNH4CmjdFqAlZe48YByq17RrjbGyxJj0+YBSnHjQ==
X-Received: by 2002:a05:6000:d52:b0:362:ad5d:4df4 with SMTP id ffacd0b85a97d-363192d0833mr4782800f8f.48.1718916978597;
        Thu, 20 Jun 2024 13:56:18 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf56eeadsm8781966b.216.2024.06.20.13.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 13:56:18 -0700 (PDT)
Date: Thu, 20 Jun 2024 22:56:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	William Breathitt Gray <wbg@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-pwm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: Re: [PATCH v2 3/5] counter: stm32-timer-cnt: Use TIM_DIER_CCxIE(x)
 instead of TIM_DIER_CCxIE(x)
Message-ID: <ip5aysvcuchc6q6sikghcz7vjn6zvih5r3amkvp7n7xpvncbhh@jdq5lkckeoej>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
 <126bd153a03f39e42645573eecf44ffab5354fc7.1718791090.git.u.kleine-koenig@baylibre.com>
 <20240620084451.GC3029315@google.com>
 <imyuhtcsjrbyodsndzbaqfwa4jxny25eylfdh4u4xtsiotsk5g@45l556pcrzys>
 <20240620173838.GB1318296@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ny374adlpexcdnhr"
Content-Disposition: inline
In-Reply-To: <20240620173838.GB1318296@google.com>


--ny374adlpexcdnhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Lee,

On Thu, Jun 20, 2024 at 06:38:38PM +0100, Lee Jones wrote:
> Which patches need to be in the pull-request and which can be hoovered
> up by their associated subsystems?

The dependencies are as follows:

	#1 <- #2 <- #3 <- #4
	       ^
	      #5

So the practical options are (in the order of my not very strong preference):

 - Immutable branch with #1 - #4 (assuming William is ok to let you
   merge #3), and then I can add #5 (and further work on the pwm-stm32
   driver that I'm currently working on). Maybe William even doesn't
   need to pull; I didn't check.

 - Immutable branch with only #1 and #2. Then William can pull and add
   #3 and I can pull and add #5. #4 can be applied later then.
   (I can remind about #4 in the next cycle.)

 - Immutable branch with #1 - #5
   (Reminder: In that case please fixup the pwm patch's short log with
   s/-/: /)
   I would add this for sure to the pwm tree. I didn't even try to check
   if it's needed for mfd and/or counter. So if you don't need it, I
   volunteer to create that branch, but if you want to do it, that's
   just fine, too.

Best regards
Uwe

--ny374adlpexcdnhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ0l20ACgkQj4D7WH0S
/k6mfwf+PSqfL8bo56onxdPLgXeRSRFlGHnohlXLPJBHSNS5MN0nKoVkWb3Qrx9j
0iMDVTrmGbfB3Bi2hVznoi3CFEaRhRzGSm0de3kSbJiXzqNacDdNVbM5WTzr38GI
wfXotmIxx6lAnt5QMb672g2S8AVqvuO+64QzFAoStGh+BtBFcZCQmTsgQEVbWzNU
WeMX5vPGvMwWEjjqkgnAscNxW0KGCwt1j2BlBDvxlacxSosQtjjROYl+mFaz8ii0
1LevCg4/MxvJQd+LsXFitEFa7ObSpFku33S9mllK7EtR/pcJyrxVXn/+yRMFIWWb
D3NxQShAbnZwVqj4+grvDGqCZKImYA==
=nFFT
-----END PGP SIGNATURE-----

--ny374adlpexcdnhr--

