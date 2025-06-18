Return-Path: <linux-pwm+bounces-6437-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848EDADF583
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 20:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3844E16C3A6
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 18:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11622F546F;
	Wed, 18 Jun 2025 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EQZjs8nJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2072F5464
	for <linux-pwm@vger.kernel.org>; Wed, 18 Jun 2025 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270067; cv=none; b=UxkOquh8veMLy6YcvJtFip0qUBEvHsLr8kRmVq4OLu5VXPhbBxuJDvz0MiRAKgOMGlCOXpNOCx8FHTAQcdmiW1CKvBf9WsbzZ2qYc+U+Swm36opt26icSC/73mbcHy8U2/HuJ7yvjCMg/d+p5Kcpboils2/g6xmLH9j5UskKpoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270067; c=relaxed/simple;
	bh=OORpbyIv7wOwpEmO2nAi9DFYlQJd4JcdOYUYd3nnzKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKZCT7QwAhQfgOK8Y8DMgriEnIdpTLHsr7Re+ePc0+QtKYUDEj7hDfAdOb4uHlTtbt+1ELEGRf8apIYnXnoUb33SSUg1404MPKk2lgE4gJN7R6wuF8W6R8nB7YaVb/YOtvLV0HF1MZxUQMFoR/IllT8ynCtTdUbiMrdE2QSijzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EQZjs8nJ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adb2bd27c7bso1077178266b.2
        for <linux-pwm@vger.kernel.org>; Wed, 18 Jun 2025 11:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750270063; x=1750874863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OORpbyIv7wOwpEmO2nAi9DFYlQJd4JcdOYUYd3nnzKw=;
        b=EQZjs8nJwxLaHdj9QUW2xw1qhApkKAfBwm1OMQc50WMvianu5HAGSZ9Udt19sqHkJe
         kRvea7IaDWNwOUi5eaYKqBY7/+FXvion6G8Y8YvwCWRJR0lvGtYyikEMWDaOJ5N/ayOF
         lBX9Gh/9put2ibE5kvPRn6YbKszROjcYaIAde3aoiVwX3L5Qi65kyO5zMRouj8dtuyqS
         kqV3IG3UpMQY8xlMx1kfYi8f1RS0epvOw4YDMoQFhOWZZJ0lc11EQw7JclvrRwGQdlMu
         tyP8FCu5uYQmkGIu8klCRdWnybqJly0KdnlukOn0c2by51YPY8m4juCIDZ/2q+T/EImn
         Veug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750270063; x=1750874863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OORpbyIv7wOwpEmO2nAi9DFYlQJd4JcdOYUYd3nnzKw=;
        b=QJALG4Xq/By4m/cmi75DysiHwS7maExsDv9j3dWfCrAlIvEx/NKlQSlaGbt8H9EgzA
         qt5YUZdRf0d7oSMeA6BmKTXnePncSMCujS5iyrcDWWxuceLk4S18HEKVERMmuZj/KZ1J
         0nQ2F1SIHtlm1Iw7Vl6VuI49lFDP8s61U0fgQIakvNXvLwt0mhO9YSN1SfvtrzxFvlYx
         6FcdSAajAqYP/DT6wtZ9GawZTMKwbtmhMnL4PHVlNwDl+71YjHVkaHNCxWdflKYsfzpF
         /nGEyO/Xw35JyA+VBePe/N+LpNiUHRx+g7s8XifclFzWdhwdvdJV4FmrbReYep1zyTPD
         lX/A==
X-Forwarded-Encrypted: i=1; AJvYcCV05lsF2Qdbq1UqnAHUA2W0GzYlgsGZsjDszpPMUYsLrtOX/gG9e65yzApt4sN9X+iNTKu9kMEkSQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvBN7SL+Bn4qhiRyARp3qetqydO4GwtkmASXJtVgZEgAFQqYqU
	s2kk/fOx+5mQlvmhM6blDHWqS+CnmxUGm9U1JYZ6lRDh/QQuzMv47JCO18/eHvt9xzc=
X-Gm-Gg: ASbGncuCJm/FqEM8O6GHuS11/7vkejmIQZnS6OchdaC9ES5/dxGoIpk6QL+ZcEehT4o
	chwOyk7X0K0PQ5EaCXje9UntvdbBL5fv84veNf2NUaD1Uv/EpUXqK0vy6w+DloVKE+E9ThVVDDp
	iHUYQp/AqPBaF0Ajc6V0Lyz7wwS8TJadR36vfNqQwhQYwhpK4pFNTsH+X1b2n++pl1uOioxnbQR
	f3T0Tyon8V3miL3f0L+wOg8XqA8yFPIa3RNK8so+bJzYzXgldO91twkoNhdW8IGRZxubkOrvOsr
	VUoG1wdGihmHPNnD5nnE+XydBXwxZDhlg7mhfvBS3q52mJLLp/XaoXS223E+WE0SoWw+/hBWfjC
	vDCSSSEDIc2a9yHD/2oDu9pMftUPe
X-Google-Smtp-Source: AGHT+IEN1axOTTyGZ+47pb4M7RuhULwD+cCfnYhjQipu2S+AjBZym/amFSpaw9xH663+D6RVqndEcw==
X-Received: by 2002:a17:907:d86a:b0:ae0:1dbf:32b9 with SMTP id a640c23a62f3a-ae01dbf4305mr392573466b.5.1750270062644;
        Wed, 18 Jun 2025 11:07:42 -0700 (PDT)
Received: from localhost (p200300f65f13c80400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f13:c804::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-adec81c1fc2sm1096774366b.59.2025.06.18.11.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 11:07:41 -0700 (PDT)
Date: Wed, 18 Jun 2025 20:07:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/4] clk: pwm: A few improvements
Message-ID: <du3xj5fkhw55oppor3feyk4pgchprcog2ew2epaixhsvf2e2sm@humm6imft4sp>
References: <cover.1746006578.git.ukleinek@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="djs46wk4reaxddc2"
Content-Disposition: inline
In-Reply-To: <cover.1746006578.git.ukleinek@baylibre.com>


--djs46wk4reaxddc2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/4] clk: pwm: A few improvements
MIME-Version: 1.0

Hello,

On Wed, Apr 30, 2025 at 11:57:45AM +0200, Uwe Kleine-K=F6nig wrote:
> my main objective here to get rid of the call to pwm_config() as I want
> to drop that function. While implementing that I found a few changes
> left and right of it that I think improve the driver.

This was sent a few weeks before v6.15 and it missed the window for
v6.16-rc1. Is it only lack of review capacities that there was no
reaction yet, or did it fall through the cracks?

Best regards
Uwe

--djs46wk4reaxddc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhTAGkACgkQj4D7WH0S
/k5Z0wf/Tlso92kkFmYl7I0XH0zZ6HdaBnkGzptHXaL8Pa4NxqGBmLEXacmsOWgm
5p0F0KVYwDJ+dbARBWj6nZ51WSFL5Gec4SQ6qlD3u70cYux8A5NwlLkV3LnW/GUe
4wx1XJijZM+p9hZAznin8V7r31SGH4wZk8dEuAvH9AKvEy4DvHPWAC9JIWUcc6Z2
+rRaCWZ5aEnbPuml5e6tjC0oRhwmkho/e8b5Brn8VF7Grz7WT2rmFzJIxj2iUHSO
RxQXc5Rz1obXSeXxz0l/pmlXiifrFreVoz+KJ9DCKhfjB3afNxbkzfdyvU0ufrL/
iVNHHVXnk0+pXpARy/Dlq386kLQsnA==
=nDTk
-----END PGP SIGNATURE-----

--djs46wk4reaxddc2--

