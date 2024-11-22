Return-Path: <linux-pwm+bounces-4122-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89519D6407
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Nov 2024 19:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C2F161767
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Nov 2024 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BA91DF74F;
	Fri, 22 Nov 2024 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZsdFvC5T"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EE25FDA7
	for <linux-pwm@vger.kernel.org>; Fri, 22 Nov 2024 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732299396; cv=none; b=L6y1P2+4OPL2sYONx+iXcq2NOL9nJFSM8GOdW7EeU1+6o8OJCe9Xg0VY2aCMjuhNVMyXKzvj8zJ+eQBLY/gWYqFywwhbb1bAYgItnY0eXiCtTnV1ubLUgNlF/71gl7THdy5FtC5G7C1RBt+Lz4G77fy8CSF9eYDdlVKn9tpGMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732299396; c=relaxed/simple;
	bh=aM47pbPVNtrMOQanMHQ7ktZXfApmfUGeliGraS2mMOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I02aGf/LAXS0y3rnHmvhJQU4/+snjO/uQqbCwxr8wEBNpFAwbzseTz/0ksIfVUm7ZPKuDNpu33yOdNaK57WCKrsp5HmPbjiaNsfmj2XP0BInXAewoHyzH36eRb5bMsnKR/akB6i0dkGsw3xIGDb8SieOps80DGy9rHzVO23NQ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZsdFvC5T; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-431688d5127so19880065e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 22 Nov 2024 10:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732299392; x=1732904192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zShOcXTAhIOrL1GD9fBhb4zbIbWmFf6wLfZDDFFuD6U=;
        b=ZsdFvC5TwY7ulhtmW7BcIOPTfl50kDhzWc9rCDJuWSqhovxjXBkhQwjAM/ZZ+kxwnT
         g2PeSGwvZpIYjFNxyKMP9hU7sJ1J1+0oM6tW/xddhILfj71i7NvXj/0VBmLTrVSSRivU
         qoLXehsYwhaJdTCoJ2viM30xAgC8B8nxBHgImFnj/2SHkGqdarKB/seZWZRM8YuiqXat
         k9/iYwiPsHq3hCu4EAgzMP+osSO9U4uu1fS+gi+kycHRry3miR4GADkAuDNbgbCEx63+
         eZVqqBvB9Q+6YY9zVqdiJzYnf38aJ42KrTPmnnkKMcEUFhlUBS8EobZj+tXEtdJ6BcWk
         n2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732299392; x=1732904192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zShOcXTAhIOrL1GD9fBhb4zbIbWmFf6wLfZDDFFuD6U=;
        b=SVEEUVQ5zvDIHHOXj3rWlD0CZ2xLzyabnU9wUjlENwNScX600c6MwLs9xuu3VDDyAL
         GP/K/W5LuFu2/4X/Wj8C7hEVnTzn8ccCayRhIbg/20bTEBRC0ZCwo8mMcqY7SdK82Hao
         Ec40o0IgyPLuMWWByjUJEot+t5X7KMndVXGXTLHC8nEvXq8bk30PfNnEWk1JXGWqk4E7
         4HwVkxVaPvldP+Wk+hgcrgO8bEN/aZ0d6810CoPbSBZQA4Pc0tCF83kSmjn0rtQLWr/f
         t21JiBLcJZL15Nl85pxdey6Ipx3OZ+rK/hbICvJC0L9mi8adMMCv34rDIuT5LUMsij77
         dxUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcEH42z7XXGjDlbs4mXIVeAyF76yyJNZ3wTa+f+mb2PPpHOLxvFyI/wlj9nsn38kPp0rUgSvckBRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQcHMFYIpmo9wpA0Z7vxYm4WJ5pGmJq29UYizOC+oI8kpRoeO
	g3Bcj+seyUKSbUwZdsVwfmr5dY4jlf94J/Bie3Eva8IqxM71PrenXLypV3aenTU=
X-Gm-Gg: ASbGncvvpPqXw20zMQsXuTZEWxJVyVitCCKRWet2J+8q/Nb4koA3E9p2p54d5PK33wP
	BC41SeVloG06/J6BQlg3Hk1ggXAlRxlsHfd2FPkO22QKv5UXdgquqKuKzkmjsfEbcEuiphWoc8W
	Jzyb5tBaupniQADxQUCcUp3Vm/z8kRFUH3FaK8Lm6LK6rhebzIIvwbp1eHOiLFrYatRxGta41DQ
	rZpKxdrgjlPLQyasdwpEj2uka8WLZfqrhbovVJfOgT1lKNEgvUX6CCmFG3pj2bWvFFWD5Yf4TyX
	/p4=
