Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BECC2AE1CF
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Nov 2020 22:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgKJVcb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Nov 2020 16:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJVcb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Nov 2020 16:32:31 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD04C0613D1;
        Tue, 10 Nov 2020 13:32:31 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id i6so233139lfd.1;
        Tue, 10 Nov 2020 13:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Udf8izR79EOqP1ijS53zeM3N/JUnCwVrU1fnKC8yXBM=;
        b=TJmDKYdfhNndOw9Fc/1HEuqiqmcIfs67XGIMRW/n659q4NI/oyLnPwqYqDHpqqSze4
         yxRdw/JI8MhkLlhqv01SA66a1lehinyiB40p03H4fmPC4kXqdPdOR9DXXI+CA8FSqBk7
         w6wChwFGwttwXQX2Xdjz29Y+Hwu/v0WRMXMyYljuqE429oOhuZ7qiOzZFPxi1Rkyq/NW
         nVGYWY6zZm9eoNwo6SyRQJSccBYBxUNPG9MlrFkc8UTPfeDIiXk0WNTxV7mdyps+2+6X
         OXy/7b5VqZJ3lgMWmZYzyttqwfgys1sL/l1uEmuidS91VXkM+dhRqONrgFsT4PF6pA+C
         zF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Udf8izR79EOqP1ijS53zeM3N/JUnCwVrU1fnKC8yXBM=;
        b=Sa/uuCxZP4Ptb4d2EkGqIo5mvHCwTvjcX0GOcY8blJ9VGqRI/sCglnNsshb41ZrPpa
         8wDpnvDc78i92Dl6u5fR0tDsc5qt3lMj34uXKJVdf7qpDeq0ZjOA6Saz80vV7dmK8mX8
         VlTTkPWWNLpu6yTmugFPICnbMDy/DGStcfM/ye3+r0JymlZGzRdiDI7jGO2Ov2YO6kHo
         KRjGaMIra+b0+y544PFymU5Glqb3vpjYD5Kdmn/0/XcahIOmyrLMsoSYYBlRXzJo84fr
         W/BJ47UQaRn7ll3CukfcKKR6nd75/JuQqscxccTSyZBlbUY1lejk0UfGS0w4/MtfNxVa
         rjgA==
X-Gm-Message-State: AOAM53201SGdgthvsqceDl90nOoGdj48A35DNQOWHXLUW4hl4V7voN+N
        PDSfpbRmxgc/LOv3pcBDZHV5RrdE09s=
X-Google-Smtp-Source: ABdhPJzgddle15uZzQkarcn6HNRYEMFyRgf1xVU2K+91PWIHM5P29WaFydPEJ+nc/MxNTQcdKv1N/w==
X-Received: by 2002:ac2:5e6e:: with SMTP id a14mr6600177lfr.595.1605043949411;
        Tue, 10 Nov 2020 13:32:29 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id o12sm2721051ljc.59.2020.11.10.13.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 13:32:28 -0800 (PST)
Subject: Re: [PATCH v1 07/30] soc/tegra: Add sync state API
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-8-digetx@gmail.com> <20201110204727.GG2375022@ulmo>
 <71934373-8425-345b-7719-0903f846119f@gmail.com>
Message-ID: <7b6c7c62-495c-eeb8-9cdb-0c33be653e3d@gmail.com>
Date:   Wed, 11 Nov 2020 00:32:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <71934373-8425-345b-7719-0903f846119f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

11.11.2020 00:22, Dmitry Osipenko пишет:
> I added a special spell checking rule for this typo, but it does help
> reliably.

does *not*
