Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31761D728A
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 10:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgERIK0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 04:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgERIKZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 04:10:25 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83775C05BD09
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 01:10:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w10so8827935ljo.0
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 01:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=em2U7B8TyUf30bEUcMzbKLuDgDBEeuKa70ZTt7cbEvc=;
        b=m1FCdPoToBswJghU2vv7XgNi/QYDpr6H1HoZ8l66YdZB6QB8h78vyCPO/e0/UGxjP6
         ZZ9EIgnMMJomAK4cszeOzFycO84gRnDipsqV03FiSgCmau5uUwee47aNVA7b3+VPi4ki
         Bgb2OQym51ongcbux98NBFutl7ayLusleUKtnyW0cJzZCeitLERQVbEOKXlyCpR3mIcf
         YhEPxn98P/gy/dhY47yCDz99uDc6z9IZswOJ99IUoNYcs33mWpgKi6C9dh932hxLWt22
         kO1po+jMFgfWYzMjO/iN1RAqobkw+LnxY7Q/1aaThEIvvI83HggVrqEHhquOQwfpTPH7
         GDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=em2U7B8TyUf30bEUcMzbKLuDgDBEeuKa70ZTt7cbEvc=;
        b=TuIDsoe3bavqlSih3aFkMR2S/DJjRtvNKQA+zh9CX1xc6KSpH24kcnUXWescqRN3M+
         TRRsAIKHEj49OiZJi9KEfvm6J36di5HV7cvzLKOiDJQm1mS97+7SY9oLLw5GMAK3KMm6
         vKLg4ffTd4MhUojSyru4BVqQ4UbaWGDQEHDn6ZvjlSGev4hPILzN6tQConM0RcDrKodi
         S9EDjJxVKwv5NDIa5xMIV6l6rMDxaYdymAdymObpKJzTz11HkrqBKcmtad/9O5dCBH9j
         166xSHdYJi2g7JHyaCAoV/aT6FPs9gmLha9S/FzOaPzodMmLSgybu8VBFkmygqfhFeiD
         0LjA==
X-Gm-Message-State: AOAM533clsUCDFBRDpUbiQVmjbYS9pJACs1AFANVHP8FbidgaiwWV53i
        d7iT7Lqtt6MqoYm/IHCd7O8kNtoTueqKVp3F3ug7sg==
X-Google-Smtp-Source: ABdhPJzmyKywKnrt+mhTCQKuNKDH+mnRR3odpUAZzgZQXdX7WCuZf65U7KFkVSK7USoDQJabCtlLvrEg8KE48wcD13A=
X-Received: by 2002:a2e:980d:: with SMTP id a13mr9750278ljj.277.1589789423940;
 Mon, 18 May 2020 01:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200517190139.740249-1-sam@ravnborg.org> <20200517190139.740249-2-sam@ravnborg.org>
In-Reply-To: <20200517190139.740249-2-sam@ravnborg.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 May 2020 10:10:12 +0200
Message-ID: <CACRpkdbogVA=12Xzh6jC0AaE7DrH8Z7iVuG3s_gS4MQBYF61Dw@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] video: amba-clcd: use devm_of_find_backlight
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        MSM <linux-arm-msm@vger.kernel.org>, linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Russell King <linux@armlinux.org.uk>,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, May 17, 2020 at 9:01 PM Sam Ravnborg <sam@ravnborg.org> wrote:

> Look up backlight device using devm_of_find_backlight().
> This simplifies the code and prevents us from hardcoding
> the node name in the driver.
>
> v2:
>   - Added Cc: Peter Ujfalusi
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Douglas Anderson <dianders@chromium.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
