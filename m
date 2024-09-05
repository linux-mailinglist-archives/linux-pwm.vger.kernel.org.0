Return-Path: <linux-pwm+bounces-3108-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B95696E0E7
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 19:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE4E1F24D63
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 17:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91481A254E;
	Thu,  5 Sep 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9fZwCtw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D1619DFB8;
	Thu,  5 Sep 2024 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556369; cv=none; b=TQ5r2cUKBvT4v1bPDcgwdbcyqellE5UUEfxr86LpTvXeoKzUEf6YO0+O3j0/EJr3uunQEVTtFwk9EsNCNJ+LY2uBjpJOwhzYdFs+XGCtheATqimtMPylEG4UO5fZUZvw7IU8rliJgROWsxgMeadvA5jXLbOiXwGjVBAQ2dYpTSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556369; c=relaxed/simple;
	bh=A7TtDQQAdTUo+ZDaXSaI6ceuzOQKZTjGvuB/qTrYS9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stIfsMoAmctnAeTte615H79t7qPJXwj8K3rFyaWOu2Pp0O/PSIE8pQAg3lskrl+tQxxksIWarqosNVO57oCDAFgdt77HRe3X58Qunz8Kj6y3ypbqRw3/lC9f1kPrgKtxAAn2YntAqHtSs0MYA7YGCNAVA2VnUFUyqP5S/zHCykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9fZwCtw; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53653682246so1192913e87.1;
        Thu, 05 Sep 2024 10:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725556366; x=1726161166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtORbUfBuSYpw+ZpNAYafseBri04aZwmXOf583OZnkE=;
        b=h9fZwCtwuUfWBDjb166+ga/nFOeu2Ky1hYx0/oeIW6KklDTQGqQ6avP9y45LVszTvG
         /0g6LWz9KUqZk+WGcx3As/vVtyTrPG3cYyn+yTqhzfiK2GK3kDhgRG9F7abtXvFydI6O
         qOkHsImrmBmvbe3dxK0pcRXDJoEYstoxyoERqWt3iKJi+Pp5PVElu5NiggYy+OnhWtA0
         2xclcO66OAWzVtcJTyCLlkQ/+y3FIDV/Ez2edGqY1CwpoqSND8w8vAMVzAamd9vI1DKl
         j+OOdLVdnHkSCX+by4Ejgf20YRo2ByczA2ENt9ALOBhtUfYKYfVbExHWZv2Pre6T8WVU
         +IEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725556366; x=1726161166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtORbUfBuSYpw+ZpNAYafseBri04aZwmXOf583OZnkE=;
        b=iz+dJGh/E1XVghv3Zw78nvUDNBsUCIZKgFkFMEywFuZz/x9Jyb0jIx17N4/z51tUYB
         2ZmUMgrkKd1d7L0cDDULqjjtz2J34HOE6OgtIw2dEaNvLb/qvcEHjfHJUXq3xCxltX+P
         2uvwUN33+bbRVmOoj9cJsr7tLpaOM+hXiblNiFGAci3LaSaHSU0OCOqgqEnxsqDTzcq7
         0WMrHtCixRSJlFxvroUJ4+dXOG0J0/xHR4lpiP/UxBvtuRTQ2y31NTjI8dbesEO/BR8c
         J6YuvNein6T3jGNRh+OuAwBvGJbhR8z1CGoWJYqj9GOFyXhY53Mb1gKSohrlGr517ZXy
         fWLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEF7b7Yy11Hpnb3B92p10Lalg/5liOybGSQSsU6x/C5keZV/8aQZODDbwb72C3YzW8+agzBSmHYr8A@vger.kernel.org, AJvYcCVNK5O/wPa5UGAvayYnWR5Gjp7iWTH60zb7AsEIdvhOKEvJhwc64GMe5KVBSZ2h7zcUzJ047FptuaIVXbSe@vger.kernel.org, AJvYcCWxncviQwI4Ry/+eQYHVZWY/gXldkkEEmyrCpFnDlfNQQgp19MmT0f5RGPuNGWTAddH/i4IDSvVXRvc@vger.kernel.org
X-Gm-Message-State: AOJu0YxDUxiPmccz7wHigYNaqvMHh/tC907idwXHrXQVnktcZYQseate
	BAfc6A6qDxR8AjhBFf9fEooQ+ep9scJgkOtrNz5D1lcgL6TVq8owqwlQTHuceQSEm9HHqz7piGy
	uOGSVI52E9fPmrQ0n9zi6PET9/GY=
X-Google-Smtp-Source: AGHT+IHSwofzoxwQsG0zMSSmo1+llgW2Wy3bZzwTo3q9Dkz410dXl/IeuLUWClfjbJdYjUEnCtJ+IeVIoX1nfMyYe0c=
X-Received: by 2002:a05:6512:2394:b0:536:55a9:4b6c with SMTP id
 2adb3069b0e04-53655a94bf8mr892897e87.13.1725556365789; Thu, 05 Sep 2024
 10:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715-pwm-v2-0-ff3eece83cbb@nxp.com> <20240715-pwm-v2-3-ff3eece83cbb@nxp.com>
In-Reply-To: <20240715-pwm-v2-3-ff3eece83cbb@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 5 Sep 2024 14:12:33 -0300
Message-ID: <CAOMZO5DNmHfHWbLoPj9P=_+JiLLQ4tiDd_90+UX+_psN2o+Knw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
To: Frank Li <Frank.Li@nxp.com>, Marek Vasut <marex@denx.de>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	pratikmanvar09@gmail.com, francesco@dolcini.it, 
	Clark Wang <xiaoning.wang@nxp.com>, Jun Li <jun.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding Marek.

