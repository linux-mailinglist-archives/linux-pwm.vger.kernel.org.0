Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C47AA90501
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Aug 2019 17:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfHPPyX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Aug 2019 11:54:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36881 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfHPPyX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Aug 2019 11:54:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id z11so2002196wrt.4
        for <linux-pwm@vger.kernel.org>; Fri, 16 Aug 2019 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rjwwQvzZbTAd0PumZ0fpI2ighfSvLNEfTeslgBS5o3c=;
        b=zen5hFriKrgrhQt7tOYMXw7q1geHpYj6bLTDvLzZgHS0RFMztkPu7eDcJ4HcIIRAC1
         hTOFeDGYZJGX1SduUZSPtAMY4MkoCurIJoEpeCyQmGXOzkqkx0eF/BYnoJx1htseHBTl
         B22l2v/Fop1oAl5vXRu6cyfUmoLJ+ZbHwP1fj2+vbjLiYnukTeWjb+s/V3FjHnYGlG2P
         yYQ9qOQpjRFYJY/douTgJDCGa+t1O6dJ5seBUADnRGBkVeOodHv0EbUYtzkahW06UXqR
         2UEr841WsMPDcTXJccy8ruUHjE/gih5Rvnw0gMduC4KP3KoUn5co2MFMaFUI37r4nR4Q
         I+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rjwwQvzZbTAd0PumZ0fpI2ighfSvLNEfTeslgBS5o3c=;
        b=th4BKWCm8gZQmV0trPEpezOVWoQe8zoBxISTxBCjA8j1vyvP+fn51u1u+CrYEy87WY
         pUR0GDebPnAb5oFBY7Mjoro7yq7hg4HdxtrXAIVQe1+lhkfuqBm1FN5NW/CBrnDJ6Q1r
         nB2FRWmMzvz+qL9b52nwqUZgacfLeFn1gfSIF2IEeSpD1TEg8arkhI8DLW5fTm+7yMW2
         uq9XamWsmNBqIURQbxi9srcbUyZrP2OglG992dV/Wm1ZfF4vgwRGqVszJrGYZfid2OcX
         hrZWh0+ge3sqRMtzAJgWo6MKWLbI4/EY1QOvEzt1UnUvVeepohMqhCpImIxIdk2sdKLv
         8+JQ==
X-Gm-Message-State: APjAAAXlVSVCyPxu4vHpu/FIk7R5JVjUyxMZnCCz6rbDx4xBnVLK65on
        V0JFCfZFPOh719YpR5tzvIz7ouDx8XG9Fg==
X-Google-Smtp-Source: APXvYqyQJCwfn9usponeAbAoxdPMgcDAMy29vLoOMKWyIeyL5+AvPp3pVd4OiYXh5ns0XltF0conlw==
X-Received: by 2002:a5d:4946:: with SMTP id r6mr12650102wrs.266.1565970860895;
        Fri, 16 Aug 2019 08:54:20 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id a64sm5352000wmf.1.2019.08.16.08.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 08:54:19 -0700 (PDT)
Subject: Re: Re: [PATCH v3 2/4] backlight: Expose brightness curve type
 through sysfs
To:     Matthias Kaehlcke <mka@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190807201528.GO250418@google.com>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <510f6d8a-71a0-fa6e-33ea-c4a4bfa96607@linaro.org>
Date:   Fri, 16 Aug 2019 16:54:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807201528.GO250418@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 07/08/2019 21:15, Matthias Kaehlcke wrote:
> On Tue, Jul 09, 2019 at 12:00:05PM -0700, Matthias Kaehlcke wrote:
>> Backlight brightness curves can have different shapes. The two main
>> types are linear and non-linear curves. The human eye doesn't
>> perceive linearly increasing/decreasing brightness as linear (see
>> also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
>> linearly to human eye"), hence many backlights use non-linear (often
>> logarithmic) brightness curves. The type of curve currently is opaque
>> to userspace, so userspace often uses more or less reliable heuristics
>> (like the number of brightness levels) to decide whether to treat a
>> backlight device as linear or non-linear.
>>
>> Export the type of the brightness curve via the new sysfs attribute
>> 'scale'. The value of the attribute can be 'linear', 'non-linear' or
>> 'unknown'. For devices that don't provide information about the scale
>> of their brightness curve the value of the 'scale' attribute is 'unknown'.
>>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Daniel (et al): do you have any more comments on this patch/series or
> is it ready to land?

I decided to leave it for a long while for others to review since I'm 
still a tiny bit uneasy about the linear/non-linear terminology.

However that's my only concern, its fairly minor and I've dragged by 
feet for more then long enough, so:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

