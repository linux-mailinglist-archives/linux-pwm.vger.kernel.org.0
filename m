Return-Path: <linux-pwm+bounces-589-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED23A81A38D
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Dec 2023 17:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8524284BB0
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Dec 2023 16:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BB94C3A6;
	Wed, 20 Dec 2023 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5KF6ugG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFF94C3AE
	for <linux-pwm@vger.kernel.org>; Wed, 20 Dec 2023 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33621d443a7so6013791f8f.3
        for <linux-pwm@vger.kernel.org>; Wed, 20 Dec 2023 07:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703087989; x=1703692789; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlF491ghOGLrK9Em/D/uRAJ1aT5zh9NJczNU+dua4mQ=;
        b=O5KF6ugGY3iu44O2SEnfw8igIM+V1gWA7KwGBHTpyqrzRv2WnpuZj/cuzskoEXEOHy
         2iW6iYNQrsMMtDTMcTLswI3+hRdn7ELGnEyxOHdZVcyBC6c7BGEty4WoNUMVaqrGi0X4
         /dB582Y4p7P94Rj+UZ2G5gtyOWK5Wzd1fKvn3KsVL27CHMpImtTzxZmAmDToPhNljgwi
         ih2oGys4Gk03r4HzxJRjcVcWAXwDtEp+q49JSYk+Y83TrZpwzZD0s7nNEfwWWCV1k9X5
         e/GqOrz5xYzTkPUhcD0VLhtK9CIGPQdOUBx/+5kUxi8VLgscf4x+xQnAcMGn6BLwq2N9
         TalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703087989; x=1703692789;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlF491ghOGLrK9Em/D/uRAJ1aT5zh9NJczNU+dua4mQ=;
        b=a6Wjn4YbWflZXOK8E/9nCTWntkNkeuaCc+qYxAo4ikTD7mThuADgNZlIUg9I721QSS
         4eiNu7Hus5bPM5sOUNewVSLKXrvLszjxIBs13a5UkGTDHk7ZEzULErR+J2izeZnMWXLW
         1HSWdFsM4UhL2jlahenZOvMj0lH2+HyR9dQHzWvigQC9FIzB9kfNK6ldDqkonodeEnu8
         vnbBfHFcaaFQ4U3W3OaeJ6txJ6HaHRWIGv2hkUobRLeEGBHPc4jL81WmAjS+qZu3oGX7
         EH488lNhGg11GQkE2mApc2Q3SpKKqW49QYNxN+sxvDG4+ot1r4qQAL6bPAv5E8v7VkSC
         LfxQ==
X-Gm-Message-State: AOJu0YyCcG1cfwJXVe7r3nEPpR5axwk8ljNFr+gcY5rMR1kGUk6LZRWr
	FWao3rlZGJrGUv5/gjV1csc=
X-Google-Smtp-Source: AGHT+IFnMPCDwoGTWb01tNCJPHJq8OlIroHW54gzOjTRHhUdDfR4zUHzMtMHHa51Tf6/OEhaYaM07w==
X-Received: by 2002:a05:600c:1389:b0:40c:61a7:e868 with SMTP id u9-20020a05600c138900b0040c61a7e868mr5142052wmf.26.1703087989151;
        Wed, 20 Dec 2023 07:59:49 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id zw23-20020a17090771d700b00a1de8f69dabsm75096ejb.5.2023.12.20.07.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:59:48 -0800 (PST)
Date: Wed, 20 Dec 2023 16:59:47 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-pwm@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Kevin Hilman <khilman@baylibre.com>, kernel@pengutronix.de,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] pwm: meson: Simplify using dev_err_probe()
Message-ID: <ZYMPc50eBi6oBClu@orome.fritz.box>
References: <20231206214817.1783227-2-u.kleine-koenig@pengutronix.de>
 <ZXM72QYBbb32Q_aL@orome.fritz.box>
 <20231208190620.5qobgtyii2wt7tfa@pengutronix.de>
 <ZXbsDRslZNKCeJF9@orome.fritz.box>
 <20231211141900.x6tpyctch5fv3uqf@pengutronix.de>
 <ZXcpswXxb1oQldp5@orome.fritz.box>
 <20231212203352.wl3rzob75fct4lov@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NDgFrnQjyNDqVFH/"
Content-Disposition: inline
In-Reply-To: <20231212203352.wl3rzob75fct4lov@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)


--NDgFrnQjyNDqVFH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 09:33:52PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Mon, Dec 11, 2023 at 04:24:35PM +0100, Thierry Reding wrote:
> > It all adds up in the end and keeps me from doing other things.
>=20
> If that means you'd be glad to give up the PWM maintainer job, I'd
> happily take over this post.

"Glad" is not the word that I would choose. After all I've looked after
this subsystem for almost 12 years, and letting it go isn't something
that is particularly easy. However, I do realize that my heart isn't in
it anymore and I don't want to be in the way of anyone.

So I'll take you up on that offer. Do you want to send a patch?

Thierry

--NDgFrnQjyNDqVFH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmWDD3AACgkQ3SOs138+
s6H0QQ/+IPt7W7ID5anQIEij/5IA0Mb5hvrylvIttu2J7KwG8Quq+UDFMqpHho4N
KKwxuRMPcwHvV/riQ/c53H8si8Qq680pH0GGVIqg3v2CJsyDifjSWQA1FfeM/v+O
44NMP7QdIjl5/y3IvFXJCczT63c1Njq6P9Fp2vjwUI1Ed3YHsnpRUjmFrRBc89j7
1CsDiMpbvaXX6A5JA/E44xVI+bzg/s3KT64scsLRYJ+gFFJBJwuShwKu96m/qcZg
XovZIZJwuH8IQpBfJ7bAvfVZUhAzGXXPL9427fv4HiBtkOC7eSNnz4rwxrz22bTd
K3wHxBwwsZmm8WXqdbSZ/iNflTOs50RkJ6ZZ+0xvEX6Y55N2Au0Xu2Ou369Aqm2V
ztQrNiJazuUGpNriWXJcq+43FHbj0dM66g5drnMwBzbxIU0h2nSliSa7Bgph4VDU
mrkUxi/9bgpu4XUV/1oB5MkuRkhW/6cp4A3v5MDREJ8TJb7h8/F0JNoHCFdpboYB
yD/FCxoPlAawzCKqTxJTL3005NtlMTc1OLWLr9UtpxfMY4L2aMmbaMaNQQTroN1D
C0y083ypWTamIQs0rxVn/NIBWwAL1H0HgBDTeDac5IhX+YM/yDUmzIHJU7BrbVJu
Pgz3OncTJ+G4Wq/1+dmoKc68Z63VEUWzmgN7rq2vMJASRsujZPA=
=pjoN
-----END PGP SIGNATURE-----

--NDgFrnQjyNDqVFH/--

