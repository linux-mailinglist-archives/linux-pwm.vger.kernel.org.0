Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9E1253BC9
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Aug 2020 04:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgH0CCY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Aug 2020 22:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgH0CCX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Aug 2020 22:02:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC87C06136C;
        Wed, 26 Aug 2020 19:02:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so18774wrn.10;
        Wed, 26 Aug 2020 19:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltbgfeR4CcIa3n8+PRW2ashWBVJ/hYJD2qsUPYMSYSk=;
        b=l0iHo369LJRLdiMbIxzuCKs1kXfmBcdJYM08mnt9PKDUhNrg93qRTlFyvqgKxdsSFZ
         jtv7UqacpWXA8FhxsmBLeyvtaSzuYS+lhYOHTdD6w94afEMVbyt29ZOeS4yX0LRo9xvQ
         QW0OI1O59s4HoLkr0sPlSzORcdZeiyavfW6DyJac0JObqhKb6vzFzdUTlG76911hUKgn
         yqx6xCImCNppAmtSFdNc2h+EnxOzsArUICAlO5nOLWX5Z5hjVXFHUvCHi+BWFvrGAWRl
         vjtwCqc0tQdBDevst+xzeiRYoE4+nRzEXaMaOdUhtoNL3FtAO2nbcpaHcfPtXUkgSp0K
         8uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltbgfeR4CcIa3n8+PRW2ashWBVJ/hYJD2qsUPYMSYSk=;
        b=rn9+ImlqwNpbpu0e8JHB98D91oaX6M7XCUH7S8S5Lw4bKzrufhnV0aa5XGkV4fSBvo
         ULDxVo4+MgsTKjLfUQUo/Pw4GSbcDdp8M5S8PZgJx/hp2xYOz9rs1IcWuQGdC2YFOXFc
         05wknpzYm+gzsktCMSwLpbQh/fC7T+O3FNO1phpuwAH+yynMQawWsc8GB43aFv9/RSZ3
         BA8rpap0fcvcgh4MXsj8m/nnhCIy0eeMQVlZcipZxwCUmKhR8qKFjXq8Vh6iqn0c3xLt
         ReWAnO//M1ZCG4rly5q6vTaPTtWxOS2rqLKy+fUDucA6c7pj2/qZhWRMLgJqNhphhwmC
         eZ+g==
X-Gm-Message-State: AOAM531FO2tWYCkHLWdrJoDUVS/TmZxaNN+O18ghdNm18bxyP643BgF1
        jmbSjwEOenWd2qss67PGV3vDmU6Uhw23YK8r774=
X-Google-Smtp-Source: ABdhPJwEutQykNcVSnhy4lnuPbD9pz6OtKZyUZ1BHPD1zRFH1EZS/HbQoP6uTZaeBG/gB5POYEfTfQjfsOkv0EoRtuU=
X-Received: by 2002:adf:e68f:: with SMTP id r15mr17575849wrm.196.1598493740036;
 Wed, 26 Aug 2020 19:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200826144747.9436-1-krzk@kernel.org> <20200826144747.9436-5-krzk@kernel.org>
In-Reply-To: <20200826144747.9436-5-krzk@kernel.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 27 Aug 2020 10:01:43 +0800
Message-ID: <CAAfSe-vaCg7KVQfuNshs8g-dyXxVGEChvGdaxNOyK6qay65qYA@mail.gmail.com>
Subject: Re: [PATCH 5/6] pwm: sprd: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 26 Aug 2020 at 22:48, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks!

> ---
>  drivers/pwm/pwm-sprd.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> index be2394227423..5123d948efd6 100644
> --- a/drivers/pwm/pwm-sprd.c
> +++ b/drivers/pwm/pwm-sprd.c
> @@ -228,11 +228,8 @@ static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
>                         if (ret == -ENOENT)
>                                 break;
>
> -                       if (ret != -EPROBE_DEFER)
> -                               dev_err(spc->dev,
> -                                       "failed to get channel clocks\n");
> -
> -                       return ret;
> +                       return dev_err_probe(spc->dev, ret,
> +                                            "failed to get channel clocks\n");
>                 }
>
>                 clk_pwm = chn->clks[SPRD_PWM_CHN_OUTPUT_CLK].clk;
> --
> 2.17.1
>
