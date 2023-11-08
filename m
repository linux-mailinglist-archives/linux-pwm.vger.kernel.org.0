Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BE77E5BFF
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Nov 2023 18:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjKHRK4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Nov 2023 12:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjKHRKz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Nov 2023 12:10:55 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33968D4F
        for <linux-pwm@vger.kernel.org>; Wed,  8 Nov 2023 09:10:53 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c5720a321aso94130961fa.1
        for <linux-pwm@vger.kernel.org>; Wed, 08 Nov 2023 09:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699463451; x=1700068251; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=IFz0eNLwTOarw1Cn3vCdHlCb5O2fB0yCDsA3mDW0SnA=;
        b=wrojkBZ1W6WGuxTxhjpbqyeOPLthD+qqotCXSWbZ695RsGgb3vQgYufN6feEJrhWQE
         4w34LOyILjc9jq2jj5wEfZ7Hx9gFFJALHlGSrFpoZAHMLamh0VguP7rqG2QUI/tcQDo3
         HiIrm+SRu+aPu4Q4VbUsBxdQGD4FN7vUR1trZatSucL6zGcQlwb4Tjm/32DFEErWoI+B
         B34OhV5c5ehHqSB5ntal3A4caXaRVAE4AkC370SfTXE0SEU1uaLH9v/PuZNx0tw4YAye
         5+Ysa0WBN6h2KPGb5LohxVi1Kn+om1kfezZPBBXw2QYsl4iYCyNTnC/qo5PkwGSkKpvG
         hljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699463451; x=1700068251;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFz0eNLwTOarw1Cn3vCdHlCb5O2fB0yCDsA3mDW0SnA=;
        b=HrEINxAQLG2PRNsdFxA5htTpSEXY1OsOiaRKeVJF2JHrlxMXl2/B5qZ+VQCPcClzTR
         lGGlFyiM752lTcNZNL792k7r5oXzqhZ7QWDhl7D3ydrsDuM+jpquo2yM++VE3yf9Qluk
         ByjCHCwuKFv72PKKiYP5sfojeknEge9ugHH6NUYnntjt8ZmhhB49718Ic1a5YfIQeWbk
         lf/vIp9HtHuuEEQKDxfB5AyYMX8HEZc4CHuVQmFbhyUE+CtDRpUpk8Sw1DCjjPWVFyvo
         kID+MO2BcZQ0jP7sGtrzhpZPwlAFNfxYbG2+JlXp94EhfSicLPIcvU7rZRPcZoLgIZwN
         XJCA==
X-Gm-Message-State: AOJu0Yx2GrQGtCiCjjK3Ig0SHaKCkdqRZfQ7Me4T9ngx2mbUYND9PMEZ
        Och+Likf3xQCHqr0dMUhInx2Cg==
X-Google-Smtp-Source: AGHT+IF1FSTZDOkyqqQddRNlqkjWeUassJy7xXc1gtYTXwCTvhN31qmjvUL0EtDj8GuAWMzO/KdJqg==
X-Received: by 2002:a2e:9617:0:b0:2c5:1388:e370 with SMTP id v23-20020a2e9617000000b002c51388e370mr2282793ljh.30.1699463451176;
        Wed, 08 Nov 2023 09:10:51 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:dfaa:8961:ce90:9db0])
        by smtp.gmail.com with ESMTPSA id az25-20020a05600c601900b004095874f6d3sm20477052wmb.28.2023.11.08.09.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:10:50 -0800 (PST)
References: <20231106103259.703417-1-jbrunet@baylibre.com>
 <20231106103259.703417-2-jbrunet@baylibre.com>
 <20231108170448.GA2388329-robh@kernel.org>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        JunYi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH 1/6] dt-bindings: pwm: amlogic: fix s4 bindings
Date:   Wed, 08 Nov 2023 18:08:55 +0100
In-reply-to: <20231108170448.GA2388329-robh@kernel.org>
Message-ID: <1jbkc4cgrp.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Wed 08 Nov 2023 at 11:04, Rob Herring <robh@kernel.org> wrote:

