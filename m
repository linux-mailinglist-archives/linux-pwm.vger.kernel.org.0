Return-Path: <linux-pwm+bounces-2765-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF76292E9D8
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 15:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8473A1C22596
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E64015FA66;
	Thu, 11 Jul 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mLk9bE7v"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE815F40A
	for <linux-pwm@vger.kernel.org>; Thu, 11 Jul 2024 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705747; cv=none; b=HKFvxMej6WjcQ+HcVu7mzRvPmJ4AQ9jfuWakvlSg4NTDgJGXhFVeuo5wvTb9sDlRso0ISGHHJwl73HmU+mnDzn7WbrdaCuvtSp+KcASa5JlQizq626Jsy6G7OGVhEoO5K0nO8ROjcif2q4g3NKHfEN92DO5t/8/bO7iq2KcF+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705747; c=relaxed/simple;
	bh=W54KqAxBeEcjgM+33L4oqZYLuZPu56t4BE6U2Z5/TX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0IcBH0UnNdBVand00Jw/DgXLxSNIaGo4/wQHimnn14E3Vm3EaP6F3vScoptUkoI+AgvWmkRvB8rrI3tXOv3MbUnjwevQUZmFJ8UTBfTd/I2ysYPN1hasuocs522CFIGJvIzgHijwqsMcuX3bjgpmRLyTfKzRv2jwgKWJK4MpGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mLk9bE7v; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58b447c51bfso1119397a12.2
        for <linux-pwm@vger.kernel.org>; Thu, 11 Jul 2024 06:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720705743; x=1721310543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W54KqAxBeEcjgM+33L4oqZYLuZPu56t4BE6U2Z5/TX4=;
        b=mLk9bE7vzqBqckQOpUm5Etyj4rl0Umgamuq1eoQokobZ6bU+eBBbs0eX0ocx9F03WI
         0tQLTeDeRFEUI2LdJ1/p4BmE6XYYQxZnmSfz4p/hSj8r48RkfkvA9nPtwKHPoSur4ErK
         ypPPcwPz+ltAqPsp8VVeDE8TUCIZ23D+6+mcAKzXJEA8xcB8elIvBs+YKDErTp+8nAlg
         amlbgTOCXV0q/EB+DpagG0+x50htFSqvv61rggaoBw4gVfuXm6nVT25dg3JKNdfxEfSs
         XqtFA2IYdXidVbNYt/b4UzBkjTG91nJ+LnpyOFoMLxYenNJbcD+gakqbcfPwMKFoqTuy
         Va0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720705743; x=1721310543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W54KqAxBeEcjgM+33L4oqZYLuZPu56t4BE6U2Z5/TX4=;
        b=tvxTGgpQFGfZAh7Cv9OD4Alajv6BP4BjSwylDcNYw7UUDWafBhTP2BlzM16IDfZkZI
         o8J/vxnfMj70vb1V7yKYV5jj5ZqlLNAyKmC1vHudFDgLPgQfz5tt2PD3rvHTbEmkFF/S
         WolCfGNKTTiKCKqIPNwZedWQt9Axe5Wq7X9NOvLTB+vE9J8j/gSKfDVgT954z2LHoZry
         zufIYnvviJckEplBT4Gw01Q6dZWFZDtc5nbBQ7cRWVs8OL7jkr8NZl07hgRHIC3nkdL8
         qofsDf7QZccsYB+Zb14ve5ho2sRugmksOm6RAdOIM87uEpObjqg7cZlHEPwelWf30t1Z
         tfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaq25FbWvfewiiyKdtXfx0LRRMaZ0Xk/EDk7E9Jbom1Pv23hneW3dlUX6sZuEELeCRyPJvSX2lJ/i8c457miQID1nKWxXJBuO4
X-Gm-Message-State: AOJu0YwCiJGLC3AwC3XbJoVugSZBpE4pMFDthDXNSdIo5Bc6wQg73WM7
	pe/9bOcGMuiHJeU4b8csfExywXbRBMAIGDEHsE3FOct+UBsPrwKLlGuwwQk2qTI=
X-Google-Smtp-Source: AGHT+IGfZtfMRXh9eucxPcMyGgSKnlhrHCt5178yGG2pvQUfh4KnB/rp6xhNMhfb/jt99oV6gpBEgA==
X-Received: by 2002:a17:906:7d1:b0:a6f:e47d:a965 with SMTP id a640c23a62f3a-a780b6ff0ecmr556134066b.41.1720705742926;
        Thu, 11 Jul 2024 06:49:02 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcd09sm259787466b.19.2024.07.11.06.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:49:02 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:49:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: axi-pwmgen: add .max_register to regmap
Message-ID: <4hbaesqrfjrqs2chu7b3kpg3lnaqoezf7ymo2yj4jwtdzs3exz@tah2c3ht5gow>
References: <20240711125743.3956935-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x7ayujcswi4gl5ge"
Content-Disposition: inline
In-Reply-To: <20240711125743.3956935-1-tgamblin@baylibre.com>


--x7ayujcswi4gl5ge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Trevor,

On Thu, Jul 11, 2024 at 08:57:42AM -0400, Trevor Gamblin wrote:
> This was missed in the basic driver and is useful for debug, so add it.
>=20
> Example regmap output before the patch:
>=20
> |root@zed-tg:~# cat /sys/kernel/debug/regmap/44a60000.pwm/registers
> |0: 00020100
>=20
> And with it:
>=20
> |root@zed-tg:~# cat /sys/kernel/debug/regmap/44a60000.pwm/registers
> |00: 00020100
> |04: 00000000
> |08: 00000000
> |0c: 601a3471
> |10: 00000000
> |14: 00000002
> |18: 00000001
> |1c: 00000000
> |...
>=20
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
> v2 just adds an example of the effect to the commit log.
> ---

Makes sense. I applied it to pwm/for-next.

Thanks
Uwe

--x7ayujcswi4gl5ge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaP4soACgkQj4D7WH0S
/k6pdAf+NCsft6eAjUSGESUighMEydt+KWlcrmnm3GiFAA01qfzWscHxGhnMU3jP
NlTt/Ksz7YlqDWRIk4DBwKbYQmg/MqF+c0K3HLUMq2w+rZBf1gNUQLDnbfUAXUKe
WlxjgEudclGn+Qmix/02JkBb93EGN9JLN04vs5lWXiCBM0ZFh4dm1xsD5VJkUtwi
jp2RON5UlfRHuZNWXmf0di4ziTY2l75GPzc/qeQdMimAeFhLBtHiRxz/gO4NST5I
nOlHAs6wTgpe8FRDnJkCFDITV+r/ak9o6iKrJsIagFZtgr0b3W91HaeGTzT1KB34
m1GOnvuloxFe7KmP/vvaEo59u81i0w==
=L73+
-----END PGP SIGNATURE-----

--x7ayujcswi4gl5ge--

