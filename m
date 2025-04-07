Return-Path: <linux-pwm+bounces-5362-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCB2A7E0B6
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 16:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B2217BEEB
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69E41C549E;
	Mon,  7 Apr 2025 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dClFUax8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EFC1C3029
	for <linux-pwm@vger.kernel.org>; Mon,  7 Apr 2025 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034831; cv=none; b=RCA6XMDUzgO5vWBYoLS5D5U0esS63hPhG/RWQj0PQPjUkFhndgSe6LF3KYpJjmuFBRy1szspSduDvQ67gGSh/1xPfpELDmQ9hgzIsVX5IykTxFDlWxELA8RH+m7QyJXyKeqP8MkSGzYxyYFnLuRQkBkWOR/gGGR7wE+E69kxps8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034831; c=relaxed/simple;
	bh=0pmKU1ufcWHSpZgVl0WwyNzntRiaBAhPSxmth2f4WA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzDKoynk+TDMCDXpP+arnR57nSaQ6/DE/tJXVJTvbvsLJ11p6TD3pxHfhbOQwM9jyjnPx7Qeb2CUqHi3n55KZsmD7I71FgiGVZBKUGObpW1pjPz7hMJjToF5N2w0IpV8W1hptKx4bASdXMOHKTjFVOUNcU3uOQGbwvWJK8xO/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dClFUax8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac297cbe017so1024874166b.0
        for <linux-pwm@vger.kernel.org>; Mon, 07 Apr 2025 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744034827; x=1744639627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0pmKU1ufcWHSpZgVl0WwyNzntRiaBAhPSxmth2f4WA8=;
        b=dClFUax8fAexwOjYNt1ARzEego6JhLwISRMF6pkP3yAtuTAZaWl2OYlEFyFMghdjj8
         KU1b6Dy10u3aWn0o1mA8ruqRDD5zqtG0nAA+PkPY+5/bIOnE2yyOU9XLI+swv6cU8oJB
         FdXxzUqa9uUHW9seP9tnP7swXHrZI+f5pUnQqs45po9il2Hq/bdl3m0ccT9gRP7O9KyL
         1kaofX26RG5BnOXyNXWQCTjXLJno85AAB9ZGv5VzKqMSH+TJJL3aLfl/iw/g4VMoNi+9
         X80hA+1m1+AaUj7369plxJVYTMKePolVIdycrsqptpgPNQsC+EFMCnLAZ1w/R5lEzaUg
         QpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744034827; x=1744639627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pmKU1ufcWHSpZgVl0WwyNzntRiaBAhPSxmth2f4WA8=;
        b=amd/4Y8/HxhBwxtJbXOz2CPiCvs84JTdHFhVMvvTyQeVvEMLaW226bVNjrpSe55Ygm
         Xka+5qAKzrqfub3ds1OGcSnl7x08W4YUos+H0zlmeittMqAwFKhYRgF/41siaRZ6AIyl
         Hz9iEYjr23q8+DjWFix6a5JjpQPkVAh5ityC0GYVmVmmE9MRsvHN6DRMULJYUoCNQxPZ
         0Mokj6MoQVHIAINOmDUBrhgdQNxfJ/nHEWwdSErClYg9oF2VngfLfGRyXYlqlo5V0ZoG
         j9cnhbbe+i149wOxLVt3+SQgtk+M/EpVIvvExJJVeKkhOfSUJwTxqRuGUWReAie3XA5i
         ZSjA==
X-Gm-Message-State: AOJu0YyjiJyhWixHDuClhWVPCwQq5HyZbrcI5FARvHS08umGnSF43OsX
	y4pj1BR3GrwcFzymov6SKA8yKQZh0lo8xsuW/bhihB0V760KTzGIm5DdARyUYNIL+4JSmH1heZv
	y
X-Gm-Gg: ASbGncuTHPVyXUI+FD3N4HIrBn6ZidB9EjVfNzs/Dej4p7Q8kL0aGA0g1pg1vR4kIEm
	9pt70lCxYW2XM/nwKuGLqpXdbLZoCmjlZaYoxz1eSN2VSzJ6UdBMSaX5iObjG4/HrH4T/Bccrgh
	ype/vF5xwzave+lvTXS/6rKW3RxAnpafnW+hYYycfnHXd1TZAs0ZQUyy+if4K+CIMaixvu40fAp
	IEeGvZnZvSGYjDUtYWB1pvH0ePwYSBruRTscaII4CZJIW1uMgXCfEcQsJ8+KG35HZr52/ROGIb6
	x0ZSxMkq+bwjL1wXpP4k0kLAU16dUGZ4ijLctmOt/8z6KO6jkQ==
X-Google-Smtp-Source: AGHT+IFPUVv9QiEbVDmXmJBFtqH3U5shxgUAf0O5X9+3CDJBmaL6N6yHbXDFoTL99mQgxRPzIafbnw==
X-Received: by 2002:a17:907:6e8e:b0:ac2:d5d3:2b77 with SMTP id a640c23a62f3a-ac7d2e1b9c5mr1218030166b.8.1744034826838;
        Mon, 07 Apr 2025 07:07:06 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac7c01c10dcsm748300266b.180.2025.04.07.07.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 07:07:06 -0700 (PDT)
Date: Mon, 7 Apr 2025 16:07:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH] pwm: Add actual hardware state to pwm debugfs file
Message-ID: <edgqgl7joxx7r2qqilgj2nbjud32sgey2pujmuwgm6il3flvcp@dhrhsgfgt5ud>
References: <20250404104844.543479-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zravorrra7aifjpx"
Content-Disposition: inline
In-Reply-To: <20250404104844.543479-2-u.kleine-koenig@baylibre.com>


--zravorrra7aifjpx
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Add actual hardware state to pwm debugfs file
MIME-Version: 1.0

Hello,

On Fri, Apr 04, 2025 at 12:48:42PM +0200, Uwe Kleine-K=F6nig wrote:
> Traditionally /sys/kernel/debug/pwm only contained info from pwm->state.
> Most of the time this data represents the last requested setting which
> might differ considerably from the actually configured in hardware
> setting.
>=20
> Expand the information in the debugfs file with the actual values.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied with Trevor's tag to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Best regards
Uwe

--zravorrra7aifjpx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfz3AYACgkQj4D7WH0S
/k4Sggf/TUgPYS4yV8C9LG5idHzNuGtsfo1/LHFSgWja+/5w9O8zcYJfPfxlC21l
TWUFhDZZOB8hmingtcPB06MoAU9tfHFAkemCrE8X2evT6OyO6w+yXcsGrW2UY6Md
moVBOwnyNLZ//UCrhWvZa6BLvqC5Rzlu6mNhqB834Zrccpw/70IK1BgTdIUIFuFl
smXaUhGHh9x71MvzgPPF0HPfrkIh0QKHiHh3fqrnaM0jKGmMtpEdNXv66fcWKOl0
2qqN7dJO9xkUaSkvBwG5iMNn+XchxhYDtfe9WCudabdgthScZ0RfNtuzO8mOwpUK
C580WaYvpi7ERV4IoSdtUcpStYvCLw==
=cQLO
-----END PGP SIGNATURE-----

--zravorrra7aifjpx--

