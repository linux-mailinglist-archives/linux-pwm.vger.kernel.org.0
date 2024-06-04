Return-Path: <linux-pwm+bounces-2334-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7A58FAC50
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 09:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1415F282F0E
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 07:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65A1411D9;
	Tue,  4 Jun 2024 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLVj3lrR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9911411CA
	for <linux-pwm@vger.kernel.org>; Tue,  4 Jun 2024 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717486951; cv=none; b=MnG8Zi+UoQBPpEF4hizfRphAqWwaT6zVGgNjuQmYkpy10ctOFA5vG0c6NQDK1OC8MrvTt1CtvjTZsyDzd9IpCID39tBg7654Ft9rcBGdwOUvTCSrOmR9r7Xg981a1nwI7SOM4i8li5sFi+Kx8cwMuniucE9e3pocheP4SOxOOxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717486951; c=relaxed/simple;
	bh=X2EQxagvwCm6SwpceTXqW87qcH6ceyWl8AK/HSrsrYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ok7A+QrZTMfI+XrdWpTlqpMjQShlv311C9egyG0043CvghHpZDLT+NnEg77zPMuBevrHOg5Z7m6dlXvdeRdV2fm8WNnT/1QcQZxxxVR6/7HPi40428rQr3D1XtY6SkJ8J1gj7e79q9pEgqTkrZBcvHXjp2lO1RavBv6DmNwvHWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FLVj3lrR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so7621645e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 04 Jun 2024 00:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717486948; x=1718091748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AsSQ9LmJ4nSDj9xxyUtFXUG1p+uGgVxeoPrlOq2QQ1o=;
        b=FLVj3lrRAqOSe4ls1KtAJeX9Llv3gTIKyajK1qwHhbixu9y3G+xfwcogXdM474n99n
         uP9DIPbk5LdDCiPzdIJAJHDx7ohkhcyJRuYPT6tLYWz2gFzRApn0DslrsAYYUamEKVFe
         sUmHMgh7X6BZHxcvY0Bz7nrw6GXVPNZL/0yRC0sGhUIo4UYYBe55ucKH2zu3jHHAsqIl
         bn/rEhRjUhHggD27tbe98N7J7aPfXG+f4rJGuDLBZiSaGd/0djXJpZ8umKv0htcVDzno
         Lu9xE01zufTEFXTI/SZnA7D3WmemhdA1NqjqEEDJLSjy3HH7+xmg5lbeIgcoci1dc2Uw
         y8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717486948; x=1718091748;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsSQ9LmJ4nSDj9xxyUtFXUG1p+uGgVxeoPrlOq2QQ1o=;
        b=PyocQv8b4nQbrQvyGFfouAq4neczzmRv1TcSxZNv4sgHqMPVU5SmqKxbUCMe8fKt61
         nVefEbafWp61Upe+ZB0LQcx+wye+OWqzgkibfXtkSNMzNkin+uxgOUHzZyc2AjhsYJyN
         /omQLxg9me6CCKXA9dsB/Y1D44Hb2j2A9fYuG3oqgAT70E7Z95T0caCaxbKjW0K23s6A
         H/6V8/LFRBky164wuYVYfdtvFIy1iRcXu20jsH2VGblFBMErCpbx78B6Y9iVd+x/Yrsg
         dVuzu5qRI6ckDDg5mXQsL1E0NIegg4pC6JSUcM1RrSeJ5huGqmSuGqDvgAgi4sCTCaTr
         N0fA==
X-Forwarded-Encrypted: i=1; AJvYcCWuAEdePCptdGR1LJIOTm2IeaWcEszV1rfWrRQMd1nPsKpAmSBDx+Ye0PkOKulfFq+RON1IUfn37Gx+57lMgGF+R92MdV6nOXo4
X-Gm-Message-State: AOJu0YxjZ5zrtf1/MkYvhRHkbNK5T3eHsQtJ5Wc9m4YqH/VhwZIaN1xv
	zsBBQEm+ma5H5DStEYwWlB7xBgBJ1H4EWs1T914EAGqs/UqNlnJUVnwGrkGgTbs=
X-Google-Smtp-Source: AGHT+IE96YZvAG+ipOTQW8PG8TZg2aJjiYp9/l/UaszCtE4I/kSg/DFwZ0+ZVT8/Thk+I+cg3lhu4A==
X-Received: by 2002:a05:600c:4f46:b0:41a:e995:b915 with SMTP id 5b1f17b1804b1-4212e044d21mr89772615e9.1.1717486948334;
        Tue, 04 Jun 2024 00:42:28 -0700 (PDT)
Received: from [192.168.2.24] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04e845bsm10668275f8f.65.2024.06.04.00.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 00:42:27 -0700 (PDT)
Message-ID: <7679dd6f-c952-44de-8863-2f0fd12f372a@linaro.org>
Date: Tue, 4 Jun 2024 09:42:25 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: pwm: Add pwm-gpio
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
 Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
 Chris Morgan <macromorgan@hotmail.com>, Stefan Wahren <wahrenst@gmx.net>,
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, Nicola Di Lieto <nicola.dilieto@gmail.com>,
 Dhruva Gole <d-gole@ti.com>
References: <20240602-pwm-gpio-v6-0-e8f6ec9cc783@linaro.org>
 <20240602-pwm-gpio-v6-1-e8f6ec9cc783@linaro.org>
 <20240604025137.GA107618@rigel>
 <1edbcf6d-92b7-4971-b8b2-a88cc96995e9@linaro.org>
 <20240604073413.GA137333@rigel>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
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
In-Reply-To: <20240604073413.GA137333@rigel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/06/2024 09:34, Kent Gibson wrote:
> On Tue, Jun 04, 2024 at 08:21:32AM +0200, Krzysztof Kozlowski wrote:
>> On 04/06/2024 04:51, Kent Gibson wrote:
>>> On Sun, Jun 02, 2024 at 10:33:08PM +0200, Linus Walleij wrote:
>>>> From: Nicola Di Lieto <nicola.dilieto@gmail.com>
>>>>
>>>> Add bindings for PWM modulated by GPIO.
>>>>
>>>
>>> Shouldn't the bindings be added after the driver?
>>
>> No. See submitting patches document.
>>
> 
> Hmmm, ok, so "5. The Documentation/ portion of the patch should come in
> the series before the code implementing the binding."[1]?
> 
> It just seems odd that you document something that doesn't exist yet.

It's logical. First you define the ABI for every user, then you
implement the ABI. Do you first implement software and then design? Or
first implement then write interface (API) for it?

Best regards,
Krzysztof


