Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCCD3EF7E4
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Aug 2021 04:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbhHRCH7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Aug 2021 22:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbhHRCH5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Aug 2021 22:07:57 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B294C061764;
        Tue, 17 Aug 2021 19:07:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w4so644021ljh.13;
        Tue, 17 Aug 2021 19:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZdWGOBRulL4VUr2nkxtGmp68zHpJN18S3Cy3ExunZB8=;
        b=ZbJ4H3eCNv1Bvw3hVzD9YPDeNyOTQ/GmXBdTT71urRvt/nxoTwLH1fzA/K6qn+n13V
         EMyJFOcQBAXmK3unujC0pekGKV+GhAYdJyvRHdQzj7rWIPi7xVLg/WMJcPcQ5PirKj3r
         mCWcJAQa780CvmoxoDAaM90aUyQvNJACNApvjKFPAAm9WwsGGlEyD1f2fvSTTM9fYxeK
         t5Z+FLcqvZcqhqpvPAUYUBL8uyZLNwpVWq6XOlWr029EcHcHjhy6C69qNnGWOe53OGMD
         UD0ZHK+jZlCvKxlNNnLY/8mNCqP91QRuXBKGfyt7TpkAkHcvIpzE8oPTRJStoeU2i7/F
         OFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZdWGOBRulL4VUr2nkxtGmp68zHpJN18S3Cy3ExunZB8=;
        b=IJviccCdFwT+KoMnlqEoCg7Us869jV85n22YQtA5Q6ILVQHVn8KYbaRjYw8/Mjalk3
         HnlJMj5bEc2bcJaw4KKYg1fdCbnBDpen0uV4fP7tWMpuEeT965SG1QPqTJE6dUmqF6g/
         ffZsl6Li5SVd7hxfENwsSEVONMOgQE05s6XUtJMDutlyFTSeKXd6H6Jy6ukS8TBB/6tz
         P7Jjrj84BjD+JL7elTiMq3UamdI/YV/k/JZG8iDTl23xcxBm8ygOEMPXIdUSFjR3qkaj
         0na7JQCzWoRDQtGyQeN4dgPbbXem0n+2wE186Uhj1KoFciI8RY7TyPVdgd91+ALMfRsi
         G/3w==
X-Gm-Message-State: AOAM530a5pyWArEVjR7lkY62q30zaHyZOABlML5OeI6Yv5PjjiXxTVKa
        EDQXD6+pnadARhzmF8/pXayny/RpQHI=
X-Google-Smtp-Source: ABdhPJxciZnUMzd7GVFJFA8FMA0hGtsUp4JHBzMUe6n55lLwaZhk7ErG9OStqzAcGbzrvom9TXW02A==
X-Received: by 2002:a2e:9256:: with SMTP id v22mr5752535ljg.150.1629252441273;
        Tue, 17 Aug 2021 19:07:21 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id 27sm353157lfz.146.2021.08.17.19.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 19:07:20 -0700 (PDT)
Subject: Re: [PATCH v8 09/34] dt-bindings: host1x: Document Memory Client
 resets of Host1x, GR2D and GR3D
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20210817012754.8710-1-digetx@gmail.com>
 <20210817012754.8710-10-digetx@gmail.com>
 <YRxfWJJ6+1GgVs33@robh.at.kernel.org>
 <fa9a1fb7-8a87-de1a-e40a-fdc4f4d05d57@gmail.com>
 <9deced25-b184-7b5b-cebf-0ad82bd959db@gmail.com>
Message-ID: <7f35b432-d113-99fa-88ca-20601ccf7e04@gmail.com>
Date:   Wed, 18 Aug 2021 05:07:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9deced25-b184-7b5b-cebf-0ad82bd959db@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

18.08.2021 05:04, Dmitry Osipenko пишет:
> 18.08.2021 04:37, Dmitry Osipenko пишет:
>> 18.08.2021 04:16, Rob Herring пишет:
>>> On Tue, Aug 17, 2021 at 04:27:29AM +0300, Dmitry Osipenko wrote:
>>>> Memory Client should be blocked before hardware reset is asserted in order
>>>> to prevent memory corruption and hanging of memory controller.
>>>>
>>>> Document Memory Client resets of Host1x, GR2D and GR3D hardware units.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  .../bindings/display/tegra/nvidia,tegra20-host1x.txt          | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
>>>> index 62861a8fb5c6..07a08653798b 100644
>>>> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
>>>> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
>>>> @@ -18,6 +18,7 @@ Required properties:
>>>>  - resets: Must contain an entry for each entry in reset-names.
>>>>    See ../reset/reset.txt for details.
>>>>  - reset-names: Must include the following entries:
>>>> +  - mc
>>>>    - host1x
>>>
>>> New entries should be at the end. Order matters.
>>
>> Indeed, order matters. In this case it matters by the hardware because
>> memory reset must be asserted before the controller's reset. We rely on
>> it in the code of the GENPD driver. Hence it's the intended order in
>> this patch.
>>
> 
> Although, my bad. It should be to reorder items here, it's not a GENPD
> binding.
> 

* should be fine

I'll change it in v9.
