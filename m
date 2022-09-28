Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6D15EE45E
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Sep 2022 20:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbiI1S3u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Sep 2022 14:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiI1S3q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Sep 2022 14:29:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EA19FE3;
        Wed, 28 Sep 2022 11:29:38 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x92so5237469ede.9;
        Wed, 28 Sep 2022 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LecMmmCV4KkS+yKiNrgFY1wAFi+9PPAIyyf/Hq5BKnc=;
        b=lInReJjxSFjgeQ2BQQM+yyrHx23D+TioDVNvYfHww08wCGmXNjxz2C80XsNix7FuTn
         JYyXvFA+9YB5EN2yZW+gYDaKP/vuwVCPw6sxgI1tsHD4JCh5RSJOYYEt0wgM/3h0ReTG
         APqJ+hksh1NymTeNVn4UHaml5a7rC78lce7mGuUFEGAUgoaKiJNijym8iKaj46zd0lIb
         isEC1nZaEBWEFiL2l9Zj1x3OOwtzKCHqRhbkvxHSqZYYoXI8i3MEIcos3sUnx9OveWgR
         ZQoZcLbZs7LU9ke9GyBJru5nHcqFnaiZP9gw/BWEIyRht1XeQs43FHqXU8XHWBDZ13Uy
         bvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LecMmmCV4KkS+yKiNrgFY1wAFi+9PPAIyyf/Hq5BKnc=;
        b=djFuHC86l7FRzKmB/Ph1ckyjMXn5Ku/embWvU4yu0+qHpYhZa1BZbA3cGixvenoZpr
         tAdS14+7N3q2HchGIRs0f9LmAdtLhsrcz+y+8E3MzfW7p4mB7mmj5zGtXuIYsjp+4t79
         UAoXyrIfhI8um5imumopeXVE0U1CfHKlc9X3vVgGs1yhlncuKv7iiUElLIVs1p0GwlDr
         +Qv5NPGlOVJecutrsXr63JLtHMWT4M2PuIPTK0J6GXo5ladLyDKJUTXLSr2NGMHEx2ZJ
         xwhccHs/ozuphg+jrVo03oWDwSsgHbHBZzHICFh8hFoDx9iC8Z5fzit6emH9hd1uZjhC
         RQiQ==
X-Gm-Message-State: ACrzQf0HHrpGyCI4PV/ZAlDEBywvjwZ2oT0AmYWbIMp6KcRd3nRXJ9Pz
        +P8qgXU3Mb0F71C2ThZdQgE=
X-Google-Smtp-Source: AMsMyM5W/8fPkCuQCjMr6yqVljOnuxDalpqaUEAD/1BRpsYWqZNOIJ/9blKcYqFLSULFtXp9xsuyxw==
X-Received: by 2002:a05:6402:4310:b0:451:3b07:9114 with SMTP id m16-20020a056402431000b004513b079114mr33628300edc.153.1664389777355;
        Wed, 28 Sep 2022 11:29:37 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m17-20020a50c191000000b00456f569f31dsm3939463edf.75.2022.09.28.11.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 11:29:36 -0700 (PDT)
Message-ID: <66b5b616-ae9f-a1aa-e2b5-450f570cfcdd@gmail.com>
Date:   Wed, 28 Sep 2022 20:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] dt-bindings: pwm: rockchip: Add description for
 rk3588
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-pwm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20220901135523.52151-1-sebastian.reichel@collabora.com>
 <1662059695.095333.2226883.nullmailer@robh.at.kernel.org>
 <20220913091202.2oawzrq2u5iiz6hq@pengutronix.de>
 <20220913141601.fi6pl2xdo4xmtw6t@mercury.elektranox.org>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220913141601.fi6pl2xdo4xmtw6t@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 9/13/22 16:16, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Sep 13, 2022 at 11:12:02AM +0200, Uwe Kleine-König wrote:
>> Hello Rob,
>>
>> On Thu, Sep 01, 2022 at 02:14:55PM -0500, Rob Herring wrote:
>>> On Thu, 01 Sep 2022 15:55:23 +0200, Sebastian Reichel wrote:
>>>> Add "rockchip,rk3588-pwm" compatible string for PWM nodes found
>>>> on a rk3588 platform.
>>>>
>>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>>> ---
>>>> No driver changes required.
>>>> ---
>>>>  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>
>>> Running 'make dtbs_check' with the schema in this patch gives the
>>> following warnings. Consider if they are expected or the schema is
>>> incorrect. These may not be new warnings.
>>>
>>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>>> This will change in the future.
>>
>> Is this a list of *new* warnings, or is the report (somewhat) orthogonal
>> to the actual change and you just used the opportunity that someone
>> touched the pwm-rockchip binding to point out that there is some cleanup
>> to do?
>>
>>> Full log is available here: https://patchwork.ozlabs.org/patch/
>>
>> Hm, that gives me a 404.
> 

> This is an existing problem with the rv1108 binding.
> The rk3588 does not have pwm interrupts.

Hi,

Could you recheck?

From Rockchip RK3588 Datasheet V0.1-20210727.pdf:

PWM
Support 16 on-chip PWMs(PWM0~PWM15) with interrupt-based operation
Programmable pre-scaled operation to bus clock and then further scaled
Embedded 32-bit timer/counter facility
Support capture mode
Support continuous mode or one-shot mode
Provides reference mode and output various duty-cycle waveform
Optimized for IR application for PWM3, PWM7, PWM11, PWM15

===

ARM: dts: rk3288: add the interrupts property for PWM 
https://github.com/rockchip-linux/kernel/commit/16b7b284618d1652e694f6286f575ce82f5f03e5

Comment:
At the moment, we can find the remotectl pwm is needed on box.
We can add the property for all PWMs. AFAIK, the pwm driver don't use it
but the drivers/input/remotectl/rockchip_pwm_remotectl.c

===

From Rockchip RK3568 TRM Part1 V1.1-20210301.pdf

8-bit repeat counter for one-shot operation. One-shot operation will produce N + 1
periods of the waveform, where N is the repeat counter value, and generates a
single interrupt at the end of operation

Continuous mode generates the waveform continuously, and does not generates
any interrupts

> 
> -- Sebastian
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
