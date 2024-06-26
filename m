Return-Path: <linux-pwm+bounces-2618-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F28991986D
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2024 21:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB249B22353
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2024 19:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418621922E1;
	Wed, 26 Jun 2024 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H+Vd0VAO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431E14F9F0
	for <linux-pwm@vger.kernel.org>; Wed, 26 Jun 2024 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431013; cv=none; b=Hwt5kziup3+2M7cevinxsak9G9BBtFKN5ptosyMr7oDYJi3ZrDmkIU/XNvlbIyY7BlZsUzW6ROqt51QmY8AVfNF2PE+GmAP6DhqP3ZFjKn5mgNzxuKz1+1HxKoLuL948tFR/IV2rXFq4SwmL/oj17cxi1SVkpeGL3i9ZFdp3XiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431013; c=relaxed/simple;
	bh=G7iGKd3NpkuleCjeNOrRcet5y5rwezOykiNc+TTLj/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsDHZHuGOkWF5mBQth8DJtbEMMgknus5Ig0nJluv2bPQMd951+9vOfDv6RyZWXrVY6sF2ohAUf4jUta2qyOGtBZC56pSrzOzHkbZ1sFguEP1Pwjf0FLFktmv6gmGLZrCpnMo4t+JW+ZCEkmHE78SjqPGbuXxqzdd+uFbh+PzYL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=H+Vd0VAO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a724958f118so552928466b.0
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jun 2024 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719431009; x=1720035809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GjGTkNIBK/W7dyZDTk9H62YteS6jTO2H7CEOhj6wZPc=;
        b=H+Vd0VAOBWF2ofpEyQsy+K/39pgPb2ImnX53ijvGwyv0riPvVYA3b7/vwex2bxgi9/
         quKmCV/68JHPdEWTNG7EULbpaz/U/ga1aJRvaMGE4ByTz+4RS0BRy++11IU1Dex/JDwk
         r/niYcsjlSXNBpdZQlnWJ6IIm1DZUbcEsCTH6fCWbVtFYy8/U6vG+/t264OMo2SCySHW
         K8tiYUkxEslTg56JBd/yJl8jfPuGBj7hTE3IjjqaZXLcZxiLo+9ER4oNtCGXhH1yGQ5V
         sjL183TZ69bF78NWm6jljd+2VUT7kNMxKhXvlz/zx5MU7T2Lay5OoCXMXuIu9TQBOMPN
         /KkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431009; x=1720035809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjGTkNIBK/W7dyZDTk9H62YteS6jTO2H7CEOhj6wZPc=;
        b=RwdwgYW+NpbuW9T5UeZkbTFqmYcJRxkTW7RZWr8Ye++003GTH7yq78nfX3TRTRMtVt
         RbgXzzn/OiOClpfHRilkf2dzuNV5ZYnQNF58nNop5gGVRpSwTDWM1YoxXalEwlN/5RIh
         ijG0KCVPxrnWNfDIGeJ58hgvO+ikugZUxhf3gonZCwFcTokhlNdBzM03haZ24jhEKXnk
         AyBPgEo0bPXJy0N6iulg6HBEo95vRx8cueOqux5bVCYNZyQ1FFvJSwARZtRoYv4HMXYi
         CYgleF7rFqLr9KYMCGfzGq8l5WnBHcmIEjcaTYeBmEnL9SZM8Vg4PlsopoY+zLAuEkdc
         Na9w==
X-Forwarded-Encrypted: i=1; AJvYcCVIMJ4YhMHyz+JguQ+rEpcykjf9sGaCrD9rL7Sm8R1akFtFLM4btCCtJi8cOekIPOInU7N5RD9Qodjgcc2rpAjS1rrdJ8F7tF3t
X-Gm-Message-State: AOJu0YyCZTJQWFAyoC77Z9pr3y2BmURiqoQHvjA/xIfZQA8JXsMyjjZV
	QYMENOjZrYK39yNUp3cpldAhBgTn7GIVmhpjq73nM8sOhhwkAO+atbsum9vNvKY=
