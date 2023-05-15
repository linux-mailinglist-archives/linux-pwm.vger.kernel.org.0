Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EB2703C96
	for <lists+linux-pwm@lfdr.de>; Mon, 15 May 2023 20:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243229AbjEOS0w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 May 2023 14:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242268AbjEOS0n (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 May 2023 14:26:43 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C744C147FC
        for <linux-pwm@vger.kernel.org>; Mon, 15 May 2023 11:26:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-643b60855c8so11259470b3a.2
        for <linux-pwm@vger.kernel.org>; Mon, 15 May 2023 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684175202; x=1686767202;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8nDLK2/UtPYpjkGzQgMjFHISI8g4dhIQhzz/HAJjizQ=;
        b=VzQCZRAksp688aDHCze2QKDw4gDbSDmk/7FcVhbK74/m6v9JIPJN29FwDz/CpKRuu4
         AYUUq0xszUSjx478QtxOKODhNLs1oiAVKM9ObfmOiPziAay+XqANGvh61Rw3aKHSiAbj
         F4+BOTJWv0tdL4BCK42rCzY3s+dOlCRN1kBrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684175202; x=1686767202;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nDLK2/UtPYpjkGzQgMjFHISI8g4dhIQhzz/HAJjizQ=;
        b=PLQyT8XL1wTLDmzoV3a/ItwL1pTY8ab5961rMCHmvkE43KmKrlXPvFC7aoPOAuqwXe
         XAn4iPUJAKnhs1zmJ4qnNpV9sFSurzi4K5QlFIC3Ijjt8k5zvtpk7rxL64s7rOi9Sy+L
         ALYD7OyztG0VtEO/mtcpiFstsQGwSj9Xg/ir6KfsNGe9PVsncH1K1fFI4uV8hbweTPLb
         tIibF+naFDj5lGYXEIGBCFev5RzIs46pvp2R4l2k0Jg77mLlsqUxhJoDZTUYY+AZ0SxP
         ZWo6RFaZHZMqo9DYPEVjAjsLmGNf71BReZrDzZDgjilGCtEx3rjXxCQKNofVEPvIBrx2
         YI9g==
X-Gm-Message-State: AC+VfDzmAhfDZaIbdL83+j6I2YmwoV93Vm8BeDrTcyEZfazyaAuofpxW
        K1G68cNXKcZ9pXdm2Yh4M6+DalM33wATiyatLo8=
X-Google-Smtp-Source: ACHHUZ4aQfqZw6Qp6npvFlULnPUhZ0/waXw1czIIZFFyrkCIrLJ9X2JhPMn7TpJPRU2Mvq4qNQWzxQ==
X-Received: by 2002:a05:6a21:6d9a:b0:104:4558:b412 with SMTP id wl26-20020a056a216d9a00b001044558b412mr16795486pzb.25.1684175202286;
        Mon, 15 May 2023 11:26:42 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:23da:4841:44b9:fd1b])
        by smtp.gmail.com with ESMTPSA id j20-20020aa78d14000000b0064381853bfcsm12102119pfe.89.2023.05.15.11.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 11:26:41 -0700 (PDT)
Date:   Mon, 15 May 2023 11:26:39 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-pwm@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] pwm: sysfs: Do not apply state to already disabled PWMs
Message-ID: <ZGJ5X5UG6+TyqPpl@google.com>
References: <20230512164736.53615-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230512164736.53615-1-marex@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Fri, May 12, 2023 at 06:47:36PM +0200, Marek Vasut wrote:
> If the PWM is exported but not enabled, do not call pwm_class_apply_state().
> First of all, in this case, period may still be unconfigured and this would
> make pwm_class_apply_state() return -EINVAL, and then suspend would fail.
> Second, it makes little sense to apply state onto PWM that is not enabled
> before suspend.
> 
> Failing case:
> "
> $ echo 1 > /sys/class/pwm/pwmchip4/export
> $ echo mem > /sys/power/state
> ...
> pwm pwmchip4: PM: dpm_run_callback(): pwm_class_suspend+0x1/0xa8 returns -22
> pwm pwmchip4: PM: failed to suspend: error -22
> PM: Some devices failed to suspend, or early wake event detected
> "
> 
> Working case:
> "
> $ echo 1 > /sys/class/pwm/pwmchip4/export
> $ echo 100 > /sys/class/pwm/pwmchip4/pwm1/period
> $ echo 10 > /sys/class/pwm/pwmchip4/pwm1/duty_cycle
> $ echo mem > /sys/power/state
> ...
> "
> 
> Do not call pwm_class_apply_state() in case the PWM is disabled
> to fix this issue.
> 
> Fixes: 7fd4edc57bbae ("pwm: sysfs: Add suspend/resume support")

My first thought was that this still belongs as:

Fixes: ef2bf4997f7d ("pwm: Improve args checking in pwm_apply_state()")

but then I realized sysfs suspend/resume support was added *after* that,
so indeed, your Fixes tag makes the most sense.

And yes, I think this solution (addressing sysfs.c directly) is best
too:

Reviewed-by: Brian Norris <briannorris@chromium.org>

Side question: I wonder if this belongs in linux-stable. It's definitely
a bug fix, but the bug has been around a while, with a
{under,non}-specified ABI, and it's easy enough to work around I
suppose. But inevitably, *any* patch with a Fixes tag gets picked up by
somebody's cherry-picking bot, so maybe it doesn't matter...
...Anyway, I guess I'm saying it's probably going to go to linux-stable,
whether we want it to or not; and maybe that's OK :)

Thanks,
Brian

> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-pwm@vger.kernel.org
> ---
>  drivers/pwm/sysfs.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
