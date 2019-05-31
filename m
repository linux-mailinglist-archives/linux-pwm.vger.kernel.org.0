Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 252F130961
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2019 09:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfEaHek (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 May 2019 03:34:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45508 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaHek (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 May 2019 03:34:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id u10so59647lfm.12;
        Fri, 31 May 2019 00:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gwut1JTjUDkHfWjDjwWnt8ushDmrjrzM6kQw1ev8x6I=;
        b=G7PZjT2bLD/L7q1m6jSKfZmjawqiQLZdmQ8nq9y8vno+2AyjbR/YTuh9LX5TxSwCft
         eo3TYJJ6iC5WUWV+Ty9cNV9OQS8RjHWWMwbIjFAwYi40Q9AopNNXtxeTxfkD7Ni9zfSd
         qhzF4MHTRTPsdkgSSNrFUSArGnXdHw1qAY+B+XDYq7gLD0tBitu0RmTn3MVbhK9V6cVS
         30bWeGsqorm7Isq5WRpLwVIFWV0k5uaO9IFVUehTj5cXQjO6Z+ZT4ywuEM0gTwmD3S+X
         jvi2EjGyek4DcQsn1ifJQU9nX/4ng4hlSR+tZx55r5aPTdCFS+0cHw7PSwdCy0iPx0CJ
         BM9g==
X-Gm-Message-State: APjAAAXC+B11oPI7r2K3CGNFsw38Gr+KrBVUNGznI0sgrznXoodlb3CA
        9E8T3Wh4rNVjzWvbUbYycWmeUvWmU6GIuP1fy9Zws4Nf
X-Google-Smtp-Source: APXvYqw0TgJiz7aQFboZp2pAlaj/oyVLrZjUw1+MWgrToJFtEGTM6bpli+TY1fHj1Wvdl8JKneG3XoeCskAA1eLL2Fk=
X-Received: by 2002:ac2:546a:: with SMTP id e10mr4659892lfn.75.1559288077991;
 Fri, 31 May 2019 00:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <1559211367-25106-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559211367-25106-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1559211367-25106-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 May 2019 09:34:25 +0200
Message-ID: <CAMuHMdXVVOvoZ4S9LC=RD_8r-XJ6tPt512rONjv8QEK0L=akww@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] pwm: sysfs: Add suspend/resume support
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Shimoda-san,

On Thu, May 30, 2019 at 12:21 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> According to the Documentation/pwm.txt, all PWM consumers should have
> power management. Since this sysfs interface is one of consumers so that
> this patch adds suspend/resume support.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c

> @@ -372,10 +373,109 @@ static struct attribute *pwm_chip_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(pwm_chip);
>

You may want to add a comment "takes export->lock on success" here...

> +static struct pwm_export *pwm_class_get_state(struct device *parent,
> +                                             struct pwm_device *pwm,
> +                                             struct pwm_state *state)
> +{
> +       struct device *child;
> +       struct pwm_export *export;
> +
> +       if (!test_bit(PWMF_EXPORTED, &pwm->flags))
> +               return NULL;
> +
> +       child = device_find_child(parent, pwm, pwm_unexport_match);
> +       if (!child)
> +               return NULL;
> +
> +       export = child_to_pwm_export(child);
> +       put_device(child);      /* for device_find_child() */
> +
> +       mutex_lock(&export->lock);
> +       pwm_get_state(pwm, state);
> +
> +       return export;
> +}
> +
> +static int pwm_class_apply_state(struct pwm_export *export,
> +                                struct pwm_device *pwm,
> +                                struct pwm_state *state)
> +{
> +       int ret = pwm_apply_state(pwm, state);
> +

... and "release lock taken in pwm_class_get_state()" here.

> +       mutex_unlock(&export->lock);
> +
> +       return ret;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
