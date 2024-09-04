Return-Path: <linux-pwm+bounces-3089-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87AC96C462
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Sep 2024 18:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C6D284F61
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Sep 2024 16:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FCB1DFE27;
	Wed,  4 Sep 2024 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2+Qvmr57"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46371E0081
	for <linux-pwm@vger.kernel.org>; Wed,  4 Sep 2024 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468416; cv=none; b=Tep00DVYmTTx5T8dFXoemrG5uHHT1kVAbxBgz6pS06IaIeoCuBjoLUk1z8e/g8+j4BtBtfGUcHOUWk7VA8w6ax/ZvhGRg9SXjYebUXMA1V2zsnUMARSQIJuNqE5y71QFwfwbsGP2SDgcdiYVmmAcQdCDP9JXM3BXm4OyBQUOFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468416; c=relaxed/simple;
	bh=HmxRjR6VKr4hFAs8SNf+IBAU0oBMQUTQJ7mXLPqaIsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0S8LK7QouAa8Q9rwDlRmXGTHW68wh60sEwVcpLgA1Oht5o1yevluzT6w333baobO2fA8ah3bex7J1eX5nTYVGX/UuWXmkImgLCi4bxTyWedDZ+B/lMwVosHKxlEN+eBOYia2koOxbci94CJOx5ydK50hFaxpqd8OUGin+yhWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2+Qvmr57; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c3ca32971cso591743a12.0
        for <linux-pwm@vger.kernel.org>; Wed, 04 Sep 2024 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725468411; x=1726073211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmxRjR6VKr4hFAs8SNf+IBAU0oBMQUTQJ7mXLPqaIsI=;
        b=2+Qvmr57cJjMwCDmQMAJtF2EJuwGeEXE3nxW1ZUKx2y6R7GfaDK7QVvV3Qi9x/V5tI
         TPMUejasgNJH8rW3uNv77cm29G8bPQjVA4cQXXKxvNRYzvKkOaozX8GzyXUHppRsyHkM
         aN8Z0JnUjzeh8wp+ktUs6DVCv4QMTKAwuxZ6AdqzmLUtecvY4UdwsDJKxG7KADV6E1j2
         FG0jGgANHPdUNajOuSnuUAKaDZ9m+djMjnaBXLEMEPbggUGq80doGpEAS12L2ToqiBg8
         RLFKWelTX1UUJbZnmtl7qw03VV4G6vAgVoVZy3UwNFzDyIga608se+3Uf4zqC5l3Dxg1
         OOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725468411; x=1726073211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmxRjR6VKr4hFAs8SNf+IBAU0oBMQUTQJ7mXLPqaIsI=;
        b=Wu91ZdKyeSLl3Dc6NIr1TEQJWNKRoWWebs5l+JW50wMLeQRh28Z1MHHtzI6nhEYuh3
         TobZuI56WHCgWqe7+JNOqYm2Sr96TWfdUV3NCTXG7E+sqtJ4nsCOzmG1YDxh3GRtaRQD
         f2GC+F1qEiADMOHB+tTAs+cV10H8U8+ojDBGQczIP8hK7egkfMv5WTy90oUHLn9TYbvq
         Zm6N6qRXkpOPjQRhwSH/BxYsQXTcdCoUqr0LWe49XTPIt4M7UQBcPAsM/bDnydFSVAl+
         RJ1Ds7fmKFzwQcrQsymagXL1ecqPZut1Bk0a/VNXYRCnVSKBCGW5GoSCzlWFTKeGlH3S
         92AQ==
X-Gm-Message-State: AOJu0YxqMF7MzP86y3e+rznzPl22HcCl8FiWqWQai5qxpi/qVUgfzNys
	Ewo9AlETsYV9P0lYw1+nXfvKFMf7/RTGbIPoc3e/F3515FWId76sPHZCDU9nrg1ktQftxsipBlZ
	j
X-Google-Smtp-Source: AGHT+IE5aHQKRbu4BtGLZq6drsobXO5g+W1R3wWQ4aMaCZvk/mJHLCbBEf7tbZZkiA5qUXNXDZHhuw==
X-Received: by 2002:a05:6402:3484:b0:5c0:ba90:463f with SMTP id 4fb4d7f45d1cf-5c25f22d5c1mr6631115a12.7.1725468410744;
        Wed, 04 Sep 2024 09:46:50 -0700 (PDT)
Received: from localhost (p200300f65f0046006ae56225a49a5edb.dip0.t-ipconnect.de. [2003:f6:5f00:4600:6ae5:6225:a49a:5edb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc697eefsm110800a12.67.2024.09.04.09.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:46:50 -0700 (PDT)
Date: Wed, 4 Sep 2024 18:46:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 4/8] pwm: Provide new consumer API functions for
 waveforms
Message-ID: <3krlt7ptdx2444azuq7o3brmdxki3rc5hjpa5zfdn3bx3upelm@xc3hko4qhvfl>
References: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
 <015a5fbd5cf449bcb2d8fdf2305d7b6bf7109844.1722261050.git.u.kleine-koenig@baylibre.com>
 <4230e4ba-d8d2-4f53-9d1d-4a4325c72c8c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s7xwpe4gtrjekc4v"
Content-Disposition: inline
In-Reply-To: <4230e4ba-d8d2-4f53-9d1d-4a4325c72c8c@baylibre.com>


--s7xwpe4gtrjekc4v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Aug 20, 2024 at 11:06:41AM -0400, Trevor Gamblin wrote:
> On 2024-07-29 10:34 a.m., Uwe Kleine-K=F6nig wrote:
> > Provide API functions for consumers to work with waveforms.
> >=20
> > Note that one relevant difference between pwm_get_state() and
> > pwm_get_waveform*() is that the latter yields the actually configured
> > hardware state, while the former yields the last state passed to
> > pwm_apply*() and so doesn't account for hardware specific rounding.
>=20
> Hi,
>=20
> kernel test robot caught an issue with a pwm function while testing my iio
> driver: https://lore.kernel.org/linux-iio/20240819-ad7625_r1-v3-0-75d5217=
c76b5@baylibre.com/T/#m7b3118821c416240e0309a8c2bbc5c51ba4b0823
>=20
> Looks like an issue with static inline versions of the consumer functions
> not being present after the #else in pwm.h?

I already replied in the linked thread, but for completeness I'm
repeating the gist here:

I didn't provide the stubs on purpose. If you use the new functions,
make sure your code depends on CONFIG_PWM.

For more details (or if you want to discuss that) please look at/reply
to the more verbose mail in the other thread.

Best regards
Uwe

--s7xwpe4gtrjekc4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbYjvYACgkQj4D7WH0S
/k6ZjAf+Nu32Xyav+evY+3RQP3dYDJoEsDDloFwOtmOvqn3ParQcftTIHArRQu0Q
71qvWE3ULRz5RxLo4XmIKFZkwdciZC2bYkUY77lEsaFY2fOjpykMvO+iJenY79Cu
4ivEj3sjILQwK9YZakU22XYSSAQ6o4eKeLMug8MebZvnbECnY9fvBGiYyObx2vTp
3QsjE9Z8tNBTNa/pSbNV/8CsAXOCIR4vcrm+pSPd9rwSj16AtGCuUVfjO2TkHFYZ
+FtutJ/2Jw4Vy2zVCG5OShzpFl+cT3KFYcaXtpeQpRw5TCraQQ3NvfEnxtOnxXqc
xWcb4shFk/l6PA9MSWaO9yKfRj/+LA==
=x3lP
-----END PGP SIGNATURE-----

--s7xwpe4gtrjekc4v--