On Mon, Jul 15, 2024 at 5:30=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> From: Clark Wang <xiaoning.wang@nxp.com>
>
> Implement workaround for ERR051198
> (https://www.nxp.com/docs/en/errata/IMX8MN_0N14Y.pdf)
>
> PWM output may not function correctly if the FIFO is empty when a new SAR
> value is programmed
>
> Description:
>   When the PWM FIFO is empty, a new value programmed to the PWM Sample
>   register (PWM_PWMSAR) will be directly applied even if the current time=
r
>   period has not expired. If the new SAMPLE value programmed in the
>   PWM_PWMSAR register is less than the previous value, and the PWM counte=
r
>   register (PWM_PWMCNR) that contains the current COUNT value is greater
>   than the new programmed SAMPLE value, the current period will not flip
>   the level. This may result in an output pulse with a duty cycle of 100%=
.
>
> Workaround:
>   Program the current SAMPLE value in the PWM_PWMSAR register before
>   updating the new duty cycle to the SAMPLE value in the PWM_PWMSAR
>   register. This will ensure that the new SAMPLE value is modified during
>   a non-empty FIFO, and can be successfully updated after the period
>   expires.
>
> Write the old SAR value before updating the new duty cycle to SAR. This
> avoids writing the new value into an empty FIFO.
>
> This only resolves the issue when the PWM period is longer than 2us
> (or <500KHz) because write register is not quick enough when PWM period i=
s
> very short.
>
> Fixes: 166091b1894d ("[ARM] MXC: add pwm driver for i.MX SoCs")
> Reviewed-by: Jun Li <jun.li@nxp.com>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - address comments in https://lore.kernel.org/linux-pwm/20211221095053.uz=
4qbnhdqziftymw@pengutronix.de/
>   About disable/enable pwm instead of disable/enable irq:
>   Some pmw periphal may sensitive to period. Disable/enable pwm will
> increase period, althouhg it is okay for most case, such as LED backlight
> or FAN speed. But some device such servo may require strict period.
>
> - address comments in https://lore.kernel.org/linux-pwm/d72d1ae5-0378-4ba=
c-8b77-0bb69f55accd@gmx.net/
>   Using official errata number
>   fix typo 'filp'
>   add {} for else
>
> I supposed fixed all previous issues, let me know if I missed one.
> ---
>  drivers/pwm/pwm-imx27.c | 52 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 253afe94c4776..e12eaaebe3499 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -27,6 +27,7 @@
>  #define MX3_PWMSR                      0x04    /* PWM Status Register */
>  #define MX3_PWMSAR                     0x0C    /* PWM Sample Register */
>  #define MX3_PWMPR                      0x10    /* PWM Period Register */
> +#define MX3_PWMCNR                     0x14    /* PWM Counter Register *=
/
>
>  #define MX3_PWMCR_FWM                  GENMASK(27, 26)
>  #define MX3_PWMCR_STOPEN               BIT(25)
> @@ -232,8 +233,11 @@ static int pwm_imx27_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  {
>         unsigned long period_cycles, duty_cycles, prescale;
>         struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);
> +       void __iomem *reg_sar =3D imx->mmio_base + MX3_PWMSAR;
>         unsigned long long c;
>         unsigned long long clkrate;
> +       unsigned long flags;
> +       int val;
>         int ret;
>         u32 cr;
>
> @@ -274,7 +278,53 @@ static int pwm_imx27_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>                 pwm_imx27_sw_reset(chip);
>         }
>
> -       writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> +       /*
> +        * This is a limited workaround. When the SAR FIFO is empty, the =
new
> +        * write value will be directly applied to SAR even the current p=
eriod
> +        * is not over.
> +        *
> +        * If the new SAR value is less than the old one, and the counter=
 is
> +        * greater than the new SAR value, the current period will not fi=
lp
> +        * the level. This will result in a pulse with a duty cycle of 10=
0%.
> +        * So, writing the current value of the SAR to SAR here before up=
dating
> +        * the new SAR value can avoid this issue.
> +        *
> +        * Add a spin lock and turn off the interrupt to ensure that the
> +        * real-time performance can be guaranteed as much as possible wh=
en
> +        * operating the following operations.
> +        *
> +        * 1. Add a threshold of 1.5us. If the time T between the read cu=
rrent
> +        * count value CNR and the end of the cycle is less than 1.5us, w=
ait
> +        * for T to be longer than 1.5us before updating the SAR register=
.
> +        * This is to avoid the situation that when the first SAR is writ=
ten,
> +        * the current cycle just ends and the SAR FIFO that just be writ=
ten
> +        * is emptied again.
> +        *
> +        * 2. Use __raw_writel() to minimize the interval between two wri=
tes to
> +        * the SAR register to increase the fastest pwm frequency support=
ed.
> +        *
> +        * When the PWM period is longer than 2us(or <500KHz), this worka=
round
> +        * can solve this problem.
> +        */
> +       val =3D FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base =
+ MX3_PWMSR));
> +       if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORD=
S) {
> +               c =3D clkrate * 1500;
> +               do_div(c, NSEC_PER_SEC);
> +
> +               local_irq_save(flags);
> +               if (state->period >=3D 2000)
> +                       readl_poll_timeout_atomic(imx->mmio_base + MX3_PW=
MCNR, val,
> +                                                 period_cycles - val >=
=3D c, 0, 10);
> +
> +               val =3D FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mm=
io_base + MX3_PWMSR));
> +               if (!val)
> +                       writel_relaxed(imx->duty_cycle, reg_sar);
> +               writel_relaxed(duty_cycles, reg_sar);
> +               local_irq_restore(flags);
> +       } else {
> +               writel_relaxed(duty_cycles, reg_sar);
> +       }
> +
>         writel(period_cycles, imx->mmio_base + MX3_PWMPR);
>
>         /*
>
> --
> 2.34.1
>

