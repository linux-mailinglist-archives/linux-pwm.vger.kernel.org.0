Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876E04048A1
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Sep 2021 12:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhIIKl3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Sep 2021 06:41:29 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59446
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234357AbhIIKl2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Sep 2021 06:41:28 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9087D3F321
        for <linux-pwm@vger.kernel.org>; Thu,  9 Sep 2021 10:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631184016;
        bh=u9tf9lWYC4h6G9JS5FJzkFQD/K1+DZwunF+xwPVPhxE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=CkFry2yIrCBOsCMPlasc7sOYvqHYEkwVT1Z3MZAw07A6401b9Z3jI/Z+6vf95sj+y
         sAIjTrS3x1V8LGJMLpZ4IVs13o3GHtuD/QjBM7ayrT+k0bA6TlbUX4LqVOdlXPSzOM
         aJgtK0CxfoMCE6xes3mdyzKS3KdrcAzJAjOmWO4z/e2ydUfJzNvAsj7rYwEAFkUFm6
         jL66QIzJIPCNu3tlEEa0mOpQMyDgOanAsUqkRytiCwcx5lPnltDMhE24bfUHHNJKi4
         WP8B1s1BKGr8QsZOhkI/IwRnp98dVmebbqvJheYoTrxEhdvK1P6OjWbhIB6WUwKCJ+
         5WF4Wp89DVtrQ==
Received: by mail-wm1-f69.google.com with SMTP id r125-20020a1c2b830000b0290197a4be97b7so539168wmr.9
        for <linux-pwm@vger.kernel.org>; Thu, 09 Sep 2021 03:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u9tf9lWYC4h6G9JS5FJzkFQD/K1+DZwunF+xwPVPhxE=;
        b=dvB3fIA6QqTYlh1B3h1cAbnOvBaadOX0A+RfHiOaFGlQEoVUaJ49sFjeLG9zzMNJGi
         JP84y6AEO1Gt9ryr71Gr+sBEiYL7ox5b8BOHQZraCHZmuJZsUbK0HFt38K5tZeXWILnx
         9jWJQy6y14P6BHY0LwAMYHQ2w9SctxuGDs8liYUp/aN6/aBXbv+sy7jM4MaAdEeHaGyl
         zwCI+gqqOoE4esittP4BTxD2zGHzxKXS2N2ScaX9CO5eMplGJLO4HEDVSEUHtYzpfV9K
         oqn7j0YcP8G16zlXXzaLvoLeKaF8dRRojbf1/w62+VjzuQmJuTpmfT1EZI0RI/4S+B7t
         JNmQ==
X-Gm-Message-State: AOAM530JCBlGiBE76jKdDGT5xGns32gRBmYlkuX+tljQuywJDzgdzHkp
        qaI9i1KrbnA8oO5+eb4X8VmPPYpTWQsi9QU24ZJ//EoaRqry0viZdV27KqxIuW6D8nLlD4eRAv/
        RxophmEg9CBVH2DbyQA/NE0K8Sbtvt9c3E29ucw==
X-Received: by 2002:a1c:7c12:: with SMTP id x18mr2274802wmc.114.1631184016249;
        Thu, 09 Sep 2021 03:40:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyboc9owUJBZr05lyAXwLSzcntMddCWmyAchxWKxFnje29uDHmXs0v8wcM46KReQqY9NhT9sA==
X-Received: by 2002:a1c:7c12:: with SMTP id x18mr2274782wmc.114.1631184016105;
        Thu, 09 Sep 2021 03:40:16 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.90])
        by smtp.gmail.com with ESMTPSA id a6sm1231247wmb.7.2021.09.09.03.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 03:40:15 -0700 (PDT)
Subject: Re: [PATCH v3] pwm: pwm-samsung: Trigger manual update when disabling
 PWM
To:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@axis.com
References: <20210909101042.17431-1-marten.lindahl@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <ded88ef3-d408-8bba-7c1d-bbd160c2de9a@canonical.com>
Date:   Thu, 9 Sep 2021 12:40:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210909101042.17431-1-marten.lindahl@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 09/09/2021 12:10, Mårten Lindahl wrote:
> When duty-cycle is at full level (100%), the TCNTn and TCMPn registers
> needs to be flushed in order to disable the signal. The PWM manual does
> not say anything about this, but states that only clearing the TCON
> auto-reload bit should be needed, and this seems to be true when the PWM
> duty-cycle is not at full level. This can be observed on an Axis
> ARTPEC-8, by running:
> 
>   echo <period> > pwm/period
>   echo <period> > pwm/duty_cycle
>   echo 1 > pwm/enable
>   echo 0 > pwm/enable
> 
> Since the TCNTn and TCMPn registers are activated when enabling the PWM
> (setting TCON auto-reload bit), and are not touched when disabling the
> PWM, the double buffered auto-reload function seems to be still active.
> Lowering duty-cycle, and restoring it again in between the enabling and
> disabling, makes the disable work since it triggers a reload of the
> TCNTn and TCMPn registers.
> 
> Fix this by securing a reload of the TCNTn and TCMPn registers when
> disabling the PWM and having a full duty-cycle.
> 
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
> 
> v2:
>  - Move fix above setting of disabled_mask
> 
> v3:
>  - Move up definition of __pwm_samsung_manual_update to avoid
>    declaration of the same
> 
>  drivers/pwm/pwm-samsung.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
