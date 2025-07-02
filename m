Return-Path: <linux-pwm+bounces-6685-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF53AF0B32
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 08:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603C43AEE3B
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 06:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B18421323C;
	Wed,  2 Jul 2025 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n5LR7wF7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D597A1FC7C5
	for <linux-pwm@vger.kernel.org>; Wed,  2 Jul 2025 06:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751436160; cv=none; b=M8hw0lj0gZOi/s5qracY841OW5tzotFOgx1d66iOcmUiYUmMN1lj6RSAskP+wYDYkCJ4wBVPqmECA7AMkXCkefPSlVzG2V8mc8dek59pPEnTV7wke2Cf92gP4kir+5SxA1XbiHeadSX3cktmeEK5ZMqfSE3DbMuSLrXtPcJ/9w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751436160; c=relaxed/simple;
	bh=aJd1Xhl45oUMd6JJSHtorv10Hn1Xnth8R0PI57hN7S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqB1E9LXdn4sH4C62QDMOZWFjaPf83tD2hsHgA4YjWpPzkd5VUjH6p/ifP29t+xXAGsZuDZJH58peJOtmrtS1eGy731qz1qm5N1rittOD7XS2X5G4IgR8KJA3mg/v4v6xcQW5NNiR0yiMH8mGm/PcuBwp9C43x0FET5xbOxyUaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n5LR7wF7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6097b404f58so10496440a12.3
        for <linux-pwm@vger.kernel.org>; Tue, 01 Jul 2025 23:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751436156; x=1752040956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aJd1Xhl45oUMd6JJSHtorv10Hn1Xnth8R0PI57hN7S0=;
        b=n5LR7wF7lqyEfgKOVzAGj1FKd2P8GFpXoiYuPu2ZXmPMI+xIq08ojD94ydlp6ArP/j
         PKtEDFp0+QfNRLHEV3lfIbtbOj6NflcGUSg0k/Y39mjvWjjNSmorqG+PI0oTmIymIDjk
         eGzKSYK4x+2RGGEjQy9IFSH6tqs35fXTtRGOA7sKweOuItxtdTtYJjPCbbAURNQ8p1tB
         wjafE8K5QAF9K9dZisjnUlWOc08+6mhIuiRbLHmb19YEbDhJp6kbw+/3QqNwpnM6WetR
         1H0A3Dw1tmubPKh3dK/h8o8pC/YxYJ2wCRWlasWsI/oKK3wdoIlmvv6847cC/pRRMJ4u
         O9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751436156; x=1752040956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJd1Xhl45oUMd6JJSHtorv10Hn1Xnth8R0PI57hN7S0=;
        b=N6mx9LqZudA4sSpdjM0sZTXBMrHsLG66/k/fVxZian6q4qLQwrdHuetWgKD9ifX+Dm
         YzrLWhxC0VPbSnRiuPKzkrdjTMGG6gQM+fkSM2gJoSM7/Xu8Q88O0kVzm8O9vvp1fvwn
         bYAC0ZtlsgpjsWm6i+h8OrZlokdnKu21zKnhjEhEMLTeXshOkPQu98Xic1PcQ8QsPf2e
         macthWKj7Kh+sCTReCTO0Ubb/5k6T1n7dfdc9YoXWaxsM35hGnwR+d1foGoXjMETveVu
         VmMMBG35xipBD0tmrkbBTwSK1nzXR3KmVdPGOAolhIey97KhpbNcxkXp6nnW3EDaOCs6
         VimA==
X-Forwarded-Encrypted: i=1; AJvYcCXsyf/vqNa3NYx9Ih9h2igqWZctgkviRxlekcrwEHSMJ7pLE1qmP+Z+OMMGZdH8voHDCwWz9jmQfSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Oo2uxlXAITsZLJesbI1695dYFH1qfiElNGL/nUC0taJ3tWmX
	5umwHD0kvp0KhBjdh1ezzShU1t4CqOQZ6b7WL2zWtifmfoF1D7F31/spUcs1SsQ+O6s=
