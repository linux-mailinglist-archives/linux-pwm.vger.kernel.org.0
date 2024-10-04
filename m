Return-Path: <linux-pwm+bounces-3448-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6610D98FCF4
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 07:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE3B1F23050
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 05:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC5981749;
	Fri,  4 Oct 2024 05:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DWgqMZKv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662524962E
	for <linux-pwm@vger.kernel.org>; Fri,  4 Oct 2024 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728019148; cv=none; b=Rk498Q3SBd55i8Tm+ovDSVGgp0+KzOZPFHO2NdHvikeE3qyGvDwjsdxFTPL2it17xfqg6BJGjrKi1btDD7Y/y7oGYcZV+PmkRCTjahcMj6SioCzT/XmQ2KlFAlQAYVcB9ko8sTK/mFAkSi3hBu1fBlqB/UHpA3sbSD9H2HlbySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728019148; c=relaxed/simple;
	bh=AQXvjz0PaU9cCDn5kumVndjIRqa6MmS/nLpQ7jAr/1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggVOSZjF4XAD+meW7WjJINzXDlbkHi7xTL3TXPgNEFDjgLD3yFf+yDqL/coVlZqIJ4GroqiId42H+8FrFCVzrtnTqV2Ov1Vrt0dJMKMUlNiRQZIiBiYEo7+qdmUQk59g1AR/mPMaXIcr0mMGfnSZbQRF789soo/WR09LxsWF0GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DWgqMZKv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so16779115e9.0
        for <linux-pwm@vger.kernel.org>; Thu, 03 Oct 2024 22:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728019141; x=1728623941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQXvjz0PaU9cCDn5kumVndjIRqa6MmS/nLpQ7jAr/1Q=;
        b=DWgqMZKv2qlYp6+dN595YsT/UOUWOzza5Rg9U2pK3UVYuzu71X6yLrjlvnDqzDe3Bo
         8H40psVOEQw3QvNMzaIoNHtSQOXzUCYQlMKNwDbR0n79ZaULjsSws7dVLMrqnc+Bd9O2
         xQK9YwjSpDMP81o5sgpea8TUAXCzt7YXmwr4JG/Djkadm9u8xsEklfnkbPqwO2CMntm0
         1+ozId+p70Qv6vckMQvMt1mP16+a3fER1wODyUlZx+V8RqLwaLxVYTJXOhF995gPeHtQ
         XIdwxV9Ww1ZYLdfaVtMp1UZc2w8PTkref2ne2bGXyLE9qE80RAtu6m+zHRzmwmC8bs4p
         cVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728019141; x=1728623941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQXvjz0PaU9cCDn5kumVndjIRqa6MmS/nLpQ7jAr/1Q=;
        b=ABDeApbR2NX27+KzlwaptgU/uGdQEP6QNow2iQFVdd5QkLIODzmjfWKyn863ySuU/y
         m3NUKjG1Y6AFrht+DRuM40zm1/TcdH2HZ29WLJ7Z5r9+ou1pFU37biLtRBWetvO9t62b
         ApzU7w+zv9ctolQv1GhYxyFTkBXvf65usgxBv0/J6kWxnrVEptIuAcnG6bZTArOGDJfg
         jKMKogxMxJYPDZk1nkSMbfuAGScvGjbO7t1qn3SoRuCWFrRfSQS3B9yc5wnztKRcDxlv
         7O2LlHwWJx98jQ8vadLROyX1lO0t5Q9jOKVtDpN542+9veq0NS5G1Izz3ALvefGDF6E8
         w55g==
X-Gm-Message-State: AOJu0YwHlEXim6yix2lj9E309wG5/IkQRXWjXKLRnfKxFX7E0sZ4tGRC
	OGRHGDK2LFLHbzp5B8dzIoFfMfGIc4+yxfGO8HTo6Zriw5FyXaYqqeAZapsp1EIVbpX4sWwTE2X
	T
X-Google-Smtp-Source: AGHT+IHq6C2UXonHYsAwj/oCMSBf3gPzuUa2ESNkvyw29by1/kqTdmPThbdICDYXVub/8sWJwQH0ig==
X-Received: by 2002:a05:600c:35c3:b0:428:f0c2:ef4a with SMTP id 5b1f17b1804b1-42f85aa817emr9210285e9.13.1728019141254;
        Thu, 03 Oct 2024 22:19:01 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a0aa44sm6016265e9.4.2024.10.03.22.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 22:18:59 -0700 (PDT)
Date: Fri, 4 Oct 2024 07:18:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] pwm: Add kernel doc for members added to pwm_ops recently
Message-ID: <z3xartccintzuh5uytgwm3yeikzz6d2tuk7fhvqgcann5trzlm@ju4tfbna37ud>
References: <20241001085138.1025818-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c7mklkschxjeh6g4"
Content-Disposition: inline
In-Reply-To: <20241001085138.1025818-2-u.kleine-koenig@baylibre.com>


--c7mklkschxjeh6g4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 10:51:39AM +0200, Uwe Kleine-K=F6nig wrote:
> The callbacks for lowlevel pwm drivers were expanded to handle the new
> waveform abstraction. When doing that I missed to expand the kernel doc
> description. This is catched up here.
>=20
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Link: https://lore.kernel.org/linux-next/20241001135207.125ca7af@canb.auu=
g.org.au
> Fixes: 17e40c25158f ("pwm: New abstraction for PWM waveforms")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.g=
it pwm/for-next
(actually already on Tuesday).

Best regards
Uwe

--c7mklkschxjeh6g4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb/er8ACgkQj4D7WH0S
/k50YggAqM8mQhl+yzWCeY+bV372HOK+QiuZkDxl+UZfBA/WGlzm68HgICoUvmyI
cTv0zoZwTC0da3BO0Fbj8Xu54zc0pYvvL0I4KfDcm6FB4A/sJXsOQr9NCT3n6s/T
rfYcv4BrbulMcR5ybUeU5XiSTUekI+54ITkSiwH3PUb6+RRdXTIwED5lfW2MGQye
0x1pY188N/gFqyZa/3Jda5gdstMRQP6j73+iCtB5JBScEuEqeCC0kYxxwtimmXSU
qIJOwqkH/93YZMOQ5huK+9bYiA04jN6W6W4uGrQaOfLSIUkrw3vdIjPUrP/+glL8
1x78uyVhPddI8rjDx4/wGVHNKewPPQ==
=v61U
-----END PGP SIGNATURE-----

--c7mklkschxjeh6g4--

