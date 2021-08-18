Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F280B3F09B5
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Aug 2021 18:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhHRQ5t (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Aug 2021 12:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbhHRQ5n (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Aug 2021 12:57:43 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CE7C061764;
        Wed, 18 Aug 2021 09:57:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p38so6111546lfa.0;
        Wed, 18 Aug 2021 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9afXLHEiBRvQw+FqKQqGWY2brD9XGx9hPAmFRANM6E0=;
        b=SkFjeie1BejmJMUfsJJa7cdKxHWnbIqV6yEx50leCh45/lOA2mtYHIhF2YuT+/qxMT
         Kz4yDrQ39Ns52bpJRJ1nvYNdeOrbzSvGNVDSFXOIEZy/5g8lF1kLMJksTgXPJ8QmjHcg
         iB+julVaTc7z/7axFMQXOnE7a569YrihqMFwkdkfwrYA1Olh6EVmg/hGR1JfF7Bo+IzT
         5pn2hximEzVhmBcizH/3kj9vKvVTct62o0rKSGlLwd0/7BGb0XQ+by7ZLMa2P8L4PJg+
         efMjguZzhJdMSLcJQv1Pv0yiP3TQGVx4otwdNVArVuo1hHYq6zxbh/irwSRReTHHDhIg
         HoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9afXLHEiBRvQw+FqKQqGWY2brD9XGx9hPAmFRANM6E0=;
        b=tD/Umr9dTSkop2zTtRdV7TcHbWWlaXs4KlMb7g8Vib1GLiIjZ7INO8VFnRT9o3oill
         mMteg4ycFSzW1AhgTx+gXlTbtYmiQhDN4B1EUSqaVkhuCiNpId2g20uyxiJm93ZU7Js6
         pUlSjaPzKFc49zNHsrt5DJ2ZE9+EvGGyuRG+8N+H3ixJdnAwEV3SFc7REMQ8RmMrHs4d
         tVMnRrcquIPCtHf64kp+Zs/OZfm7IiOl6tC1d6iTpxpovkKOYFLWvT9euT/gimBsGJfk
         upyP1ndZi/0flC2Rs7Sqv+RilIVJkS8rbZWRmcN/WHZ0BNSSfovgdApxlnYZqNaY089e
         oenw==
X-Gm-Message-State: AOAM5326V9bgmzHehg2E+0mByYDSFx807PjfcEJ8OgywcYtObjZKFhwk
        LxWfC1g3wq816+FUIWRU02x4qPwQ6bA=
X-Google-Smtp-Source: ABdhPJwoN3TrpzatYdR/vf/doNTOb6j8sY8QLs5kbR7gHEbbr6h18EW7bx2EM9tVNh0BF01dlvfX6g==
X-Received: by 2002:a19:701a:: with SMTP id h26mr6902287lfc.443.1629305825693;
        Wed, 18 Aug 2021 09:57:05 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id f19sm24809lfu.100.2021.08.18.09.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 09:57:05 -0700 (PDT)
Subject: Re: [PATCH v8 06/34] dt-bindings: clock: tegra-car: Document new
 tegra-clocks sub-node
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
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
 <20210817012754.8710-7-digetx@gmail.com> <YR0SSz7KMh7TwaFW@orome.fritz.box>
 <eff5ef47-e6e0-3e03-cf1a-d931b0f2dc2a@gmail.com>
 <YR033zuYWWLCeYpM@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a5b942cb-1611-9ae1-6e89-4b68fdaf03e3@gmail.com>
Date:   Wed, 18 Aug 2021 19:57:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR033zuYWWLCeYpM@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

18.08.2021 19:39, Thierry Reding пишет:
>> We don't have a platform device for CaR. I don't see how it's going to
>> work. We need to create a platform device for each RPM-capable clock
>> because that's how RPM works. The compatible string is required for
>> instantiating OF-devices from a node, otherwise we will have to
>> re-invent the OF core.
> I think we do have a platform device for CAR. It's just not bound
> against by the driver because these clock drivers are "special". But
> from other parts of the series you're already trying to fix that, at
> least partially.
> 
> But it doesn't seem right to create a platform device for each RPM-
> capable clock. Why do they need to be devices? They aren't, so why
> pretend? Is it that some API that we want to use here requires the
> struct device?

The "device" representation is internal to the kernel. It's okay to me
to have PLLs represented by a device, it's a distinct h/w by itself.

CCF supports managing of clock's RPM and it requires to have clock to be
backed by a device. That's what we are using here.

Please see
https://elixir.bootlin.com/linux/v5.14-rc6/source/drivers/clk/clk.c#L109

>>> Also, I don't think the tegra- prefix is necessary here. The parent node
>>> is already identified as Tegra via the compatible string.
>>>
>>> In the case of CAR, I'd imagine something like:
>>>
>>> 	clocks {
>>> 		sclk {
>>> 			operating-points-v2 = <&opp_table>;
>>> 			power-domains = <&domain>;
>>> 		};
>>> 	};
>>>
>>> Now you've only got the bare minimum in here that you actually add. All
>>> the other data that you used to have is simply derived from the parent.
>> 'clocks' is already a generic keyword in DT. It's probably not okay to
>> redefine it.
> "clocks" is not a generic keyword. It's the name of a property and given
> that we're talking about the clock provider here, it doesn't need a
> clocks property of its own, so it should be fine to use that for the
> node.

I'm curious what Rob thinks about it. Rob, does this sound okay to you?
