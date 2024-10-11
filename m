Return-Path: <linux-pwm+bounces-3592-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40588999D2B
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 08:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367B01C216FD
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Oct 2024 06:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AA620ADF3;
	Fri, 11 Oct 2024 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eo6pJKNw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA49209660
	for <linux-pwm@vger.kernel.org>; Fri, 11 Oct 2024 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629526; cv=none; b=VUgvMdsxshEsQKedN/9xiwms/j2GtAlc8MSIC8WmvVJko65xCfEFPD5bLGifjomu9ysFb+Z0TSXNgRy8OkMUcfYAPKKKTtaPmLLUhkVgIr0zt3mQ6aEzBlscSPeNRMU7kArnpEjz8FycUBPJH0lzipcQhEstxKBOkFhkslstB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629526; c=relaxed/simple;
	bh=J2iMSLRCPsPMx+AG9tDaYPTZOE1B2tv6njwOlROE93w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHvjJSmAvDatTla59dikDP8M/k2VRUryg3zrDEzkgqNkDnhp04TAsUX6Xj9QFfXYBDDagHGY1Kf7kR0nR9BcKNlA4QFBjH6glRtcedQjnyVRbwBmh9WZIqy9uURqZx7LKOTleGOX2wwV6hUF/3JpcpynPGsGeRIVOhI+IBrE6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eo6pJKNw; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fad6de2590so25054931fa.0
        for <linux-pwm@vger.kernel.org>; Thu, 10 Oct 2024 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728629523; x=1729234323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yol/CqMflojZ91zDJ6BWlrykjb5lk+ms5wvr74ezf+w=;
        b=eo6pJKNwmt1FeFAMTx1hY5X2CUXRMqpakyvKfhiJMxiEubY8/HlTjRFiP+X/N0EnOJ
         T+MGSr4/pbBG/b5sUOj5sdnAmUp74holy46C361TaP60Xu1oW5YaYd+eM6xMQoi0uzB0
         /+0C9OR+34ifnnqP6zOPKxhFs7ApTaWrgn7bWVftIkyZ+InmF/QbjR9mtdyO7vwGgaih
         qzJPX8SHZrGVepPEZt1mZR6yqcvtj3rpkwvdW+G37qGWRFRMhE7P0QLXoWl1SbA9DUKp
         U11rr4tg6FWxKifO5T0jrkAoeyRM9vVlBpEzZ5Y4O8wvev/jrxrSn19uw8kk6KbmZsaY
         rrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728629523; x=1729234323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yol/CqMflojZ91zDJ6BWlrykjb5lk+ms5wvr74ezf+w=;
        b=JwkOiQRZreLVZcZ9PBVcc8nSN6Gg1E0MAJo1jtSDqJw9jgwK+UXc8VRHLG8jS8rGNw
         def/Zjk3vSA5RDaalCKV4HpNseAXrUZHNdesWnuIVgCJNxLno0JwmpKClOkKUWfDa/66
         tX0Tzhhy8VAB5M4PDbm26WrZAblIp2jbXHNfbppxXhXuR4mxYywGEot8tuiYnX0Vrb4a
         NdlSAJoiPYp3u3klQa2R4sGDOquBQGu6z6DfnidQuDgfJgcSoEKxmhSKyn93ocw930uR
         Iy1PwVQNQ5xQ7g1c9xRYEs4FWZKgfer8/+k9nZ7gB5jy++mGPjzTs/UyQvAhrTvVib+l
         xqMw==
X-Forwarded-Encrypted: i=1; AJvYcCVFXJ+CLIwvc+7R8xfZKe39BTfSkR5lD6TXrcAS07NuQwxs+tIAPHFsGoYkC4cKdZNezr3uM1e+3jY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+WBvga8nBtLH+7GOeD7MS2cUCJL+T/bxR2hSmFZ619gFyKjGc
	PKoFPJiNh4MTLKSuAL4UOIUiNG+EgkuIs2dSyXwTyWj3iVUC4NkZHHgTUzm39GdTqth3aQnjzjJ
	Elsj92qFPLdjxPpPhFlpzuu7H7s8FdgOBf2s9aQ==
X-Google-Smtp-Source: AGHT+IEL+j79y+MejFM6HiX8V5iKw9ViH8TW+NbeQoNVhAz74UvZoFsQPZ4rGjCGTgCqCqgVNXiU/grYNIrmU/CAJHE=
X-Received: by 2002:a2e:a587:0:b0:2fa:de13:5c34 with SMTP id
 38308e7fff4ca-2fb32744f3dmr8696101fa.19.1728629522773; Thu, 10 Oct 2024
 23:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org>
 <20241001-en7581-pinctrl-v5-3-dc1ce542b6c6@kernel.org> <20241002132518.GD7504@google.com>
 <ZwWscWk5axQI9H1t@lore-desk> <20241009104821.GF276481@google.com>
 <20241009105550.GG276481@google.com> <6707a8ec.df0a0220.376450.293e@mx.google.com>
 <CACRpkdanpA-wq0sYv9HRF=uVeAX_mW4LaKhE8i6TgC9+0d7bCg@mail.gmail.com> <ZwhKECIpL7g7ZGEC@lore-desk>
In-Reply-To: <ZwhKECIpL7g7ZGEC@lore-desk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 08:51:50 +0200
Message-ID: <CACRpkdYxF23-Py=eOZHodeR-RvkYGen_+hn_BtiU+tCPva8BXg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] mfd: airoha: Add support for Airoha EN7581 MFD
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	upstream@airoha.com, benjamin.larsson@genexis.eu, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:41=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.o=
rg> wrote:
> > On Thu, Oct 10, 2024 at 12:14=E2=80=AFPM Christian Marangi <ansuelsmth@=
gmail.com> wrote:

> > I think you want a separate GPIO node inside the system controller:
> >
> >   en7581_gpio: gpio {
> >          compatible =3D "airhoa,en7581-gpio";
> >          interrupt-parent =3D <&gic>;
> >          interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> >
> >          gpio-controller;
> >          #gpio-cells =3D <2>;
> >
> >          interrupt-controller;
> >          #interrupt-cells =3D <2>;
> >
> >          gpio-ranges =3D <&en7581_pinctrl 0 13 47>;
> > };
>
> So far I implemented the gpio functionalities in the en7581 pinctrl drive=
r
> (as it is done for other mtk pinctrl drivers) but I am fine to reuse the
> gpio-en7523 driver for it. Do you prefer this second approach?

It's fine to combine GPIO and pin control into the same node, especially
if you will have a combined driver for it, then it's more or less mandatory=
.
I only wrote this looking at ansuel's sketch.

> > This will make subdevices probe and you can put the pure GPIO
> > driver in drivers/gpio/gpio-en7581.c
>
> We could actually reuse gpio-en7523 driver (removing the gpio part from e=
n7581
> pinctrl driver) and extend it to support irq_chip. I do not have a strong
> opinion about it.

Code reuse is always preferred, if possible.

Yours,
Linus Walleij

