Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5387DAC09
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Oct 2023 12:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjJ2LHL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Oct 2023 07:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2LHK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Oct 2023 07:07:10 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ACAC1
        for <linux-pwm@vger.kernel.org>; Sun, 29 Oct 2023 04:07:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c523ac38fbso52275181fa.0
        for <linux-pwm@vger.kernel.org>; Sun, 29 Oct 2023 04:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698577625; x=1699182425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTw9e5U1dxmS60TaF58rmYOq+L3kDSS3ju4ja9AbvBM=;
        b=HIIx+KaKa6tZgdeoSCLohRlq2QHR6vBgesXnTIBxTeCJCdIxQKX2HrLPgAicwVm3yY
         j8vMjMiYkJ+YDC71B9xorFOh4g167QKiYlrkC2TuV0t4p/2/dt18qAxL5eL/zAKBNrrT
         SlgcmGQcH7VPKMdtaIvyonSSubNdLFqhGvG8VhrflkN29OeuZH2rNqEe7MQEtsNkvqNU
         J6KUp5PZS7Am936CtMEossGl9mjZR+IX/phQ5vOnag7Nv8QIILYDh82B4nEfCXJI7Aia
         DzReTZLQ9pAD00X1D/6ZEyAGnmDHb1yk1bXSaqgwTfGsPpCeNUoy1KXgAaVuR1qQxVvD
         fsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698577625; x=1699182425;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTw9e5U1dxmS60TaF58rmYOq+L3kDSS3ju4ja9AbvBM=;
        b=ZxxU7J3lIJanzXrAEuxgLEFDzTrNpYqMrEuL9juZE5a+s09kHmW8mMKwO78vTZ9x4e
         wOU173M/y3DfudKSMiT3l23mBut5Tu4F97It83qkfI7VVIQJ3OkDFPI361aTg+m09Nwy
         kimRt9MTnrmyV/VhArVpYfMcHllS655ODKj3Pr1wEmJhbpv2O7h6ZAUH7eEVMfGTmu2G
         NzOEYxFMVH/z8Gnvc8IyLEnpOIq91mg01Vkh2PfHWc2yS+/xRw2JL35/z4ZqMS6722oA
         Nc0GFI0NO17487vjDZF8oostu6gpWZtPU7eEY9j4m/Zn+CxshiTiVGnoJaoMMnWXvcZH
         Vwmg==
X-Gm-Message-State: AOJu0YzpydS+FL+vbodp1sfTNp1lOviqnSTA8wSjHev9NwUqJP7AOKqZ
        JTkQLaCTxWPcHCEASwFp0mXOTA==
X-Google-Smtp-Source: AGHT+IEbH8QoKWO9UiEQxYacANzdgqxHnSFmPLKa7epb4hiIE+R+v95RruxP8sPzwDO30BRcFNgqxg==
X-Received: by 2002:a2e:7e0e:0:b0:2c0:34ed:b5ea with SMTP id z14-20020a2e7e0e000000b002c034edb5eamr5104047ljc.45.1698577624703;
        Sun, 29 Oct 2023 04:07:04 -0700 (PDT)
Received: from [192.168.0.22] ([78.10.206.168])
        by smtp.gmail.com with ESMTPSA id f24-20020a2e9198000000b002b6d68b520esm838938ljg.65.2023.10.29.04.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 04:07:04 -0700 (PDT)
Message-ID: <c3495c6d-72e3-493b-99ed-47e8cd3f1108@linaro.org>
Date:   Sun, 29 Oct 2023 12:07:02 +0100
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
        kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20231012210228.1009473-2-u.kleine-koenig@pengutronix.de>
 <169720375693.285367.8034783567173304872.b4-ty@gmail.com>
 <20231013172750.nxcw2ftihpemnymx@pengutronix.de>
 <20231024145524.7qkzrrdm6zg5hfji@pengutronix.de>
 <fa624966-176a-47d1-937d-8384fda06513@linaro.org>
 <20231024164627.ejcqrtbhvohduvpg@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231024164627.ejcqrtbhvohduvpg@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
> 

Thanks Uwe for the snippet. I went further and it allowed to simplify
checking for commit in Linus' tree.

Cc, Greg, Stephen,
Maybe you will find it useful to update your scripts as well (I forked
from yours):
https://github.com/krzk/tools/commit/39d2c71a72f5d4f30d0752e45b9bcc09b75b5026

https://github.com/krzk/tools/commit/0061331501fac2f4b24709adb0ec5cf267bcb661#diff-0100377e067a4cd4cb89c0f0ae8732d3e814ed25e816a392bf2e0855a392adbcL11

Best regards,
Krzysztof

