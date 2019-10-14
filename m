Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A9FD68EF
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2019 19:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfJNR7N (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Oct 2019 13:59:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40707 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfJNR7N (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Oct 2019 13:59:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id e13so2320033pga.7;
        Mon, 14 Oct 2019 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XN1W11UdnVSpmM8IBnNjLEn4Slzsx790GpHtKtPVAlo=;
        b=V60ItJYNKZfadf+Ceewo994i+FEZYS4kU89CY6CLJ2GaPSAo8Py82mDvlMV6izozS3
         un9AB+fn72Z0RtEFjVwlQeYqgz0hNpvr9qTvV5YETqUQx1b/lzASdk9NSC+Ocvv3BRqA
         myuHSRQQ6K5IDKPWh7IAJBuP/0tu9m3H5NXCitwRUrQZXuedisaxE69bftubVJNMPp5G
         nR2txXx17bX0tg1CdPc7yfZXiKNGq7S/HKjC7WEJ9Cof1qgkgy6QdDHYMq9BDRILp/ub
         sS3fDU1OMOf+gOTopKogew7GgH3K1s/5R9g6Ucy83+ki9uwE2IajqqdJvRH++pznvUf+
         Otaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XN1W11UdnVSpmM8IBnNjLEn4Slzsx790GpHtKtPVAlo=;
        b=oWWKR3OjaKgB7NC5iYI5QNZIVbxrP5kFpIZy0mY38cK0NwJ/KELwh+lm4BQyMpNvkT
         j0/l5eNAw30GLr3NHxH0TvxP1sTyE+FkGe8iff0qhnebFOKBm16L9WHdGzWs3M4jUvv9
         HP3mO5dLcuPnnbfZzcJktNx+j7i/1VXYtL/56xeMBkZZitJRyn7X88Cgg1ZqJ1vApypx
         uC/hHlAt8qunfGAy4MFN4JO9URx6iPnHuP+mwGQayr+HCh1bitnw09VyZYFSRl8Co3fD
         S3ew/4GLvVANX7Gaw6mdf6BMDiJCDAcwVsznKMya3O7sXF0FZSqq+ISSVNEARwMa3qlU
         YTeg==
X-Gm-Message-State: APjAAAVkrYem8Mt3/bsLXNgJBIqSWJ+PxMkvz/k8gv5yRlJdM0QeK0eF
        cZR3EBgUDzi4C7QaBwz2L/G5+582K2dGDHDM1JA=
X-Google-Smtp-Source: APXvYqzraupcIWwI76kQ4DY04c/kHa31m8HupWF67hdf3F6diQxFBi44IWY2xMjlmWlZ/dDNeOT+L8ZlW0sC7Eacqt8=
X-Received: by 2002:a17:90a:b391:: with SMTP id e17mr38652318pjr.132.1571075952238;
 Mon, 14 Oct 2019 10:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191014124803.13661-1-miquel.raynal@bootlin.com>
In-Reply-To: <20191014124803.13661-1-miquel.raynal@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 14 Oct 2019 20:59:01 +0300
Message-ID: <CAHp75Vc4vnNVKc+Q_TY8DpwV4rLZYGm2MvGBC7r67XjmtNoskQ@mail.gmail.com>
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

On Mon, Oct 14, 2019 at 4:09 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> The MAX7313 chip is fully compatible with the PCA9535 on its basic
> functions but can also manage the intensity on each of its ports with
> PWM. Each output is independent and may be tuned with 16 values (4
> bits per output). The period is always 32kHz, only the duty-cycle may
> be changed. One can use any output as GPIO or PWM.

Can we rather not contaminate driver with this?

Just register a separate PWM driver and export its functionality to
GPIO, or other way around (in the latter case we actually have PCA8685
which provides a GPIO fgunctionality).

-- 
With Best Regards,
Andy Shevchenko