> On Mon, Nov 06, 2023 at 11:32:48AM +0100, Jerome Brunet wrote:
>> s4 has been added to the compatible list while converting the Amlogic PWM
>> binding documentation from txt to yaml.
>> 
>> However, on the s4, the clock bindings have different meaning compared to
>> previous SoCs.
>> 
>> On previous SoCs the clock bindings used to describe which input the PWM
>> channel multiplexer should pick among its possible parents.
>> 
>> This is very much tied to the driver implementation, instead of describing
>> the HW for what it is. When support for the Amlogic PWM was first added,
>> how to deal with clocks through DT was not as clear as it nowadays.
>> The Linux driver now ignores this DT setting, but still relies on the
>> hard-coded list of clock sources.
>> 
>> On the s4, the input multiplexer is gone. The clock bindings actually
>> describe the clock as it exists, not a setting. The property has a
>> different meaning, even if it is still 2 clocks and it would pass the check
>> when support is actually added.
>> 
>> Also the s4 cannot work if the clocks are not provided, so the property no
>> longer optional.
>> 
>> Finally, for once it makes sense to see the input as being numbered
>> somehow. No need to bother with clock-names on the s4 type of PWM.
>> 
>> Fixes: 43a1c4ff3977 ("dt-bindings: pwm: Convert Amlogic Meson PWM binding")
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 68 ++++++++++++++++---
>>  1 file changed, 59 insertions(+), 9 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> index 527864a4d855..754b70fc2db0 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> @@ -9,9 +9,6 @@ title: Amlogic PWM
>>  maintainers:
>>    - Heiner Kallweit <hkallweit1@gmail.com>
>>  
>> -allOf:
>> -  - $ref: pwm.yaml#
>> -
>>  properties:
>>    compatible:
>>      oneOf:
>> @@ -43,12 +40,8 @@ properties:
>>      maxItems: 2
>>  
>>    clock-names:
>> -    oneOf:
>> -      - items:
>> -          - enum: [clkin0, clkin1]
>> -      - items:
>> -          - const: clkin0
>> -          - const: clkin1
>> +    minItems: 1
>> +    maxItems: 2
>>  
>>    "#pwm-cells":
>>      const: 3
>> @@ -57,6 +50,56 @@ required:
>>    - compatible
>>    - reg
>>  
>> +allOf:
>> +  - $ref: pwm.yaml#
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - amlogic,meson8-pwm
>> +              - amlogic,meson8b-pwm
>> +              - amlogic,meson-gxbb-pwm
>> +              - amlogic,meson-gxbb-ao-pwm
>> +              - amlogic,meson-axg-ee-pwm
>> +              - amlogic,meson-axg-ao-pwm
>> +              - amlogic,meson-g12a-ee-pwm
>> +              - amlogic,meson-g12a-ao-pwm-ab
>> +              - amlogic,meson-g12a-ao-pwm-cd
>> +              - amlogic,meson-gx-pwm
>> +              - amlogic,meson-gx-ao-pwm
>> +    then:
>> +      # Historic bindings tied to the driver implementation
>> +      # The clocks provided here are meant to be matched with the input
>> +      # known (hard-coded) in the driver and used to select pwm clock
>> +      # source. Currently, the linux driver ignores this.
>> +      properties:
>> +        clock-names:
>> +          oneOf:
>> +            - items:
>> +                - enum: [clkin0, clkin1]
>> +            - items:
>> +                - const: clkin0
>> +                - const: clkin1
>> +
>> +  # Newer IP block take a single input per channel, instead of 4 inputs
>> +  # for both channels
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - amlogic,meson-s4-pwm
>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: input clock of PWM channel A
>> +            - description: input clock of PWM channel B
>> +      required:
>> +        - clocks
>
> What are the 'clock-names' in this case? Because it's still allowed.
>

Indeed, it should not be.
I should add 'clock-names: false' , right ?

> Rob

