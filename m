Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B245940ECC4
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Sep 2021 23:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhIPVnj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Sep 2021 17:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhIPVni (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Sep 2021 17:43:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78374C061756
        for <linux-pwm@vger.kernel.org>; Thu, 16 Sep 2021 14:42:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g1so24188064lfj.12
        for <linux-pwm@vger.kernel.org>; Thu, 16 Sep 2021 14:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngsmooqXNsHgBKfkElGn8tQBGgJkqsh0GOhjTmfiKjs=;
        b=Kj9Y8gcTt4TgGUzYJFJ2xQFSkgUMMob94bgC1CKrrISQc/ZSgNlmv+sU681xqDsY9r
         Vwr2bEDqT4PrrP6NGXbI6Q6hxkGHLgXD+s5jnc8DEjWnPw9wsqsHMrCxxcYEKh8GzUJL
         +DPg40KBstQlzyJnALmo5nNGSDc73CSMDqayIMQKLpz79awy/N2BZe7+6NM2rVYXH7nK
         IX1v5ScwZvAdt0W6wT8BvHgVja6ZNrNpHFuEUy9w8PPKzRYMAYJuXznsbmI2uZUVfZkv
         iq79DmuCJVmruIvZjE4/I++5RjQckQuo6GeO+jAit+ESWIQe8n7O5SzLuipGCAi1UM9E
         ObSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngsmooqXNsHgBKfkElGn8tQBGgJkqsh0GOhjTmfiKjs=;
        b=By+HH9WUSMthHm7zYndMj7TVRgRtIOvzIhz8igZI8s8VUJzFCXORjYdo1uYB6ZjbfY
         eLEN0gLQluRiCHD3Jk2LLBT2Do8Gf7ZbbAtoa4ssaFERmQDmNZ3ItMNGZdKUznGYjfOF
         raFmZzQzZdvz3YxOqkbML3JeLO4HgUp51RVOCbd0HenxfJRr/8yvSOFvK7iO7wGhxF6x
         vGXvhhTWXWt7lvBjssgUwW/jWQlcXOmkF7ycYOS/u3DYcWiqfA7bIw830xG/ol64BAfM
         iLiK0oIP+uXnrCQdlru2TGhOSikRvrciqV2ziUuT2ievnZ2yldU786BPfl/7w9OHlIx5
         ZI3Q==
X-Gm-Message-State: AOAM532gzChKZtUY49EenQQYllShSbPf2T4fXnZRgZunn/TD6IVjgBYh
        x6EwdKzdaRntOLNYzXlDMXOOyjkPxJUgbtu90Jcflg==
X-Google-Smtp-Source: ABdhPJx10db8eaZ+I8ehLsyREKhLW1AoewhBK0s2SWPdi0X7r9/ZilW0iCTr41ebckupWObS1/ifTUFd4TeyT/L6S/g=
X-Received: by 2002:a05:6512:3c92:: with SMTP id h18mr5542169lfv.656.1631828535849;
 Thu, 16 Sep 2021 14:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210824164801.28896-1-lakshmi.sowjanya.d@intel.com> <20210824164801.28896-8-lakshmi.sowjanya.d@intel.com>
In-Reply-To: <20210824164801.28896-8-lakshmi.sowjanya.d@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Sep 2021 23:42:04 +0200
Message-ID: <CACRpkdYJkPgaz-BvQ1X0PHRCCbn0hrMDabouDwHkn+pr9d-dSQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 07/20] gpio: Add output event generation method to
 GPIOLIB and PMC Driver
To:     "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>, bala.senthil@intel.com,
        Dipen Patel <dipenp@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Lakshmi,

On Tue, Aug 24, 2021 at 6:48 PM <lakshmi.sowjanya.d@intel.com> wrote:

> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
>
> Intel Timed I/O hardware supports output scheduled in hardware. Enable
> this functionality using GPIOlib
>
> Adds GPIOlib generate_output() hook into the driver. The driver is
> supplied with a timestamp in terms of realtime system clock (the same
> used for input timestamping). The driver must know how to translate this
> into a timebase meaningful for the hardware.
>
> Adds userspace write() interface. Output can be selected using the line
> event create ioctl. The write() interface takes a single timestamp
> event request parameter. An output edge rising or falling is generated
> for each event request.
>
> The user application supplies a trigger time in terms of the realtime
> clock the driver converts this into the corresponding ART clock value
> that is used to 'arm' the output.
>
> Work around device quirk that doesn't allow the output to be explicitly
> set. Instead, count the output edges and insert an additional edge as
> needed to reset the output to zero.
>
> Co-developed-by: Christopher Hall <christopher.s.hall@intel.com>
> Signed-off-by: Christopher Hall <christopher.s.hall@intel.com>
> Signed-off-by: Tamal Saha <tamal.saha@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Reviewed-by: Mark Gross <mgross@linux.intel.com>

So this is some street organ machine that generates sequences
with determined timing between positive and negative edges
right?

I can't see how this hardware is different from a PWM, or well
I do to some extent, you can control the period of several
subsequent waves, but that is really just an elaborate version
of PWM in my book.

It seems to me that this part of the functionality belongs in the
PWM subsystem which already has interfaces for similar
things, and you should probably extend PWM to handle
random waveforms rather than trying to shoehorn this
into the GPIO subsystem.

Yours,
Linus Walleij
