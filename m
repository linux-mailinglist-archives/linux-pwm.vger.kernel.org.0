Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8387F1023
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Nov 2023 11:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjKTKTS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Nov 2023 05:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjKTKTR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Nov 2023 05:19:17 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70F3BA
        for <linux-pwm@vger.kernel.org>; Mon, 20 Nov 2023 02:19:12 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c887d1fb8fso678961fa.0
        for <linux-pwm@vger.kernel.org>; Mon, 20 Nov 2023 02:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700475551; x=1701080351; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=m3PqdGd3hzZKCAL9p199LXfBSoxwo8nMT5FPvyOoA9c=;
        b=m1yn9h/L+TwUamT9qs55AUfrl0KssNmjtZaRHujzEsxyXnNaFQwCqWRwgKAN2M/ssj
         daMtsCYudJJHmliY2hlXybPPiQa1EF9ADslr9Yps+iwo/Dy2BmU5QCosLlqVaXPycqkj
         fzS53CiLCqjR4QngzBzDxSL5U78DwQfSnrPtDqnRC4GZ/IHvWPpRCVLtL5u/1MVQy53N
         ZEMiHAlN1mlccYNAZKeUH6tug9SIH11Du5dLF1fn7X6BlXDlTMeCzi2jIWuQlkckxE+W
         kga2kOnMkQaMcLkz7QVyOBUtz0cf30C3y3TrogOythexiTrHKxigtsiqyQziR+//SIbN
         y7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700475551; x=1701080351;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3PqdGd3hzZKCAL9p199LXfBSoxwo8nMT5FPvyOoA9c=;
        b=ThLlX3GU3uHVPCpYb2vzpSS8+TtDJdB+bcM6Z8K1sA7l+KxfT/WMaTABj+BWKaLOVy
         8Ay2olCAY+W+n7DqobbVjh0zd33aU0uacxCJ9sJzRYY8qSAOrdbi99IuQJuuY6D8FPNc
         Z1URbrrmu9ugo9vmqDN0aQo9VW11AMGRzKh3BfMJoX69N8SkYr+xPwU5SZMcV7J1lv7W
         AjesQ34AMv6dG6P+fYk42lZ0LdowYOQt2z5qjVMO/qg7QLx7wOdIU+Y1jYz8sNWI2Hxo
         nijRdyBkSCebqy3zSk0tcSVhv+uAmZjx6wKtpxLpmxsIcqpaM3f50MbccjXymeHehdiI
         eruw==
X-Gm-Message-State: AOJu0Yyfk/I6LdwfEazntN3ZUsguOkSpbKeLvegPZBHJRloTy3A3Fckd
        AoIww5Nk1fPPClSxsTGmtQRQlQ==
X-Google-Smtp-Source: AGHT+IEPX2G5aclVwRbVdhdVk6Qz+Wvs9j7cq77cqcIy9GhSHMtNLsN6GkXktc/8rAKZlPKJNJuIYw==
X-Received: by 2002:a2e:a162:0:b0:2bb:b01a:9226 with SMTP id u2-20020a2ea162000000b002bbb01a9226mr4153302ljl.7.1700475550839;
        Mon, 20 Nov 2023 02:19:10 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:36e8:9c14:4901:7aca])
        by smtp.gmail.com with ESMTPSA id j32-20020a05600c1c2000b004094c5d929asm13027434wms.10.2023.11.20.02.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 02:19:10 -0800 (PST)
References: <20231117125919.1696980-1-jbrunet@baylibre.com>
 <20231117125919.1696980-3-jbrunet@baylibre.com>
 <170040994064.269288.960284011884896046.robh@kernel.org>
 <4608012c-059f-4d6a-914b-e85ad0c32ff0@linaro.org>
 <1j5y1wg3sb.fsf@starbuckisacylon.baylibre.com>
 <2e7a65da-5c1d-4dd4-ac69-7559a53afdf3@linaro.org>
User-agent: mu4e 1.10.7; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     neil.armstrong@linaro.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        JunYi Zhao <junyi.zhao@amlogic.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: pwm: amlogic: add new compatible
 for meson8 pwm type
