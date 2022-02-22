Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A564BF986
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Feb 2022 14:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiBVNhW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Feb 2022 08:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiBVNhV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Feb 2022 08:37:21 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11F02AFF
        for <linux-pwm@vger.kernel.org>; Tue, 22 Feb 2022 05:36:54 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id c23so15375172ioi.4
        for <linux-pwm@vger.kernel.org>; Tue, 22 Feb 2022 05:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FK7qt6xgpz95ThWUwGExdK4EPexQLIQmLfJrzAo+MW4=;
        b=VYdDylPcVfnkXLk+tjShAHfxjsxlFw2vPvgzDlNlXSfrOHtGTCEFpsZtPsweqqJeVn
         ctA6F01BcY5i1RliOhFhejbYeae4jlxKUlxUQ0vzVkyRMqhYzHye7eyvj1HAkJHSyoo0
         GJUlMw7Znmn3OGq4J+0xVvEYxo4WSwZzMtuuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FK7qt6xgpz95ThWUwGExdK4EPexQLIQmLfJrzAo+MW4=;
        b=PcNsbVvl0vBkKzgE+wKQ+VwtSsGpl6yQ3QAQuUb6NXNFMfieMZ4i393vL7pN322gd7
         vPvx/y62NEuKH8iOfv22WLC8PRCxkEATFm2FdyNCCvXd5a6H8O6hEfDAvMSe7G47gigq
         MHRn8GorQAWj8KMpTum2OBmv/OO8UiAe4KF1gL06SPcGQb7Hl6ZPZPyd475qt/hzjXez
         +JY/x/IMqvl77XbqE5OJb0vD0KKQWc34S+j1h8DYsQ6CXUUQGGvxiPJisXSwL4AkjFPV
         Qgc9X2gnWy+LV6cyHhTJyWjiy/vl3enq7FHEhSkThiTK0Pl1Q/MWu6P/CRULH23ZU9Ix
         lt8Q==
X-Gm-Message-State: AOAM53398YcrGLji1q4hMepqW9rAvJxt/aM2NLLZEU6oYvE0OkZJVLGT
        bXekxUwg2oKm/dBNB2ZlRx4qDw==
X-Google-Smtp-Source: ABdhPJxn55uoJgQ6VmlzDSxVVHifLMoM4/PKeoJQp5lq1lxBd336HTQfqPYuuXIX9avCcCrhnoqixw==
X-Received: by 2002:a05:6638:3283:b0:314:1d49:d553 with SMTP id f3-20020a056638328300b003141d49d553mr19882440jav.48.1645537014232;
        Tue, 22 Feb 2022 05:36:54 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id 2sm8450055ioz.48.2022.02.22.05.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 05:36:53 -0800 (PST)
Message-ID: <1f8fb11a-4f22-2301-45be-482141b1a18d@ieee.org>
Date:   Tue, 22 Feb 2022 07:36:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] staging: greybus: introduce pwm_ops::apply
Content-Language: en-US
To:     Song Chen <chensong_2000@189.cn>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     johan@kernel.org, elder@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <1644580947-8529-1-git-send-email-chensong_2000@189.cn>
 <YhPGqg2BydlAFiM1@kroah.com> <ccbddd00-a2d6-c613-bc7b-e08d7fa2306b@189.cn>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <ccbddd00-a2d6-c613-bc7b-e08d7fa2306b@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2/22/22 12:19 AM, Song Chen wrote:
> Hi Greg,
> 
> 在 2022/2/22 01:06, Greg KH 写道:
>> On Fri, Feb 11, 2022 at 08:02:27PM +0800, Song Chen wrote:
>>> Introduce apply in pwm_ops to replace legacy operations,
>>> like enable, disable, config and set_polarity.
>>>
>>> Signed-off-by: Song Chen <chensong_2000@189.cn>

. . .

>>> diff --git a/include/linux/greybus/greybus_protocols.h b/include/linux/greybus/greybus_protocols.h
>>> index aeb8f9243545..81a6f16de098 100644
>>> --- a/include/linux/greybus/greybus_protocols.h
>>> +++ b/include/linux/greybus/greybus_protocols.h
>>> @@ -812,8 +812,8 @@ struct gb_pwm_deactivate_request {
>>>   struct gb_pwm_config_request {
>>>       __u8    which;
>>> -    __le32    duty;
>>> -    __le32    period;
>>> +    __u64    duty;
>>> +    __u64    period;
>>>   } __packed;
>>
>> Did you just change a greybus protocol message that is sent over the
>> wire?  Why?  And why drop the endian marking of it?
> 
> I discussed with Uwe about losing bit and found there is no perfect
> way to avoid, even in Uwe's patch[1], as a result, we decided to

The patch you reference [1] does not change the size of the
duty cycle and period, it only ensures the value passed is
no more than can be represented in an integer.

> widen duty and period in gb_pwm_config_request, the other side of the
> wire is supposed to change accordingly to support 64bit duty and

This is what Greg meant about changing the over-the-wire protocol
message format.  You can't do that, or rather, if you do that, it
is a *lot* more work than just changing it as you have done here.

If it is really required (and that's not clear, at least not at
this time), then you need to modify the protocol version, and
then make sure the versioning logic works correctly, both on
the AP side and on the module side for all existing modules.

I would suggest that it is *not* required though, because the
existing module code was built with the assumption that it would
be provided a 32-bit unsigned value for its duty cycle and period.
So as long as you make sure the AP side doesn't send anything
nonsensical, they will continue to work as desired.

The correct fix in this case (assuming you don't want to change
the protocol) is to ensure that whatever value is passed in to
the pwm_ops->config callback (which is gb_pwm_config()) is
adjusted to be within a range usable by the existing protocol.
Since it's actually an unsigned value, you could double the
range supported without changing the protocol if you wanted to
do that.

> period too(this will introduce compatibility problem and there is no
> variable like version to address it), similar with ktime_t in y2038,
> below is the detail [2]

And similar to addressing the Y2038 issue, it is not an easy thing to do.

> [1]:https://lore.kernel.org/all/20210312212119.1342666-1-u.kleine-koenig@pengutronix.de/
> [2]:https://lore.kernel.org/all/20220211071601.4rpfbkit6c6dre2o@pengutronix.de/
> 
> endian is a problem, i shouldn't drop it.

This is absolutely correct.  Did you attempt to compile this?

					-Alex

> BR
> 
> Song
> 
>>
>> Are you sure this is ok?
>>
>> thanks,
>>
>> greg k-h
>>

