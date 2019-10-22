Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 595C3DFC2F
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2019 05:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387462AbfJVDWt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 23:22:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36056 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbfJVDWs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 23:22:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id j11so7637021plk.3;
        Mon, 21 Oct 2019 20:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ktjQEDZTM5vr66tIybOMYDqM0GssdJmiaPiXVHKGvHE=;
        b=dkDtJy+ogm/ooMKxFR+W1KnGqlR6ZmXhXUvZMmGhSiPp22uLhtTpfsZ5WuY1baFp9a
         LgcBEzBSZeCluGunH6Ri0c1ndwMuaiT3to2dTPA0gqOEe6ru4ZqnUxVxJohzkbqogee9
         OlvtKoXZaz227YcEu3MpSTuOyFG70N+YFos5czdE69QNSXhwyFmGoTH1kEJI98U/Mn1F
         zJReNgGXEjHCQ0iLj2MJYcTQJhUVbn3gYds/t2j1/eZVOdkNpLOU9D+kkuCypMQu546d
         dL7qGYqRKigEhMbAwQxdUw+9a7KrUov23d9GAAabjlzcFrLijOOQucDzY8NIHb/30ZMP
         oQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ktjQEDZTM5vr66tIybOMYDqM0GssdJmiaPiXVHKGvHE=;
        b=ZDchsapbSU3h4RNfovgX6UujYdGZXhlOggD883Db4I1dMHhTJR0k8E0Ict+BMJVhat
         nnry6A2Cl0D1d34pD9orVVz2ZoPD7wXvCdJTVwJasvRoi6Ms4+kypbkQHrFoUJUjdmqm
         xiS5JWjCDYF3qA2A++53VrM+8J0nihsk6N9onqQFmk9QQao6lqGIRvuBb8rwl2dM/c5A
         wld9L9QnwNRNOkCAuWteL4djFet/qHmsYd2gP6iEwFb2q8kKOD8zY9BkNWbsJIi0Qr1Z
         UDe0kZRdEYyaiUQiUgjjP8xJ9QecRYhAnF8IZuTdbKbcjUo6NSQHg4UnQanb4oQ3q6CH
         vT3Q==
X-Gm-Message-State: APjAAAUDafPYqWlbuuBxBW5nlBwRxlJ0cb9NyPmuJQeKzRnUoxKxoVtT
        ZCjAvKrzRvQodEjqt6URVlvNHqFr
X-Google-Smtp-Source: APXvYqxiL+g5UerW/p2FC+aAarTSUIn7gq/OzWK07PYqQH+0AutS9s21wDLktL4nfAIRMVo0ugp2ww==
X-Received: by 2002:a17:902:1:: with SMTP id 1mr948164pla.338.1571714567878;
        Mon, 21 Oct 2019 20:22:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e17sm591942pgg.5.2019.10.21.20.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 20:22:46 -0700 (PDT)
Subject: Re: [PATCH 4/8] hwmon: Add support for Azoteq IQS620AT temperature
 sensor
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com,
        thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-hwmon@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-5-git-send-email-jeff@labundy.com>
 <20191021153825.GA15359@roeck-us.net> <20191022022611.GA2091@labundy.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f9610e3d-d923-1ffe-233f-e94cace41f64@roeck-us.net>
Date:   Mon, 21 Oct 2019 20:22:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191022022611.GA2091@labundy.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 10/21/19 7:26 PM, Jeff LaBundy wrote:
> Hi Guenter,
> 
> Thank you for your prompt review.
> 
> On Mon, Oct 21, 2019 at 08:38:25AM -0700, Guenter Roeck wrote:
>> On Sun, Oct 20, 2019 at 11:11:19PM -0500, Jeff LaBundy wrote:
>>> This patch adds support for the Azoteq IQS620AT temperature sensor,
>>> capable of reporting its absolute die temperature.
>>>
>>> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
>>
>> Seems to me this might be more feasible as iio driver.
>> Jonathan, what do you think ?
>>
> 
> Interestingly enough, this actually started as an iio driver; however the
> "When to Use" slide of [0] made me suspect that conventional devices with
> the temperature sensing element integrated on the die belong in hwmon.
> 
> I then found the highly similar ad7314, which Jonathan himself appears to
> have converted from iio to hwmon. Therefore, I placed this where existing
> drivers seemed to match the most, especially since the temperature sensors
> in iio generally use IR or a thermocouple.
> 
> That being said, I would be happy to move this into iio so long as Jonathan
> does not mind, as it would limit the blast radius of this patch series.
> 

I don't recall why the ad7314 driver was moved. With a conversion time of 40uS
it is most definitely not a typical use case for a hwmon sensor.

Anyway, not worth arguing about. Just don't complain later. There is an
iio->hwmon bridge, but no hwmon->iio bridge, so the decision does have some
impact. Specifically, userspace will have to implement both hwmon and iio
access to handle the chip.

Guenter
