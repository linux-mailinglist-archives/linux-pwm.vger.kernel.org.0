Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1E7815F9
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Aug 2019 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfHEJzQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Aug 2019 05:55:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35028 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbfHEJzP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Aug 2019 05:55:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id w20so78055045edd.2
        for <linux-pwm@vger.kernel.org>; Mon, 05 Aug 2019 02:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ugxJzTJ2xHuItvCljlgbNzTRxYRdkmyzJjHeDKI4Cvg=;
        b=f41/9GuHcg3HEK8D5hgdWB3/mF0JU++eiz8MHnydEwlR2AyDasAedlrOUpufOfBTTk
         f94lJpX5uFSCNDGS4kFiYKC7ufV39k/CMiQcfClqUmfRzyhdP25aunKSXCwzaycU07gE
         ZYqeE0Mm6IIjZ9N3lRAG5a/CtHr4lkUycJ5b5TwChS6gcmmgByp+9t6iVRCIfYQO1EpM
         fIs3B7ya36R0hrgAomltf0k4qHpESNxxlsFPmzcUWcaFY8FSLuf1g/yruiY5fPXKScIL
         LZR9GRsZMVoRHJEuo4csd+mfyLzm4EnPx4ES+G+sCaoA/yiN3SOOW1llPW9wCcvAwIlq
         LCQQ==
X-Gm-Message-State: APjAAAWnUeVK2UtVOVUDtwesfXUChqJzVZDTRPG5QfLJ48jOUbOeaAou
        6Y8dandXnqFY4xH0ayYf/9S8cQ==
X-Google-Smtp-Source: APXvYqwn63PWHhnonKoXTG3u1Pfg7RTdggSgLoLyHCiGmI4NwkHuLOqV/Kof7OqzI0HtI3085JmZdQ==
X-Received: by 2002:a17:906:684e:: with SMTP id a14mr118417610ejs.156.1564998913913;
        Mon, 05 Aug 2019 02:55:13 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id e14sm2004517ejj.69.2019.08.05.02.55.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 02:55:13 -0700 (PDT)
Subject: Re: [PATCH 5.3 regression fix] pwm: Fallback to the static
 lookup-list when acpi_pwm_get fails
To:     Nikolaus Voss <nv@vosn.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "youling257@gmail.com" <youling257@gmail.com>,
        nikolaus.voss@loewensteinmedical.de
References: <20190730154848.5164-1-hdegoede@redhat.com>
 <alpine.DEB.2.20.1908050935570.62587@fox.voss.local>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4e2afae5-ce42-9f32-e3df-cdf222690af2@redhat.com>
Date:   Mon, 5 Aug 2019 11:55:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1908050935570.62587@fox.voss.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 05-08-19 11:31, Nikolaus Voss wrote:
> Hi Hans,
> 
> On Tue, 30 Jul 2019, Hans de Goede wrote:
>> Commit 4a6ef8e37c4d ("pwm: Add support referencing PWMs from ACPI")
>> made pwm_get unconditionally return the acpi_pwm_get return value if
>> the device passed to pwm_get has an ACPI fwnode.
>>
>> But even if the passed in device has an ACPI fwnode, it does not
>> necessarily have the necessary ACPI package defining its pwm bindings,
>> especially since the binding / API of this ACPI package has only been
>> introduced very recently.
>>
>> Up until now X86/ACPI devices which use a separate pwm controller for
>> controlling their LCD screen's backlight brightness have been relying
>> on the static lookup-list to get their pwm.
>>
>> pwm_get unconditionally returning the acpi_pwm_get return value breaks
>> this, breaking backlight control on these devices.
>>
>> This commit fixes this by making pwm_get fall back to the static
>> lookup-list if acpi_pwm_get returns -ENOENT.
> 
> Ok, I didn't find any pwm_add_table() calls in the x86 directory, so I thought the fallback matching is only for non-DT/non-ACPI systems.

AFAIK only Bay Trail and Cherry Trail X86 systems use a separate
(not integrated into the GPU) PWM controller, but there are a lot of
these systems out there. I got a bug report for this pretty much the
day rc1 was out :)

The pwm_add_table calls are done in drivers/acpi/acpi_lpss.c.

> If it is used for ACPI nodes without PWM controller binding, it maybe should apply to DT nodes without PWM controller binding, too?
> 
> It would be structurally cleaner as DT and ACPI handling was symmetrical.

I'm fine with someone doing a follow up patch along this lines, but
given that this is a serious regression in 5.3 I would like to move
forward with my tested patch as is to fix the regression in 5.3.

Regards,

Hans



>> BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=96571
>> Reported-by: youling257@gmail.com
>> Fixes: 4a6ef8e37c4d ("pwm: Add support referencing PWMs from ACPI")
>> Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> drivers/pwm/core.c | 7 +++++--
>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>> index c3ab07ab31a9..8edfac17364e 100644
>> --- a/drivers/pwm/core.c
>> +++ b/drivers/pwm/core.c
>> @@ -882,8 +882,11 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>>                return of_pwm_get(dev, dev->of_node, con_id);
>>
>>        /* then lookup via ACPI */
>> -       if (dev && is_acpi_node(dev->fwnode))
>> -               return acpi_pwm_get(dev->fwnode);
>> +       if (dev && is_acpi_node(dev->fwnode)) {
>> +               pwm = acpi_pwm_get(dev->fwnode);
>> +               if (!IS_ERR(pwm) || PTR_ERR(pwm) != -ENOENT)
>> +                       return pwm;
>> +       }
>>
>>        /*
>>         * We look up the provider in the static table typically provided by
>> -- 
>> 2.21.0
>>
>>
