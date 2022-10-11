Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A075FBAC8
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Oct 2022 20:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJKS42 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Oct 2022 14:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJKS42 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Oct 2022 14:56:28 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D7A70E4F
        for <linux-pwm@vger.kernel.org>; Tue, 11 Oct 2022 11:56:25 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a5so4082635qkl.6
        for <linux-pwm@vger.kernel.org>; Tue, 11 Oct 2022 11:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7x0QWEjMITni9D9z1IbLkk3S/dD4GRJa1XmwJ8g62s=;
        b=g4M1pOOZX39JJVnCFOfKNWeyGvvikax9hnBg+I6zuf9dFDC2i6Jl79KFA/IgCZmLJK
         lVe5dx5Ev77sIdukYY19sxD/fPjbpHYcCUoJAYrCYjmbfaLDJOEJsq01dZle/5tcVKCJ
         Tk3jueSJ+rvwxvo14AwM5Atwpou9qWceCpP7pTGgvS6UoqFJXaN8kbxZmWY+LluAmY+b
         QgltMvfT6nju/Whx7u8wmFOvkBcPMf0oRTNkmqBpNt+TBzsPvjFsOVCU2rMb5rZ0N6Mn
         v1mskClTwVrGwQ+5Pcd+Flopbr0POZgkVXCEJGtKwH2I/yWw2E+gH1WtQAbnzoEXrUAp
         23zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7x0QWEjMITni9D9z1IbLkk3S/dD4GRJa1XmwJ8g62s=;
        b=cGbiX1bqvf3aMd+YmfiZy0kltkD2gna7pqn3e7/hqYZxHulaIvLaEaJ0LVH35eotfy
         a7ICvsi2X48P+73hiwGhw+VNrweLa+3Q3xo34fZLw9tFy6VEwttr4wUi0uEhrJOkjlzp
         u30LvEtk4Hphnh1iN1rEhwEuRCWOGk4ELEVw9uQgaiqEncsRjv+P5gZ2G1UeUl0/UMiJ
         mhszATkTHOttOsEQCTUYNl8nWu6S50kVap4f5R/Vg5K+dN0kG/krqWpfQHAwTNv7QfIh
         A7pkKVcyqI18MeGh+rXiI5ntBfjGaCSyVbqR19OLP7fA7eWo+K80SqvoKrTzSfslUzm/
         UnJw==
X-Gm-Message-State: ACrzQf1DrtUfv8RPf/MGd/GQpE47HBwXtHrRf4W7J15HV99stqczBFJ0
        5glXhDNsqRmmkC1SnTqaXtMEOA==
X-Google-Smtp-Source: AMsMyM4gCR9XfwZQWK1v933wx7NJZkHpiSNCGr5SQJfRREgOt5REl6NsTqhrjF8Yoregd3V5sfWhFA==
X-Received: by 2002:a05:620a:28cd:b0:6cf:93b3:a78 with SMTP id l13-20020a05620a28cd00b006cf93b30a78mr17817152qkp.11.1665514584908;
        Tue, 11 Oct 2022 11:56:24 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id bs38-20020a05620a472600b006b615cd8c13sm13690108qkb.106.2022.10.11.11.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 11:56:24 -0700 (PDT)
Message-ID: <b701187b-d2aa-eecc-0052-d611d1f45807@linaro.org>
Date:   Tue, 11 Oct 2022 14:53:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Lee Jones <lee@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-5-biju.das.jz@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221010145222.1047748-5-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 10/10/2022 10:52, Biju Das wrote:
> Add support for RZ/G2L MTU3 PWM driver. The IP supports
> following PWM modes
> 
> 1) PWM mode{1,2}
> 2) Reset-synchronized PWM mode
> 3) Complementary PWM mode{1,2,3}
> 
> This patch adds basic pwm mode 1 support for RZ/G2L MTU3 driver
> by creating separate logical channels for each IOs.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3->v4:
>  * There is no resource associated with "rz-mtu3-pwm" compatible
>    and moved the code to mfd subsystem as it binds against "rz-mtu".
>  * Removed struct platform_driver rz_mtu3_pwm_driver.
> v2->v3:
>  * No change.
> v1->v2:
>  * Modelled as a single PWM device handling multiple channles.
>  * Used PM framework to manage the clocks.
> ---
>  drivers/mfd/Kconfig       |   6 +
>  drivers/mfd/Makefile      |   2 +
>  drivers/mfd/rz-mtu3-pwm.c | 405 ++++++++++++++++++++++++++++++++++++++

That's not a MFD driver. That's a PWM. Use proper subsystem and email
prefix.

The same applies to your other patches.

Best regards,
Krzysztof

