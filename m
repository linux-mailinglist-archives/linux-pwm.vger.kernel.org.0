Return-Path: <linux-pwm+bounces-6088-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FC7AC0C1C
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 15:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C054500C35
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 13:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5331E487;
	Thu, 22 May 2025 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="H5c8q866"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766BD35963
	for <linux-pwm@vger.kernel.org>; Thu, 22 May 2025 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747918881; cv=none; b=VeJlQPGJGIn3shIAY4KnB4G0Vu8BGDMFqF3ug/Zd87sYspPZfJA3BmAZNYO8b3b6sZxFtl5e1LSA5ZAOlErsnRZbF3EKITmgEC3Uw/W0klZUOikFPcNTZqOfpNMNw7Mq40BKES1ma8+XSEIZ1Iz5cE9maKQxDy4+ciJ6OgzwYA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747918881; c=relaxed/simple;
	bh=dyHhktMA+tP6K9DkwriiNHXh1gKPz9cPXffhriQHbYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TaDdd9owlWIi1MDgt8RkqPRheLtjOEBVLyDQ0lS+YM9UIl2lo2B2WqI5ZzkeDCkf+rQEIpYvRaeUG87GakbJ9s01QkGjSrYmVuNVA9VSdaUlmtAXN6pOrDykNG3HcFVqaFyvEuZ3xKBK/mdFJ/QB8oY4mszuSRJMa1pOQSrJfTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=H5c8q866; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-550e2ac6bc9so8791902e87.1
        for <linux-pwm@vger.kernel.org>; Thu, 22 May 2025 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1747918876; x=1748523676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzu+PRVXcOL8yrXNh1C3D66rYRdfVDajFRg4W7HU2/U=;
        b=H5c8q866PU2olvrfRdCEzxfs5UqFPCJMlqXXzSEXsxL5wjcfX68lHYvdD1lpx7VvYR
         jqk8ChlF/3FyxPHO7ilFWoR6fYkD4pecoWGltnsy96k+m1HkAbAz8sQogTwFuLQkptra
         Ufv19xKEPummZ69LGAdIMxyde9VE/+vwiSRx62rhTCDn0oQS9e0Xy43cOyFwibBtv/PN
         5w7x75QhSG9DFdGyBUaolHSu50bpprwtiGLlS5tbQYJc98P1oBcSBrYyPTGQQpGeDkMT
         vSYuBDc9kVlk+4p135FHfCSw95UTuRSJ+54XFqN/pc8cIYMHeqkq0kNq67raQOtWTCcw
         tqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747918876; x=1748523676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzu+PRVXcOL8yrXNh1C3D66rYRdfVDajFRg4W7HU2/U=;
        b=s5KM9sy7Mt+Z9FruVZEIckGh0E7Nz0EstcZCmuwPLO+uwSuC57LTi+0wmHo6Z3KqT7
         W7b46YLDVnRYivJlRkmBaPMIR3EppjZ5pyGSDwin78sq3ZHcZOtMtw3NzDP4Y/MJVh5x
         7SGLE6qxoAJ2tUmTK9ED0wqFrpWAnq+r60EAT76kcOtWHtW3nFTk1X6W/G0bqSSprTcf
         gRGVvu3v90i7BlhpVlNcKCbxqXeNAFknKd3yR7wVHZdrqk99rkjYsLYo5GPYSeAEWpLK
         YPA6aDeQugNpYIM2fRQ7F38kc+P8MetdQ8hg+nmRug9hahWTsn+q4e6QAl43LGd8ewyS
         wkaw==
X-Forwarded-Encrypted: i=1; AJvYcCUG5ruH9B9cW+cfdTp8hiivDQeOV0zCT/bWKNdulH75c/pk4CH1Tjfd8Lo6Xq7GbHgBzMXD5ORPT2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/J+Z64rNFG/fLJRfGs0pVXJFOr7LoG+TkbI8dI/5kukfw8Kmd
	7O9Zk6kXFGGgSXsJJbwt9+eNL8So2PegmOrjkiBDI8OVmI53O5zc6QetuS7rA0lp87zpjNBSUuR
	569UHZ8HlRMi3KUpjTTHPcKGueEJ+SE7jd2ZGvqMAgg==
X-Gm-Gg: ASbGnctnxfheU12XA8M2sbYxKUrrCbClTcOd185Q3YqiUQ6IlSTzqpdmMVsI0KGvpgX
	a7YeLKghmHnMVvnFz3t9yBPpyjkN2+kgg3/ytskx2u1DBMwviAU77/Z3J0mIyE99LqjPsJyUQYj
	uNyN7YlA+BUbP3tW8oXylwAFc1obXEqhXRsFM0hO2TP1LFRVr4uQ+cLatnw8viPeHl
