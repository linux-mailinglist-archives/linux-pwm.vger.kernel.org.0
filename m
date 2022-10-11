Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BFC5FBC3D
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Oct 2022 22:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJKUkD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Oct 2022 16:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJKUkA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Oct 2022 16:40:00 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAF41707C
        for <linux-pwm@vger.kernel.org>; Tue, 11 Oct 2022 13:39:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id z8so4516912qtv.5
        for <linux-pwm@vger.kernel.org>; Tue, 11 Oct 2022 13:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1R1aIVvSllOCnB9/qVFJs2shECEd5rfK4Hda12/PfGg=;
        b=gKIMKrr3nnbYkkLFdLPLv4E7cXTLkkwlxb78Lv4PxFXuzdkV/wFc6eOXLBx2rZc+Nb
         s/gRmC8022RwWixUzZeoLXiXqr7O1C3e0go3KBzQ9WWJ++6e5A1RBXsvlA9RFYC5tmeX
         SNJsvnPpk2doJgkIzMPbyBSSBpxcL9g5JJp+jDSM0/xiYeOGk73LtOEb310f4ZtD0i29
         XT+954VKYOZ9ZBRt3n6TK/rb5T3IsvK4MDupReUc70mKyk/81tIfM52nKILtNAPKCecN
         zP1QsFYTL7Y/V22U+jocK3EmpijhqnTN9/JKwvHJqzndUB7g3Cv5ZqWS5Zz7VwT1eXyQ
         kHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1R1aIVvSllOCnB9/qVFJs2shECEd5rfK4Hda12/PfGg=;
        b=kc0sHLaXaQ6O1m/lQWaUx9LpYbxVjbZPwFBiFOpV0RlJcX6oy7q79fPoWcR2zmyL2b
         pWBCGmmiOJGvYWjTC5NQQo+D27rjsaWqH6Eikw1PG8k9NK7X7tjAXBurCNu+eKGoXSmC
         1mEOHBIUglPEBB8rQ0ScwDGmhtoYQwpogCyTLn8+AAHZpb1E1GXnA0wd8snkfiCH15xh
         L8Hk8Fd8jv0n2+jA4HUXHq3njbeD3zqSrlsex5ckq/sdvVrLMQAm3hL1IG9SiEkP10X2
         Lp2UTrF8ZAjiNCxGk/0BNtYvihet0YMzd8Zo4ZH7vW8zTTqtNy1KVhp4mwgqA4FIbVtP
         UfLA==
X-Gm-Message-State: ACrzQf14OiL6OA/x1NKQwMotjqny2+uhPap+xaBFHQCkS+QiotgM2tnb
        CCyibylDlknZsisQqd8KB9CwRQ==
X-Google-Smtp-Source: AMsMyM5z1vNjVCe3KsKJq9e/HAB5ZPTWpXgGF+bz5lICz1u7BIaMtftDH6g9kvBg43qgvEj3jocbHg==
X-Received: by 2002:a05:622a:1898:b0:39a:1184:43cc with SMTP id v24-20020a05622a189800b0039a118443ccmr10243055qtc.151.1665520797539;
        Tue, 11 Oct 2022 13:39:57 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id bn42-20020a05620a2aea00b006ee8874f5fasm1458954qkb.53.2022.10.11.13.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 13:39:56 -0700 (PDT)
Message-ID: <ddfb11e0-0704-1600-d89c-ec8ca1650c38@linaro.org>
Date:   Tue, 11 Oct 2022 16:37:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Lee Jones <lee@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-5-biju.das.jz@bp.renesas.com>
 <b701187b-d2aa-eecc-0052-d611d1f45807@linaro.org>
 <OS0PR01MB59227CF4B0D4CA846E24298C86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <219922df-5bba-e6ae-fa89-60a9b319424b@linaro.org>
 <OS0PR01MB592269EB3BAE686A2F74B48286239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <f12dfcd3-ef5c-b422-c00c-35cef082a3ff@linaro.org>
 <OS0PR01MB5922E406D2711AA6B8CD632C86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <OS0PR01MB5922E406D2711AA6B8CD632C86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 11/10/2022 16:35, Biju Das wrote:
>>>>
>>>> So no, here and in other files - don't put subsystem specific code
>>>> like PWM or timer into MFD.
>>>
>>> Where should do we put, if there is single driver to be bind against
>>> "renesas,rz-mtu3" and register functionalities for pwm and counter??
>>
>> Again - how binding is related to this problem? If you have separate
>> drivers, e.g. counter, timer and PWM, all go to their respective
>> subsystems. Counter goes to counter, timer to timer, PWM to pwm.
> 
> How do you instantiate these drivers with a single compatible "renesas,rz-mtu3"?
> If it is separate drivers.
> 

With MFD framework and mfd_cell, just like many, many other drivers.

Best regards,
Krzysztof

