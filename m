Return-Path: <linux-pwm+bounces-7432-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D85BCC87D
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 12:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF2AA4FD16F
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 10:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A2D23E347;
	Fri, 10 Oct 2025 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDsHwdR5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579C828314E
	for <linux-pwm@vger.kernel.org>; Fri, 10 Oct 2025 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091982; cv=none; b=sTdV8XdCwPntXI6RZerDR3M49odGaApW5Q0fV+ZHlZO5Rot/tBhSyVDSkxvlLvl8j0I7RF58g93V6LdWdIKJhRn7SrBofMyJsicZithrC5qb42uxdfIrlAEJY9KGyoLpq9V0OWh1B/QaZ4HkiVEExU6hU8fNFKD3Y+GB3jXBTsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091982; c=relaxed/simple;
	bh=UZmabyKdE5tjxeLurwM+WNImkK1c7Yg2W5nT2vOQv1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iARaNftpeELK3gwTZuPtrbFXUedLiRjb6z5IMnSr2qz8gfRaqlZ+XkfoKVrzsfBx8NGwDpa0ZG4iB0W5pTzEcW9t1VZCnr8A9bq51Q0jV+t7KJFEfFY/FjbrP/DjLAvNMkxge1WJUbP7XBPBT+phv9z5RwhVtMR8phxMUwS5sno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDsHwdR5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso10816645e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 10 Oct 2025 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760091978; x=1760696778; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f/wisNhEkDXpBQcqt8JCgArlMwsFd4AUx+Hr46blXNQ=;
        b=PDsHwdR54OO9tlib42tw3IE8/UvRcqbubU3CPBKs0Yhce+tQQhWHejZx+UuoHdSJvv
         J/a431/rSq0dpGPHuoyWYNatWzdZhuM6FGw8xAu3m5ML75eVU7N3Siw9i1N6ubKmLdF4
         CUAheqS2osgslkmmX06v2pbykLEY32hCuHa14+2IOPv7VZs63CQQHAIYj1+U/7lNgWGD
         IzCaF+yjkA4iqAAxVpygdHGvrsEpDUt7AfKS0J667A6tv4dNzXYYwqljzxK9+1eCDwIE
         eJRqfW+SpJYa/LQngCLAXxGF8B+rTwKE2zBze3OZ8R5/ztOo49g9MG4IO0ndLWb6W8Ao
         QdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760091978; x=1760696778;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/wisNhEkDXpBQcqt8JCgArlMwsFd4AUx+Hr46blXNQ=;
        b=izC/krADMDcQugIj6d6e8AOIvRYdHYbiWnMUtXyn1u+sAqWwFjMF61LBLtvZRb5cBg
         idU5Frz3Mr+PYTTVJd0wlf4vzHhtzITW9B0Z678f/gOYCFSfsLrT2ZC4DCwDRTO4oiLE
         nGLsoeVfcrC4q7T18ROA0Ronyv7PDSMGiqy+/sJhaxApSFrw0xVMjZ6LzJY7A/XqMQ7I
         2P9/3knmKKXL8co92mfIDPkqmshKGoru7g+sp9/69PDLiL3iliaP2kEVsQCYuaEFQMS5
         btGdm1oKv7QuF1KP1TDk2gse5NiG93Eo4xktXvIRN20yOiWemSXLxFVTJLJJieR9kY+h
         DXMg==
X-Gm-Message-State: AOJu0Yw5LWFOuZfpg94RrrRTPa0FgsFLIhWLweG/dzQ2Z8asEjbTE+ED
	1kfYhpenNGn2ds3svjTXTgLj+ZTIPDGzst3Gmd+LjWHLrAbGqTIGWXe2
X-Gm-Gg: ASbGncu7CbNSKBfg0YHxCr1tvZ2An1BQAO6MsbfVmbJFUl8vhP59VRXkCSL3ieewLPz
	7ac9ib0uCwLUHLfy2sstRO3/cc4GJ02Eq9V/0xaKS3wCVMQNNjuf8xXY70gIYiXIZZf043juNED
	snR8kI2WTaVuCxIUqARmQVbvn4k79V5+6c/ctIVuDFXJvJRwwoMtArIFdEQVp+WQn5wbzADpdz2
	rNAX12Ak2v7isgN723GSLDcl9gQ0fzGfHtpJWi06WqEYS3XR3QECkObPQ9Tg1/adJolTuG4YhlS
	pJJ4Eu/LL7q8Pmue959AIUwdUtGHQvXS/Hg3E9kjcUy/6bjYqe5jNiiW4OUxt1mEVIiUy2duy96
	iymFV+Nm0cGPYlCAtvXOWwwwU9MBaR/p8p7xmXIacnVyYXlNfNrUhoEbW5lFd