X-Google-Smtp-Source: AGHT+IEKXZsuXa61rx7iYXVdN5gAUYZ6t4jPh8WeQF1z9sKal0LbQMPKsCLBhIwfmsJA3Pg+puN9L64R+OYtBY9d0U8=
X-Received: by 2002:a2e:a594:0:b0:30c:4610:9e9e with SMTP id
 38308e7fff4ca-328077c36ecmr91178471fa.35.1747918874917; Thu, 22 May 2025
 06:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522-mdb-max7360-support-v9-0-74fc03517e41@bootlin.com> <20250522-mdb-max7360-support-v9-6-74fc03517e41@bootlin.com>
In-Reply-To: <20250522-mdb-max7360-support-v9-6-74fc03517e41@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 May 2025 15:01:03 +0200
X-Gm-Features: AX0GCFsKBsNYnfZ6NFYjJv1MLR5Cl4LpJ53FIqsJ0O4hK_3tLeUr_p3wGhtMou4
Message-ID: <CAMRc=MeT+b5dBOWyf6-BpTjk70nwVhLOpCY-JHNizBo5H1-AnQ@mail.gmail.com>
Subject: Re: [PATCH v9 06/11] gpio: regmap: Allow to allocate regmap-irq device
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, 
	=?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 2:06=E2=80=AFPM Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:
>
> GPIO controller often have support for IRQ: allow to easily allocate
> both gpio-regmap and regmap-irq in one operation.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  drivers/gpio/gpio-regmap.c  | 21 +++++++++++++++++++--
>  include/linux/gpio/regmap.h | 11 +++++++++++
>  2 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> index 87c4225784cf..9cbbbaf82609 100644
> --- a/drivers/gpio/gpio-regmap.c
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -215,6 +215,7 @@ EXPORT_SYMBOL_GPL(gpio_regmap_get_drvdata);
>   */
>  struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config=
 *config)
>  {
> +       struct irq_domain *irq_domain;
>         struct gpio_regmap *gpio;
>         struct gpio_chip *chip;
>         int ret;
> @@ -295,8 +296,24 @@ struct gpio_regmap *gpio_regmap_register(const struc=
t gpio_regmap_config *config
>         if (ret < 0)
>                 goto err_free_gpio;
>
> -       if (config->irq_domain) {
> -               ret =3D gpiochip_irqchip_add_domain(chip, config->irq_dom=
ain);
> +#ifdef CONFIG_REGMAP_IRQ
> +       if (config->regmap_irq_chip) {
> +               struct regmap_irq_chip_data *irq_chip_data;
> +
> +               ret =3D devm_regmap_add_irq_chip_fwnode(config->parent, d=
ev_fwnode(config->parent),
> +                                                     config->regmap, con=
fig->regmap_irq_line,
> +                                                     config->regmap_irq_=
flags, 0,
> +                                                     config->regmap_irq_=
chip, &irq_chip_data);

I don't think using devres here is a good idea. There's no guarantee
that gpio_regmap_register() will be called on device attach so you
must not make the release of the resource depend on an associated
detach which may never happen. Please use the non-managed variant
here.

Bart

> +               if (ret)
> +                       goto err_free_gpio;
> +
> +               irq_domain =3D regmap_irq_get_domain(irq_chip_data);
> +       } else
> +#endif
> +       irq_domain =3D config->irq_domain;
> +
> +       if (irq_domain) {
> +               ret =3D gpiochip_irqchip_add_domain(chip, irq_domain);
>                 if (ret)
>                         goto err_remove_gpiochip;
>         }
> diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
> index c722c67668c6..19b52ac03a5d 100644
> --- a/include/linux/gpio/regmap.h
> +++ b/include/linux/gpio/regmap.h
> @@ -40,6 +40,11 @@ struct regmap;
>   * @drvdata:           (Optional) Pointer to driver specific data which =
is
>   *                     not used by gpio-remap but is provided "as is" to=
 the
>   *                     driver callback(s).
> + * @regmap_irq_chip:   (Optional) Pointer on an regmap_irq_chip structur=
e. If
> + *                     set, a regmap-irq device will be created and the =
IRQ
> + *                     domain will be set accordingly.
> + * @regmap_irq_line    (Optional) The IRQ the device uses to signal inte=
rrupts.
> + * @regmap_irq_flags   (Optional) The IRQF_ flags to use for the interru=
pt.
>   *
>   * The ->reg_mask_xlate translates a given base address and GPIO offset =
to
>   * register and mask pair. The base address is one of the given register
> @@ -78,6 +83,12 @@ struct gpio_regmap_config {
>         int ngpio_per_reg;
>         struct irq_domain *irq_domain;
>
> +#ifdef CONFIG_REGMAP_IRQ
> +       struct regmap_irq_chip *regmap_irq_chip;
> +       int regmap_irq_line;
> +       unsigned long regmap_irq_flags;
> +#endif
> +
>         int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base=
,
>                               unsigned int offset, unsigned int *reg,
>                               unsigned int *mask);
>
> --
> 2.39.5
>

