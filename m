Return-Path: <linux-pwm+bounces-3151-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B82297084F
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Sep 2024 16:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2E91C20881
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Sep 2024 14:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1326116D332;
	Sun,  8 Sep 2024 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Gyfu0SDM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D9156243
	for <linux-pwm@vger.kernel.org>; Sun,  8 Sep 2024 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725807586; cv=none; b=nOEPGvPfcBVnBiIrPyoKf8ogNhUivSHbq0VAyjEkcu58jniBluXmaZuRupl8TFsaajtFDJ02mZvLzdrSFF37Ghaj7IJG0zrDSevOpgMohz/8DWm8woMcnIOZ3vi6H2mohFOUIFjEXZpHLvhfqaGK3du5XPnugXSGZdsgg4OX+SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725807586; c=relaxed/simple;
	bh=5EYRa4wxLim2nTIv2ttBKyxla4itO+B3ApUaBXi7Lyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fP5JKXxZiFjyembXTRikyal9/ymtFHQs6OMdsh4LRp9Roy/shlmKYr506GTPZVZXbqhsSS2qfX1BYYS0NRG8H5EEW4nGk9oiEP/Ey1ka+DVXED+sd0cdltQKPTDstPKpn40kaxn2GsXjT8cVuzBOFNgtSr4MK6BZebA2bC0uQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Gyfu0SDM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8a7903cb7dso157652566b.3
        for <linux-pwm@vger.kernel.org>; Sun, 08 Sep 2024 07:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725807580; x=1726412380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdjZuwklg3W2mfIeBzz/NQICPspSzY1LH3dp75KuGqg=;
        b=Gyfu0SDMXcZsOrd97bdORWB/9d34Itp95zGBNNQadYyILPJNQnmTl9vHrA/IfUStzm
         sN9cE/ydvupDnXpiL9crYWqY1ZundXCl9OY/Mbe+r/t8qTUTZA5Ej/YhlbmIoxRkSGzj
         6osdlTysS+5WBFdNA3g+0UNBJp7XCiXv4ALAy1Fi2bW1UdCgmhYF58sSDTEtwRCUlXCk
         fgBrZTy2s3I1Uk+4R00cwIbJ1fOqLX4pTolMmiqxFXofYc/tMhsLnVzT6q95Il4JxSC5
         28pZvOkobIC+kFD8/Dmk2HEWkVNtdBUMkzGzhcHLlV12cWXNMrW8KEKA5GUpXU3PWBNK
         QB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725807580; x=1726412380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdjZuwklg3W2mfIeBzz/NQICPspSzY1LH3dp75KuGqg=;
        b=GubotmsVKt6Xrb8VtVmro5iGiAEmSZ7wz3uUCHZesWYVdka+RxTpdQ7kwSPaI55jkA
         O7TqGxBG7Fph8xdsNvsg1mkJ5zHPg+++SrMZ4z8r3rWAqgd4+sD7SGS3aNIxR9nAYMgc
         r3hp1EIPOvxMds8oIn1Bu7JYuZVfZ+ifQI2aO7j/RmawGvtXYAoK4YMEfouJpjLA6BhB
         dmtKbc+oJ2Es2zPTegMj1GOdNo4N26pRs7vbn5Vtz4JDqvS0u0tKmYmZjOmnlhd+Exlw
         WsHd7JITuMSsx9/eJep3onTT3tN3uk8m3MnWoxUw5p6w98mCR2QW95Hn3eo82npfrmxF
         Hpvw==
X-Gm-Message-State: AOJu0YxE2S7ZmftcT3xAAF1Nb+uRz2BdllzfmZy1Oku8lNoLIf9cTXGx
	hIi2m8Hlu0QVSG63RwSaKU6QZiFazPQuGXIwBpQrOycBgWO7vsofQAWifICBsBY=
X-Google-Smtp-Source: AGHT+IEU8t8wlA8Zfbu8SnCigT3UoH2UzqMyk7MFMohGp65QdPhHUM98O7lmKgXggA5inVNesFkz3w==
X-Received: by 2002:a05:6402:2807:b0:5c3:cb45:2e with SMTP id 4fb4d7f45d1cf-5c3dc77b0b3mr7996209a12.5.1725807580038;
        Sun, 08 Sep 2024 07:59:40 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:3473:41ca:c39b:2ff3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd4679csm1935036a12.32.2024.09.08.07.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 07:59:39 -0700 (PDT)
