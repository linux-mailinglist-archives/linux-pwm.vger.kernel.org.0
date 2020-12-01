Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5262CA56B
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Dec 2020 15:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbgLAOSE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Dec 2020 09:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbgLAOSE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Dec 2020 09:18:04 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6302C0613D4;
        Tue,  1 Dec 2020 06:17:23 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id j205so4441170lfj.6;
        Tue, 01 Dec 2020 06:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+/VDVLzOBDjqiEu/N1C0eMmuynbTWK2RMfkKzr3b440=;
        b=NFS1gJ6qIMEM0tjrCNFlTLXIiKzLUz8Gnm9RoDkDgAGoOrAmFH665FazAn65xfep9j
         q1MzYJOj3Zlv/6l+94KjbYlkwVpip2977xGSaKfNO/trDYc5k7c4/WcDtCzjHhJivaw4
         R3wSqZQpSfK8urUC+KUWSI03zjKLD2qUjSA1Sh36Vv3gkEPtGffag2dP6CvSTvSq3UKY
         YylNKX7Dx4eifs+51m341bLnClw1F91DSN9xMT666b1NKXE2m8BabsDyn4Az/aDh03d7
         EAnoQKdNqE2iVos9mifhxROnB6lM4QDKR2vwmfs0SCZYZPWhyhwrUHdSXnF5Z6q3a5OU
         KfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+/VDVLzOBDjqiEu/N1C0eMmuynbTWK2RMfkKzr3b440=;
        b=LdNCmRtHMzL2CqWs+Cppu8mR/wz1IRS+Q3HJ6rWJ4WI1lx9muj5HlNQJ974cTIIXgD
         AFb/Rwop+vGgpCExbZLizRj4hdcjyLrPmrVptyWgLLd5FO472G4U4dmpg/bRIThDT/tz
         lJCHymwruUxKSZD4uk7zIWt5Yb1GHUlGwcl5TgMn39C79RhCX0ori5L5je3JdROGWnzB
         awLwEMYRElFPSpi+OeEjEPwmAYiP8aJRgzUNKOLnUH6AbqtkzzoPjSk3GoSclkIiof6P
         81wBEar6Zb2y+leq85hAgHPfW1xQMUTi8+nfr/yqMni7mmp1vNj0lXm2tNqIIz5NXLDX
         JL5g==
X-Gm-Message-State: AOAM530E8mB5IY9b0+f5BrpGPt4Ed00Qk19r7ox/PNJzObu5RUHGXCiI
        IKifSrFP1lWbaplpkpllVzWjOsdpv+M=
X-Google-Smtp-Source: ABdhPJy45twU6WKpFARyvJXmOYuPohM+PTgEg36doZmYuxa+KLwfB3LOW5+S25YIdNCijAJHOc0fgg==
X-Received: by 2002:ac2:5503:: with SMTP id j3mr1305836lfk.94.1606832242037;
        Tue, 01 Dec 2020 06:17:22 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-53.dynamic.spd-mgts.ru. [109.252.192.53])
        by smtp.googlemail.com with ESMTPSA id p16sm214803lfe.255.2020.12.01.06.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 06:17:21 -0800 (PST)
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
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
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-mmc@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
References: <20201104234427.26477-1-digetx@gmail.com>
 <160683107675.35139.13466076210885462180.b4-ty@kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <858e4183-5064-084f-9b80-870e118c3edc@gmail.com>
Date:   Tue, 1 Dec 2020 17:17:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <160683107675.35139.13466076210885462180.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

01.12.2020 16:57, Mark Brown пишет:
> On Thu, 5 Nov 2020 02:43:57 +0300, Dmitry Osipenko wrote:
>> Introduce core voltage scaling for NVIDIA Tegra20/30 SoCs, which reduces
>> power consumption and heating of the Tegra chips. Tegra SoC has multiple
>> hardware units which belong to a core power domain of the SoC and share
>> the core voltage. The voltage must be selected in accordance to a minimum
>> requirement of every core hardware unit.
>>
>> The minimum core voltage requirement depends on:
>>
>> [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] regulator: Allow skipping disabled regulators in regulator_check_consumers()
>       (no commit info)
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.

Hello Mark,

Could you please hold on this patch? It won't be needed in a v2, which
will use power domains.

Also, I'm not sure whether the "sound" tree is suitable for any of the
patches in this series.
