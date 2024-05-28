Return-Path: <linux-pwm+bounces-2249-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9229B8D1A59
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 13:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C050C1C22003
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 11:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DD316C84C;
	Tue, 28 May 2024 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+trmbeZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC59C16C84A
	for <linux-pwm@vger.kernel.org>; Tue, 28 May 2024 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897283; cv=none; b=uNMOyQK2l5emhutF5d0qvP4OXgS6aiLCQwd/MjodSg9TwlFUAgmH+jacS+6N3NZxv43Vdbm/N+5pES/k5LSO9ty+ylPCdrzZmcp2fj4GgP+jJNU9YAY6hSpfG5xVk9RnBtqDVaggVQDltLrYkUlXW+hRlxKCPYSIcPSXgQ+2II4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897283; c=relaxed/simple;
	bh=rOVJH4nneZooWwYT28snd/nHe+v09VIVntLIbqJ6SHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPtw3QMKpLbJv/faJuDDS/LBffocJgY8iv1QM3rI4x6yR7GdXv2MPi0ddWJfcv1Xt3YAk82upg9M291mSnMLBHyLhwMhsDCDoOSJBaClEC0jyik2f6B/vVzvqVSjlaXw4ZE9Xmq5HyCJJRSsTpB+vupxAbfpCCVnm4H+XThs8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n+trmbeZ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-df771cae64aso642761276.3
        for <linux-pwm@vger.kernel.org>; Tue, 28 May 2024 04:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716897280; x=1717502080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2ZiDWbd+rmrEps4dsEoh3/axBJ9SRQHNITtFJg7aIA=;
        b=n+trmbeZdJ1fWWgxL56w5DaT459zEN55sma0Amvtrhbzgz2Y0/8O2QAEPhBHwDogol
         kTAR1LIrbGIndI6PicSQXUG86k2U8vB/6tFx7k8KfRyTUibKvB/+RD3EyHo11xsaBG/w
         4B5kj3sau+ZOM7Mfvz30LepjHHVrMUbpwGmFEHDHwwY0Ma/CNBuxd7yEUOo/NdrhDkP2
         xvU/kuIduXk3kzwSOU6BWZbruyVVgHNa6M9tkIGdNoYZ/iTwrxk6DDjI/cyyrafQVall
         NpqA0xybjCnDSjbHh5OkTvoRG4PdinSRRU4TzEFirlsdexs2Q2qEmsaFkB0IALAz6Ae3
         he7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716897280; x=1717502080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2ZiDWbd+rmrEps4dsEoh3/axBJ9SRQHNITtFJg7aIA=;
        b=KgBHbYZKGr42kGxA/DTCZi1gS+MDzhYV0GVt2Er4QdpWU+ZA3ixE/AaItNswzO0VAT
         53SvVEcOMBY3nm2fO1IU+mXLNGFrMHkUyXCRl+UjjfMggg3a2JdTjTaHKoLhTVRJjyfr
         ClQjfkk9rLL/xaJ/HLjdRLAZAtJ6i0k+NXFlXa9cWuAddUOY3YP2yXsxaSrMr48szwF9
         JFTH+oKYj866mGY1ajXXnyUzvUSV9h+mYAO3HC5LBN8afx40c5J7lsdM84Q5xFmtITCg
         A53VBHOTeLQEJXQImYcfbtFWuOe00qHSkuZGwYzu8Fm+6HikBpG/NvSfTLAR7iCzqV1Z
         NgvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU31n7xQiNpcg7qKOZeVZJoUtbtFG536gXWU1pTJ/AelxemBsBjt+/IT6eICQPdQRWHSZaVxJ7vCm7gl6AMTqLyt4vqgXoS3VXG
X-Gm-Message-State: AOJu0Ywmcxa6+kGO/FZnFqIAMlvsGmPKgHfTadz9Kihb+quxEkQ+192F
	NnfGqERQ40aj4+BkuArcoIDWtcA9tkI4/lhxLW3jDukbhZgjozFx0VL6sfZxJZ0xn51T3a9ecuE
	SCfO/7Rb1G+M2LIt2lxmE05xVstjej7sDVi3X1ulSmjg/UDwmdAW4Sw==
X-Google-Smtp-Source: AGHT+IEEmlDgJX8py9oRVhTs9SrjHN2VKQehB1aTAo8maPSVXq5jzMhl0pQ6oyZ4KdZq6BzPizDGQdL5TnBpH0uaUA4=
X-Received: by 2002:a25:d0d2:0:b0:de5:5067:6b4a with SMTP id
 3f1490d57ef6-df772180300mr13087888276.2.1716897279862; Tue, 28 May 2024
 04:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com> <20240520195942.11582-5-laurent.pinchart@ideasonboard.com>
In-Reply-To: <20240520195942.11582-5-laurent.pinchart@ideasonboard.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 May 2024 13:54:29 +0200
Message-ID: <CACRpkdbAq1Cqr4X8fjEjOTxw7ky9b6V0ye1NYKfDy5E1BmAX6g@mail.gmail.com>
Subject: Re: [PATCH 4/5] gpio: adp5585: Add Analog Devices ADP5585 support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Alexandru Ardelean <alexandru.ardelean@analog.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Haibo Chen <haibo.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laurent/Haibo,

thanks for your patch!

On Mon, May 20, 2024 at 9:59=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
>
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> This driver supports the GPIO function using the platform device
> registered by the core MFD driver.
>
> The driver is derived from an initial implementation from NXP, available
> in commit 451f61b46b76 ("MLK-25917-2 gpio: adp5585-gpio: add
> adp5585-gpio support") in their BSP kernel tree. It has been extensively
> rewritten.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

(...)

> +static int adp5585_gpio_direction_input(struct gpio_chip *chip, unsigned=
 int off)
> +{
> +       struct adp5585_gpio_dev *adp5585_gpio =3D gpiochip_get_data(chip)=
;
> +       unsigned int bank =3D ADP5585_BANK(off);
> +       unsigned int bit =3D ADP5585_BIT(off);
> +
> +       guard(mutex)(&adp5585_gpio->lock);
> +
> +       return regmap_update_bits(adp5585_gpio->regmap,
> +                                 ADP5585_GPIO_DIRECTION_A + bank,
> +                                 bit, 0);

First, I love the guarded mutex!

But doesn't regmap already contain a mutex? Or is this one of those
cases where regmap has been instantiated without a lock?

> +       gc =3D &adp5585_gpio->gpio_chip;
> +       gc->parent =3D dev;
> +       gc->direction_input  =3D adp5585_gpio_direction_input;
> +       gc->direction_output =3D adp5585_gpio_direction_output;

And chance to implemen ->get_direction()?

Other than this I think the driver is ready for merge, so with the
comments fixed or addressed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

