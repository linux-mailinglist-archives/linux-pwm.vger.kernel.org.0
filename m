Return-Path: <linux-pwm+bounces-3845-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950DF9AF422
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 22:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B781C20D0D
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 20:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311661ADFFB;
	Thu, 24 Oct 2024 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YjV0LQ3a"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CBD198A30
	for <linux-pwm@vger.kernel.org>; Thu, 24 Oct 2024 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803344; cv=none; b=dsBkNHUH7CqfqOOYKIQ1tZqQNiIlo3TiO6VlaTM9zHSDmvxAuErUftFxul04T+1/xh7Mjk6AJIjfUyF5WjvMA2cbZZEjBeZ7jxCunIQfxK6/zEwIeQevLlstDeL00DPhFNpb7t325oacGthCVufS5BVzEFN9894mQfxH4CiMrPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803344; c=relaxed/simple;
	bh=nxIHzAClLNDGCwmKNdZ3UWWCVUmMTAF6GmSIUAN3gUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGr1IoeWIhNxdnSBWJZxxeKj9jVhbvyrLwMZ0IgMeWjWScDC3lxSSV1YKm0nzAjMb9SQKbTw2JTvC8caAB0/DZ3l5skWRoRLK+YimPi46oHfYDecdB30qaaHMM+3fDAyWesAnaMTKL2vstSZz9jkHDcF9oCsBqEvI69H6FwsSqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YjV0LQ3a; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43159c9f617so13616975e9.2
        for <linux-pwm@vger.kernel.org>; Thu, 24 Oct 2024 13:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729803339; x=1730408139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JY/Sg5K2Kp8SWLwBIhx9DawGIOPIUVQRH4SiR7NaVYk=;
        b=YjV0LQ3awBGGd5zIuRpf1eR1xV4toyRQj53VyqeIqmWIFSas3xM0ZVSVX9LYHUaQXy
         j+0n5EOP78SD3M+upULWNT2vlgy72dJ1kk/SNjKO1EvcK8zJ8Z1PxduvftcGeZBkqk1s
         Rh0A3rFiiCbq4hlPdIh/YPFGWzMx/J+jTcZQive21K8PdgIL/zkAF8Xf4wz2IL5wb83o
         W009K+1Jajp4qZo0/s1gXQxT/o2fmcNcAZTBVdu3zPVFHHtiobJg41EVl23DsrhIxNCN
         i0i2+QKkqcC5vEZO1dMh/tyDVw9lTVaiIdNcyX74R5hRGpnff2jzqmocsutq7GWMXrhk
         sWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729803339; x=1730408139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JY/Sg5K2Kp8SWLwBIhx9DawGIOPIUVQRH4SiR7NaVYk=;
        b=cSGvi0RK7AMmdk7JMEueMMfeUvaDL9zkJze+lYOsm7OYtQk3TcjEuLn2h/gNFGuj83
         G7KAy7NaxUdpu5J66HZa3bm31UciNzPW7iSu/4/BU2W8WQq1S/yxnAuP6mhaUMpe6lym
         FLXaDgJJreNTdkyvwJLtxnGQHv9vkEqdJMgALbKCmytIDLDqA6uoUbyqF+dLtfIEjfrM
         pDrl5+hxd5JDPylXCoWFD+DDjoREz0SXEWsi3C01dCkKZHQRy5u0Tma9JYPlmjZU5xqk
         qMFxjwiKM17v2+3EkMkLY2X3q3kf2SMvV/ADDQ9XsF3Ryssqto2ZyDdTGXlizQY2TMVv
         rEIw==
X-Gm-Message-State: AOJu0YwYO9rw9MYoSzw++MWIedbwT1nD44GTziNt02sH/x1H2JjIA7gC
	kaKlc9iysSgh4Ci+g1akre65l/1MzvMmBkZBB/uwJCYeUwlniS5ec64KATwLUpI=
X-Google-Smtp-Source: AGHT+IEAyWoHVJ/Zk7HiRZz1UKshEzg02zmYUlV9zG3i/Tsc0TKX04eOJEKBAl8rGn2fKDlvYd938A==
X-Received: by 2002:a05:600c:5028:b0:42f:7c9e:1f96 with SMTP id 5b1f17b1804b1-4318c6df984mr29545215e9.1.1729803338889;
        Thu, 24 Oct 2024 13:55:38 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:b203:5494:7e5a:8c7b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55d753sm28623665e9.11.2024.10.24.13.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:55:38 -0700 (PDT)
Date: Thu, 24 Oct 2024 22:55:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pwm: core: use device_match_name() instead of
 strcmp(dev_name(...
Message-ID: <2r7ey7fkt4k3s3kpi2vmesqrfntyd6jt7uf5jmwwbzglgxcohf@lr5gfy3ce2yu>
References: <20241024151905.4038854-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sydgajavitgg6bof"
Content-Disposition: inline
In-Reply-To: <20241024151905.4038854-1-andriy.shevchenko@linux.intel.com>


--sydgajavitgg6bof
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/1] pwm: core: use device_match_name() instead of
 strcmp(dev_name(...
MIME-Version: 1.0

Hello Andy,

On Thu, Oct 24, 2024 at 06:19:05PM +0300, Andy Shevchenko wrote:
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 634be56e204b..4399e793efaf 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -852,9 +852,7 @@ static struct pwm_chip *pwmchip_find_by_name(const ch=
ar *name)
>  	guard(mutex)(&pwm_lock);
> =20
>  	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id) {
> -		const char *chip_name =3D dev_name(pwmchip_parent(chip));
> -
> -		if (chip_name && strcmp(chip_name, name) =3D=3D 0)
> +		if (device_match_name(pwmchip_parent(chip), name))

This theoretically changes behaviour in a few cases. For example if
dev_name(pwmchip_parent(chip)) is NULL the new code would crash. Can
this happen?=20

Best regards
Uwe

>  			return chip;
>  	}

--sydgajavitgg6bof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcatEYACgkQj4D7WH0S
/k7GNwgAhlYa2Zr+2HtBo54kubBRpT6ECHOqbhPGsX4OC+93jgHqLJ04k5CZcg/R
AXibCb///GF5fXH3odAfBncPKZuY6dJdglEnyJZpwRTHGkpx2GoSmpe94gzHy834
tEw02HGoZKFIweyAyU5ppJqPnXGLav7EGS2pbjd5QxOCIrHAQ3pnzvK+/4x0AzCm
xKqN3mYIKFCTAOTIKMLFcsouphQT9FCrfeJS8w68dVARiSYLaa3Yo336hZEgepfV
xDLeDdmoIu1L2Gb7oas7noKJ4bKkfVNSarGmiYVvS0xFrJcwKXKxgngXls/vGEQ3
RhTHG+aISW/LLMZD63B+k0up+lRCfQ==
=LqXR
-----END PGP SIGNATURE-----

--sydgajavitgg6bof--

