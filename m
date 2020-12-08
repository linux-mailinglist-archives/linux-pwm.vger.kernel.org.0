Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58DB2D31E5
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 19:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgLHSQE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Dec 2020 13:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730483AbgLHSQD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Dec 2020 13:16:03 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D439C061749;
        Tue,  8 Dec 2020 10:15:23 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id t19so5912736uaq.1;
        Tue, 08 Dec 2020 10:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8SVSLFtz8XCFX35QtBBhLioF4VkLss3R+vxBxh9OlM=;
        b=IXMCJvQn8ys5LSKXqaH2S2FHBiJJTdR62QBskWNgyXtob6K6y0GNFeOLFVUToI7zCg
         ZmiNWtCVVMNIwMYRl4BIjrrBvOcsEwSYyVmw2RMBotSNbcjXjB3DOGG2yDbr2gYmq3xL
         JYt8C4BajLMBqq5eF1E68jmP1WycYUFzYP8SWoTjudEXQWgWyUjqN+nwRmSAnT3kxSMM
         z/+FVU1qQQtdp5Sgaisd2EsLpG3YBRjFDkCORNwTn/FgYi104NdMGV8QSpg+NWBApMPD
         kUGxeyZZuN6wOvhAiMizdYIOMbLeZKPixTKDvQ0Ve9wShEHRDdLndaB1X5ozuF76QoKq
         qQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8SVSLFtz8XCFX35QtBBhLioF4VkLss3R+vxBxh9OlM=;
        b=t5Qu7/gmT8aHFz7/5GuSPAxEk/aafqsB59NJ+IBw33aJYDgXRrgQRBeulA10Fvv1PQ
         CaWDH0ha9NJ69aeZoex8RLTT9rKXsS+exhCTpHcVWPrd2m8ykBHMliSJ7vRKAmTVbr3E
         ys/X9hf2lqtNEZgaASlaGIEcEnU9i3AhRmlUkuSBnlq2PMJFwVb7+9nZBcQgKiQXPeN5
         MTVLgWheyYmKOstJs9pRv5/9PP63oEA3dfgmbKyr9+NQr2ZfQ43wxyqSCfnW8LwVo2eB
         +AigfcUqu/NDttzyXIeg0iHLgk+8OEPpibhqw8CF2rnTs+hC/o0pl3a7iPY1BgVQPb3w
         t0ew==
X-Gm-Message-State: AOAM532CeDxVrjwsUjAMTQwZuvcAr2vbwce0PJGL016s3/hsLaqUFhCC
        XLZI5gbqFr2PMb6XNyoYqyVqemnuBSaoyMkRQ+Q=
X-Google-Smtp-Source: ABdhPJzJeaX9n16GCA7D55Jumfe08vdLPZG98CULXNKDaLkT/bhaI5P3Sn0PGpOBHNHsAyvUmUDbts7dJEco1sO7R/c=
X-Received: by 2002:ab0:4881:: with SMTP id x1mr17207972uac.101.1607451322316;
 Tue, 08 Dec 2020 10:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
 <20201207220025.42b6g76wq7ph5nvb@pengutronix.de> <X863KNo0IaekkU7q@workstation.tuxnet>
 <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de> <X89RgpTb3sBBI++w@workstation.tuxnet>
 <X8+DI7ZN7mXtsxv9@ulmo> <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
 <X8+waLH58pOaMI06@ulmo>
In-Reply-To: <X8+waLH58pOaMI06@ulmo>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 8 Dec 2020 13:15:10 -0500
Message-ID: <CAGngYiUP7BBF4i8YFXREA291dBTc4JytAFV9AoSjzMYTW7MyjQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
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

On Tue, Dec 8, 2020 at 11:57 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> Is this really that complicated? I sounds to me like the only thing that
> you need is to have some sort of usage count for the prescaler. Whenever
> you want to use the prescaler you check that usage count. If it is zero,
> then you can just set it to whatever you need. If it isn't zero, that
> means somebody else is already using it and you can't change it, which
> means you have to check if you're trying to request the value that's
> already set. If so, you can succeed, but otherwise you'll have to fail.

+1
I think your suggestion is an elegant solution to get the required behaviour.

One possible complication is synchronization. The sysfs interface has a lock
protecting against concurrent pwm_apply() calls. But the in-kernel
API (e.g. pwm_apply_state()) doesn't seem to. This is not normally a problem
when pwm bits are strictly separated. But in this case we have shared state
(prescale value and use count), so we probably need to protect pwm_apply()
with a mutex?

Not sure if it is currently possible *in practice* for two regulator consumer
drivers to call pwm_apply() from different threads. But Linux is slowly moving
towards asynchronous probing.

Uwe and Thierry, what is your opinion? Do you think we need to worry about
synchronization?
