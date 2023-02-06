Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B0768C859
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Feb 2023 22:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBFVNn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Feb 2023 16:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjBFVNn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Feb 2023 16:13:43 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507534218;
        Mon,  6 Feb 2023 13:13:42 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id lu11so38093185ejb.3;
        Mon, 06 Feb 2023 13:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZtS5vyMO1j5bifjBnwS+OCCtmHppSGHkVWDdflpcgQ=;
        b=oP0XSEHQC5aWdClkeRnAbGc7ZoYQnto0IF7DVciCduEdRoBXp7b6ibFnUX2+EQTUzi
         lcXMi28emzQ8NkxhAv03VfY3uYx33fkMRhSGV1wUtOzRVVmXI5PT5InZ/30pLPmOetz8
         JCoOEl5fYU4NlBcuqU7PAzTDvlY+3HI0TKTnoMJZigL1uRPZjI8dHbh4DcPNCjijJpIk
         zpMFWbyFMitMbdV7UysPYr19tVmtWaFh/KQ9uws/dvT2LfVf3SqWNlzW+KgGQTFd4+pU
         6/T31ATcW82RKJM4zpGwFlDnBXJk5Wfv1jvrTbr1jg5o8jyQPxiwOyLUjaNjMMy2jRln
         1jwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZtS5vyMO1j5bifjBnwS+OCCtmHppSGHkVWDdflpcgQ=;
        b=ip2KndtHLF0bJ3z8NFRLUDWribl4xe2X7xhrZ46mUbmed6icGhdhWJtinNy8lnwbKR
         qRkZEyAsmyI+zqZ3LHHDz3uvoq74c2i2BKNzg/TeHBUkFoC9l8PjZfviJt7fDSHiSOhk
         UHud6LRnBNuhDPV+RFfQhxSvkrYpJJAsdB6m9AoNVYcAe8qI3H+A3MKZNCDiT9Z6Ai2B
         2CWl2jQx1ItjzmTYwITe5J068gDKhiRukYbQUjFumS8TrlP+FTh3LeveVI/De7PpzaGj
         Cr7IGdplpWiU9Ri029M0EU+D98ukYZlMnuZSTIqzlz2obrnn1WO8meObpPtDy0fl/W5Z
         blog==
X-Gm-Message-State: AO0yUKUBv0Deq30Vu4AbJ4oCtOJPWfePR1gPTQ9Sh2LO2bie7/WZB0OE
        7HEnXA9os55+UGgfY+7utW4=
X-Google-Smtp-Source: AK7set+3+FsYuhkU78K71Ir/e1the4l9Da6i5qqPjBJa0HxQQTAfi7NQdSv/CePdjqnOZ734eAFJVw==
X-Received: by 2002:a17:906:a102:b0:878:5e84:e1da with SMTP id t2-20020a170906a10200b008785e84e1damr804504ejy.27.1675718020715;
        Mon, 06 Feb 2023 13:13:40 -0800 (PST)
Received: from ?IPV6:2a01:c23:c485:9100:38f3:3203:b326:71ab? (dynamic-2a01-0c23-c485-9100-38f3-3203-b326-71ab.c23.pool.telefonica.de. [2a01:c23:c485:9100:38f3:3203:b326:71ab])
        by smtp.googlemail.com with ESMTPSA id d20-20020a17090694d400b0088e682e3a4csm5877799ejy.185.2023.02.06.13.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 13:13:40 -0800 (PST)
Message-ID: <63b86083-1b05-d851-d141-d3578e4dc724@gmail.com>
Date:   Mon, 6 Feb 2023 22:13:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/4] dt-bindings: pwm: Convert Amlogic Meson PWM binding
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>
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
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20230206082317.ygvixvhjqppz4nmy@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 06.02.2023 09:23, Uwe Kleine-König wrote:
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
> 
Neil,
are you going to take this via the amlogic tree?

> Best regards
> Uwe
> 
Heiner

