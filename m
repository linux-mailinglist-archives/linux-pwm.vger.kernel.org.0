Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4866D180127
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Mar 2020 16:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgCJPGF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Mar 2020 11:06:05 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52379 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgCJPGE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Mar 2020 11:06:04 -0400
Received: by mail-pj1-f67.google.com with SMTP id f15so528431pjq.2;
        Tue, 10 Mar 2020 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qQRzy6D3zZlNYzsyvEoz1P4kGm+5/Pm4DqOhCX31Gs8=;
        b=cuR7C4FsrepPDRp8iI1vq9oXWn5Vgr8KEu+5LyKogGz3qwNVJNpFeh4ZjnwBzoGpJA
         QJf51WS/RSEBNsoFxw9SgJh2OwCvVv1MlC4KeYxqsHzWuL4XJ8E9GnyQ/TyE20Kbnxeu
         q1W5XaCcbCEdW4OOokq+00Wcm/udPygyR+7BaXGOUabnACGRMGAn5q1MiTZ5DFKH/jIm
         57kIqUhLxL/oiRxurqyVZyliCcWXQ2RLDH0vWWlVp1I3nQ9uCutKu9edJhYl8X2QSbVq
         0r06OfjUBM5mxMMmEyrUKElhgKbnFkY8/+g7tiQtF1Hs7hfKQ5abxN7PxukVy+iTB+vm
         XdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qQRzy6D3zZlNYzsyvEoz1P4kGm+5/Pm4DqOhCX31Gs8=;
        b=NtQGq+u3q1Wyf8JaU0bDWVYyHwjyPq2iTD3yTAZRaonXa2VqD8YYCQERm30VzuI1PK
         JAwG76bAxcyLX1XTMvWVGT8GTjRdb70zY0CycIjBxWo5ntgl+Lpxxb5mVa5MLhmLycpq
         b4us2uYSmJL8g75JlNzYeo8Jgc8ji+7A5FrVyNZhLxJZXuBruRLoDCCUlOM6ilfvh1Tk
         ahmhSwgnn9IjhmbURbCViiG56Jt8R1QQg0jQoStzaCOEmIvpXEYBZCm87GrhBOevzO+M
         4uGgab0txre/9UQaVTzM9J9V0YQ00slvDHDsTnM0mHWMjlshYWQdQw2EDRgI44D/Fc5C
         a7cQ==
X-Gm-Message-State: ANhLgQ3ch3nPx061nuqzcU0M1EYuJXehOnsdC3I0y2p4bj1Ybe+u3MAa
        FkgMoXtVhic66LBaXPgVGd8PkciR
X-Google-Smtp-Source: ADFU+vtOKDMZY/tneNYl+AL/VYFUNO5GDM7yUjqSUI1kuBMlnv0VBXqOav/IKPHAMrK9dfRn5lkAXw==
X-Received: by 2002:a17:902:bd42:: with SMTP id b2mr21498150plx.34.1583852760978;
        Tue, 10 Mar 2020 08:06:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e9sm4225937pfl.179.2020.03.10.08.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 08:06:00 -0700 (PDT)
Subject: Re: [PATCH v7 03/13] hwmon: pwm-fan: Use 64-bit division macros for
 period and duty cycle
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Guru Das Srinagesh <gurus@codeaurora.org>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org
References: <cover.1583782035.git.gurus@codeaurora.org>
 <b503833e0f58bd6dd9fe84d866124e7c457e099e.1583782035.git.gurus@codeaurora.org>
 <20200309214822.GA19773@roeck-us.net>
 <20200310120814.4kjxmii3c7zxw55y@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <bd6c7679-9569-2cf1-1664-61bf368d82dd@roeck-us.net>
Date:   Tue, 10 Mar 2020 08:05:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310120814.4kjxmii3c7zxw55y@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 3/10/20 5:08 AM, Uwe Kleine-König wrote:
> Hello Guenter,
> 
> On Mon, Mar 09, 2020 at 02:48:22PM -0700, Guenter Roeck wrote:
>> On Mon, Mar 09, 2020 at 12:35:06PM -0700, Guru Das Srinagesh wrote:
>>> Because period and duty cycle are defined in the PWM framework structs
>>> as ints with units of nanoseconds, the maximum time duration that can be
>>> set is limited to ~2.147 seconds. Redefining them as u64 values will
>>> enable larger time durations to be set.
>>>
>>> As a first step, prepare drivers to handle the switch to u64 period and
>>> duty_cycle by replacing division operations involving pwm period and duty cycle
>>> with their 64-bit equivalents as appropriate. The actual switch to u64 period
>>> and duty_cycle follows as a separate patch.
>>>
>>> Where the dividend is 64-bit but the divisor is 32-bit, use *_ULL
>>> macros:
>>> - DIV_ROUND_UP_ULL
>>> - DIV_ROUND_CLOSEST_ULL
>>> - div_u64
>>>
>>> Where the divisor is 64-bit (dividend may be 32-bit or 64-bit), use
>>> DIV64_* macros:
>>> - DIV64_U64_ROUND_CLOSEST
>>> - div64_u64
>>
>> There is no explanation why this is necessary. What is the use case ?
>> It is hard to imagine a real-world use case with a duty cycle of more
>> than 2 seconds.
> 
> When my Laptop is in suspend there is an LED that blinks with a period
> of approximately 5 seconds. (To be fair, the brightness is more a sinus
> than a rectangle, but still.)
> 

I don't see support in the LED subsystem to utilize the PWM framework directly
for blinking. Plus, you say yourself that it isn't a _real_ use case, just a
theoretic one.

Either case, the reason / use case for this series should be explained
in the summary patch. That is what it is for. That case is not made.

Guenter
