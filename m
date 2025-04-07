Return-Path: <linux-pwm+bounces-5354-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D3DA7DB0C
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 12:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8AFF7A59FA
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3A2230BC2;
	Mon,  7 Apr 2025 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ATMJBjQD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC2322FE0F
	for <linux-pwm@vger.kernel.org>; Mon,  7 Apr 2025 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744021477; cv=none; b=WQf6LAAgaHk8TcPuQ+kVdv5maChvWmcUTdiBdzcBZf6bK6O0yUcthgTOqSaxAAuOH7hggZ42Dd+8VNmHLHFOvwBFsyJH3GVduERwSdrD6DXhJDdRvfRIxs3m5IgGtbZmhmPTNCUOBaniA6Vf6/lDpCqS+8rLFJc4F4850TyB5h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744021477; c=relaxed/simple;
	bh=DyAx4p+d4Yo6UybfGrnNrwrsaiiPORXp5nHPXkTY5XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WauLzxkwG75ut/nknVum1eyzsm+Ppr14zjdQpglPMLT1Rdz6CX9hMlyo2wUdgs+pEbsriv4KfdEU76rrI3Mnmwez/UM1U3ZDF73NUyngqCX1FFJndO6sun4bLVJCOSJHJhnrliGaL/Hky932IXC29M+YGN0J0TZaRpwYIwu1iIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ATMJBjQD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so24069325e9.2
        for <linux-pwm@vger.kernel.org>; Mon, 07 Apr 2025 03:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744021473; x=1744626273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cHEoQFwXWeEahAsWtVrHWP+XPCjbcIBA59jvijJVzNM=;
        b=ATMJBjQDmHJ1s9N6pdIucYDun/lXZNY92fGrtTgSqgM2EZtov5/6RIdOuQ4Hf9LLGE
         7GDxjKqafcT0F0GGGTEOcQAmWG6O94pzYpdZsox6Rzfg1HzUNrnAvRXvE0bUWucGh6t1
         E2dJp2y54GBmi2GsfiGLfueA47EDVFuv9h9aAk2quJQgWt0tPSHyfy61RRvmUQDT//71
         gRt6+l/0e8FzYFwDHFF1pJEMRFoHZv/Zt6gHaZVyEyWM5uRtIgk0zPP7OR8873Q1e3JL
         FyRX2CtuTSWhzM82RKJQ+oWX22rRi/AoxBZgZUTrJtRrYv6ujK/07UZJ47MzHO+QZyUV
         Hnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744021473; x=1744626273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHEoQFwXWeEahAsWtVrHWP+XPCjbcIBA59jvijJVzNM=;
        b=vt+nEbwtH113Dz7JUs48eWpYGjOOCIcw9M9NGjyAx7n1IZQv7FtIl/IHxOU2gIsC8I
         ioDf9txVpz7A+fj2Pv4iHopMIgpLjda1KEHWnbCbB4ZKYD0IWsIEmvLuoHZByRiYyNki
         JCnof4XV4HJofU1j4l9D/yU57uYv8QI6f6vTkiaXaMuoRZE083/89mVNlkKxCGV9rYju
         uA1evFoHltf2vfluvH7W1CnXPd60U8laKRGRROjMM7AOYK8XQe4TkEoWa/7RIUP1PL4p
         07M1O8+y/4ueehGUPX69dE3UHMFUEtL7wNmH5a5ZoFgRXxnkUX7cGBYYvQCplSyI0GCJ
         XDuQ==
X-Gm-Message-State: AOJu0Yy9TUkvmKLugLQMOL5mv1xcn4hjbT2pVAFtr9kDosG914ZuBqcd
	4kUgz4cWeBrp/mZPFsr0ZBjw2YfIOvavz3tSeNjNvRKdm93lqX5rXTB/+py+yPDlvbQ86BDrnff
	0
