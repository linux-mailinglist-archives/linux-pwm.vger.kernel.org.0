Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35925421209
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Oct 2021 16:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbhJDOyi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Oct 2021 10:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbhJDOyi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Oct 2021 10:54:38 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5727C061749;
        Mon,  4 Oct 2021 07:52:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id e15so72801906lfr.10;
        Mon, 04 Oct 2021 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e9mEC7vyz6aYS5ipxJsTFX2kQTkmdkM9KeZtG855BT0=;
        b=j0Ur3IU22Dtc5kFnP/nXkoktbxHcZFHOAKKskIoJgXkwGHYXbbkyALnAz04dfcCoVV
         0Mi+yf7x6bLdauQEAwTnqbWC6yASn3DvUmQzjLsswUxGTTKJ6s/CRmffsVicfj4H/JdQ
         c/LIIg0L7rv8lHs1sW2K5rZwgSx57ZXcHyto17YWq5qqGR+KdrUM8a/vBIQevrz7MKqt
         4+fAAMP0uH9K8IRIrKtcrYu5d1hJt2gQAndx84DW2UalqWNKhO6AnDeKmZJUWZRpcZPy
         CmjMAchXyeOg4QY//26g7aMb6W3U/7YeGFmXOquN7S/42F7Yuv5Wu7Qw7InfGjWugPr7
         q3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e9mEC7vyz6aYS5ipxJsTFX2kQTkmdkM9KeZtG855BT0=;
        b=i4FOD3fZwEezdBUfN0ibfgTJ8bBbIkAGRvpk6bnVxVD/jD6xaHkpPLWblD5dUTA+FN
         xwnrb6cpktDfgsOJD7Z5NERbkC9ww5+MyuGnsg2HQ8KIjLd2G1yRTE2kR4R2aYhBARFP
         7YJ9e/gjVT07bv7KzONujK/NvIL1OyachS6GD/Y2L5sEUYGzwcZvcwc2GR6dsTQptgRf
         C//fUStXeY3Ufp/Fr4R7r1feYRNHMpIIlFJAxlPEMs4EegXfmRQHMUTiEVeti98JFixw
         eMGZiKBw+sR90a7JmXSCm1P/+VIVC7PO7L00zZkOmgBPMJsDygKER/rrAVzJwqHVoKdZ
         vN3A==
X-Gm-Message-State: AOAM5326A24VhUpnlyO4l8r+dzkw2KfbwBEIgBbWc9ROTtdICTxxKtu2
        E3uku8UKjseBYCt/yHAVPrE=
X-Google-Smtp-Source: ABdhPJwZpF/pb309DarSmG6340t8JrbcT7IOPdU/tSH1oTe/CJm/C7yaYY6kTpK2zLUPD04MKNAKqg==
X-Received: by 2002:a2e:5450:: with SMTP id y16mr16673360ljd.21.1633359167035;
        Mon, 04 Oct 2021 07:52:47 -0700 (PDT)
Received: from [192.168.2.145] (79-139-163-57.dynamic.spd-mgts.ru. [79.139.163.57])
        by smtp.googlemail.com with ESMTPSA id o19sm1632148lfg.68.2021.10.04.07.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 07:52:46 -0700 (PDT)
Subject: Re: [PATCH v13 00/35] NVIDIA Tegra power management patches for 5.16
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
References: <20210926224058.1252-1-digetx@gmail.com>
 <20211004091129.fhlfhsddzk5fakuj@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <80e0e5a9-7987-a334-7a2b-a7b09b591414@gmail.com>
Date:   Mon, 4 Oct 2021 17:52:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211004091129.fhlfhsddzk5fakuj@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

04.10.2021 12:11, Viresh Kumar пишет:
> On 27-09-21, 01:40, Dmitry Osipenko wrote:
>> This series adds runtime PM support to Tegra drivers and enables core
>> voltage scaling for Tegra20/30 SoCs, resolving overheating troubles.
>>
>> All patches in this series are interdependent and should go via Tegra tree.
> 
> So you don't need any OPP changes anymore ? I just came back from
> vacation, don't know what you guys discussed in between :)
> 

We discussed it and decided that we don't need more OPP/domain core
changes. It's already good enough for the starter and making it all
absolutely ideal doesn't worth the effort for now.
