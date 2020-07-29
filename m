Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF2E232801
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Jul 2020 01:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgG2XWJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 19:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgG2XWI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Jul 2020 19:22:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C70C061794;
        Wed, 29 Jul 2020 16:22:08 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so12770735plk.1;
        Wed, 29 Jul 2020 16:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dYdPpgoeWUX12WEZRA5uofSu8jyLZ45WRjobjopXACQ=;
        b=GsZ8rjPLeO518JYxeY5JaABnuRqY6ZcUKxPrhfUSOB6L9fK3nMQLLY4U8I6e5/yzPr
         xInOccydDe4wZY+G4gjl32UjueOqfX+rutjgNg3xjX/1AKNzXJD9eTfxJQ6bjHwcXj6g
         UnA2/EtGdlGuO642XZbpDkdIOLwVT9NyQE5ASRG5VOo6TcxN9uHpPP2/cKGJTWnAFkzw
         hyjwmE0gS75ik0+6QqPSa0jtx6d5On6OFeHe1lA8A383tiPm0RhLlERfmtb03+2ytIEE
         RZo/mmhcwPzFlfTuL0rmGHaVirgYuYMr5ORPfAU5gVuFUXu7PAH/3GiDG8kLuspa3013
         UbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dYdPpgoeWUX12WEZRA5uofSu8jyLZ45WRjobjopXACQ=;
        b=iZj8JUwgp60+/L8vtW+fngIZcZlalW3Rtm0h6A47ZHAeEeWoaJZZQTq0HNGcAiGuvX
         c1osukNYbkus33YT5Nald5vnlglINB/BEzCjd7VNo8AOE7700Izj3+MYG+q5yn0i890D
         1whTn8s5h48Ww610SZrIXK1M9J3mKRijZNv3quOQ3TjfSQHV1wW2tL4SfXDg2RLGJoU6
         /0WwammlulR2ZQPUPPc4t7y6C68OAlvZ4J5GCAwH2H7PYL1LHUuUbTZ5IGSgvSpigZdF
         5y9gLTXD9g+hcldXzUzS9t8JA8J7vveI4avlVE9jJsVyseh5arCgxrtnDftuT4/EjijR
         o9/A==
X-Gm-Message-State: AOAM531GKQ/rbywD31hArKvkM5+uCS13qCQoeisWk17cQQ8yFLgg9mFv
        QabcQxJCfpZlp3BafTbMy4U=
X-Google-Smtp-Source: ABdhPJzMOzMbm5s6FvIAb74n6YtTT7uElMIMyHKqG8V3pDsBexBEYsgzc9d3v0fz5ykFb4afhYW7Cw==
X-Received: by 2002:a17:90a:7c04:: with SMTP id v4mr154252pjf.191.1596064928142;
        Wed, 29 Jul 2020 16:22:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o10sm3246501pjo.55.2020.07.29.16.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 16:22:07 -0700 (PDT)
Subject: Re: [PATCH v3 6/6] platform/chrome: cros_ec_proto: Convert EC error
 codes to Linux error codes
To:     Brian Norris <briannorris@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
References: <20200726220101.29059-1-linux@roeck-us.net>
 <20200726220101.29059-7-linux@roeck-us.net>
 <20200729222150.GA970863@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <ae5aeae1-4dfc-0fd7-3392-bf1ca3540866@roeck-us.net>
Date:   Wed, 29 Jul 2020 16:22:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729222150.GA970863@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 7/29/20 3:21 PM, Brian Norris wrote:
> Hi Guenter,
> 
> On Sun, Jul 26, 2020 at 03:01:01PM -0700, Guenter Roeck wrote:
>> v3: Use -ENOPROTOOPT for EC_RES_INVALID_VERSION
>>     Implement function to convert error codes
>> v2: No change
>>
>>  drivers/platform/chrome/cros_ec_proto.c | 52 ++++++++++++++++++++-----
>>  1 file changed, 42 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
>> index e5bbec979a2a..a081b8245682 100644
>> --- a/drivers/platform/chrome/cros_ec_proto.c
>> +++ b/drivers/platform/chrome/cros_ec_proto.c
>> @@ -15,6 +15,43 @@
>>  
>>  #define EC_COMMAND_RETRIES	50
>>  
>> +static const int cros_ec_error_map[] = {
>> +	[EC_RES_INVALID_COMMAND] = -EOPNOTSUPP,
>> +	[EC_RES_ERROR] = -EIO,
>> +	[EC_RES_INVALID_PARAM] = -EINVAL,
>> +	[EC_RES_ACCESS_DENIED] = -EACCES,
>> +	[EC_RES_INVALID_RESPONSE] = -EPROTO,
>> +	[EC_RES_INVALID_VERSION] = -ENOPROTOOPT,
>> +	[EC_RES_INVALID_CHECKSUM] = -EBADMSG,
>> +	[EC_RES_IN_PROGRESS] = -EINPROGRESS,
>> +	[EC_RES_UNAVAILABLE] = -ENODATA,
>> +	[EC_RES_TIMEOUT] = -ETIMEDOUT,
>> +	[EC_RES_OVERFLOW] = -EOVERFLOW,
>> +	[EC_RES_INVALID_HEADER] = -EBADR,
>> +	[EC_RES_REQUEST_TRUNCATED] = -EBADR,
>> +	[EC_RES_RESPONSE_TOO_BIG] = -EFBIG,
>> +	[EC_RES_BUS_ERROR] = -EFAULT,
>> +	[EC_RES_BUSY] = -EBUSY,
>> +	[EC_RES_INVALID_HEADER_VERSION] = -EBADMSG,
>> +	[EC_RES_INVALID_HEADER_CRC] = -EBADMSG,
>> +	[EC_RES_INVALID_DATA_CRC] = -EBADMSG,
>> +	[EC_RES_DUP_UNAVAILABLE] = -ENODATA,
>> +};
> 
> Sorry I didn't pay attention to this earlier, but is there any
> programmatic way to ensure that we don't have unexpected holes here? If
> we do (e.g., we add new error codes, but they aren't contiguous for
> whatever reasons), then those will get treated as "success" with your
> current patch.
> 
> I say "unexpected" hole, because EC_RES_SUCCESS (0) is an expected hole.
> 
>> +
>> +static int cros_ec_map_error(uint32_t result)
>> +{
>> +	int ret = 0;
>> +
>> +	if (result != EC_RES_SUCCESS) {
>> +		if (result < ARRAY_SIZE(cros_ec_error_map) && cros_ec_error_map[result])
>> +			ret = cros_ec_error_map[result];
> 
> ^^ Maybe we want to double check 'ret != 0'? Or maybe
> 
> 			ret = cros_ec_error_map[result];
> 			if (!ret) {

'ret' won't ever be 0 here. Above:
							&& cros_ec_error_map[result]

and below:

		else
			ret = -EPROTO;

> 				ret = -EPROTO;
> 				dev_err(..., "Unexpected EC result code %d\n", result);
> 			}
> 
> ? Could even be WARN_ON(), since this would be an actionable programming
> error, not exactly an external factor. Or maybe I'm being paranoid, and
> future programmers are perfect.
> 
I think, if anything, we might consider adding the message below (result >=
ARRAY_SIZE(cros_ec_error_map) is just as bad). Not sure myself. I am
open to adding it if people think it would be useful/desirable.

Thanks,
Guenter

> Otherwise:
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> 
>> +		else
>> +			ret = -EPROTO;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  static int prepare_packet(struct cros_ec_device *ec_dev,
>>  			  struct cros_ec_command *msg)
>>  {

