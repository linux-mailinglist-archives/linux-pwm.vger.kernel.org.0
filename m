Return-Path: <linux-pwm+bounces-2751-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D0F92D4FD
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 17:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C791F210F9
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC3363B9;
	Wed, 10 Jul 2024 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W/N8zgz+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ED410A09
	for <linux-pwm@vger.kernel.org>; Wed, 10 Jul 2024 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625496; cv=none; b=RKXmEsJqs1Eg9vF79OTlQ9MlA5icdQOzQQiu7XT/vupwAvDetVliFZxiICSjV9leRlxQfHRJ0ya4T4QZa+tLbCyou2eA4NTC8+eqWimnfM4TBR44IUtnUzUFpISS1PRevMb3U2NlhRvxZwEtEXnVcsxDAB3PhMFV5aX4Q5EYtNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625496; c=relaxed/simple;
	bh=kGoQDT0AT5Z0IkB/fIpMCOwLxicAbNvoxxT5SVTO0SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSEtsMAvO61m/ki5kQ08OiSvulzgEoouiwDvFzka22H78r5nTB7v65+NC+k5e/pIrGqFfF8v+i8YyjQbGZ7u/GebRwc8JQOPx9UKTyxdaxrE0FvkVfnXkgjzKwGeXHZsSUwSeJfQDr6AJZoI39uLopYEPjsOJ84lmRw1U8vLwlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W/N8zgz+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-426717a2d12so6260895e9.0
        for <linux-pwm@vger.kernel.org>; Wed, 10 Jul 2024 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720625491; x=1721230291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kGoQDT0AT5Z0IkB/fIpMCOwLxicAbNvoxxT5SVTO0SI=;
        b=W/N8zgz+T/wXzQdp2m1n95vgR0jn8aTkZO5s8MpJLGGgQxJZp2irmRt0ojJAybasMk
         SO36C/Y2JuPx4jAMKWgClV85vcTE2X7p5pYQYlHiS/Htinis/RR1+HOmdgmA5AiodtBt
         ZvEbRPy8x9BF30OiICV+HLLvTzSDPQrejiQAa/NBmlhTGAIBLZ2FQdj86wE18G0ud6Qr
         lAz+cwhKWJ0g4pAlK/sQpGZbxz3cAV80sOG+c1mCKxtlhPbohWqHZNPI2G0JoD6Op5he
         Fc13BirzWJc5hcnKzclZEpMNzXK2m3nVFC7x4L6f7VHf5npzd5dFLmDkQzEea41yoQvy
         PLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720625491; x=1721230291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGoQDT0AT5Z0IkB/fIpMCOwLxicAbNvoxxT5SVTO0SI=;
        b=a/cyT4iVUsMDYNhxOkooypwQq5dBumwZ0+3UB4+ZOcMbTzLYVQjPr/buGdfRlt9Onb
         XEa8Z4zb+Jc/z06CxQkJEMmfDh1qv0wnqv7zMIaKWZntZFgIybAx+N4c1id2mg2eCkfp
         Wl8/wndyzTWGiOMwlHUIdeSj9UlMSyWF6JSm/vaMBzgaLouOHRn3XOemIAcyYX0Ytp6R
         ftNwW6LqcHHGI84LMfs4tCcKs1m//sFyRpTLLQu0UBVDm/3bJ2avAc3uwSRi+r2UTXwd
         k5xAE/k9aje2XNFPDyARC0KaOeMKuPbqBQ+T3i5tq8SUDnwNBo/DXAME0U81oNQKomva
         cA7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHEX1uUsg/jQxNllIKVcyXUrSI1jx2Y4Wy2pCZUGZNuUuYnWJDfkdPNSeBrWghIFOCP8pyBB2YFpvCkmD7p85D4uaJQXhMj/Xu
X-Gm-Message-State: AOJu0Yy4VpBJqitvtUFXU5vgTzZ3JdSqHY+v5W518cJnroBEBroumVjY
	7N0gKcNpatthldrupfio+gW/OTYHlGpwqpcrSfIqSja/x5toJLim1ZwroakSS8U=
