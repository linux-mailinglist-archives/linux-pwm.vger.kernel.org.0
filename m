Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACEF2A8029
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 14:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbgKEN5a (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Nov 2020 08:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730676AbgKEN5a (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Nov 2020 08:57:30 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A9DC0613CF;
        Thu,  5 Nov 2020 05:57:30 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id v144so2385762lfa.13;
        Thu, 05 Nov 2020 05:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+oB95VM8Zw9gIAt2FC+TShAF+0gIWo5rt3Q41RXJdtg=;
        b=k7qYU/S7xIQk2jr0RN0b4YX8DQl0u0bLGIF7BIO03i9ysBwBpKDn2MliLppMdD912h
         r6BgWfzuRYtSE1eLkUMnbUB/BLsLo+YvOQfwlkgKibkMcVVi1isY/5BggTofJ/y1r0Hm
         YXTNppZyodPQYF16UO3KTj5p7F89cfzPcpONsMTDz0kZoeDG8Fx0XGembDMrW3FuOzXM
         jio/WB6mh7LmvjaKoQD27SeVDVB1tKJaInHuJOCXUkAdoOyzgiBYOsX/YjAtCKwJlQaR
         K889lN9RvZfHHalw/0sSwWgdKgiFdf9q8dpTy6GIkWbl3kBPpBC5N6gEirv5uxbLGA/i
         qy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+oB95VM8Zw9gIAt2FC+TShAF+0gIWo5rt3Q41RXJdtg=;
        b=LAkh9c++vmxJSnAXiB1xqhPTXTn4TfINks8xtjJrUNHlePux9cmmeS4SC1vlOwc8l/
         ehqkGpMEQX+IQm1iXV93wYKT4g4sTMvY60FrJe8GisSeHEAngbYqqpvV3MtBmp8fZ4J7
         rzjoeOT5Dmr9wWWtre/PV2Ua/rOK+hPSvcemCCVAn4pda4AVGHA2BFLQGSEiRjjort9V
         VBq1zEshzON1llta0pWrh3y7lgWwncfabTlglAHjaqJBjpUgl9on4O27cfQwdL4eTTr2
         5pcSalCBNF5vNYUrjiMVoSpFN8+5Yjqe4k3eUl6R+da2N/yt98idovbJguXX7SHXvXuT
         SkGQ==
X-Gm-Message-State: AOAM532INXx3qDpNEcKJGdVzbINt3P4Kv0OXpx6pJnrFHLljH6WpoIjg
        D++7dtqY1W3HwUcF/z1IO/DUgke/eBg=
X-Google-Smtp-Source: ABdhPJy8aDH+pQWACig1gxUeRAo9xbkzKXDLndcNZHc3MgeMS7MQorfWYcYeqkisehyHHQbAhHZsRw==
X-Received: by 2002:ac2:522a:: with SMTP id i10mr1023516lfl.128.1604584648429;
        Thu, 05 Nov 2020 05:57:28 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.googlemail.com with ESMTPSA id h10sm158920ljj.116.2020.11.05.05.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 05:57:27 -0800 (PST)
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
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
 <20201105014502.GB17266@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <60e6ea6b-3a02-30a1-f0c9-d33ef7906ed6@gmail.com>
Date:   Thu, 5 Nov 2020 16:57:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105014502.GB17266@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

05.11.2020 04:45, Michał Mirosław пишет:
> On Thu, Nov 05, 2020 at 02:43:57AM +0300, Dmitry Osipenko wrote:
>> Introduce core voltage scaling for NVIDIA Tegra20/30 SoCs, which reduces
>> power consumption and heating of the Tegra chips. Tegra SoC has multiple
>> hardware units which belong to a core power domain of the SoC and share
>> the core voltage. The voltage must be selected in accordance to a minimum
>> requirement of every core hardware unit.
> [...]
> 
> Just looked briefly through the series - it looks like there is a lot of
> code duplication in *_init_opp_table() functions. Could this be made
> more generic / data-driven?

Indeed, it should be possible to add a common helper. I had a quick
thought about doing it too, but then decided to defer for the starter
since there were some differences among the needs of the drivers. I'll
take a closer look for the v2, thanks!
