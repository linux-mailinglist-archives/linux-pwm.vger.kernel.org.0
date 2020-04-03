Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C4B19E18C
	for <lists+linux-pwm@lfdr.de>; Sat,  4 Apr 2020 01:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgDCXsL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Apr 2020 19:48:11 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43902 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgDCXsL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 19:48:11 -0400
Received: by mail-ot1-f66.google.com with SMTP id a6so9162938otb.10;
        Fri, 03 Apr 2020 16:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qAvXoX+HxvORqDYqk1Ywo54Ongb6oZlHuDXpQGxzhDg=;
        b=tWUf9S4VVHExI7eqLi5KqBWhzhncLRFWGvrT/TM2NdaocVgVY5KXUwAveByOlVa2UH
         KRRFUBbitnHyPicHtquYvtMq91AQe1Nf3nvh42Ip3l52/SqBVLDkC3ULAkd5PHHJHTX6
         PrDgccJ+xKMxcVBqX/6XkiZ+dhZQSq7gC7epjxcqrfWou55YR/Y3T+MjCkepn0UELBLo
         qlUL50Xlm+U28O/VJifIL+tEYDrKJy8jpZ7yDKvuhTYRsFRopUgNTjZsGJ0dnmaV5/PG
         H+DOP8I9vLCzW9yXjYoGZNM/+2C8YNkpf43frCpW1CoeHmfI5MXVKvJFYB9dX0vy+PgD
         AX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qAvXoX+HxvORqDYqk1Ywo54Ongb6oZlHuDXpQGxzhDg=;
        b=E6xRAVTsNuEyMLcic03032EPNXkPOxkHfhMDgOV5S1P5cuSxYEMM/3hGST2jH5el2w
         QiA/S5g940sbmRCFX/xyzd98csDNa2UEpeC1hTnuMZz4daCGPQntm2Kv8ekhF7qixvZp
         QkgJR40wZWy99m0p1vKdd7gJvCi1/W9fobyeYhY+j8aeRqKEt3yMzA0/WUnOkPVo+eL9
         Ruo4eK3188c7bY8At3ThzipO2jNThtMdSKpIv10mPixp1ONP3onsLVN2Oo0kfHjkWSjd
         IHmMbKsFJE7QfC8ZOd4vgAXUEK6n6i2NdanW0hjovL8XDcCrLT7dyI4qMvQuO487R+d9
         O1kg==
X-Gm-Message-State: AGi0PuaGJyVdtCD1Da0hRU7FfKHrwiUtT/ATOLMDWsDOHzOcAaZbCRhj
        PDkVmEH3J/DubbTy7fwRZbw47PcOR7ZQIAfiiKc=
X-Google-Smtp-Source: APiQypKwwlYRFZZ/wQVVYqbNJKIppJyjZy0kYCbw6QSx1WCzU0+CVyM2BNm6GYYj6JuAcy7eh9clMmOQExgpSh1MBlQ=
X-Received: by 2002:a9d:6a05:: with SMTP id g5mr8713103otn.116.1585957690400;
 Fri, 03 Apr 2020 16:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226151034.7i3h5blmrwre2yzg@pengutronix.de> <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
In-Reply-To: <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 3 Apr 2020 19:47:58 -0400
Message-ID: <CAGngYiUinGeppRdnsWvX4DBLVcHFBSGWamUKdTC+rTY3kpFWcQ@mail.gmail.com>
Subject: Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle
 struct element
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Feb 26, 2020 at 12:04 PM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> >  - Is this racy somehow (i.e. can it happen that when going from
> >    duty_cycle/period = 1000/5000 to duty_cycle/period = 4000/10000
> > the
> >    output is 1000/10000 (or 4000/5000) for one cycle)?
>
> It currently is racy. It should be possible to fix that either by
> updating all 4 registers in a single I2C write, or by using the "update
> on ACK" mode which requires all 4 registers to be updated before the
> new setting is applied (I'm not sure if this mode would require using a
> single I2C write as well though).

Matthias, did you verify experimentally that changing the period is racy?

Looking at the datasheet and driver code, it shouldn't be. This is because
the OFF time is set as a proportion of the counter range. When the period
changes from 5000 to 10000, then 5000*20%/5000 and 10000*20%/10000
will result in the same 20% ratio (disregarding rounding errors).

This is documented at the beginning of the driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pwm/pwm-pca9685.c?h=v5.6#n25

Should we move that comment to pwm_config(), so future versions of
ourselves won't overlook it?
