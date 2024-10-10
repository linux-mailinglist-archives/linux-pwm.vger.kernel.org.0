Return-Path: <linux-pwm+bounces-3581-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C120E998081
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2024 10:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03221C26BFA
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2024 08:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90261E131F;
	Thu, 10 Oct 2024 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmO7Vryp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D401E1321;
	Thu, 10 Oct 2024 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548948; cv=none; b=fPJBSQ3rBId2eBJRw4nYlpcOB3MH5RqB/ygGiwJGZxyJQP4U7aJDoDasWse6/F4qT3IjvAnac0L1SLaAVQyolnjvTGwI3zsznu7n/r0FfMhRSihyyzq1fge7gIg4E1x8yNShI027vadzIBuEFmYmNW+01BdcUu0m9yF86XsfZrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548948; c=relaxed/simple;
	bh=I5Ea6PGkvzypTjuRn0NyGbjzXruH+kV9lE1eez1AFTI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OvkWw/IZtuGIdBGagmGpf7QDStFF0sCrjyHsVqiDfBEILgmWzVOol9XFZYg4ffvpqiMBABz2XYBL3uF9R6l2FRY8dvxMI1E7JlF6m+yTGmBBCMF+9kEq6tYPvFzQzrBGSqZm9UAkXCI5sI22fucCmjFGtKrruDiNRKCjd3HdR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmO7Vryp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso4514885e9.2;
        Thu, 10 Oct 2024 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728548945; x=1729153745; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I5Ea6PGkvzypTjuRn0NyGbjzXruH+kV9lE1eez1AFTI=;
        b=FmO7VrypFQl9aLp9JL7g9BwKwtm2gppuyo76KGRkT2oGfwpsu2ed5jaYqmVgiUer8d
         bTUh/L5ddBvwfnqi6A/54PPLr61F55cP0IIXM3QKyZyV9b+ymy/LMH4YNKk84vjot7zS
         IDvd4rlX3/+8uyZyuk7Jisry/1o+gF6AYrg8/psh7V0Wh5Ej04hmKtxHbgwOdjDE1wJV
         4/1UPj27xDs3Ot9fbCEoOklsDalG2abQAqRXt1xxe5zF6JGO+fc8JoIZqBniHQ5JUd5j
         c5RXgi5ocqBjbOxQ1cpAQZQz6PUTde+zT4us9fDYIJJzkT551H2gvEvrQvlLLxx+n/9e
         pB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728548945; x=1729153745;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5Ea6PGkvzypTjuRn0NyGbjzXruH+kV9lE1eez1AFTI=;
        b=HVFpY4E+kxmB36dIoIFC4qbwPqlKTYvreifRJ3VTswwVZS1yyZkV064ZL9ddpKtRFv
         HwQ2gvStGXFZ6a2gIWuO4Qg6zWNwgHP0dpPGcUeaqBxtsejwxTKihMA9atLzON+5r0TO
         4FJzga30fq7FGf7Y06wCSqjr9Gg6N57uGZmUqfKjI/YxlIT2b6zUf2Boul1yn5v9xuSG
         2NPg3TTXMwA9Our0KUIt+vBnZLCW7wTFBWHEUf5eP5D9SwPtRwu/FZB5BcwC9zT7+puY
         828yXl2ynghsEA30XL4srnOA9hdeV4jmVxmXXL+IHbAgbh/xF2squwNWOj8pjxA6vnjh
         FHnA==
X-Forwarded-Encrypted: i=1; AJvYcCXF44lvVQlTHsptLRYRPci5bWAjBJxg8sEx6mHhJZqfzCEvwJVuWVRP+IP3Y2dl6X2H6sA94ilTpF88Nfk=@vger.kernel.org, AJvYcCXfYRE/inud7YFsyDsypXjPKRRimV5OjuSjbgOOnNXXC5XegShXL5r8ME6gIciwEzBPI1VwgttJVaB7@vger.kernel.org
X-Gm-Message-State: AOJu0YzkFst2CDg+nlhhgyo6ppga3CBs8R9dXtmVbRpXbl3pKMynP8TZ
	BexCsPWxvK21f/GPTYMEM7a2nRVwdvMByOvVBtddBjh3yeUh7ASTL7bXrvhDLm4=
X-Google-Smtp-Source: AGHT+IGjK3bIM0DBkDb+cuk8Ce58H4JGpsO6ceiWUXDLSBsHO011Q1XTbXuF2dipNitWnlmuXJ86Sw==
X-Received: by 2002:a05:600c:1f0d:b0:427:ff3b:7a20 with SMTP id 5b1f17b1804b1-430d6faa2b6mr33791775e9.27.1728548945146;
        Thu, 10 Oct 2024 01:29:05 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b4462sm41474825e9.30.2024.10.10.01.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:29:04 -0700 (PDT)
Message-ID: <57169283416bf7902523891ba03d1f878772ffe5.camel@gmail.com>
Subject: Re: [PATCH 0/2] pwm: axi-pwmgen: always enable FORCE_ALIGN
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=
	 <ukleinek@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Oct 2024 10:33:20 +0200
In-Reply-To: <20241009-pwm-axi-pwmgen-enable-force_align-v1-0-5d6ad8cbf5b4@baylibre.com>
References: 
	<20241009-pwm-axi-pwmgen-enable-force_align-v1-0-5d6ad8cbf5b4@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 16:11 -0500, David Lechner wrote:
> When using the axi-pwmgen as a trigger for ADCs, we've found that the
> default behavior of the PWMGEN IP block is not ideal. The default
> behavior is to wait for the period of all PWM outputs to run out before
> applying any new settings. But there isn't a way to block until this
> happens (and even if there was, it could take a long time). So the
> pwm apply function returns before the new settings are actually applied.
>=20
> This makes certain use cases impossible. For example, to use the PWM
> like a GPIO to create a single pulse on and off to trigger a single ADC
> conversion.
>=20
> The AXI PWMGEN has a FORCE_ALIGN configuration option that changes the
> behavior so that any new output settings (period, duty cycle, etc.) are
> applied immediately. This can cause glitches in the output, but makes
> the PWM actually useable for most applications.
>=20
> Also, there was a naming conflict with register names, so there is a
> preliminary cleanup patch to sort that out.
>=20
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> David Lechner (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pwm: axi-pwmgen: rename 0x10 register
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pwm: axi-pwmgen: enable FORCE_ALIGN by def=
ault
>=20
> =C2=A0drivers/pwm/pwm-axi-pwmgen.c | 24 ++++++++++++++++++------
> =C2=A01 file changed, 18 insertions(+), 6 deletions(-)
> ---
> base-commit: ff25451372ee1aa4c4f4401dc96516782a00dd4d
> change-id: 20241009-pwm-axi-pwmgen-enable-force_align-cfb403da4612
>=20
> Best regards,


