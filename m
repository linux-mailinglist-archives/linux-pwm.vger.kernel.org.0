Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096133B6CEF
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jun 2021 05:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhF2D0M (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Jun 2021 23:26:12 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:9296 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbhF2D0L (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Jun 2021 23:26:11 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GDV6m6xVvz1BSbD;
        Tue, 29 Jun 2021 11:18:24 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 11:23:42 +0800
Received: from [10.174.178.208] (10.174.178.208) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 29 Jun 2021 11:23:42 +0800
Subject: Re: [PATCH -next] pwm: img: Fix PM reference leak in img_pwm_enable()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1620791837-16138-1-git-send-email-zou_wei@huawei.com>
 <20210512045222.2yjm6yxikznohlmn@pengutronix.de>
 <CAJZ5v0huz6Ek1FTvdMs0hPOoMn+ZHiNJeDp6-ujg-1WwpCsELQ@mail.gmail.com>
 <20210628063839.5oeh5fvvoy3fk2gw@pengutronix.de>
 <20210628170105.apt7numxkdyxf6q5@pengutronix.de>
From:   Samuel Zou <zou_wei@huawei.com>
Message-ID: <060df682-1490-be4d-ff84-5e05cbdd9101@huawei.com>
Date:   Tue, 29 Jun 2021 11:23:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210628170105.apt7numxkdyxf6q5@pengutronix.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Sorry for the delayed reply.
Thanks for all the review,.
To keep the consistency, it's better to clean this up accordingly, and I 
will send a new patch soon.

On 2021/6/29 1:01, Uwe Kleine-König wrote:
> Hello Zou,
> On Mon, Jun 28, 2021 at 08:38:39AM +0200, Uwe Kleine-König wrote:
>> On Fri, Jun 25, 2021 at 07:45:14PM +0200, Rafael J. Wysocki wrote:
>>> On Wed, May 12, 2021 at 6:52 AM Uwe Kleine-König
>>> <u.kleine-koenig@pengutronix.de> wrote:
>>>> On Wed, May 12, 2021 at 11:57:17AM +0800, Zou Wei wrote:
>>>>> pm_runtime_get_sync will increment pm usage counter even it failed.
>>>>> Forgetting to putting operation will result in reference leak here.
>>>>> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
>>>>> counter balanced.
>>>>>
>>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>>> Signed-off-by: Zou Wei <zou_wei@huawei.com>
>>>>> ---
>>>>>   drivers/pwm/pwm-img.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
>>>>> index cc37054..11b16ec 100644
>>>>> --- a/drivers/pwm/pwm-img.c
>>>>> +++ b/drivers/pwm/pwm-img.c
>>>>> @@ -156,7 +156,7 @@ static int img_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>>>>>        struct img_pwm_chip *pwm_chip = to_img_pwm_chip(chip);
>>>>>        int ret;
>>>>>
>>>>> -     ret = pm_runtime_get_sync(chip->dev);
>>>>> +     ret = pm_runtime_resume_and_get(chip->dev);
>>>>>        if (ret < 0)
>>>>>                return ret;
>>>>
>>>> This patch looks right with my limited understanding of pm_runtime. A
>>>> similar issue in this driver was fixed in commit
>>>>
>>>>          ca162ce98110 ("pwm: img: Call pm_runtime_put() in pm_runtime_get_sync() failed case")
>>>>
>>>> where (even though the commit log talks about pm_runtime_put()) a call
>>>> to pm_runtime_put_autosuspend() was added in the error path.
>>>>
>>>> I added the PM guys to Cc, maybe they can advise about the right thing
>>>> to do here. Does it make sense to use the same idiom in both
>>>> img_pwm_enable() and img_pwm_config()?
>>>
>>> I think so.
>>>
>>> And calling pm_runtime_put_autosuspend() in the img_pwm_enable() error
>>> path would work too.
>>
>> Do you care to clean this up accordingly and send a new patch?
> 
> Note that Thierry applied your initial patch regardless of the
> inconsistency. Still I'd like to see this done in a consistent way. Do
> you care to follow up with a patch that unifies the behaviour?
> 
> Best regards
> Uwe
> 
