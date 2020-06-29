Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD96E20E180
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2020 23:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389861AbgF2U4f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jun 2020 16:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731278AbgF2TNJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 15:13:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00429C030F2E;
        Mon, 29 Jun 2020 09:45:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so14214215wrw.1;
        Mon, 29 Jun 2020 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y9LuaHpAJp7j99mylhwwTrgsG7QR6yXOEQqHPjHK9qA=;
        b=YG1iZpScR2fnD/Dg0q0W5hkPvmMrLbNo9xlP1cqrwH2mupcSdQTr4LZR+9nZIKBkhS
         vNxlDaGanRq87QIVN4EIae1EoO1LKEPYH5/TT7VqNi3dm09PLW5A18bwk8y2bP0I19Dp
         7amp7MNjaIvmjbUVxgBphis8bQqS+Cgq4t+mDKgU46afrmUTLt1XhOjJSJj9RnUaBGVS
         ygj++98OzqCSrPQ3NwRlILzhK+xS+zrrGXYuf8xJehhPVJI6DErMknEW/s2CXDG+9jUJ
         FK73oiZ8EUmGLsRotn44ygJAd1jKxyLIhwh73uooLRa7ZgXTWD0Som4EYsuGKhwxeaUL
         wFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y9LuaHpAJp7j99mylhwwTrgsG7QR6yXOEQqHPjHK9qA=;
        b=jvQILgQd4+Bg1f5MIOHkaUezSJ/cEF1Jb1IsWjjj74YDRGEmmKnuz9MCRz0IJpKA3B
         Nrv/Y24LXxUvQB6vfp+fDPRO56slUNxKh9KwbDfZf7DUJXjadGJZ3IVrcwP4cVOhcd4n
         mS0kCrLhrbpytwAUd8IMqwpleIehufaFba5nE7RSHBVbqsZ/fg07muBMht9IrRzuv+vW
         87ovKFgueySPTAQpGaOwG7hR9iIqN7YvsCms/LTqmMuBngnDgJhA/bQXSjxGt68EG1/3
         4PxhzpyUhQy77+2l0UKEvNpH4hcVdR15VeX4rgSFA5jde5mtq+AVE+SbUY4YA9VEHdGI
         G8cQ==
X-Gm-Message-State: AOAM532CkdQ9p1Gb1YN0cQTpvVenWFCJ/1pqAly4fHdYhSKcRu2DnS+u
        udO4w6rj/7v0k8yOND92aZM=
X-Google-Smtp-Source: ABdhPJyO9Vl/0aowtNg2HaFwebZPM9zO5kDm6GzEIHIzbBOeZOCT+P6YXcPb6Z5tEMB0sRox55sZ8g==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr17120164wrn.93.1593449135758;
        Mon, 29 Jun 2020 09:45:35 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x11sm371016wmc.26.2020.06.29.09.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 09:45:35 -0700 (PDT)
Subject: Re: [PATCH 2/4] pwm: bcm-kona: Remove impossible comparison when
 validating duty cycle
To:     Lee Jones <lee.jones@linaro.org>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20200629124752.1018358-1-lee.jones@linaro.org>
 <20200629124752.1018358-3-lee.jones@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0db8ebc7-b75b-a74c-8852-b235daedaf82@gmail.com>
Date:   Mon, 29 Jun 2020 09:45:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629124752.1018358-3-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/29/2020 5:47 AM, Lee Jones wrote:
> 'dc' here is an unsigned long, thus checking for <0 will always
> evaluate to false.
> 
> Fixes the following W=1 warning:
> 
>  drivers/pwm/pwm-bcm-kona.c:141:35: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-pwm@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

And similar to patch #1, DUTY_CYCLE_HIGH_MIN now gets unused, so if you
remove it as well, you can add:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
