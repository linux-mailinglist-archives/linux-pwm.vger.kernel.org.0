Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A248C51DDA
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jun 2019 00:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfFXWCR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jun 2019 18:02:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42414 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfFXWCR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jun 2019 18:02:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id t28so14111546lje.9
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jun 2019 15:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XtbMn3xFs7FmnICFe6DhpFIKouWcZNSxkCHmQ/+Ylc=;
        b=izb2Z46NzMUkEEC4KRpeTZxTRLJ0GQ/RzhAb8ief9AuLtSRsxtyGojyTaRXUHuLRF1
         Y1K1Hj+ItpQFmYCDMraMDoN6XKefXr/fA2S8lixYzb6lN+40iNMZAwugGK8wDaIMlihe
         GnpLw8qtECPRTbWEMTN4v6XVwOgmV0JI/tyVx9mdyNZyMPiICLek7nR5F+BVEJ6kQcqU
         ZPQK7vlfl2br4pdVVLyjIF2wmIT5LthddzXtyklfp3JOeQBYHHElDedyH9Pfi4UkF1mQ
         QU0A3nRr+NuNXpcAu8UNX2jUf/t5J1gt+oqip44qh7spUrxSVnv6owch92cePWrvXSMi
         c6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XtbMn3xFs7FmnICFe6DhpFIKouWcZNSxkCHmQ/+Ylc=;
        b=cscVZIpT7a4dzgLiUNp9VXoaz3RMJrEwqO9HqM3WUnib4OYHbfefwRCUA6qjSH1zzw
         1PazNLv2s6wycNOmIdGbobIc0qW2ZGv4u/geS2CiLCYT90XivTvZASltm8pd4nuffCcC
         wxuHxM4E7wqE6mUiOzc5v/KC8+kX6iMnmgmHG9N3SEKQ01TGvl5j0//564mnNBFsTFpP
         JiEIG0ZKAA+AzxZJJlm+l6CZZC1v07ZIUsBs2ZFl58evM2XVDSM6La8SXZUAQpPBuk9e
         UPcSuKE24YwAKLHdxzmEZwwC9aW6ThheyPozFqG/pgvOlpEgWZoMiqpSDQx7akVSr9ax
         Tl8A==
X-Gm-Message-State: APjAAAVQzLZZ4N3LzMLYHXWpCrFts3UaEfmOkqiyQH7XRZdf5UUKbqYM
        jDQuGkoJ7NyjjMhaL6wXhC6aLw7+Jxzz5SRsDqVrNg==
X-Google-Smtp-Source: APXvYqz94aRYtRYpNe6kqWgritXzE0c6aWIYSvz2gxrGE8hvN+/7y7do5SKF1vQxUBqEL72NonVRvHe+q4JNPmoe7sI=
X-Received: by 2002:a2e:81d8:: with SMTP id s24mr31105577ljg.37.1561413735780;
 Mon, 24 Jun 2019 15:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190522163428.7078-1-paul@crapouillou.net> <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
 <20190621135608.GB11839@ulmo>
In-Reply-To: <20190621135608.GB11839@ulmo>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 00:02:02 +0200
Message-ID: <CACRpkdY4xgtYVto8fM-TSGWbDEsJpj=Fx2zXHPaZTJ6m1JuWQw@mail.gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered down
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        od@zcrc.me, linux-pwm@vger.kernel.org,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jun 21, 2019 at 3:56 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> I'm not sure this would actually work because I think the way that
> pinctrl handles states both "init" and "idle" would be the same pointer
> values and therefore pinctrl_init_done() would think the driver didn't
> change away from the "init" state because it is the same pointer value
> as the "idle" state that the driver selected.

Right.

> One way to work around
> that would be to duplicate the "idle" state definition and associate one
> instance of it with the "idle" state and the other with the "init"
> state. At that point both states should be different (different pointer
> values) and we'd get the init state selected automatically before probe,
> select "idle" during probe and then the core will leave it alone. That's
> of course ugly because we duplicate the pinctrl state in DT, but perhaps
> it's the least ugly solution.

If something needs special mockery and is not generic, I'd just
come up with whatever string PWM needs, like
"pwm-idle", "pwm-sleep", "pwm-init" etc instead of
complicating the stuff done before probe(). These states are
only handled there to make probe() simple in simple cases.

> Adding Linus for visibility. Perhaps he can share some insight.

I think Paul hashed it out. Or will.

> On that note, I'm wondering if perhaps it'd make sense for pinctrl to
> support some mode where a device would start out in idle mode. That is,
> where pinctrl_bind_pins() would select the "idle" mode as the default
> before probe. With something like that we could easily support this
> use-case without glitching.

I would say the driver can come up with whatever state it need for
that and handle it explicitly. When there are so many of them that
it warrants growing the device core, we can move it into
drivers/base/pinctrl.c. But no upfront design.

> I suppose yet another variant would be for the PWM backlight to not use
> any of the standard pinctrl states at all. Instead it could just define
> custom states, say "active" and "inactive".

I would suggest doing that.

> Looking at the code that
> would prevent pinctrl_bind_pins() from doing anything with pinctrl
> states and given the driver exact control over when each of the states
> will be selected. That's somewhat suboptimal because we can't make use
> of the pinctrl PM helpers and it'd require more boilerplate.

The helpers are just for the dirt-simple cases anyway.
At one point one developer thought that the "default" set up
before probe would be the only thing any system would ever
want to do with pin control. It seems like not.

Yours,
Linus Walleij
