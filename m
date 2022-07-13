Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4A85735F3
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jul 2022 14:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbiGMMGO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jul 2022 08:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiGMMGN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jul 2022 08:06:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5221034ED
        for <linux-pwm@vger.kernel.org>; Wed, 13 Jul 2022 05:06:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l22-20020a05600c4f1600b003a2e10c8cdeso2000577wmq.1
        for <linux-pwm@vger.kernel.org>; Wed, 13 Jul 2022 05:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cFzXm7FkqFEGmY7ZvWygg5JPqy1rrXb63f/H3RTjw5Q=;
        b=juOeqYB/IHvxzcxziLjgU4xWOupolDlaODbTlG6FvpPD3xDBnH0GQxGui2SIml5Rcl
         igb32w0V9g54LnYLDQoCdCtug1jYv7EUF/EVxJkNMJnfbuBo0HrjaMnAfN+guMMPv+jG
         SqCmppCluiwhKlLwgnPHlHTwkHM5ydWXuW6hPEg0FARANUUg+4WBiWsNBI3hFsmlVUHx
         cpM8opBxPgVV5erzkvtlEcmKHB2LA2qA6FhU0Fbtpbzg984cTBduJhqTM4qCNOaK6Z+X
         dIztYOOWn0ke76zCnIFV7TkAhxeOfkB0lIxAAQqqZ7WCIQDcZC+0OF0Ap7TWiCL7Zgox
         U1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cFzXm7FkqFEGmY7ZvWygg5JPqy1rrXb63f/H3RTjw5Q=;
        b=KtDWShEl5RP2n7hLE4OQvINrbxpfZbKZMj2rAVqyUO66gH/yiZo21W0bQn3h3Rx9jZ
         hTzDKypSraP2Y1FAfvVj3lgkCNQPA5bYnWaS7br63jbWP3Qpy3hFSe3vd3gSFcu6z9y6
         QZDAr9kdyOTQnwP2iW87B94vJdhaIRD8XsxNKmrfALbbVlL0AbhsVJhZbyiJn3qBEjBj
         zrcrLfK8IJcjTiGUul4umDnDCwBCnykdBzgXTsybWjf0IZ3ofZFRQ2mBfB5/AXZjeyBR
         6NJwwPfhzIZCjkdkOhJt/TlHp4rxOEbLitYUv/fsiT9eWWfSsM1pKRRL0fUmwtRKICs1
         L8mg==
X-Gm-Message-State: AJIora/zVD2SvzjGM5JzQOHZqjgAO//waOeu8kHvi2JfdZba7HWm2hfU
        gQJwUMIU4KT2q2/iyrHaPd0Kug==
X-Google-Smtp-Source: AGRyM1swYzam1sNiQvAydj9MjXOvIWnRc8kJtUr8l9k3XC1v6bhQu6SWwAo5FoeVNHcD2VJMg8Ek7Q==
X-Received: by 2002:a05:600c:4e16:b0:3a2:ef34:dbe3 with SMTP id b22-20020a05600c4e1600b003a2ef34dbe3mr3305655wmq.71.1657713971324;
        Wed, 13 Jul 2022 05:06:11 -0700 (PDT)
Received: from [192.168.0.17] (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id z8-20020a1c4c08000000b003942a244f40sm1932870wmf.25.2022.07.13.05.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 05:06:11 -0700 (PDT)
Message-ID: <32f8770c-2440-742a-0282-0cfc437b27df@sifive.com>
Date:   Wed, 13 Jul 2022 13:06:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/7] pwm: dwc: add of/platform support
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greentime Hu <greentime.hu@sifive.com>,
        u.kleine-koenig@pengutronix.de,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-4-ben.dooks@sifive.com>
 <1657635972.108769.1805849.nullmailer@robh.at.kernel.org>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <1657635972.108769.1805849.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 12/07/2022 15:26, Rob Herring wrote:
> On Tue, 12 Jul 2022 11:01:09 +0100, Ben Dooks wrote:
>> The dwc pwm controller can be used in non-PCI systems, so allow
>> either platform or OF based probing.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>>   .../devicetree/bindings/pwm/pwm-synposys.yaml | 40 ++++++++++++++
>>   drivers/pwm/Kconfig                           |  5 +-
>>   drivers/pwm/pwm-dwc.c                         | 53 +++++++++++++++++++
>>   3 files changed, 96 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/pwm/pwm-synposys.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):

Is the following equivalent:

> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/snps,pwm.yaml 


> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/pwm/pwm-synposys.yaml:11:4: [warning] wrong indentation: expected 2 but found 3 (indentation)
> ./Documentation/devicetree/bindings/pwm/pwm-synposys.yaml:31:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> 
> dtschema/dtc warnings/errors:
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:

Whoops, turns out I hadn't installed yamllint.

> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

