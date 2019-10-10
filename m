Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88163D310A
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2019 20:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfJJS6n (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Oct 2019 14:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfJJS6n (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 10 Oct 2019 14:58:43 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1707921A4C;
        Thu, 10 Oct 2019 18:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570733922;
        bh=C3qJQMyjD9A/GMvJ52P6U8GDKE7BNVgB4aq0nJUK3Tc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x9hnp5Xo4bB1M1JWF8/BAZab4UX1ziPUvnFgk/cPG/ZALiC2ezbfWSIK9WfrWnqxU
         Be8N6AeS7oihMOahkrPHOI0whlDuASFXutW+vuKo6b1R/NAzZ/WsV5JfutdIEk6dPX
         j9KYoQjQg6HQBC03nBIRN41NzOebPx9rSvB/Ja9M=
Received: by mail-qt1-f177.google.com with SMTP id u22so10191384qtq.13;
        Thu, 10 Oct 2019 11:58:42 -0700 (PDT)
X-Gm-Message-State: APjAAAVqRBt4bt3+kUUFtpO7U2m7AMN1L0HkGkkkM4yfZujz4GH8b8vE
        pXK4jAaS5sqRVIm8Lxj0dZZrXCyZyApkQHIG2w==
X-Google-Smtp-Source: APXvYqzB5TzRKwoOcFcNVQukkGMmMU2iFIhyKCekwRBNJHWn3GTHP/CmHznLTqw+AnmCr8x0PiE1VBXV/9mGgldc2YU=
X-Received: by 2002:ad4:5044:: with SMTP id m4mr12009044qvq.85.1570733921147;
 Thu, 10 Oct 2019 11:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191002164047.14499-1-krzk@kernel.org> <20191002164047.14499-2-krzk@kernel.org>
In-Reply-To: <20191002164047.14499-2-krzk@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 10 Oct 2019 13:58:30 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Fa1+epSvDpSx4NdzOUohoJR+qR3-xyMTTw4LaOK7AbQ@mail.gmail.com>
Message-ID: <CAL_Jsq+Fa1+epSvDpSx4NdzOUohoJR+qR3-xyMTTw4LaOK7AbQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: pwm: Convert Samsung PWM bindings to json-schema
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 2, 2019 at 11:41 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Convert Samsung PWM (S3C, S5P and Exynos SoCs) bindings to DT schema
> format using json-schema.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v2:
> 1. Add additionalProperties: false.
>
> Changes since v1:
> 1. Indent example with four spaces (more readable),
> 2. Fix samsung,pwm-outputs after review,
> 3. Remove double-quotes from clock names.
> ---
>  .../devicetree/bindings/pwm/pwm-samsung.txt   |  51 --------
>  .../devicetree/bindings/pwm/pwm-samsung.yaml  | 109 ++++++++++++++++++
>  2 files changed, 109 insertions(+), 51 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
