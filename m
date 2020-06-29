Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C990320D6BC
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2020 22:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgF2TXb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jun 2020 15:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732288AbgF2TWp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 15:22:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1B5C030F33
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 09:54:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a6so14134130wmm.0
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=X9rfAlOxfe38VMX/oL2KWbXJmMAccAeFpKeQ6kbgS5I=;
        b=UZ6FVKc7frhOr+27BqHpUSAAlW/b6bGMLjuQl7IYNjpAn9UP9nwBkgtlMucNWw5P0M
         YTRq3+LIylKWY1EpNL4FD5Vuwel8piO0VIk6nUxpzG9Ls450pSl99qLEi2KfmUEV4fC3
         Q0HMPnnWRd7jZFkfC02SLQXuTxIeg1aAPTOqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X9rfAlOxfe38VMX/oL2KWbXJmMAccAeFpKeQ6kbgS5I=;
        b=ZGx9ttpMIL7sh8R72YtI0BSfbdHGY/m66kqfb7YRsgkwedFiFJgN/eK7F7LELfOVfC
         0mtfjQ22oYGcejhSrQ2xpN7/Na4xusHyjMp8MV22Hze0wk3aFhyCoXqflnCBApJ88D2u
         y5pyF+AI2dkVsCDwUIQV3iP/l4rmkyp4QMAkqHj8QbFbF+0lBySh4zH5kiIIGOTX7Tq9
         /5IC/UaszIWnRyrQZ7KITg5j4Fs6Lg41pllp/zJtHrKLgkHX8S4zG0atZJpXndS/Bo0k
         biCnOGBVtoL+FKwtVunL3xITGK82o+XOebXjWAatySm/9yl9Nn5ovLx7/Bt2fCbav7Rx
         tonw==
X-Gm-Message-State: AOAM531qlnb9ArjP+yR+HUXjlX8KS95+GRNDbhPqG+HZX8uZpd2AMaIy
        NH9PkE19JHaBzJMplqyiLey72w==
X-Google-Smtp-Source: ABdhPJzEBOnJbI3F9fbCTkykHuYski3xJ+b+DkSQKsgVaDyTwA3/2FplB6F5M/HjmK7MhPF+FIuGjw==
X-Received: by 2002:a05:600c:c1:: with SMTP id u1mr17895281wmm.48.1593449664783;
        Mon, 29 Jun 2020 09:54:24 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e8sm396022wrp.26.2020.06.29.09.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 09:54:24 -0700 (PDT)
Subject: Re: [PATCH 1/4] pwm: bcm-iproc: Remove impossible comparison when
 validating duty cycle
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20200629124752.1018358-1-lee.jones@linaro.org>
 <20200629124752.1018358-2-lee.jones@linaro.org>
 <3470e941-aa86-11a8-674b-5258a08fedb1@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <76a657ca-d30e-c5f2-f057-1c1bb7c8e1bf@broadcom.com>
Date:   Mon, 29 Jun 2020 09:54:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3470e941-aa86-11a8-674b-5258a08fedb1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 2020-06-29 9:45 a.m., Florian Fainelli wrote:
>
> On 6/29/2020 5:47 AM, Lee Jones wrote:
>> 'duty' here is an unsigned int, thus checking for <0 will always
>> evaluate to false.
>>
>> Fixes the following W=1 warning:
>>
>>   drivers/pwm/pwm-bcm-iproc.c:147:12: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
>>
>> Cc: Ray Jui <rjui@broadcom.com>
>> Cc: Scott Branden <sbranden@broadcom.com>
>> Cc: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
>> Cc: bcm-kernel-feedback-list@broadcom.com
>> Cc: linux-pwm@vger.kernel.org
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> And IPROC_PWM_DUTY_CYCLE_MIN is unused after remove this single use of
> the define, if you also remove it you can add:
>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
We actually made this same change internally recently but hadn't 
upstreamed it yet.

Tested-by: Scott Branden <scott.branden@broadcom.com>

