Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED695EDFF1
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Sep 2022 17:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiI1PSz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Sep 2022 11:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiI1PSy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Sep 2022 11:18:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6867674DF3;
        Wed, 28 Sep 2022 08:18:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z97so17673419ede.8;
        Wed, 28 Sep 2022 08:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=83ANzPhUBDAvBVhFrZlJ/Dy3P0GTE4v4S/j3A1WMvaE=;
        b=q0u/L5c0l1YAgQn410oPBSepSxTA6PiegtWUsMHDwT4vYp64XVJcCVxJ07LRKYz4XW
         umNMNXvFCFEGsYfYCeRiKZPwGgw8tv772twmaBZvhp7smSAzg2oZqUtbrCsLkgSO9DNZ
         kWltHFbjC/EMx9F0DMxHIfS5+5QiVsOizf1lfbgrOWOCxXvibHtcsXp31KPDXnGijoU9
         s+z0XpNs3GBSorzROcOVTc0b7zwlH/233WV0L9+hVTnncR+wH4wHezND+YfVmFsar4/3
         wWHB9+DUQthTYN+Au+9+bydQMqXlhw/ZPmSaVIbYDEoR1yBtTYVc2FlDYnSORsEzA/zG
         nz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=83ANzPhUBDAvBVhFrZlJ/Dy3P0GTE4v4S/j3A1WMvaE=;
        b=bKGYcKKoXoWp2HsFjUcEFEc4AU/C893WK7QEYfzoqwQnK88XuHZfgKpjqe95tS+WLp
         Q+m8yzyGYvOCXCWN3dTBnSd0aihbZRfQ9UeFycfpRTppl+2m78ZWGl5zuvKM5SYSkWyu
         H5ggR5WljSYP+wCFcY1+mvEXUUiOSvCJ+k8ZHfolXTJL35iVRdshTpb+5oU+si2Ge3BO
         pll+YTRhd7mWSWsp1syAKM0Y/Xmn0GVKsTKxOOF8ULjqeCzMN5LLbaiEJVc6Gg30Njl/
         p0/0ZS/Ad4cFcelLMBbebAK4t50Up/8LeC3l8teDCmVY4E+mnfK8yR+rqCDVszX6ew6O
         uxGQ==
X-Gm-Message-State: ACrzQf3BFYO2A+5F436NnvX0MIl2xLKywXECq2xflQfQs98g536vE4eN
        sSJtjzjSBMFc/xbx0eUooUs=
X-Google-Smtp-Source: AMsMyM5B/FsKRlMcjZuQlqNk1dOP5mS51TCAI4tCXrbakuCsjkHCUFWYXjL5Gfh4MC8OWax5E2FLag==
X-Received: by 2002:a05:6402:1053:b0:455:27b7:f1 with SMTP id e19-20020a056402105300b0045527b700f1mr31682046edu.370.1664378331003;
        Wed, 28 Sep 2022 08:18:51 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id la22-20020a170907781600b00741a0c3f4cdsm2550482ejc.189.2022.09.28.08.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 08:18:50 -0700 (PDT)
Message-ID: <2ae321ff-ffe5-6f45-46b6-05259087bb81@gmail.com>
Date:   Wed, 28 Sep 2022 17:18:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] dt-bindings: pwm: rockchip: Add description for
 rk3588
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-pwm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20220901135523.52151-1-sebastian.reichel@collabora.com>
 <1662059695.095333.2226883.nullmailer@robh.at.kernel.org>
 <20220913091202.2oawzrq2u5iiz6hq@pengutronix.de>
 <20220913141601.fi6pl2xdo4xmtw6t@mercury.elektranox.org>
 <YzQ0jTmJCBwV+x2y@orome>
 <20220928130634.x5cfkwegwgqer2xx@mercury.elektranox.org>
 <YzRSpGwUQIFT2A3g@orome>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <YzRSpGwUQIFT2A3g@orome>
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



On 9/28/22 15:56, Thierry Reding wrote:
> On Wed, Sep 28, 2022 at 03:06:34PM +0200, Sebastian Reichel wrote:
>> Hi,
>>
>> On Wed, Sep 28, 2022 at 01:48:29PM +0200, Thierry Reding wrote:
>>> On Tue, Sep 13, 2022 at 04:16:01PM +0200, Sebastian Reichel wrote:
>>>> Hi,
>>>>
>>>> On Tue, Sep 13, 2022 at 11:12:02AM +0200, Uwe Kleine-König wrote:
>>>>> Hello Rob,
>>>>>
>>>>> On Thu, Sep 01, 2022 at 02:14:55PM -0500, Rob Herring wrote:
>>>>>> On Thu, 01 Sep 2022 15:55:23 +0200, Sebastian Reichel wrote:
>>>>>>> Add "rockchip,rk3588-pwm" compatible string for PWM nodes found
>>>>>>> on a rk3588 platform.
>>>>>>>
>>>>>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>>>>>> ---
>>>>>>> No driver changes required.
>>>>>>> ---
>>>>>>>  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
>>>>>>>  1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>
>>>>>> Running 'make dtbs_check' with the schema in this patch gives the
>>>>>> following warnings. Consider if they are expected or the schema is
>>>>>> incorrect. These may not be new warnings.
>>>>>>
>>>>>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>>>>>> This will change in the future.
>>>>>
>>>>> Is this a list of *new* warnings, or is the report (somewhat) orthogonal
>>>>> to the actual change and you just used the opportunity that someone
>>>>> touched the pwm-rockchip binding to point out that there is some cleanup
>>>>> to do?
>>>>>
>>>>>> Full log is available here: https://patchwork.ozlabs.org/patch/
>>>>>
>>>>> Hm, that gives me a 404.
>>>>
>>>> This is an existing problem with the rv1108 binding.
>>>> The rk3588 does not have pwm interrupts.
>>>

I can provide DT and YAML changes, but I pass for changes to the currently to me unknown PWM framework and missing hardware.

Johan

>>
>> I assume this will be taken care of with the rk3128 patchset, since
>> that is affected anyways:
>>
>> https://lore.kernel.org/linux-pwm/f5dd0ee4-d97e-d878-ffde-c06e9b233e38@gmail.com/
> 
> That patch is already acked and I've pulled it in, so better make it a
> separate patch.
> 
> The point I was trying to make is that somebody needs to fix this,
> otherwise the automated checks are not going to be useful. So saying
> things like "this is an existing problem and the new compatible is not
> affected" is not helpful.
> 
> Thierry
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
