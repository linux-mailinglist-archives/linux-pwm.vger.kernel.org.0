Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF4D112D988
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Dec 2019 15:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfLaOxD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 31 Dec 2019 09:53:03 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33139 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaOxC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 31 Dec 2019 09:53:02 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so35404694edq.0;
        Tue, 31 Dec 2019 06:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2o20aAqayv6BZ7lYdB775KhwnJD8SsBVJk71b0rde2E=;
        b=poRD7KZjKZr3ORNVyI2Yj3hyY1TSZPoPk95zGZ701aGlD/EuLWIYYGcQNBnu2tZ7En
         xoxgSxs5loO/fAEkWpp678V8OLrQTcgJrUFksGkGuG8BarsWWXMPvtvZE1SfXAOgejml
         SLB+9Fd0k3b41xtxmVe9f/raX5P1W249Yk2AqJ15SARoCzycZA1QzKvuIQ+3j32VCpGz
         iKSAYWHJWSCOuZVvlXBzU8wMmL0ERW8LyW2wYDIQ9WUVbotyuWLM0aScSi3rKSQVm33C
         mvV0Fo4HIPY9SHlLjH+P+IMsRlEgXN4N/aXUFYrOoO0MbtUyKTAwyLZ6UghZzNXybp5c
         gC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2o20aAqayv6BZ7lYdB775KhwnJD8SsBVJk71b0rde2E=;
        b=Xh8q1TIsG4wgo9Rh9RssxIX1DnHhdYG5wc8+9OIomne5sv0bYpsB+ccrxWUC0GaJx9
         gmT7XF0eIQfnHnRgTsOkIAUlCuun0oy2Zo8SaXVV9Uq6i6R0dw3ijoXRoIVVPaeQmLo4
         K6A+fIxxtnjv2qmm6HrHD158MbfkW3eL1HgKX2ev66iBV+nK8hSICXNhPvzgSsQ+xcQz
         IfGeAY4Rfc3KLXY4KLbc5bgXFFY2SvXc2RtQOQzKMnn+RMspcc+qj0d1hqREjXjhUWzi
         i2BdWl7LfaBn2ftQDfogWV/eSyK47l7O2/OGA5wAKFHiT9RdSrAd9UqPoS49rvOyevp0
         y9NA==
X-Gm-Message-State: APjAAAUML6nEGmz5dKebR91IJsXT8Ql7VnvyN2arOpEacUuYwvOa4Uen
        0upFGqpDgS50kf+o90YcaDbXeXLV018VSO8xg7E=
X-Google-Smtp-Source: APXvYqyRa5i9cLmMHe86c+B4Fx/pd0qP4rUcFH9Tquw1x4/LQC/Oq5YixxDbRdVtRa9R4GKVNAzhEfLEp5Lfo8kVkxk=
X-Received: by 2002:a50:bae1:: with SMTP id x88mr59378035ede.10.1577803980972;
 Tue, 31 Dec 2019 06:53:00 -0800 (PST)
MIME-Version: 1.0
References: <20191230172113.17222-1-krzk@kernel.org> <20191230172113.17222-2-krzk@kernel.org>
In-Reply-To: <20191230172113.17222-2-krzk@kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 31 Dec 2019 15:52:50 +0100
Message-ID: <CAFBinCAeE-mu4+F9vOkp3cMaGjQ7tst0xdd47zSp54wW4ArRug@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: Enable compile testing for some of drivers
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Dec 30, 2019 at 6:21 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Some of the PWM drivers can be compile tested to increase build
> coverage.
>
> The Meson PWM driver requires COMMON_CLK dependency.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
for PWM_MESON:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you!


Martin
