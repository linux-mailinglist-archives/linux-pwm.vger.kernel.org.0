Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B247052A842
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 18:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239435AbiEQQjB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 12:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241878AbiEQQjA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 12:39:00 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CA633E84;
        Tue, 17 May 2022 09:38:59 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id l16so22949233oil.6;
        Tue, 17 May 2022 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=axuVWaBdq6V6egHHSQL0agyYNT8KeElLl2dSRTEgFFY=;
        b=Teky0vSu1E67YQsy3bsou7NODJNem4fM6ChPMfPhTiNsHPS5eBiAnnlegtVnX5oMek
         bRJXNcfjP0OlXSMTwQSdMQWoYa6YhiVSkkTp8PMCgebiLJbBihPxVmVuDYienQzf0xNJ
         YHeNIqFpGtXvzaJPRzP9/PjVakQsH1fAUJ3xapSlfpgBoV49HF4fVXv0maAt5PyhpSXR
         TX4eyZZkIHwaH9cJ6WdACvw5FW9Pv/IrJfD0ckDCxPFJ4ACuRrHuWOR+iyvcv6byl9LN
         NrhDBq9rPcCXnYw4sTmWQ4732Tl9jFUHOwcsHgCw52E4UyiCwAmF42bcw81gyKV0c1lc
         1jJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=axuVWaBdq6V6egHHSQL0agyYNT8KeElLl2dSRTEgFFY=;
        b=cCAMSqeLQSJbhyF1kaJCWDh5jNO7KEes7dM92dejebHe6Yv+apTi3IlNQZVS+ODfUh
         xNVdzhFZz/outGh1QZJBas+F7M/bzlT7N4rUUZdhUCtVBiGyNLRKcrQQ42v+0MqPQ2G4
         w2fdMgMi3R0UpyVTQX7FjfrDFjike7CPU4sx9/oskJ64FQQPqEWLT0HkBNoWnJmgMnAn
         1Kz3wL20KD3FPHOrYQgE0096UClMStPZtAJ0yWFW0gNfTq8H7ftMb+go9gPCX3GeLF88
         WUrqHQCXT4jaG2DmKtP/8eHCGnJGqs3DaaeQmqkEpeV1uXGj7fc41JvVB9mcR5zr4WLv
         YiEQ==
X-Gm-Message-State: AOAM532vMzAW18qJZVj82nLB4rUY1NP6EVZPDeRJoZpurJeiOXnkard8
        pbk4JfGRTWNSnMOuoexKva0=
X-Google-Smtp-Source: ABdhPJw3l6/qyoY1u5TEASvFfsBQQSssu8gbGBwTXZw24G39pY3JsGvf7Rqhcbvee7yBGT31oW/yUA==
X-Received: by 2002:a05:6808:118f:b0:2d4:13f1:8504 with SMTP id j15-20020a056808118f00b002d413f18504mr16162824oil.90.1652805539008;
        Tue, 17 May 2022 09:38:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h9-20020a056870538900b000edae17a8cesm6878643oan.3.2022.05.17.09.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 09:38:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <355e6efa-dc65-771e-fcc0-2ca774d382de@roeck-us.net>
Date:   Tue, 17 May 2022 09:38:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
References: <20220517142620.1523143-1-alexander.stein@ew.tq-group.com>
 <20220517142620.1523143-7-alexander.stein@ew.tq-group.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 6/6] hwmon: pwm-fan: Add hwmon_pwm_enable attribute
In-Reply-To: <20220517142620.1523143-7-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 5/17/22 07:26, Alexander Stein wrote:
> This adds the enable attribute which is used to differentiate if PWM duty
> means to switch off regulator and PWM or to keep them enabled but
> at inactive PWM output level.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>   Documentation/hwmon/pwm-fan.rst | 10 ++++
>   drivers/hwmon/pwm-fan.c         | 95 +++++++++++++++++++++++++++++----
>   2 files changed, 95 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/hwmon/pwm-fan.rst b/Documentation/hwmon/pwm-fan.rst
> index 82fe96742fee..0083480068d1 100644
> --- a/Documentation/hwmon/pwm-fan.rst
> +++ b/Documentation/hwmon/pwm-fan.rst
> @@ -18,3 +18,13 @@ the hwmon's sysfs interface.
>   
>   The fan rotation speed returned via the optional 'fan1_input' is extrapolated
>   from the sampled interrupts from the tachometer signal within 1 second.
> +
> +The driver provides the following sensor accesses in sysfs:
> +
> +=============== ======= =======================================================
> +fan1_input	ro	fan tachometer speed in RPM
> +pwm1_enable	rw	keep enable mode, defines behaviour when pwm1=0
> +			0=switch off regulator and disable PWM
> +			1=keep regulator enabled and set PWM to inactive level

Unless I am missing something, I think we have (at least) three
conditions to handle:

- regulator disabled (independent of pwm value)
- regulator enabled, pwm output disabled if pwm=0
- regulator enabled, pwm output enabled and set to 0 (or, if inverted,
   to maximum) if pwm=0

plus possibly:
- regulator disabled, pwm output disabled if pwm=0

Guenter
