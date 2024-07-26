Return-Path: <linux-pwm+bounces-2919-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B8D93CF67
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jul 2024 10:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A84B2215A
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jul 2024 08:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967801369B1;
	Fri, 26 Jul 2024 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fC/YTSK8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC8A41C63
	for <linux-pwm@vger.kernel.org>; Fri, 26 Jul 2024 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981769; cv=none; b=XJdZeAt5TnIk8LYsSub9QGuiAXJZJpQnvrYpBzZQ5shezj3gE04g6dzb1YDEIvOkOIUuEVoz/AxQBKElUGATfJiu1WbCxF/GtJXQ5nWewRgaNzKF/BEju9Fc1KP+AxDX3IwFv0MGJXVpIyC8UJP9mU72+oFG8zZj9FGWgydFKYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981769; c=relaxed/simple;
	bh=S/Hoh4bXg1UZDdZJQBXsz2bQKhdvNuE+/OwIDUSIuQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrTnHKnCKC6xgRPoNaUqj1ih3Zamfgum1eJ68TJRCkWor18OgRoBSccI/vY093naoJKNkCIf6hkVlamc338wwT9mwYywfPIdMBbxx2ifpjpT19ktUEqC+ElpaVZ+GS2VpVMHTz9iadU0d8rF2ktvSfQqGojgO9dHvpJa1VfRkHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fC/YTSK8; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso15595731fa.2
        for <linux-pwm@vger.kernel.org>; Fri, 26 Jul 2024 01:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721981765; x=1722586565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TYTI0CSVKI2TXvDPdpXJ4Kmrco4gw3sbLMb/7A/5juI=;
        b=fC/YTSK8L1YD9K5Oqk1qxjGBzj2TxFC9/AfxfAA2k5Lk4HVsYWWY93nj9VqY2NDJR6
         4Xx3RkGbXLglJGpnX959nZ8nlBSCfINi1mXXPJGMbsdAvrHhb78dXZg0REtjGGgx9KTR
         cXdyDjHiuLEoRXUxc0j82qu4rWbjwcoMSoAggzExeebeG8s86apktOvj069x7ahrkdt4
         MQVXC+8pXIBpXkvW00Kyl7VF8M4k2o6X5IIytWGl9gMgsmKmTfhyaI+I5ATNeUFaauHJ
         ARIamJjEQFtt8U47MnhsD91k3afWf+vwBZj1elV0WuN3P/EDUO/3qCJSmawH8ESTpD7n
         UHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721981765; x=1722586565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYTI0CSVKI2TXvDPdpXJ4Kmrco4gw3sbLMb/7A/5juI=;
        b=S8cnyqN9Q4yuBhIdv875NNIc4frdT+wOwYLz95vqdQPzTsz9TO0A0qB+ofqmsMLeJ8
         6Qf7G4WL72wWal7IfcBvuZiUgTQee6Hno+Oa9TXRmJ9F1sLiRBHtF04qW64JRydAmOHc
         hWdIDwF6VzPOactIiklfW/Wm3yZsYyfWKziKeNtITctGvlFGxbQQRsGckmP3SEUNdbTl
         NbNNwMCpP1pnBaGKTnIL/jtQlRsWCyXw1ubYt358X6broL4/9FhrPt8bPmSo6fuPxer5
         G0yi4LYYZmSKSnS5BoTcbYe/NY0hNNZ3qyClBOigMsIP+oW1TrZoFsuRRKz06Vj3J1Dl
         W8nA==
X-Forwarded-Encrypted: i=1; AJvYcCUb4tiQLnrq5Cv2yQPawXivJ8HwcohrfbjJvu6OS9/5r20paEsuK7+aZJdPT5coQ/aYg8WqQaYFMu+NjX8lTlV7Wr5v3mXN05AM
X-Gm-Message-State: AOJu0Yz83uQfLZi8bkjjIeWj4O+SeWilkYGQUMLosLNZp4UsD/PMw7p4
	zYwTkokcBl9d4lEzEwxhxo3Rr18gcDxebqicdhvUEB33XeVaPNiVdFcmKImbCGs=
X-Google-Smtp-Source: AGHT+IFARq9FwsB8RjXSIH+GWglIVcZ0UrF3Y3kjl0RxuQLU9iezQhGVz2hdxK4T5dKSzYVooaeGgw==
X-Received: by 2002:a2e:8812:0:b0:2ef:296d:1de3 with SMTP id 38308e7fff4ca-2f03dabebd2mr35897911fa.0.1721981765244;
        Fri, 26 Jul 2024 01:16:05 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:3ebe:e31b:885d:414e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41164sm147206766b.102.2024.07.26.01.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 01:16:04 -0700 (PDT)
Date: Fri, 26 Jul 2024 10:16:02 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 0/2] dt-bindings: pwm: Add r8a779h0 support
Message-ID: <yaavvcimdwatogeiejd4q6s325scnxdspqkl3d7u4x3qgho6sa@jgi2smviz4bz>
References: <20240725193803.14130-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pynesepz3mktlh7g"
Content-Disposition: inline
In-Reply-To: <20240725193803.14130-4-wsa+renesas@sang-engineering.com>


--pynesepz3mktlh7g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Wolfram,

On Thu, Jul 25, 2024 at 09:38:03PM +0200, Wolfram Sang wrote:
> Add the bindings for both PWM controllers in this SoC.
>=20
> Wolfram Sang (2):
>   dt-bindings: pwm: renesas,pwm-rcar: Add r8a779h0 support
>   dt-bindings: pwm: renesas,tpu: Add r8a779h0 support

Looks straight forward. I applied it to my for-nexxt branch at
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt
=2E It will migrate to the branch with a single x that is included in next
after the merge window closes. Still open to accept review tags for it.

Thanks
Uwe

--pynesepz3mktlh7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmajWz8ACgkQj4D7WH0S
/k7iQwf/SaZmhQb38lBOdeLuTyTAHQtHPx1LsLQ1pL2L65kY5d0vkly20vvGKG/J
fNwcramcSMUtCJy8UhEBvIcMzxAhcBHhvkCAmLeWriVwwDRUZBiw+vzzVrxMYw/+
h8XvwTZNBNMQ1k1feEQDxeWlGNo2n1HewQ61r/ge3VTWjL9efWAjVslIMs+vfFI5
KCb5NNigStrQ7+MkXKhRT9p/WlQV+dhkRNrijMBxXUJZ5PnaTmpvF+wnYwXPekbC
3XXvh4158OywG8Xo7WOUsz+e+GmkhJUsp351dpph/J3y4qjIRApkk1vpQxouMEM+
KrWAc2L3vOtZB5u4KqST1Qqxzl1T3g==
=CLxK
-----END PGP SIGNATURE-----

--pynesepz3mktlh7g--

