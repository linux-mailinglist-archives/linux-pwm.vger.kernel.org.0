Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5014B5856
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 18:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348525AbiBNRTD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 12:19:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242400AbiBNRTD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 12:19:03 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79715488A9
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 09:18:55 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i6so28450553pfc.9
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 09:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0RLeL5rnV5Yw5KLAID/1eQLl/8YrzEVot5+9jkOFCq8=;
        b=di4RPN9oj/MPlmbLy3rhJWd/zdfJXtQFvUFywJ3uojv/kd5AtFjkCCu3DlaaRA8b+j
         g2nmqSfveZFlO0iq6WDJIKhCsQt/0wtnitjsq6sKIF546HABLTcNXcc8LS0przpS7mqF
         2NgEXf/+16DMtcBZjkHHOimtcteHoRyNuna2GQLmcSWnJFwfM3gsgJQgYFse9fa2LhFc
         F8c2nKGaicei83mtzUJuy6Sv8Dm7zGH6Zi08EyWM27wbO03YG6s/u0TJUc9pLA2NjvQ6
         Oqxay4jqMEqR5zBtC5zgZyTycXBMVJyTRSYVQaoT0EMkLrW6Sp40R7nDqHLG5VI6VPCV
         EsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0RLeL5rnV5Yw5KLAID/1eQLl/8YrzEVot5+9jkOFCq8=;
        b=C4pknb3QGhrnmRKHsGaU7vdqZpSPqFnUo4HNFpuCBLooe/cm6CmYOSYG4XomvJMUa0
         khxG5C4ej1Lw9dbHtDDStFfabb3aaDTZ9sYswSxfC3KU9nRZQFmiZXdX5E1OUy3UWtlZ
         vs2XDZiM5Kpw1x4+qMcK4lA8N2cCO5tuCEa2GTl+OWGwePAZeIM5b+Iv5H5Nid1V4gAu
         PuQCzoamgeAg/EItWs+ARlVYDzpWWWS9hvXWS0MhGCCP0JtC1VyPC6qsDbdncVoxyJpw
         wqfFKjbFxYSwA6yaNAqJMP2kPx2N92jiEJZDl+RyR+sLuVJquUjjEwGs0I3sn9C7o5xT
         ecNA==
X-Gm-Message-State: AOAM532rro7YfN6DaBSs2Tj+AyM/ykGR+5mzAmQg9DcZRADITYkG07xL
        6KIIJCro2L/UzIOkOao/MKM=
X-Google-Smtp-Source: ABdhPJx2Jsrb5aFpmdAgC2ADZplQAqmkiC/9OAsZ3wKtZMdsG13rvj0vXxBK9OXorcAID6gbYmW+7Q==
X-Received: by 2002:a63:e302:: with SMTP id f2mr592691pgh.451.1644859134672;
        Mon, 14 Feb 2022 09:18:54 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a38sm24790767pfx.121.2022.02.14.09.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 09:18:54 -0800 (PST)
Subject: Re: [PATCH 0/2] pwm: brcmstb: Some cleanups
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <83f9a9b2-4a01-1f98-4783-d221cc3adf4f@gmail.com>
Date:   Mon, 14 Feb 2022 09:18:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
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

On 2/14/22 12:23 AM, Uwe Kleine-König wrote:
> Hello,
> 
> here are a few cleanups for the brcmstb PWM driver. There are a few
> issues left with it, that I'm not addressing for now. Just mention it in
> case someone wants to work on this driver:
> 
>  - There is no .get_state() callback
>    (That needs to be implemented by some with hardware and
>    documentation)
> 
>  - There are a few places where an overflow can happen in
>    brcmstb_pwm_config() that are not handled
> 
>  - The loop in brcmstb_pwm_config() to calculate cword is ineffective,
>    cword could be calculated ad hoc.
> 
>  - I don't understand
> 
>                 /*
>                  * We can be called with separate duty and period updates,
>                  * so do not reject dc == 0 right away
>                  */
>                 if (pc == PWM_PERIOD_MIN || (dc < PWM_ON_MIN && duty_ns))
>                         return -EINVAL;
> 
>    The usual policy is "With the selected period, pick the biggest
>    possible duty_cycle that isn't bigger thatn the requested duty_cycle.
>    So should this case be handled using dc = 0 instead?
>    But as I don't understand the real issue here (is this about changing
>    period and duty at the same time?), I don't want to touch that.

IIRC, I was testing using a shell script that would exercise corner
cases by modifying the /sys/class/pwm/*/{period,duty_cycle} separately
was able to run into that. Let me see if I can dig up that script.

Can you give me a day or two to make sure your changes work properly? I
need to locate a board with an exposed PWM header so I can put a scope
on it. Thanks!
-- 
Florian