X-Google-Smtp-Source: AGHT+IFHf6TeR/NVDH3cfePc+5+edkwy9xfRhJNNTE6F7bdfomvn1olhA2eAJQ6y5FxO9DrlPYYWXg==
X-Received: by 2002:a05:600c:6287:b0:46f:b42e:e365 with SMTP id 5b1f17b1804b1-46fb42ee3f5mr22514855e9.39.1760091978348;
        Fri, 10 Oct 2025 03:26:18 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57cce5sm3633649f8f.1.2025.10.10.03.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:26:18 -0700 (PDT)
Message-ID: <2e82eaf275b5c8df768c8b842167c3562991e50c.camel@gmail.com>
Subject: Re: [PATCH] pwm: Declare waveform stubs for when PWM is not
 reachable
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 jic23@kernel.org, 	marcelo.schmitt1@gmail.com, kernel test robot
 <lkp@intel.com>, Trevor Gamblin	 <tgamblin@baylibre.com>, Axel Haslam
 <ahaslam@baylibre.com>
Date: Fri, 10 Oct 2025 11:26:49 +0100
In-Reply-To: <6v4hny7hxjsdf6zvinhpagtbhluxbd6psq7wpx5ls6zdbnjtym@lnygnkav4ewk>
References: 
	<1ac0fc529e02744aacfcb9140ed597ff60886f39.1759873890.git.marcelo.schmitt@analog.com>
	 <6v4hny7hxjsdf6zvinhpagtbhluxbd6psq7wpx5ls6zdbnjtym@lnygnkav4ewk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-09 at 18:53 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Marcelo,
>=20
> On Tue, Oct 07, 2025 at 07:19:38PM -0300, Marcelo Schmitt wrote:
> > Previously, the PWM waveform consumer API would not be declared if
> > CONFIG_PWM was not reachable. That caused kernel builds to fail if a
> > consumer driver was enabled but PWM disabled. Add stubs for PWM wavefor=
m
> > functions so client drivers that use, but don't depend on PWM, can buil=
d if
> > PWM is disabled.
> >=20
> > Fixes: 6c5126c6406d ("pwm: Provide new consumer API functions for
> > waveforms")
>=20
> At the time 6c5126c6406d was applied, there was no user of the API that
> doesn't depend on CONFIG_PWM, so I object adding this Fixes line.
>=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202509272028.0zLNiR5w-lkp@intel.c=
om/
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Hi Uwe,
> >=20
> > This is a fix based on a report from 0-day bot [1].
> > We need this for a sophisticated IIO device that makes direct use of a =
PWM
> > waveform (in addition to indirect use of PWM through
> > SPI_OFFLOAD_TRIGGER_PWM).=20
>=20
> Does the driver work in some configuration with the pwm stubs? If not,
> the right thing to do is to let it depend on PWM. (Note the inverse
> isn't necessarily a good idea.)
>=20
> And I wonder how you could even compile your driver without PWM support
> given that it selects SPI_OFFLOAD_TRIGGER_PWM which depends on PWM.
>=20
> ... some time later ...
>=20
> OK, I tried to reproduce the problem that the kernel build bot run into.
> There is a warning:
>=20
> 	WARNING: unmet direct dependencies detected for
> SPI_OFFLOAD_TRIGGER_PWM
> 	=C2=A0 Depends on [n]: SPI [=3Dy] && SPI_OFFLOAD [=3Dy] && PWM [=3Dn]
> 	=C2=A0 Selected by [y]:
> 	=C2=A0 - AD4030 [=3Dy] && IIO [=3Dy] && SPI [=3Dy] && GPIOLIB [=3Dy]
>=20
> This is the thing that needs fixing, i.e. don't select a symbol with
> dependencies that the selecting symbol doesn't assert to be fulfilled.
>=20

Agreed. Seems to be one of those cases where we select a symbol that depend=
s on
something.

However, this driver can indeed work without spi offload and hence PWM and
SPI_OFFLOAD (AFAIR) are optional so I wonder what's the right approach. Loo=
king
at the new series I already see:

select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM)

Which makes more sense but I guess we still need the stubs with the above. =
But=20
I would also expect stubs to be needed for spi/offload/consumer.h. Maybe I'=
m
missing something though...

I did not tested but I also wonder if 'imply SPI_OFFLOAD_TRIGGER_PWM' is no=
t
similar to the above.

- Nuno S=C3=A1

> Best regards
> Uwe

