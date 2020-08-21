Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EB524D8E7
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Aug 2020 17:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgHUPjq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Aug 2020 11:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgHUPjo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Aug 2020 11:39:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C56FC061573;
        Fri, 21 Aug 2020 08:39:44 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b11so1034449pld.7;
        Fri, 21 Aug 2020 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DG7naCvPgXGiCExgkvnWZgl1bCrL3Q2lEpDgpQnU+oc=;
        b=vfWoBBcABnl1L+FQhlYO0Kcp/ayXOi3lNY5u+Pg9rExEtAo5n5L1bYY1aLa7UaJslG
         RBwzAE4HCKMefIUI5hsDH7hmPnxTnoiFwe2QqRADiTypj6ghx9jtZjQEcVezj7DrKrTx
         97j2rj+ZC6QCCDwUO4H3J8BDOW0BUl27gEFEuOG3bT98SZiArfePGwoRCmlZju/xM/Mm
         nAvBUipvwscITtXhbLs1tDnhJ37s9t/wUKTy/N/aM9gIWTp1/cfnIp49juLMntrhywPs
         NrGblDB+HegbgCr3FpYV1KNWPMazGRVfVyI25x44LBKjajQDOKyed3H+13AoRm8qRRxG
         At6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DG7naCvPgXGiCExgkvnWZgl1bCrL3Q2lEpDgpQnU+oc=;
        b=uAjlRFtitgAga322HS3rRQttKBBTCc3zN3i5BxN3i1TzQ+aQZ0nOAuT9VNF41/ESxj
         5JMSRfYEhZJGa+qkYWt8gLlhMTw+N7m5zVcc0mTYd+9UWk+sBZP4lit6tnpVo6CxAUpv
         iZfZ3EmydeWTal359dpjkSLwwgsp7ZqIjvW0eGFBxXUwYhDxBZx/an5Ze0nd/uhTV6tN
         05IM2Gs+f/GhQgWU9xrm5gtX67cv62WSqUIDnP4NjKhOqd5mh9M5UP9O3sMMq0q17cQO
         ltO+0UffMpPnep1HAmsq3jjIiYEgg/wVIeRLJV/SWdx2nteKtsJArfDxuIa+HeaGHo6B
         yh/A==
X-Gm-Message-State: AOAM532QxFP851c/BBFwgGXipC2qT741f6KoySp/RwWtsz893wKzP2KY
        uVLskWyxWdkIBVjoWJYmeOZErXG0ROc=
X-Google-Smtp-Source: ABdhPJzv73uXqomQdzD1Z1czOKY8qchPEpQg7dDizoFqem1pofcozWvAkUm3cSke91BfhFuTAWBaEw==
X-Received: by 2002:a17:90b:11c4:: with SMTP id gv4mr2899721pjb.198.1598024383854;
        Fri, 21 Aug 2020 08:39:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e125sm2992507pfh.69.2020.08.21.08.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 08:39:42 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] platform/chrome: cros_ec_proto: Convert EC error
 codes to Linux error codes
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200806153308.204605-1-linux@roeck-us.net>
 <0dfbce79-0413-de27-a2cb-a687ab2fd9d8@collabora.com>
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
Message-ID: <ce0bfe13-38b8-1891-802c-84b4148333d1@roeck-us.net>
Date:   Fri, 21 Aug 2020 08:39:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0dfbce79-0413-de27-a2cb-a687ab2fd9d8@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 8/21/20 1:21 AM, Enric Balletbo i Serra wrote:
> Hi Guenter et all,
> 
> On 6/8/20 17:33, Guenter Roeck wrote:
>> The EC reports a variety of error codes. Most of those, with the exception
>> of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
>> error code gets lost. In cros_ec_cmd_xfer_status(), convert all EC errors
>> to Linux error codes to report a more meaningful error to the caller to aid
>> debugging.
>>
>> To prepare for this change, handle error codes other than -EPROTO for all
>> callers of cros_ec_cmd_xfer_status(). Specifically, no longer assume that
>> -EPROTO reflects an error from the EC and all other error codes reflect a
>> transfer error.
>>
>> v2: Add patches 1/4 to 3/4 to handle callers of cros_ec_cmd_xfer_status()
>> v3: Add patches 4/6 and 5/6 to handle additional callers of
>> 	cros_ec_cmd_xfer_status()
>>     Use -ENOPROTOOPT for EC_RES_INVALID_VERSION
>>     Implement function to convert error codes
>> v4: Add coments describing the functionality of cros_ec_num_pwms().
>>     Add patch 7/7 to clean up cros_ec_num_pwms() after the new error code
>>     support has been implemented.
>>     Rebased series to v5.8.
>>
>> ----------------------------------------------------------------
>> Guenter Roeck (7):
>>       iio: cros_ec: Accept -EOPNOTSUPP as 'not supported' error code
>>       cros_ec_lightbar: Accept more error codes from cros_ec_cmd_xfer_status
>>       platform/chrome: cros_ec_sysfs: Report range of error codes from EC
>>       pwm: cros-ec: Accept more error codes from cros_ec_cmd_xfer_status
>>       platform/input: cros_ec: Replace -ENOTSUPP with -ENOPROTOOPT
>>       platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
>>       pwm: cros-ec: Simplify EC error handling
>>
>>  .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |  2 +-
>>  drivers/input/keyboard/cros_ec_keyb.c              |  2 +-
>>  drivers/platform/chrome/cros_ec_lightbar.c         | 10 ++---
>>  drivers/platform/chrome/cros_ec_proto.c            | 52 +++++++++++++++++-----
>>  drivers/platform/chrome/cros_ec_sysfs.c            | 24 ++++------
>>  drivers/pwm/pwm-cros-ec.c                          | 37 +++++++--------
>>  6 files changed, 74 insertions(+), 53 deletions(-)
>>
> 
> The patches LGTM, and if the other maintainers are fine, I'd like to queue all
> these through the chrome-platform tree.
> 
> I noticed, thought, that KernelCI reported a regression on Kevin that I'll try
> to debug at the beginning of next week.
> 
> [    3.821203] cros-ec-spi spi2.0: Wrong size 1/3: 0 != 4
> [    3.827320] cros-ec-keyb ff200000.spi:ec@0:keyboard-controller: cannot
> register non-matrix inputs: -71
> [    3.838506] cros-ec-keyb: probe of ff200000.spi:ec@0:keyboard-controller
> failed with error -71
> [    3.853492] cros-ec-spi spi2.0: Chrome EC device registered
> 

Easy to debug. cros_ec_cmd_xfer_status() now returns 0 for success and < 0 for errors.
It needs to return the receive length if there is no error. I'll send v5 with a fix,
and sorry for the trouble.

Thanks,
Guenter
