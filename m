Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAE93B4855
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jun 2021 19:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhFYRrr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Fri, 25 Jun 2021 13:47:47 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:40568 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYRrr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Jun 2021 13:47:47 -0400
Received: by mail-ot1-f45.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so8312776otk.7;
        Fri, 25 Jun 2021 10:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Pdg+c0bCKRv3vfZOsBUZeWcTgAgBkhLYfD+IypIHoU=;
        b=pHL7eNdoT86v1TpKlm2dSCWP9eg36bkOha3O4dcB1kXIgTYnNDkl5ypGec2Ktdjid0
         WfMseHN4rEICEwcp4X0hav4zuSGHwv9Wd7gnMKHTk07oe20PfbXcgAXPOzhRPR7jsZof
         g2Lw7q+m3oR8RQczzQJryM3hxT/QQLnx+1Gt5WfFgUSPCfD8nmLWXxqmtgYJCC7lGnuY
         BUopDSuZLB8/qpKRd+TZ5+4R44LuBFkgEH4Fs4b+CARtofIrDhCRqGysCnCLeZBzIn2O
         7P+j18Oz7796Ea5IioVV5ZO8QFfRN4qt9tPunH8abfCLTF3koRTX+uGXVcjRdZQ54wRE
         GfaQ==
X-Gm-Message-State: AOAM533d5sSSvDV1eTXCX+Z/tLACzfPDLv3C14qJnPUizY+fRFWV+Nzo
        Z5IEPOA+JtWlFPevqjFwVFMrt87dBdU45qMp52NtvSYVQ3Q=
X-Google-Smtp-Source: ABdhPJyIuxfdEd/5Ts/EYJtDmPwFUQVIHJeQytN255CeTODS6bnGUFs5qzjLHxzOoct1MeaoMICZOo0ZuGzaEUveQFo=
X-Received: by 2002:a9d:1905:: with SMTP id j5mr10641075ota.321.1624643125712;
 Fri, 25 Jun 2021 10:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <1620791837-16138-1-git-send-email-zou_wei@huawei.com> <20210512045222.2yjm6yxikznohlmn@pengutronix.de>
In-Reply-To: <20210512045222.2yjm6yxikznohlmn@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Jun 2021 19:45:14 +0200
Message-ID: <CAJZ5v0huz6Ek1FTvdMs0hPOoMn+ZHiNJeDp6-ujg-1WwpCsELQ@mail.gmail.com>
Subject: Re: [PATCH -next] pwm: img: Fix PM reference leak in img_pwm_enable()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Zou Wei <zou_wei@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, May 12, 2021 at 6:52 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Wed, May 12, 2021 at 11:57:17AM +0800, Zou Wei wrote:
> > pm_runtime_get_sync will increment pm usage counter even it failed.
> > Forgetting to putting operation will result in reference leak here.
> > Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> > counter balanced.
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Zou Wei <zou_wei@huawei.com>
> > ---
> >  drivers/pwm/pwm-img.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> > index cc37054..11b16ec 100644
> > --- a/drivers/pwm/pwm-img.c
> > +++ b/drivers/pwm/pwm-img.c
> > @@ -156,7 +156,7 @@ static int img_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> >       struct img_pwm_chip *pwm_chip = to_img_pwm_chip(chip);
> >       int ret;
> >
> > -     ret = pm_runtime_get_sync(chip->dev);
> > +     ret = pm_runtime_resume_and_get(chip->dev);
> >       if (ret < 0)
> >               return ret;
>
> This patch looks right with my limited understanding of pm_runtime. A
> similar issue in this driver was fixed in commit
>
>         ca162ce98110 ("pwm: img: Call pm_runtime_put() in pm_runtime_get_sync() failed case")
>
> where (even though the commit log talks about pm_runtime_put()) a call
> to pm_runtime_put_autosuspend() was added in the error path.
>
> I added the PM guys to Cc, maybe they can advise about the right thing
> to do here. Does it make sense to use the same idiom in both
> img_pwm_enable() and img_pwm_config()?

I think so.

And calling pm_runtime_put_autosuspend() in the img_pwm_enable() error
path would work too.
