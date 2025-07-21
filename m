Return-Path: <linux-pwm+bounces-6859-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92597B0C84D
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Jul 2025 17:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B5D97A2277
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Jul 2025 15:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D3A2DFA28;
	Mon, 21 Jul 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2hyC3lHm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911CE2E03E5
	for <linux-pwm@vger.kernel.org>; Mon, 21 Jul 2025 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113397; cv=none; b=fKp/kGkAYLIOExLDjMbBwKdBT/8Gc0rdVLj41oQ/UOnFVzx2+CdkgMuea5SIFhHJ7B65O1d23OMt0b52oc4usna2KsJr1eEVqdq6RL/Qn6pOwdDnlQXhgYx4fvUV4hxiRWKOF4NncS/4Zwe0xv94rjppLlx3l6O4B8DXMytFzrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113397; c=relaxed/simple;
	bh=Y1Txmm2yTjO9UOxF+1gOFlDsO8QUBUF3nY6oNfYmY5Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gUr1MT50rpY30RZgwO6+aOJP83PZg8/KbZOf5s4DHgch56nwUiwLbbHqwyiAnM5AvwS6BqnxP2+3+HZskvXsp51NaW5f51YfVLqJCwM8diZyi5Ud6U+KjuKr9tT/CyCK+d+8H9IQatKbmAhzivrjDojl1jq4FncqnAhYIt3SXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2hyC3lHm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af0dc229478so90494366b.1
        for <linux-pwm@vger.kernel.org>; Mon, 21 Jul 2025 08:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753113392; x=1753718192; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nj7gfbQW2F5r8RqE7JtKaNBSJecKf57CYR2AWZIqgRM=;
        b=2hyC3lHmynYaNjlJM/ZvnNd/XNiVumBjKzLomuXdEessygpNJYrCgw0EzxQWe+fYln
         FEc+DgSt0xNk9cFW8F2zGYjqDfWZJ2YQGqVc0Y7IMJdw/PhlcUwaV/dyTCXoobo7Tytd
         sEEAoBXmnuTp5x7vz31e0kOnGXBRKxxsdVcmqlQfsb1FVm1rc+CgL9Z0skWYmQsp2t19
         im/Mfu8kdOGdi0PUx8LbKeUG+6gIsNnkSbGkmcqim1NNGQ7tARf4tMCPzoSp3UXrhhLo
         As817CEOZPDj5Nsi+OILekzKi63HMxIuu1XIRAyLx8wynq28siP70Z7Xc9XPDfdgLqAF
         6CSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753113392; x=1753718192;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nj7gfbQW2F5r8RqE7JtKaNBSJecKf57CYR2AWZIqgRM=;
        b=NpoxEJLVSj/MHhuNZskyGIEBckUp/9cQuB6y8EbMoUa8w2UhypQz8NIGjFleHlWLjJ
         dD8GxogibGehLYY3006hD5CG+MCR80nNAQWrNz8nAM9Zp9wqNjkKbQ0MJTS4DKYzBt9z
         pAKpot+0rJtWPPKrLdB0ISs1hkIogPMEx7bTrIYJXC8U43Z2R8JrWP/QYE+tuR+sOnoS
         SBk3RVx92sH7gn9a1xJhC6kXVZZWW92zZ++ntkw8N9wtF7BBDETel8wSBElMNqj+XzDr
         YSPVJXClnxk4ppis4V7zxl8mUAEOXrNh9FQq2zfID/GTKAGgQQFZj8L9l2nLkMkLuuFn
         A+Uw==
X-Gm-Message-State: AOJu0Yx25i07tsMqpCG2v0MJRPNdQMQ+HVqDGqf3+0fuL9mC6z/fCsqf
	/2veE/smuXltoB6wn2DVB2N1/IIpVCvwM/0cgFNkc2SpTiBRopLrrCmh6wrkqgOjYQEAO8Eh7Tm
	pSjo5
X-Gm-Gg: ASbGncubAXIDDbxjP1hYupX22bdzNd0W98Wx2jPFs0hOYuma40vY0sRRlF8ZPoTI9Fh
	B7yf98uip+dg7PAwYAv6qoYqKTJrKOX7OyrYjc32+Sdi4vIOeHxlUeJbFiCMzmac5rKYwFqLyo2
	VLCsIs0Sc0CZC8gqR/qmadEzZeZ8rxoUWUpLximHTqJvGudGvHOSsuo+Lfs1ayjj6ocBNMEo5jU
	VmTZVfbBBJOdDxVwOSouUynOQOeErcHuTOhvXfBQ4EETic/JUSVRk0U/xviNGqY2Py2jAFgdhHy
	5UkWIehQ2zNrGF0bzUCLYll9JwRljqVEEo2d3LNXTb1NM757QPhwKrp9vUgcXNJDaRHzKEAetKO
	YCrll1+dGeYWBdN7QSW4z2p6fEPRu4E/VBmnMD23lU0Kp8TRA7Z/wEke24deHn45q
X-Google-Smtp-Source: AGHT+IE3CWdRfGfJn37WiWwV1ESiyujicTGKtZKnqtZi4X1wTeLtRsn3bp7hFaMWgWDT5t6TivEbLg==
X-Received: by 2002:a17:907:7ba9:b0:ade:8720:70a0 with SMTP id a640c23a62f3a-ae9cddfe622mr2071518166b.20.1753113391585;
        Mon, 21 Jul 2025 08:56:31 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aec6ca30005sm698990766b.74.2025.07.21.08.56.30
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:56:31 -0700 (PDT)
Date: Mon, 21 Jul 2025 17:56:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: libpwm 1.0-rc2
Message-ID: <kirjpf2iuf5h5ij2kntddnv63ucuffvnzywcgst4zupqh5kldr@olanenwsfbzg>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b5u2c6mj6knslcup"
Content-Disposition: inline


--b5u2c6mj6knslcup
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: libpwm 1.0-rc2
MIME-Version: 1.0

Hello,

I'm happy to announce that I just released libpwm 1.0-rc2.

Find it at

        https://mirrors.edge.kernel.org/pub/linux/kernel/people/ukleinek/libpwm/

or

        https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git/tag/?h=v1.0-rc2

(both signed by my PGP key).

Compared to -rc1 it contains a bunch of fixes and doesn't depend on
recent uapi headers to compile in the character support.

Also in the meantime libpwm is available in Debian unstable. It
currently contains the -rc1 release, but -rc2 will be there very soon.

Please send negative feedback in the form of patches ;-)

Best regards
Uwe

--b5u2c6mj6knslcup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmh+YyoACgkQj4D7WH0S
/k5+gAf/fjGhd0fXMp8ce4NryduzK/itwcWtGbQm1BEt7QJvF2+dlbZexsKLWfCD
hds+SnpdHeVselz3Ovb7a6/E7t0X1VKh5lFZy51YBdgwHaK08ndTD9u52wH8Xy2f
06DiY9nk42x+iieMHX6KVoSznt06SrVd+r7GOwaW4OozWG3GzKCt/yDm4xc5IBUT
Ecj5QaS5XZqvT9s8wP8csSncFaCKqqRjETG9pxBTVx9nzyr6Qb5CaRUjFYbN1P0c
xTvK9noNnct3ZwWaZi/xJSyHNJAbrXUbhwPPKF8EFgdkStnKXJLvZs4BH+24yh6g
Y18b3pTH5EjpCumBpCKKNxlpHlrnDA==
=BQ9h
-----END PGP SIGNATURE-----

--b5u2c6mj6knslcup--

