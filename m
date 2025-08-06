Return-Path: <linux-pwm+bounces-6974-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 131AFB1C7D0
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 16:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1E2161EE4
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003DD215F4A;
	Wed,  6 Aug 2025 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="07cmRkEc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC70C9463
	for <linux-pwm@vger.kernel.org>; Wed,  6 Aug 2025 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491430; cv=none; b=rZXH1uzGf9jKqC2GqrxhEb9sIS4yX+LgN025umOoaCKGX4D6oT7dbwNO1wmcGfqhbAmBDXapqe2+n+a06Ppo8ANYMlp1ag4gwSipyu3pTaT8tXgq1aYuoUkFz09OvV3m/gi2FYeoGQ2liRRrDPUItFvqfP7oJbg6i8rBOo7dIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491430; c=relaxed/simple;
	bh=ZzKFJ4yHJ7DCQCvUFX2RLuuegQ3GKxIuAUtI+zl6XmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxiR8PlLY3S0agw9ze2RHUZlZj1OMjEhW9DaBDh7Ad2RaD3tFb6vhH0M8A2pEpvouEUxSy8X0GEGEg1cwXMKkjiYyP4FzxETBdf2syx+ytdAmKESKId5w4cygOEd7Tjk10OBdFsbcY8ZkArM7RC39+Uajk1cU1LyofGUpETAlbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=07cmRkEc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b783ea502eso706395f8f.1
        for <linux-pwm@vger.kernel.org>; Wed, 06 Aug 2025 07:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754491424; x=1755096224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VH/RNGwsGxAQ5onQ4CWDXuDU973vpIbBVYO78gN0lAk=;
        b=07cmRkEcmyvJoQH4LclMQf1kcftA2QRmejvBg4pYjGE3exn+tykdPJDsvbVKfNwXYB
         qAq4gpqMBGpEjvLEXjox8H/MqKU5TttoxCs8eQRDEbQ2pvkLJTytVOU/2aY6W2zB//1G
         OgjQIU8waTaTtVXTB+OgvGO0RAvDsL+9OHmHGOpLbZgS+YplC030Wyu9WB3wneAuWhA2
         FZOhrNrbdJKrKLmvJit6gaE+JShx8vuh0K/U7QFoP/pMSa9bw9KetCOe5gq6swBgmZAk
         BWagpYhnuvcVrE7aq9xTypJ6gSpslT5T/u2QcSyRCoCF5Uqb6KolZSKHk5ItFmNMBF6F
         m2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754491424; x=1755096224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VH/RNGwsGxAQ5onQ4CWDXuDU973vpIbBVYO78gN0lAk=;
        b=B2hMZrwy0UXf49mxfmUNyQcD4sXlGampSOy9uIH14TshmKNraYpNPxNiKHKeW2lhj1
         NjB0TXeuChnAC5/mfjWQofzpLmqO6C3Ock68eE5dQcYA9tWAWifU01yXAeZa7xRdeiTV
         x2EkNY4m6KGcv7pWPOmwdQUskw07Ahye8LUtq8E0uEGjekIxptFGD6CGMpElO1wM9heP
         wy5Y07dAnA2luTVdW2oJ+Cw+bJ9SAKiI9kf8BFNx8myst9JGA55JwzoOHXPpdfkR24jb
         p26pWvv14T+OOP/BMoo7NlmNhrQNIqmnq/7n1FdR/lxTdZ4z214g3nI9zYrMgjEB8o17
         LBgQ==
X-Gm-Message-State: AOJu0YzUTzErdDqOlgDWA4cCYE5KwxfEUUp9JaD+4tO3aAI3ZxfNMHdy
	Kz+7bEcEb/QUrcjGTn7iy3AqgMxTHG9oVoY6VGlv3z23A9d7OA/83NV726RySvcizORXseStnGJ
	VbYcVluU=
X-Gm-Gg: ASbGncscD2AAAPUCOrvdhLidJVsidwa1kruSrw9ZyyGChtNLSCc+8XvV8R2+2BjwtEs
	5hFvaWDT/V0u38SLeLtZPmeboJSSpTrohY5cC+bB1wl5yNNvzEBr7kGLcAX4QkyMs7r4mPfobjo
	Vz0e8JFmAeQrhCuyJivc2ts1TL5bSLbgumWfUCT7EBoPKQ1csED/wrGttgtOzi4XDtiA4ztxhK4
	ob6OBCQDGzgMbpfkuueBtNyEOBLdbtlhZwyDAosvf0/5qVXbK7StyIpO9DAJaWIzL+wKl4kxvGy
	LJsyYBnj+4ARjeIrNNtjPhYwXmXRXm+ZlVCTB33tDtCL3WxLyI8OSqa9cV4bUQVT12UMyPngkXb
	uUUu2hiSc3JN8GtZmNCq4vp4VBqbwMlLGF7sGlzGA8J7GrrvnCqVDMUDkrXFmt0gE
