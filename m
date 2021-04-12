Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B135F35C365
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 12:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbhDLKHe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 06:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbhDLKFc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 06:05:32 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64037C06134C;
        Mon, 12 Apr 2021 03:03:30 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h10so14306449edt.13;
        Mon, 12 Apr 2021 03:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IecIer/Daj67JEJVhH+GPnEHHlaRlGiwgqpp2Q/YAIU=;
        b=ln51gpRQqxs+aXEIsek0esHSItFg0Webv0LPtRTD2g0FmtU/iQPUd8sThf8D1iSel4
         zwDkLyxXl4ytJMdasEVWhqEWwXgWLXzop/l06D5GK7a/ylDCpdbEQEgvURJ25qsVQ2Fn
         /poXqgd6Gt0ZQK0VFY0dI3zwm35FeEgziFPsNKjYp9WdANyrO+PsLjAm7bSAA+s0Obsg
         OemRwl/0IkyD8QMUYfUJLaErOm2jBvnEDkcyxGmcWYNjNQqEt4AMOTDQuQSEa5RePELp
         t/iVc+YmVP/esBqgvjg+x8qM/w+81EGkWhvFsXSCmN7uwvJ2OR5WoY8V6wRuCwMjYIpe
         7mwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IecIer/Daj67JEJVhH+GPnEHHlaRlGiwgqpp2Q/YAIU=;
        b=eWQt2wjbgP4/IEIqbLXAjTO7g0O3zVViHXL751+Imym+HXAlCq3prC8HZ/oQ/fBtkX
         83Bba6slPf0/RTyZ3dGa1s3bK89HnlSPDpKTvzcqRlmTsb3elmdc7lFXuawbFFjlJwDA
         AQWsk25tsyiDt8ILn6JJ0Rfr9F91TRLSGPllAa4jLMYfnsH8YkCkAcbxoz1kC6pUDJ1x
         9iRRZV69wM9fj+sJjeL4D+WuVtYnlChQurSEsuq3kk6cfYH/RWgiIX791Qz5VORba4Gu
         R5jS7Tj6se922bwG0YEdu0j9fXtV4sjcEBaixJJP1fDdLAxSHFam85SkrOHHBYYXsCzy
         9gsA==
X-Gm-Message-State: AOAM532Rl+CBfTIo2Y9UsO6WqlllEDDWvtv2XRBtYaluKwOl9wNicVGT
        hiok7lylVsxLvMbAYPe1kBwxkMB7B708Dw==
X-Google-Smtp-Source: ABdhPJwsC2fOcR1VpuH/xWkjRQVk4aT58cqY4kGqC/1+OKqjTFeg+noo1vbd2uJIVw1TFGySTfCM+w==
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr28456381edw.348.1618221809192;
        Mon, 12 Apr 2021 03:03:29 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w25sm6172320edq.66.2021.04.12.03.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 03:03:28 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] ARM: dts: rockchip: remove interrupts properties
 from pwm nodes rv1108.dtsi
To:     wens@kernel.org
Cc:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210411131007.21757-1-jbx6244@gmail.com>
 <20210411131007.21757-3-jbx6244@gmail.com>
 <CAGb2v67s7a4GARfAnROKS40kaYQpdW_qWX=HX6GU09jV9wrbXw@mail.gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <31b5ff50-afe5-b446-7d3c-943d148814d8@gmail.com>
Date:   Mon, 12 Apr 2021 12:03:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v67s7a4GARfAnROKS40kaYQpdW_qWX=HX6GU09jV9wrbXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 4/12/21 5:15 AM, Chen-Yu Tsai wrote:
> On Sun, Apr 11, 2021 at 9:11 PM Johan Jonker <jbx6244@gmail.com> wrote:
>>
>> A test with the command below gives this error:
>>
>> /arch/arm/boot/dts/rv1108-evb.dt.yaml:
>> pwm@10280000: 'interrupts' does not match any of the regexes:
>> 'pinctrl-[0-9]+'
>>
>> "interrupts" is an undocumented property, so remove them
>> from pwm nodes in rv1108.dtsi.
>>
>> make ARCH=arm dtbs_check
>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> 
> Given that the interrupts were specified, meaning they are wired up in hardware,
> shouldn't the solution be to add the interrupts property to the binding instead?
> 
> After all, the device tree describes the actual hardware, not just what the
> implementations need.
> 
> ChenYu
> 

Hi,

The question of what to do with it was asked in version 1, but no answer
was given, so I made a proposal.
The device tree description should be complete, but also as lean as
possible. If someone manages to sneak in undocumented properties without
reason then the ultimate consequence should be removal I think.

Not sure about the (missing?) rv1108 TRM, but for rk3328 the interrupt
is used for:

PWM_INTSTS 0x0040 W 0x00000000 Interrupt Status Register
  Channel Interrupt Polarity Flag
    This bit is used in capture mode in order to identify the
    transition of the input waveform when interrupt is generated.
  Channel Interrupt Status
    Interrupt generated

PWM_INT_EN 0x0044 W 0x00000000 Interrupt Enable Register
  Channel Interrupt Enable

Is there any current realistic use/setup for it to convince rob+dt this
should be added to pwm-rockchip.yaml?

The rk3328 interrupt rkpwm_int seems shared between channels, but only
included to pwm3. What is the proper way for that?

Johan