X-Google-Smtp-Source: AGHT+IG4TjffVhUXYhDKxyCatM54/g+s4fUWCsSBNsfk6wfhm8KPJ2zLGyyYXEOBP2q79X3ceoR9WQ==
X-Received: by 2002:a17:906:c243:b0:a6f:569b:3ff0 with SMTP id a640c23a62f3a-a7242c39c0cmr794609666b.26.1719431009283;
        Wed, 26 Jun 2024 12:43:29 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724610ff5dsm437619466b.223.2024.06.26.12.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:43:28 -0700 (PDT)
Date: Wed, 26 Jun 2024 21:43:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: Re: [PATCH v2 3/5] counter: stm32-timer-cnt: Use TIM_DIER_CCxIE(x)
 instead of TIM_DIER_CCxIE(x)
Message-ID: <cgtiizodhbyutaeu2kw5qszb6ap6bpzdk5pnpurliikhz4isvp@3xtidwcttjkb>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
 <126bd153a03f39e42645573eecf44ffab5354fc7.1718791090.git.u.kleine-koenig@baylibre.com>
 <20240620084451.GC3029315@google.com>
 <imyuhtcsjrbyodsndzbaqfwa4jxny25eylfdh4u4xtsiotsk5g@45l556pcrzys>
 <20240620173838.GB1318296@google.com>
 <ip5aysvcuchc6q6sikghcz7vjn6zvih5r3amkvp7n7xpvncbhh@jdq5lkckeoej>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ufxu7ubv2j356spy"
Content-Disposition: inline
In-Reply-To: <ip5aysvcuchc6q6sikghcz7vjn6zvih5r3amkvp7n7xpvncbhh@jdq5lkckeoej>


--ufxu7ubv2j356spy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jun 20, 2024 at 10:56:15PM +0200, Uwe Kleine-K=F6nig wrote:
> On Thu, Jun 20, 2024 at 06:38:38PM +0100, Lee Jones wrote:
> > Which patches need to be in the pull-request and which can be hoovered
> > up by their associated subsystems?
>=20
> The dependencies are as follows:
>=20
> 	#1 <- #2 <- #3 <- #4
> 	       ^
> 	      #5
>=20
> So the practical options are (in the order of my not very strong preferen=
ce):
>=20
>  - Immutable branch with #1 - #4 (assuming William is ok to let you
>    merge #3), and then I can add #5 (and further work on the pwm-stm32
>    driver that I'm currently working on). Maybe William even doesn't
>    need to pull; I didn't check.
>=20
>  - Immutable branch with only #1 and #2. Then William can pull and add
>    #3 and I can pull and add #5. #4 can be applied later then.
>    (I can remind about #4 in the next cycle.)
>=20
>  - Immutable branch with #1 - #5
>    (Reminder: In that case please fixup the pwm patch's short log with
>    s/-/: /)
>    I would add this for sure to the pwm tree. I didn't even try to check
>    if it's needed for mfd and/or counter. So if you don't need it, I
>    volunteer to create that branch, but if you want to do it, that's
>    just fine, too.

I wonder what's the state here. Maybe Lee waiting for William to send an
Ack that Lee can do the first option?

Best regards
Uwe

--ufxu7ubv2j356spy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ8b08ACgkQj4D7WH0S
/k5u9wf8D3qbnAeT1su3hEebC3PyyJaGAQgQP3j6KOeSzL1QwvEYVG2QWirUwU4M
nduLdm0RKB//DIb98T87S1WNT9+6yRy4YNG51liRGPPdJkCPftYiA7qCrmS8+knn
XxFUJ0q578MzWTPZEuIFVNybdF1XLjb07eWerpE9TNIOwawnrmdrSXAEWF/7AjaL
krin++PPjmLPvcaREVVvosFdov4XIZJij9gso9M61zj+ZiDGQxRYBWsrrjDhGPKD
/6E5R9RISaOSqFyi/kpLgifRQP0ts94QLVIvtbvD30M9pB9exTBRRl1AHxq4iSws
YmMOzrRvYdoXCNcwcerJ4oXz3keWqA==
=Y58C
-----END PGP SIGNATURE-----

--ufxu7ubv2j356spy--

