Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F6857171F
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Jul 2022 12:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiGLKUd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Jul 2022 06:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiGLKU1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Jul 2022 06:20:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C287EACF54
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jul 2022 03:20:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p4so4468450wms.0
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jul 2022 03:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=04V4RQgBX7AsYN808fX5ZMZvvU/6A68Rai6mXeiPU1g=;
        b=LwceR9vem7LcRg0Hyt/kzuJes/XEsor4/Brw7bgsaxReUbQEJqa44JSxlOIkCRdVli
         RVgZqUrKK5cyjiJvbdqe/nUo/gtD6t7SnVBBe6ogZv6A/moJS6/vWcd88jCLoXCJKulb
         72QjG2qObWvnpRV4LFzBl3lGkD7w9Z46ZPDhLSAjCLxI+kJZDuMlFltdMl0qdkThvyQH
         B56gFURabUsKijiMWjhfRYyvcfPcQ3ludLWmBV/XAoAAnhpdseOXdOr+6lFZfbOyC/He
         69rO2givfRparQjSE7GKjbNWN2WjzjQqnIQuESVk6+swPhwuUE8NTdNlDTJ0FGYANEnK
         g8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=04V4RQgBX7AsYN808fX5ZMZvvU/6A68Rai6mXeiPU1g=;
        b=vPFc8wtF94dhFf3epi4/42w25z6si7boRiyccztQN3rBzxaUefBGqpjTRw8V1wLUOT
         bxSXUdOiVFpXN+ylH8/+eGpNgwJNWFgeECrYSjiSV2oVRtu1+ArBq+eqgpZfurgia5hG
         fBTKgO+BAUkqEzh0bF2A4IV0yPBNNxmJjRgLed9iSEfW5H6MiFp/2u3I4xhTndO+4GQm
         6YTOsUKniYW7yUxj8WAYVfWmf17ojTzO/Jh4niHxXZ4o8su6Jw1B3OL4N6tQ9y5PWbpK
         MRMwUQGRCThMzT5x0IJC+R0bsFJIuefoxRm+oDot/ZNMxpbqjskpJQ6iQbZAK3Njninu
         YCKw==
X-Gm-Message-State: AJIora/kM8bW4mF1t066s1MW3AeYwxtgF7HVMBRLadaKdbyGesFBr/GN
        86W6tIuZ38I0/tyUsb6WNU1mjw==
X-Google-Smtp-Source: AGRyM1t0HAxAGODjou1yysBiPRklZspiATIK3jALlva7H/1Pk/bj3nzYOdTyPBsVKXEIeHqctSnR3Q==
X-Received: by 2002:a05:600c:5026:b0:3a2:ea0c:ea8a with SMTP id n38-20020a05600c502600b003a2ea0cea8amr2839054wmr.53.1657621224427;
        Tue, 12 Jul 2022 03:20:24 -0700 (PDT)
Received: from [10.35.4.171] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c4f0900b003a2e42ae9a4sm9545640wmq.14.2022.07.12.03.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 03:20:24 -0700 (PDT)
Message-ID: <77c97281-96d9-c969-18cf-6e609098aa57@sifive.com>
Date:   Tue, 12 Jul 2022 11:20:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 6/7] pwm: dwc: remove the CONFIG_OF in timer clock
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-7-ben.dooks@sifive.com>
 <bcbd1b29-7c6d-1d1d-2c72-b8818e99c65c@linaro.org>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <bcbd1b29-7c6d-1d1d-2c72-b8818e99c65c@linaro.org>
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

On 12/07/2022 11:09, Krzysztof Kozlowski wrote:
> On 12/07/2022 12:01, Ben Dooks wrote:
>> We should probably change from the #ifdef added earlier in
>> 49a0f4692a8752c7b03cb26d54282bee5c8c71bb ("wm: dwc: add timer clock")
>> and just have it always in the dwc data so if we have a system with
>> both PCI and OF probing it should work
>>
>> -- consider merging with original patch
> 
> Missing SoB. Please run checkpatch.

This was meant to be an RFC about whether it should be a single patch
or merged back into the previous one.

