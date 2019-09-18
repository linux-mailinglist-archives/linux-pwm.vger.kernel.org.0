Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6BDB5E1D
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Sep 2019 09:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfIRHc3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Sep 2019 03:32:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41652 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbfIRHc1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Sep 2019 03:32:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id f20so3233652edv.8;
        Wed, 18 Sep 2019 00:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pMRyAAMSr25/uzv+iFU0HHBkFg5lhH7YB2umT/GPFT8=;
        b=pdsTmTy+6+Q3KzW0EazEZ7g19GTKEQLaHIJig5o32uIL90WCyNluMmi7IgiSgABr/K
         85of6LhqmoZeOXauE8IiDpegNb4jX5/WL6/EOnzeO1wUYamA2npdwvgWBAPBlGT0fRah
         KYOpf/yVBIyDsiz/Xmt/BB78+je7ODtw7VZcbNCt3a+P+ixY2zimr/wX864Htkf5sXSv
         p+lj32iVfIetG1hGab8bFUL0Are93w7mb7QkoQzUCUideCbABBENUuqeqtmjpBoMTOCe
         AhFAeNYr7KJ8DfO+hdsMnqICvSUJCgrKpFjOQtknuhqh7hjeRf/eaDHMqqCKh12M0AMR
         dRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMRyAAMSr25/uzv+iFU0HHBkFg5lhH7YB2umT/GPFT8=;
        b=JmuCg5bnNkFbPxq1jy2MAH4e+7Ug4NvCNSY4Z9ktHZTjbSFFzs92gUgCUS4peDGZj7
         OqIpQLZzbEVXoocs5OROE8pnRAaGMAvLDhp+ycuHtD92R/zWAqUBgNiaQKnP3Hfrs04r
         BZ3D9OgKt4jff9YHFj7/RY+rWkU7Yiw+KS1ECBYQlTOasH4BHD/mnzMtztNiL6UxCv/E
         qlnw8vuHde2RHg1qCld5oXWCufX41NJUNewZ2KSRLOoe8kymi2gVMoZhs/j5Dxc8+F7A
         x9fAG+m6eehL5CVmnLo5m3/h2xqCEyhcZdkhWEkM54iRy1p5BOBPH8r1J7r1zIfC2O9R
         zXbA==
X-Gm-Message-State: APjAAAUqsDlapWTOkTqHjCIN/9eDWVEWXX7UoOYFqSE9nTut1w6hefJW
        DBKAScp7kS9wv3SHrvGuKsbwjogwq4fXleCOxtPmug==
X-Google-Smtp-Source: APXvYqyjOF4Xb7nN31Q4FJYCioLbEXzRNdb/lNTMgmuOKR4VZGLQk0dI9XEY+6dnC7SllFvnYzEwM3ZvHGLZ33JzL1Q=
X-Received: by 2002:a17:906:4a19:: with SMTP id w25mr8286817eju.239.1568791944801;
 Wed, 18 Sep 2019 00:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-5-git-send-email-atish.patra@wdc.com> <CACRpkdaoBwqQ4V5Hm9f_G5_jrdkvjT5anhBK1_HoFTj6=cba-Q@mail.gmail.com>
 <d8fe9a17-283c-e2ad-9e01-2754b35699b4@wdc.com>
