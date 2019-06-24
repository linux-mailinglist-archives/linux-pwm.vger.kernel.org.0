Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAD25178B
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2019 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbfFXPqe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jun 2019 11:46:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50421 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730829AbfFXPqe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jun 2019 11:46:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so13303434wmf.0
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jun 2019 08:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VkRib9MjDERFnyai1bhB1E+iVO+Fk8rJH+jZvg2+AEA=;
        b=YBhKFOTU2fXjolvY4Qy/+XKi9E/Cp+F6Bw0F+7n1AcoYyxFCZY6ypfkpAZg3yvFkne
         9MbjCmwEOTZeSv3spSSBgvN3RPNUJEhi1KfrpwkqWrHSk+TIRnFdH0xBgmcKOhtUcjTc
         K8Nr/PiV6tyA70wiFCVYRD/oQKFgHSQx2YAjMeihJQKNBh4u6EiD5Ae+J9oV2FMw47BB
         Hjh/MqmFysFWh5KS4z+axkUZeMsX7MY59W5zBU9doO6VDZGYAjFSz+cC9guPoKZAasOu
         AuLn5sybQegICFCpATc5Rv/JFcSe7yw88XJjqAvSgrkaGerCXts44A165QN7iWcnZxku
         E/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VkRib9MjDERFnyai1bhB1E+iVO+Fk8rJH+jZvg2+AEA=;
        b=r+t5F0YfvAODiE42T/XzL5a2f1gaQ+X1MInYSKhtglvaJJ81bTl/8AmeNOhL/Ydx8T
         +ZOM+gMA1xlFbPDLMGdbHrtY6of8pPzl1jdHw5wmh5nDgJsbM5qQKiR+4lgc3wCVao/X
         HcC1AcgyV4t3RcZaDvOI7eLfXyDozW8pqEr1LI6/pV9XCeNLeZP5xZQyx4PMFTIQrJZw
         ycQY6IgunABnERbom63ZSOAbb0791ubfsBHgPGgZcTDkQMfosftw8ggDht6kgizYT5iS
         jCFbXmauR/evW2mMpcPxVu6BmTuZ9SOwX5aG0ebwFL08ScYPyN+fT9vcAxjjEBLIUSbQ
         Oelg==
X-Gm-Message-State: APjAAAW7Tace+86Ex03K+QpC/sNXhGq2dM1mEN6XbZRWrW97+/YZePKP
        I0uklq7GMaTI5w7j/BaM+4Jnxw==
X-Google-Smtp-Source: APXvYqyJCeVLgWy2hZZ6ZYHRLkIgXsmBRb1EzM5JnZ45W5XFy3eHef+64qI8NKnV76mr+c/SgwP1XA==
X-Received: by 2002:a1c:e341:: with SMTP id a62mr17120203wmh.165.1561391190915;
        Mon, 24 Jun 2019 08:46:30 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a67sm10295275wmh.40.2019.06.24.08.46.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 08:46:30 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:46:28 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        od@zcrc.me, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered
 down
Message-ID: <20190624154628.rq7ykltms7ovhawx@holly.lan>
References: <20190522163428.7078-1-paul@crapouillou.net>
 <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
 <20190621135608.GB11839@ulmo>
 <20190624112844.fmwbfpdxjkst3u7r@holly.lan>
 <1561386717.20436.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561386717.20436.0@crapouillou.net>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jun 24, 2019 at 04:31:57PM +0200, Paul Cercueil wrote:
