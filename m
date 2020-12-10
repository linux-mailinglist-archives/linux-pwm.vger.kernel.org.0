Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7CE2D6A0A
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Dec 2020 22:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394085AbgLJViC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Dec 2020 16:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394050AbgLJVhy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Dec 2020 16:37:54 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22EEC061793;
        Thu, 10 Dec 2020 13:37:13 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id v185so1590284vkf.8;
        Thu, 10 Dec 2020 13:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oO4d+S9YKM1pH0Lm9beVGewfmjAa6w60PNlPdJrLfTI=;
        b=AbklrVmERaOF7Qt9rKuET+0352rMiVQ8cbfPDQ/X6XUabw04OcRQ9HfFP9bIMaGgVm
         pefWQA9Ac+bZhhkxw+z29JItqpnBuNHSk/XizwjfAeBLf5PRTXDb5YD3IpaE7pYUHOlF
         bLStIOo1VT5+wZMpvJ1/Q6wRG5tovwzEI8GMa5YDr1GnCtYzS5WZLuM8ZEHTKKfAVl/e
         OT6VyctrDMwYYHKkXdu8mPEJkcyNeGYvyl7yow4kdaMEVn6J0GzfxX+rXELO3JWd6qWX
         k7A14OjBa2N77qAQYWLVb1QNa6B/C53WHTW3fkeVm0ao0XZLazLHzhjZCFLEL3p9/f9R
         dlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oO4d+S9YKM1pH0Lm9beVGewfmjAa6w60PNlPdJrLfTI=;
        b=YVuKNkkqj8zQ/HnqwaNZ4wMEA8QiqYEcXSLZlAt1VhYw81tW5h0G7PUdnI4Nnw1EeK
         iWCkka8/6aeR+Q4DypW5QPCsUNPHVVkeQ3rUHETY2wFO1x+nRql1fJHGXrNUFhU555ZW
         K2O0s8+m8BOnLT8wZC+Fh1qjNrQiWAilcFX2tGJQmlCO/naRT8VFlMuo0VEl4paNg8Ib
         WAt8BChs5FUbsUwm2TtGihfgLn2ETz9yn4Io2i/wRhyW1xCNH8FEFqhz+7VKMvDUXG9p
         cGbs42aB1xiylEEDYXtTbT34GjJb9fmVmZuot1VV1hLjpqI8+q/gxg4yAwzm22lso54S
         lT0A==
X-Gm-Message-State: AOAM533Ot8oTcF1damKDzEsk8YWR+ZPsYfrHQ/0tusvtmyHEZEtkH2ak
        yoanfdayAAdpo++w064tZ59q3njkSmDMDtkGVUR1nk+zCNEvYg==
X-Google-Smtp-Source: ABdhPJwkHN1JBbLSIJjm3TdHN20gsBdUOu+Mkza2Ot33DX96DdS6DCnAJqN/jgkXMPt+ab3tdANGrvLRoLbYUTW1kqw=
X-Received: by 2002:a1f:9987:: with SMTP id b129mr11047352vke.5.1607636232804;
 Thu, 10 Dec 2020 13:37:12 -0800 (PST)
MIME-Version: 1.0
References: <X863KNo0IaekkU7q@workstation.tuxnet> <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de>
 <X89RgpTb3sBBI++w@workstation.tuxnet> <X8+DI7ZN7mXtsxv9@ulmo>
 <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
 <X8+waLH58pOaMI06@ulmo> <20201208182637.hm5uzuw5ueelo26k@pengutronix.de>
 <X9EDGHySNYb7CxcW@ulmo> <20201210090124.rfswkrcttsg5gszp@pengutronix.de>
 <X9JWlVPb9ZGdB4q9@ulmo> <X9KK9UrXu+b8F+IT@workstation.tuxnet>
In-Reply-To: <X9KK9UrXu+b8F+IT@workstation.tuxnet>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 10 Dec 2020 16:37:01 -0500
Message-ID: <CAGngYiVAKraGxOYe5bCNhzhPSvFMh5u7cZ-ENqzTv4kvbNjryw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Dec 10, 2020 at 3:54 PM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> After reading your reasoning in this mail and rethinking the whole
> situation, I do no longer have any objections to the more complex
> solution. (Allowing 0% and 100% duty cycle channels with any period)
>
> I first thought it would be too confusing to block users from changing a
> duty cycle when in reality the period is the problem.
> However, if we log an error message, explaining that the periods have to
> match if duty cycles > 0 and < 100% are used, I think it's OK.
>
> Uwe, Sven: Do you have any objections?

No objections, as long as the "fully flexible" solution doesn't get too
complex. Complex code is hard to maintain and extend, but obviously that
decision is for Thierry or Uwe to make.

Thinking this through a little bit, I don't think the "fully flexible"
solution has to be that complex. Keeping track of prescale-inuse may
have to involve a bitmask and not a counter, such as here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pwm/pwm-pca9685.c?h=v5.10-rc7#n81

That way, channels can do set_bit() to mark that they use the prescaler,
clear_bit() when giving up the prescaler, and if (bitmap_weight() <= 1) to
check if they can make a prescale change.

But this is theory - the only way to find out what's best, is to actually
write the code...

> If not, I will prepare a v5 next week.

Looking forward to it, thank you !!
