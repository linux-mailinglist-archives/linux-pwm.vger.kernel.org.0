Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0E54D0751
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Mar 2022 20:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiCGTMD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Mar 2022 14:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbiCGTMC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Mar 2022 14:12:02 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F18A527D9
        for <linux-pwm@vger.kernel.org>; Mon,  7 Mar 2022 11:11:08 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso46680pjo.5
        for <linux-pwm@vger.kernel.org>; Mon, 07 Mar 2022 11:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ez+lML41mFLmgl+VJD6WnyhJXRb/yUevLFik056nu8A=;
        b=G5L1P1RrNCQAmcKPeiqMJN04uKk0jXHbZLHNEBOK3Xsq1nSXqlHx2Uwt2u0Shu58Yl
         bSpSfsKFNLa+a1BELpYSY5JM4O60HQAWizSBJyOBOmwUN6KDrzdER30H9A2T7g0eV6MH
         6bP0ch1zUQ9GcofnP5sGl/kKRWEAxe2Zad+Lc1nIm8+7B1zmeoV4m/cCGJIbgZ7PZ5sO
         gJ5G+sCYqhhT8BuEnLCi3j2KC/UKyVgSj0QWrMUIq+RrztXBYK/A/r6tTBRtkRTkpnSL
         U12obEelIXuA9tnGD5GBsKBGjeK79TDxDscjOhEx1yahMuNenuevLFtjBRQb6Ep2AbVv
         5rEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ez+lML41mFLmgl+VJD6WnyhJXRb/yUevLFik056nu8A=;
        b=S41e0LRN/v/I8dvShCwmM1lkZHMRRBRmIGL90G04nY3UIxdqDcNzLMn0MSczyeRFfm
         X15sZKcFkXYDL0jGS9NQ7QxS289GKP8qeor0VLlxbrsz5n8uAF+N5Gcar6WRaY675gW3
         RuJnrfKlP+rxi1nipbR22W/FyavAyUh5F0pvn+Ghr0rAt3jqmYK6pzo1DmfoSdxnyHuh
         Fpl61E0cNCivlSV7obJaSmJqN5V3TwMY5PuabdSyyXluy99mThAdMHtYRK/Pjzo0dLIM
         SCiKx2HXekOz240SVSs3tdjXzoOdf2NpynhTowBXwuocm1vrYQR/lemCvpw6d18DZwI2
         0dzA==
X-Gm-Message-State: AOAM5300r23ET9tXn584dcCpa5py4vgJTg7wH2ps/odRk04TWpq0QGG/
        j3hHsuQbB7vpAsZkYz1nEhQ9cS1zhHc=
X-Google-Smtp-Source: ABdhPJxi3ib3D0kx09xqy+8CQFHZxBZGvKRBU3kL9dWWGccAScMC0l9/2MbP06pX75jJREbWEe/SDg==
X-Received: by 2002:a17:902:f686:b0:151:ca86:e1be with SMTP id l6-20020a170902f68600b00151ca86e1bemr13844808plg.16.1646680267803;
        Mon, 07 Mar 2022 11:11:07 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 2-20020a631342000000b0037487b6b018sm12524008pgt.0.2022.03.07.11.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 11:11:07 -0800 (PST)
Subject: Re: [PATCH 0/2] pwm: brcmstb: Some cleanups
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
References: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
 <20220307184750.qkbueadgqohbvv2g@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <bfcda0d1-7855-7ab6-ef2c-950ead5f8b15@gmail.com>
Date:   Mon, 7 Mar 2022 11:11:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220307184750.qkbueadgqohbvv2g@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 3/7/22 10:47 AM, Uwe Kleine-König wrote:
> Hello Florian,
> 
> I have a few questions here looking in more detail into the brcmstb
> driver:
> 
>  - What happens on PWM_ON(channel) = 0?
>    I guess it just emits a flat inactive line, and refusing a small
>    duty_cycle that results in PWM_ON(channel) = 0 is just artificial?
> 
>  - There is a line describing:
> 
>    	W = cword, if cword < 2 ^ 15 else 16-bit 2's complement of cword
> 
>    The driver only considers powers of two <= 2^15 for cword. Is the
>    implementation just lazy, or is the comment misleading?
>    At least s/</<=/ ?
>    There is no sense in using a value > 2^15 as for each such value
>    there is a smaller value with the same result, right?

This was copied from the specification which now that you mention it,
seems off by one in its formula, it should be <=. This is further
confirmed with:

pwm1_cword[15:0] must be less than or equal to 32768 when the
variable-frequency PWM is used as a clock for the constant-frequency PWM.
Reset value is 0x0.

so I believe that the comment is wrong and so is the specification of
the block that was used to write the driver.

> 
>  - clk_get_rate(p->clk) is expected to return 27 MHz, right?
>    (Just for my understanding, not about to hardcode this in the code)

That is right.

> 
>  - The explanation about period in the comment is:
> 
>    	The period is: (period + 1) / Fv
> 
>    so I would have expected:
> 
>    	pc = (period_ns * clkrate * cword / (NSEC_PER_SEC << 16)) - 1
> 
>    (assuming no overflows). However the -1 isn't in the code.
> 
>  - Duty-cycle calculation is unclear, the docs say:
> 
>  	"on" time is on / (period + 1)
> 
>    I suspect on time is $on / Fv though?

Yes, that is also what the specification says, not sure why I wrote that
down TBH.

>    But even with that I don't understand the +1 in
> 
>  	dc = mul_u64_u64_div_u64(duty_ns + 1, rate, NSEC_PER_SEC);
> 
> Can you enlighten me?

I wish, this was 7 years ago, and I do not remember why there was a +1
being added here, it might have been that this should have been a
DIV_ROUND_UP().

I am slowly rebuilding some context here so if you want me to test
something in the meantime, I will do that.
-- 
Florian
