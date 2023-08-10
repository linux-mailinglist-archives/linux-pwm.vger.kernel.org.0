Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB3E7775D6
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Aug 2023 12:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjHJKat (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Aug 2023 06:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjHJKaj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Aug 2023 06:30:39 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F57E213B
        for <linux-pwm@vger.kernel.org>; Thu, 10 Aug 2023 03:30:37 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bcade59b24so717790a34.0
        for <linux-pwm@vger.kernel.org>; Thu, 10 Aug 2023 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1691663436; x=1692268236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfX2UO9uPMLGCJf+csL6XyU3QIcd01mEsKwWrpSRNS4=;
        b=SGnJ72WXikaU5xqUInA5M3UvYftl90Px6nU01CEkJphO/WsF5Q2X5gSU4xT6tchamL
         5oH6WUuttHrXL1mWEVgtVnnZcbyWQK/LF7pjeAbo0lqCgKuhyI2LHTGFBGyJVqpZP3jd
         7Ro7a7lBZSw2Q3l6rd0D5Ir21mM9lV0jqpqfROsleVpiV+VBfaaCQvlwJK9l7emWyXps
         8/kD9xmUX1yvQDY9601GcrdcL9zSua5LZ24RsKY6wRIfgaOFtkIWbGDREjHCZnusU9XY
         GCp9qb1WTiBL0TwB8aR0iGDjuhuYll95r5DPSw7mP4UBQ4VqxgXIvmewPTXRP901tW6V
         ezsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663436; x=1692268236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfX2UO9uPMLGCJf+csL6XyU3QIcd01mEsKwWrpSRNS4=;
        b=XHEIeZKWmaNLTGGDMvd5rgtGvLCiF/+7yVl6briMeyBIbC6OPrThTD6ha05v0K44Ii
         1xM0YpeMHAaItriRGrZ71fuXOIJJxo4KeDiwrc1qvkwFMsFxfW2tCV3qhQYkJA+7F6HM
         KHhip6wFwNn15p2CL0aoVckFOxHLh70jk4/7yOrHi8SQx13fkQgkHqmk7Vxm2OMglO/q
         zH1wY7FBxoVZ6wsuEDnJYI0utmWw4faYBmik266nTO19oss7IQc+UpPs54qqQrbL8tp5
         6QJqs8r899GmotED82tatuL+HwCrL3ZCY6pPJprn9H5zkIBSy35fD4lGIQD+YWXXQiQd
         MiLw==
X-Gm-Message-State: AOJu0YxOFZmrRPL2eZbwzfDxoySjCUtlM1TT0IAuJPHNjuKqbv1KlTr4
        gAqLjH0nbAo5rAyp6K/Cu+j9Gg==
X-Google-Smtp-Source: AGHT+IF0r6GZclcogo6XbgwR5E95APycZzfccRq3VLl0HNlzfmMExbMjn9dfSBYwvsABTggoervb8w==
X-Received: by 2002:a05:6358:7e8f:b0:134:c279:c82a with SMTP id o15-20020a0563587e8f00b00134c279c82amr2360798rwn.29.1691663435963;
        Thu, 10 Aug 2023 03:30:35 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id y11-20020a63ad4b000000b00564250660f3sm1214409pgo.78.2023.08.10.03.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 03:30:35 -0700 (PDT)
Message-ID: <0bdbd852-d21d-3149-a34f-8d25ec3544e8@tuxon.dev>
Date:   Thu, 10 Aug 2023 13:30:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
To:     Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc:     nicolas.ferre@microchip.com, conor.dooley@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, maz@kernel.org,
        srinivas.kandagatla@linaro.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, sre@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
 <ZM0Be8S8zII8wV4l@nanopsycho> <ZNS0708cDAt7H7ul@vergenet.net>
Content-Language: en-US
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <ZNS0708cDAt7H7ul@vergenet.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 10.08.2023 12:59, Simon Horman wrote:
> On Fri, Aug 04, 2023 at 03:47:39PM +0200, Jiri Pirko wrote:
>> Fri, Aug 04, 2023 at 07:00:07AM CEST, claudiu.beznea@tuxon.dev wrote:
>>> Update MAINTAINERS entries with a valid email address as the Microchip
>>> one is no longer valid.
>>>
>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>> ---
>>>
>>> Changes in v2:
>>> - collected tags
>>> - extended the recipients list to include individual subsystem
>>>  maintainers and lists instead using only linux-kernel@vger.kernel.org
>>>  as suggested initially by get_maintainers.pl
>>
>> Consider adding entry in .mailmap as well please.
> 
> Hi Claudiu,
> 
> I'd like to echo Jiri's suggestion of adding .mailmap entry
> to reflect this change.

Hi, Simon, Jiri! It's on my list. I'll handled it asap.
