Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3CC5F2550
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Oct 2022 22:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJBUon (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Oct 2022 16:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJBUom (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Oct 2022 16:44:42 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B2231E
        for <linux-pwm@vger.kernel.org>; Sun,  2 Oct 2022 13:44:38 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 2so2640136pgl.7
        for <linux-pwm@vger.kernel.org>; Sun, 02 Oct 2022 13:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=ZushtYIWuTe/TMKKyf1EKciQYOYaSryvHjPNVNndNEU=;
        b=UhmYEVKis6kULUzcpymNpLrkJ47wghyJW3oe43kYiIeLlOLg9QGistQtG6norpS39X
         8aDm85l6Qayx0H+B7IS7yw3DuAqfBVZcenl9BinNBY6o1ccVpW4UaSGZGe427WJyMAx0
         kmbNxTBVjclIyF+2XbNikqBntZFFboaWS1W80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZushtYIWuTe/TMKKyf1EKciQYOYaSryvHjPNVNndNEU=;
        b=LWgufrPt+EU6c9WfnqE3MfuBE0swSACkQqeQPQesWWayorBgZ6Wbnxd7I3RACZK08Y
         wMrG96iZI3gVmyNGDlYKKEo/7cX+u8bCz4edBLVy2TFFDBNa8CCWnMMoW4SfMM7d6HVs
         /WPxyKyZgw69wZRYBQ6fPVWN9523yRl9yjjwmJOkhkYKT0TfK4Vl0OGHOdTCLTOxYkTF
         CbFLZ/fKC1/pSLF2Kqj40EGH3LJ7FGCGjIsRyOkjN6CzJcUwHHB34Z07og3d6/YcZb5h
         bMW1P7c8Uv7zb/UUWesYA2j1FzEWn3pRMc7oBxMHANZz7+V3xGCAT568Tu37HmOTwS0w
         y4Cw==
X-Gm-Message-State: ACrzQf0zT8ZPY4c0oubj5ZTAPdXnX4WtideKKcg/IINqPo+mUXRQq8zf
        G37fRiXSASoNGfgagoYI8YWDqA==
X-Google-Smtp-Source: AMsMyM6dMnqvbXMsx4eAVqEynKZm3EIuvSdcBx1uk4/0UNs4sRge+z6d4HrnubI5zUPFleTf9uNkBA==
X-Received: by 2002:a63:1e5a:0:b0:43c:b966:e2d6 with SMTP id p26-20020a631e5a000000b0043cb966e2d6mr15793484pgm.569.1664743477949;
        Sun, 02 Oct 2022 13:44:37 -0700 (PDT)
Received: from [192.168.1.33] ([50.45.132.124])
        by smtp.googlemail.com with ESMTPSA id x5-20020a63b205000000b0044046aec036sm5266783pge.81.2022.10.02.13.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 13:44:37 -0700 (PDT)
Message-ID: <47dc5db0-af7a-54fb-4115-02fc4d397083@schmorgal.com>
Date:   Sun, 2 Oct 2022 13:44:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
References: <20221002061552.45479-1-doug@schmorgal.com>
 <20221002061552.45479-2-doug@schmorgal.com>
 <20221002150436.mhtdv56tjfaxdfbc@pengutronix.de>
From:   Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH 1/2] pwm: pxa: Enable clock before applying config
In-Reply-To: <20221002150436.mhtdv56tjfaxdfbc@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 10/2/2022 8:04 AM, Uwe Kleine-König wrote:

> First, would you mind adding a first patch that just replaces
> pxa_pwm_enable() by clk_prepare_enable(pc->clk) and pxa_pwm_disable() by
> clk_disable_unprepare(pc->clk)? Given that the dedicated .enable() and
> .disable() callbacks are not needed any more, this would simplify the
> driver a bit.

Will do -- makes sense.

> Then I think to understand that you need the clk enabled for operating
> the output and for register access, right? I'm not sure, but after the
> above change it might be simpler/more efficient to enable the clk here
> unconditionally (and adapt the end of the function accordingly).

Right. It has to be enabled in order to access the registers, and it
also simultaneously enables the actual output. What you are suggesting
makes perfect sense to me. I will play with that approach for V2.

> If there is a transistion say from:
> 
> 	.period = A, .duty_cycle = B, .enabled = false
> 
> to
> 
> 	.period = C, .duty_cycle = D, .enabled = true
> 
> can it happen that you (shortly) see A and B on the wire? (I think this
> is orthogonal to this patch and happens with and without it.) If so it
> might be prudent do configure duty_cycle = 0 for the .enabled = false
> case.

You are absolutely correct. I had noticed that case was possible, but it
didn't click in my head that setting duty_cycle to 0 when disabling
would work around it. I need to set duty_cycle to 0 when disabling the
PWM anyway, because it seems to have a tendency to get stuck high when
stopping the clock.

I also realized I forgot to submit one other patch to allow this driver
to be selected with ARCH_MMP (which the PXA168 belongs to). I will
include that with V2 as well.

Thanks for reviewing this so quickly and providing great feedback!

Doug
