Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E8A2246D1
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jul 2020 01:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgGQXLr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jul 2020 19:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgGQXLq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 19:11:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FDFC0619D2
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 16:11:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z2so12760624wrp.2
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 16:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rzjn/eYPwCM6Moj4rlObmsEsReunmRsAEC0/KZLwCVg=;
        b=Lov4sdCnWQ+sBRfBNL+0G/LP/iK7IUI/22PUpseUjsRwmSVhhsKTNfh0HcvxTeEmYl
         WlrmebPlQiavtHDYNLWRQrcXG3ccPYoROmr6vd19HtI9mp/KlnVdNkMIF9k2IAnlC3pu
         9XoT04HEBib/De7FxRLtlPObMGBXc1ddRgK8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rzjn/eYPwCM6Moj4rlObmsEsReunmRsAEC0/KZLwCVg=;
        b=r4yJ10C/riqRw4E6eUgvU1cPWgLz31VKYqwzF28uG8f4KLsxOD/BFpASRls3oNttrK
         Rbt84LNwDf5avzbbS6ubV/JU6jK2/jzQMR8NtXlameBhRtU3PjpAJxWA0wKeZL4JLca5
         TOel1dy5d12+eZBftgfC38G9KBjW/z2f2L79MAgEFts+lF/qMSAqOFOoBQn/I3Vc7H8W
         +f05aog+kxsJZyhikWP79uEt6l7U+Ux+Ltq5SEblYSs4JCuK1xHcJVVmaZV3sPgnPkGJ
         VAxBwNsuHYC5UEXmNXe+61NOP3PtLfUQKkS0EtMKPE49JI8fKu6yo8/crB76UT0X7wCq
         NcsQ==
X-Gm-Message-State: AOAM5316SDhHDfwYNkeLXY11uj0WrM8j3SuyhnGYp2cDrlTRvrURvKxt
        Ld7jhlMyzVkogl9Ctqq8MXNytQ==
X-Google-Smtp-Source: ABdhPJxIeTbByBtvJPFBWtoEQwfx1aw0jKUYoGevVA/FgRszcMTAzmlm2Y25dEQktbQ/CvQGb+K4Pw==
X-Received: by 2002:adf:80c7:: with SMTP id 65mr12694318wrl.246.1595027504036;
        Fri, 17 Jul 2020 16:11:44 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c3sm4296419wrx.5.2020.07.17.16.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 16:11:43 -0700 (PDT)
Subject: Re: [PATCH v2] pwm: bcm-iproc: handle clk_get_rate() return
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20200717182512.26001-1-scott.branden@broadcom.com>
 <20200717230431.4oj44cfnkhkd2o6z@pengutronix.de>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <61a62404-6a44-53c3-6d17-89fa7a4c8551@broadcom.com>
Date:   Fri, 17 Jul 2020 16:11:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717230431.4oj44cfnkhkd2o6z@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 2020-07-17 4:04 p.m., Uwe Kleine-König wrote:
> On Fri, Jul 17, 2020 at 11:25:12AM -0700, Scott Branden wrote:
>> From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>
>> Handle clk_get_rate() returning <= 0 condition to avoid
>> possible division by zero.
> You advertise handling <= 0, but in the code only == 0 is checked. One
> of the two is wrong ...
I checked - clk_get_rate can't return negative values.
I'll update the commit message from <= to ==.
>
> Best regards
> Uwe
>
Thanks,
  Scott
