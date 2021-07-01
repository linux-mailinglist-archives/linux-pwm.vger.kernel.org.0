Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6373B8F41
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jul 2021 10:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhGAJBO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 1 Jul 2021 05:01:14 -0400
Received: from mail-vk1-f175.google.com ([209.85.221.175]:39714 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbhGAJBO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jul 2021 05:01:14 -0400
Received: by mail-vk1-f175.google.com with SMTP id k140so1118590vkk.6;
        Thu, 01 Jul 2021 01:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6KPfg0tVESChXRJsK+t+OfxLrBSHfHocGqt0EG9tjTU=;
        b=BV7yKrify+JoMinGqMuC7fYenMCWYVGOzkZc1OH5Y29nn83AFnwT2ZNyw+eLpng8nH
         J9ZfM6jKPc5TiXc6ZQtWxnOe4XPjdPQ8N3p8wJJNLBXkQvDz3peDduABajCHqNFdm5/D
         U2JZ7DoKBkLjbxhb43TlWl6aeQj41flzLinzIeMA93n6GbCutAar+TCWAJl8h9rfk/yr
         8u9XdULY7QHiyrV61DOECopghP58Wlehn9xn5WOQ2QiOkJpnyE683xEHqIh3pvR3WHYU
         8uK1lddlp/90i1Fd1o+yitBPv0cSCv3/HIw2KucK3ZdlR65rpMBCNbQtXUNPt34SD23n
         hSXg==
X-Gm-Message-State: AOAM530VkCmGSqHi0CYlfrWw9kUgvBeEcyKbgvxXk+vRjIEpzYYWvpnr
        Dc+Xb/1Go9xsTQAPaSP3+3ez7lTl2XG3qZS5QZ0=
X-Google-Smtp-Source: ABdhPJzK8TKwywu35MPaFki99NGXZpsVU0HWdQhYJvbHnQ+DCHHm2ClJb545/ESfpHGd8o3lad86K0SCuePmTk+h86U=
X-Received: by 2002:a05:6122:130b:: with SMTP id e11mr24469927vkp.6.1625129923582;
 Thu, 01 Jul 2021 01:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Jul 2021 10:58:32 +0200
Message-ID: <CAMuHMdWFL42BV9m7Oigvy0m7=-i4W0hnQT8izHdNNiYG0BfiMQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] pwm: Some improvements for legacy drivers
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Thu, Jul 1, 2021 at 9:29 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> this is the successor of my earlier patch "pwm: Ensure for legacy
> drivers that pwm->state stays consistent" that was applied shortly to
> next until Geert found a problem with it.
>
> I split the patch in three parts now: First the legacy handling is just
> moved to a separate function without any semantic change. Then a glitch
> is fixed, but without the regression I introduced initially. In the
> third and last patch the longstanding FIXME about breaking pwm->state if
> a callback fails is addressed.
>
> Uwe Kleine-König (3):
>   pwm: Move legacy driver handling into a dedicated function
>   pwm: Prevent a glitch for legacy drivers
>   pwm: Restore initial state if a legacy callback fails
>
>  drivers/pwm/core.c | 139 ++++++++++++++++++++++++++-------------------
>  1 file changed, 79 insertions(+), 60 deletions(-)

Thanks, works fine on Armadillo 800 EVA!
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5

That's plain v5.13-rc1, which is probably not what Thierry is targeting?

The first patch applies with some fuzz on my local tree including
yesterday's pwm/for-next and a revert of the bad version.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
