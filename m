Return-Path: <linux-pwm+bounces-5559-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D998A91DD8
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 15:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8F019E6BCD
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Apr 2025 13:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E8823FC55;
	Thu, 17 Apr 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qPpsNwVa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A712322A7F1;
	Thu, 17 Apr 2025 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896264; cv=none; b=LSBP2Zo4DoZk0Otyu459ycDlvQ85fWDcmxQ6/A4L4IM1VWaztWSusWP8bjTFoNTFqXGpPAsxPZJ6dp1A7qJ97WhohaRBKJ5NTwu85cOHQV2jFzfOH1yp1CxRJfjbIRa2BVZY070oWcBGyESHb/pEBz4gf3Rj2B8Qtk1B1QrRiGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896264; c=relaxed/simple;
	bh=3C0z3bqQphJ/rneK3taoWu7dxwuwy273SojRPNw7Mik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R50uoPZ1/RjANZy9QBlRCwbrpW+X1/I5jzslPOMdBWUG8lO9ijzpG4cwxH/FDjEQdMTekUlM7pk5Ggq5gFVFVYvAVJeEYqBmYDr1vCmvKG9gOScM2RTCMw6HFVf/7ENpDiAbtfM2nKsxH8SKD4W+1qr6iiy5/ASlpbRA8hENgN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qPpsNwVa; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7025041062
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1744896256; bh=9yhRUByZUvTPPxNd7Jt2Y3FeXqk3lHI/pOhzKqMczvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qPpsNwVaDHm4uTuAjs27umd7qRVoYlFxIGVw5G8tBJtHshsZfZXN2dfbOjICoh03C
	 lWJ6XzlpYWGYHcSd7ABu8CQrGRxGjVXIiTa3RjNilQ4Thz2HsJzo3QHwDAuaHz2sfw
	 mddYKpEk5quHKmIVakTOHM96mAZRaQ5KIuE3gnsHq/iq/V+SNiPFRldmgnD8komrQv
	 IF3v8Tbx4JmrqXfONSF8eXGtErz/ayMt6b+BOKys5WKTDtkgCgI5HRlAS6RMdlbbxe
	 LeTryIT202uWTXF/RENSGzWPEYebkwlAkCGm6eEy/oW50I6i7bvSsAohjBGPAjWBR9
	 QD1X6GUdXj4Pg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7025041062;
	Thu, 17 Apr 2025 13:24:16 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] pwm: Fix various formatting issues in kernel-doc
In-Reply-To: <20250417092535.2669166-2-u.kleine-koenig@baylibre.com>
References: <20250417092535.2669166-2-u.kleine-koenig@baylibre.com>
Date: Thu, 17 Apr 2025 07:24:15 -0600
Message-ID: <87cyda6hvk.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> writes:

> Add Return and (where interesting) Context sections, fix some formatting
> and drop documenting the internal function __pwm_apply().
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello Jonathan,
>
> while looking into the warning that Stephen reported in
> https://lore.kernel.org/linux-next/20250417162700.728e14e5@canb.auug.org.=
au,
> I found a few more issues fixed here.
>
> I intend to merge this via my pwm tree, but getting a confirmation (or cr=
itic)
> from someone who knows kernel-doc better than me would be great.

Seems generally fine, but ...

> Best regards
> Uwe
>
>  drivers/pwm/core.c  | 30 ++++++++++++++++++++++--------
>  include/linux/pwm.h |  8 +++++---
>  2 files changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 079964961bd8..447077776bce 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -222,8 +222,10 @@ static int __pwm_write_waveform(struct pwm_chip *chi=
p, struct pwm_device *pwm, c
>   * Note however that the world doesn't stop turning when you call it, so=
 when
>   * doing
>   *
> - * 	pwm_round_waveform_might_sleep(mypwm, &wf);
> - * 	pwm_set_waveform_might_sleep(mypwm, &wf, true);
> + * .. code-block:: C
> + *
> + *   pwm_round_waveform_might_sleep(mypwm, &wf);
> + *   pwm_set_waveform_might_sleep(mypwm, &wf, true);

Here I would just use an ordinary literal block rather than embedding
Sphinx directives into the comment like that:

 * Note however that the world doesn't stop turning when you call it, so wh=
en
 * doing::
 *
 * 	pwm_round_waveform_might_sleep(mypwm, &wf);
 * 	pwm_set_waveform_might_sleep(mypwm, &wf, true);

Thanks,

jon

