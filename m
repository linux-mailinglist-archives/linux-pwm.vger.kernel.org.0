Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B5E2B1F47
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Nov 2020 16:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgKMPzh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Nov 2020 10:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMPzh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Nov 2020 10:55:37 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D450BC0613D1;
        Fri, 13 Nov 2020 07:55:36 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id z21so14481633lfe.12;
        Fri, 13 Nov 2020 07:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4/bF4c42U9QIMTb1QGxEpNjGgqxOXHed/9Sju++TrnQ=;
        b=EmXWyr9gx7KS0zwcEBEAYUaxurDUV3ESqpMaCg9JaE9hKPHdsMyptRiU0PhucAJg57
         sWNit+5QfNq8tNVIqx46BqCocNtjeJXbt4jKtikifYsjkdUQbLjXrnxr9qkxjgZRyZHq
         TXlCW0/ciAaZVvMnyVhuZxC2ijNcNkBjiAcv9bDzbBMXnusu37wDsDL7NY0jYqQtA3vp
         PIgR17yr3IOJzvWiye1+iRzAfcIGWQeDEi+egnXgCSnrSt/IzJcPeOgFOq4e5cJTdOLu
         hhiAHxxwDWXN0pyDhoMxZJHVC4zrdnmiTI5ssYzWwy6ojWuvzKDNpVu8jf2LV7apAlp+
         bE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4/bF4c42U9QIMTb1QGxEpNjGgqxOXHed/9Sju++TrnQ=;
        b=jLRCFJSC4LVQ9WUs0yyiPmszK0QoY8YTndx9qxhP7JieDaEOoVb7/5Q4bm9Ixtw234
         Dmv8ZtdjxT/weu7ooPJ5y3z4mQZ+snejT4TCqfrUaLr/rOpV1ToXrKAMZNByJtBrfCtl
         rXNIS995/TntlTPElbGrtLPiqud00YolaGtAG36hdxiKfVHdX6C2m5kulga60M/ENZht
         ghOP4O+oZSkGg6i3KhvqLQSgtTWG4SlWr4c3xbFIE7+AV3VcZjY3J2pcF624IsSnvgjF
         1tDyhJhlUb4Rl6bZad2Bg7MQCorE1nw5/sY7C8eIymiAqu1GQAFUfzXyuGL7jSFGL61u
         pYHg==
X-Gm-Message-State: AOAM533NWPiXoKqarqfKC62EiffB3h7RIxxrSOL1pfzP4Ku0h7RXCAfl
        X+vxbkC0cs0b8oKwmuOwzJOzBxp0/FE=
X-Google-Smtp-Source: ABdhPJw1/12loswbdkPkD8Zhl2Yvb+Tjd/1tqW0mRR71ohF0rznxZ7TNEV0H6NcysfGbIqHPuGQf6Q==
X-Received: by 2002:ac2:5503:: with SMTP id j3mr1281724lfk.94.1605282930190;
        Fri, 13 Nov 2020 07:55:30 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id v12sm1474128lji.3.2020.11.13.07.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:55:29 -0800 (PST)
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
References: <20201104234427.26477-12-digetx@gmail.com>
 <20201110202945.GF2375022@ulmo> <20201110203257.GC5957@sirena.org.uk>
 <72ae6462-13df-9fcb-510e-8e57eee0f035@gmail.com>
 <20201111115534.GA4847@sirena.org.uk>
 <dd26eb18-8ac4-22a6-29b0-dbbe5fa6075b@gmail.com>
 <20201112171600.GD4742@sirena.org.uk>
 <b4b06c1d-c9d4-43b2-c6eb-93f8cb6c677d@gmail.com>
 <20201112200123.GF4742@sirena.org.uk>
 <ce9e2d9f-917e-fb8a-7323-f3bf1a367e9d@gmail.com>
 <20201113142937.GB4828@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7f066805-97d9-088f-e89d-a554fe478574@gmail.com>
Date:   Fri, 13 Nov 2020 18:55:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201113142937.GB4828@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

13.11.2020 17:29, Mark Brown пишет:
> On Fri, Nov 13, 2020 at 01:37:01AM +0300, Dmitry Osipenko wrote:
>> 12.11.2020 23:01, Mark Brown пишет:
>>>> But it's not allowed to change voltage of a dummy regulator, is it
>>>> intentional?
> 
>>> Of course not, we can't know if the requested new voltage is valid - the
>>> driver would have to have explict support for handling situations where
>>> it's not possible to change the voltage (which it can detect through
>>> enumerating the values it wants to set at startup).
> 
>>> [Requesting the same supply multiple times]
> 
>> But how driver is supposed to recognize that it's a dummy or buggy
>> regulator if it rejects all voltages?
> 
> It's not clear if it matters - it's more a policy decision on the part
> of the driver about what it thinks safe error handling is.  If it's not
> possible to read voltages from the regulator the consumer driver has to
> decide what it thinks it's safe for it to do, either way it has no idea
> what the actual current voltage is.  It could assume that it's something
> that supports all the use cases it wants to use and just carry on with
> no configuration of voltages, it could decide that it might not support
> everything and not make any changes to be safe, or do something like
> try to figure out that if we're currently at a given OPP that's the top
> OPP possible.  Historically when we've not had regulator control in
> these drivers so they have effectively gone with the first option of
> just assuming it's a generally safe value, this often aligns with what
> the power on requirements for SoCs are so it's not unreasonable.

I don't think that in a case of this particular driver there is a way to
make any decisions other than to assume that all changes are safe to be
done if regulator isn't specified in a device-tree.

If regulator_get() returns a dummy regulator, then this means that
regulator isn't specified in a device-tree. But then the only way for a
consumer driver to check whether regulator is dummy, is to check
presence of the supply property in a device-tree.

We want to emit error messages when something goes wrong, for example
when regulator voltage fails to change. It's fine that voltage changes
are failing for a dummy regulator, but then consumer driver shouldn't
recognize it as a error condition.

The regulator_get_optional() provides a more consistent and
straightforward way for consumer drivers to check presence of a physical
voltage regulator in comparison to dealing with a regulator_get(). The
dummy regulator is nice to use when there is no need to change
regulator's voltage, which doesn't work for a dummy regulator.