X-Google-Smtp-Source: AGHT+IEjopSKCdy7U8FKkZXAjb3CuQDXRTKLcweLWBxM8N+4unfyWADRxJ/f8jD1TFxZal7semg4Og==
X-Received: by 2002:a05:6000:2c11:b0:3b7:8f3b:1726 with SMTP id ffacd0b85a97d-3b8f430c2f7mr2812824f8f.7.1754491424474;
        Wed, 06 Aug 2025 07:43:44 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3ac093sm24451789f8f.9.2025.08.06.07.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 07:43:43 -0700 (PDT)
Date: Wed, 6 Aug 2025 16:43:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 0/8] pwm: mediatek: Convert to waveform API
Message-ID: <dwycjujhxtxgjyjpfsgm6xttrgcskdobtc7dw5sts2fuutcwxi@5v7ekobsjojv>
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gdu3m3k3aua2dak5"
Content-Disposition: inline
In-Reply-To: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>


--gdu3m3k3aua2dak5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/8] pwm: mediatek: Convert to waveform API
MIME-Version: 1.0

Hello,

On Fri, Jul 25, 2025 at 05:45:04PM +0200, Uwe Kleine-K=F6nig wrote:
> here comes v2 of my effort to convert the pwm-mediatek driver to the new
> waveform API. Changes since (implicit) v1 (available at
> https://lore.kernel.org/linux-pwm/cover.1751994509.git.u.kleine-koenig@ba=
ylibre.com/):
>=20
>  - Rebase on top of the latest fix for period and duty setting
>    (https://lore.kernel.org/linux-pwm/20250724210041.2513590-2-u.kleine-k=
oenig@baylibre.com/)
>=20
>  - Don't report a disabled PWM when the PWM is disabled. Though that
>    seems counter intuitive, this is the only way to allow the consumer
>    to query the minimal period. This wasn't necessary in v1 because back
>    then the driver claimed to provide a non-disabled setting for
>    duty_cycle=3D0 .
>=20
> As before the patches in the middle don't serve a functional purpose
> because the last patch removes the changes again. Still I consider it
> useful because it reduces the last patch to what is needed in such a
> conversion.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=F6nig (8):
>   pwm: mediatek: Simplify representation of channel offsets
>   pwm: mediatek: Introduce and use a few more register defines
>   pwm: mediatek: Rework parameters for clk helper function
>   pwm: mediatek: Initialize clks when the hardware is enabled at probe
>     time
>   pwm: mediatek: Implement .get_state() callback
>   pwm: mediatek: Fix various issues in the .apply() callback
>   pwm: mediatek: Lock and cache clock rate
>   pwm: mediatek: Convert to waveform API

i pushed the first 7 patches to pwm/for-nexxt now. I found a twist in
the conversion to the waveform APIs that I first want to think about a
bit more. The problem is that a setting with a small duty cycle now
reports the PWM as disabled. While this is technically correct,
this isn't helpful to let the consumer find the smallest possible
period.

Will followup when I left the current rabbit hole.

Best regards
Uwe

--gdu3m3k3aua2dak5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiTahsACgkQj4D7WH0S
/k5qWQf9GMIt2sdEo77P7lLjheoo6iqKh+5H9p8KulcNmovIksZ/n06236dor+ch
JNG9DV2LJVxV9XOTHD43lXGOS3BnovK0qAyCnF+iQgLd+6Bbx/WpQfhHn0PieqXy
5jCWDAWc8L8TALhfqb7PssQlScPdTS+PHj0lhDiAMWTuXshENDmO6kKB/dHT5aln
E/trUXgP9EScJZZWpcyYspwFSGcQqaoM5Z9h1IZZOA8J4+F/epjR7AQ9sdaCQz9a
+WJygPOPYCRydbojXrekRPA+6c3MphrSXKKR+HS8cOFbG9SlwMRc9DyXTagZ6ehR
ZkCGiMh3Gfsr5CXjFuiI/Q+lmeKvug==
=aEYh
-----END PGP SIGNATURE-----

--gdu3m3k3aua2dak5--

