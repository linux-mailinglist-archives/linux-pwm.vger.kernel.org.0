Return-Path: <linux-pwm+bounces-4044-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1009C0357
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Nov 2024 12:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B197128835B
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Nov 2024 11:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA051EE024;
	Thu,  7 Nov 2024 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NaQc58Oz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7741373
	for <linux-pwm@vger.kernel.org>; Thu,  7 Nov 2024 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977533; cv=none; b=Jba85akjVeOnBSvfAHmJDFaclRxck2c1psI1Ie9ACTvgzMASn9sLAATtjCQjTFAUrrlU3Aw1RQS+dKi0hCUdbRI4v+oGZTh6UIGhSNOdpIuqr1YDIRWO2lBcwHhDzDRDVn+ma0Y2DhyPyP1/Fh3bi15A4xWS+CYKkbtLAU7VDOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977533; c=relaxed/simple;
	bh=MTi9DnWTiNFT5MyTU1ywAX3/oLLji33torD+CFCxMv0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPHDHDAkYl+m/gZdXq4C2dVO6OGFMxjSlGKqtx8fucRgOFfjOMIRcVZpb633SUIN06YKBOQvibMU0jk1y1cVbVxDChdq6eFf9rjpPYm7EFM1H0P9LpvZwvv/S51+2wy5A5eHPjHHCUiksU0EDRSXx4YDHWtMyGNzCI2Zc1RCQF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NaQc58Oz; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99e3b3a411so331656566b.0
        for <linux-pwm@vger.kernel.org>; Thu, 07 Nov 2024 03:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730977529; x=1731582329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MTi9DnWTiNFT5MyTU1ywAX3/oLLji33torD+CFCxMv0=;
        b=NaQc58OznX86zLaflahW+pJMrVJZ4rDi9jjs/vdRbkppQWWlZzd8Ys2uMXUudx3pWC
         Xg2zxj0T4taZPAWnSMHALjD//xsN1PiziIsONzVobWu9WOrvOpASwaTiKYiWUAb7xdfe
         nI0HG7g514x0j/J2k2oUvw1dOdiIIA1n+SWs6/WOg7m2440ERN7xXBOWGO5h2rfs8xyB
         iNnA/6vIVWUhTKvBOo1J+tEAZFJqZRKm9KR8SP0cRo++S2QU69p2rDitrbysM7SGllWj
         BHAYUt4RuR8vwDnJai+kh4teb4BU2UxbiXiDD3uyHlOnTgKccM6wlZrEQAjsiwXKOWtK
         Rxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730977529; x=1731582329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTi9DnWTiNFT5MyTU1ywAX3/oLLji33torD+CFCxMv0=;
        b=FFxmdMbmQqndGRZxWngGQOqNgPdaSTlgIumtu9fv6lyx5E88D+51jVyRvj9hKpgR3o
         P70Mea9bArNqQdOpoO6rFHZlaR9XIFyBHQh/SQl9wxGKILXaIxEnz3YoPBG+M1OOW4Qd
         SMEIEsdWUi5JYaCPjjdFFS/zNJkPhD4ekGtLfLHBcmKGOKuEfeHkX+POiyF1wM5AzUwN
         MYn3etg4l2Q7B5vySPgKuXpsnpjeORkhZc6qzFptSIUhxrFm3gP/sXEaLgwWdNeKULZv
         +DLKwhOZeop+3X2pGtLcf2QQQ/VD7JoPyUcEkMHY25uTKp23UwJW4K6/9S8FJoXUueeL
         IBNA==
X-Gm-Message-State: AOJu0YwZhNGFELbZmZTwDCMM/ETkyNESOSpv5bmmWqV4n8QSGXThNHFw
	APaRzbqXVWuQTjLGO8QHcmUG6uPV7CauQ/L6nI+WpPK5KgUAK9QC8MJK/2Az4h5SkDDbLFPNTaK
	z
X-Google-Smtp-Source: AGHT+IFYQW1xa6pw/aWGXaZDsrXpxd5bPaPlFlXRQTAACtoYXZcxb2C+yrAbg845LtabwUhLldLb3A==
X-Received: by 2002:a17:907:268a:b0:a9a:85b5:2aca with SMTP id a640c23a62f3a-a9ed4c8eba9mr229390066b.7.1730977528845;
        Thu, 07 Nov 2024 03:05:28 -0800 (PST)
Received: from localhost (p200300f65f28bb0063ffae39110fa2df.dip0.t-ipconnect.de. [2003:f6:5f28:bb00:63ff:ae39:110f:a2df])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0defc3csm76527466b.166.2024.11.07.03.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:05:28 -0800 (PST)
Date: Thu, 7 Nov 2024 12:05:26 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org, Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH] pwm: Assume a disabled PWM to emit a constant inactive
 output
Message-ID: <wtxg42sebppic7v65sskken7np7s3ujaz3kfxxn6vliw75yrhv@22q7nx347h6w>
References: <20241105153521.1001864-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dgv6hyxy3og67axw"
Content-Disposition: inline
In-Reply-To: <20241105153521.1001864-2-u.kleine-koenig@baylibre.com>


--dgv6hyxy3og67axw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Assume a disabled PWM to emit a constant inactive
 output
MIME-Version: 1.0

Hello,

On Tue, Nov 05, 2024 at 04:35:22PM +0100, Uwe Kleine-K=F6nig wrote:
> Some PWM hardwares (e.g. MC33XS2410) cannot implement a zero duty cycle
> but can instead disable the hardware which also results in a constant
> inactive output.
>=20
> There are some checks (enabled with CONFIG_PWM_DEBUG) to help
> implementing a driver without violating the normal rounding rules. Make
> them less strict to let above described hardware pass without warning.
>=20
> Reported-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> Link: https://lore.kernel.org/r/20241103205215.GA509903@debian
> Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
with Dimitri's tags.

Thanks
Uwe


--dgv6hyxy3og67axw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcsnvQACgkQj4D7WH0S
/k4vrggAoaf0ubj9X5b15N4SGS4CjxdV4FUlYGdgtVHNcV8kunAvmf6kZ3wAlIan
9xhy/ZCxt3yJjT/Unei/rGnAjmdVSzv8Nb/UHfHXYyhZEqyhOP96qjW7jnPX5Qfg
DA1s2PH9RQ/qEPV7+o0dTnVAaYpbiPgM+MRTbn1Acxi9Fx8KSpHOupCf/VLHq42J
yLL3ym7A1X0YOGL9LWk9KNZg3wGNTtvN8hpEm1sNvsuaAIILrOwOvg/8sYw/uYtD
mFJ329B20XnsrLNm0JR3RrxYBJLyFUrJehf7fbXrkGgn24hmTRJYtHjHvXXeVPql
4IThm/BPerKZMLTHDolVkYdnAhjm2w==
=+FGe
-----END PGP SIGNATURE-----

--dgv6hyxy3og67axw--

