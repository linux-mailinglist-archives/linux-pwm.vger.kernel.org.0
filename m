Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9220E1AF
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2020 23:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbgF2U6l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jun 2020 16:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731250AbgF2TNC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 15:13:02 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BCAC030F2D;
        Mon, 29 Jun 2020 09:45:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so17156687wrj.13;
        Mon, 29 Jun 2020 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u9fUuABIS2EcFjNrVGvmrkgcrL3UypNwy9u+b06+fm8=;
        b=RXfK6rQ+SzRHAAVPuZgSCcwjrzUnceasBHQrhHMlYQ5I1SwpWIBR7DK1d9z7HkvSKk
         MEVg1EeIlqmjYTk5OsFBriXDewcGgPjdcNafq5kaZpPfePyEgRPZ9KR/zL8lyFUCczsQ
         fiExr9g3JvIkRHCN4gf/kV7o6tI1lGDyqRUhkanPryvVXw1bR3kmf0rsFUEju8am7/2o
         acuoJOCiMPtfkQ7D4wkqcUG6x3gCNCcsrnehQs1HTEiitZpPTqeKgDEHzc4SsrmYh7qT
         V8kuot39HNtGZAe2xXp6kdzpSV1Fyy0OAUiP6MDKv4mmLUHNtkngmP/upBmbE0yXLUev
         PKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u9fUuABIS2EcFjNrVGvmrkgcrL3UypNwy9u+b06+fm8=;
        b=ctbcJyWcYp9E2dElxV6cbbkwCnyGNzhb0PprjSBjlMZg1P9RrEZgHtqB8TyEJtxyF6
         sfT6CHXiCWoKEWgotJs8AeZHvkvW/C1P/yGDsen9I7lJwXbCQzqgXcqQiqR7U0GX3hZz
         1v97sQlNGFWndu0bH4eVNeG/BGKIKJN0hDk/oIJR490ITX5GKAp9or7Go6e0e+ZgwUo0
         julmu6Ap0NdH7PPp8GJvcj1jxehu0WZRBatozVkhhrQKTOAWP+G/tQwkGw++qsLUDfVF
         ws7Ww1LLKTivRLsZfHoRKN2Q8sDMVfZsyYppN3/Hl2VCOZ7rcyALlSvMVZqfyevwpmas
         M2lA==
X-Gm-Message-State: AOAM532h0um9XRLkGswTxYbxI1WEP0uG3V4dPG1j3F9yjhyz/XxGZLsM
        G3sfccVvsWk2UCzjVzz6ke8=
X-Google-Smtp-Source: ABdhPJwgDtmaZGJrtNa0zEf2BklM+msP3P7Rk7sYX4yUbVAN3Av14f+0EZj5nhMLZ6sMh6IJblncLA==
X-Received: by 2002:adf:f608:: with SMTP id t8mr18108260wrp.308.1593449121909;
        Mon, 29 Jun 2020 09:45:21 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p29sm438013wmi.43.2020.06.29.09.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 09:45:21 -0700 (PDT)
Subject: Re: [PATCH 1/4] pwm: bcm-iproc: Remove impossible comparison when
 validating duty cycle
To:     Lee Jones <lee.jones@linaro.org>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20200629124752.1018358-1-lee.jones@linaro.org>
 <20200629124752.1018358-2-lee.jones@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3470e941-aa86-11a8-674b-5258a08fedb1@gmail.com>
Date:   Mon, 29 Jun 2020 09:45:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629124752.1018358-2-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/29/2020 5:47 AM, Lee Jones wrote:
> 'duty' here is an unsigned int, thus checking for <0 will always
> evaluate to false.
> 
> Fixes the following W=1 warning:
> 
>  drivers/pwm/pwm-bcm-iproc.c:147:12: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> 
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-pwm@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

And IPROC_PWM_DUTY_CYCLE_MIN is unused after remove this single use of
the define, if you also remove it you can add:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
