Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A81D69B94A
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Feb 2023 11:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBRKQa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 18 Feb 2023 05:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBRKQ3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 18 Feb 2023 05:16:29 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F9B38B77
        for <linux-pwm@vger.kernel.org>; Sat, 18 Feb 2023 02:16:28 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id fd2so1739427edb.2
        for <linux-pwm@vger.kernel.org>; Sat, 18 Feb 2023 02:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isL683qk+zwUEc0fdI1TRbW50SVZApf+Izx8IU5t3v0=;
        b=XfNmEX3U5b2bz9p/4Acby5zZSdHmyuZiC9ZflVTG9zuCSZ6t2++DOdQdm2MJ19SZ9S
         9MdULBlDxnVCX090immUY2DhglxwvP0BUPLQAoKUaiKmNLMir3tokZESbEiBeXnLck06
         p5ftKiBxux9QC/LeMUGeAU1DhFqQrd7Z1ShrKDj5/ZIb+7Dhs16wNyhPuGAJM1EnhFHK
         FFMa0CiUhqtFQdmDmHQBDhGAuL1vMhPqXxN3+TVKuiwrrhhbqgO1A2JQwQS4sTEC8Prk
         FRimIeOx4H0fvKXGwGLBX8qAUBNp2XJfDkBUnV3Qw7C5dvduT11DONqx5FmvfhsrULvm
         /tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isL683qk+zwUEc0fdI1TRbW50SVZApf+Izx8IU5t3v0=;
        b=x8uMv8aF/uKKXqSvYJiuWkI2v4NhtvACVcMPxfR/v7Lk0jG7t+XJo4cT1qITsU7B6/
         M6PPcKl+Vy4v63Drf4TVQN4Y8Z5nhdUie9qp0S5O6Xya9xs4kJMMV028j+3vpYyVUsP0
         4QF1xnTTmMVHCa+zXc8Jv1BvafiQIsneV+HxwR+mSl+kEgLdH5bXVZGOdl3EEPdePKT7
         NSd5hh+QN24sNGakW1oxKAmsaQfojhzoLx/Ur7wDdOSXU+vrCoez7FNody/BHVOzoOct
         qhfoN9qCRCdZYIIkXd0GGm0Ed7sWNV5GqsGv74E8B7F0Qk6b3LE12DqqpF0gW5p7Y3UN
         De+A==
X-Gm-Message-State: AO0yUKWl6pv+EzcFfrGssrS7bhjFzSsBV4U2ZQbzG9MeNIy2D9u+/Lbb
        aUqWO5hKtPIX06Qa0oP3rIuYZg==
X-Google-Smtp-Source: AK7set8F5+d4ybBx7pl4yewkqkHJpbFAsLcHzIGt4byA3KBeymPai/DkcZidLH13N/hJczuU5rqiqA==
X-Received: by 2002:a17:906:2655:b0:8af:5752:26e4 with SMTP id i21-20020a170906265500b008af575226e4mr1059536ejc.68.1676715387002;
        Sat, 18 Feb 2023 02:16:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906474b00b0088f8a61eb48sm3208173ejs.154.2023.02.18.02.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 02:16:26 -0800 (PST)
Message-ID: <610e8b6a-8e1c-753e-d2c9-0056a7804f9b@linaro.org>
Date:   Sat, 18 Feb 2023 11:16:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 3/3] dt-bindings: misc: servo-pwm: Add new bindings for
 servo-pwm
Content-Language: en-US
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc:     Angelo Compagnucci <angelo@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:GENERIC PWM SERVO DRIVER" <linux-pwm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230217161038.3130053-1-angelo@amarulasolutions.com>
 <20230217161038.3130053-3-angelo@amarulasolutions.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217161038.3130053-3-angelo@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 17/02/2023 17:10, Angelo Compagnucci wrote:
> This binding describes the binding for controlling servo motors through
> pwm.
> 
> Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> ---
> v2:
> * Converted old txt to yaml
> v3:
> * Fixed errors rised by make dt_binding_check 

Still fails the tests.

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> 
>  .../devicetree/bindings/misc/servo-pwm.yaml   | 57 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/servo-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/servo-pwm.yaml b/Documentation/devicetree/bindings/misc/servo-pwm.yaml
> new file mode 100644
> index 000000000000..73e81b939daf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/servo-pwm.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/servo-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Servo motor connected to PWM
> +
> +maintainers:
> +  - Angelo Compagnucci <angelo@amarulasolutions.com>
> +
> +description:
> +  Each servo is represented as a servo-pwm device.
> +  The 20ms period is the accepted standard and so most of the motors
> +  support it, while the positioning min/max duty cycle or the motor
> +  degrees aperture vary lot between manufacturers.
> +  The most common type of servo (SG90) has 180 degrees of movement
> +  and moves between 0.5ms and 2.5ms duty cycle.
> +
> +properties:
> +  compatible:
> +    const: servo-pwm
> +
> +  pwms:
> +    maxItems: 1
> +
> +  pwm-names: true

You got later feedback from Rob for v2, so this needs changes.

> +
> +  degrees:
> +    description:
> +      How many degrees the motor can move.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  duty-min:
> +    description:
> +      Duty cycle for position the motor at 0 degrees.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  duty-max:
> +    description:
> +      Duty cycle for positioning the motor at "degrees" angle.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +

Drop blank line.

Krzysztof

