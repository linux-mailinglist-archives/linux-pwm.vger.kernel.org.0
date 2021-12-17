Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25C6479048
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Dec 2021 16:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhLQPru (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Dec 2021 10:47:50 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40084
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235702AbhLQPru (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Dec 2021 10:47:50 -0500
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 16AE73FFD9
        for <linux-pwm@vger.kernel.org>; Fri, 17 Dec 2021 15:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639756068;
        bh=hhDHhyLf8ciLV/pb2fq9VsORYOGJ7hjmmAlIVCJH7WY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=nF1tXX8b0HJQs/ty/74iw/v1xyNnALVboi1aufmSUkj20Td4sbv6QuLmwsFuzcaQw
         MQutzYoyrMdPIRQ57bWZrOlCwofchpisKkSQE9tj1JBxe6sp9ho/nSWpc1F4CSRFbC
         6sq08Rzc0nnP65ytKoRJrOWxYUmM32iGTkhn3mk0D1sRRcv9cQzEFk9Evs4sVAs+gt
         ZZOw78daxZdYd881BriTuULG5eOBxD0KEGyyLGbkOCEQqkpT2xRuY6zoLm4uShiV6F
         2kq0RKrS0BxSXvy1XUPbTnjRYFoijGJ+Yne8Tfi8QlnXod39ZfNW/lGk5c3BpyKcTk
         nai+8cnTb8ZhA==
Received: by mail-lf1-f72.google.com with SMTP id s11-20020a195e0b000000b0041c0a47fb77so1032452lfb.20
        for <linux-pwm@vger.kernel.org>; Fri, 17 Dec 2021 07:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hhDHhyLf8ciLV/pb2fq9VsORYOGJ7hjmmAlIVCJH7WY=;
        b=53WCR5ooKhzZ+kp3fr6Y/+dlfHQSpSNhklKltueW+sGin4xTMRawpDSVbxCvuJAlS5
         FT7X7hLiqQ4i37pzEDXnkFbeVjgNEE4fA9IUGw/Ru0cgU6xJ2BSHWEck0QKe0HoAeZam
         r/YUbUYmjlyepan+gO/VwFZDej49gBGbU8OU4dxKex2xdqiWaDXNH9AHJbxVEoDpQExf
         9Wg/puGWUiQA/e07eHnDhIVMVC8+afMh1YJyZWPMMVAYBvKYwJg8sH3EeABl/6KbcdEh
         l8+5FMp3/QySmDLDxvZ6135bUuF/cyvml/eKi/5rtwnDIHcpMN1cCZXf4cpyXsEZWUY7
         YjBw==
X-Gm-Message-State: AOAM532pBWAzRereWpzMO3lHu6vZa+wiLuI6PTz6jZ3ZxEAE0P2JAsmn
        9jdho0LaWL4lxPuj0clLhQ3xzYQ/z3YGRcjZbARUsk1HaW9ykTjXC+wUKzbZ6PnC1i18idNDMRW
        kb3+29DnWZ5gvbFX4vyjvEkvNA+OZlrbpnC3DGg==
X-Received: by 2002:a05:6512:2150:: with SMTP id s16mr3408753lfr.519.1639756059692;
        Fri, 17 Dec 2021 07:47:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwt9tJHIq/B3JqqY9RpHltS5AsBubgidwCcIwxibp52U1LQxYs+vVjkCeSXk+SDsWN3QzhEUw==
X-Received: by 2002:a05:6512:2150:: with SMTP id s16mr3408731lfr.519.1639756059505;
        Fri, 17 Dec 2021 07:47:39 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id w25sm356919lfl.33.2021.12.17.07.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 07:47:39 -0800 (PST)
Message-ID: <2e7588e5-9dc5-571f-d7e9-0ee5c89ab39e@canonical.com>
Date:   Fri, 17 Dec 2021 16:47:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 06/17] dt-bindings: rng: add bindings for microchip
 mpfs rng
Content-Language: en-US
To:     Conor.Dooley@microchip.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     geert@linux-m68k.org, bin.meng@windriver.com, heiko@sntech.de,
        Lewis.Hanly@microchip.com, Daire.McNamara@microchip.com,
        Ivan.Griffin@microchip.com, atish.patra@wdc.com
References: <20211217093325.30612-1-conor.dooley@microchip.com>
 <20211217093325.30612-7-conor.dooley@microchip.com>
 <e59a60d5-4397-1f7f-66ab-3dd522e166a0@canonical.com>
 <19cbe2ba-7df5-7c7c-289f-6dc419d9f477@canonical.com>
 <422126ac-ce26-2940-5b4d-fe79a1fa89c5@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <422126ac-ce26-2940-5b4d-fe79a1fa89c5@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 17/12/2021 16:22, Conor.Dooley@microchip.com wrote:
> On 17/12/2021 15:07, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 17/12/2021 15:53, Krzysztof Kozlowski wrote:
>>> On 17/12/2021 10:33, conor.dooley@microchip.com wrote:
>>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>>
>>>> Add device tree bindings for the hardware rng device accessed via
>>>> the system services on the Microchip PolarFire SoC.
>>>>
>>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>>> ---
>>>>   .../bindings/rng/microchip,mpfs-rng.yaml      | 29 +++++++++++++++++++
>>>>   1 file changed, 29 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/rng/microchip,mpfs-rng.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/rng/microchip,mpfs-rng.yaml b/Documentation/devicetree/bindings/rng/microchip,mpfs-rng.yaml
>>>> new file mode 100644
>>>> index 000000000000..32cbc37c9292
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/rng/microchip,mpfs-rng.yaml
>>>> @@ -0,0 +1,29 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: "http://devicetree.org/schemas/rng/microchip,mpfs-rng.yaml#"
>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>>> +
>>>> +title: Microchip MPFS random number generator
>>>> +
>>>> +maintainers:
>>>> +  - Conor Dooley <conor.dooley@microchip.com>
>>>> +
>>>> +description: |
>>>> +  The hardware random number generator on the Polarfire SoC is
>>>> +  accessed via the mailbox interface provided by the system controller
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: microchip,mpfs-rng
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    hwrandom: hwrandom {
>>>
>>> Three topics:
>>> 1. Node name (as most of others are using): rng
>>> 2. skip the label, not helping in example.
>>> 3. This looks very simple, so I wonder if the bindings are complete. No
>>> IO space/address... How is it going to be instantiated?
>>>
>>
>> OK, now I saw the usage in DTS. I have doubts this makes sense as
>> separate bindings. It looks like integrated part of syscontroller, so
>> maybe make it part of that binding? Or at least add ref to syscontroller
>> bindings that such child is expected.
> Acking the rest of this, re: adding the ref: is what is being done in 
> patch 03/17 insufficient?

Ops, I missed the 03/17. Yeah, it looks it is sufficient and in such
case I think you do not need this patch. The compatible is documented in
03/17. The same for sysserv.


Best regards,
Krzysztof
