Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9467D5925
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Oct 2023 18:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjJXQuL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Oct 2023 12:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344009AbjJXQuI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Oct 2023 12:50:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1A8BD
        for <linux-pwm@vger.kernel.org>; Tue, 24 Oct 2023 09:50:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991c786369cso699108666b.1
        for <linux-pwm@vger.kernel.org>; Tue, 24 Oct 2023 09:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698166203; x=1698771003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbdvzRVbRMri902qjvcTqCbkDzNEOYSX2SohiaeuFAk=;
        b=lidkANAOZ7nLsOqYkdsi51vqxrnUn3fwpG+o8+fLepvktpqk//44p55M5E1GU0siYD
         RpGqyMXAgb9NYn1sdL2V1+yDYDv3j8o8DqZkT1XXhao3JeHBhpHZtpU3Rn6Kc+4EWu2s
         b12aCdtHPoRkYQuqrklSOVy2OMG1JtT0dEUlEqkLn5bAZ8Szl2F0ekpMc0bcihOITCk2
         5t1R6/anxPRu9kQsfNGMuUhTTFpeitGJdpojFmlFpzjA29QdcYBa9fSzLsJLqTFZOIC7
         lBpWJXsadOS8ZaI/J/J7au4qGQkSekN2J/X8Oi1gVo9MzZ7Z9qHJC7DGalOVvRMRrjWE
         2rbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698166203; x=1698771003;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbdvzRVbRMri902qjvcTqCbkDzNEOYSX2SohiaeuFAk=;
        b=pubwHZkfP+I/AnH/NP0BZTZerpTd2HcrPVCcV9rwwe766QkbJpbXD8zSr7kiSzrKVY
         twm+ltKRkhtTOb6ZBqTtobqmX+6Fenpy2Ts3yMECgm7qZ5dX673Ovv0ja1/yWnWhckHk
         Svoi5/xpknCvyw7ECmgF8zr8V1UQ56ozS5i/NhRaksKK1gpbx4K33omjzuz0hCpqiANg
         LM64Mbs9LRPj6BbqdaXuG7wIWqnJN0Vm7DA+zpTBNaFuDjtbwMAjJd63b2GxgHhK+6yr
         o6hotWL/DEuEaE1fKX40J0XPWcEEzwUe5Er8QYDpQuzw8g9Eo9bYCsYN+UNNOw79//bk
         orSA==
X-Gm-Message-State: AOJu0YwdeLO8PNzDrksAKrTNyrVvGDyG1aIe5NJklLThMwCC/KJNKh3v
        b4/Sll4AB6Qs7Mn3E2LhCr1tKQ==
X-Google-Smtp-Source: AGHT+IEG/aF91f8u8H58trUhMV4Z9Prb5azdf8wC3d5EuxnI5gS8BnGTQzvQE63In7TLnDrPGesFPA==
X-Received: by 2002:a17:907:2ce2:b0:9bd:e036:387d with SMTP id hz2-20020a1709072ce200b009bde036387dmr9826780ejc.21.1698166202965;
        Tue, 24 Oct 2023 09:50:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id a19-20020a1709065f9300b009b94c545678sm8512895eju.153.2023.10.24.09.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 09:50:02 -0700 (PDT)
Message-ID: <ce2ce25f-7de5-4682-bdff-09ded85d7aeb@linaro.org>
Date:   Tue, 24 Oct 2023 18:50:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: samsung: Document new member .channel in struct
 samsung_pwm_chip
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>
References: <20231012210228.1009473-2-u.kleine-koenig@pengutronix.de>
 <169720375693.285367.8034783567173304872.b4-ty@gmail.com>
 <20231013172750.nxcw2ftihpemnymx@pengutronix.de>
 <20231024145524.7qkzrrdm6zg5hfji@pengutronix.de>
 <fa624966-176a-47d1-937d-8384fda06513@linaro.org>
 <20231024164627.ejcqrtbhvohduvpg@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231024164627.ejcqrtbhvohduvpg@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 24/10/2023 18:46, Uwe Kleine-König wrote:
> On Tue, Oct 24, 2023 at 04:58:22PM +0200, Krzysztof Kozlowski wrote:
>> On 24/10/2023 16:55, Uwe Kleine-König wrote:
>>> Hello,
>>>
>>> On Fri, Oct 13, 2023 at 07:27:50PM +0200, Uwe Kleine-König wrote:
>>>> On Fri, Oct 13, 2023 at 03:29:35PM +0200, Thierry Reding wrote:
>>>>> On Thu, 12 Oct 2023 23:02:29 +0200, Uwe Kleine-König wrote:
>>>>>> Fixes: 4c9548d24c0d ("pwm: samsung: Put per-channel data into driver data")
>>>>>
>>>>> Applied, thanks!
>>>>>
>>>>> [1/1] pwm: samsung: Document new member .channel in struct samsung_pwm_chip
>>>>>       commit: 4bb36d126cb3147d6bbfd00242a5b846dacad595
>>>>
>>>> You might want to change 4c9548d24c0d to e3fe982b2e4e now that you
>>>> rewrote your for-next branch.
>>>
>>> This is still open. I wonder there is no automated check that warns if
>>> there is a Fixes: line in next that doesn't refer to an ancestor.
>>
>> I am using Greg's/Stephen's scripts in commit hooks:
>> https://github.com/krzk/tools/blob/master/linux/git-hooks-post-commit
>> https://github.com/krzk/tools/blob/master/linux/verify_fixes.sh
> 
> Skimming throud the verify_fixes script I'd say the following addition
> to verify_fixes should do:
> 
> diff --git a/linux/verify_fixes.sh b/linux/verify_fixes.sh
> index f22384bb6bb8..12e73da82dd4 100755
> --- a/linux/verify_fixes.sh
> +++ b/linux/verify_fixes.sh
> @@ -100,6 +100,13 @@ verify_fixes()
>  				continue
>  			fi
>  
> +			if ! git merge-base --is-ancestor "$sha" "$c"; then
> +				printf '%s%s\t\t- %s\n' "$commit_msg" "$fixes_msg" 'Target SHA should be an ancestor of your tree'
> +				commit_msg=''
> +				error=1
> +				continue
> +			fi
> +
>  			if [ "${#sha}" -lt 12 ]; then
>  				msg="${msg:+${msg}${nl}}${tab}${tab}- SHA1 should be at least 12 digits long${nl}${tab}${tab}  Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11${nl}${tab}${tab}  or later) just making sure it is not set (or set to \"auto\")."
>  			fi

Oh, thanks! It makes sense.

> 
> It has quite a few hits in next ...
> 
>> Happy to receive more ideas during:
>> https://lpc.events/event/17/contributions/1498/
> 
> I hope you pick up this idea even without me repeating this suggestion
> there :-)
> 
Best regards,
Krzysztof

