Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82075735E1
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jul 2022 13:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiGML5G (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jul 2022 07:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbiGML5F (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jul 2022 07:57:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9059F1034F9
        for <linux-pwm@vger.kernel.org>; Wed, 13 Jul 2022 04:56:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b26so15173762wrc.2
        for <linux-pwm@vger.kernel.org>; Wed, 13 Jul 2022 04:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qxcQt+R1BQvmSe81l8pzxUpsvc5Hyp+NVDBvjQReI90=;
        b=ON7C9i7WOOVBRXKaAud5rrqEbU/g7AYTogs8RVrkq6VdFMNXxFOM4TVG7EvX26yTpf
         5bWyg8bOVguB1IgWsxEzjHJHIsLJlcwSMa0EUGLKDQfDj6xaXi9NZrI0F0C0dh8SuNjH
         UaW5VxA0s2M7e/H4hQqXHJ2ALmm3m8Q1PeNHcwCa41tzR2mRwUE3aYZZ9GDW7NFG/z+j
         lxUfVKANakXLyxEit6MtAqCiGcbMBr1mvM2gkmvtKFhw/tWypq/tC7wxv7D5iLSWwHFV
         AEFOSqHE13YRwE/ieEl02mHKEkovXbB900aiC5zI5A1Fk9JfWa0ViblCjWnNP0aS35kG
         E/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qxcQt+R1BQvmSe81l8pzxUpsvc5Hyp+NVDBvjQReI90=;
        b=KT8esBG7Zfciw20PyR/K7MkiL/SnxHp5iysWT/0OTWGVYXpnznRPmqyiH/Hs/goZk0
         jENVoV++huYp8jv9ekRehIS5esX3hZN+2fqZ83aukeHMwZ1K950dWIFOKVPSfRKA0n4G
         iTgmXWMo3b5LLABkhw0A9D5Ymh5qgkSc9LO+8aENd1cxRnRRfuI/lDi5AdstdvFcO0x+
         3cZsJ4KkHz7R1i//ggboIarNDb2Y7O0sEarH+v85Mjn4C5n0FTcGvIq/QFeHm5u6IRSA
         Iut0Zw+gVQ5cDsKfAAEQR1ExruqyS2ygBaUXTyLLEIrZXcuptzy/A3ck1Kpf52gzN8zb
         vRHg==
X-Gm-Message-State: AJIora8oPgiYYF4Nm5uAZwBMLAcdpvyl49nGfVg+JbsK/yow/U+NPD5u
        Q/FRxxTlcGBZ+DAvA8d9EpGCIg==
X-Google-Smtp-Source: AGRyM1uBP9gd3wmaygD60IXxI6xdqVBlMdxdPX5CyGEgDY02YRkMmPcOJuBUbid86a+KEk70Qvz55Q==
X-Received: by 2002:adf:efd1:0:b0:21d:6731:221e with SMTP id i17-20020adfefd1000000b0021d6731221emr3028637wrp.404.1657713417102;
        Wed, 13 Jul 2022 04:56:57 -0700 (PDT)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id s14-20020a5d424e000000b0021d4d6355efsm10772676wrr.109.2022.07.13.04.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 04:56:56 -0700 (PDT)
Message-ID: <feaacf44-f9a8-b892-d8ba-8a396b49d56b@sifive.com>
Date:   Wed, 13 Jul 2022 12:56:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/7] pwm: dwc: add of/platform support
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-4-ben.dooks@sifive.com>
 <20220712221715.GT1823936-robh@kernel.org>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20220712221715.GT1823936-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 12/07/2022 23:17, Rob Herring wrote:
> On Tue, Jul 12, 2022 at 11:01:09AM +0100, Ben Dooks wrote:
>> The dwc pwm controller can be used in non-PCI systems, so allow
>> either platform or OF based probing.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>>   .../devicetree/bindings/pwm/pwm-synposys.yaml | 40 ++++++++++++++
> 
> Use compatible string for filename.

ok, will fix.

>>   drivers/pwm/Kconfig                           |  5 +-
>>   drivers/pwm/pwm-dwc.c                         | 53 +++++++++++++++++++
>>   3 files changed, 96 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml b/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
>> new file mode 100644
>> index 000000000000..38ac0da75272
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
>> @@ -0,0 +1,40 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2022 SiFive, Inc.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/pwm-synposys.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Synopsys PWM controller
>> +
>> +maintainers:
>> +   - Ben Dooks <ben.dooks@sifive.com>
>> +
>> +properties:
>> +  "#pwm-cells":
>> +    description: |
>> +      See pwm.yaml in this directory for a description of the cells format.
> 
> pwm.yaml doesn't define how many cells. You need to. And you don't need
> generic descriptions.

  "#pwm-cells":
     const: 1

should be sufficient then?

>> +
>> +  clocks:
>> +    items:
>> +      - description: Interface bus clock
>> +      - description: PWM reference clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: bus
>> +      - const: timer
>> +
>> +  compatible:
> 
> Convention is compatible comes first in the list.

ok, fixed.


>> +    oneOf:
>> +      - items:
>> +        - const: snps,pwm
> 
> Don't need oneOf or items. Just 'const: snps,pwm'.

ok, fixed.


> That's pretty generic for a compatible. There's only 1 version of the IP
> or is the version discoverable?

This IP block doesn't seem to have evolved much since being included so
I don't think so at this point, most of the revision list is for the
internal options and cleanup.

I will go through and check if all the compile-time properties are deal
with, but that'll be adding more properiteis if they are needed.

>> +
>> +required:
>> +  - "#pwm-cells"
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false

