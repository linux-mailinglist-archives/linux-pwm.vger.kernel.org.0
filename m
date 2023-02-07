Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9929668D146
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Feb 2023 09:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjBGIIC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Feb 2023 03:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjBGIIB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Feb 2023 03:08:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B90F2FCD3
        for <linux-pwm@vger.kernel.org>; Tue,  7 Feb 2023 00:08:00 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g6so4690818wrv.1
        for <linux-pwm@vger.kernel.org>; Tue, 07 Feb 2023 00:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RQlDidB6Gvvp6ghBrLgv75BvvHu3m4TEuLCw4BC1C/U=;
        b=sEDJ1fu0JDTI24wHOg1lgL/WoCnjFuVGa7uzyEZNEFTIewsjrxYH8wjB5CfvF6IGwG
         4mMpnDpzmYZm6v4rR8GObnKIcJhTNFiYp4cchYRfiYLaZEs5//+6a0aEVjLP/mxpC1Rg
         fGJ/4iUKSs0FMVz+2TpqE4LIMW/ziGHtl0edQd9uNLan3a3bPlcaHeFQjcm3Vj6d/vyb
         fU4KXb3tFx2z8RVQSQ54lKBvToSP3d0CDjTEe+cmThPSxLpXC8MUS2CBvzVhCnmScFQM
         TvL+6CtWAHca6ezrDoIMvl26AEXD0SeLcEe1rPCaD8Nc3tOvNjyFJglPvPTPImZKNaML
         yo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQlDidB6Gvvp6ghBrLgv75BvvHu3m4TEuLCw4BC1C/U=;
        b=5bxif06JrfSlzuGLPuX4q09gAtIwRH79mYlhh/yk8gMymGvgIl1WQIKieu30b1gAH6
         qssXthoM0TIEODFSgft0hXMUUdivpB7lvHRqA7882QidaM8Ikgzor4rGtY2jIK3Ng1R1
         JwurjxYUwBUK7JXb24ZIPjraTnrs7U0bKwFTN/J7e1mUoElJ3zfMiL6eIN4nOcABtpHj
         El/q/9qsIkP+/Jtfk+GAsXs607hvXlR3qDVDdUFFErzSVNFkb7RhHXJps9s7LIpLVx6j
         kh31rwzo9oN22FZt543l38CEmu3AwbE7BE7UO6UeSaK2PBW5UDuzjEWoUOqQh3TmHouG
         7Pvg==
X-Gm-Message-State: AO0yUKW0X9eZakwyNwUFUWver/lLy5R/Wlgo3M8Zo6/KCS0QmhrjhuTY
        e4Rf1KVWFqmzjq75bIc4F0jpoA==
X-Google-Smtp-Source: AK7set9MUnU8VvfsvVaIq/Or338muK8PL0UGOugI4JZSjpEDpqiycPmBpgyzKRDbCfFOS2RaJaUHew==
X-Received: by 2002:a5d:6b4f:0:b0:2bf:b68a:e122 with SMTP id x15-20020a5d6b4f000000b002bfb68ae122mr1898790wrw.33.1675757278977;
        Tue, 07 Feb 2023 00:07:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c58c:fc5c:67d6:e5f3? ([2a01:e0a:982:cbb0:c58c:fc5c:67d6:e5f3])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d6d06000000b002be099f78c0sm11055130wrq.69.2023.02.07.00.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 00:07:58 -0800 (PST)
Message-ID: <c65e894d-2682-9fc4-1843-1e30b2779d42@linaro.org>
Date:   Tue, 7 Feb 2023 09:07:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/4] dt-bindings: pwm: Convert Amlogic Meson PWM binding
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org
References: <8df4ceec-663c-dc68-d775-5caeb02c0cca@gmail.com>
 <5b83767e-c53d-316f-df10-45a39dbd9c88@gmail.com>
 <20230206082317.ygvixvhjqppz4nmy@pengutronix.de>
Organization: Linaro Developer Services
In-Reply-To: <20230206082317.ygvixvhjqppz4nmy@pengutronix.de>
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

Hi,

On 06/02/2023 09:23, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Feb 01, 2023 at 09:00:21PM +0100, Heiner Kallweit wrote:
>> Convert Amlogic Meson PWM binding to yaml.
>>
>> Reviewed-by: Rob Herring <robh+dt@kernel.org>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> How is supposed to pick up this patch? Does it go in together with the
> other patches in this series via amlogic/arm; or is there an expectation
> that it enters via PWM?

I expect Thierry to pick it, if he can't I can take with his ack.

Neil

> 
> Best regards
> Uwe
> 

