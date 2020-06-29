Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BE020D620
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2020 22:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbgF2TRy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jun 2020 15:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731954AbgF2TRn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 15:17:43 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA3FC030F31;
        Mon, 29 Jun 2020 09:50:55 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o1so746758plk.1;
        Mon, 29 Jun 2020 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epjZAavl8OTnrmj035AkLkdZa01IVf7hDefQw4XclfM=;
        b=qfyP5RxgxAmyq6gPs73byd3YoUOiLlNFQvfce7YA6ZsR4onyELxfCTqCWi9/zFOy9v
         7ispQlUC7C62ftj66FOnsAaCx06Splb36D3NXxPefaLlEexM+/GJp5SzYtsGakl+mL8B
         eiPo23Xf8b/PqiyIqGS164oGgDUWUvPrIGy1sBMgspA0aqQBkcHfxRXfE3/2dFsV6dAW
         k11LT22CZUqLUqGH2Em2PSrz5m+H6cJgWvUB96mb2oPQvs7VGaO1I4H9d6J/iOgaigXr
         4af3bgasPy59TzF+5e2A/5fHzziw2TWZci3cAFqTzHOYBESugR9IwZ0F6+uS9vE1IZyq
         e9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epjZAavl8OTnrmj035AkLkdZa01IVf7hDefQw4XclfM=;
        b=Ds++611FQtbDfwjmK0Ja4x9B58g+eThFp+aRwufbE2vjFMIxtgfGgWbB+qHZSOJdKh
         5VsnBo8MQ/e2H3mNtffXUFLD2Ps4AcN9kHr36iYHIPL5ntx1ioOcUOHmT6F6ORvvbgW+
         poPI0MMFucKV5HvwCURQH1raQjhOBVlulKj3W3r64sSU5qp/4vN+IRns1HuxGBDd5vk0
         VWXkVyIEkbIQ9GQBHDI+CRTJo2gxuzAHOwZAjSdctc8LX2KFUTwCUmAD5MY6EKwcENhb
         5HYFoGRr8/QMhmeS9C0i0JeRg+HEKWW381w6z2lIqX7+WFSzLSFvzpCqCxMNdjinfH9T
         dvig==
X-Gm-Message-State: AOAM531qr4mxBjjAKaoH7SAMxSn+Ci3wz8LYyEKVulMaeNx020qu7ULY
        UQQkgwlPJjfciCCmyTDkTgvQAjzZORLlKmh1mmg=
X-Google-Smtp-Source: ABdhPJwK8VIW73nkc0kipwx1fUf9LlTusE2dlg042QQH/vsyXg7aXQu6OoBfFkAIfefdmaXBT/ZOhM4ezkR0DNBgt9w=
X-Received: by 2002:a17:902:8491:: with SMTP id c17mr6807522plo.262.1593449454975;
 Mon, 29 Jun 2020 09:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200503105453.23658-1-miquel.raynal@bootlin.com> <20200629160844.6ecf79c1@xps13>
In-Reply-To: <20200629160844.6ecf79c1@xps13>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Jun 2020 19:50:41 +0300
Message-ID: <CAHp75Vehv_Cp1AhMPhk8ktyp-uHSkgweqnhhSq_7w2Kf9y=7XQ@mail.gmail.com>
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jun 29, 2020 at 5:08 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> Miquel Raynal <miquel.raynal@bootlin.com> wrote on Sun,  3 May 2020
> 12:54:53 +0200:
>
> > The MAX7313 chip is fully compatible with the PCA9535 on its basic
> > functions but can also manage the intensity on each of its ports with
> > PWM. Each output is independent and may be tuned with 16 values (4
> > bits per output). The period is always 32kHz, only the duty-cycle may
> > be changed. One can use any output as GPIO or PWM.

> Can I have a status on this patch please?
>
> If it was forgotten, I would be good to have it queued now, otherwise,
> may I know the reason?

TWIMC, just my 2 cents about this patch.
I don't like it in this form. On the constructive side I can propose
at least two ways to solve:
a) introduce a PWM as a pin mode; move pca953x to pin control; use
this mode with PWM driver being separated from the pin control;
b) introduce an MFD that provides two parts for this GPIO & PWM.

Personally I would go with a) as I know at least one more pin
controller which will get an advantage of this (and it's definitely
not an MFD).

If GPIO / pin control maintainers consider this okay, I will rest my
case, but see above...

-- 
With Best Regards,
Andy Shevchenko
