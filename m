Return-Path: <linux-pwm+bounces-3284-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2661C97B27C
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Sep 2024 18:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592D11C20C72
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Sep 2024 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21877535DC;
	Tue, 17 Sep 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="owXtdADW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6914D71E
	for <linux-pwm@vger.kernel.org>; Tue, 17 Sep 2024 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726588892; cv=none; b=U6ZsgQCQyPKxeSDT05Pt3NzkcGJ4Tq7WDjoNjaKndywdw3Guoh5fdurWjJx98cpFbKSZyJVcrG3Jk6D6eMPxr7iePWkiI/wMUb4PhcU+6lTd3+a316Tr6ECBs2licfcKdEBFKofcbMP0wPwS1Qm5ZIvkArrqH7w8fzFwi1bkRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726588892; c=relaxed/simple;
	bh=hdXqSCdNxoPoX+DywFZn352mfbmIqc9RPWZo8eDvWjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4/eBGvHdYjRu545EffPF4gLnvjhoYoJrOu1XcOnFrq4g3CLJjRJulxvFsePoNnldaOH7KrSZWJPdCnW2w9SmWQocB/hfrZ2e/NAQIpHK9S6xRao4GnIMhugzw+Hdkjgm15RWLynL3yeo3C9667iwKwKP1Yn2qS4i42fCspbq+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=owXtdADW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c26a52cf82so2478152a12.2
        for <linux-pwm@vger.kernel.org>; Tue, 17 Sep 2024 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726588887; x=1727193687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uuEYPgrDf2j8L7z5gATu0mjFEDNmwvkpCaFkTninaAo=;
        b=owXtdADWZ36g9t8OqRZ1SOrPp65AlogkCv/yeFPV4H8GyUREBd9u5UJQd1tbwwG4bE
         WRB8o8kisj2yNSqwxSLF+ZToUS94ckygpRHctSU2EoTtfilONaYo05tcpSlUOQZyn5Iz
         qJM6aqsusj9x+n29ZDxTzLYrWdb+vxt0mErhxOvBYkl8+c0EOodttGNZEubzTWPryJpq
         ZfTHEf3XQ/8Uvdo0KaGG9u1N++AhHJUQk7lxqujV4gcuvpJskk8hyCsM4peGP23hLDnH
         GHCyqTDJk7+8Y8Al6l1tbj4USObasXCDOEn1hTnfHV1fRSVeacXui8ke2XEaMXBMk7Qw
         iJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726588887; x=1727193687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuEYPgrDf2j8L7z5gATu0mjFEDNmwvkpCaFkTninaAo=;
        b=wTCgifVBBoNtQXxCkABtOLOY3Ei1Y1f6O7NSvKvJ4QCIztUdqc8B07oL1ggUgGHZ1g
         bhuZduD9HEDmXZxxHsXUpOcXsCQddueAbtYm3F3VwuD5bAFcSlEsp06U5mK1vjYgZ0Hy
         978DwTBx73ai2wjX/rWYDOfNusochMzUnp1RqCj04CeeGYiqvx6qVHKDO2a+P8Ty3vOC
         6LiMQw56+abN7cWMm/gyuci4AUui5dMobTcSSGoDO++PimOMXkGeSFcoMT4ExY2XUAFX
         IuNqOeNbCeiCWLw2vqGjX0N95Mj4ko1MbVHjUm5AOBmxsBsHkbj1YK4sSj6fmYZiSQ1X
         Eo9A==
X-Gm-Message-State: AOJu0YxTh1PWPShRfP8yjRnyXh40LG0kw43l2gAA18CNdlVTYP4qwme8
	UI44Tr+1v/rvbLtayac1sizoqGkgSbksoJq7Cyxmu30NgylS+xMY6aqXo4iZPUjiXeVhR4dL4v5
	o
X-Google-Smtp-Source: AGHT+IFehvn6undS7AZ9St3IRyGjc+hflZg1jw9rxPGAn/1MUFeHmMFU7CftvCBvwlIjBwLnXC9Znw==
X-Received: by 2002:a05:6402:5d3:b0:5c3:c530:e99a with SMTP id 4fb4d7f45d1cf-5c41e1930c7mr25040964a12.15.1726588885865;
        Tue, 17 Sep 2024 09:01:25 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5dc0dsm3814193a12.42.2024.09.17.09.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 09:01:25 -0700 (PDT)
Date: Tue, 17 Sep 2024 18:01:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Kent Gibson <warthog618@gmail.com>
Subject: Re: [PATCH v4 1/7] pwm: Add more locking
Message-ID: <7cop5lj6v4aaobdarwdewelhjkd5asy4b3yk7vtxfwuppo5apz@zoafbb26aysp>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
 <a519af534a6670fdb0c3ee9c2aa80106c35ff489.1725635013.git.u.kleine-koenig@baylibre.com>
 <561434b8-c13d-48a0-86ea-026f83dfc98f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="63ajnbzfcbs22blx"
Content-Disposition: inline
In-Reply-To: <561434b8-c13d-48a0-86ea-026f83dfc98f@baylibre.com>


--63ajnbzfcbs22blx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Fri, Sep 06, 2024 at 02:54:29PM -0500, David Lechner wrote:
> On 9/6/24 10:42 AM, Uwe Kleine-K=F6nig wrote:
> > @@ -336,6 +367,11 @@ static int pwm_capture(struct pwm_device *pwm, str=
uct pwm_capture *result,
> > =20
> >  	guard(mutex)(&pwm_lock);
>=20
> Do we still need to hold pwm_lock here? Maybe we can remove it?
> Or add a comment about why it is still necessary even though we
> also hold pwmchip lock.

Probably we don't. And even if it were required from a theoretic POV,
it's most probably still not needed because nobody actually uses
pwm_capture(). So I suggest to add a comment like:

/*
 * Holding the pwm_lock is probably not needed. If you use pwm_capture()
 * and you're interested to speed it up, please convince yourself it's
 * really not needed, test and then suggest a patch on the mailing list.
 */

Until someone speaks up and tells that pwm_capture is still useful, I'm
happy if I don't have to spend brain cycles about it.

I also still consider
https://lore.kernel.org/linux-pwm/20220523174502.987113-3-u.kleine-koenig@p=
engutronix.de
a good idea to make it more likely that someone who still uses capture
support shows up on the list.

> > +	guard(pwmchip)(chip);
> > +
> > +	if (!chip->operational)
> > +		return -ENODEV;
> > +
> >  	return ops->capture(chip, pwm, result, timeout);
> >  }

Best regards
Uwe

--63ajnbzfcbs22blx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbpp9AACgkQj4D7WH0S
/k7VsAf/Zboj5dWwVxL8thgWLZ4v8yT/RDnioHnHdQzY2P/Mn76x6A67Nu42NSbL
AkK/XzvWyExP1BbHQLq1tZyVtdzUCq3SquoHCJgQ+cSJnKpG+FsQ3FqX7KIbWLkU
V1ejVEQbzkJxDVQtfwbUwPE4AEkep7jd1vAZ4KHj7hZ3HT7ijkf0OxOuwpienPIX
9W2NuHU0dQnUM5jH787bNLflqP35Aww8Uu4NqMQ8mBu4mcqVxr5gysUW64VvRAY8
cHupDJ94UT301mh6Xz8iY6kmP0QSPVSOt047/TnRiXAc4m5CJVCBMb9gYpgdfyfo
Gku7X2+iKzK+d2NiiPs9UrIK7xC1Gw==
=Q1Zq
-----END PGP SIGNATURE-----

--63ajnbzfcbs22blx--

