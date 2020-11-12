Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879B72B11C0
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 23:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgKLWhH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 17:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgKLWhG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 17:37:06 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F348C0613D1;
        Thu, 12 Nov 2020 14:37:05 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id i6so10952069lfd.1;
        Thu, 12 Nov 2020 14:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0qni2M87D+g89wV73PaUfeJOYq05vtoVkWdsLrYHeyg=;
        b=kdYppoKFHiS9XKa3FhxlKioia9DpxhoAMnLvX3xxwUDyqIiDJ3HHl3IBW6p/6Hppgr
         R1rrlU57Zy6cPF2EoCyeH+Vj7DtGbdUur/qeOJ5iivsuZWhBfoFYLANqy8A0ZN/hIbOC
         hzMjgk+HOAKRJgwRKfqTFbsQQCm6O1j9Mk2vhjV5UCip2XhLqD1SR0a/iBKgVIIdZ89E
         BYwaMCRnu8T3dfsnrarFGvnrKog6t/XXpNu/IZPXfANecW0enI19tvf+dIatOgQDZ7OK
         TcsqlEJ0qKXLVGEQoZ/auOTRSu/cyJMRmB++w+tQm6Fjk+QGvmxT/rVGMvqP4kLUagKK
         crgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0qni2M87D+g89wV73PaUfeJOYq05vtoVkWdsLrYHeyg=;
        b=i9XT3DeEn66paWC21p/Q3Gn6OaYwiUeZDLeDkq4gp80c+OiqiSH1x8apchsO36co4V
         YrUBWleQKWu6XRXSQJVELSkrXgiSb/mfK7L7+HF/XGGd2KK9Da/OOmEs82FuZiaaZOGm
         R7WPsNhYUP1HHt836BXp/e2lbNN96jwWuLeUtWr7JLoUQHrCf5Qb48h0hXumwumRqoiF
         sPwfBykQbRi6gKUCxnt+KIY/kg2hlJkF0Ujnwh1FcTISE1yT32e0YfeMnf1EIkOWo50W
         g0TzPHnNKR7jITX6kUQK3782Ab5YNoGleZ1d9dlNd14iArN8W54zJm9F7nFqVB9vwSdS
         mi+A==
X-Gm-Message-State: AOAM532BgxESa2gbLJlSoya9/baP8ZMcnk8nAdOil512Y8H3nYBGtSRI
        Av8f1zNOupkXjPx7wKecXIBeQd4XOtk=
X-Google-Smtp-Source: ABdhPJz14sMvD+lHcp3Whn12ApfHxx9o6IGlXRIpcfSRQR0C4MBfRBbzrGgqZKxBnQTJLRiZ9wpHOA==
X-Received: by 2002:a05:6512:3312:: with SMTP id k18mr654537lfe.403.1605220623351;
        Thu, 12 Nov 2020 14:37:03 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id 1sm981505lfi.263.2020.11.12.14.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 14:37:02 -0800 (PST)
Subject: Re: [PATCH v1 11/30] drm/tegra: dc: Support OPP and SoC core voltage
 scaling
To:     Mark Brown <broonie@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
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
 <20201104234427.26477-12-digetx@gmail.com> <20201110202945.GF2375022@ulmo>
 <20201110203257.GC5957@sirena.org.uk>
 <72ae6462-13df-9fcb-510e-8e57eee0f035@gmail.com>
 <20201111115534.GA4847@sirena.org.uk>
 <dd26eb18-8ac4-22a6-29b0-dbbe5fa6075b@gmail.com>
 <20201112171600.GD4742@sirena.org.uk>
 <b4b06c1d-c9d4-43b2-c6eb-93f8cb6c677d@gmail.com>
 <20201112200123.GF4742@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ce9e2d9f-917e-fb8a-7323-f3bf1a367e9d@gmail.com>
Date:   Fri, 13 Nov 2020 01:37:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201112200123.GF4742@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

12.11.2020 23:01, Mark Brown пишет:
>> But it's not allowed to change voltage of a dummy regulator, is it
>> intentional?
> Of course not, we can't know if the requested new voltage is valid - the
> driver would have to have explict support for handling situations where
> it's not possible to change the voltage (which it can detect through
> enumerating the values it wants to set at startup).
> 
> [Requesting the same supply multiple times]

But how driver is supposed to recognize that it's a dummy or buggy
regulator if it rejects all voltages?