X-Gm-Gg: ASbGncs3rp0GiO8vPJBa62rjzIHyfUUG7bPWEIAT94yx+CJf5HEGSzuzKV+fwCZONgb
	Fp1hUd6lz5sy16H4ZKC2dVQypv9nh6rTmPH42jWxn1svEtN/vVj7eMzyylSj6UBgSgi505C9Ubc
	e86b60xre0GpSvAowZt0949xktreZ8x6g4D/I+xoqCBVxqSBfaK4gx2gJcuTwgZ1AWdQjmxgAu6
	xq/0W9rVQbj5mWo8s+qWJJNAuuNgxKVZYw+QZ7pMwUD62W2Pg0e9DBm3OKeC5wS1e3Ee/EzatbE
	apbMxNyrZ2g7sOhzhnrGs4HcQD2l50Qa9iO/vaxVr2J9Dk4g3nyRWvA2pzEnRJspDXCCMlkBStQ
	57eQqsrYplVSXWV2vl+cos1+3hpnU
X-Google-Smtp-Source: AGHT+IG6/yccNqp4J+DsHToDNUC62Vpos+UEC5spUlBcFisq5GYf8q2guX/EUn0gYajh18cliyqHKg==
X-Received: by 2002:a17:906:4fc9:b0:ae0:c497:c5ca with SMTP id a640c23a62f3a-ae3c2b04f67mr147613866b.3.1751436155672;
        Tue, 01 Jul 2025 23:02:35 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae353c011desm1020565866b.101.2025.07.01.23.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 23:02:34 -0700 (PDT)
Date: Wed, 2 Jul 2025 08:02:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] Input: max77693 - Convert to atomic pwm operation
Message-ID: <sl3jqe36dfxfzblposdtkvlgalc4ydixpqkfmn7gc6hcjfwmqn@7bex3mxwjqyy>
References: <20250630103851.2069952-2-u.kleine-koenig@baylibre.com>
 <w3tkxxkqr2kmri3bz5m34dzw3hfvkqou3zbww7kwjdg72o7kla@ty777ynf26qr>
 <23ddfd32qebfzb4qftxih3mwpymghlezdv5u63qhxhqthpbxpz@u7f4tbihsfop>
 <yafw6oi62ckqgz7ur4idua2r2sjyxnfomc7h2v5w6tthqwu334@5i6tdfumtj5b>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iuh2ulbdpnlbszyq"
Content-Disposition: inline
In-Reply-To: <yafw6oi62ckqgz7ur4idua2r2sjyxnfomc7h2v5w6tthqwu334@5i6tdfumtj5b>


--iuh2ulbdpnlbszyq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Input: max77693 - Convert to atomic pwm operation
MIME-Version: 1.0

On Tue, Jul 01, 2025 at 11:06:50AM -0700, Dmitry Torokhov wrote:
> On Tue, Jul 01, 2025 at 07:49:22AM +0200, Uwe Kleine-K=F6nig wrote:
> >=20
> > I had something like that at first, but didn't like it. With that
> > approach you have two places that have to know how to set the PWM's
> > duty_cycle. Also I think the control flow is more complicated.
> >=20
> > I considered renaming max77693_haptic_enable() to something that better
> > matches what it does in my variant, but max77693_haptic_configure() was
> > already taken.
> >=20
> > But that might all be subjective? If you like your version better,
> > that's fine, it still gets rid of pwm_config(), pwm_enable() and
> > pwm_apply_args() which is my main objective.
>=20
> Yes, I agree that it is subjective. I know that you do not quite like
> the version I posted, still will you be OK if it is attributed to you?

Yes, feel free to apply it as you suggested.

Thanks
Uwe

--iuh2ulbdpnlbszyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhky3cACgkQj4D7WH0S
/k5V6wf8CN4KCNj3PRFBlrdw7tI8Dxo90rdEEev3igOd12SEnlf/Z491CR54wXvk
aWoO2ie8UJ+eCZ1Cbv0M/QUSB5aIqHW6GioyCmjHWBowacHJ7abN1twxhgL1/jnZ
H78WJbkzV2B/WAxdcoOzRP14dln+bmCpUA5g2s49jwzEKhyPBHJcqLFLAQoSI9ga
Urp9YQD9Q0RHbTgqik6CQVnndoNS0v1dJ1iXb8P8mtnrXMwyt3IyVm1e1SOV1tLR
hBjFmIxswAvOOyIpe1yS14VYNWj9iM/O4CVqEFZEz0kkKz7uMaTTTikSRolx+Gkz
AB7yk5ZstXDEQ975ByLMlHddOa9nsA==
=Qrcm
-----END PGP SIGNATURE-----

--iuh2ulbdpnlbszyq--

