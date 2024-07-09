Return-Path: <linux-pwm+bounces-2738-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B559A92B3E6
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jul 2024 11:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8A428146B
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jul 2024 09:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CE914BFB0;
	Tue,  9 Jul 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw8pftww"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1E6153582
	for <linux-pwm@vger.kernel.org>; Tue,  9 Jul 2024 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517603; cv=none; b=cUU48HFK0wJWF4lp9cbrlm3wpQwSGkVL35pBh6KahGthEizc8nMrTE/D1OS3No0Jq7f9kEXdMVZnW6wsSVXlfibSBfM01oHmySu7s9LTRp+3hQdMuLnoFs0r8zLhfv59wGlrcy2sCpEA621oKFexZJw5enkrOFEBG83c3GjLZA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517603; c=relaxed/simple;
	bh=2Dv/HXa4tu3ES90YGGfrQdJ1WgZFYtmB/QWSg4nC4pU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tHNeuGClTgLlmd7q0MH9pYbCYjkbhlZeE0V7Xjh+Abgf3z49acXQ2p9B07YIJUGjtj/rHBfY8AqQhFxzBOOZtW3uJC84xsJDCIl93T4TipgHN8VxS2R/TYCR7dyK3BaLAcv0aS4l666iuUdUOw+g6oAaUeO3sRv0i/Q6b4xvvNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw8pftww; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36798779d75so4326762f8f.3
        for <linux-pwm@vger.kernel.org>; Tue, 09 Jul 2024 02:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720517600; x=1721122400; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrAV5FP6mpmqfMuaOax0m60JFOumBPDoV6/ZNX+4Nn8=;
        b=Qw8pftwwjXxaM2ckwu3K+/2nwkof0UpdwT4U/EtveVz/PE5KNledMViz4srxxz4YpL
         cxWUItL3bYPMOG1xxhOMJNNluXnN3bSFgv3maJZUeqb8H58i5DwtsnGUE/Ki17iXEOVJ
         o8kIti4exsln47QLCNpIKcj+fDyp63QDgAmQYRyCWeqMuLBpX4cI7c5WSU7VaGpfQwmT
         cZhLJ8hV6s3TtDiKJ1/7gHhazaOp47QQM8+2h75KZKlBAD6beeSIVd0FkZMDnhejrdqP
         ms5Y+U1k5XvoFhJjnOf1mRqoMDwAut/MEr0JNV0DkQn8yU/Av5Zv0fJc8Yj3avbd3azi
         OqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720517600; x=1721122400;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KrAV5FP6mpmqfMuaOax0m60JFOumBPDoV6/ZNX+4Nn8=;
        b=ZZShk8h43MuiRmJmBYwuapaKanjELTMqP7u4BYtWbv6cfXkIyrLGDAcsRkOiNjWC+U
         W8qEyVdVBDXNswl1MDf93R6SwU8xl0T0iLIGgQFUeLsg3aOPp+GKsQ6PcvynRYVFQw1h
         vRlHBzM/ir8II3lH0+7kv6q1PPAdQXgSqf5nMSfv27Z5WvPUW9B63lsi1HKBQzsB995/
         45aFyjgEd7WRiaVBdzWwPrFegiyvzw2oKlfydQJ5mWvF67hSr8mqQcg3bNIluzwnXR02
         IlYKofqnXVUlidBjCMRhtroA7KLJzV2/TAUpowXsa6BfHSTbiaASUr/LenWPRFUZFzyu
         jAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZR/Cf3QUo6J0G7brZgBNKvYLrAAQq/p2M3BZNdxEkybO4qOR1LFGlCCeleKgKj4d1xbDqqB9eNDvzKafkgAoUBjsWKsYd9Eit
X-Gm-Message-State: AOJu0YwkPHWIZq4noN40JN16v0r4i6XzHEiLiV+X5tdnCsweZ+dksxNE
	mGhlhg8yRAtR5cO2m/YipjM/MmetsM4PIgPeKiiXpv9CxPX868FQ
X-Google-Smtp-Source: AGHT+IHjs54FJosOI/sKErGKVEGc3++IcZjiPsOyJ4qGvD0aH7BXuokChQT09EQp9znzBW57vKSX/w==
X-Received: by 2002:a5d:4e46:0:b0:367:8ff5:5870 with SMTP id ffacd0b85a97d-367cead15f4mr1503258f8f.47.1720517599413;
        Tue, 09 Jul 2024 02:33:19 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa06b6sm2001271f8f.86.2024.07.09.02.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 02:33:19 -0700 (PDT)
Message-ID: <86fdb6409c8f439bf75d2ed31d1031fb910aa435.camel@gmail.com>
Subject: Re: [PATCH 3/6] pwm: Add support for pwmchip devices for faster and
 easier userspace access
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-pwm@vger.kernel.org
Date: Tue, 09 Jul 2024 11:37:13 +0200
In-Reply-To: <7490e64bbe12e2046d92716dadef7070881592e6.1720435656.git.u.kleine-koenig@baylibre.com>
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
	 <7490e64bbe12e2046d92716dadef7070881592e6.1720435656.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-08 at 12:52 +0200, Uwe Kleine-K=C3=B6nig wrote:
> With this change each pwmchip can be accessed from userspace via a
> character device. Compared to the sysfs-API this is faster (on a
> stm32mp157 applying a new configuration takes approx 25% only) and
> allows to pass the whole configuration in a single ioctl allowing atomic
> application.
>=20
> Thanks to Randy Dunlap for pointing out a missing kernel-doc
> description.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

I didn't looked very carefully at the patch but one thing did caught my
attention

...

> +
> +struct pwmchip_waveform {
> +	unsigned int hwpwm;
> +	__u64 period_length;
> +	__u64 duty_length;
> +	__u64 duty_offset;
> +};
> +

I do not think we should have holes in the struct given this is an userspac=
e
interface.

One other thing is how likely is this struct to grow? If that is expected w=
e
should probably think in adding some __reserved__ parameters or maybe to mo=
dify
the interface so we could make use of:

https://elixir.bootlin.com/linux/latest/source/include/linux/uaccess.h#L348

Like wrapping struct pwmchip_waveform in another struct with an extra membe=
r
forcing userspace to specify pwmchip_waveform size. But I agree it's a bit
awkward and ugly (but it could be hidden in libpwm).

Anyways, if this is not likely to change disregard all the compatibility
thingy...

- Nuno S=C3=A1


