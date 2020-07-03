Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E740213F05
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgGCSBX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:01:23 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:39845 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGCSBX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:01:23 -0400
Received: by mail-ej1-f67.google.com with SMTP id w6so35163334ejq.6;
        Fri, 03 Jul 2020 11:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YageHdHnDETUH0WwG8/ZR5delr/Q4EUevxKHi51xHZM=;
        b=Oj45A+o5SLrXa1sAWh00l6N0XEQK49KYP/UymvnhaXbXjSOVjQmPusO4vHEwshJKc6
         CHpvnQ5SoiRADtyFusMHD+Iy3ep5UA9DafB9dtVoVMJ4QFD0jj+uIm03tvEiLZBF8qN3
         2gdpoaeA5Uq8ToUHhXfxl7p2ZAFeDk0z1TGbXAe5R7tKA+iL950kv4k8ecyEC5vLJ/65
         J1VueQc/pxI0Rjn0qGZN8GcphI74u31i83VsibbgHx17lKYIEOAhZm3dwWAahmvHZu06
         UGtOYQgGL5Qx6l+dp9bpmpxpp7hZ0lK7VLOAUPdTRwBq6Z2GDr9OJTfHczbYKTXT14lZ
         PyUw==
X-Gm-Message-State: AOAM53335MaH52GFvF70iT5J0VFgL97wE3cESdoXAdisjyZnYLI0XPEA
        Gb8CiKfqn43S5s2ieXiX2gQ=
X-Google-Smtp-Source: ABdhPJwyz/pyBEbw295xSe8DvR03m0H2mpqxsylPLSbujJ36/MYAlzcJjyg7zpwwv//h3eWK2oJrNQ==
X-Received: by 2002:a17:906:5657:: with SMTP id v23mr34429394ejr.196.1593799280892;
        Fri, 03 Jul 2020 11:01:20 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id y7sm9779927ejd.73.2020.07.03.11.01.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jul 2020 11:01:20 -0700 (PDT)
Date:   Fri, 3 Jul 2020 20:01:17 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH v2 3/8] arm64: dts: exynos: Remove generic
 arm,armv8-pmuv3 compatible
Message-ID: <20200703180117.GA1241@kozik-lap>
References: <20200702155149.12854-1-krzk@kernel.org>
 <20200702155149.12854-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200702155149.12854-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jul 02, 2020 at 05:51:44PM +0200, Krzysztof Kozlowski wrote:
> The ARM PMU node is described enough with first compatible so remove the
> arm,armv8-pmuv3 to fix dtschema warnings like:
> 
>     arm-pmu: compatible: Additional items are not allowed ('arm,armv8-pmuv3' was unexpected)
>     arm-pmu: compatible: ['arm,cortex-a57-pmu', 'arm,armv8-pmuv3'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. None
> 
> Not tested although no effect expected.
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 4 ++--
>  arch/arm64/boot/dts/exynos/exynos7.dtsi    | 2 +-

Applied.

Best regards,
Krzysztof