Date:   Mon, 20 Nov 2023 11:04:48 +0100
In-reply-to: <2e7a65da-5c1d-4dd4-ac69-7559a53afdf3@linaro.org>
Message-ID: <1j1qckg21u.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Mon 20 Nov 2023 at 10:55, neil.armstrong@linaro.org wrote:

> Hi Jerome,
>
> On 20/11/2023 10:18, Jerome Brunet wrote:
>> On Mon 20 Nov 2023 at 09:27, Neil Armstrong <neil.armstrong@linaro.org>
>> wrote:
>> 
>>> Hi Rob,
>>>
>>> On 19/11/2023 17:05, Rob Herring wrote:
>>>> On Fri, 17 Nov 2023 13:59:12 +0100, Jerome Brunet wrote:
>>>>> Add a new compatible for the pwm found in the meson8 to sm1 Amlogic SoCs.
>>>>>
>>>>> The previous clock bindings for these SoCs described the driver and not the
>>>>> HW itself. The clock provided was used to set the parent of the input clock
>>>>> mux among the possible parents hard-coded in the driver.
>>>>>
>>>>> The new bindings allows to describe the actual clock inputs of the PWM in
>>>>> DT, like most bindings do, instead of relying of hard-coded data.
>>>>>
>>>>> The new bindings make the old one deprecated.
>>>>>
>>>>> There is enough experience on this HW to know that the PWM is exactly the
>>>>> same all the supported SoCs. There is no need for a per-SoC compatible.
>>>>>
>>>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>>>> ---
>>>>>    .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 36 +++++++++++++++++--
>>>>>    1 file changed, 34 insertions(+), 2 deletions(-)
>>>>>
>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>>
>>>
>>> I'm puzzled, isn't it recommended to have a per-soc compatible now ?
>> I have specifically addressed this matter in the description,
>> haven't I ? What good would it do in this case ?
>
> Yes you did but I was asked for the last year+ that all new compatible
> should be soc specific (while imprecise, in our care soc family should be ok),
> with a possible semi-generic callback with an IP version or a first soc
> implementing the IP.
>
>> Plus the definition of a SoC is very vague. One could argue that
>> the content of the list bellow are vaguely defined families. Should we
>> add meson8b, gxl, gxm, sm1 ? ... or even the actual SoC reference ?
>> This list gets huge for no reason.
>
> I think in our case soc family is reasonable since they share same silicon
> design.
>
>> We know all existing PWM of this type are the same. We have been using
>> them for years. It is not a new support we know nothing about.
>> 
>>>
>>> I thought something like:
>>> - items:
>>>      - enum:
>>>          - amlogic,gxbb-pwm
>>>          - amlogic,axg-pwm
>>>          - amlogic,g12a-pwm
>>>      - const: amlogic,pwm-v1
>> I'm not sure I understand what you are suggesting here.
>> Adding a "amlogic,pwm-v1" for the obsolete compatible ? No amlogic DT
>> has that and I'm working to remove this type, so I don't get the point.
>> 
>>>
>>> should be preferred instead of a single amlogic,meson8-pwm-v2 ?
>> This is named after the first SoC supporting the type.
>> Naming it amlogic,pwm-v2 would feel weird with the s4 coming after.
>> Plus the doc specifically advise against this type of names.
>
> The -v2 refers to a pure software/dt implementation versioning and not
> an HW version, so I'm puzzled and I requires DT maintainers advice here.
>
> Yes meson8b is the first "known" platform, even if I'm pretty sure meson6 has

This is not my point. I picked this name because I have to pick a
specific device based one. Not because it is actually the first or
not. I don't see a problem with meson6 being compatible with
meson8-pwm-v2, if that ever comes along.

I think the binding here satisfy the rule that it should be specific,
and the intent that goes with it:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/writing-bindings.rst?h=v6.7-rc2#n42

> the same pwm architecture, this is why "amlogic,pwm-v1" as fallback seems more
> reasonable and s4 and later pwm could use the "amlogic,pwm-v2"
> fallback.

That is not how understand this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/writing-bindings.rst?h=v6.7-rc2#n82

>
> Neil
>> 
>>>
>>> Neil
>> 

