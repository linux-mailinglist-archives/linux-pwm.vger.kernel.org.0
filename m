Return-Path: <linux-pwm+bounces-2935-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAC1940F44
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2024 12:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C724B25F45
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2024 10:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9C61A0717;
	Tue, 30 Jul 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SrJrckAD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B1019F47A
	for <linux-pwm@vger.kernel.org>; Tue, 30 Jul 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335177; cv=none; b=A2c8o3Xb53VErybwcizyNo5faQ+kGmorYcDdwzCXwycfJKXU5gva+JuyfTQ656M5IYLikvKG3XXvO3v3MPWtipgo7RjxZIOlYqkyQUpOhw9OdYZdJn8rMPBcHK3R7OzCV+iSnGCV9ZvyFRaV4uGBQNvwA41ws3yqfwuRE8MtEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335177; c=relaxed/simple;
	bh=w6CE0tTayGGj0EurttnWXfBGSVa89CM6wOtmq7ZN3Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nL7zPSSnp/OSIbEJ+iUvP7pcMXKkSQEo5FM0N35Jp+UaY9b8gLsc42nEq4SLra/HMJfcD28K3DT8W8hgCVoJDHnvGBvtgzCqqFbf8ic9XAm0qBdeAyUFmcIugfeK02YF64gHF4Sm4gaeBhZvaApYpfIIwzEMmSddEOcEc8DZn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SrJrckAD; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a975fb47eso621770666b.3
        for <linux-pwm@vger.kernel.org>; Tue, 30 Jul 2024 03:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722335172; x=1722939972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9HaKnNx0tuOXHJcNotj8H/kI6sAN2Y3iBab0dZw94qU=;
        b=SrJrckADWnYRBYzpFS+lDbZhAwUz1smwBJ8+ISbbgVL2AmM0jN5dlJq2HOnEdvfjUz
         jIrQvMaNH5ZZejee8d4eoYWsYPvtIMD3oBvfq5I94Qe1rug1VYzoHJ6ljm82Xt/xOki8
         pqcmb7rVmjrDqNS4cJPo5xF//b539YUdQwuhgbI2Jj03N4pe0MescTJSit1g1D8icM9P
         6ApW0b3TaPLu1Bd/DEo5YsHNRrw31AuS0O7TxShs2X+OqCcnThQ8O2HK8FR8np+jZ3Ek
         I6ok6F4miqEzesSPMTmbheswAGMv7SLikKJZh8Z9p83+CW36Uwe8gp5J6SA6IxFZRUcy
         tp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335172; x=1722939972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HaKnNx0tuOXHJcNotj8H/kI6sAN2Y3iBab0dZw94qU=;
        b=BrH5Z4nLMK0+CPcL6M1SXri1rJO+pc2BqrqzVArVycbQv37asIKcVLICqsNEhgOL3F
         Bosi9AHGW5JYIEtgWikXPoInJaBIwgA6A/MeC7ROJvS8f2XmW/mXoYuIZ8LJ74DXgruD
         zMAJa6+nmnbm2ONXuVez/eEDtF5R9i7yXmkT+uDm3JG21wLDszKYGTUnRnf08oQ/c2U3
         gTAcv0qr2eY+ki4V4rDnDZdlsJpKcrNKST9yCsjBLhMinPk/sFuoEsNuYmQeGJ8gV/p5
         /kXGge4s5gIAnbQmDGKcHwDyl79QvtWgTuAaDzQHgvLIZtSTKPkUKb914h3zsV0hvGKU
         prKA==
X-Gm-Message-State: AOJu0YxBAvS9p0+fVDG06eXW54xWujJV49LHaAoqh5bI+f5n0jZTocsP
	1g90Fl4ghBoymfMzJkBLmCylbQkiTCgpgJFh/gmI5FdNgyd/B7na/kBEI3NaDjzh1dFBi8ikQlk
	p
X-Google-Smtp-Source: AGHT+IEB6tSTC88cFLkzJ9d6mSRqGxlP9n5mLzn9waFCREVYcH5CUGhqgOe4O8h5QEoJFTjIZv9g8A==
X-Received: by 2002:a17:907:c50a:b0:a7a:bae8:f299 with SMTP id a640c23a62f3a-a7d40166eb1mr680307766b.51.1722335172243;
        Tue, 30 Jul 2024 03:26:12 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad92cd7sm633135766b.179.2024.07.30.03.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:26:11 -0700 (PDT)
Date: Tue, 30 Jul 2024 12:26:09 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v2 5/8] pwm: Add support for pwmchip devices for faster
 and easier userspace access
Message-ID: <impohkxfro2udihqhckracjhzo66ft66c3o4vgnje3phtauf5b@4mvr74dupo2h>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
 <7e50f9901d63c3aa27cdd02194f95b0ed79765f6.1721040875.git.u.kleine-koenig@baylibre.com>
 <80dbe964-6e83-4085-b56c-609babac2ee5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vuy6x4tmn4rvipnm"
Content-Disposition: inline
In-Reply-To: <80dbe964-6e83-4085-b56c-609babac2ee5@baylibre.com>


--vuy6x4tmn4rvipnm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 02:37:57PM -0500, David Lechner wrote:
> On 7/15/24 6:16 AM, Uwe Kleine-K=F6nig wrote:
>=20
> > +#define PWM_IOCTL_GET_NUM_PWMS	_IO(0x75, 0)
>=20
> What is the use case for PWM_IOCTL_GET_NUM_PWMS? This info is already ava=
ilable
> from sysfs, and it doesn't seem like there would be any performance consi=
deration
> for using an ioctl to get the same info.

Thinking about that (and sending out a v3 that didn't change anything
here), I think it would be sensible to drop this. Maybe in favour of an
ioctl that gets the chip id. This way a consumer could find the
respective device directory below /sys/class/pwm without parsing the
chip id from the filename (assuming a sane udev configuration).

Would that make sense to you, too?

Best regards
Uwe

--vuy6x4tmn4rvipnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaov78ACgkQj4D7WH0S
/k6jEwf/QkLdakkRhT2dSYQiEC4vvn9YsLEdzftR0nUq7fo3Dkl7w4dneq8oJueE
QvEcLmcdmrXPKJIaqu9nIb1WSGKKkiiIm8Zh4aFqO60WpeIU2IJ/upRkQPTesQ2x
0qF+nuM42W1ZsBhH4wTaSC8iBrzm/YzAT6czxwK/lkUDWiNinFH1bGtYQv2c9uS4
1refoOiqJZR5HHQfeaPK/0SVV4WQdyh52J3yDdRp8oYqB9gBPDImIf/DFCwCaq2n
AXi4pGhP79As4Vc+L/qvsX8tp+Sxpb6JTHXHN7ff7RZYoy7JuGIQQO80S8CeJ4s6
8raI8Pw9LEpomfm2tpH29qQmKM0QhQ==
=Yg/C
-----END PGP SIGNATURE-----

--vuy6x4tmn4rvipnm--

