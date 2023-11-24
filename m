Return-Path: <linux-pwm+bounces-194-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 923A47F78ED
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 17:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D36BB20D75
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1085341A6;
	Fri, 24 Nov 2023 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQdDPWki"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A441719BA
	for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2023 08:29:05 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54b0073d50fso886437a12.2
        for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2023 08:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700843344; x=1701448144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m59lGOjhmNFmUbmnXXYOyMU0r5AKqEjyJwepUZSyZQs=;
        b=LQdDPWkisiaDFG9+ozXNaMU5eaJY5JJMKszxbOueRWIgfMDUliQMh42l6WiddSw98/
         gLBTjL+YHpU2jz84qMak0+ksBg9UcR5S4GTPcxco9BJt7Xz3ze2VwMQ3sxOKbe7r5yPV
         vQEA3VNcP1rwVgy3pDL8Fy0HR7r+tq7yaGoLxfk8wudR1v+bF7Nl0Gej23LaRGuaGV11
         ZwQLyQfgwHyefU+ZR9egKhSuNI/BiI1/vH02qwzJEmRYKvqavyc+Ika2mKGZtjYE0FJt
         FvkI5ul0LB63wgsEab8a59SXCO6IS8jiB5BrfLIHmjm7v5nqm4/wDlKW88gm/W95ewVw
         D2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700843344; x=1701448144;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m59lGOjhmNFmUbmnXXYOyMU0r5AKqEjyJwepUZSyZQs=;
        b=H28QgwPCCkEMuvHEpbPuwBqoyoj/+PZtCdBvpwBZhZarwh2S6WDxJLrhgVIZUV2bQM
         8K25U8i89S0Db3YxNX0txIsT5GFByFnhEKto2y3wjYSlumrzRiE69SILSn07DbNLfAhw
         9ATEiPkRADCrW0WkNSrgtLzIps27fLuWA69uMTwgkKAtObIpzraOD2ndJ+V2BNkSyhq+
         B9TATNz/38H0vd42iQfX6TSO6Nr8LGPV60QQjnZQnNU/hUXyNveB4dKnLtsFlTEchMBr
         PG2yXD1GNG88w99sTV5Z2fGOOGx15hx/g2pgmZAFi5iCehbW2Rgz9IAAWQ2UVeOs4qYj
         PHlg==
X-Gm-Message-State: AOJu0YxetE4YYbm4C+v+ODmArnNvVpLw/ypBec1xFD/Fbw2OUZtNY/0r
	dt4tZoym5svnHqMRcv/CfckaXg==
X-Google-Smtp-Source: AGHT+IHmw2v9akiv8lLwobosBbnycWxS+mTHFNHjdgc73oGvRIXlhS7yygAOU243HPtOYOWLXofSgQ==
X-Received: by 2002:a50:f699:0:b0:540:12fc:ed1d with SMTP id d25-20020a50f699000000b0054012fced1dmr2691693edn.12.1700843344125;
        Fri, 24 Nov 2023 08:29:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id n21-20020aa7c455000000b00548c945bac0sm1943343edr.45.2023.11.24.08.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 08:29:03 -0800 (PST)
Message-ID: <850b0eec-c991-40b6-92e1-2bc46eecdae5@linaro.org>
Date: Fri, 24 Nov 2023 17:29:02 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LINUX PATCH v2 1/3] clocksource: timer-cadence-ttc: Do not probe
 TTC device configured as PWM
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Sayyed, Mubin" <mubin.sayyed@amd.com>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "git (AMD-Xilinx)" <git@amd.com>, "mubin10@gmail.com" <mubin10@gmail.com>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "Simek, Michal" <michal.simek@amd.com>
References: <20231114124748.581850-1-mubin.sayyed@amd.com>
 <20231114124748.581850-2-mubin.sayyed@amd.com>
 <d37db10b-f9fa-49b0-8b1e-36e20acbcfd6@linaro.org>
 <DM4PR12MB593888B73B65D25E42490EF29DB1A@DM4PR12MB5938.namprd12.prod.outlook.com>
 <e0f28ec5-b980-490b-a857-5218fe521381@linaro.org>
 <DM4PR12MB5938CB10059DF7E39A2A0E239DB8A@DM4PR12MB5938.namprd12.prod.outlook.com>
 <a701ba6e-ae4e-4c4d-9d93-c54e56c3348e@linaro.org>
 <DM4PR12MB5938256CC0E50256004ED6B19DB8A@DM4PR12MB5938.namprd12.prod.outlook.com>
 <9fb984b3-331b-45ce-8f82-03bc476acd3c@linaro.org>
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
In-Reply-To: <9fb984b3-331b-45ce-8f82-03bc476acd3c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/11/2023 17:24, Krzysztof Kozlowski wrote:
>>>>> So again, one driver binding.
>>>> [Mubin]: I will explore whether mfd framework can be used to handle this.
>>>
>>> You do not need MFD for this, because you do not have a really MFD. This is just
>>> one device, so I expect here one driver. Why do you need multiple drivers (which
>>> also would solve that problem but why?)?
>> Cadence TTC IP can be used as timer(clocksource/clockevent) and PWM device.
>> We have drivers/clocksource/timer-cadence-ttc.c for clocksource/clockevent functionality. 
>> New driver for PWM functionality will be added to drivers/pwm/pwm-cadence.c (3/3 of this
>> Series).  In given SoC,  multiple instances of TTC IP are possible(ZynqMP  Ultrscale SoC has 4
>> Instances), few of them could be configured as clocksource/clockevent devices and others
>> as PWM ones. So,  cloksource as well as PWM drivers for cadence TTC IP would be enabled in 
>> the kernel. 
>>
>> Now in this scenario, each TTC device would be matching with 2 drivers, clocksource and PWM, since
>> compatible string is same.  If I don’t add #pwm-cells checking in clocksource driver and return 
>> -ENODEV based on that, each device would always bind with clocksource driver. PWM driver 
>> would never probe since clocksource driver probes ahead of PWM one in probing order.
> 
> None of these above explain why you need two drivers.

And please do not answer to this with again: "I have two drivers...".

> 
>>
>> I am exploring mfd to deal with said scenario. Do you see any better way to handle this? 
> 
> You basically repeated previous sentence about MFD without answering.
> Yeah, better way could be to have one driver. Why you cannot have it
> that way?
> 
> 
> Best regards,
> Krzysztof
> 

Best regards,
Krzysztof


