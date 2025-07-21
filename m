Return-Path: <linux-pwm+bounces-6857-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBABB0C249
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Jul 2025 13:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0365540EF5
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Jul 2025 11:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54124293B70;
	Mon, 21 Jul 2025 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G6vzLZYl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB521CA0A
	for <linux-pwm@vger.kernel.org>; Mon, 21 Jul 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096272; cv=none; b=i58j7iYS0hH5PKEOwYsXwOA11Bkfo6ssgsqR+bl0MS6wcw9kiXD2DPyNdkHqezhRMUlngRq8Y3VXSJko9XI+d/e1Y+zlEq4FQkmfyWog9LwJpAQdD7UMKZYT+TnVk0KmsVU3U/ge0InJzJPFrbXiR/niIwg95lL1WLsQc3oH0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096272; c=relaxed/simple;
	bh=6+F0aA6lSTB5A6jgWKkS8W5cXN2DyWMYZgBse8oy7Pg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0ycAlkUYcdbrOGbY7hw9kFFKbzwGELR96hX1+KNGwYrtVu3Bj4Gk/iyolDnVOK9SrDPj26WuHEzoprVgc23c0PsntN1lT6ZGqzd6kns0GJdBU83JOSZrf55oaxZkZyemqR1rKEcufO/Uv2Jm5f/NnZ5cV3tPV88NmMVDa4ZvoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=G6vzLZYl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45619d70c72so39501025e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 21 Jul 2025 04:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753096267; x=1753701067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+F0aA6lSTB5A6jgWKkS8W5cXN2DyWMYZgBse8oy7Pg=;
        b=G6vzLZYlOX1qDlbq0acSel5/0avGAAZ78xaf58vHmsdNoOnKaUAoOH+Wl7wpE6dBSD
         v2RkCBQ8leyGTloZ5SwIt82sR8rGxkTuhfoU5uJJS37CmXTiY9E4vmsUZbDSENdnKcYX
         efPYnqNh9rZCEic9g3hCsiyMKiD/+hKKUev9mruIkXxNoi1Oay4VQpm5xkhChQ8fYNxS
         7JYCsr0gce24ErADoRGpthcjVe8yIclx8grPTXwX8+nKaaxFdgwbL8PGd3yDu58Mc9vk
         hgROyZokKzctgWxN6iVpxN75Fmh/EHNk5oDGUvvhv3OsU++64FYAB2M96JaK/fCqOyI/
         kObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753096267; x=1753701067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+F0aA6lSTB5A6jgWKkS8W5cXN2DyWMYZgBse8oy7Pg=;
        b=AU04jmePBmzai8hVv7kXTnbAgHZ5WfkxjTTGxBIF4QmfMrm9krncSTEKAjYpEf0g+k
         cn/FeCPVcvX4B6GAFhKaMes8FAQ+/3e6lo73G6DIvDET2LX9czepc/yDkWmw5LF6LIog
         rd+NctCi8z/MkN6WJNQFG9zcoGBig0FnehlauPRapa3bfWuus0Gdxs9qYCu3AEhqPIUi
         yPB9JUqHBxNbMS5herWmU70aSBpH5ZHgsLqXTjaIWucbLb9qFqiWaNNURhC+Js3y+TKT
         qsosJXuoUp+TGxXSKFpAek7mHc0v5EB/CGWIXfWDThucujSJqYDw0Lo0clCRePWcQNqW
         lVdw==
X-Gm-Message-State: AOJu0YyBtQeE1Mti9tnDCCEBQ6kpyPszrX/1No6+rkDOvUfIZS4LHvww
	5lWMmGaKYbZGMf5pZEeIyGODEhXMc3H0Dsfipx0CjH80yPF7PQaxgLPh1NBeqbm1QL9rbsjn1mr
	uCaS8
X-Gm-Gg: ASbGncufXQmA2hGo0WqixF+SoOM4hTSOCwky53VyihWkKU1o21kNwTlbWTnzlQaC2Mq
	8+S6tlv7gINcv1QUBD7zg+oTrq6kirf7PvJqx3dfUfuu6VED1s8bpqVanRukiUpclxBA7PNXSuR
	dmoObMgypZydG7VBW7gdpmYGd/K0e6m8qu7A/ayUiXU+jqV7P6D8ZwTzp0MM4zeBZhblnP5UCvE
	R3f9SRZGprpzjm5XfzJW/YVvvZP6gyhWi1+b/p6rW/oDGeTjeqHWSM+L+BcrydT7jmMWBETYhNc
	VDhbIQf0XagWxbVoCcMT/KtNxFTc20hVCvF7ZcxffpAu+b+0XwuCMel6bSVSjHb4g6oa3DkCRz+
	PGYU9WVUsdENas4jLbgKHc+uYd8Goyvd9UKLKNLYCi89KDBV4BMFw/9w/QIt2l5kW
X-Google-Smtp-Source: AGHT+IHSLpLAQmtEaVegY2WjXVIf3tzQJWQp0aJe3AdNFfADdPJxIAQ1SWG5/rvcyS0/LAIBmzOlGA==
X-Received: by 2002:a05:600c:5246:b0:456:189e:223a with SMTP id 5b1f17b1804b1-456347b5ccfmr163288035e9.10.1753096266511;
        Mon, 21 Jul 2025 04:11:06 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4562e7f4289sm157046225e9.7.2025.07.21.04.11.05
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:11:05 -0700 (PDT)
Date: Mon, 21 Jul 2025 13:11:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH libpwm 0/4] sysfs: Various fixes and an improvement
Message-ID: <k7uxf7fpgv5qtncnerdclycirw2qsiy6seldlhko5fv6qtssxb@6vavb574i5pr>
References: <cover.1751995302.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hortfzb5cmrefhnr"
Content-Disposition: inline
In-Reply-To: <cover.1751995302.git.u.kleine-koenig@baylibre.com>


--hortfzb5cmrefhnr
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH libpwm 0/4] sysfs: Various fixes and an improvement
MIME-Version: 1.0

Hello,

On Tue, Jul 08, 2025 at 07:24:12PM +0200, Uwe Kleine-K=F6nig wrote:
> while working on the pwm-mediatek driver I found a few corners in libpwm
> that doesn't seem to have seen much testing before with a driver that
> can only implement normal polarity.

applied with the announced fixup to patch #2 to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git main
=2E

Best regards
Uwe

--hortfzb5cmrefhnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmh+ID8ACgkQj4D7WH0S
/k7gOgf+KF216u9mMQzulSLeFfYrDs3WH1ul8h5EcHQriby691Zmd0h5WYL08SSE
tXlqgAckl8Ot6LS22zo5lKUJhMWmOpohCKYAy8IVwjOuFyd6G2G2/PD++MsuwVQA
ZkrEMuXRbXppoXaWEK1//U917K8llFCAnJIZBMZUATnxpaJsOyA9i+zFuNtOSK+I
14zuhRhohd6rSVtKcAux1Op5xzjW/XBHYJgMFN42vzs9Y3dSot9gVAnULLX0UQas
l/VkBC6ZAtguVb2V+i7rPpM39743H/dktkD+HAPAOHPIWKBR/PYGpWOZcWahYe02
CaJKzyCjHzO+VLDEwIdllJOoAalksg==
=IFLB
-----END PGP SIGNATURE-----

--hortfzb5cmrefhnr--