X-Google-Smtp-Source: AGHT+IHO3jyqLCOcTS3wh4+2xhK12la2E5PqJC9zeMvnqEaUzAlAA/kD0IsAvSGpyvD3nUkmL5b/wg==
X-Received: by 2002:a05:600c:154d:b0:431:5d4f:73b9 with SMTP id 5b1f17b1804b1-433ce4c2324mr30034465e9.26.1732299392126;
        Fri, 22 Nov 2024 10:16:32 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde8c8d3sm35357205e9.31.2024.11.22.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 10:16:30 -0800 (PST)
Date: Fri, 22 Nov 2024 19:16:29 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: sprd,ums512-pwm: convert to YAML
Message-ID: <dbptlfuj5peehd5i63cbvdhnargexmfk6pncnnofir5wghpiwh@rtpe7cyj7g3g>
References: <ZyH-JASRcpMXYsmH@standask-GA-A55M-S2HP>
 <ielio4ys77kgo5qsvrbbqfg6yzlit33yun4leei2giplbedsc4@5qmkwgvqe6xl>
 <84dfe382-65d8-4743-84ba-d70699b6f5e7@linux.alibaba.com>
 <jjfajijz7xkh6rh4ekmvta5rum7tod4ts2j3y7sbdkbhkcgryr@6bbxclrkyzgq>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ni7e7r325tknnap5"
Content-Disposition: inline
In-Reply-To: <jjfajijz7xkh6rh4ekmvta5rum7tod4ts2j3y7sbdkbhkcgryr@6bbxclrkyzgq>


--ni7e7r325tknnap5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: pwm: sprd,ums512-pwm: convert to YAML
MIME-Version: 1.0

On Mon, Nov 04, 2024 at 09:28:34AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Mon, Nov 04, 2024 at 10:52:09AM +0800, Baolin Wang wrote:
> > On 2024/11/4 04:24, Uwe Kleine-K=F6nig wrote:
> > > thanks for your patch, looks fine for me.
> > >=20
> > > On Wed, Oct 30, 2024 at 10:36:36AM +0100, Stanislav Jakubek wrote:
> > > > +maintainers:
> > > > +  - Orson Zhai <orsonzhai@gmail.com>
> > > > +  - Baolin Wang <baolin.wang7@gmail.com>
> > > > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > >=20
> > > An Ack from (at least one of) them would be great. I see Baolin Wang =
in
> >=20
> > Sorry for late reply. Look good to me though I'm not a DT schema expert=
=2E So
> > Acked-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >=20
> > > the recipients of this mail, but with a different address. Does the
> > > maintainer entry need updating?
> >=20
> > No need, I have already done the mail mapping:)
>=20
> Having an entry in .mailmap doesn't justify adding old/wrong email
> addresses. If your linux.alibaba.com address is the one that should be
> used, it should be listed here. Not everyone consults .mailmap before
> sending mail.
>=20
> If you agree I just substitute your address while applying.

Assuming silent agreement I applied the patch with your address updated
to the linux.alibaba.com one.

The patch now waits in

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt

for the closing of the merge window. Will put it into next then and
include it in my PR for 6.14-rc1.

Best regards
Uwe

--ni7e7r325tknnap5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdAynkACgkQj4D7WH0S
/k4ubgf/T9lngTW46evn+d4FyC5/oaYb3HlwKomgqWDmXWgNCo4j4hUZgeNjlZJ0
peA9kJ4812Iuwx8kj2J5l5QvGiH8AB3iV4IyPg12wuVfsQE2AG8wZ/GruMH05bg7
8/duQHFtmTJ6r5LE5oJwcu8WYQdGlFLdJWaIv5ru+jfDGLMEEFD+Pistvj8z2dcc
jKMUBp9aJCgxHY99Q4yN0bdbKvUZUr+Sx9kt+DbrpUmAJR76rJkWVKkoVK1t29CT
D//4VyZJV2BHb/FT0nvPwR7jRDhOkL21rFMF9/fxJdZ3uEbB2RnPeeLzC2aQsYoi
5r9YGCu2ld5ZEKND6g9VYfqMkAMM1g==
=fIyv
-----END PGP SIGNATURE-----

--ni7e7r325tknnap5--

