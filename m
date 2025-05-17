Return-Path: <linux-pwm+bounces-6006-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DE0ABAAD3
	for <lists+linux-pwm@lfdr.de>; Sat, 17 May 2025 17:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 221867A8744
	for <lists+linux-pwm@lfdr.de>; Sat, 17 May 2025 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184D313B58D;
	Sat, 17 May 2025 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u4yJIkmY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130AB202F8E
	for <linux-pwm@vger.kernel.org>; Sat, 17 May 2025 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747494602; cv=none; b=BeeLALvVlI9o7FgxLOeqvKDaOiW/tRx8TkE9H9WWwagALGVa+8uuMBz0anTSu6wFBFiRq1qpr9wz9flGve/4j7iYfCfAsZMp20xiqpQmHOVWqPgeD8H3VE1vfb8Mk6Vd1zKJjZF4NuZLFgHLOFpk/951mJ6iuDyQbb7Oe4/jbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747494602; c=relaxed/simple;
	bh=/YB6nBU2koYwIVjJsNe7CtOo8eFh3bzrCYrwIZg6YK8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si7bBSX4ivo+L7NVxgiyzYq92ExxHT9H5nLFCicEX7JolkAQvCy/Kc0HOdGS62jPbmJ0f+CTahvqAkvlfSC7hfwzFDmLACPb1EJ/3lmKWxGXUh+BK5lrmGHr87i+8Y2EZtWG1PN3vYao4ATSWN/AYQq8UEp4LpC3bA+aG8J9JGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=u4yJIkmY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad216a5a59cso433591966b.3
        for <linux-pwm@vger.kernel.org>; Sat, 17 May 2025 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747494596; x=1748099396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/YB6nBU2koYwIVjJsNe7CtOo8eFh3bzrCYrwIZg6YK8=;
        b=u4yJIkmYd9UfYuikTm36ZtKiutvn779SVPGkMfqA947eysWNz68UGjsy+cVfj+glQ0
         CTRUOlxWTdVU/rb0gbxzo/Ip20ZGT6QiVh13OGNvvnF8sXhuZQJuF62VuaiDDU8IvJll
         Ym2Zxk4/oJekc5ekrGAJW/0OSUPQy97bh1W6D1gni9SVIqLy4xbuVFGylUMPClwGiKeB
         wzXrzZFe/kEJtFsRUvzw20PFuvsaNIneLuny9kjKGRF4jyCIEwojGznqW2wZmmefEmJj
         qDJgsVHOdL4Bq+gG0zt6+uoL8izVuE8agqKb9soPLRzQFmY0YgYFoc6IdN4iaVIBu5Gu
         ewcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747494596; x=1748099396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YB6nBU2koYwIVjJsNe7CtOo8eFh3bzrCYrwIZg6YK8=;
        b=HU7N5qKqbN55X6KLGRMdan8uv6DAclsBgsxOLnSIQbZbzEL+1f1RjF6COUs+uH3yJ7
         /rR79ewVzIGC0nkNEGKSEH6kIkAC8RluBei05nu7ZQBf99x97ziQq9dYGPFlwSmUQO3w
         jB+i4jIa3gcnYDYhvHqWsLellexCPPrxTO3Tq0kK2aTDXLIW/GEB580xjWlixFaUrDwh
         x76cVf8cXbuWRn6kIw2kV/aCc7HFx72B83cBAM3b0twhIUIzTIyEWbdLYhuH4o4yUsnM
         zgrTQxIZuwMmX9jjPzaj5Sj9uElvW8vfzNfsQz8TTRldQ/WTis3o1ZnyvXhkgRt2tfPB
         C5zg==
X-Gm-Message-State: AOJu0YzRNTHM6EDLrpsAoVB1WoyDAAmR5yshmSKs2uuqfcdMIgoVNF34
	y+WDEFvwF2DuVCl7OGtUZt/pPOx2EjF5eP7cf8YopoK6AlwSUA6pTGJumGsz8fBmO6YguZzgPLs
	vHTXF
X-Gm-Gg: ASbGnct19XTZfuGFmrWphxqYXavCQXGsXXM6nt+eSLGKEPO9SUwdH9/+agNo7INJVPZ
	ukuRQ2xHJZFQFXhIkrvgqyMyN1R8NVxOjuPJj8ucC8zq/rOybyPjGSypuaoJyhZYDzXe26uHx2O
	beJfiEFJoAyr5S9MSsQc9SZBFcwaOe5rarDLWxbzT0Crrda+VM4rRDpXZbrDuCmdxvaOs0fvbAP
	sRuvZOtjE7n96YvfljiLRkQ+nsUR1i+P4VfeUPpytgxiuj+SwcVajQlzphIIlg7TKoEgYq+6+tM
	xRqK4OYpE59Pjiiu6vzApoU3AtTGuv8MHH5f+K1FclxiDsVWQcL2VNJo
X-Google-Smtp-Source: AGHT+IEPDot7oilxImzc3f7JFrIXbXecfw8DeNGhHo4Ao/eczO0Wh3Cjwm/z2X0AvdZ6gxBNKLjmBw==
X-Received: by 2002:a17:906:6a19:b0:ace:9d35:6987 with SMTP id a640c23a62f3a-ad52d441f89mr643002466b.3.1747494596014;
        Sat, 17 May 2025 08:09:56 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad52d49886esm310695866b.144.2025.05.17.08.09.55
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 08:09:55 -0700 (PDT)
Date: Sat, 17 May 2025 17:09:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH libpwm] sysfs: Complete cleanup in close callback
Message-ID: <d43ud4caxnkmq3ubgl2dphvg2c7jpqaba7662phhhucwrnlnls@b47akgwckkyk>
References: <20250516191536.1353824-1-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sfluf6adckco5qhi"
Content-Disposition: inline
In-Reply-To: <20250516191536.1353824-1-u.kleine-koenig@baylibre.com>


--sfluf6adckco5qhi
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH libpwm] sysfs: Complete cleanup in close callback
MIME-Version: 1.0

Hello,

On Fri, May 16, 2025 at 09:15:36PM +0200, Uwe Kleine-K=F6nig wrote:
> Unexport used PWMs and close all open file descriptors.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

I don't expect review feedback, so I went ahead and pushed it out to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git main
=2E

Best regards
Uwe

--sfluf6adckco5qhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgopr4ACgkQj4D7WH0S
/k4SBwf9Fzp6yKx3ya7rh1RVMHkAwJXcUrD/ppYRY9m2QCRexpD78sa1HQsmZ19B
nV4Bq+72mnX3sOreoDTXzytVFKX7KU7R8k/TVDT3htE3B0GZaeE2LKtzbVWmKDYB
WatHMaPZMc9WBFlvMf6My91fCnft0wTHo0B3Ict0dLSqHts1yvGxobzOI0zYdTtE
p2CtbVvC9svBntMzWQOu+o7R8MaJqEAv3BqMAH3FhDF1EuhU4IS6v0PqD3rjPHPc
BomdHixeb/Fu4RWbsFOCsXXH4BGpOwYk1g7U0bHpXNo+Qug6fllLay9Xe+FySNLQ
YfQZYg7wI2aJMczlwXXUfhVzQsgnsw==
=bEOK
-----END PGP SIGNATURE-----

--sfluf6adckco5qhi--

