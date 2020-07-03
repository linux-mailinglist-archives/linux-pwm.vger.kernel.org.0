Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681FF213F0C
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgGCSBh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:01:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44210 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGCSBg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:01:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id by13so18617843edb.11;
        Fri, 03 Jul 2020 11:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L654+zJ/cvi5hSUqjWMCahBJf+AXAvhkOW6yFKhe6hc=;
        b=K+38WWACAz/1EKo9UVbosHX0mHKSaqhaHjxoqHoefwr3S3dct6OvfYgGogjParos/l
         gXcQ5FMNH3PAj8O9N4xTYOWI3g46cVsdzcSz7iRFgfuhJrxsLZ1AbcC11QUdg1Zxb+OF
         wjjDQVzJA+5L4rpS3RyMEIxYMR9VuLG7ORokTWbC+/dbj0c3+/3oA8yQ+xQvjwSTKjEz
         6F8NH3D8kKqUaxR6+jO2iH2EmASVNX5w5jbwoYVISkjdFpWul9qUog9kVeuZbxZGezYL
         5Qwvk+LlfR0k4Z7kIlc0IH9lGWeISXW2ild0a/mmIbMnx46aUPZz+qwsku0g+MCpSHfR
         7V/A==
X-Gm-Message-State: AOAM530p54tzIHcCw52G0HftQBkcVOiQy+bz39FercKNhbyau/+HtzLg
        pIODgOG/X0+G4usuMxS/yjc=
X-Google-Smtp-Source: ABdhPJyaDF8+Dw77XnoL7zyQ1R/DJEv9s2bcBAZgxjp3WPqCiJjnOds3jiUHTCEIw3Pv/1UeZ2jUnw==
X-Received: by 2002:a05:6402:1a3c:: with SMTP id be28mr31952326edb.140.1593799294552;
        Fri, 03 Jul 2020 11:01:34 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id x16sm13114933edr.52.2020.07.03.11.01.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jul 2020 11:01:33 -0700 (PDT)
Date:   Fri, 3 Jul 2020 20:01:31 +0200
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
Subject: Re: [PATCH v2 2/8] arm64: dts: exynos: Describe PWM interrupts on
 Exynos7
Message-ID: <20200703180131.GB1241@kozik-lap>
References: <20200702155149.12854-1-krzk@kernel.org>
 <20200702155149.12854-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200702155149.12854-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jul 02, 2020 at 05:51:43PM +0200, Krzysztof Kozlowski wrote:
> Add interrupts property to PWM node on Exynos7 to describe the hardware
> fully.  No functional change as the interrupts are not used by drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Correct the interrupts, change message.
> 
> Not tested
> ---
>  arch/arm64/boot/dts/exynos/exynos7.dtsi | 5 +++++

Applied.

Best regards,
Krzysztof

