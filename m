Return-Path: <linux-pwm+bounces-2076-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7151E8B0B95
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 15:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E37C286ED3
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0687C15E5CB;
	Wed, 24 Apr 2024 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L0ACVveM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129DA15B99C
	for <linux-pwm@vger.kernel.org>; Wed, 24 Apr 2024 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966879; cv=none; b=PhtCjGpbZ7FkpQo+u1CITqjyt/CZWX8BT0ajq5H1Uj9fHxcp5GWDRNuJ0ZADOYKo6sCXExByzotFYii/2BgZZJKz3BUIe9cvH/ZHJmalXQV5fa5eOKhDMmdpJni3XeKH9/VfGkL4++tFS5DXcam3DfOEo1FyDy0dEutefXhs50A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966879; c=relaxed/simple;
	bh=Mx2OfLd2q5mi0gURFw5TuMXcb1Huqn82HNjl8eR3ylE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=uOWN2Rl3wonOIHUhn8j2ApV98PpddkS65yXptWpbXoERKwS34ycgJg4okBNkuCTNxM/BvOcQ4GENjTnSSAQ01X8vNI62tZxXV9xUHV1C9sO+593axoqlCpFr8gS7Ccb48ZNle23NbGP9r8pN/fP8M5k1d/ARocT3NDXfFuUmHN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=L0ACVveM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343c7fae6e4so6071318f8f.1
        for <linux-pwm@vger.kernel.org>; Wed, 24 Apr 2024 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713966876; x=1714571676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqG6EAw4hfK6YDk87ISdjEyvEY4/LHJcMlZc2x8R9og=;
        b=L0ACVveMqoyPVa55/eYySBH0vg1cRvHB0FzATMjJfL4L8G/itIj1gx84wFOhHK5fsy
         1kIusoUJzOVAjlq8loXdVj+gnHpN/PQ3wePt9A3isf/yQshQgJebG/hqGIIWGf0smfDw
         rDsjkKnhtqziSJp9TBqYeVKFn+Q8aMKxtT0bgjAw5dQhouNrA4MDO/z5Vw9a/DWMjIsw
         0sIlEc/nielh4J7AjcqxmTLfJMzGanK+AwsqnBEOBMaKmHZ4AYg5TOt1ZMmXB/iypt9i
         BuyGEVzetxj+xkpfzoMkw7oCaL5h5PlO8mZhlx34JrQLQ3KbueGAiC3uGzRf7o5SfKu8
         yfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966876; x=1714571676;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nqG6EAw4hfK6YDk87ISdjEyvEY4/LHJcMlZc2x8R9og=;
        b=Zx9RXbnHLWFmvoieJ+3Y90HMbREDH/C8/fS8S3pe/eL4m/PaRzyPiL9wv6JFfxAbqd
         /RpQJs7Go/Ypp407sjQrOVOZGwBnCJGqNk+b/airKuDxmkPi1bqawO8darIAnwX6DTsY
         uMfb8y7FrsR1+u1uRw8WX5kDxFlO7PGl9JJ07ATPIvG+/0a75oC76c+ZKBMaGj0nlPTl
         P9I2J7tfoxvUDlVIYjS26fEBmVLbOFeC8Led0GnZUZrUCjgm3udpj0lwl4NAw4f/RFfI
         zd3r+WNYQmDYEO54IYHMGwG5OGoqZWbgFaeWL+tkBnDzDCATIUu8ElfSgcOW6u4cBn7W
         k3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv3eR6Di4SVZMsYBjElsyCZX+uVjJpv3KXEMSrIcDTKThfMaQemGc9pVoA9ZKO56tvclmU3F4QXelPzJmxMLXaBTtgl+181ClJ
X-Gm-Message-State: AOJu0YyTaVC7SGnrfStYZrhYnR4xEUMARUjxiFvde81CAk9O0/2ZwIfi
	XXOrwZc2LF6Qfh0C00va9FwETKgjI/1qwZeUZSeDnrd89Whc7xNp2qzG6nX89sw=
X-Google-Smtp-Source: AGHT+IEOznvXT2DbTMtec6cIfPbt6cznBYSdTY7urC4yVUpfeeSzluMWHpxbXdtlOl9wyfNYXsAK/A==
X-Received: by 2002:a5d:56c2:0:b0:346:251a:396d with SMTP id m2-20020a5d56c2000000b00346251a396dmr1588928wrw.51.1713966876400;
        Wed, 24 Apr 2024 06:54:36 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:ab48:1b7:631c:952a])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b00417e5b71188sm23952306wmo.34.2024.04.24.06.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 06:54:36 -0700 (PDT)
References: <20240424-s4-pwm-v4-0-ee22effd40d0@amlogic.com>
 <20240424-s4-pwm-v4-1-ee22effd40d0@amlogic.com>
 <1jil07f3ps.fsf@starbuckisacylon.baylibre.com>
 <ikwqq5veuad7fehk6qrpebevvn2ezuxwm3h7agloqeomxc5cbg@kj3be67luyxm>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>, kelvin.zhang@amlogic.com, George
 Stark <gnstark@salutedevices.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Junyi Zhao
 <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v4 1/2] pwm: meson: Add support for Amlogic S4 PWM
Date: Wed, 24 Apr 2024 15:53:44 +0200
In-reply-to: <ikwqq5veuad7fehk6qrpebevvn2ezuxwm3h7agloqeomxc5cbg@kj3be67luyxm>
Message-ID: <1jbk5yg92c.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Wed 24 Apr 2024 at 15:51, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutr=
onix.de> wrote:

> [[PGP Signed Part:Undecided]]
> Hello,
>
> On Wed, Apr 24, 2024 at 12:32:36PM +0200, Jerome Brunet wrote:
>> > +err:
>> > +	while (--i >=3D 0) {
>> > +		channel =3D &meson->channels[i];
>> > +		clk_put(channel->clk);
>>=20
>> Fine on error but leaks on module unload.
>>=20
>> Same as George,
>>=20
>> Add the devm variant of of_clk_get() if you must.
>
> There shouldn't be a reason to still use of_clk_get(). I'd expect that
> devm_clk_get() should do the job and if not that's a bug.

Getting a clock ressource by index instead of by name is a reason.

>
> Best regards
> Uwe


--=20
Jerome

