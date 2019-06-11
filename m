Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C8B3D768
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jun 2019 22:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406413AbfFKUCa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Jun 2019 16:02:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42734 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405168AbfFKUCa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Jun 2019 16:02:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so14358570wrl.9;
        Tue, 11 Jun 2019 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jIebUp4XY7WW1bkNEqW8SSNqGZE7schYtfqUjB6l7k0=;
        b=rjjq2BYL90EBCSL/toQeCzvvX7/mr3CT8wNVZ5RrUf9C4iHpBbLWDEbfYOZEJ8Pj4q
         NNEdrItqug1NOkCSsrAgG3RaVp1IDaUsD0EY9yUcqX03AYR0uvQg3SEa/rIVUCmk79ik
         AUaWNObvhnMKupRn+GrK6NbovbCK4c93D2eYGYLq2NMisxYK0gmviqStYYoaCInLvwoS
         ik0rmfpNNqQwh1zguzJdUG/zHLIIJ0/L6Trutr9hHDGjdTk/wevjQxUE5vaWeo1qkqp4
         l3sv1kswS2B88HLMkiLSc+8+51SEKiFcExDiVLbfATNMmV/gP5sCngr3zpwjKPHwn3nL
         R5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jIebUp4XY7WW1bkNEqW8SSNqGZE7schYtfqUjB6l7k0=;
        b=TU8/9X8q45s9/pST0eKSUdFK3+9WU4fAih+5Q6S0D45/ZDXZ8cHp4vzCvuYTRc2abu
         Oq6msR/rcm4SK2L2+Lcm9GCpKJODtT4TcFeiUra94oAlbClftJQPZ5Ae6VuZ4v5sT5Ii
         xFdnhEov8SE0i/1jY+VwdiBsXbasERgUDiIWyB73wuCQj5C3UlxN4TEb8xmH/eCdjEfh
         wtOW7tegqQX4rqgeFYFVRMHfWjleSladE5xu7RC/h4lfu5WOljyoLmUx7adXeNJwvsAa
         rsEdX0nhyqXY0KG6c+9vy/0BQVkF+/vZW8T9p1H2IWSrZFKQPUZtfQKYWxzBgSgd4p7f
         6f5g==
X-Gm-Message-State: APjAAAVQZamUDF+ZZZjQXQTF4x7/rEzt8R1y6dMuBAtOwN5Of/B07Rk9
        E7ijiwvC6wnSAW4GkBnnhUs=
X-Google-Smtp-Source: APXvYqy69Nttw3VJy9kpldo/q2sr2jjcjp5IQcHqdojuXnECS/X413h3T3E/IrANMshlTYRLwEAwbA==
X-Received: by 2002:adf:e60f:: with SMTP id p15mr5340510wrm.332.1560283348311;
        Tue, 11 Jun 2019 13:02:28 -0700 (PDT)
Received: from [192.168.1.17] (bgt97.neoplus.adsl.tpnet.pl. [83.28.83.97])
        by smtp.gmail.com with ESMTPSA id t15sm6862774wrx.84.2019.06.11.13.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 13:02:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: pwm-backlight: Add 'max-brightness'
 property
To:     Matthias Kaehlcke <mka@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
References: <20190610233739.29477-1-mka@chromium.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <00220cd7-ed4b-5250-d448-cf83ed4c2012@gmail.com>
Date:   Tue, 11 Jun 2019 22:02:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610233739.29477-1-mka@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Matthias,

On 6/11/19 1:37 AM, Matthias Kaehlcke wrote:
> Add an optional 'max-brightness' property, which is used to specify
> the number of brightness levels (max-brightness + 1) when the node
> has no 'brightness-levels' table.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>   .../devicetree/bindings/leds/backlight/pwm-backlight.txt       | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> index 64fa2fbd98c9..98f4ba626054 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> @@ -27,6 +27,9 @@ Optional properties:
>                               resolution pwm duty cycle can be used without
>                               having to list out every possible value in the
>                               brightness-level array.
> +  - max-brightness: Maximum brightness value. Used to specify the number of
> +                    brightness levels (max-brightness + 1) when the node
> +                    has no 'brightness-levels' table.

In the LED subsystem we have led-max-microamp property which seems to
better describe hardware capabilities. It says just: this is the current
level the LED can withstand. max-brightness does not implicitly convey
this kind of information.

Why the need for the property at all? If for the reasons other than
hardware capabilities than it should be more likely handled
by userspace.

>   [0]: Documentation/devicetree/bindings/pwm/pwm.txt
>   [1]: Documentation/devicetree/bindings/gpio/gpio.txt
> 

-- 
Best regards,
Jacek Anaszewski
