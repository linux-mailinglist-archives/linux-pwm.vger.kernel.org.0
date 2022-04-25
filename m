Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B02F50E784
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Apr 2022 19:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiDYRyF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Apr 2022 13:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiDYRyE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Apr 2022 13:54:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83232EA1E0
        for <linux-pwm@vger.kernel.org>; Mon, 25 Apr 2022 10:50:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u15so31042761ejf.11
        for <linux-pwm@vger.kernel.org>; Mon, 25 Apr 2022 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=33PZKz4c+MjchNXq+oupWUlcQ4ccJgjWlCH/KLUfNjw=;
        b=y9CZhhKmvRcpV4R7r1DC00TCWV89NKUm8FxpwjuQPRJgr79ucWaPjTp/SsBBArNLHR
         tBWNB9QdvpQepLtpyajjdncBUiD5yEwUxrZx14XahuJ5gmfIIa5MWl45BCyVdtFZXwkt
         MKUcs57RAKbe/73o8Ed7k1TRUvZk+UyDnQsgGsgMFilSMnoYT8qoR6tE5tXtyaP90qVC
         CySKitg2BTdsq3eXJBsvVBC5nbFuGWwuKUexsJhPglGiE3Ghl6i9f+7mZ2AN4rMQ1kVn
         MmfHz7noGnovXfRufWHOMMUCeyvhMAqw/+Pd+LY2Hn0gY2D9rfd8VVaQZ78idbQmTDPR
         UHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=33PZKz4c+MjchNXq+oupWUlcQ4ccJgjWlCH/KLUfNjw=;
        b=7/d9ul+lCjw8alUocIAAPoo+XorSQbqUj378WhvQssZB27kX/I9MzslEDrhUlMiS9q
         F+3qn4duxq0o9sIovzgeVYiSkwBhxMJoN4+iZUj+rBazuQb0r7FlXnvjuj1cQPZnrJE3
         HJLSx5rkL2T2+VkIC2cIIr4VUD+i5XVRb4eR+xs2X7q11K8n73X8ft9c+9ngmzEGtdTk
         zDPq+mHHlAPfK5Vv2KeCsEQurLJcb1fI6zlrjwXqj8ohc7H9Dkdamd1uUheluRfBetqw
         Jp5JIQVettPt/YSicPo7TzvRenCDYVh2xW16Vwz/q2XbIksjl+EJ5oiApqy1otxPjuLp
         KSRQ==
X-Gm-Message-State: AOAM5338ivdM7o4nShmW7n5+9+v/cIa8yxKcxXGdVZt/ffNMcZudGiaO
        LZM22dSi8orNsx2xixDPc8bPqw==
X-Google-Smtp-Source: ABdhPJya3ygUFCPyPXTeZNKILNjEo525uOqfmR5suEiZjqllJs7BO9vjxtQKfNwUIe5Nyv/XexIv+Q==
X-Received: by 2002:a17:906:c1d6:b0:6d6:e0a3:bbc7 with SMTP id bw22-20020a170906c1d600b006d6e0a3bbc7mr17585758ejb.484.1650909058056;
        Mon, 25 Apr 2022 10:50:58 -0700 (PDT)
Received: from [192.168.0.244] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i12-20020a05640200cc00b00421058b175esm4934181edu.53.2022.04.25.10.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 10:50:57 -0700 (PDT)
Message-ID: <ec763086-174f-ab96-5f92-5a2ec54e4cce@linaro.org>
Date:   Mon, 25 Apr 2022 19:50:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] pwm: samsung: Implement .apply() callback
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
References: <20220328073434.44848-1-u.kleine-koenig@pengutronix.de>
 <d7030fc5-3165-0255-0055-b2bc2e387d53@linaro.org>
 <20220425171641.tf2cgkzbwrx36pn6@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220425171641.tf2cgkzbwrx36pn6@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 25/04/2022 19:16, Uwe Kleine-König wrote:

>>> +	/*
>>> +	 * We currently avoid using 64bit arithmetic by using the
>>> +	 * fact that anything faster than 1Hz is easily representable
>>> +	 * by 32bits.
>>> +	 */
>>> +	if (state->period > NSEC_PER_SEC)
>>
>> Isn't this changing a bit logic in case of setting wrong period and
>> inverted signal?
>>
>> Before, the config would return early and do nothing. Now, you disable
>> the PWM, check the condition here and exit with PWM disabled. I think
>> this should reverse the tasks done, or the check should be done early.
> 
> The intension here is to just push the legacy implementation of .apply()
> (i.e.  pwm_apply_legacy()) into the driver, to be able to get rid of the
> legacy handing in the core. I think the problem you point out is real,
> but it is not introduced by my change which doesn't change behaviour.
> 
> The problem is just that it's not possible to "see" that period is
> invalid at the time the polarity is changed and so it exists since at
> least 5ec803edcb703fe379836f13560b79dfac79b01d, my patch just made it
> more obvious.
> 
> So yes, there is potential to further improve the driver, but that's out
> of scope for this 1:1 conversion patch.

Sounds reasonable, thanks for explanation. Everything else was looking
good, so:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>




Best regards,
Krzysztof
