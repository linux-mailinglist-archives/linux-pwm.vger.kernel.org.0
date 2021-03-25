Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66328349C5A
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Mar 2021 23:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhCYWhV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 25 Mar 2021 18:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbhCYWhS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 25 Mar 2021 18:37:18 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02B8C06174A
        for <linux-pwm@vger.kernel.org>; Thu, 25 Mar 2021 15:37:17 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id l1so3270384pgb.5
        for <linux-pwm@vger.kernel.org>; Thu, 25 Mar 2021 15:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yrr1GJH31Lvxach6q6yeojKhEVpNvsWzUHCQrSotVHc=;
        b=ZwWC/czG9DYI/RSiYT+UdtuuoyOsOfp4rpdCufpcpryJLvrSSK1ATxgIMIbZ7RgrMW
         4DlAKn5w+oZdzzSTayyuOkXl+gcymJkmBPmvuNeS+BfAaBzvSGoscFNJWo4BNNxMh9hb
         OvJAMYWJVWOWX9ZVkrfbQK41LZ/M2X/41XlDckhjXCoCkHbDwnj8jqF6Kwqgecx4S3s/
         BY0Bmzqq4C7F1XcGgz/oea5T+Lm/GAlQ2OalBzzsxoyxu6eQQBc2uR4JWFPi2twurZGI
         NBDvhOTRaKDDZvKDgVbrouLFyPnuotithIKtAW1cJvsoKm65T/6mw9o5NDwKAG1nITg6
         /lTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yrr1GJH31Lvxach6q6yeojKhEVpNvsWzUHCQrSotVHc=;
        b=mWhXekSWUSG1PiBla2JELm1+EVgPwcmyA8Sua9w70K5Nm/KqQ2SszUbcssGKK7u69a
         eeyWZbgaBy2vQ1s04JUrXOqZ5COsRzZf8pJ2rmqOk5CDFcYi9WTs7WG0bnP+mhudAkKz
         q+dM2MziUA6Gl095T3wkHkSnU9kG2ayah4zNoBnuq3rt2BhpslV/kw3UCF2zDWqIqZtd
         UvBvI1Bl4CilWGtlxb2n7tDWtQu2EWK51CETUX0DTf1ukdB0ohK1uG9Uy6iueQ7tIG6s
         mh9xz0Z5PhEwIfuse+v5M6sribRX5lxwOLxUXVwuTUWxl1CmrILsr5fhC11IicxvbPrA
         r02Q==
X-Gm-Message-State: AOAM5321wCmy45t8pgqT5f67C7a56gov+ueayY1t045wWrVh+1EdbQ4U
        ZGZD3dDjwt7x4GajaP1R0VM=
X-Google-Smtp-Source: ABdhPJwzoVCIWJUyYiPy0LvU17kkgZ0Z6hGti5Z+QOUl/VJjhZBaQPqYTW/dU39wtXbbsyzbAFrMpA==
X-Received: by 2002:a63:2c8f:: with SMTP id s137mr9252213pgs.51.1616711837153;
        Thu, 25 Mar 2021 15:37:17 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g21sm7015987pfk.30.2021.03.25.15.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 15:37:16 -0700 (PDT)
Subject: Re: [PATCH] pwm: bcm2835: Free resources only after pwmchip_remove()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
References: <20210325082931.81774-1-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d16b2937-a697-56e7-5c66-37839253d7c1@gmail.com>
Date:   Thu, 25 Mar 2021 15:37:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325082931.81774-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 3/25/2021 1:29 AM, Uwe Kleine-König wrote:
> Before pwmchip_remove() returns the PWM is expected to be functional. So
> remove the pwmchip before disabling the clock.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Similar to your pwm-bcm-iproc.c change, I would be inclined to add a:

Fixes: e5a06dc5ac1f ("pwm: Add BCM2835 PWM driver")

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Uwe!
-- 
Florian
