Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1C18168E
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Aug 2019 12:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfHEKL3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Aug 2019 06:11:29 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:50888 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfHEKL3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Aug 2019 06:11:29 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 333A1466FE; Mon,  5 Aug 2019 12:11:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 2F33C46510;
        Mon,  5 Aug 2019 12:11:27 +0200 (CEST)
Date:   Mon, 5 Aug 2019 12:11:27 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "youling257@gmail.com" <youling257@gmail.com>
Subject: Re: [PATCH 5.3 regression fix] pwm: Fallback to the static lookup-list
 when acpi_pwm_get fails
In-Reply-To: <4e2afae5-ce42-9f32-e3df-cdf222690af2@redhat.com>
Message-ID: <alpine.DEB.2.20.1908051159370.64037@fox.voss.local>
References: <20190730154848.5164-1-hdegoede@redhat.com> <alpine.DEB.2.20.1908050935570.62587@fox.voss.local> <4e2afae5-ce42-9f32-e3df-cdf222690af2@redhat.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-630655690-1564999887=:64037"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-630655690-1564999887=:64037
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 5 Aug 2019, Hans de Goede wrote:
> Hi,
>
> On 05-08-19 11:31, Nikolaus Voss wrote:
>> Hi Hans,
>> 
>> On Tue, 30 Jul 2019, Hans de Goede wrote:
>>> Commit 4a6ef8e37c4d ("pwm: Add support referencing PWMs from ACPI")
>>> made pwm_get unconditionally return the acpi_pwm_get return value if
>>> the device passed to pwm_get has an ACPI fwnode.
>>> 
>>> But even if the passed in device has an ACPI fwnode, it does not
>>> necessarily have the necessary ACPI package defining its pwm bindings,
>>> especially since the binding / API of this ACPI package has only been
>>> introduced very recently.
>>> 
>>> Up until now X86/ACPI devices which use a separate pwm controller for
>>> controlling their LCD screen's backlight brightness have been relying
>>> on the static lookup-list to get their pwm.
>>> 
>>> pwm_get unconditionally returning the acpi_pwm_get return value breaks
>>> this, breaking backlight control on these devices.
>>> 
>>> This commit fixes this by making pwm_get fall back to the static
>>> lookup-list if acpi_pwm_get returns -ENOENT.
>> 
>> Ok, I didn't find any pwm_add_table() calls in the x86 directory, so I 
>> thought the fallback matching is only for non-DT/non-ACPI systems.
>
> AFAIK only Bay Trail and Cherry Trail X86 systems use a separate
> (not integrated into the GPU) PWM controller, but there are a lot of
> these systems out there. I got a bug report for this pretty much the
> day rc1 was out :)
>
> The pwm_add_table calls are done in drivers/acpi/acpi_lpss.c.
>
>> If it is used for ACPI nodes without PWM controller binding, it maybe 
>> should apply to DT nodes without PWM controller binding, too?
>> 
>> It would be structurally cleaner as DT and ACPI handling was symmetrical.
>
> I'm fine with someone doing a follow up patch along this lines, but
> given that this is a serious regression in 5.3 I would like to move
> forward with my tested patch as is to fix the regression in 5.3.

Makes sense, thank you for the explanation.

Acked-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

>
> Regards,
>
> Hans
>
>
>
>>> BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=96571
>>> Reported-by: youling257@gmail.com
>>> Fixes: 4a6ef8e37c4d ("pwm: Add support referencing PWMs from ACPI")
>>> Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> drivers/pwm/core.c | 7 +++++--
>>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>>> index c3ab07ab31a9..8edfac17364e 100644
>>> --- a/drivers/pwm/core.c
>>> +++ b/drivers/pwm/core.c
>>> @@ -882,8 +882,11 @@ struct pwm_device *pwm_get(struct device *dev, const 
>>> char *con_id)
>>>                return of_pwm_get(dev, dev->of_node, con_id);
>>> 
>>>        /* then lookup via ACPI */
>>> -       if (dev && is_acpi_node(dev->fwnode))
>>> -               return acpi_pwm_get(dev->fwnode);
>>> +       if (dev && is_acpi_node(dev->fwnode)) {
>>> +               pwm = acpi_pwm_get(dev->fwnode);
>>> +               if (!IS_ERR(pwm) || PTR_ERR(pwm) != -ENOENT)
>>> +                       return pwm;
>>> +       }
>>> 
>>>        /*
>>>         * We look up the provider in the static table typically provided 
>>> by
>>> -- 
>>> 2.21.0
>>> 
>>> 
>
--8323329-630655690-1564999887=:64037--
