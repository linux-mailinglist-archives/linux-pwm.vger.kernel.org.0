Return-Path: <linux-pwm+bounces-6617-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21812AEF042
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 09:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEAE87A87EA
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 07:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14BC23C51B;
	Tue,  1 Jul 2025 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oJ9K/rhP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB21E51EB
	for <linux-pwm@vger.kernel.org>; Tue,  1 Jul 2025 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356683; cv=none; b=sy4XKxA9142SUzYmZsULgEi1yJ/0G3c5jjRZO8UqJec2JQts4iPQoBULn10G1vT+Jr1O7MVohfE7crFax4K2j3prL3tEW6y5sFO3zCNPeUfr0EGThdFShNlEnRm+x1Hs3Lwyw3OekvYLX4H1qecyeelWYCHZUtK8mXOsse90wBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356683; c=relaxed/simple;
	bh=0fGtepblwK+PwnUbRqr8IJdvtvAvDr3iEbtu2aVkHEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NO2pAMAYxXoasM2oBoqfDgISN+bH+LYZOzLOrj/ArPVo0vDk3KVaD9FgSzBj1CtFYVm/3uOT3KkWh9GX3N85IaNg5w7jOG0A/i/RjbUhQtPEdSfdnPkIqZiYCAugnj7f/hxC5N4RWezcfrnE4pih4JwEWxXL7RXuNHHsD0W0+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oJ9K/rhP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60cc11b34f6so3587507a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 01 Jul 2025 00:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751356679; x=1751961479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0fGtepblwK+PwnUbRqr8IJdvtvAvDr3iEbtu2aVkHEg=;
        b=oJ9K/rhPOS+KXOnBXXHy4spQ50ghRkv4GgmyPa1mpOfOm5Xkyn1pelfmjXwx9N1cRZ
         GTkP85ptQ6T/872nOQtiAigkEXs/KTyPbaYLxbMLk0AuYxnBSbeE3WaGdah+iRlqxMsP
         pWdTAY/nHuuOroTyembF9ytUZfLXqKvGLzBPqaRa+0HWtTQCIWfaXh1WQklHRvEIBPEh
         xIIv/2pFtnYdWTGwOvtwJQQ6ne+m0LYEUDfXc8I+8dtBaF4e8M9+kS0XH/rrlqNIqH2s
         kldQg60mja9pGp4n51LucXvtieodCYWrLDTTMdoulrXkf70ftmcyU4Ioe1SwzswFHvBW
         aT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751356679; x=1751961479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fGtepblwK+PwnUbRqr8IJdvtvAvDr3iEbtu2aVkHEg=;
        b=I9NbZIdR7wOiUzJVMj+zdmqofLU/QjpRMlUhDo4pUqiRR01hINkzX+SPOxlrEqzc3c
         WaEHfmpBi1YysnfxCYSKhrtRUW2EP8yL7TpEyzRNXBpwbuMEF/571e7q6pMYIf83+vdd
         jnskxJKffYCL7yn5pbymEWJb4HVeHhrkKiA5zQRJLsXUJoccsjCBxl2/cxnU8+Cs2i7E
         hbVjlaThz9BNLK8fi9FeHBrDO9DnA00HNzi7lD89byI5sDt0tm53p/4MXQeiTvCirBgV
         EOLOlq0SCxOE4VCkVan1LWh4d3An/VOduVjLaW5t5kSced802mnPQHlRfulgZpXWJZVt
         /PxQ==
X-Gm-Message-State: AOJu0Yw+PFWTKETAaJJ/RqklCj68DBrSuzVe6y6k+T42MQhnbwt6kCZh
	t+sL/KaxqJvcXO5d67E2NWeHUbiPWo3oW2+MZBMfhIMyZeFoo+DVUIMT0VU3U9pjV1VOboOXdk4
	u7Zys
X-Gm-Gg: ASbGncsIebpwdGNeQ0I0kXwkEes0nFKSO7r2WNJ/cxgBXcEIWUghn+eg6VDb9fNb3WS
	BLDgj2as9OEaykDfDAeWaDGPhPYAmiRP5VSZmE8j43zX+qy+kOQFEL0FKgQvlFD/gZMcThIO39W
	UQqspYb3GQvqKOhQ/mSJ5JbLtwY6JoWZgD1L2bU5URy8rZjOB58UKPS7tP92el1bHg1o8xkY/Og
	w+lEq1ilkzaWHREauKdjJkczMf4e6PbCraGaIgD6x+HncZR4hV2Lge79kNaRn8TjBUBWOgqGWoC
	WVhozDuB7oiVEpYa8D8+iV9e5xme5m6sCIliao4W/1vHXCTSXaHa8qGqzRexrQENxHr4rPd7Rfe
	1rxHD7s0Q84sUHfn38eRRWltM4lSF
X-Google-Smtp-Source: AGHT+IGGrCAc15VHtma/sGYQ2QD6trb1EHpP/JN8l1psGDWhOW7Eth1ZId1p8Z9JxXzDyNqdoc0dkQ==
X-Received: by 2002:a17:907:3d8f:b0:ae0:c4e3:e2e8 with SMTP id a640c23a62f3a-ae3b0b8fa19mr136200866b.28.1751356679310;
        Tue, 01 Jul 2025 00:57:59 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae35363a172sm808993166b.8.2025.07.01.00.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 00:57:58 -0700 (PDT)
Date: Tue, 1 Jul 2025 09:57:57 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-arm-kernel@lists.infradead.org, Vladimir Zapolskiy <vz@mleia.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	linux-riscv@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/8] pwm: Drop local locking in several drivers
Message-ID: <wzadx2ut3wjm24bw7ol4qjjeku6f74sp3tovtexs5w62ljesid@n7d2f4uzga6b>
References: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dvqu3sv3rcoezsre"
Content-Disposition: inline
In-Reply-To: <cover.1750788649.git.u.kleine-koenig@baylibre.com>


--dvqu3sv3rcoezsre
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/8] pwm: Drop local locking in several drivers
MIME-Version: 1.0

Hello,

On Tue, Jun 24, 2025 at 08:15:36PM +0200, Uwe Kleine-K=F6nig wrote:
> some time ago the pwm core implemented additional locking to protect
> lowlevel driver callbacks against driver removal. A side effect is that
> .apply() and .get_state() are serialized. This allows to drop some
> locking that is now superfluous due to the core's locking.
>=20
> I identified a few drivers that are affected; these are cleaned up
> accordingly here.

I applied these patches to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
now.

Best regards
Uwe

--dvqu3sv3rcoezsre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhjlQEACgkQj4D7WH0S
/k4vegf8DgkQ0a9kQ5LjlzCtQA04Tm1xfeP7UVjfQXVsJkkBcOU4mfdoSrU9tfno
BfO6tWeFYcUdJbCAPLDW0rtt/PLGq00m1Ti+DotG0ys5XYfE4C/L2gEcEJXEWdh5
teuOCdBWo55vAOj0OT+fFWSagAH5t1UJvOiX/XHUqS4do4wNVCUDo3oCG94zvqRo
t+cSZpO8iWlY+qK/wJu7rClU87CHx+WgtSs+TKH44z6SV8chWe2sh2a8bJzEYjLf
oCP3jZ6htcXuYiqQEyxRtyzYPvV7Uhy3tnshs2tS54Pyvgs6hYa13ZkPU9uSa154
6kyYGeshrOV0IJSJUvGmR+mfNO9lcQ==
=GkCe
-----END PGP SIGNATURE-----

--dvqu3sv3rcoezsre--

