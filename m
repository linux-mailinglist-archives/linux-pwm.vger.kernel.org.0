Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 647CFD7944
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2019 16:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbfJOOzq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Oct 2019 10:55:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46524 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732567AbfJOOzq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Oct 2019 10:55:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so12624656pfg.13;
        Tue, 15 Oct 2019 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MoRLQz9qQnnVM1y2LSZvCw9MdLFXu/hnDRgkUKNBBAM=;
        b=KRXATf+InZy/eTJ79BVO3AuOMNIRR9ivYDZCSXLPTJHC8PkUoymSBomp5F+30QsIeJ
         5uADk1qDojD3CeFNgHP4uDnZvCRTR1ft4zYh5mfuKF6bnaSF34vWaNgg4tBvvP1TwH6F
         +TOPa677gZ2o1S16WPdKqhpglnhQtjT3SGxfaIvHipYHISC7J0ixhFHwgeSOFZ0jqxzs
         89y1/RjkRiAyrGuINClu04IIXEhFlfvnVdp1kH26aBIfePmGG4fcE02TurHrpbviZoti
         GOYeULbCjGEIsYux0/FwNdkUzhdew/+E1MVfAABzRxmNKlFOjNAZ8wYIgrhVS1WiGh8O
         Rf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoRLQz9qQnnVM1y2LSZvCw9MdLFXu/hnDRgkUKNBBAM=;
        b=gg92unOTLeXiLlYQ0+EHwjc/pJXfR22fDMjDC9RUgPl8aKXU2hNej8rmP8sNoRVFhR
         zew8o/wJjYs/xco2+2lXda5hBMQRz/PzohSLE6AL6ctERPq/CaYCFwbh2nrkQ2wODHWX
         sSpQOuLkk4BBa+erGCIuXlYQTvK0pW1SLbeFyBWxXyAbSE4+1Ws4H5D7YnQHPgDmShjk
         kBbGOpMBOshlOA2OQvHcbEQe0A7NVSP8bUXCxZfkTX6ePW8b2HM8AJgmc9ZxWIQWS35B
         eTkDWj7aZlMUKdoEsJZzcDTsfCSMeZZuzXucawLZIUPnYJ+avYt9u6GMyQncfZqzpdGz
         +0lA==
X-Gm-Message-State: APjAAAUVKICMeHIZfbs6MGx7ivioNFPbbtmfa9veaoAy/nKHtEybVigd
        cqterRaQ+oYnb2acCpg8lH8Xo5hw/qIdA/JA4pY=
X-Google-Smtp-Source: APXvYqwWayIy4dorcceC8cFJAO2Cz1ku9tnUs2bwH8eIXgX2wsHGADypAxGKaidt82Vy4YqTRdm3kw0I6URbc2idDKU=
X-Received: by 2002:a63:d0a:: with SMTP id c10mr37925179pgl.203.1571151344336;
 Tue, 15 Oct 2019 07:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191014124803.13661-1-miquel.raynal@bootlin.com>
 <CAHp75Vc4vnNVKc+Q_TY8DpwV4rLZYGm2MvGBC7r67XjmtNoskQ@mail.gmail.com> <20191015163055.0d8f44e5@xps13>
In-Reply-To: <20191015163055.0d8f44e5@xps13>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Oct 2019 17:55:33 +0300
Message-ID: <CAHp75VemkA7kap0O7=iACX4cD5_r6QXaLF6nS8R94ErStK0DwA@mail.gmail.com>
Subject: Re: [PATCH] gpio: pca953x: Add Maxim MAX7313 PWM support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Oct 15, 2019 at 5:30 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Andy,
>
> Thanks for the feedback.
>
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Mon, 14 Oct 2019
> 20:59:01 +0300:
>
> > On Mon, Oct 14, 2019 at 4:09 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > The MAX7313 chip is fully compatible with the PCA9535 on its basic
> > > functions but can also manage the intensity on each of its ports with
> > > PWM. Each output is independent and may be tuned with 16 values (4
> > > bits per output). The period is always 32kHz, only the duty-cycle may
> > > be changed. One can use any output as GPIO or PWM.
> >
> > Can we rather not contaminate driver with this?
> >
> > Just register a separate PWM driver and export its functionality to
> > GPIO, or other way around (in the latter case we actually have PCA8685
> > which provides a GPIO fgunctionality).
> >
>
> I understand your concern but I am not sure to understand which
> solution you have in mind. In the former case, could you explain a bit
> more what you are thinking about? Would linking the PWM support with
> the GPIO driver (code would be located in another .c file) work for
> you? Or maybe you would prefer an MFD on top of the GPIO driver?
>
> As for the later case, I am not willing to re-implement GPIO support in
> an alternate driver for an already supported chip, it is too much work
> for the time I can spend on it.


drivers/pwm/pwm-max7313.c:

probe(platform_device)
{
  struct regmap = pdata;
  ...
}

--- 8< --- 8< ---
drivers/gpio/gpio-pca953x.c:

probe()
{
  struct regmap rm;
...
  if (dev_has_pwm)
   pca953x_register_pwm_driver(rm);
...
}

In the above regmap may be replaced with some (shared) container.

Or other way around. PWM registers GPIO (which actually I prefer since
we have PCA9685 case where PWM provides GPIO functionality, though via
different means)

-- 
With Best Regards,
Andy Shevchenko
