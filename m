Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5668F2CA60E
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Dec 2020 15:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389645AbgLAOpU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Dec 2020 09:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387462AbgLAOpT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Dec 2020 09:45:19 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C484C0613CF;
        Tue,  1 Dec 2020 06:44:33 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y7so3288440lji.8;
        Tue, 01 Dec 2020 06:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y9EUIaQ8GAN124ZcC2ubYB5qyTvd2qS6h+7s4S3ERhc=;
        b=tllgianMmrwuVpg6r3EmSTbKQSrPwzHyLcVAGFGi8/j+Pv2v6Gawoxml6JypW3e/Fu
         uMD0+CCTqDUo+pboGZDab1cgowlL44vTGDNNLVM87U+vO9qW04DMZQ5er5jwhoSwo+C2
         oDGz0FNJVfUs4T4OhzqtNobs6ut7R+2vCjVg8XmISnlQwEvbL5+UbB7Ge/dl49yB1TDK
         LYr25AZKa89UDlsmo2lD+gB7fYf6oEybJdqrCla7h3Sbvu7NLCHdyfDEaEBGwRbk0p3k
         4dHDlgZcvIAPJ7Rwh3E87FaAedb6Zaw4q8ebIT4+AAar4b0q2P++jCQn5/vGXhYLTolq
         mhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y9EUIaQ8GAN124ZcC2ubYB5qyTvd2qS6h+7s4S3ERhc=;
        b=pjaS6bnJCoTQHoR49nAedYDB+HWZNNiuOz3xhQSWQITsNKQ0EMw0zc10upNEoZ1smX
         Vlv0yAy0ADokwHRjbiN4Nw95aiELAz1B3Sr1EuBtYi9lHVzG1tbNVQb22IT2+kBwOFrF
         wpPOjwjoS3soLt+TIbkmYRY6L+0TN5L5b0ZmOTh2mlNT+aYp6QVPQghsqlktSDHu9p+j
         10YIzTsz3UDvvq+HykGFk9TqIXmy5zFQt8W9sNh1sBirWEmqaTdJlT3UNzlrLqSX29r4
         MDigxKmtzuI+pLy6vjo0C82mcz5hehOQgamvOvR0jIuiMQMT1mp5XDZMRrDnBjjb00Fn
         9ZmA==
X-Gm-Message-State: AOAM532uixEYChSTPpJSmFkHf4/KPEvhmt1WU0xctGEVYL6YfwJdJSkp
        +Fxy4w/5vjPuQu/aM1YOxwBr2gHOzmo=
X-Google-Smtp-Source: ABdhPJx2qDWHfrVca/Vv8M2UHUKK2ubeA/h9klMOPlTpcfO8LtF0Sa0uJ6QnKT2b0Nx9rH1QAeJ6mg==
X-Received: by 2002:a2e:9c51:: with SMTP id t17mr1411950ljj.302.1606833871765;
        Tue, 01 Dec 2020 06:44:31 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-53.dynamic.spd-mgts.ru. [109.252.192.53])
        by smtp.googlemail.com with ESMTPSA id c14sm224862lfp.7.2020.12.01.06.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 06:44:30 -0800 (PST)
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
References: <20201104234427.26477-1-digetx@gmail.com>
 <160683107675.35139.13466076210885462180.b4-ty@kernel.org>
 <858e4183-5064-084f-9b80-870e118c3edc@gmail.com>
 <20201201143420.GD5239@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2349ba09-95bf-1e2f-68ae-deea36805628@gmail.com>
Date:   Tue, 1 Dec 2020 17:44:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201201143420.GD5239@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

01.12.2020 17:34, Mark Brown пишет:
> On Tue, Dec 01, 2020 at 05:17:20PM +0300, Dmitry Osipenko wrote:
>> 01.12.2020 16:57, Mark Brown пишет:
> 
>>> [1/1] regulator: Allow skipping disabled regulators in regulator_check_consumers()
>>>       (no commit info)
> 
>> Could you please hold on this patch? It won't be needed in a v2, which
>> will use power domains.
> 
>> Also, I'm not sure whether the "sound" tree is suitable for any of the
>> patches in this series.
> 
> It didn't actually get applied (note the "no commit info") - it looks
> like b4's matching code got confused and decided to generate mails for
> anything that I've ever downloaded and not posted.
> 

Alright, thank you for the clarification.
