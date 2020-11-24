Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0D22C2B6E
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Nov 2020 16:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389715AbgKXPey (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Nov 2020 10:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389340AbgKXPey (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Nov 2020 10:34:54 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF33FC0613D6;
        Tue, 24 Nov 2020 07:34:53 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id v8so10813285vso.2;
        Tue, 24 Nov 2020 07:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSahwMlPVKC+k3kYG3otLuHHfUicNi1S/Np+gD97NI0=;
        b=K/deaqEVY6aTzrqs6A1dV9MeM2e9ix2qrWfdFg7md/EVNIn59JTeoy0sgRmnDbcQiS
         z1IOgXwEK81gyG7lsTer6hoxdznAte4Q/3fgsx732+L75wuZDAV0xdeTLZbyp6c+ET0r
         rA3DEO4G21frdrUxddD8Qu1Tf0SIWtkb7LAuWPh/SYsZRqlXGmXkXA5hLZk/RNg2zzMj
         djBP5aQSsrToOFaLkGkvNnvlBB9G5tOSvCGnAfU9OKVfSQkY4M3ec2SowDnK2Mmuu38t
         2e20AnPViCUoQfYXdX3zexO9IoWgoRFXrsdMt55Rh1v6keg5s+lHGA2ra046mKQXFPOB
         AADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSahwMlPVKC+k3kYG3otLuHHfUicNi1S/Np+gD97NI0=;
        b=tBAE62A+yHofY+HpnXvqOk5bNjCj0cqByGglesL44Zm4rB4oV6agEQQ+beOlzU3j5a
         6KTJ6tCAfEzsBcaWrueGLN2jytgrajLK64Sv4lARrSsNUwh19krzczTinJaIys5sPxL2
         cUO0tCH+K2mVjvj98ySWmIVUSAjO9yCwo02JzpgAw5VvSMUoYFIFXAA2jyO0KI6tMh15
         EcknQCZ0Dxr6Vb6HeXOUZ7/ara2DKMoBKxhDD90E2u5KjEmCMegly9vktZxs4kRbv9Im
         XPbMtuQvVsBYbg4QF6bO2raFka+WR95aU4b1aSMEADDt2zTGf6gC6savtri6g3U+9MdM
         A5Hg==
X-Gm-Message-State: AOAM532kn3mE9gKQlAnHCLSkuKBuAwJM4UU67PvOrK8Fa/ee2LznRQe/
        WBzsvka6y0MTB1WZw03zYNQn6ighTAoZwFLz3B0=
X-Google-Smtp-Source: ABdhPJzH01ciWRir6svn8+Zir3hYQjEG0pjt/A2lxGqAy6ff5TJ5jBJl3RaA9o6zcNnUTX598G2jyt6/+5yJx3PCE7w=
X-Received: by 2002:a67:2084:: with SMTP id g126mr4429457vsg.42.1606232093012;
 Tue, 24 Nov 2020 07:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20201123163622.166048-1-clemens.gruber@pqgruber.com>
 <CAGngYiU8M0urUogQJf5-GS_rWmPa85TAVxdRD1EfkRK-EGQ7_w@mail.gmail.com>
 <X70kjlZpIaN1T1ml@workstation.tuxnet> <CAGngYiVkzm=D=hX=k7jL-ikApV4Xc0q+jzebMbqbQVoSAzSWYg@mail.gmail.com>
In-Reply-To: <CAGngYiVkzm=D=hX=k7jL-ikApV4Xc0q+jzebMbqbQVoSAzSWYg@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 24 Nov 2020 10:34:41 -0500
Message-ID: <CAGngYiUhWii29u06B5jq8gjYr8xW6L3VgLB0njaBxdKP2GdsTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] pwm: pca9685: Switch to atomic API
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Nov 24, 2020 at 10:29 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> My pleasure ! We are fortunate that you take the time & effort to improve
> this code.

By "this code" I meant the pca9685 driver in general. Just making sure
there's no possible misinterpretation :)
