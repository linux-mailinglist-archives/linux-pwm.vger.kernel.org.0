Return-Path: <linux-pwm+bounces-5998-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE99AB83AF
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 12:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A1A3AB7C9
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 10:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A952320CCE4;
	Thu, 15 May 2025 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DZpJ006A"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6941AAE13
	for <linux-pwm@vger.kernel.org>; Thu, 15 May 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747304513; cv=none; b=O/rLX32usKLQtsfeNSjvgO0PVxSWRgcBO44Iax5fwFgnfTNShCKTpjyW/Hz4NhyeADtIPPPOaSj4tEcLjFwW21cxmb2+B5pyqPO+cYnXDiq/4xxX4ytKArTm17bVzLZLWlWYBooI+NE7RgDYSyB7PKT9eeBljcqdDAcXCbqkIR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747304513; c=relaxed/simple;
	bh=bV6M6sJSIQWEF64EibOYqxanrwW8fbar0AUm++ui+qQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KwPHP5WioXXRMVfqPxDYR0YrmJipZcumxBsd5q5rojw2cFm7mgjlu6D1HOCMl6Mk57+cVSWYT5ZCO+GNaKnBkUl3d6T1yMEqBpG4HENBg0mLNHiCqI6xTGWEkxUFFO2O8UVfoyhNO9ldiRg3N69davdVkSrUfo1bJmEpe1dBGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DZpJ006A; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a0b933f214so458898f8f.0
        for <linux-pwm@vger.kernel.org>; Thu, 15 May 2025 03:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747304508; x=1747909308; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qqvI5/m2v3NyavdcL6vD6HNxrSJKAAsLr4G5Ti5Lg1k=;
        b=DZpJ006A9XnCDsIEujqAihbGiUcNSUXO0s20pLkDKQK3zwJeDIWhs1mJH22kiC1uYq
         fBSsBPqwnw9b/rTG6o4B0/oAKi1W/hhLTqzS3D1HIBsW3Fhxe42LNN1FzbUIk5jB5d1u
         K0SJy1nCL1l8Yb6nm85eKSs61RTEWo4iqoFbsBzOqt0VPB2Vzasa3A1Cgkhz8vntuLX9
         YvlaaRcd15TAU38o4L+yOaONyVQ4uHeYGjsduT1287aWFBrqks4Ow/VquIc3nDAeDVXz
         mYYuwj++RQKKHIV4h01Q+jARCBdWbK7gNfY5goTdq0NFtkFvVxBOgw38U0WlEuPexDBn
         GrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747304508; x=1747909308;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqvI5/m2v3NyavdcL6vD6HNxrSJKAAsLr4G5Ti5Lg1k=;
        b=GOFX9k5LtyO+T0OPJOSaHmuXyODBW4I0NjA+5bTg8fZbV6KOOkGpw1eoVR8DoOiUiM
         kPierUE9/j91WAXMiDnmXTP+8YCR3dQBhYxD3cJYEncuqtAbFHDby2kOXBk04uPOlWeo
         CpRiVxiBL5eqNXIplBEonk+yBE/eD0VDD5sFGkpkDitmRAP4n6fvuoVVs1m/Ioki9Ac0
         zMkpgBHm7GqxPjO2P0JB3FG0F+jDoy35cm3eoxpk9QpM2dp94dvUl3M+geaCUKXpBfFo
         DGkUJ0pIKw5BIvaZJpAVLqqte24OQTKIu4XRSvYUsm+D6y3eKOdun07kuFngPYw8rF45
         L66Q==
X-Gm-Message-State: AOJu0YyysjDS2n5i01wJGxTFdk+XWTGqUg4XN60C5DpN2/3Igs1YDizw
	/Nnda2WEvUBKL59a1L9pzpXbJlXQeN7gm5+E2g+3/TgF4VZ5QJcpK6qQGOnamYNkSabT1SvevCw
	r
X-Gm-Gg: ASbGnct3r36RgekJ0yAl3pNJSWlBVwZwVxHWdLDw/KpaKX+TiP7qCwBORkXxtVA2Q/2
	QyWkE0PdaUuHr/X+yeVjhDBvKojyRp0e5q+FZ4jsW/JFj5f7mpC5ZrsK/CYjpAZcZGmeWvZACfF
	LqQ/Np+GbDuUVw7sabTS0msldfQt82Usk58MhNhr8VdmYoNmNBd7CHLMiCg7w4KGUEhRkBKTzgd
	C66laz4KJLCluDJKTdrSV4uL55rAtA5RUKNOryiNB2be1KEP8hUeSFNPb+hVPyAJAzqItBjOlnt
	vveySrRo9hfnCdpnSJeca1r761ZanNebXWJ51RpCah8RbEGEOrJI8M9bYC0p5qH9djQ5yezMpca
	R7mRDw6w0NEio4/RySA==
X-Google-Smtp-Source: AGHT+IFaSjCtUnW6I+Yha59MDmlrs35LAjgtPcor70e1Lt0Rhk2bVAM28JK2+BddH77SSxuVIcdPCg==
X-Received: by 2002:a05:6000:2408:b0:39c:30f9:339c with SMTP id ffacd0b85a97d-3a3496c1fa7mr5664026f8f.28.1747304507662;
        Thu, 15 May 2025 03:21:47 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a1f5a4c5f6sm22153062f8f.86.2025.05.15.03.21.46
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 03:21:47 -0700 (PDT)
Date: Thu, 15 May 2025 12:21:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: libpwm 1.0-rc1
Message-ID: <ifd4m654m4ephqdwsxcu32a7igcfz3d36ex5btwghqa2muiahl@mpqkd4coyfcg>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="74ro3ayvtr66ikkv"
Content-Disposition: inline


--74ro3ayvtr66ikkv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: libpwm 1.0-rc1
MIME-Version: 1.0

Hello,

now that the kernel side parts for the pwm character devices are
considered done and the API set in stone, I tagged libpwm that
implements the userspace parts of it as 1.0-rc1.

Find it at

	https://mirrors.edge.kernel.org/pub/linux/kernel/people/ukleinek/libpwm/

or

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git/tag/?h=v1.0-rc1

(both signed by my PGP key).

The tools included there are nice to test PWM driver implementations and
I recommend it to everyone who is working on PWM drivers.

The pwm character device support in libpwm depends on headers that are
currently only provided by the kernel, so you need kernel headers
installed that include this support when compiling libpwm with chardev
support. I intend to make this a bit smoother for the 1.0
release.

Happy to get feedback, preferably in the form of patches here on the
list :-)

Best regards
Uwe

--74ro3ayvtr66ikkv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmglwDYACgkQj4D7WH0S
/k7DsAgArFgchgeW16d/ZmjeJqcj448s811L/TxvH/q3X67/XsQNQNMrrW1SSpRv
Fb9Piwt+QUlxALOTgmTEvv+o2aTuGGo2nEh2WY/5VCCGQ9pwAfEerq8R4PESel0Y
UiBgBuZ8t3WAtlZtTryyAlD9ARONt91ADyLAqm2txwxKpER/0c3YzxF5lAjyXaXW
FRj+xP58IrI7o88psockr19qptgy+BhSn4YiH6dCmq9tEdp6/+4WwUp6OvxaGit3
RsHXcG95apvCfTsnXur3F+9td1LmJ7OtUpgDMKkIP3iZSphS2HoXuzSftf5FDaSn
0fbfcE6CDtNT0TDZ1CKQMoBWpcaNkg==
=2be1
-----END PGP SIGNATURE-----

--74ro3ayvtr66ikkv--