X-Google-Smtp-Source: AGHT+IFkDAzjUyXZl/AMphCJyuepuXqSVYpMiPZ66qDKSX01A7bxZsCxFA7XanrpBwkhc5LfZ5tkLw==
X-Received: by 2002:a05:600c:4316:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-427981b76damr146055e9.6.1720625490786;
        Wed, 10 Jul 2024 08:31:30 -0700 (PDT)
Received: from localhost (p200300f65f164800ca5d02fee8f4878b.dip0.t-ipconnect.de. [2003:f6:5f16:4800:ca5d:2fe:e8f4:878b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741fa6sm87640575e9.45.2024.07.10.08.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 08:31:30 -0700 (PDT)
Date: Wed, 10 Jul 2024 17:31:28 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Boris Brezillon <boris.brezillon@collabora.com>, 
	linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] pwm: atmel-tcb: Fix race condition and convert to
 guards
Message-ID: <i3d3x7rzqphcjhagmdfenqxrzq72k5qdmdv2dh3tjvwmbrcub2@nfkck2zyjbzf>
References: <20240709101806.52394-3-u.kleine-koenig@baylibre.com>
 <bbb984a8-8815-45fb-8ddf-a5180f6e41c4@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2r5s4vrgtgcgrzng"
Content-Disposition: inline
In-Reply-To: <bbb984a8-8815-45fb-8ddf-a5180f6e41c4@microchip.com>


--2r5s4vrgtgcgrzng
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nicolas,

On Wed, Jul 10, 2024 at 04:17:09PM +0200, Nicolas Ferre wrote:
> On 09/07/2024 at 12:18, Uwe Kleine-K=F6nig wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > The hardware only supports a single period length for both PWM outputs.=
 So
> > atmel_tcb_pwm_config() checks the configuration of the other output if =
it's
> > compatible with the currently requested setting. The register values are
> > then actually updated in atmel_tcb_pwm_enable(). To make this race free
> > the lock must be held during the whole process, so grab the lock in
> > .apply() instead of individually in atmel_tcb_pwm_disable() and
> > atmel_tcb_pwm_enable() which then also covers atmel_tcb_pwm_config().
> >=20
> > To simplify handling, use the guard helper to let the compiler care for
> > unlocking. Otherwise unlocking would be more difficult as there is more
> > than one exit path in atmel_tcb_pwm_apply().
> >=20
> > Fixes: 9421bade0765 ("pwm: atmel: add Timer Counter Block PWM driver")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
>=20
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>=20
> And I like the conversion to the "guard" lock helper.

I hesitated a bit to add it because it will make backporting to stable
harder. But I guess we will just not backport it, the problem doesn't
seem to matter in practise given that it was found by looking at code
and not hit in real life more more than 11 years after its introduction.

Best regards and thanks for your Acks,
Uwe

--2r5s4vrgtgcgrzng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaOqU0ACgkQj4D7WH0S
/k7Z4Qf8CRQe4gJDiuCWn2UcqjJJg8L4TmnKGJBvLp/hSCcp1FK7lXEX1PqhJ2f8
pMJPUfTLb3BlsuzqNggFKvKvNl11bUNVq9y4ssowjpefnPKwVKwayyWv/g1SkYeC
eXopnMKI2mIru+vrvQ4faeZBRUKFm5TzK3t3N+jt77WGJxDllNdvXQSp1dAyioGN
FTcu4ohzOwRs1yPHt1oj2nqpArQ30T6hvCKtPCNG5aL3Kpck6eKGYtmwqKs8zeD3
/n6J843CjwkCuxP5MwkM626zBTxJhwLETvTATPxRUarxbxGVS5SGp8mPkU//JzuD
fG52xuPDKP/me9Mr9oyiFwYMsjRJng==
=fWrt
-----END PGP SIGNATURE-----

--2r5s4vrgtgcgrzng--