> 
> 
> Le lun. 24 juin 2019 à 13:28, Daniel Thompson <daniel.thompson@linaro.org> a
> écrit :
> > On Fri, Jun 21, 2019 at 03:56:08PM +0200, Thierry Reding wrote:
> > >  On Fri, Jun 21, 2019 at 01:41:45PM +0100, Daniel Thompson wrote:
> > >  > On 22/05/2019 17:34, Paul Cercueil wrote:
> > >  > > When the driver probes, the PWM pin is automatically configured
> > > to its
> > >  > > default state, which should be the "pwm" function.
> > >  >
> > >  > At which point in the probe... and by who?
> > > 
> > >  The driver core will select the "default" state of a device right
> > > before
> > >  calling the driver's probe, see:
> > > 
> > >  	drivers/base/pinctrl.c: pinctrl_bind_pins()
> > > 
> > >  which is called from:
> > > 
> > >  	drivers/base/dd.c: really_probe()
> > > 
> > 
> > Thanks. I assumed it would be something like that... although given
> > pwm-backlight is essentially a wrapper driver round a PWM I wondered why
> > the pinctrl was on the backlight node (rather than the PWM node).
> > 
> > Looking at the DTs in the upstream kernel it looks like ~20% of the
> > backlight drivers have pinctrl on the backlight node. Others presumable
> > have none or have it on the PWM node (and it looks like support for
> > sleeping the pins is *very* rare amoung the PWM drivers).
> 
> If your PWM driver has more than one channel and has the pinctrl node, you
> cannot fine-tune the state of individual pins. They all share the same
> state.

Good point. Thanks.


> > >  > > However, at this
> > >  > > point we don't know the actual level of the pin, which may be
> > > active or
> > >  > > inactive. As a result, if the driver probes without enabling the
> > >  > > backlight, the PWM pin might be active, and the backlight would
> > > be
> > >  > > lit way before being officially enabled.
> > >  > >
> > >  > > To work around this, if the probe function doesn't enable the
> > > backlight,
> > >  > > the pin is set to its sleep state instead of the default one,
> > > until the
> > >  > > backlight is enabled. Whenk the backlight is disabled, the pin
> > > is reset
> > >  > > to its sleep state.
> > >  > Doesn't this workaround result in a backlight flash between
> > > whatever enables
> > >  > it and the new code turning it off again?
> > > 
> > >  Yeah, I think it would. I guess if you're very careful on how you
> > > set up
> > >  the device tree you might be able to work around it. Besides the
> > > default
> > >  and idle standard pinctrl states, there's also the "init" state. The
> > >  core will select that instead of the default state if available.
> > > However
> > >  there's also pinctrl_init_done() which will try again to switch to
> > > the
> > >  default state after probe has finished and the driver didn't switch
> > > away
> > >  from the init state.
> > > 
> > >  So you could presumably set up the device tree such that you have
> > > three
> > >  states defined: "default" would be the one where the PWM pin is
> > > active,
> > >  "idle" would be used when backlight is off (PWM pin inactive) and
> > > then
> > >  another "init" state that would be the same as "idle" to be used
> > > during
> > >  probe. During probe the driver could then switch to the "idle"
> > > state so
> > >  that the pin shouldn't glitch.
> > > 
> > >  I'm not sure this would actually work because I think the way that
> > >  pinctrl handles states both "init" and "idle" would be the same
> > > pointer
> > >  values and therefore pinctrl_init_done() would think the driver
> > > didn't
> > >  change away from the "init" state because it is the same pointer
> > > value
> > >  as the "idle" state that the driver selected. One way to work around
> > >  that would be to duplicate the "idle" state definition and
> > > associate one
> > >  instance of it with the "idle" state and the other with the "init"
> > >  state. At that point both states should be different (different
> > > pointer
> > >  values) and we'd get the init state selected automatically before
> > > probe,
> > >  select "idle" during probe and then the core will leave it alone.
> > > That's
> > >  of course ugly because we duplicate the pinctrl state in DT, but
> > > perhaps
> > >  it's the least ugly solution.
> > >  Adding Linus for visibility. Perhaps he can share some insight.
> > 
> > To be honest I'm happy to summarize in my head as "if it flashes then
> > it's not
> > a pwm_bl.c's problem" ;-).
> 
> It does not flash. But the backlight lits way too early, so we have a 1-2
> seconds
> of "white screen" before the panel driver starts.

That's the current behaviour.

What I original asked about is whether a panel that was dark before the
driver probes could end up flashing after the patch because it is
activated pre-probe and only goes to sleep afterwards.

Anyhow I got an answer; if it flashes after the patch then the problem
does not originate in pwm_bl.c and is likely a problem with the handling
of the pinctrl idel state (i.e. probably DT misconfiguration)

So I think that just leaves my comment about the spurious sleep in the
probe function.


Daniel.