X-Gm-Gg: ASbGncsiWcciqUQ0etSYL+XUjozisBm50DOqu1SVJnewQ5jyd1ZMzoi6ACqeul6bs7Z
	5BA2ZnjDDlBMcO9+4D6W79Xp16bW8ECmqwLDUYHLNzoY8yojVrNWCpKbBR2PTy6R99L2o5QBfJT
	/1Ao/ECUZx/wRCV53miDz59Duu0TeROFU75u62yOcBQm7CKAqmRoRqLYdcBxyrqKeJ+p05Vv2CU
	P0s+17TDBLneVyUhVfa+YUDJvrbKwp41wMig7qCLcmTc5wVvFrwhOofbsAohVyi5OXNRlSKyr9o
	+hSChxXIPQfRgH0SraP8+6TlsaB/a5qpS0yqt3EglSyhYNXhP0WnUWbRarrnL3YvZb+T1csO1C+
	OuuaD7dL5qDc=
X-Google-Smtp-Source: AGHT+IGZWuoPqI5GhADsQ3RuS88slV6GMK9gadfCiV0+cI0VoYQJ9/cpeSLu1FczN67nQ6IYvyNLEg==
X-Received: by 2002:a05:600c:4f05:b0:43d:7588:6687 with SMTP id 5b1f17b1804b1-43ee0664696mr69308895e9.12.1744021473550;
        Mon, 07 Apr 2025 03:24:33 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39d753e48f7sm5409639f8f.4.2025.04.07.03.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 03:24:32 -0700 (PDT)
Date: Mon, 7 Apr 2025 12:24:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH 0/6] pwm: Some fixes preparing chardev support
Message-ID: <lzwvrhmx3yqv2v2qkpiq5e542eflnnwvhm63fjmq6szh4bh47b@zk4hifurejja>
References: <cover.1743844730.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c76mue3amd423vde"
Content-Disposition: inline
In-Reply-To: <cover.1743844730.git.u.kleine-koenig@baylibre.com>


--c76mue3amd423vde
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/6] pwm: Some fixes preparing chardev support
MIME-Version: 1.0

On Sat, Apr 05, 2025 at 11:27:11AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> while working on character device support for PWMs I found a few
> inconsistencies that are fixed in this series. After that I plan to work
> on getting the character device support into shape to get it into
> mainline, too.
>=20
> While some of these patches qualify as fixes I think there is no urge to
> get them into 6.15, but given there is a bunch of such changes I might
> send them to all together to Linus for inclusion to 6.15.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=F6nig (6):
>   pwm: Let pwm_set_waveform() succeed even if lowlevel driver rounded up
>   pwm: stm32: Search an appropriate duty_cycle if period cannot be
>     modified
>   pwm: stm32: Don't open-code TIM_CCER_CCxE()
>   pwm: stm32: Emit debug output also for corner cases of the rounding
>     callbacks
>   pwm: axi-pwmgen: Let .round_waveform_tohw() signal when request was
>     rounded up
>   pwm: Do stricter return value checking for .round_waveform_tohw()

I applied patches #1, #2 and #5 to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fixes

I still havn't made up my mind about trying to get these into v6.15, but
at least they should be included in next for now.

Best regards
Uwe

--c76mue3amd423vde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfzp9cACgkQj4D7WH0S
/k5h1wf/ePnI78AwsFL73hW/6a3vkcMZT1DX5QGpwIyEH62MofINXyMmZ/DLn3/E
cHpC9YmdK4KjuLW/FjdG/yxNo/Me8osVzWaMTNNbFZAtgVc5gIka3FbfznJML970
5UYLrmq4YcgT+PfECKmwQ5n2qleTpUimRIgUkSIu1GSCutJ47Z2K+SmwW2RdoDZc
ILkPr7uTh3Smp5SMXU1lIXI6p5BrbxHDTtgidp6qEbLLU56zulCqUY8Xc/BaBzQV
oPqykCt5ec5E1NdyLN6OTmQPSrQTFzsQqcuPSRj9E0RJeD12HwC/toKhG13vWAGW
w1Iu0W62/tqWEksU+l9Op9pMMa6u5w==
=PhOu
-----END PGP SIGNATURE-----

--c76mue3amd423vde--

