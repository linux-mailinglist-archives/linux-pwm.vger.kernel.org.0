Return-Path: <linux-pwm+bounces-3106-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EC396DF2B
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 18:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F8E28314C
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A8E19F49D;
	Thu,  5 Sep 2024 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VsAVtQ4l"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0961A00D7
	for <linux-pwm@vger.kernel.org>; Thu,  5 Sep 2024 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552480; cv=none; b=uqFdLFzvSvnnnzQVST5GUyqFzO/drzaN66t6j+7yQbYYHFT/doaF/XfhRZSmO9gcI+lkJnhe214eqhIA14ZU9LUnughR7yLl59jnZ/jrGZaHOiMjpG3SUQL9fo5q+epOXx84RWwxX6XMSl2zxPyCkQgPCep2mFsva3qffNWAA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552480; c=relaxed/simple;
	bh=4+V/2/69Oekf/IqJLJkJMCGq+BYCH2b4UrGiPsgeqgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHZ5vWpRGqGg6ezgnOim4g8kbroDu5WjRyWgXpXZzK7XpR7gwfAeZO82dUKoqjpgYIzA5w46aqfosLEWDpDG4tRls8UCdozJCdo1mAUY+tyRd38aY1rIC06u1o7NUWY/xljGBIzUw7loa38+huWjto9HMUkv+LwUSK66TtmCh/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VsAVtQ4l; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c3cdbe4728so1027090a12.2
        for <linux-pwm@vger.kernel.org>; Thu, 05 Sep 2024 09:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725552477; x=1726157277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+V/2/69Oekf/IqJLJkJMCGq+BYCH2b4UrGiPsgeqgg=;
        b=VsAVtQ4lG1heGJ7DNLeQqrhr8BylAXrgUmMH5O/tjvPkSkh6yUYPpLgzCbhDsb8w1J
         iJFR9gr50BS4ZChqo4pud89I4uDz5RlWEMKlYqxDPAbNI8mO9o1Xj8njU/SCjyX8Mw7J
         yWFdEnZuOdt+OoK2NWwWEd8ap4bZlRJi4ZxHoZNLIR1tzszQt7hlp4ZgiLe0bVylcLsW
         YZFRH2KaefnWYSBA4zjmT96mFDzzjU1o4VIe7v5UeLkxsn2g4oNNBCL8EXwL/rtRYE57
         8p0sZUOxoUhS6ZXZUx6pUrrXCv+1sJnpGYVQy1XtvJL8H3eqw4R4s6hP/zzWhV7opwEh
         nv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725552477; x=1726157277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+V/2/69Oekf/IqJLJkJMCGq+BYCH2b4UrGiPsgeqgg=;
        b=EOB9f4VlCG266meCEykDYKd0eNOzu6CzUBSN0vwaQ3Jj3Z3/8iY8jXaBez7J8pcoWA
         9iiI1kF6aD6Fmq7bP5TkhtvYS/Pj0AGCSnssk8SLSdXMkGtuRP0PFB6CvkLS0XygfSCq
         ZQg7Go6F8Bal0km/GteGiO0f4/mhWuIzMZnJRhQ87Zi8jWtm8pmyVcrjH1Vw5u06bedS
         2ebkbrXjvow3/+/p8/GVxR0UM8H+d0gYCJ7dTGOAw5SegMehbkeq94xtbSxabqJLK39h
         dvARDkMZbjPeOCKeXZWzyBByKbeyFTy+IZX7W3CAS0eu7rt7xaLcdDKtTrQ1pp7TFHYw
         RvDg==
X-Forwarded-Encrypted: i=1; AJvYcCWeSWtUkcqs0KsfezRUUQUr9poUSy2TkREkEeAzZC49+8Nj2QSzNZyPYJkoGf3CPfjG6WhWp/MhOG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlxvyOIwoIbSMtfb9v6ycH3AAyD3Oo4MaLCitGYry6u/i23gjb
	5DwSEl6wtNLWa4wd7xtXSB++WpdpP7VkNoQcdH+fsPtDJKjh3s/3/+n6NUaAmvyQWScRASmD/fS
	I
X-Google-Smtp-Source: AGHT+IH+yeZQhRsD9G65BjoujdjesMoaUAknZULkhtESsyPwnLRQdSEaHjaNYNJRShPfhk7+5tEtsw==
X-Received: by 2002:a50:c943:0:b0:5c0:b793:df4e with SMTP id 4fb4d7f45d1cf-5c21ed52c88mr16699830a12.22.1725552476740;
        Thu, 05 Sep 2024 09:07:56 -0700 (PDT)
Received: from localhost (p200300f65f01db004d6a46a6454a1385.dip0.t-ipconnect.de. [2003:f6:5f01:db00:4d6a:46a6:454a:1385])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc528bcfsm1405056a12.16.2024.09.05.09.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:07:56 -0700 (PDT)
Date: Thu, 5 Sep 2024 18:07:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: axi-pwmgen: use shared macro for version reg
Message-ID: <hurwsgglzhipxkehkefopiw7ujfbnowbprkqdc3hyxlwp3qhud@a22jwhzfp6z5>
References: <20240816-pwm-axi-pwmgen-use-shared-macro-v1-1-994153ebc3a7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r5kiyyqgcuiwe4rb"
Content-Disposition: inline
In-Reply-To: <20240816-pwm-axi-pwmgen-use-shared-macro-v1-1-994153ebc3a7@baylibre.com>


--r5kiyyqgcuiwe4rb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Fri, Aug 16, 2024 at 12:30:58PM -0500, David Lechner wrote:
> The linux/fpga/adi-axi-common.h header already defines a macro for the
> version register offset. Use this macro in the axi-pwmgen driver instead
> of defining it again.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Thanks
Uwe

--r5kiyyqgcuiwe4rb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbZ11cACgkQj4D7WH0S
/k67fwgAkaC5Tr+QQb7cGPfyg4WK05i1LzaFUD73feUn7jpHQluPp89YLYqj6xzl
U9Nfw9F9JLrqPEKdDYJPuUfAYg8EncbRar8FclUAWt1zYtoEe7lw7Fh+dfl7qnFk
u7FjIuUiPtkvhpn4He0zix0AGh2Rahu2CyjhQ0RA3/Z1BQo/vfVzAldPlnwAf9d/
k9xLZZiAQcjwOF1MA0e4lcIKQybQHCsp2CEpvCjWB3CZut7+lAAttjd2yQLeK4Sz
WvUbRjGVNA5lHijjdDVQTGAGo9nU7rgVYEoAbhBxRY9IJ3D9NsfMGk3zwsJlqbKx
0P2ghUCVIGkYQMy6s31PCvQGgm1heA==
=5U8F
-----END PGP SIGNATURE-----

--r5kiyyqgcuiwe4rb--

