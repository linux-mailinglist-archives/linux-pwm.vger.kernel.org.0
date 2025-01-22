Return-Path: <linux-pwm+bounces-4705-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D8EA19238
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 14:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2D31626A0
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 13:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC6B212D65;
	Wed, 22 Jan 2025 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sRGUXYyC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587A3212F9F
	for <linux-pwm@vger.kernel.org>; Wed, 22 Jan 2025 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551897; cv=none; b=eBrh59efpCBd2HyLsvuCDgJjBfrlhgwTmWCxOtv9YBuF1PS0q1gubrztwORhFEq3QeTxiSTkYkNSkwkjUIhvL3bcTIW5EhPJOODDM0bwR89izklf0NeoGajHC3Zg6XU7jcNf6RnqkdZ8FOa/TBKnB2qVIuW0UsAaRYCkxl1F61I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551897; c=relaxed/simple;
	bh=SzxuyU2yAyNtPusbcdvLjoKifFW9Afx1CHqAf8gK+RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqSbqa1B70reDGtEq1vlARtYCiHP1J3WVg5djxXtSiMG1/CFYBq70rMu1Z/E5OZqgmymn2qfuM41NUjI+EG65F7h2SojdM/zCzKzk50c5d2z3fIXKcCwI3ZMJBwphBqtUKsJua14+heQhoEFwvvYXH7LN+LSrzytF6X1L7qol4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sRGUXYyC; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401c52000fso6616083e87.2
        for <linux-pwm@vger.kernel.org>; Wed, 22 Jan 2025 05:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737551893; x=1738156693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzxuyU2yAyNtPusbcdvLjoKifFW9Afx1CHqAf8gK+RU=;
        b=sRGUXYyCL19CANDdq/X5/U3Z44urh+2vFm9+uGUGJEIiGib59bPL3fTZuuIgTDXmEp
         vdb8qq4PgNG36NoiRbY10w4ti5Wa6Hi8GXdc9aMWMqj7eKmSuy8YuVM1NcX8qE02JQDk
         oyiql31jxhPo5uDjrJXgRSHeTzkd3BxEyFZ1/ybaPbXHIPfO2hkUoNRnaptFgYBcRXrO
         otFhGUDXQjCC1dPGzID6TSpiDnD/Dot3iiK+qkZbElGc/jmn1slrzICaEZ9as1SpDCud
         VzRPOpWe/jeXTIOia2g8ctg0Ub5pRczz+ngSE+uXbkIQJd51+O0nZ/u0JuMwAW3k/kFE
         QH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737551893; x=1738156693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzxuyU2yAyNtPusbcdvLjoKifFW9Afx1CHqAf8gK+RU=;
        b=wVvj16ExKkart1W1nSJ07YSBwaQ4DxpGlo6SUS3m3eMf3le6NygYBPRgC0nRVp5+Mi
         hALhhbrI4f6SVIAAKAYODYC6y2qjN47Z7J9QQ2w7HNiqX4W7w+bPaSmK+lvFoFZMiLlS
         mTc2xtGUX2r5LO09X7TWH+xTz3985ifMV68lq7TCgfFbPIVKme7sxt9HrFULfLxuKI5t
         WQyiTnoeSaWvEHwCV8SVKjO2FJKKnUxU/tOXe3IaxHO7sgVRjlJKgAoJwP8ZDDzHrIsu
         WAA7sxAnFvOzZhTsxG6zCZ+zwmSqsffYIw6Rco7JM74iIQgxzj7sCr6v5hb7B+AQ/Aj/
         mSbA==
X-Forwarded-Encrypted: i=1; AJvYcCUui6GXp6wamEqiOnbgs1UvWUFfEQCipHy7vgYm4dbvf6KyH3/U4/PvE3vTBT9C4D/4P7m9UDM+GUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNOSzPNOaGkjbbUuVy4ApoR59MaffTTqrSKSMWMOzbJPrKMKlt
	/Z922Oc/THs0oVux5KG9QXf2GDo8ii62nvZ7RF0hCQ7/agasPFdibvYlO8K8M3IvVq0XBEAXN3m
	2RcxYu7C7aZpUG289kfg1VOG9AOL/lTMVQSiOgQ==
X-Gm-Gg: ASbGncvJHEoWuRhfr3wIirdFGNXPFmAPD5lzOf1/EpN7LV8oDk9NxR6MhocSOEuT++c
	fPbkvbowymYULeWuG0cEktlePiVUMIddRPx6DaKQ/ZKO5l6wwAA==
X-Google-Smtp-Source: AGHT+IGx94jEEbs3RXLhYMJzipQpPaITuu/cDsPO6lvIB40L+SYCX7nP/SwM57IZh5M/14/A9ZfVrtIFsKzpspJZJrI=
X-Received: by 2002:ac2:4851:0:b0:540:1b41:c75f with SMTP id
 2adb3069b0e04-5439c247804mr7518539e87.16.1737551893267; Wed, 22 Jan 2025
 05:18:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-4-9519b4acb0b1@bootlin.com>
 <CACRpkdb5rmUK06uW3M2Lsy4Wam8JvrjmGM83cJa-V3LZwTX9dg@mail.gmail.com> <D74G95A3DHG3.OD522T88GX83@bootlin.com>
In-Reply-To: <D74G95A3DHG3.OD522T88GX83@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 22 Jan 2025 14:18:02 +0100
X-Gm-Features: AbW1kvZa1bBVRjs7vofZvq4_6URi9UF8tFCRrRfOePL_D2lVGG2FqlUFUy0FJ3I
Message-ID: <CACRpkdYMvx31UBpVnWGYdNUdnQLhHgn9FW+ruLXNpy82roTJwQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] gpio: max7360: Add MAX7360 gpio support
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pwm@vger.kernel.org, =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

On Fri, Jan 17, 2025 at 4:22=E2=80=AFPM Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:

> I tried to switch to GPIO_REGMAP and I really like it overall, as it
> does simplify a lot the code. However, I identified two features that I
> was not able to port so far: the request()/free() callbacks and the
> interrupts.

Thanks for looking into this!

> So for the request()/free() callbacks, I cannot add them anymore, as
> they are set on the gpio_chip structure, and this structure is hidden
> behind the gpio_regmap structure. I could easily modify the
> gpio_regmap_config structure and gpio_regmap_register() to allow to
> provide these callbacks, but is this acceptable?

Of course. The template is to be used for setting it up, just
modify it if we need more from it.

> On the IRQ side, before switching to GPIO_REGMAP, I was able to define
> the IRQ configuration using the irq member of the gpio_chip structure.
> This does create the IRQ domain for me in a quite straightforward way.
> Again, I will not be able to do that anymore, as the gpio_chip structure
> is hidden.
(...)
> I had a quick look at existing drivers using GPIO_REGMAP and providing
> IRQ support: I believe they are all using REGMAP_IRQ. And I believe I
> cannot use REGMAP_IRQ here,

Then we need to modify GPIO_REGMAP so it's possible to pass
in our own gpio_irq_chip, maybe another member in
the config, simply?

Yours,
Linus Walleij