Date: Sun, 8 Sep 2024 16:59:35 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Kent Gibson <warthog618@gmail.com>
Subject: Re: [PATCH v4 4/7] pwm: Add support for pwmchip devices for faster
 and easier userspace access
Message-ID: <5qrct3wt2e544vfoxaaacdifxcc7k243hnlrs7rki5nkbki4os@vfss2f2g4hvu>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
 <00c9f1181dc351e1e6041ba6e41e4c30b12b6a27.1725635013.git.u.kleine-koenig@baylibre.com>
 <7acc85f6-69e9-4e44-ab04-88eaf2ffa291@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lydg36clmni7ufgj"
Content-Disposition: inline
In-Reply-To: <7acc85f6-69e9-4e44-ab04-88eaf2ffa291@baylibre.com>


--lydg36clmni7ufgj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Fri, Sep 06, 2024 at 05:26:46PM -0500, David Lechner wrote:
> Maybe a potential problem here with multiple requests.
>=20
> Suppose an applications does:
>=20
> // main thread
> fd =3D open("/dev/pwm0", ...);
>=20
> // start some threads
>=20
> // thread A
>=20
> ioctl(fd, PWM_IOCTL_REQUEST, 0);
> // in kernel, pwm_device_request() is called and
> // cdata->pwm[0] is assigned
>=20
> // does some stuff - OK
>=20
> 	// thread B
>=20
> 	ioctl(fd, PWM_IOCTL_REQUEST, 0);
> 	// succeeds since cdata->pwm[0] is assigned
>=20
> 	// does some stuff - messes up thread A
>=20
> // does some stuff - messes up thread B

If two threads share a single fd for a given pwmchip char device, it's
in the responsibility of the application to not shoot in its own foot.
There are similar problems if two threads write to the same fd
corresponding to an ordinary file or directory. I think behaving
differently here isn't a good idea.
=20
> 	// cleans up after itself
> 	ioctl(fd, PWM_IOCTL_FREE, 0);
> 	// pwm_put() is called and
> 	// cdata->pwm[0] is set to NULL
> =09
> // does some stuff - kernel has to call pwm_device_request()
> // again, which may fail? e.g. if sysfs stole it in the meantime
>=20
> // cleans up after itself
> ioctl(fd, PWM_IOCTL_FREE, 0);
>=20
> Maybe we should be more strict and only allow one requester at a time?

=46rom the POV of the kernel code, there is only one requestor, identified
by the opened file. Handling that in a different way isn't a good idea I
think.

> Or maybe we just don't need the REQUEST and FREE ioctls?

The idea of the REQUEST ioctl is that an application can make sure it
can access all PWMs it needs before starting to change the
configuration.

> > +			if (cwf.__pad !=3D 0) {
> > +				pr_warn("huh\n");
>=20
> This is what I will say when I see this in the kernel log. :-p

So the message seems to be chosen correctly :-)

Of course will drop that, thanks for finding that.

Best regards
Uwe

--lydg36clmni7ufgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbdu9UACgkQj4D7WH0S
/k5mfAgAiX9FkqBGzcctBlRKpaPyeVUHhQfEfVuoCiaCaGVobKr2DEzt659Ue81R
2+p0fbkcG9/i2EE2T5eVj0l5Rzq46drkMkX8XmTWsKkyWg8BoiDxWv2Z71Du5glh
PXTo4swd2qjjyHz1+Ehr8n/mYd1ODgwGZto0YJmk52b1mZEW7dY6+VAYcwhefypt
kuGyUuixEtfX3zRfmSmwCP6aNbYatrGkN2RZUEL7stAMolh53vme9KFLFXg2xDor
pH4UK+gwN7Xy18o8TG2rxT0gJyZNAuXoj3MM5DraOP5oHuzsmQ99ewM6OVc8RXhj
hOjgUNePo6pBnGd2BcDeS7FsWQCj/w==
=l+1l
-----END PGP SIGNATURE-----

--lydg36clmni7ufgj--