In-Reply-To: <d8fe9a17-283c-e2ad-9e01-2754b35699b4@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Wed, 18 Sep 2019 15:32:13 +0800
Message-ID: <CAEUhbmWmWr+dDEqtfwO8U1nXOOzfJ_1L+omVZEU=cZbnWgJpDw@mail.gmail.com>
Subject: Re: [RFC 4/4] gpio: sifive: Add GPIO driver for SiFive SoCs
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Wed, Oct 17, 2018 at 9:01 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> On 10/10/18 5:35 AM, Linus Walleij wrote:
> > Hi Atish,
> >
> > thanks for your patch!
> >
> > On Tue, Oct 9, 2018 at 8:51 PM Atish Patra <atish.patra@wdc.com> wrote:
> >
> >> From: "Wesley W. Terpstra" <wesley@sifive.com>
> >>
> >> Adds the GPIO driver for SiFive RISC-V SoCs.
> >>
> >> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> >> [Atish: Various fixes and code cleanup]
> >> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> >
> > (...)
> >
> >> +config GPIO_SIFIVE
> >> +       bool "SiFive GPIO support"
> >> +       depends on OF_GPIO
> >> +       select GPIOLIB_IRQCHIP
> >
> > I suggest to add
> > select GPIO_GENERIC as per below.
> >
> > Maybe select REGMAP_MMIO as well.
>
> ok.
>
> >
> >> +       help
> >> +         Say yes here to support the GPIO device on SiFive SoCs.
> >> +
> >
> >> +#include <linux/of_irq.h>
> >> +#include <linux/irqchip/chained_irq.h>
> >
> > Do you need these two? I think <linux/gpio/driver.h>
> > will bring them in for you.
> >
>
> driver.h only brings chained_irq.h. of_irq.h is still required. Right ?
>
> >> +#include <linux/pinctrl/consumer.h>
> >
> > Are you using this?
>
> My bad. Left over from the old code. I will remove it.
>
> >
> >> +struct sifive_gpio {
> >> +       raw_spinlock_t          lock;
> >> +       void __iomem            *base;
> >> +       struct gpio_chip        gc;
> >> +       unsigned long           enabled;
> >
> > Since max GPIO is 32 why not use an u32 for this?
> >
>
> Sure.
>
> >> +       unsigned int            trigger[MAX_GPIO];
> >> +       unsigned int            irq_parent[MAX_GPIO];
> >> +       struct sifive_gpio      *self_ptr[MAX_GPIO];
> >> +};
> >> +
> >> +static void sifive_assign_bit(void __iomem *ptr, unsigned int offset, int value)
> >> +{
> >> +       /*
> >> +        * It's frustrating that we are not allowed to use the device atomics
> >> +        * which are GUARANTEED to be supported by this device on RISC-V
> >> +        */
> >> +       u32 bit = BIT(offset), old = ioread32(ptr);
> >> +
> >> +       if (value)
> >> +               iowrite32(old | bit, ptr);
> >> +       else
> >> +               iowrite32(old & ~bit, ptr);
> >> +}
> >
> > This looks like a mask and set implementation, you are
> > essentially reinventing regmap MMIO and the
> > regmap_update_bits() call. Could you look into
> > just using regmap MMIO in that case?
> >
> > If you need examples, look at gpio-mvebu.c that calls
> > devm_regmap_init_mmio() for example.
> >
>
> That's really cool. Sorry, for not checking that earlier.
> I am pretty new to this.
>
> >> +static int sifive_direction_input(struct gpio_chip *gc, unsigned int offset)
> >> +static int sifive_direction_output(struct gpio_chip *gc, unsigned int offset,
> >> +static int sifive_get_direction(struct gpio_chip *gc, unsigned int offset)
> >> +static int sifive_get_value(struct gpio_chip *gc, unsigned int offset)
> >> +static void sifive_set_value(struct gpio_chip *gc, unsigned int offset,
> >
> > These functions look like a typical hardware that can use
> >
> > GPIOLIB_GENERIC and bgpio_init() to set up the accessors.
> >
> > See gpio-ftgpio010.c for an example.
> >
> > As a bonus you will get .get/.set_multiple implemented by
> > the generic GPIO.
> >
>
> Great. This will reduce the driver a code by a big factor.
> Thanks for the pointer.
>
>
> >> +static void sifive_irq_enable(struct irq_data *d)
> >> +static void sifive_irq_disable(struct irq_data *d)
> > (...)
> >> +static struct irq_chip sifive_irqchip = {
> >> +       .name           = "sifive-gpio",
> >> +       .irq_set_type   = sifive_irq_set_type,
> >> +       .irq_mask       = sifive_irq_mask,
> >> +       .irq_unmask     = sifive_irq_unmask,
> >> +       .irq_enable     = sifive_irq_enable,
> >> +       .irq_disable    = sifive_irq_disable,
> >
> > The handling of .irq_enable and .irq_disable has
> > changed upstream. Please align with the new codebase
> > as changed by Hans Verkuil:
> >
> > commit 461c1a7d4733d1dfd5c47b040cf32a5e7eefbc6c
> > "gpiolib: override irq_enable/disable"
> > commit 4e9439ddacea06f35acce4d374bf6bd0acf99bc8
> > "gpiolib: add flag to indicate if the irq is disabled"
> >
> > You will need to rebase your work on the v4.20-rc1 once it is
> > out. Right now the changes are on linux-next or my devel
> > branch.
>
> Will do.
>
> >
> >> +       ngpio = of_irq_count(node);
> >> +       if (ngpio >= MAX_GPIO) {
> >> +               dev_err(dev, "Too many GPIO interrupts (max=%d)\n", MAX_GPIO);
> >> +               return -ENXIO;
> >> +       }
> > (...)
> >> +       for (gpio = 0; gpio < ngpio; ++gpio) {
> >> +               irq = platform_get_irq(pdev, gpio);
> >> +               if (irq < 0) {
> >> +                       dev_err(dev, "invalid IRQ\n");
> >> +                       gpiochip_remove(&chip->gc);
> >> +                       return -ENODEV;
> >> +               }
> >
> > This is an hierarchical IRQ so it should use an hierarchical
> > irqdomain.
> >
> > I am discussing with Thierry to make more generic irq domains
> > for hierarchical IRQ GPIOs, until then you have to look at
> > gpio-thunderx.c, gpio-uniphier.c or gpio-xgene-sb.c that all
> > use hierarchical IRQs.
> >
>
> Thanks. I will convert them to hierarchical IRQ.
>

When will this series get respun and upstreamed?

Regards,
Bin
