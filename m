Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E847D3727
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Oct 2023 14:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjJWMtR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Oct 2023 08:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjJWMtR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Oct 2023 08:49:17 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E92DF
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 05:49:13 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c5720a321aso20487631fa.1
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698065351; x=1698670151; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5F2/b6x1LCbJBCL/hGp4wgBjwVGE9CeqqG2gwc9QLwU=;
        b=u39RIBv1Yj049P7EKDELlMkE6cGW3gTDyXQwBj2rcz0m6WyBqMjCkSanN+rhaIzljt
         +Pg3eXQT/4ew7gmEu2CRa6q5TxI+m0AZhmFGrAvazx91t02ZeWmIU6F7ptY+dxk56Bzc
         CTumJD39sqiuYB+8CFt/OvlkQsMIHraj549twqWRieHATy0pA6GxhDY5s36JIBxPhIdB
         CgQKsW4ogTIbVCbRyZq+iYecsQ7/BGdjuoQOKoTEGF6lO1Y7KIjSudYdvjmzWdW0WNgQ
         3+MnSMXhjtjP0AUW3n5SbvY9PvUsqsfQ7BOamSutWUWHJavf46fplBbE9hSdJoO0TnvS
         ZZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698065351; x=1698670151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5F2/b6x1LCbJBCL/hGp4wgBjwVGE9CeqqG2gwc9QLwU=;
        b=B3ZkieDEc3cjG6YsoDRCW7FLju1R4M+Jqt9MDe1P/2iVmjn5qTvBXAOYHpED37Bwy0
         XCGm3+s1C9kR1UIx7Z7yeWM1zIN+3Fvaftj4fWborkjpa8W9geqNIVYQ16qscuK4BDOz
         qsgp88r34W1iHqVoHHaFgJgd4kvJuVZGc7sYmR9uf8/a8szgEQgQ2DKvctiN7UYVg1+I
         5IQlUhCMnWGenGUWxZmCx01LaQBjMFrVcc6sQX1JN73+f7ifJpLdxWqwjVJPxQ8BMlcP
         28K71AQ/6LzGltT5Knfpt+JYWFvmoI95seBO2J95bQSJzWFpDq2RtbJnAmCI+uwEAWfk
         SdkQ==
X-Gm-Message-State: AOJu0Yy6QpsyxVbxA4fzYSGpod6BN7ejtJ77/KQHUyphVDLRV70uS+QC
        2oyv5rbVXOVUcxp7aPY9tdX/jg==
X-Google-Smtp-Source: AGHT+IGaTg0NdwZ2awpa8SRAqNobR151fbJLl50rAUDEuxtz05JE5xRAXwVriQOeZMaE926br6ZqKw==
X-Received: by 2002:a2e:7c15:0:b0:2c5:5926:de52 with SMTP id x21-20020a2e7c15000000b002c55926de52mr6031556ljc.53.1698065351491;
        Mon, 23 Oct 2023 05:49:11 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c488600b004080f0376a0sm9320997wmp.42.2023.10.23.05.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 05:49:11 -0700 (PDT)
Date:   Mon, 23 Oct 2023 13:49:09 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] backlight: pwm_bl: Avoid backlight flicker applying
 initial PWM state
Message-ID: <20231023124909.GC49511@aspen.lan>
References: <20230608-backlight-pwm-avoid-flicker-v1-1-afd380d50174@pengutronix.de>
 <20231018210741.6t3yfj6qgmpwhhlo@pengutronix.de>
 <20231020112727.GF23755@aspen.lan>
 <20231020121148.3g6t3v5uuyubifpb@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020121148.3g6t3v5uuyubifpb@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 20, 2023 at 02:11:48PM +0200, Uwe Kleine-König wrote:
> Hello Daniel,
>
> On Fri, Oct 20, 2023 at 12:27:27PM +0100, Daniel Thompson wrote:
> > On Wed, Oct 18, 2023 at 11:07:41PM +0200, Uwe Kleine-König wrote:
> > > Hello Philipp,
> > >
> > > On Thu, Jun 08, 2023 at 04:11:14PM +0200, Philipp Zabel wrote:
> > > > The initial PWM state returned by pwm_init_state() has a duty cycle
> > > > of 0 ns.
> > >
> > > This is only true for drivers without a .get_state() callback, isn't it?
> >
> > pwm_init_state() explicitly zeros the duty-cycle in order to avoid
> > problems when the default args have a different period to the currently
> > applied config:
> > https://elixir.bootlin.com/linux/latest/source/include/linux/pwm.h#L174
>
> Ah right, pwm_init_state() is strange in a different way than I
> remembered :-) pwm_get_state() is only called to get .enabled set
> appropriately.
>
> Looking at the callers:
>
>  <snip>

>  - drivers/video/backlight/lm3630a_bl.c
>    explictily sets .enabled before calling pwm_apply_state()
>
>  - drivers/video/backlight/lp855x_bl.c
>    explictily sets .enabled before calling pwm_apply_state()
>
>  - drivers/video/backlight/pwm_bl.c
>    This is the one we currently discuss. I think even with the patch
>    applied it uses the .enabled value returned by pwm_init_state() but
>    it shouldn't.

Agreed.

> So all consumers using pwm_init_state() either don't use the .enabled
> value returned by pwm_init_state() or at least shouldn't do that.

Looking a little deeper in the PWM code, it looks to me like pwm_bl.c
could just use pwm_adjust_config() during probe to transition between
bootloader settings and kernel settings!


Daniel.
