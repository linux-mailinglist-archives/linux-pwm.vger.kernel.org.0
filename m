Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0191B9585
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2019 18:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391159AbfITQX4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Sep 2019 12:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388479AbfITQX4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 20 Sep 2019 12:23:56 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6B5721882;
        Fri, 20 Sep 2019 16:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568996635;
        bh=SDWrzZuVG71v0J2X6nPbnKE1kFEZUtHXnpXPTYAQdcM=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=Y0NPYxXS5lxvCc5BrOJBS+38DHx4Vw4tGLuccuPjWhQHZjLN1+SP2QJbwffe6Fo6R
         SGaBxYr0YFTOcZZ74KP24FDLyP9h6k+pQ2VXu9tF4gCqFBfBD4s3DyPTPENUcLZ1/t
         wlNhYEZpL/2F2pyw54AFDUqkleli+20BjzwXfEhY=
Received: by mail-ot1-f52.google.com with SMTP id g13so6665160otp.8;
        Fri, 20 Sep 2019 09:23:54 -0700 (PDT)
X-Gm-Message-State: APjAAAUCuy/u1YNhM7UeufgJOQkz3xHxAarqU3FarpNdvQ8qgvTl0NPW
        aJJ0pKtxXvVhqUHS4LjkIkKkYoDrCP9QP9RJFjQ=
X-Google-Smtp-Source: APXvYqzVXOyysg9607AyFbe3o2oRNE6mFVRauJhZAfa1N2RVl6I/Rt2f5iakVGo4VwLzm014Px6jKLwO2nAgy6rn4nA=
X-Received: by 2002:a9d:6c9a:: with SMTP id c26mr12313571otr.241.1568996634274;
 Fri, 20 Sep 2019 09:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190918173141.4314-1-krzk@kernel.org> <20190918173141.4314-5-krzk@kernel.org>
In-Reply-To: <20190918173141.4314-5-krzk@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 20 Sep 2019 18:23:41 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfQFg5wC-JcHUs8btYJRfpC=NW2FOpWTHkTD6zekzHV0A@mail.gmail.com>
Message-ID: <CAJKOXPfQFg5wC-JcHUs8btYJRfpC=NW2FOpWTHkTD6zekzHV0A@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] dt-bindings: watchdog: Convert Samsung SoC
 watchdog bindings to json-schema
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-crypto@vger.kernel.org, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 18 Sep 2019 at 19:32, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Convert Samsung S3C/S5P/Exynos watchdog bindings to DT schema format
> using json-schema.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Indent example with four spaces (more readable),
> 2. Remove unneeded timeout-sec description.

Superseded by v3 (although named v2...).

Best regards,
Krzysztof
